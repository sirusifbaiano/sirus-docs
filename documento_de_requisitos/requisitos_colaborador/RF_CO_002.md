## RF_CO_002: O sistema deve permitir listar todas os Colaboradores
**Descrição do caso de uso:** O sistema deve permitir visualizar a lista de todas os Colaboradores cadastradas.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Visualizar` no model `Pessoa`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou membro de setor que tenha permissão de `Visualizar` no model `Pessoa`.

**Saídas e pós-condição:**
- O sistema exibe a lista dos colaboradores que são membros de um setor que:
    - tenha como base a base atual.
    - ou tenha como base uma base cuja central seja a base atual.

**Fluxo de eventos principal:**
- O usuário seleciona a opção "Colaboradores" no menu do sistema.
- O sistema apresenta a lista de colaboradores.
- O usuário pode visualizar informações resumidas (nome, base de cadastro, email e telefone).

**Fluxos secundários:**
- Caso não haja Colaboradores cadastradas, o sistema retorna a mensagem: “Nenhum Colaborador cadastrada”.
- Caso o usuário não possua permissão de `Visualizar` no model `Pessoa`, o sistema:
  - Não exibe a opção Colaboradores no menu.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar a lista em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_PE.md](./DD_PE.md.md).
