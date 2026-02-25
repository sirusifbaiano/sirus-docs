## RF_BA_003: O sistema deve permitir visualizar os detalhes de uma Base
**Descrição do caso de uso:** O sistema deve permitir acessar e visualizar os detalhes completos de uma Base cadastrada.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Detalhar` no model `Base`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve ter permissão de `Detalhar` no model `Base`.
- O usuário seleciona uma Base específica na lista.

**Saídas e pós-condição:**
- O sistema exibe os detalhes completos da Base selecionada.
- O usuário pode visualizar informações como nome, endereço, responsável, se é central, Bases associadas, entre outros.
- O usuário, com respeito as suas respectivas permissões, pode navegar para outras funcionalidades relacionadas à Base (ex.: editar, excluir).
- O sistema deve garantir que todas as opções apresentadas estejam em conformidade com as permissões do usuário.

**Fluxo de eventos principal:**
- O usuário seleciona a Base desejada na lista.
- O sistema exibe uma tela com os detalhes (ex.: nome, endereço, responsável, se é central, Bases associadas).

**Fluxos secundários:**
- Caso a Base não exista ou tenha sido excluída, o sistema retorna a mensagem: “Base não encontrada”.
- Caso o usuário não possua permissão de `Detalhar` no model `Base`, o sistema:
  - Não exibe a opção de Ver essa base para acessar os detalhes.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: A visualização dos detalhes deve ser carregada em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_BA.md](./DD_BA.md).