# Asterisk em producao com HTTPS/WSS

Este checklist mostra somente o que ainda falta fazer antes de subir o Asterisk em producao/homologacao com WebRTC, HTTPS e WSS.

## Ja foi preparado

Nos arquivos `samu/docker-compose.prod.yml` e `samu/docker-compose.homo.yml` ja foi ajustado:

- Postgres sem porta publica, usando apenas rede interna.
- Redis sem porta publica, usando apenas rede interna.
- pgAdmin sem porta publica.
- Web exposto somente em `127.0.0.1`, para ficar atras de proxy HTTPS.
- Asterisk expondo WSS em `8089/tcp`.
- RTP exposto sem remap em `10000-10099/udp`.
- SIP UDP `5060` comentado, para abrir somente se houver tronco/operadora/telefone SIP externo.
- Banco PostgreSQL proprio para realtime do Asterisk em `asterisk-db-prod` e `asterisk-db-homo`.
- Asterisk buildando a imagem local `sirus-asterisk:22.9.0`, com entrypoint aplicando as variaveis nas configs.
- Certificado/key WSS montados em caminhos fixos dentro do container:
  - `/etc/asterisk/keys/asterisk-fullchain.pem`
  - `/etc/asterisk/keys/asterisk-privkey.pem`

Atencao: `homo` e `prod` agora usam as mesmas portas publicas do Asterisk. Nao suba os dois no mesmo host ao mesmo tempo usando as mesmas portas, a menos que use IPs publicos separados ou configs RTP/portas separadas.

## Falta fazer

### 1. Definir dominio e IP publico

Defina os valores reais:

```text
DOMINIO_SISTEMA=samu.seudominio.com
DOMINIO_ASTERISK=asterisk.seudominio.com
IP_PUBLICO_ASTERISK=203.0.113.10
```

O DNS de `DOMINIO_ASTERISK` precisa apontar para o servidor onde o Asterisk recebe WSS/RTP.

### 2. Conferir os `.env` do Asterisk

O Django usa as variaveis `AST_DB_*` para acessar o banco realtime do Asterisk. O container customizado do Asterisk tambem usa essas variaveis no `entrypoint.sh`.

Nao deixe `prod` ou `homo` cairem no default `asterisk-db-dev`.

#### `.env.dev`

Em desenvolvimento, com `asterisk-db-dev`:

```env
# Asterisk DB
AST_DB_HOST=asterisk-db-dev
AST_DB_PORT=5432
AST_DB_NAME=asterisk_db
AST_DB_USER=asterisk_user
AST_DB_PASSWORD=asterisk_pass
ASTERISK_PUBLIC_HOST=192.168.0.111
ASTERISK_TLS_CERT_FILE=./infra/https/certs/dev-cert.pem
ASTERISK_TLS_KEY_FILE=./infra/https/certs/dev-key.pem
```

#### `.env.homo`

Em homologacao:

```env
# Asterisk DB
AST_DB_HOST=asterisk-db-homo
AST_DB_PORT=5432
AST_DB_NAME=asterisk_db
AST_DB_USER=asterisk_user
AST_DB_PASSWORD=troque-esta-senha

# Asterisk externo/TLS
ASTERISK_PUBLIC_HOST=asterisk-homo.seudominio.com
ASTERISK_TLS_CERT_FILE=/etc/letsencrypt/live/asterisk-homo.seudominio.com/fullchain.pem
ASTERISK_TLS_KEY_FILE=/etc/letsencrypt/live/asterisk-homo.seudominio.com/privkey.pem
```

#### `.env.prod`

Em producao, use senha real e host real do Asterisk.

```env
# Asterisk DB
AST_DB_HOST=asterisk-db-prod
AST_DB_PORT=5432
AST_DB_NAME=asterisk_db
AST_DB_USER=asterisk_user
AST_DB_PASSWORD=senha-forte-aqui

# Asterisk externo/TLS
ASTERISK_PUBLIC_HOST=asterisk.seudominio.com
ASTERISK_TLS_CERT_FILE=/etc/letsencrypt/live/asterisk.seudominio.com/fullchain.pem
ASTERISK_TLS_KEY_FILE=/etc/letsencrypt/live/asterisk.seudominio.com/privkey.pem
```

Os composes atuais ja criam `asterisk-db-prod` e `asterisk-db-homo`. Nao use `AST_DB_HOST=db-prod` ou `db-homo` a menos que voce mesmo tenha criado banco/schema/usuario do Asterisk no Postgres principal.

### 3. Criar o `.env` do telefone externo

