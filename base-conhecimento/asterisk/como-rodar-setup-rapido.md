# Como Rodar a Query de Setup Rapido

Este documento explica como executar a query [setup-rapido-ramais-samu.sql](setup-rapido-ramais-samu.sql) para preparar um ambiente de teste com ramais basicos do Asterisk no contexto do SAMU/SIRUS.

Use este processo apenas em desenvolvimento ou homologacao controlada. A query cria senhas simples para facilitar testes locais.

## O que a query cria

- tabela `queues`: fila `fila-tarm`;
- tabela `ps_aors`: AORs dos ramais e identidades web;
- tabela `ps_auths`: usuarios e senhas SIP;
- tabela `ps_endpoints`: endpoints WebRTC;
- tabela `queue_members`: TARMs `2001` e `2002` dentro da fila.

Credenciais criadas:

| Uso | Usuario | Senha | Contexto |
| --- | --- | --- | --- |
| TARM 1 | `2001` | `2001` | `samu-tarm` |
| TARM 2 | `2002` | `2002` | `samu-tarm` |
| Regulacao | `2101` | `2101` | `samu-equipe` |
| Radio | `2102` | `2102` | `samu-equipe` |
| Paciente/site teste | `web-0001` ate `web-0010` | `web0001` ate `web0010` | `site-publico` |

## Pre-requisitos

No ambiente de desenvolvimento do projeto `samu`, os containers esperados sao:

```text
asterisk-db-dev
asterisk-dev
```

O banco realtime do Asterisk, pelo `docker-compose.dev.yml`, usa:

```text
container: asterisk-db-dev
banco: asterisk_db
usuario: asterisk_user
senha: asterisk_pass
porta externa: 5433
```

Confirme se os containers estao de pe:

```bash
docker ps --filter "name=asterisk"
```

## Opcao 1: rodar pelo container do Postgres

Execute a partir da pasta do repositório `sirus-docs`:

```bash
docker exec -i asterisk-db-dev psql -U asterisk_user -d asterisk_db < base-conhecimento/asterisk/setup-rapido-ramais-samu.sql
```

Se estiver em outra pasta, use o caminho completo do arquivo:

```bash
docker exec -i asterisk-db-dev psql -U asterisk_user -d asterisk_db < /home/rj/Documentos/Code/Sirus-Samu/sirus-docs/base-conhecimento/asterisk/setup-rapido-ramais-samu.sql
```

## Opcao 2: rodar pela porta local 5433

Se voce tiver `psql` instalado na maquina:

```bash
PGPASSWORD=asterisk_pass psql -h 127.0.0.1 -p 5433 -U asterisk_user -d asterisk_db -f base-conhecimento/asterisk/setup-rapido-ramais-samu.sql
```

## Recarregar o Asterisk

Depois de rodar a query, recarregue as configuracoes:

```bash
docker exec asterisk-dev asterisk -rx "pjsip reload"
docker exec asterisk-dev asterisk -rx "queue reload all"
docker exec asterisk-dev asterisk -rx "dialplan reload"
```

## Validar se funcionou

Ver endpoints:

```bash
docker exec asterisk-dev asterisk -rx "pjsip show endpoints"
```

Ver contatos registrados:

```bash
docker exec asterisk-dev asterisk -rx "pjsip show contacts"
```

Ver fila TARM:

```bash
docker exec asterisk-dev asterisk -rx "queue show fila-tarm"
```

Ver o dialplan do site publico:

```bash
docker exec asterisk-dev asterisk -rx "dialplan show site-publico"
```

## Como testar no softphone

1. Abra o softphone interno.
2. Registre o TARM 1:

```text
Ramal: 2001
Senha: 2001
```

3. Em outro navegador, aba anonima ou outro dispositivo, registre o TARM 2:

```text
Ramal: 2002
Senha: 2002
```

4. Para simular visitante/site externo, registre uma identidade web:

```text
Usuario: web-0001
Senha: web0001
Destino: 9000
```

5. Ao ligar para `9000`, a chamada deve entrar em `fila-tarm` e tocar em `2001` ou `2002`.

## Se der erro

### Tabela nao existe

O banco do Asterisk ainda nao rodou as migrations. Suba/reinicie o container `asterisk-dev`, pois o entrypoint executa `ast-db-manage`:

```bash
docker compose --env-file .env.dev -f docker-compose.dev.yml up -d asterisk-dev
```

### Permissao negada ou banco errado

Confira se esta usando o banco do Asterisk, nao o banco do Django:

```text
correto: asterisk-db-dev / asterisk_db / asterisk_user
evitar: postgres / banco principal do Django
```

### Endpoints nao aparecem no Asterisk

Rode:

```bash
docker exec asterisk-dev asterisk -rx "pjsip reload"
docker exec asterisk-dev asterisk -rx "pjsip show endpoint 2001"
```

### Fila nao mostra os TARMs

Rode:

```bash
docker exec asterisk-dev asterisk -rx "queue reload all"
docker exec asterisk-dev asterisk -rx "queue show fila-tarm"
```

---

Navegacao: [Anterior: Query de configuracao rapida para testes](setup-rapido-ramais-samu.sql) | [Indice](README.md) | [Proximo: Visao geral antiga](visao-geral.md)
