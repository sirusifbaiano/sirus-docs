# Arquitetura no SIRUS/SAMU

Este capitulo explica como a telefonia do SIRUS/SAMU funciona como um caminho de chamada. A ideia aqui nao e decorar nomes de arquivos, e sim entender quem fala com quem e por que cada parte existe.

Pense no Asterisk como uma recepcao telefonica automatizada:

- o navegador e o "telefone";
- o JsSIP e a biblioteca que faz esse telefone falar SIP/WebRTC;
- o Asterisk e a central;
- o dialplan e o roteiro de decisao da central;
- a fila TARM e a sala de espera da chamada;
- os operadores TARM sao os atendentes disponiveis.

## Visao geral em uma imagem

```text
                             BANCO POSTGRESQL
                 +--------------------------------------+
                 | ps_endpoints  ps_auths  ps_aors      |
                 | queues        queue_members          |
                 +-------------------+------------------+
                                     |
                                     | Asterisk consulta
                                     v
+------------------+       +-----------------------------+       +------------------+
| NAVEGADOR        |       | ASTERISK                    |       | ATENDIMENTO      |
|                  |       |                             |       |                  |
| SIRUS/site       | ----> | WS/WSS -> PJSIP -> Dialplan | ----> | fila-tarm        |
| JsSIP            |       |                    |        |       | PJSIP/2001       |
| microfone/audio  | <===> | audio RTP/WebRTC   |        |       | PJSIP/2002       |
+------------------+       +-----------------------------+       +------------------+
```

Leia da esquerda para a direita: o navegador registra e chama, o Asterisk autentica e decide o caminho, o banco fornece configuracoes, e a fila entrega para um operador.

## O que acontece quando um operador abre o softphone

O operador interno entra no SIRUS e usa o softphone. Esse softphone nao e um telefone separado: ele e uma janela do navegador rodando JavaScript.

Fluxo:

1. O operador informa ou recebe automaticamente ramal e senha.
2. O `softphone.js` cria um cliente JsSIP.
3. O JsSIP abre uma conexao WebSocket com o Asterisk.
4. O Asterisk confere usuario e senha em `ps_auths`.
5. O Asterisk confere o endpoint em `ps_endpoints`.
6. Se estiver correto, o contato ativo aparece em `ps_contacts`.
7. A partir dai, o Asterisk sabe onde esta o ramal daquele operador.

```text
Operador
   |
   | 1. abre o softphone no SIRUS
   v
Navegador / softphone
   |
   | 2. JsSIP tenta registrar o ramal 2001
   v
Asterisk / PJSIP
   |
   | 3. consulta usuario, senha e permissoes
   v
PostgreSQL realtime
   |
   | 4. devolve ps_auths + ps_endpoints + ps_aors
   v
Asterisk / PJSIP
   |
   | 5. aceita o registro e grava contato em ps_contacts
   v
Navegador / softphone
   |
   | 6. mostra "Registrado"
   v
Operador
```

O ponto mais importante: o ramal nao "mora" no navegador. O navegador apenas se registra. O Asterisk guarda o contato atual e usa esse contato para entregar chamadas.

## O que acontece quando um paciente liga pelo site externo

O paciente externo nao deve ganhar um ramal interno como `2001`.

No estado atual do projeto, o `infra/telefone-externo/script.js` usa uma configuracao fixa de teste:

```text
RAMAL_INICIAL = 7001
RAMAL_FINAL = 7010
RAMAL_SENHA = 12345678
NUMERO_SAMU = 192
```

Ou seja: o navegador sorteia um ramal entre `7001` e `7010`, registra com a senha `12345678` e chama `192`. Esses ramais precisam existir previamente no Asterisk realtime. A query [setup-rapido-ramais-samu.sql](setup-rapido-ramais-samu.sql) prepara esse pool.

A criacao automatica de identidade temporaria pelo backend, como `web-483921`, ainda e uma funcionalidade futura.

Fluxo:

