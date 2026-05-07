## RF_REL_003: O sistema deve permitir editar relatórios

**Descrição do caso de uso:**  
O sistema deve permitir que usuários autorizados alterem modelos de relatórios previamente cadastrados.

**Ator(es):**  
Super usuário e/ou membros de setores que tenham permissão de `Editar` no app **Relatórios**.

**Prioridade:**   [ ] Essencial  [x] Importante  [ ] Desejável  

**Entradas e pré-condições**
- O usuário deve ser um Super Usuário ou membro de setor que possua permissão de `Editar` no app **Relatórios**.
- O relatório deve estar previamente cadastrado no sistema.

**Saídas e pós-condição**
- O sistema salva as alterações realizadas no modelo de relatório.

**Fluxo de eventos principal**
1. O usuário acessa a página de **Relatórios**.
2. O sistema apresenta a lista de relatórios disponíveis.
3. O usuário seleciona a opção de edição de um relatório.
4. O sistema apresenta o gerador de relatórios contendo os componentes já salvos.
5. O usuário altera os componentes ou propriedades desejadas.
6. O usuário seleciona a opção **Salvar modelo**.
7. O sistema registra as alterações realizadas.

**Fluxos secundários**
- Caso ocorra erro durante o salvamento das alterações, o sistema retorna uma mensagem de erro.
- Caso o usuário não possua permissão de `Editar` no app **Relatórios**, o sistema:
  - Não exibe a opção de edição do relatório.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

### Requisitos Não-Funcionais (RNF) vinculados
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**  
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_REL.md](./DD_REL.md).