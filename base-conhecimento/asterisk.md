# Asterisk no SIRUS/SAMU

Esta pasta resume, em um unico arquivo, como a telefonia WebRTC do SIRUS/SAMU se organiza. A ideia aqui e dar contexto rapido e superficial.

## Visao geral

O Asterisk funciona como a central telefonica do sistema. O navegador usa JsSIP para registrar um ramal via WebRTC, o Asterisk autentica esse ramal, consulta configuracoes no PostgreSQL e decide para onde a chamada deve ir pelo dialplan.

```text
Navegador/JsSIP -> Asterisk/PJSIP -> Dialplan -> Fila TARM -> Operador
                         |
                         v
                  PostgreSQL realtime
```

## Componentes principais

- `JsSIP`: biblioteca usada pelo navegador para falar SIP/WebRTC.
- `Asterisk`: central que registra ramais, controla chamadas e encaminha audio.
- `PJSIP`: modulo do Asterisk usado para endpoints SIP.
- `Dialplan`: regras que decidem o destino de cada chamada.
- `PostgreSQL realtime`: banco onde ficam ramais, autenticacoes, AORs, filas e membros de fila.
- `fila-tarm`: fila principal para atendimento TARM.

## Fluxo do operador

O operador interno usa o softphone do SIRUS. Ao abrir o softphone, o navegador registra um ramal fixo, como `2001`, no Asterisk. Depois do registro, o Asterisk sabe onde entregar chamadas para esse operador.

Fluxo simplificado:

1. Operador abre o softphone.
2. JsSIP registra o ramal no Asterisk.
3. Asterisk valida usuario e senha nas tabelas realtime.
4. O ramal fica disponivel para receber chamadas.
5. A fila TARM pode tocar nesse operador.

## Fluxo do paciente externo

O paciente externo nao deve usar ramal interno. No estado atual, o telefone externo usa um pool de ramais de teste, de `7001` a `7010`, com senha padrao `12345678`.

Fluxo simplificado:

1. Paciente abre o telefone externo.
2. O navegador usa um ramal do pool `7001` a `7010`.
3. A chamada disca `192`.
4. O contexto `site-publico` envia a chamada para a fila `fila-tarm`.
5. Um operador TARM atende.

Modelo recomendado para evolucao futura: o backend gerar uma identidade temporaria por sessao, em vez de reutilizar um pool fixo.

## Dialplan

O dialplan e o roteiro de decisao da central. No projeto, ele separa chamadas internas, fila TARM, entrada externa e site publico.

Regras importantes:

- ramais internos ficam em contextos internos;
- paciente externo fica no contexto `site-publico`;
- chamadas do site publico devem cair na `fila-tarm`;
- paciente externo nao deve conseguir chamar destinos internos diretamente.

## Tabelas realtime

As tabelas mais importantes sao:

| Tabela | Papel |
| --- | --- |
| `ps_endpoints` | Define o endpoint/ramal e suas permissoes. |
| `ps_auths` | Guarda usuario e senha SIP. |
| `ps_aors` | Controla quantos contatos o ramal pode registrar. |
| `ps_contacts` | Mostra contatos registrados no momento. |
| `queues` | Define filas de atendimento. |
| `queue_members` | Define quem atende cada fila. |

## Seguranca basica

A regra principal e separar identidades internas e externas.

| Tipo | Exemplo | Contexto esperado |
| --- | --- | --- |
| Operador TARM | `2001` | `samu-tarm` ou equivalente interno |
| Equipe interna | `2XXX` | contexto interno |
| Paciente externo atual | `7001` a `7010` | `site-publico` |
| Paciente externo futuro | identidade temporaria | `site-publico` |

Paciente externo nunca deve estar em contexto de operador ou equipe interna.

## Arquivos relacionados

Os pontos mais relevantes no repositorio sao:

- `infra/asterisk/config/pjsip.conf`: transports e configuracoes PJSIP.
- `infra/asterisk/config/extensions.conf`: dialplan.
- `infra/asterisk/config/extconfig.conf`: integracao realtime com o banco.
- `infra/asterisk/config/http.conf`: HTTP/WebSocket do Asterisk.
- `infra/asterisk/config/rtp.conf`: audio RTP/WebRTC.
- `code/telefonia/models.py`: modelos Django ligados a telefonia.
- `code/static/js/softphone/softphone.js`: softphone interno.
- `infra/telefone-externo/script.js`: telefone externo de teste.

## Diagnostico rapido

Comandos uteis no console do Asterisk:

```sh
pjsip show endpoints
pjsip show contacts
queue show fila-tarm
dialplan show
```

Problemas comuns:

- navegador nao registra: conferir credenciais, endpoint, transport e WebSocket;
- chamada sem audio: conferir RTP, NAT, ICE/STUN e permissao de microfone;
- fila nao toca: conferir membros da fila e se os ramais estao registrados;
- paciente acessa destino indevido: revisar contexto `site-publico` no dialplan.
