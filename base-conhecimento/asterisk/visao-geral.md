# Asterisk e Telefonia WebRTC

Base de conhecimento do modulo de telefonia do SIRUS/SAMU.

Este documento registra como o Asterisk esta organizado no projeto, como o softphone interno se conecta, como as chamadas entram na fila TARM e qual e o modelo recomendado para chamadas vindas do site externo por pacientes.

## Objetivo

O Asterisk funciona como central telefonica do sistema. Ele recebe conexoes SIP/WebRTC dos navegadores, autentica os endpoints, aplica o dialplan e entrega as chamadas para ramais internos ou para filas de atendimento.

No projeto atual, existem dois publicos principais:

- equipe interna/TARM, usando softphone autenticado por ramal;
- paciente ou visitante do site externo, usando uma identidade temporaria restrita.

## Arquivos principais

- `infra/asterisk/config/pjsip.conf`: transports SIP, WS e WSS.
- `infra/asterisk/config/extensions.conf`: dialplan principal.
- `infra/asterisk/config/extconfig.conf`: mapeamento realtime para PostgreSQL.
- `infra/asterisk/config/http.conf`: HTTP/WebSocket do Asterisk.
- `infra/asterisk/config/rtp.conf`: faixa RTP e ICE/STUN.
- `code/telefonia/models.py`: modelos Django para tabelas realtime do Asterisk.
- `code/telefonia/admin.py`: painel de administracao de endpoints, autenticacoes, AORs e filas.
- `code/static/js/softphone/softphone.js`: registro JsSIP e controle WebRTC.
- `code/static/js/softphone/softphone-bridge.js`: ponte entre pagina principal e janela isolada do softphone.

## Realtime no PostgreSQL

O Asterisk esta configurado para buscar dados no banco, nao apenas em arquivos estaticos. O arquivo `extconfig.conf` aponta estas tabelas para o PostgreSQL:

```ini
ps_endpoints => pgsql,asterisk_db,ps_endpoints
ps_auths => pgsql,asterisk_db,ps_auths
ps_aors => pgsql,asterisk_db,ps_aors
ps_contacts => pgsql,asterisk_db,ps_contacts
queues => pgsql,asterisk_db,queues
queue_members => pgsql,asterisk_db,queue_members
```

Na pratica:

- `ps_endpoints`: define o endpoint SIP/WebRTC e seu contexto.
- `ps_auths`: guarda usuario e senha SIP.
- `ps_aors`: controla contatos registrados para um endpoint.
- `ps_contacts`: contatos ativos, usado para debug.
- `queues`: configuracao das filas.
- `queue_members`: membros que recebem chamadas de uma fila.

## Transports

O `pjsip.conf` declara transports para:

- `transport-ws`: WebSocket sem TLS, usado em desenvolvimento local.
- `transport-wss`: WebSocket seguro, necessario quando o site roda em HTTPS.
- `transport-udp`: SIP UDP tradicional.

O `http.conf` habilita o servidor HTTP do Asterisk na porta `8088` e TLS/WSS na porta `8089`. Em producao, WSS deve usar certificado valido, por exemplo Let's Encrypt.

## Dialplan atual

O arquivo `extensions.conf` organiza os contextos principais:

### Chamadas internas

```ini
[samu-internal]
exten => _2XXX,1,Dial(PJSIP/${EXTEN},30,tT)
```

Ramais internos no padrao `2XXX` podem ligar entre si.

### Fila TARM

```ini
[samu-fila-tarm]
exten => 9000,1,Queue(${FILA_TARM},t,,,600)
```

O ramal logico `9000` e o ponto unico de entrada para atendimento TARM. Ele nao representa uma pessoa; ele representa a fila.

### Entrada externa

```ini
[samu-entrada]
exten => s,1,Goto(samu-fila-tarm,9000,1)
exten => _X.,1,Goto(samu-fila-tarm,9000,1)
```

Chamadas vindas de fora sao encaminhadas para a fila TARM.

### Equipe e TARM

```ini
[samu-equipe]
include => samu-internal
include => samu-fila-tarm
include => samu-saida

[samu-tarm]
include => samu-equipe
```

