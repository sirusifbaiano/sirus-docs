## RF_FL_001: O sistema deve permitir listar os fluxos de chamado  
**Descrição do caso de uso:** O sistema deve permitir que o usuário visualize o fluxo de chamado configurado, exibindo etapas e os setores responsáveis por cada fase.  

**Ator(es):** Super usuário e/ou responsável pela Base de Atendimento que tenham permissão de `View` no model `Fluxo`. 

**Prioridade:**   [x] Essencial  [ ] Importante  [ ] Desejável  

**Entradas e pré-condições:**  
- O usuário deve ser Superusuário ou Responsável pela Base de Atendimento com permissão de View no model Fluxo.
- Deve existir ao menos um fluxo configurado para que a listagem apresente dados.  

**Saídas e pós-condição:**  
- O sistema exibe o fluxo de chamado configurado, apresentando suas 4 etapas e os respectivos setores responsáveis.  
- Caso não exista nenhum fluxo configurado, o sistema retorna a mensagem: **“Fluxo de chamado não configurado.”**  

**Fluxo de eventos principal:**  
1. O usuário seleciona no menu a opção **Fluxo de chamado**.  
2. O sistema consulta os fluxos de chamado configurados no banco de dados.  
3. O sistema exibe a listagem com o fluxo e os setores vinculados a cada etapa.  

**Fluxos secundários:**  
- Caso o usuário não possua permissão de `View` no model `Fluxo`:  
  - O sistema **não exibe a opção de Fluxo de chamado** no menu.  
  - Se o usuário tentar acessar a funcionalidade diretamente pela URL, o sistema retorna **erro HTTP 403 (Forbidden)**.  
- Caso ocorra uma falha de comunicação com o banco de dados, uma mensagem de erro é exibida e a operação é cancelada.  

**Requisitos Não-Funcionais (RNF) vinculados:**  
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.  
- RNF_002: O sistema deve ter recursos de acessibilidade.  
- RNF_003: O sistema deve registrar em log os acessos e tentativas de acesso negado.  

## Dicionário de termos
| Termo | Descrição |
|-------|-----------|
| Fluxo de chamado | Conjunto de etapas definidas para o tratamento de um chamado, determinando quais setores são responsáveis em cada fase do processo. Cada fluxo possui exatamente 4 etapas, cada uma associada a um setor previamente cadastrado no sistema. |

## Dicionário de dados:  
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_FL.md](./DD_FL.md).  