Foi criado em `samu/infra/telefone-externo/.env` um modelo local para o telefone externo. Ele fica ignorado pelo git porque `.env` e sensivel.

Tambem existe o arquivo versionado:

```text
samu/infra/telefone-externo/telefone-externo.env.example
```

Exemplo:

```env
TELEFONE_EXTERNO_ASTERISK_HOST=asterisk.seudominio.com
TELEFONE_EXTERNO_ASTERISK_WS_PORT=8089
TELEFONE_EXTERNO_NUMERO_SAMU=192
TELEFONE_EXTERNO_RAMAL_INICIAL=7001
TELEFONE_EXTERNO_RAMAL_FINAL=7010
TELEFONE_EXTERNO_RAMAL_SENHA=troque-esta-senha
```

Importante: navegador nao le `.env` diretamente. O telefone externo ja carrega `config.js` antes de `script.js`; no deploy, gere ou edite esse `config.js` usando os valores do `.env`.

Arquivos versionados:

```text
samu/infra/telefone-externo/config.js
samu/infra/telefone-externo/config.example.js
```

Exemplo de `config.js` real:

```js
window.TELEFONE_EXTERNO_ASTERISK_HOST = "asterisk.seudominio.com";
window.TELEFONE_EXTERNO_ASTERISK_WS_PORT = "8089";
window.TELEFONE_EXTERNO_NUMERO_SAMU = "192";
window.TELEFONE_EXTERNO_RAMAL_INICIAL = 7001;
window.TELEFONE_EXTERNO_RAMAL_FINAL = 7010;
window.TELEFONE_EXTERNO_RAMAL_SENHA = "senha-real-dos-ramais-temporarios";
```

O `index.html` ja deve carregar:

```html
<script src="config.js"></script>
<script src="location.js"></script>
<script src="script.js"></script>
```

### 4. Emitir certificado valido para o Asterisk

O navegador nao aceita WSS com certificado autoassinado em producao.

Emita certificado para:

```text
asterisk.seudominio.com
```

Exemplo de caminhos esperados pelo Let's Encrypt:

```text
/etc/letsencrypt/live/asterisk.seudominio.com/fullchain.pem
/etc/letsencrypt/live/asterisk.seudominio.com/privkey.pem
/etc/letsencrypt/archive/asterisk.seudominio.com/
```

No `.env.prod` e `.env.homo`, configure como mostrado acima:

```env
ASTERISK_TLS_CERT_FILE=/etc/letsencrypt/live/asterisk.seudominio.com/fullchain.pem
ASTERISK_TLS_KEY_FILE=/etc/letsencrypt/live/asterisk.seudominio.com/privkey.pem
```

### 5. Conferir `samu/infra/asterisk/config/http.conf`

O arquivo ja fica apontando para os caminhos internos fixos:

```ini
tlscertfile=/etc/asterisk/keys/asterisk-fullchain.pem
tlsprivatekey=/etc/asterisk/keys/asterisk-privkey.pem
```

Mantenha:

```ini
enabled=yes
tlsenable=yes
tlsbindaddr=0.0.0.0:8089
```

O compose monta `ASTERISK_TLS_CERT_FILE` e `ASTERISK_TLS_KEY_FILE` nesses caminhos. Nao precisa editar o `http.conf` por ambiente.

### 6. Conferir `samu/infra/asterisk/config/pjsip.conf`

O arquivo versionado nao deve ter IP de rede local. O `entrypoint.sh` troca `external_signaling_address` e `external_media_address` pelo valor de `ASTERISK_PUBLIC_HOST` ao iniciar o container.

Exemplo recomendado:

```ini
[transport-wss]
type=transport
protocol=wss
bind=0.0.0.0
external_signaling_address=asterisk.seudominio.com
external_media_address=203.0.113.10
local_net=172.18.0.0/16
local_net=192.168.0.0/24
```

Se nao for usar WS sem TLS, remova ou comente o bloco:

```ini
[transport-ws]
```

Nao deixe em producao:

```ini
external_signaling_address=192.168.x.x
external_media_address=192.168.x.x
```

### 7. Conferir endpoints WebRTC no banco/realtime

Os ramais WebRTC precisam usar WSS e parametros compativeis com navegador.

Verifique no banco/tabelas realtime se os endpoints tem, no minimo:

```text
transport=transport-wss
webrtc=yes
use_avpf=yes
media_encryption=dtls
dtls_auto_generate_cert=yes
ice_support=yes
rtcp_mux=yes
direct_media=no
rewrite_contact=yes
rtp_symmetric=yes
force_rport=yes
```

