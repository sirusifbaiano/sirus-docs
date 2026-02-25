## RF_UND_004: O sistema deve permitir editar uma Unidade
**Descrição do caso de uso:** O sistema deve permitir alterar os dados de uma Unidade previamente cadastrada.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Editar` no model `Unidade`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve ter permissão de `Editar` no model `Unidade`.
- O usuário seleciona uma Unidade existente para editar.

**Saídas e pós-condição:**
- O sistema retorna mensagem informando o resultado da operação.
- Os dados da Base são atualizados no banco de dados.

**Fluxo de eventos principal:**
- O usuário acessa a lista de Unidades.
- O usuário seleciona a opção Editar em uma Unidade específica, representada por um botão com o ícone de uma caneta.
- O sistema apresenta o formulário preenchido com os dados atuais da Unidade.
- O usuário altera os dados desejados.
- O usuário clica em Salvar.
- O sistema valida as informações e atualiza os dados no banco.
- O sistema retorna a mensagem: Unidade atualizada com sucesso”.

**Fluxos secundários:**
- Caso ocorra falha na comunicação com o banco de dados, o sistema retorna uma mensagem de erro e cancela a operação.
- Caso o usuário não possua permissão de `Editar` no model `Unidade`, o sistema:
  - Não exibe a opção de editar Unidades.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: A atualização deve ser concluída em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.
- RNF_003: Todos os campos obrigatórios dos formulários do sistema devem ser identificados com um asterisco (*) imediatamente após o seu label.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_UND.md](./DD_UND.md).