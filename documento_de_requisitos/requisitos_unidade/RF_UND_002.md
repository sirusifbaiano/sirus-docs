## RF_UND_002: O sistema deve permitir listar todas as Unidades
**Descrição do caso de uso:** O sistema deve permitir visualizar a lista de todas as Unidades cadastradas.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Visualizar` no model `Unidade`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou membro de setor que tenha permissão de `Visualizar` no model `Unidade`.

**Saídas e pós-condição:**
- O sistema exibe a lista das Unidades disponíveis conforme a permissão do usuário.

**Fluxo de eventos principal:**
- O usuário seleciona a opção "Unidades" no menu do sistema.
- O sistema apresenta a lista de Unidades disponíveis.
- O usuário pode visualizar informações resumidas (Tipo de unidade, nome, Status e Base).

**Fluxos secundários:**
- Caso não haja Unidades cadastradas, o sistema retorna a mensagem: “Nenhuma Unidades cadastrada”.
- Caso o usuário não possua permissão de `Visualizar` no model `Unidade`, o sistema:
  - Não exibe a opção Unidades de atendimentos no menu.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar a lista em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_UND.md](./DD_UND.md).
