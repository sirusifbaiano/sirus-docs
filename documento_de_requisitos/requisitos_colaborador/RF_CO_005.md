## RF_CO_005: O sistema deve permitir desativar um Colaborador
**Descrição do caso de uso:** O sistema deve permitir desativar o acesso de um Colaborador previamente cadastrada, tornando-o inativo.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Delete` no model `Pessoa`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve ter permissão de `Delete` no model `Pessoa`.
- O usuário seleciona um Colaborador existente para desativar.
- O sistema deve solicitar confirmação antes de excluir definitivamente.

**Saídas e pós-condição:**
- O sistema define o acesso do colaborador como inativo.
- O sistema retorna mensagem confirmando a exclusão.

**Fluxo de eventos principal:**
- O usuário acessa a lista de Colaboradores.
- O usuário seleciona a opção Excluir em um Colaborador específico.
- O sistema solicita confirmação da operação.
- O usuário confirma a exclusão.
- O sistema define o usuário do colaborador como inativo.
- O sistema retorna a mensagem: "Colaborador excluído com sucesso”.

**Fluxos secundários:**
- Caso ocorra falha na comunicação com o banco de dados, o sistema retorna uma mensagem de erro e cancela a operação.
- Caso o usuário não possua permissão de `Delete` no model `Pessoa`, o sistema:
  - Não exibe a opção de excluir Pessoa.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: A exclusão deve ser concluída em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_PE.md](./DD_PE.md).