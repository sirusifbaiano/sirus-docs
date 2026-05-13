## RF_AU_003: O sistema deve permitir consultar a auditoria de um chamado

**Descrição do caso de uso:** O sistema deve permitir que usuários autorizados visualizem uma linha do tempo de auditoria de um chamado específico, incluindo alterações do chamado e de registros operacionais relacionados.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Visualizar` no model `Log de acesso`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve estar autenticado no sistema.
- O usuário deve possuir permissão `auditoria.view_usersessionlog`.
- Deve existir uma base válida.
- Deve existir um chamado vinculado à base informada.

**Saídas e pós-condição:**
- O sistema exibe a linha do tempo de auditoria do chamado.
- O sistema apresenta ação, responsável, data/hora e mudanças registradas.
- O sistema identifica registros operacionais relacionados ao chamado.

**Fluxo de eventos principal:**
- O usuário acessa a auditoria a partir do detalhe do chamado ou da consulta de chamados na auditoria central.
- O sistema valida a base e o chamado informados.
- O sistema busca logs do chamado e dos registros vinculados.
- O sistema formata os nomes dos modelos, ações e valores alterados.
- O sistema exibe a linha do tempo em ordem decrescente de data/hora.

**Fluxos secundários:**
- Caso a base não exista, o sistema retorna **erro HTTP 404 (Not Found)**.
- Caso o chamado não exista ou não pertença à base informada, o sistema retorna **erro HTTP 404 (Not Found)**.
- Caso o usuário não possua permissão, o sistema retorna **erro HTTP 403 (Forbidden)**.
- Caso o ator do log não exista, o sistema apresenta a ação como realizada pelo **Sistema**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: A linha do tempo deve ser carregada em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_AU.md](./DD_AU.md).
