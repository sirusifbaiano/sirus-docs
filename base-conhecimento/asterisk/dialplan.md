# Dialplan

Dialplan e o conjunto de regras que decide o caminho das chamadas.

No Asterisk, o dialplan do projeto fica em:

```text
infra/asterisk/config/extensions.conf
```

## Como ler uma regra

Exemplo:

```ini
exten => 9000,1,NoOp(Entrada na fila)
 same => n,Queue(fila-tarm,t,,,600)
 same => n,Hangup()
```

Significado:

- `exten => 9000`: regra para quando alguem disca `9000`;
- `1`: primeira prioridade, ou primeiro passo;
- `NoOp`: escreve mensagem no log, util para debug;
- `same => n`: continua a mesma extensao, no proximo passo;
- `Queue(...)`: coloca a chamada na fila;
- `Hangup()`: encerra a chamada.

## Contextos do projeto

### `samu-internal`

Permite chamadas internas para ramais `2XXX`.

```ini
[samu-internal]
exten => _2XXX,1,NoOp(== Ligacao interna: de ${CALLERID(num)} para ${EXTEN} ==)
 same => n,Dial(PJSIP/${EXTEN},30,tT)
 same => n,Hangup()
```

`_2XXX` e um padrao. Significa qualquer numero com quatro digitos que comece com `2`.

### `samu-fila-tarm`

Cria o destino logico `9000` para a fila TARM.

```ini
[samu-fila-tarm]
exten => 9000,1,NoOp(== Entrada na fila TARM: ${CALLERID(num)} / ${CALLERID(name)} ==)
 same => n,Queue(${FILA_TARM},t,,,600)
 same => n,Hangup()
```

`FILA_TARM` e uma variavel global definida no topo do arquivo:

```ini
FILA_TARM=fila-tarm
```

### `samu-entrada`

Recebe chamadas externas e manda tudo para a fila.

```ini
[samu-entrada]
exten => s,1,Goto(samu-fila-tarm,9000,1)
exten => _X.,1,Goto(samu-fila-tarm,9000,1)
```

`s` e usado quando a chamada entra sem numero especifico. `_X.` pega numeros discados em geral.

### `samu-saida`

Exemplo de saida para operadora/tronco.

```ini
[samu-saida]
exten => _0X.,1,Dial(PJSIP/${EXTEN:1}@SEU_TRONCO,60,tT)
```

`_0X.` significa numeros comecando por `0`. `${EXTEN:1}` remove o primeiro caractere, ou seja, tira o prefixo `0` antes de mandar para o tronco.

### `samu-equipe`

Agrupa permissoes da equipe interna.

```ini
[samu-equipe]
include => samu-internal
include => samu-fila-tarm
include => samu-saida
```

Quem esta nesse contexto pode usar as regras incluidas.

### `samu-tarm`

Contexto dos operadores TARM.

```ini
[samu-tarm]
include => samu-equipe
```

Hoje ele herda as permissoes de `samu-equipe`.

### `site-publico`

Contexto restrito para paciente externo.

```ini
[site-publico]
exten => 9000,1,Queue(${FILA_TARM},t,,,200)
exten => _X.,1,Goto(site-publico,9000,1)
```

Esse contexto e propositalmente limitado. Mesmo que o paciente tente discar outro numero, a chamada volta para `9000`.

## Regra de seguranca

Nunca incluir `samu-internal` ou `samu-saida` dentro de `site-publico`.

Se isso acontecer, um visitante do site pode ganhar permissao para chamar ramais internos ou tentar chamadas externas.

---

Navegacao: [Anterior: Transports, WebSocket, RTP e NAT](transports-webrtc-rtp.md) | [Indice](README.md) | [Proximo: Tabelas realtime do Asterisk](tabelas-realtime.md)
