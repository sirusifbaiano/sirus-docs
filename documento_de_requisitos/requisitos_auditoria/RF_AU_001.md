## RF_AU_001: O sistema deve permitir consultar a auditoria central

**Descrição do caso de uso:** O sistema deve permitir que usuários autorizados consultem, em uma tela central, registros de acesso de usuários e movimentações de entidades auditadas.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Visualizar` no model `Log de acesso`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve estar autenticado no sistema.
- O usuário deve possuir permissão `auditoria.view_usersessionlog`.
- Deve existir uma base válida no contexto da navegação.

**Saídas e pós-condição:**
- O sistema exibe a tela **Auditoria** com áreas de consulta para acessos de usuários e registros auditados.
- A consulta de usuários lista registros de acesso vinculados à base atual, bases subordinadas ou superusuários.
- A consulta de registros auditados apresenta movimentações recentes disponíveis para a base em contexto.

**Fluxo de eventos principal:**
- O usuário acessa a opção **Auditoria** no menu do sistema.
- O sistema abre a tela central de auditoria no contexto da base selecionada.
- O sistema exibe os registros de acesso como visualização padrão.
- O usuário alterna para outras consultas de auditoria quando desejar visualizar movimentações auditadas.
- O sistema apresenta os registros ordenados dos mais recentes para os mais antigos.

**Fluxos secundários:**
- Caso a visualização informada na URL seja inválida, o sistema retorna para a visualização padrão.
- Caso o usuário não possua permissão, o sistema retorna **erro HTTP 403 (Forbidden)**.
- Caso a base informada não exista, o sistema retorna **erro HTTP 404 (Not Found)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: A consulta deve ser carregada em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_AU.md](./DD_AU.md).
