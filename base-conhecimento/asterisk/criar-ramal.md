# Como Criar um Ramal

Este passo a passo cria um ramal WebRTC interno para operador.

Exemplo usado:

```text
Ramal: 2001
Senha: uma senha segura
Contexto: samu-tarm
```

## 1. Criar AOR

Tabela: `ps_aors`

Onde preencher: Django Admin de telefonia, cadastro de AORs. No codigo, esta em `samu/code/telefonia/models.py`, classe `PsAors`.

```text
id: 2001
max_contacts: 1
remove_existing: yes
qualify_frequency: 60
```

Explicacao:

- `id`: nome do AOR, igual ao ramal;
- `max_contacts=1`: apenas um navegador/dispositivo usando esse ramal;
- `remove_existing=yes`: se registrar de novo, remove registro antigo;
- `qualify_frequency=60`: testa periodicamente se o contato esta vivo.

## 2. Criar autenticacao

Tabela: `ps_auths`

Onde preencher: Django Admin de telefonia, cadastro de autenticacoes. No codigo, esta em `samu/code/telefonia/models.py`, classe `PsAuths`.

```text
id: 2001
auth_type: userpass
username: 2001
password: senha_segura
```

Explicacao:

- `username`: usuario que o softphone informa;
- `password`: senha do ramal;
- `auth_type=userpass`: autenticacao simples por usuario e senha.

## 3. Criar endpoint

Tabela: `ps_endpoints`

Onde preencher: Django Admin de telefonia, cadastro de endpoints. No codigo, esta em `samu/code/telefonia/models.py`, classe `PsEndpoints`.

Os campos de NAT e WebRTC desta etapa, como `direct_media`, `force_rport`, `ice_support`, `rewrite_contact`, `rtp_symmetric`, `rtcp_mux` e `bundle`, tambem ficam nessa mesma tabela `ps_endpoints`.

```text
id: 2001
transport: transport-ws
aors: 2001
auth: 2001
context: samu-tarm
from_domain: 127.0.0.1
disallow: all
allow: opus,ulaw
direct_media: no
force_rport: yes
ice_support: yes
rewrite_contact: yes
rtp_symmetric: yes
use_avpf: yes
media_encryption: dtls
webrtc: yes
dtls_auto_generate_cert: yes
dtls_fingerprint: SHA-256
dtls_setup: actpass
dtls_verify: fingerprint
rtcp_mux: yes
bundle: yes
media_use_received_transport: yes
rtp_keepalive: 20
allow_transfer: yes
```

Em producao com HTTPS, trocar `transport-ws` por `transport-wss`. Os transports em si sao definidos no arquivo `samu/infra/asterisk/config/pjsip.conf`.

## 4. Adicionar na fila TARM

Se esse ramal deve receber chamadas da fila:

Tabela: `queue_members`

Onde preencher: Django Admin de telefonia, cadastro de membros de fila. No codigo, esta em `samu/code/telefonia/models.py`, classe `QueueMembers`.

```text
queue_name: fila-tarm
interface: PJSIP/2001
membername: TARM 2001
state_interface: PJSIP/2001
penalty: 0
paused: 0
ringinuse: no
```

## 5. Testar registro

No container do Asterisk:

```bash
docker exec asterisk-dev asterisk -rx "pjsip show endpoint 2001"
docker exec asterisk-dev asterisk -rx "pjsip show contacts"
```

## 6. Testar chamada interna

Com outro ramal registrado, discar:

```text
2001
```

Se o endpoint estiver no contexto `samu-tarm` ou `samu-equipe`, o dialplan deve permitir chamada para ramais `2XXX`.

## 7. Testar fila

Discar:

```text
9000
```

O Asterisk deve colocar a chamada em `fila-tarm` e tentar chamar os membros livres.

---

Navegacao: [Anterior: Tabelas realtime do Asterisk](tabelas-realtime.md) | [Indice](README.md) | [Proximo: Filas e membros de fila](filas.md)
