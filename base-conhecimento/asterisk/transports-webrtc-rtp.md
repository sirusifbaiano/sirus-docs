# Transports, WebRTC, RTP e NAT

## O que e transport

Transport e a forma como o Asterisk recebe a sinalizacao SIP.

No projeto existem transports como:

- `transport-ws`: SIP sobre WebSocket sem TLS;
- `transport-wss`: SIP sobre WebSocket seguro;
- `transport-udp`: SIP tradicional por UDP.

Onde fica:

- definicao dos transports: arquivo `samu/infra/asterisk/config/pjsip.conf`;
- escolha do transport usado por um ramal: campo `transport` da tabela `ps_endpoints`, administrada pelo Django em `code/telefonia/admin.py`.

## Quando usar WS e WSS

Use `transport-ws` em desenvolvimento local quando a aplicacao roda em HTTP.

Use `transport-wss` em producao quando a aplicacao roda em HTTPS. Navegadores modernos bloqueiam recursos inseguros quando a pagina esta em HTTPS, entao WebRTC em producao deve usar WSS com certificado valido.

## HTTP do Asterisk

O arquivo `samu/infra/asterisk/config/http.conf` habilita o servidor HTTP do Asterisk:

```ini
enabled=yes
bindaddr=0.0.0.0
bindport=8088
tlsenable=yes
tlsbindaddr=0.0.0.0:8089
```

Na pratica:

- `8088`: WS sem TLS;
- `8089`: WSS com TLS.

## RTP

SIP decide a chamada. RTP carrega o audio.

No projeto, o arquivo `samu/infra/asterisk/config/rtp.conf` define:

```ini
rtpstart=10000
rtpend=10099
icesupport=true
stunaddr=stun.l.google.com:19302
```

Isso significa:

- o audio usa portas de `10000` a `10099`;
- ICE ajuda o WebRTC a atravessar NAT;
- STUN ajuda o navegador a descobrir seu endereco publico.

## NAT

NAT acontece quando o navegador ou o Asterisk esta atras de roteador/firewall. Problemas de NAT costumam causar chamada muda, audio em um sentido so, ou registro instavel.

Campos importantes no endpoint:

No Django Admin, esses campos aparecem no cadastro do endpoint, principalmente no bloco "Midia e NAT". No codigo, o modelo fica em `samu/code/telefonia/models.py`, classe `PsEndpoints`.

- tabela `ps_endpoints`: `direct_media=no` - mantem o audio passando pelo Asterisk.
- tabela `ps_endpoints`: `force_rport=yes` - ajuda a responder para a porta correta.
- tabela `ps_endpoints`: `rewrite_contact=yes` - ajusta o contato informado pelo cliente.
- tabela `ps_endpoints`: `rtp_symmetric=yes` - melhora audio em redes com NAT.
- tabela `ps_endpoints`: `ice_support=yes` - habilita suporte ICE para WebRTC.

## Checklist rapido de audio

Se a chamada registra mas nao tem audio:

- conferir portas RTP liberadas no firewall e a faixa `rtpstart`/`rtpend` em `samu/infra/asterisk/config/rtp.conf`;
- conferir tabela `ps_endpoints`: `direct_media=no`, no endpoint do ramal/paciente;
- conferir tabela `ps_endpoints`: `rtp_symmetric=yes`, no endpoint do ramal/paciente;
- conferir tabela `ps_endpoints`: `rewrite_contact=yes`, no endpoint do ramal/paciente;
- conferir tabela `ps_endpoints`: `ice_support=yes`, no endpoint do ramal/paciente;
- conferir se o navegador autorizou o microfone;
- conferir HTTPS/WSS em producao no arquivo `samu/infra/asterisk/config/http.conf` e no campo `transport` da tabela `ps_endpoints`;
- conferir firewall entre navegador e Asterisk.

---

Navegacao: [Anterior: Arquitetura no SIRUS/SAMU](arquitetura-sirus.md) | [Indice](README.md) | [Proximo: Dialplan](dialplan.md)
