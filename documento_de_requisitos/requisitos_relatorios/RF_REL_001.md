## RF_REL_001: O sistema deve permitir listar todos os relatórios disponíveis

**Descrição do caso de uso:**  
O sistema deve permitir visualizar a lista de todos os relatórios cadastrados e disponíveis para o usuário conforme suas permissões.

**Ator(es):**  
Super usuário e/ou membros de setores que tenham permissão de `Visualizar` no app **Relatórios**.

**Prioridade:**   [ ] Essencial  [x] Importante  [ ] Desejável  

**Entradas e pré-condições**
- O usuário deve ser um Super Usuário ou membro de setor que possua permissão de `Visualizar` no app **Relatórios**.  

**Saídas e pós-condição**
- O sistema exibe a lista de relatórios disponíveis, apresentando **nome** e **descrição** de cada relatório.  

**Fluxo de eventos principal**
1. O usuário acessa a opção **Relatórios** no menu do sistema.  
2. O sistema apresenta a lista de relatórios disponíveis.  
3. O usuário pode acionar a geração de um relatório clicando no ícone de impressora correspondente.  

**Fluxos secundários**
- Caso não existam relatórios cadastrados ou disponíveis para o perfil, o sistema retorna a mensagem: **“Nenhum registro encontrado.”**  
- Caso o usuário não possua permissão de `Visualizar` no app **Relatórios**, o sistema:  
  - Não exibe a opção **Relatórios** no menu.  
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.  

### Requisitos Não-Funcionais (RNF) vinculados
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.  
- RNF_002: O sistema deve ter recursos de acessibilidade.  
- RNF_003: O layout deve manter consistência visual com os demais módulos (cores, cabeçalho, rodapé, tabelas).  




