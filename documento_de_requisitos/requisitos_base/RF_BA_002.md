## RF_BA_002: O sistema deve permitir listar todas as Bases
**Descrição do caso de uso:** O sistema deve permitir visualizar a lista de todas as Bases cadastradas.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Visualizar` no model `Base`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou membro de setor que tenha permissão de `Visualizar` no model `Base`.

**Saídas e pós-condição:**
- O sistema exibe a lista das Bases disponíveis conforme a permissão do usuário.

**Fluxo de eventos principal:**
- O usuário seleciona a opção "Bases de atendimento" no menu do sistema.
- O sistema apresenta a lista de Bases disponíveis.
- O usuário pode visualizar informações resumidas (nome, cidade, responsável e central).

**Fluxos secundários:**
- Caso não haja Bases cadastradas, o sistema retorna a mensagem: “Nenhuma Base cadastrada”.
- Caso o usuário não possua permissão de `Visualizar` no model `Base`, o sistema:
  - Não exibe a opção Bases de atendimentos no menu.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar a lista em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_BA.md](./DD_BA.md).
