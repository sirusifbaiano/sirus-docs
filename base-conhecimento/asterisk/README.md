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
10. [Visao geral antiga](visao-geral.md)

## Mapa rapido

- Quer entender o que e ramal, tronco, fila e dialplan? Comece em [Conceitos basicos](conceitos-basicos.md).
- Quer cadastrar um atendente novo? Va para [Como criar um ramal](criar-ramal.md).
- Quer configurar quem recebe chamadas do TARM? Va para [Filas e membros de fila](filas.md).
- Quer entender o visitante do site externo? Va para [Paciente externo e identidade temporaria](paciente-externo.md).
- Quer resolver problema de registro ou audio? Va para [Operacao e diagnostico](operacao-diagnostico.md).

## Regra de ouro do projeto

No SIRUS/SAMU, ramais internos e pacientes externos devem ser tratados de formas diferentes:

- operador interno tem ramal fixo, por exemplo `2001`;
- paciente externo recebe identidade tecnica temporaria, por exemplo `web-483921`;
- paciente externo deve ficar preso ao contexto `site-publico`;
- chamadas de paciente devem entrar na fila `fila-tarm` pelo destino logico `9000`.

---

Navegacao: [Proximo: Conceitos basicos](conceitos-basicos.md)
