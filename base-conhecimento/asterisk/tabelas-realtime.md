# Tabelas Realtime do Asterisk

Este capitulo explica as tabelas usadas pelo Asterisk realtime no SIRUS/SAMU.

## `ps_endpoints`

Define o comportamento do endpoint SIP/WebRTC.

Onde fica:

- tabela no banco: `ps_endpoints`;
- modelo Django: `samu/code/telefonia/models.py`, classe `PsEndpoints`;
- painel Django: administracao de telefonia, cadastro de endpoints;
- arquivo Asterisk que ativa o uso realtime: `samu/infra/asterisk/config/extconfig.conf`.

Campos principais:

- `id`: nome do endpoint. Para ramal interno, exemplo `2001`. Para paciente externo, exemplo `web-483921`.
- `transport`: como o endpoint se conecta. Exemplos: `transport-ws`, `transport-wss`, `transport-udp`.
- `aors`: qual AOR esse endpoint usa. Normalmente igual ao `id`.
- `auth`: qual autenticacao esse endpoint usa. Normalmente igual ao `id`.
- `context`: contexto do dialplan. Define o que esse endpoint pode fazer.
- `from_domain`: dominio usado nos cabecalhos SIP. Em dev pode ser `127.0.0.1`; em producao deve acompanhar o dominio/IP correto.
- `from_user`: usuario de origem nos cabecalhos SIP. Pode ficar vazio na maioria dos ramais.
- `disallow`: codecs bloqueados. Normalmente `all`, para bloquear tudo antes de liberar os desejados.
- `allow`: codecs permitidos. Para WebRTC, comum usar `opus,ulaw`.
- `direct_media`: se `yes`, tenta audio direto entre as pontas. Para WebRTC/NAT, preferir `no`.
- `force_rport`: ajuda clientes atras de NAT.
- `ice_support`: habilita ICE, importante para WebRTC.
- `rewrite_contact`: reescreve contato SIP para lidar melhor com NAT.
- `rtp_symmetric`: usa RTP simetrico, importante para NAT.
- `use_avpf`: necessario em WebRTC.
- `media_encryption`: criptografia da midia. Para WebRTC, usar `dtls`.
- `webrtc`: marca o endpoint como WebRTC. Para navegador, usar `yes`.
- `dtls_auto_generate_cert`: permite gerar certificado DTLS automaticamente.
- `dtls_fingerprint`: algoritmo de fingerprint. Preferir `SHA-256`.
- `dtls_setup`: negociacao DTLS. Comum usar `actpass`.
- `dtls_verify`: verificacao DTLS. No projeto, `fingerprint`.
- `rtcp_mux`: WebRTC costuma exigir multiplexacao RTCP. Usar `yes`.
- `bundle`: agrupa midias WebRTC. Usar `yes`.
- `media_use_received_transport`: usa o transporte recebido na negociacao. Bom para WebRTC.
- `rtp_keepalive`: envia pacotes para manter NAT aberto.
- `allow_transfer`: permite transferencia.
- `refer_blind_progress`: comportamento de transferencia cega.
- `trust_connected_line`: confia nas informacoes de linha conectada.
- `send_connected_line`: envia informacoes de linha conectada.

## `ps_auths`

Guarda autenticacao SIP.

Onde fica:

- tabela no banco: `ps_auths`;
- modelo Django: `samu/code/telefonia/models.py`, classe `PsAuths`;
- painel Django: administracao de telefonia, cadastro de autenticacoes.

Campos:

- `id`: identificador da autenticacao. Normalmente igual ao ramal.
- `auth_type`: tipo de autenticacao. Usar `userpass` na maioria dos casos.
- `username`: usuario SIP. Normalmente igual ao ramal.
- `password`: senha SIP.

Para ramal `2001`:

```text
id: 2001
auth_type: userpass
username: 2001
password: senha_segura
```

## `ps_aors`

AOR significa Address of Record. Na pratica, controla onde e quantos contatos podem registrar nesse endpoint.

Onde fica:

- tabela no banco: `ps_aors`;
- modelo Django: `samu/code/telefonia/models.py`, classe `PsAors`;
- painel Django: administracao de telefonia, cadastro de AORs.

