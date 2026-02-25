## RF_UND_005: O sistema deve permitir excluir uma Unidade
**Descrição do caso de uso:** O sistema deve permitir remover uma Unidade previamente cadastrada.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Delete` no model `Unidade`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve ter permissão de `Delete` no model `Unidade`.
- O usuário seleciona uma Unidade existente para excluir.
- O sistema deve solicitar confirmação antes de excluir definitivamente.

**Saídas e pós-condição:**
- O sistema remove a Unidade do banco de dados.
- O sistema retorna mensagem confirmando a exclusão.

**Fluxo de eventos principal:**
- O usuário acessa a lista de Unidade.
- O usuário seleciona a opção Excluir em uma Unidade específica.
- O sistema solicita confirmação da operação.
- O usuário confirma a exclusão.
- O sistema remove a Unidade do banco de dados.
- O sistema retorna a mensagem: “Unidade excluída com sucesso”.

**Fluxos secundários:**
- Caso ocorra falha na comunicação com o banco de dados, o sistema retorna uma mensagem de erro e cancela a operação.
- Caso o usuário não possua permissão de `Delete` no model `Unidade`, o sistema:
  - Não exibe a opção de excluir Unidades.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: A exclusão deve ser concluída em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_UND.md](./DD_UND.md).