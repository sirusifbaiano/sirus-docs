# Asterisk e Telefonia WebRTC

Esta pasta organiza a documentacao de telefonia do SIRUS/SAMU em capitulos menores. A ideia é comecar pelos conceitos básicos e aos poucos avançar para configuracao, criacao de ramais, filas e diagnostico.

## Ordem sugerida de leitura

1. [Conceitos basicos](conceitos-basicos.md)
2. [Arquitetura no SIRUS/SAMU](arquitetura-sirus.md)
3. [Transports, WebSocket, RTP e NAT](transports-webrtc-rtp.md)
4. [Dialplan](dialplan.md)
5. [Tabelas realtime do Asterisk](tabelas-realtime.md)
6. [Como criar um ramal](criar-ramal.md)
7. [Filas e membros de fila](filas.md)
8. [Paciente externo e identidade temporaria](paciente-externo.md)
9. [Operacao e diagnostico](operacao-diagnostico.md)
10. [Referencia consolidada](visao-geral.md)
11. [Como rodar a query de setup rapido](como-rodar-setup-rapido.md)
12. [Query de configuracao rapida para testes](setup-rapido-ramais-samu.sql)

## Mapa rapido

- Quer entender o que e ramal, tronco, fila e dialplan? Comece em [Conceitos basicos](conceitos-basicos.md).
- Quer cadastrar um atendente novo? Va para [Como criar um ramal](criar-ramal.md).
- Quer configurar quem recebe chamadas do TARM? Va para [Filas e membros de fila](filas.md).
- Quer entender o visitante do site externo? Va para [Paciente externo e identidade temporaria](paciente-externo.md).
- Quer resolver problema de registro ou audio? Va para [Operacao e diagnostico](operacao-diagnostico.md).
- Quer saber como executar a query? Leia [como rodar a query de setup rapido](como-rodar-setup-rapido.md).
- Quer preparar dados basicos de teste? Depois leia e execute a [query de configuracao rapida](setup-rapido-ramais-samu.sql).

## Regra de ouro do projeto

No SIRUS/SAMU, ramais internos e pacientes externos devem ser tratados de formas diferentes:

- operador interno tem ramal fixo, por exemplo `2001`;
- hoje, o telefone externo usa um pool fixo de ramais de teste, `7001` ate `7010`, com senha padrao `12345678`;
- futuramente, o paciente externo deve receber uma identidade tecnica temporaria gerenciada pelo backend;
- paciente externo deve ficar preso ao contexto `site-publico`;
- chamadas do telefone externo discam `192`, e o contexto `site-publico` redireciona para a fila `fila-tarm`.

---

Navegacao: [Proximo: Conceitos basicos](conceitos-basicos.md)
