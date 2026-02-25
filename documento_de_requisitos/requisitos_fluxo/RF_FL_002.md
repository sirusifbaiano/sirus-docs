## RF_FL_002: O sistema deve permitir configurar o fluxo de chamado  
**Descrição do caso de uso:** O sistema deve permitir que o usuário configure o fluxo de trabalho de um chamado, definindo quais setores participarão das fases do processo.  

**Ator(es):** Super usuário e/ou responsável pela Base de Atendimento que tenham permissão de `Add` no model `Fluxo`.  

**Prioridade:**   [x] Essencial  [ ] Importante  [ ] Desejável  

**Entradas e pré-condições:**  
- O usuário deve ser Superusuário ou Responsável pela Base de Atendimento com permissão de `Add` no model `Fluxo`.
- Os setores que serão parte do fluxo já devem estar previamente cadastrados no sistema.  
- O fluxo de chamado deve conter exatamente 4 etapas, cada uma associada a um setor.  

**Saídas e pós-condição:**  
- O sistema retorna uma mensagem informando o resultado da configuração do fluxo.  
- O fluxo de chamado é salvo no banco de dados, vinculado aos setores definidos.  

**Fluxo de eventos principal:**  
1. O usuário seleciona no menu a opção **Fluxo de chamado**.  
2. O usuário seleciona a opção **Configurar fluxo de chamado**, representada por um símbolo de `⚙️`.  
3. O sistema exibe um formulário com 4 etapas a serem configuradas.  
4. O usuário seleciona, para cada etapa, o setor que será responsável.  
5. O usuário clica no botão **Salvar**.  
6. O sistema grava a configuração do fluxo no banco de dados.  
7. O sistema exibe mensagem de sucesso confirmando a operação.  

**Fluxos secundários:**  
- Caso o usuário não possua permissão de `Add` no model `Fluxo`:  
  - O sistema **não exibe a opção Configurar fluxo de chamado**.  
  - Se o usuário tentar acessar o formulário de criação de Fluxo de Chamado diretamente pela URL, o sistema retorna **erro HTTP 403 (Forbidden)**.  
- Caso o usuário tente salvar o fluxo sem selecionar setores para todas as etapas, o sistema retorna uma mensagem de erro informando que todas as etapas devem ser configuradas.  
- Caso ocorra uma falha de comunicação com o banco de dados, uma mensagem de erro é retornada para o usuário e a operação é cancelada.  

**Requisitos Não-Funcionais (RNF) vinculados:**  
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.  
- RNF_002: O sistema deve ter recursos de acessibilidade.  
- RNF_003: Campos obrigatórios devem estar identificados com um asterisco (*).  

## Dicionário de termos
| Termo | Descrição |
|-------|-----------|
| Fluxo de chamado | Conjunto de etapas definidas para o tratamento de um chamado, determinando quais setores são responsáveis em cada fase do processo. Cada fluxo possui exatamente 4 etapas, cada uma associada a um setor previamente cadastrado no sistema. |


## Dicionário de dados:  
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_FL.md](./DD_FL.md).  
