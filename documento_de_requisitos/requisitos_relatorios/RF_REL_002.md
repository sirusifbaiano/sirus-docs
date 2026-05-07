## RF_REL_002: O sistema deve permitir adicionar relatórios

**Descrição do caso de uso:**  
O sistema deve permitir que usuários autorizados criem novos modelos de relatórios utilizando o gerador visual de relatórios.

**Ator(es):**  
Super usuário e/ou membros de setores que tenham permissão de `Adicionar` no app **Relatórios**.

**Prioridade:**   [ ] Essencial  [x] Importante  [ ] Desejável  

**Entradas e pré-condições**
- O usuário deve ser um Super Usuário ou membro de setor que possua permissão de `Adicionar` no app **Relatórios**.

**Saídas e pós-condição**
- O sistema salva o novo modelo de relatório cadastrado.
- O relatório passa a ficar disponível na listagem de relatórios do sistema.

**Fluxo de eventos principal**
1. O usuário acessa a página de **Relatórios**.
2. O usuário seleciona a opção de adicionar relatório.
3. O sistema apresenta a interface do gerador de relatórios.
4. O usuário adiciona componentes ao relatório (títulos, textos, tabelas e imagens).
5. O usuário configura os elementos desejados do relatório.
6. O usuário seleciona a opção **Salvar modelo**.
7. O sistema registra o novo relatório.

**Fluxos secundários**
- Caso ocorra erro durante o salvamento, o sistema retorna uma mensagem de erro.
- Caso o usuário não possua permissão de `Adicionar` no app **Relatórios**, o sistema:
  - Não exibe a opção de adicionar relatório.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

### Requisitos Não-Funcionais (RNF) vinculados
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade. 

**Dicionário de dados:**  
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_REL.md](./DD_REL.md).