1. Paciente abre o site externo.
2. O JavaScript sorteia um ramal entre `7001` e `7010`.
3. O navegador registra esse ramal no Asterisk com senha `12345678`.
4. O navegador chama `192`.
5. O contexto `site-publico` redireciona a chamada para `fila-tarm`.
6. A regra `_X.` do dialplan garante que qualquer numero discado pelo telefone externo caia na fila.
7. A fila chama um operador TARM disponivel.

```text
Paciente
   |
   | 1. abre a pagina de chamada
   v
Site externo
   |
   | 2. sorteia um ramal entre 7001 e 7010
   v
Telefone externo JS
   |
   | 3. registra o ramal sorteado com senha 12345678
   v
Asterisk
   |
   | 4. navegador chama 192
   | 5. contexto site-publico manda para fila-tarm
   v
Fila TARM
   |
   | 8. toca em um operador disponivel
   v
Operador TARM
   |
   | 9. atende e conversa com o paciente
   v
Paciente
```

Esse pool fixo existe para teste e simulacao do site externo. Para producao, a evolucao recomendada e o backend gerar uma identidade temporaria por sessao, expirar credenciais e evitar reutilizacao fixa.

## Duas entradas, uma fila

O sistema tem duas formas principais de chegar na fila TARM:

```text
CAMINHO A: paciente pelo site

Paciente -> ramal 7001-7010 -> contexto site-publico -> 192 -> 9000
                                                        |
                                                        v
CAMINHO B: chamada por tronco externo                   |
                                                        |
Operadora/tronco -> contexto samu-entrada ------------> 9000
                                                        |
                                                        v
                                                 fila-tarm
                                                        |
                        +-------------------------------+------------------+
                        |                               |                  |
                        v                               v                  v
                    PJSIP/2001                      PJSIP/2002         PJSIP/2003
```

O objetivo e que tudo que precisa de atendimento TARM entre pelo mesmo ponto logico: `9000`.

## O papel do Django

O Django nao substitui o Asterisk. Ele ajuda a administrar dados.

No SIRUS, o Django pode:

- cadastrar ramais internos nas tabelas realtime;
- cadastrar filas;
- cadastrar membros da fila;
- cadastrar o pool fixo de ramais externos usado hoje pelo `infra/telefone-externo`;
- vincular usuario do sistema a um ramal;
- exibir telas administrativas;
- futuramente criar identidade temporaria para paciente externo;
- futuramente pausar/despausar operador ou expirar identidades temporarias.

Quem efetivamente registra o SIP, toca chamadas e envia audio continua sendo o Asterisk.

## O papel do banco realtime

O banco realtime e uma ponte entre Django e Asterisk.

Sem realtime, cada ramal precisaria ser configurado diretamente em arquivos `.conf`. Com realtime, o Django escreve no PostgreSQL e o Asterisk consulta essas tabelas.

```text
Django Admin  ----+
                  |
Backend SIRUS ----+----> PostgreSQL ----> Asterisk realtime ----> Chamadas
                       escreve dados       le configuracoes       SIP/WebRTC
```

As principais tabelas sao:

- `ps_endpoints`: o que a identidade pode fazer;
- `ps_auths`: usuario e senha;
- `ps_aors`: quantidade e controle de registros;
- `ps_contacts`: contatos ativos;
- `queues`: definicao das filas;
- `queue_members`: quem atende cada fila.

## O papel do dialplan

O dialplan e a parte que decide o destino da chamada.

Exemplos:

- se um operador disca `2002`, o dialplan chama `PJSIP/2002`;
- se alguem disca `9000`, o dialplan manda para `fila-tarm`;
- se um paciente tenta discar qualquer numero no `site-publico`, o dialplan redireciona para `9000`;
- se uma chamada chega por tronco externo, o dialplan manda para a fila TARM.

Ele e uma camada de seguranca. Mesmo se um paciente tentar manipular o numero chamado no navegador, o contexto `site-publico` deve impedir acesso a destinos indevidos.

