# Paciente Externo e Identidade Temporaria

Paciente externo nao deve receber ramal interno real.

No projeto atual, o `infra/telefone-externo` ainda nao cria ramais automaticamente. Ele usa um pool fixo de ramais externos de teste:

```text
7001 ate 7010
senha: 12345678
numero discado: 192
contexto: site-publico
```

O correto para uma versao futura e criar uma identidade tecnica temporaria para cada sessao do site. Essa evolucao ainda nao esta implementada neste momento.

## Por que nao usar ramal interno

Ramais como `2001`, `2002` e `2030` representam pessoas ou postos internos. Se um paciente externo recebe um desses numeros, a central fica mais dificil de auditar e pode expor permissoes indevidas.

Para a funcionalidade futura, use nomes tecnicos como:

```text
web-483921
web-a7f31c
sessao-120394
```

## Fluxo atual do telefone-externo

1. Paciente abre o site externo.
2. O JavaScript em `samu/infra/telefone-externo/script.js` sorteia um ramal entre `7001` e `7010`.
3. Browser registra no Asterisk com senha `12345678`.
4. Browser chama `192`.
5. Dialplan `site-publico` redireciona para `9000`.
6. `9000` manda para `fila-tarm`.

## Fluxo futuro recomendado

1. Paciente abre o site externo.
2. Site pede uma credencial temporaria ao backend.
3. Backend cria ou reserva uma identidade de sessao.
4. Backend grava `ps_aors`, `ps_auths` e `ps_endpoints`.
5. Browser registra no Asterisk com JsSIP.
6. Browser chama o destino publico configurado.
7. Ao terminar ou ficar ocioso, backend expira a identidade.

## Configuracao atual do endpoint externo

Tabela `ps_endpoints`:

Onde criar: hoje, manualmente pelo Django Admin de telefonia ou pela query [setup-rapido-ramais-samu.sql](setup-rapido-ramais-samu.sql). No codigo, o modelo esta em `samu/code/telefonia/models.py`, classe `PsEndpoints`.

Todos os campos abaixo pertencem a essa tabela. Os campos de NAT/WebRTC, como `direct_media`, `ice_support`, `rewrite_contact`, `rtp_symmetric`, `rtcp_mux` e `bundle`, tambem ficam aqui.

```text
id: 7001
transport: transport-ws
aors: 7001
auth: 7001
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

Onde criar: hoje, manualmente pelo Django Admin de telefonia ou pela query de setup rapido. No codigo, classe `PsAuths`.

```text
id: 7001
auth_type: userpass
username: 7001
password: 12345678
```

Tabela `ps_aors`:

Onde criar: hoje, manualmente pelo Django Admin de telefonia ou pela query de setup rapido. No codigo, classe `PsAors`.

```text
id: 7001
max_contacts: 1
remove_existing: yes
```

## Tempo de vida

No estado atual, os ramais externos `7001` a `7010` sao fixos para teste e nao expiram automaticamente.

Para a funcionalidade futura de identidade temporaria, a sugestao e:

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
