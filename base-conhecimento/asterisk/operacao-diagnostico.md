# Operacao e Diagnostico

Comandos uteis para verificar o Asterisk em desenvolvimento.

## Ver endpoints

```bash
docker exec asterisk-dev asterisk -rx "pjsip show endpoints"
```

Mostra endpoints conhecidos e estado geral.

## Ver um endpoint especifico

```bash
docker exec asterisk-dev asterisk -rx "pjsip show endpoint 2001"
```

Use para conferir contexto, auth, AOR, codecs e parametros WebRTC.

## Ver contatos registrados

```bash
docker exec asterisk-dev asterisk -rx "pjsip show contacts"
```

Se o ramal registrou, deve aparecer aqui.

## Ver fila

```bash
docker exec asterisk-dev asterisk -rx "queue show fila-tarm"
```

Mostra membros da fila, chamadas aguardando e estados.

## Ver dialplan

```bash
docker exec asterisk-dev asterisk -rx "dialplan show site-publico"
docker exec asterisk-dev asterisk -rx "dialplan show samu-tarm"
```

Use para confirmar se o contexto tem as regras esperadas.

## Recarregar PJSIP

```bash
docker exec asterisk-dev asterisk -rx "pjsip reload"
```

## Recarregar dialplan

```bash
docker exec asterisk-dev asterisk -rx "dialplan reload"
```

## Problema: navegador nao registra

Verificar:

- usuario e senha na tabela `ps_auths`, pelo Django Admin ou banco;
- tabela `ps_endpoints`: endpoint existe;
- AOR existe na tabela `ps_aors`;
- campos `auth` e `aors` do endpoint em `ps_endpoints` apontam para IDs corretos;
- URL WS/WSS no frontend, em `samu/code/static/js/softphone/softphone.js`;
- certificado TLS se estiver em HTTPS, no arquivo `samu/infra/asterisk/config/http.conf`;
- porta `8088` ou `8089` no arquivo `samu/infra/asterisk/config/http.conf`;
- tabela `ps_endpoints`: campo `transport` aponta para o transport correto.

## Problema: chamada sem audio

Verificar:

- permissao de microfone no navegador;
- portas RTP liberadas no firewall e faixa `rtpstart`/`rtpend` em `samu/infra/asterisk/config/rtp.conf`;
- tabela `ps_endpoints`: `direct_media=no`;
- tabela `ps_endpoints`: `ice_support=yes`;
- tabela `ps_endpoints`: `rtp_symmetric=yes`;
- tabela `ps_endpoints`: `rewrite_contact=yes`;
- tabela `ps_endpoints`: `rtcp_mux=yes`;
- STUN em `samu/infra/asterisk/config/rtp.conf`, campo `stunaddr`;
- NAT/firewall entre navegador e Asterisk.

## Problema: paciente derruba outro paciente

Provavel causa:

```text
varios pacientes usando o mesmo endpoint/AOR com max_contacts=1
```

Correcao:

```text
criar uma identidade web-* por paciente/sessao
```

## Problema: paciente consegue chamar numero indevido

Verificar:

- tabela `ps_endpoints`: `context=site-publico` no endpoint do paciente;
- contexto `site-publico` no arquivo `samu/infra/asterisk/config/extensions.conf` nao inclui contextos internos;
- regra `_X.` em `site-publico`, no arquivo `extensions.conf`, redireciona para `9000`.

---

Navegacao: [Anterior: Paciente externo e identidade temporaria](paciente-externo.md) | [Indice](README.md) | [Proximo: Query de configuracao rapida para testes](setup-rapido-ramais-samu.sql)
