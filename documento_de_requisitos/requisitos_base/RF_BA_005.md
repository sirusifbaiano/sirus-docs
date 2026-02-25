## RF_BA_005: O sistema deve permitir excluir uma Base
**Descrição do caso de uso:** O sistema deve permitir remover uma Base previamente cadastrada.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Delete` no model `Base`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve ter permissão de `Delete` no model `Base`.
- O usuário seleciona uma Base existente para excluir.
- O sistema deve solicitar confirmação antes de excluir definitivamente.

**Saídas e pós-condição:**
- O sistema remove a Base do banco de dados.
- O sistema retorna mensagem confirmando a exclusão.

**Fluxo de eventos principal:**
- O usuário acessa a lista de Bases.
- O usuário seleciona a opção Excluir em uma Base específica.
- O sistema solicita confirmação da operação.
- O usuário confirma a exclusão.
- O sistema remove a Base do banco de dados.
- O sistema retorna a mensagem: “Base excluída com sucesso”.

**Fluxos secundários:**
- Caso ocorra falha na comunicação com o banco de dados, o sistema retorna uma mensagem de erro e cancela a operação.
- Caso a Base esteja vinculada a outros registros críticos, o sistema retorna a mensagem: “Não é possível excluir esta Base, pois está vinculada a registros ativos”.
- Caso o usuário não possua permissão de `Delete` no model `Base`, o sistema:
  - Não exibe a opção de excluir Bases.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: A exclusão deve ser concluída em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_BA.md](./DD_BA.md).