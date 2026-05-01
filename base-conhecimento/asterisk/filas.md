# Filas e Membros de Fila

Fila e usada quando uma chamada deve esperar por um atendente disponivel.

No SIRUS/SAMU, a fila principal e:

```text
fila-tarm
```

O destino logico para entrar nela e:

```text
9000
```

## Criar fila

Tabela: `queues`

Onde preencher: Django Admin de telefonia, cadastro de filas. No codigo, esta em `samu/code/telefonia/models.py`, classe `Queues`.

O dialplan usa essa fila no arquivo `samu/infra/asterisk/config/extensions.conf`, quando executa `Queue(${FILA_TARM},...)`.

Configuracao inicial recomendada:

```text
name: fila-tarm
musiconhold: default
timeout: 20
retry: 3
wrapuptime: 5
ringinuse: no
autofill: yes
strategy: rrmemory
joinempty: yes
leavewhenempty: no
setinterfacevar: yes
setqueuevar: yes
setqueueentryvar: yes
```

## Escolher estrategia

- `ringall`: todos tocam ao mesmo tempo. Bom para equipe pequena, mas pode incomodar.
- `rrmemory`: rodizio com memoria. Bom equilibrio para TARM.
- `fewestcalls`: prioriza quem atendeu menos chamadas.
- `leastrecent`: prioriza quem esta ha mais tempo sem atender.
- `random`: sorteio simples.

Recomendacao inicial: `rrmemory`.

## Adicionar atendente

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

## Pausar atendente

Para impedir que o ramal receba chamadas sem remover da fila:

Alterar estes campos na tabela `queue_members`, no registro do atendente dentro da fila:

```text
paused: 1
reason_paused: almoco
```

Para voltar:

Alterar o mesmo registro em `queue_members`:

```text
paused: 0
reason_paused: vazio
```

## Verificar fila

```bash
docker exec asterisk-dev asterisk -rx "queue show fila-tarm"
```

Observar:

- membros cadastrados;
- se estao pausados;
- se estao ocupados;
- quantidade de chamadas esperando;
- tempo de espera.

---

Navegacao: [Anterior: Como criar um ramal](criar-ramal.md) | [Indice](README.md) | [Proximo: Paciente externo e identidade temporaria](paciente-externo.md)
