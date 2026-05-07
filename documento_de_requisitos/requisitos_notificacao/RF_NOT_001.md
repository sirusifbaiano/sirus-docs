## RF_NOT_001: O sistema deve permitir que o usuário liste suas notificações

**Descrição do caso de uso:** O sistema deve permitir que o usuário visualize a lista de notificações associadas à sua conta.

**Ator(es):** Usuário autenticado.

**Prioridade:**   [ ] Essencial       [x] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve estar autenticado no sistema.

**Saídas e pós-condição:**
- O sistema exibe a lista de notificações do usuário, ordenadas das mais recentes para as mais antigas.

**Fluxo de eventos principal:**
- O usuário seleciona o ícone “Notificações” presente na barra superior.
- O sistema exibe uma lista suspensa com algumas notificações.
- O usuário clica no link "Ver todas as notificações" presente na lista suspensa.
- O sistema apresenta a lista de notificações recebidas.

**Fluxos secundários:**
- Caso não existam notificações salvas para o usuário, o sistema retorna a mensagem: **“Não há notificações para exibir.”**.
- Caso o usuário tente acessar notificações sem autenticação, o sistema retorna para a tela de login.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_NOT.md](./DD_NOT.md).