Campos:

- `id`: identificador do AOR. Normalmente igual ao ramal.
- `max_contacts`: quantos dispositivos podem registrar ao mesmo tempo.
- `remove_existing`: remove registro antigo quando chega um novo.
- `qualify_frequency`: intervalo para o Asterisk testar se o contato esta vivo.

Para operador interno comum:

```text
max_contacts: 1
remove_existing: yes
```

Para endpoint compartilhado por varios navegadores, seria necessario `max_contacts` maior e `remove_existing=no`, mas esse modelo nao e recomendado para pacientes.

## `ps_contacts`

Tabela de contatos ativos. Ela e preenchida pelo Asterisk quando alguem registra.

Onde fica:

- tabela no banco: `ps_contacts`;
- modelo Django: `samu/code/telefonia/models.py`, classe `PsContacts`;
- painel Django: apenas para debug, sem cadastro manual.

Campos:

- `id`: identificador interno do contato.
- `uri`: endereco de contato atual.
- `user_agent`: cliente usado, por exemplo JsSIP.
- `expiration_time`: quando o registro expira.

Nao cadastrar manualmente. Usar para debug.

## `queues`

Configura filas de atendimento.

Onde fica:

- tabela no banco: `queues`;
- modelo Django: `samu/code/telefonia/models.py`, classe `Queues`;
- painel Django: administracao de telefonia, cadastro de filas;
- uso no dialplan: arquivo `samu/infra/asterisk/config/extensions.conf`, aplicacao `Queue(...)`.

Campos mais importantes:

- `name`: nome da fila. Exemplo `fila-tarm`.
- `musiconhold`: classe de musica de espera.
- `announce`: audio anunciado ao entrar.
- `context`: contexto usado por algumas acoes da fila.
- `timeout`: quanto tempo toca em um membro antes de tentar outro ciclo.
- `ringinuse`: se `no`, nao toca em membro que ja esta em chamada.
- `retry`: tempo antes de nova tentativa.
- `wrapuptime`: descanso apos uma chamada antes de receber outra.
- `autofill`: se `yes`, permite distribuir varias chamadas ao mesmo tempo para membros livres.
- `maxlen`: tamanho maximo da fila.
- `servicelevel`: tempo-alvo de atendimento para relatorios.
- `strategy`: estrategia de distribuicao.
- `joinempty`: permite entrar na fila quando nao ha atendentes disponiveis.
- `leavewhenempty`: remove chamadas se a fila ficar sem atendentes.
- `reportholdtime`: informa tempo de espera ao atendente.

Estrategias comuns:

- `ringall`: toca todos.
- `rrmemory`: rodizio com memoria.
- `fewestcalls`: toca quem atendeu menos.
- `leastrecent`: toca quem esta ha mais tempo sem atender.
- `random`: escolhe aleatoriamente.

## `queue_members`

Define quem recebe chamadas de uma fila.

Onde fica:

- tabela no banco: `queue_members`;
- modelo Django: `samu/code/telefonia/models.py`, classe `QueueMembers`;
- painel Django: administracao de telefonia, cadastro de membros de fila;
- consulta operacional: comando `queue show fila-tarm` no Asterisk.

Campos:

- `uniqueid`: identificador unico da linha.
- `queue_name`: nome da fila. Exemplo `fila-tarm`.
- `interface`: destino que sera chamado. Exemplo `PJSIP/2001`.
- `membername`: nome amigavel do membro.
- `state_interface`: interface usada para saber se esta ocupado. Geralmente igual a `interface`.
- `penalty`: prioridade relativa. Penalidade menor atende primeiro.
- `paused`: se `1`, membro esta pausado e nao recebe chamada.
- `wrapuptime`: descanso especifico desse membro.
- `ringinuse`: se `no`, nao chama esse membro se ele ja estiver em chamada.
- `reason_paused`: motivo da pausa.

---

Navegacao: [Anterior: Dialplan](dialplan.md) | [Indice](README.md) | [Proximo: Como criar um ramal](criar-ramal.md)
