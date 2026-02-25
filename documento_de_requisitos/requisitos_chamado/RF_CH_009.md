## RF_BA_009: O sistema deve permitir visualizar os detalhes de uma etapa do Chamado
**Descrição do caso de uso:** O sistema deve permitir acessar e visualizar os detalhes da etapa de um Chamado cadastrado.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Detalhar` no model `Chamado`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve ter permissão de `Detalhar` no model `Chamado`.
- O usuário seleciona um Chamado específico na lista.

**Saídas e pós-condição:**
- O sistema exibe os detalhes completos da etapa selecionada.
- O usuário pode visualizar informações que são obitidas na etapa selecionada.

**Fluxo de eventos principal:**
- O usuário seleciona o chamado desejado na lista.
- O usuário visualiza o detalhamento da primeira etapa e pode visualizar as próximas, caso já tenham sido finalizadas.
- O sistema exibe uma tela as informações que são obitidas na etapa selecionada.

**Fluxos secundários:**
- Caso o chamado não exista ou tenha sido excluído, o sistema retorna a mensagem: Chamado não encontrado”.
- Caso o usuário não possua permissão de `Detalhar` no model `Chamado`, o sistema:
  - Não exibe a opção de Ver chamado para acessar os detalhes.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: A visualização dos detalhes deve ser carregada em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_CH.md](./DD_CH.md).