## RF_UND_003: O sistema deve permitir visualizar os detalhes de uma Unidade
**Descrição do caso de uso:** O sistema deve permitir acessar e visualizar os detalhes completos de uma Unidade cadastrada.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Detalhar` no model `Unidade`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve ter permissão de `Detalhar` no model `Unidade`.
- O usuário seleciona uma Unidade específica na lista.

**Saídas e pós-condição:**
- O sistema exibe os detalhes completos da Unidade selecionada.
- O usuário pode visualizar informações como Tipo de unidade, Status, Nome da Unidade, Modelo, Base, entre outros.
- O usuário, com respeito as suas respectivas permissões, pode navegar para outras funcionalidades relacionadas à Unidade (ex.: editar, excluir).
- O sistema deve garantir que todas as opções apresentadas estejam em conformidade com as permissões do usuário.

**Fluxo de eventos principal:**
- O usuário seleciona a Unidade desejada na lista.
- O sistema exibe uma tela com os detalhes (ex.: Tipo de unidade, Status, Nome da Unidade, Modelo, Base).

**Fluxos secundários:**
- Caso a Unidade não exista ou tenha sido excluída, o sistema retorna a mensagem: “Unidade não encontrada”.
- Caso o usuário não possua permissão de `Detalhar` no model `Unidade`, o sistema:
  - Não exibe a opção de Ver essa Unidade para acessar os detalhes.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: A visualização dos detalhes deve ser carregada em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_UND.md](./DD_UND.md).