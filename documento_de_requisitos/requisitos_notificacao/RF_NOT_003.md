## RF_NOT_003: O sistema deve permitir marcar notificações como lidas

**Descrição do caso de uso:** O sistema deve permitir que o usuário marque notificações como lidas.

**Ator(es):** Usuário autenticado.

**Prioridade:**   [ ] Essencial       [x] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve estar autenticado no sistema.

**Saídas e pós-condição:**
- O sistema altera o status da notificação para “Lida” e atualiza a interface.

**Fluxo de eventos principal:**
- O usuário acessa a página de notificações.
- O usuário seleciona a(s) notificação(ões) não lida e clica no botão "Marcar como lida".
- O sistema altera automaticamente o status da notificação para “Lida”.
- O sistema atualiza a interface de notificações.

**Fluxos secundários:**
- Caso a notificação já esteja marcada como lida, o sistema mantém o status atual sem alterações.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_NOT.md](./DD_NOT.md).
