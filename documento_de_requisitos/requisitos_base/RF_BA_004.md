## RF_BA_004: O sistema deve permitir editar uma Base
**Descrição do caso de uso:** O sistema deve permitir alterar os dados de uma Base previamente cadastrada.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Editar` no model `Base`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve ter permissão de `Editar` no model `Base`.
- O usuário seleciona uma Base existente para editar.
- O usuário não pode editar uma Base que esteja vinculada de maneira direta ou indireta.

**Saídas e pós-condição:**
- O sistema retorna mensagem informando o resultado da operação.
- Os dados da Base são atualizados no banco de dados.

**Fluxo de eventos principal:**
- O usuário acessa a lista de Bases.
- O usuário seleciona a opção Editar em uma Base específica, representada por um botão com o ícone de uma caneta.
- O sistema apresenta o formulário preenchido com os dados atuais da Base.
- O usuário altera os dados desejados.
- O usuário clica em Salvar.
- O sistema valida as informações e atualiza os dados no banco.
- O sistema retorna a mensagem: “Base atualizada com sucesso”.

**Fluxos secundários:**
- Caso ocorra falha na comunicação com o banco de dados, o sistema retorna uma mensagem de erro e cancela a operação.
- Caso o usuário não possua permissão de `Editar` no model `Base`, o sistema:
  - Não exibe a opção de editar Bases.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: A atualização deve ser concluída em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.
- RNF_003: Todos os campos obrigatórios dos formulários do sistema devem ser identificados com um asterisco (*) imediatamente após o seu label.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_BA.md](./DD_BA.md).