### 8. Conferir `samu/infra/asterisk/config/rtp.conf`

Pode manter:

```ini
[general]
rtpstart=10000
rtpend=10099
icesupport=true
stunaddr=stun.l.google.com:19302
```

O importante e o firewall/Docker abrirem exatamente:

```text
10000-10099/udp
```

Nao remapear RTP para `10100`, `10200` etc.

### 9. Ajustar o softphone interno do SIRUS

Arquivo:

```text
samu/code/static/js/softphone/softphone.js
```

Hoje ele nao pode ficar apontando para `127.0.0.1` em producao.

Use o dominio real:

```js
var ASTERISK_IP = "asterisk.seudominio.com";

function getSocketUrl() {
  return "wss://" + ASTERISK_IP + ":8089/ws";
}
```

Se o WSS passar por proxy reverso na porta `443`, use:

```js
function getSocketUrl() {
  return "wss://" + ASTERISK_IP + "/ws";
}
```

### 10. Ajustar o telefone externo

Arquivo:

```text
samu/infra/telefone-externo/script.js
```

Para WSS direto na porta `8089`, configure antes de carregar o script ou altere o padrao:

```js
window.TELEFONE_EXTERNO_ASTERISK_HOST = "asterisk.seudominio.com";
window.TELEFONE_EXTERNO_ASTERISK_WS_PORT = "8089";
```

Se usar proxy reverso na porta `443`, a URL final deve ficar:

```text
wss://asterisk.seudominio.com/ws
```

### 11. Configurar proxy HTTPS do sistema

O Django em compose ficou preso em localhost:

```text
prod: 127.0.0.1:8001
homo: 127.0.0.1:8002
```

Falta configurar Nginx/Traefik/Caddy no host para publicar:

```text
https://samu.seudominio.com -> 127.0.0.1:8001
```

Para homologacao, se houver dominio separado:

```text
https://homo.samu.seudominio.com -> 127.0.0.1:8002
```

### 12. Abrir somente as portas necessarias

Para WebRTC direto no Asterisk:

```text
443/tcp
8089/tcp
10000-10099/udp
```

Se o WSS do Asterisk ficar atras do proxy na `443`, nao abra `8089/tcp` publicamente.

Nao abrir publicamente:

```text
8088/tcp
5432/tcp
5433/tcp
5434/tcp
6379/tcp
6380/tcp
6381/tcp
5051/tcp
5052/tcp
5060/tcp
```

Abra `5060/udp` somente se houver tronco SIP/operadora/telefone SIP externo. Se abrir, restrinja para IP da operadora sempre que possivel.

### 13. Subir e validar

Subir o Asterisk:

```bash
docker compose -f docker-compose.prod.yml up -d --force-recreate asterisk-prod
```

Com env explicito:

```bash
docker compose --env-file .env.prod -f docker-compose.prod.yml up -d --build
```

Conferir HTTP/TLS:

```bash
docker exec -it asterisk-prod asterisk -rx "http show status"
```

Conferir transports:

```bash
docker exec -it asterisk-prod asterisk -rx "pjsip show transports"
```

Conferir endpoints e contatos:

```bash
docker exec -it asterisk-prod asterisk -rx "pjsip show endpoints"
docker exec -it asterisk-prod asterisk -rx "pjsip show contacts"
```

Testar WSS:

```bash
curl -k -I https://asterisk.seudominio.com:8089/ws
```

Durante teste de chamada:

```bash
docker exec -it asterisk-prod asterisk -rvvv
```

No CLI:

```text
pjsip set logger on
rtp set debug on
```

Depois desligue:

```text
pjsip set logger off
rtp set debug off
```

### 14. Teste final obrigatorio

Antes de liberar:

- Registrar ramal pelo softphone interno em HTTPS.
- Fazer chamada de entrada.
- Atender e confirmar audio nos dois sentidos.
- Transferir chamada.
- Testar telefone externo em HTTPS.
- Confirmar que o navegador nao mostra erro de certificado nem mixed content.
- Confirmar que nenhuma porta de banco/Redis/pgAdmin esta aberta publicamente.

## Nao subir se ainda tiver

Nao colocar em producao se qualquer item abaixo ainda existir:

```text
external_signaling_address=192.168.x.x
external_media_address=192.168.x.x
tlscertfile=/etc/asterisk/keys/asterisk-local-cert.pem
tlsprivatekey=/etc/asterisk/keys/asterisk-local-key.pem
wss/ws apontando para 127.0.0.1
RTP remapeado para porta externa diferente de 10000-10099
Postgres, Redis ou pgAdmin expostos publicamente
```
