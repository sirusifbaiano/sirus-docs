# Paciente Externo e Identidade Temporaria

Paciente externo nao deve receber ramal interno real.

O correto e criar uma identidade tecnica temporaria para a sessao do site.

## Por que nao usar ramal interno

Ramais como `2001`, `2002` e `2030` representam pessoas ou postos internos. Se um paciente externo recebe um desses numeros, a central fica mais dificil de auditar e pode expor permissoes indevidas.

Use nomes como:

```text
web-483921
web-a7f31c
sessao-120394
```

## Fluxo recomendado

1. Paciente abre o site externo.
2. Site pede uma credencial temporaria ao backend.
3. Backend cria ou reserva `web-*`.
4. Backend grava `ps_aors`, `ps_auths` e `ps_endpoints`.
5. Browser registra no Asterisk com JsSIP.
6. Browser chama `9000`.
7. Dialplan `site-publico` manda para `fila-tarm`.
8. Ao terminar ou ficar ocioso, backend expira a identidade.

## Configuracao do endpoint temporario

Tabela `ps_endpoints`:

Onde criar: backend do SIRUS ou Django Admin de telefonia, cadastro de endpoints. No codigo, o modelo esta em `samu/code/telefonia/models.py`, classe `PsEndpoints`.

Todos os campos abaixo pertencem a essa tabela. Os campos de NAT/WebRTC, como `direct_media`, `ice_support`, `rewrite_contact`, `rtp_symmetric`, `rtcp_mux` e `bundle`, tambem ficam aqui.

```text
id: web-483921
transport: transport-wss
aors: web-483921
auth: web-483921
context: site-publico
disallow: all
allow: opus,ulaw
direct_media: no
ice_support: yes
rewrite_contact: yes
rtp_symmetric: yes
use_avpf: yes
media_encryption: dtls
webrtc: yes
rtcp_mux: yes
bundle: yes
```

Tabela `ps_auths`:

Onde criar: backend do SIRUS ou Django Admin de telefonia, cadastro de autenticacoes. No codigo, classe `PsAuths`.

```text
id: web-483921
auth_type: userpass
username: web-483921
password: senha_aleatoria_temporaria
```

Tabela `ps_aors`:

Onde criar: backend do SIRUS ou Django Admin de telefonia, cadastro de AORs. No codigo, classe `PsAors`.

```text
id: web-483921
max_contacts: 1
remove_existing: yes
```

## Tempo de vida

Sugestao:

- criada e nao registrada: expirar em 2 minutos;
- registrada sem chamada: expirar em 10 minutos;
- chamada encerrada: liberar apos 30 a 60 segundos;
- sem heartbeat do navegador: expirar em 60 a 120 segundos;
- chamada ativa: nao expirar ate terminar, salvo acao administrativa.

## IP nao deve ser chave principal

O IP pode ser salvo para auditoria, mas nao deve ser usado sozinho para identificar paciente. Varias pessoas podem compartilhar o mesmo IP por NAT, Wi-Fi publico ou operadora movel.

Use:

```text
sessao do navegador + token temporario + IP auxiliar
```

## Seguranca

O contexto do paciente deve ser sempre:

```text
site-publico
```

Esse contexto nao deve incluir:

- `samu-internal`;
- `samu-equipe`;
- `samu-tarm`;
- `samu-saida`.

Onde conferir: o valor `site-publico` fica no campo `context` da tabela `ps_endpoints`. As regras desse contexto ficam no arquivo `samu/infra/asterisk/config/extensions.conf`.

---

Navegacao: [Anterior: Filas e membros de fila](filas.md) | [Indice](README.md) | [Proximo: Operacao e diagnostico](operacao-diagnostico.md)
