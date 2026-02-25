## RF_REL_002: O sistema deve permitir filtrar Relatórios por período

**Descrição do caso de uso:**  
O sistema deve permitir que o usuário defina um período de datas para filtrar os relatórios disponíveis, retornando apenas as informações correspondentes ao intervalo informado.

**Ator(es):**  
Super usuário e/ou membros de setores que tenham permissão de `Visualizar` no app **Relatórios**.

**Prioridade:**   [x] Essencial  [ ] Importante  [ ] Desejável  

**Entradas e pré-condições**
- O usuário deve ser um Super Usuário ou membro de setor que possua permissão de `Visualizar` no app **Relatórios**.  
- O usuário deve selecionar um período no formato `dd/mm/yyyy - dd/mm/yyyy`.  
- Caso o usuário não informe um período, o sistema aplica o **período padrão**: o dia atual.  

**Saídas e pós-condição**
- O sistema retorna o relatório filtrado de acordo com o período informado em formato PDF.  
- O sistema exibe a indicação visual do período considerado.  
- O sistema disponibiliza as ações de **Filtrar** e **Limpar** para o usuário ajustar a consulta.  

**Fluxo de eventos principal**
1. O usuário acessa a opção **Relatórios** e seleciona um relatório disponível.  
2. O sistema exibe o formulário de filtros com o campo **Período**.  
3. O usuário informa o intervalo de datas e clica em **Filtrar**.  
4. O sistema processa a consulta e exibe os dados filtrados.  

**Fluxos secundários**
- Caso não existam dados no período selecionado, o sistema retorna a mensagem:  
  **“Nenhum dado encontrado para o período selecionado.”**  
- Caso o usuário clique em **Limpar**, o sistema redefine o período para o valor padrão (dia atual).  

### Requisitos Não-Funcionais (RNF) vinculados
- RNF_001: O sistema deve retornar os resultados do filtro em menos de 3 segundos.  
- RNF_002: O sistema deve ter recursos de acessibilidade.  
- RNF_003: O layout deve manter consistência visual com os demais módulos (cores, botões e formulários).  