Usuarios internos podem ligar entre ramais, chamar a fila e, se configurado, fazer chamadas externas.

### Site publico

```ini
[site-publico]
exten => 9000,1,Queue(${FILA_TARM},t,,,200)
exten => _X.,1,Goto(site-publico,9000,1)
```

Visitantes do site devem cair apenas na fila TARM. Mesmo que tentem discar outro numero, o dialplan redireciona para `9000`.

## Softphone interno

O softphone interno usa JsSIP no navegador. O fluxo atual e:

1. Usuario informa ramal e senha.
2. O JavaScript cria um `JsSIP.UA`.
3. O navegador registra no Asterisk via WebSocket.
4. O endpoint recebe e faz chamadas conforme seu contexto.

Exemplo conceitual:

```text
Browser -> JsSIP -> WS/WSS -> Asterisk PJSIP -> Dialplan -> Fila/Ramal
```

Para equipe TARM, o ideal e cada usuario ter um ramal fixo vinculado ao cadastro do sistema. Assim o operador nao precisa escolher ramal manualmente.

## Paciente externo

Paciente nao deve receber um ramal real da central. O modelo recomendado e entregar uma credencial WebRTC temporaria, usada apenas para iniciar chamada para o SAMU.

Do ponto de vista tecnico, o Asterisk ainda precisa de uma identidade SIP para autenticar o navegador. Mas essa identidade deve ser tratada como sessao temporaria, nao como ramal humano.

Formato recomendado:

```text
web-483921
web-a7f31c
sessao-120394
```

Evitar formatos de ramal interno como:

```text
2001
2037
2199
```

### Por que usar identidade temporaria

Uma identidade temporaria por paciente e melhor que um endpoint unico para todo o site porque:

- permite varias chamadas simultaneas;
- evita que um visitante derrube o registro de outro;
- facilita auditoria e diagnostico nos logs;
- permite expirar ou bloquear uma sessao especifica;
- reduz risco de abuso, pois a credencial nasce restrita e com prazo curto.

## Modelo de lease para paciente

O backend pode gerenciar um "emprestimo" temporario de identidade:

1. Paciente abre o site externo.
2. Frontend solicita credenciais temporarias ao backend.
3. Backend cria ou reserva uma identidade `web-*`.
4. Backend grava `ps_endpoint`, `ps_auth` e `ps_aor` com contexto `site-publico`.
5. Browser registra no Asterisk usando JsSIP.
6. Browser chama `9000`.
7. Ao terminar, ficar ocioso ou perder heartbeat, a identidade expira.

Prazos sugeridos:

- criada mas nao registrada: expirar em 2 minutos;
- registrada mas sem chamada: expirar em 10 minutos;
- chamada encerrada: liberar apos 30 a 60 segundos;
- heartbeat ausente: expirar apos 60 a 120 segundos;
- chamada ativa: nao expirar ate encerrar, salvo acao administrativa.

O IP pode ser salvo como informacao auxiliar, mas nao deve ser a chave principal. Muitas pessoas podem compartilhar o mesmo IP por NAT, Wi-Fi publico ou rede movel.

## Configuracao recomendada para identidade web temporaria

Endpoint:

```text
id: web-483921
transport: transport-wss em producao ou transport-ws em dev
context: site-publico
aors: web-483921
auth: web-483921
webrtc: yes
media_encryption: dtls
direct_media: no
ice_support: yes
rewrite_contact: yes
rtp_symmetric: yes
use_avpf: yes
rtcp_mux: yes
bundle: yes
allow: opus,ulaw
```

Auth:

```text
id: web-483921
auth_type: userpass
username: web-483921
password: senha_aleatoria_temporaria
```

AOR:

```text
id: web-483921
max_contacts: 1
remove_existing: yes
qualify_frequency: opcional
```

Para uma identidade temporaria por paciente, `max_contacts=1` e suficiente. Se fosse usado um endpoint unico para todos os visitantes, seria necessario `max_contacts` maior e `remove_existing=no`, mas esse modelo e menos isolado.

## Fila TARM

A fila usada pelo dialplan e `fila-tarm`.

