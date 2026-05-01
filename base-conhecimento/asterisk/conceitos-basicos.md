# Conceitos Basicos

Este capitulo explica os termos mais comuns antes de entrar na configuracao.

## O que e o Asterisk

O Asterisk e uma central telefonica em software. Ele faz o papel que uma central fisica faria em uma empresa: recebe chamadas, autentica telefones, decide para onde cada ligacao deve ir, toca filas, transfere chamadas e registra eventos.

No SIRUS/SAMU, o Asterisk conversa com navegadores por WebRTC. Isso permite que um operador use um softphone dentro do sistema web e que um paciente consiga iniciar chamada pelo site externo.

## O que e SIP

SIP e o protocolo usado para sinalizacao de chamadas. Ele nao e o audio em si. Ele serve para coisas como:

- registrar um telefone ou navegador;
- iniciar uma chamada;
- avisar que esta tocando;
- atender;
- desligar;
- transferir.

O audio normalmente trafega por RTP. Em WebRTC, o navegador tambem usa tecnologias de seguranca e NAT, como DTLS, ICE e STUN.

## O que e PJSIP

PJSIP e o modulo moderno do Asterisk para trabalhar com SIP. Nos arquivos e tabelas do projeto, quase tudo comeca com `ps_` por causa do PJSIP:

- `ps_endpoints`;
- `ps_auths`;
- `ps_aors`;
- `ps_contacts`.

## O que e um ramal

Ramal e uma identidade telefonica interna. Exemplo:

```text
2001
2002
2003
```

No sistema, um ramal normalmente representa um operador, uma sala, uma equipe ou um dispositivo. Quando o ramal `2001` se registra, o Asterisk passa a saber onde entregar chamadas destinadas a `2001`.

Para um operador TARM, o ramal pode ser fixo e vinculado ao usuario do sistema.

## O que e uma identidade temporaria

Identidade temporaria e parecida com um ramal do ponto de vista tecnico, mas nao deve ser tratada como ramal humano.

Exemplo:

```text
web-483921
web-a7f31c
sessao-120394
```

Ela serve para um paciente externo conseguir se autenticar e ligar para a fila. Ela deve expirar depois de um tempo ou ao fim da chamada.

No estado atual do projeto, essa criacao automatica ainda nao esta implementada. O `infra/telefone-externo` usa um pool fixo de ramais de teste, de `7001` a `7010`, todos com senha padrao `12345678`. A identidade temporaria automatica e uma evolucao futura.

## O que e um tronco

Tronco e uma conexao entre o Asterisk e outra rede telefonica.

Exemplos:

- tronco com uma operadora VoIP;
- tronco com outra central Asterisk;
- tronco com uma central fisica da prefeitura;
- tronco SIP para receber chamadas do numero publico.

Se o ramal e "um telefone interno", o tronco e "a estrada para fora ou para dentro da central".

No dialplan atual existe um exemplo de saida:

```ini
exten => _0X.,1,Dial(PJSIP/${EXTEN:1}@SEU_TRONCO,60,tT)
```

Isso significa: se alguem discar numero com prefixo `0`, o Asterisk tira o `0` e tenta mandar a chamada para o tronco `SEU_TRONCO`.

## O que e uma fila

Fila e um destino que segura chamadas ate algum atendente estar disponivel.

No SIRUS/SAMU, a fila principal de atendimento e:

```text
fila-tarm
```

O numero logico para entrar nessa fila e:

```text
9000
```

Quando uma chamada entra em `9000`, o Asterisk coloca a chamada na `fila-tarm` e tenta entregar para os membros cadastrados.

## O que e um membro de fila

Membro de fila e quem pode receber chamada daquela fila. Exemplo:

```text
PJSIP/2001
PJSIP/2002
PJSIP/2003
```

Esses membros ficam na tabela `queue_members`.

## O que e dialplan

Dialplan e o conjunto de regras que diz o que acontece quando alguem liga para um numero.

Exemplo humano:

```text
Se discar 2001, chamar o ramal 2001.
Se discar 9000, entrar na fila TARM.
Se paciente discar qualquer numero, mandar para 9000.
```

No Asterisk, isso aparece no arquivo `extensions.conf`.

## O que e contexto

Contexto e uma area de permissao do dialplan. Ele define o que um endpoint pode fazer.

Exemplos do projeto:

- `samu-tarm`: contexto de operadores TARM;
- `samu-equipe`: contexto da equipe interna;
- `site-publico`: contexto restrito para paciente externo;
- `samu-entrada`: contexto para chamadas que chegam de fora.

Contexto e uma das principais barreiras de seguranca. Um paciente externo nunca deve estar em um contexto que permita ligar para ramais internos ou para fora da rede.

## O que e endpoint, auth e AOR

No PJSIP, criar um "ramal" normalmente envolve tres pecas:

- `endpoint`: comportamento e permissoes;
- `auth`: usuario e senha;
- `aor`: onde o endpoint esta registrado.

Para o ramal `2001`, normalmente existem:

```text
ps_endpoints.id = 2001
ps_auths.id = 2001
ps_aors.id = 2001
```

Usar o mesmo ID nas tres tabelas reduz erro humano.

---

Navegacao: [Anterior: Indice](README.md) | [Proximo: Arquitetura no SIRUS/SAMU](arquitetura-sirus.md)
