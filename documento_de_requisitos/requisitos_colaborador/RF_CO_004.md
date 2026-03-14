## RF_CO_004: O sistema deve permitir editar um Colaborador
**Descrição do caso de uso:** O sistema deve permitir alterar os dados de um Colaborador previamente cadastrada.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Editar` no model `Pessoa`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve ter permissão de `Editar` no model `Pessoa`.
- O usuário seleciona um Colaborador existente para editar.
- O usuário não pode editar um Colaborador que esteja vinculada de maneira direta ou indireta.

**Saídas e pós-condição:**
- O sistema retorna mensagem informando o resultado da operação.
- Os dados do Colaborador são atualizados no banco de dados.

**Fluxo de eventos principal:**
- O usuário acessa a lista de Colaboradores.
- O usuário seleciona a opção Editar em um Colaborador específico, representada por um botão com o ícone de uma caneta.
- O sistema apresenta o formulário preenchido com os dados atuais do Colaborador.
- O usuário altera os dados desejados.
- O usuário clica em Salvar.
- O sistema valida as informações e atualiza os dados no banco.
- O sistema retorna a mensagem: “Colaborador atualizada com sucesso”.

**Fluxos secundários:**
- Caso ocorra falha na comunicação com o banco de dados, o sistema retorna uma mensagem de erro e cancela a operação.
- Caso o usuário não possua permissão de `Editar` no model `Pessoa`, o sistema:
  - Não exibe a opção de editar Colaboradores.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: A atualização deve ser concluída em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.
- RNF_003: Todos os campos obrigatórios dos formulários do sistema devem ser identificados com um asterisco (*) imediatamente após o seu label.

**Dicionário de dados:**
Para detalhes sobre campos e estrutura de dados, consulte os arquivos [DD_CO.md](./DD_CO.md) para os campos de colaboradores e
[DD_PE.md](../requisitos_pessoa/DD_PE.md) para os campos herdados de Pessoa.