Os atendentes devem estar cadastrados em `queue_members`, por exemplo:

```text
queue_name: fila-tarm
interface: PJSIP/2001
membername: TARM 2001
state_interface: PJSIP/2001
paused: 0
ringinuse: no
```

Estrategias importantes em `queues`:

- `rrmemory`: rodizio com memoria, bom para distribuir chamadas.
- `ringall`: toca todos os membros ao mesmo tempo.
- `fewestcalls`: prioriza quem atendeu menos chamadas.
- `random`: sorteia um membro.

Para operacao TARM, `rrmemory` costuma ser uma boa escolha inicial.

## Seguranca

Regras recomendadas:

- Paciente externo sempre no contexto `site-publico`.
- `site-publico` nao deve incluir `samu-internal` nem `samu-saida`.
- Credenciais temporarias devem expirar.
- Senhas temporarias devem ser aleatorias e curtas em tempo de vida, nao simples em valor.
- WSS com certificado valido deve ser obrigatorio em producao.
- Monitorar tentativas de registro falhas.
- Evitar expor ramais internos ao site publico.

## Checklist de operacao

Para verificar se o ambiente esta saudavel:

```bash
docker exec asterisk-dev asterisk -rx "pjsip show endpoints"
docker exec asterisk-dev asterisk -rx "pjsip show contacts"
docker exec asterisk-dev asterisk -rx "queue show fila-tarm"
docker exec asterisk-dev asterisk -rx "dialplan show site-publico"
docker exec asterisk-dev asterisk -rx "dialplan show samu-tarm"
```

Sinais esperados:

- endpoints internos aparecem como `Avail` ou possuem contato ativo;
- contatos WebRTC aparecem em `pjsip show contacts`;
- membros TARM aparecem em `queue show fila-tarm`;
- contexto `site-publico` redireciona tudo para `9000`;
- chamadas externas entram na fila, nao em ramal interno direto.

## Troubleshooting

### Browser nao registra

Verificar:

- URL WS/WSS usada pelo frontend;
- porta `8088` ou `8089`;
- certificado TLS em HTTPS;
- usuario e senha em `ps_auths`;
- endpoint, auth e aor com o mesmo id esperado;
- logs do Asterisk.

### Chamada sem audio

Verificar:

- portas RTP liberadas no firewall e a faixa `rtpstart`/`rtpend` no arquivo `samu/infra/asterisk/config/rtp.conf`;
- tabela `ps_endpoints`: `ice_support=yes`, no endpoint do ramal/paciente;
- tabela `ps_endpoints`: `rtp_symmetric=yes`, no endpoint do ramal/paciente;
- tabela `ps_endpoints`: `rewrite_contact=yes`, no endpoint do ramal/paciente;
- tabela `ps_endpoints`: `direct_media=no`, no endpoint do ramal/paciente;
- STUN configurado no arquivo `samu/infra/asterisk/config/rtp.conf`, campo `stunaddr`;
- NAT/firewall entre navegador e Asterisk.

### Um paciente derruba o outro

Provavel causa:

- varios navegadores usando o mesmo endpoint/AOR na tabela `ps_aors` com `max_contacts=1` e `remove_existing=yes`.

Correcao recomendada:

- usar uma identidade temporaria por paciente (`web-*`), cada uma com seu proprio AOR.

### Paciente consegue tentar discar outros numeros

Verificar:

- tabela `ps_endpoints`: `context=site-publico` no endpoint do paciente;
- contexto `site-publico`, no arquivo `samu/infra/asterisk/config/extensions.conf`, nao inclui contextos internos;
- dialplan em `extensions.conf` redireciona `_X.` para `9000`.

## Decisao arquitetural

Para o site externo, a solucao preferida e:

```text
Paciente -> credencial temporaria web-* -> contexto site-publico -> 9000 -> fila-tarm -> TARM
```

Essa abordagem preserva a simplicidade para o paciente, evita expor ramais internos e permite controle tecnico por sessao.

---

Navegacao: [Anterior: Como rodar a query de setup rapido](como-rodar-setup-rapido.md) | [Indice](README.md)