## O papel dos arquivos de configuracao

Arquivos importantes no repositorio `samu`:

| Arquivo | Papel |
| --- | --- |
| `infra/asterisk/config/pjsip.conf` | Define os transports, como `transport-ws`, `transport-wss` e `transport-udp`. |
| `infra/asterisk/config/extensions.conf` | Define o dialplan, ou seja, as regras de chamada. |
| `infra/asterisk/config/extconfig.conf` | Diz ao Asterisk quais tabelas buscar no PostgreSQL. |
| `infra/asterisk/config/http.conf` | Habilita WebSocket/WSS do Asterisk. |
| `infra/asterisk/config/rtp.conf` | Define portas de audio RTP e suporte a ICE/STUN. |
| `code/telefonia/models.py` | Espelha tabelas realtime no Django. |
| `code/telefonia/admin.py` | Permite administrar telefonia pelo painel Django. |
| `code/static/js/softphone/softphone.js` | Faz registro SIP/WebRTC e controla chamadas. |
| `code/static/js/softphone/softphone-bridge.js` | Integra a pagina principal com a janela persistente do softphone. |

## Exemplo completo: chamada do telefone externo ate o TARM

Imagine uma pessoa clicando em "ligar para o SAMU" no site externo.

1. O `infra/telefone-externo/script.js` sorteia um ramal entre `7001` e `7010`.
2. O navegador registra esse ramal usando a senha `12345678`.
3. O telefone externo chama `192`.
4. O endpoint sorteado esta no contexto `site-publico`.
5. O contexto `site-publico` redireciona `_X.` para `9000`.
6. `9000` executa `Queue(fila-tarm,...)`.
7. A fila consulta `queue_members`.
8. O Asterisk escolhe um membro, por exemplo `PJSIP/2001`.
9. O navegador do operador `2001` toca.
10. Quando o operador atende, o audio passa entre paciente e TARM via Asterisk/WebRTC.

## Exemplo completo: chamada entre operadores

1. Operador do ramal `2001` disca `2002`.
2. Como `2001` esta no contexto `samu-tarm`, ele herda regras de `samu-equipe`.
3. `samu-equipe` inclui `samu-internal`.
4. `samu-internal` aceita padrao `_2XXX`.
5. O Asterisk executa `Dial(PJSIP/2002,30,tT)`.
6. Se `2002` estiver registrado, o softphone do operador toca.

## Separacao de seguranca

A arquitetura depende muito dos contextos:

| Tipo de usuario | Identidade | Contexto | Pode fazer |
| --- | --- | --- | --- |
| Operador TARM | `2001` | `samu-tarm` | Receber fila, chamar ramais internos e usar permissoes da equipe. |
| Equipe interna | `2XXX` | `samu-equipe` | Usar recursos internos autorizados. |
| Telefone externo atual | `7001` a `7010` | `site-publico` | Chamar `192`, que cai na fila TARM. |
| Identidade futura do paciente | `web-*` ou equivalente | `site-publico` | Entrar na fila TARM com credencial temporaria gerenciada pelo backend. |
| Tronco externo | nome do tronco | `samu-entrada` | Encaminhar chamadas recebidas para TARM. |

Regra principal: paciente externo nunca deve estar em contexto interno.

## Decisao arquitetural para paciente externo

O paciente externo nao deve usar ramais internos `2XXX`.

Modelo recomendado:

```text
Estado atual:
Paciente -> ramal sorteado 7001-7010 -> site-publico -> 192 -> fila-tarm -> operador TARM

Evolucao futura:
Paciente -> identidade temporaria -> site-publico -> fila-tarm -> operador TARM
```

Essa separacao evita que uma identidade publica tenha permissao indevida dentro da central.

---

Navegacao: [Anterior: Conceitos basicos](conceitos-basicos.md) | [Indice](README.md) | [Proximo: Transports, WebSocket, RTP e NAT](transports-webrtc-rtp.md)
