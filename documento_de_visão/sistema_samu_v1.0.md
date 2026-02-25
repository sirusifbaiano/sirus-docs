##  Sistema SAMU - Versão 1.0

### Documento de Visão

### **Descrição geral deste documento:**

Este documento descreve o cliente (bem como a problemática a ser automatizada com o sistema), os usuários do sistema, e também fornece uma visão geral do Sistema SAMU em sua versão 1.0.

### **1.1 Cliente:** 

O Serviço de Atendimento Móvel de Urgência (SAMU) do município de Guanambi-Bahia foi criado com o objetivo de fornecer um atendimento rápido e eficaz a situações de urgência e emergência em saúde.
O serviço de atendimento pré-hospitalar móvel é acionado pelo número telefônico gratuito 192, onde o usuário solicita assistência médica. Esse serviço é composto por dois componentes principais: a Central Médica de Regulação e as equipes assistenciais das ambulâncias.

Atualmente, os registros dos chamados e dos atendimentos da central de regulação médica do SAMU são feitos manualmente em formulários de papel, resultando na produção de dois documentos diferentes: um formulário que é preenchido no momento do chamado telefônico na central de regulação (formulário este chamado de Ficha Individual de Regulação Médica - Registro de Chamadas), e o outro que é preenchido pelos agentes socorristas durante o atendimento da ocorrência (formulário este chamado de Ficha de Atendimento Pré-hospitalar).

De modo geral, o atendimento começa com um processo conhecido como Receber Chamado, no qual o SAMU recebe um chamado através do número 192, chamado este que é atendido pelo Técnico Auxiliar de Regulação Médica (TARM). O TARM é responsável por coletar as informações iniciais da ocorrência e adicionar manualmente na Ficha Individual de Regulação Médica, por exemplo, a hora do chamado, o nome do solicitante, o local da ocorrência, a quantidade de vítimas, a queixa principal, entre outras informações relevantes. O TARM então encaminha a ligação para o Médico Regulador, bem como passa para ele a Ficha Individual de Regulação Médica, com algumas informações já preenchidas, dando início a um novo processo conhecido como Realizar Regulação. O Médico Regulador dá prosseguimento na coleta de mais informações e complementa o preenchimento da Ficha Individual de Regulação Médica.

De posse de todas as informações coletadas, o Médico Regulador realiza a avaliação da gravidade do caso e, com base nessa análise, determina o recurso mais apropriado a ser destinado ao local da ocorrência (seja uma unidade de suporte básico ou avançado) ou, quando pertinente, presta orientações médicas à distância. Além disso, acompanha a evolução do atendimento e define a unidade de saúde mais adequada para o encaminhamento do paciente, assegurando a continuidade e a eficácia da assistência.

Nos casos em que o Médico Regulador define que o atendimento de fato é de urgência, e que é necessário o uso de uma unidade de suporte, o Rádio Operador faz a liberação da unidade móvel, que pode ser destinada à equipe de socorristas local ou de outro município. Quando a ocorrência é destinada à equipe de socorristas local, o Rádio Operador entrega a Ficha Individual de Regulação Médica impressa da ocorrência diretamente à equipe que irá deslocar para o atendimento.

<!--[DÚVIDA] A Ficha Individual de Regulação Médica que o Rádio Operador entrega a equipe da unidade móvel é a mesma que o Médico Regulador preencheu? 
Fiquei com dúvida pois, quando a ocorrência é continuada, a equipe socorrista liga novamente para o Médico Regular passando informações que ao meu ver são registradas na Ficha Individual de Regulação Médica, então neste caso a ficha que o Rádio Operador entregou é uma cópia da ficha original que está com o Médico Regulador? -->

### **1.2 Grupos de usuários do sistema:** 

Para esta primeira versão do sistema, os grupos/perfis de usuários serão:
- Técnico Auxiliar de Regulação Médica (TARM)
- Médico Regulador
- Rádio Operador
- Equipe Assistencial
  
**Observações:**
  
 - Os grupos/perfis de usuários, serão cadastrados no sistema como Colaboradores.

 - As funcionalidades de cada grupo/perfil de usuário, passará pela concessão de permissão (ou seja, se poderá adicionar, editar, excluir, visualizar ou detalhar) para cada setor.
  
### **1.3 Visão geral do Sistema SAMU - versão 1.0:**

 A versão 1.0 do Sistema do SAMU tem como principal objetivo a automatização de parte dos processos conhecidos como Receber Chamado e Realizar Regulação.
 
 #### Fluxo do Sistema SAMU em sua primeira versão: 

O TARM, o Médico Regulador, o Rádio Operador e a Equipe Assistencial, realizam login no sistema, acessando seus respectivos perfis.

Ao receber um chamado pelo 192, o TARM atende a ligação e preenche, via sistema, as informações da ocorrência, como a hora do chamado, o nome do solicitante, o local da ocorrência, a quantidade de vítimas, a queixa principal, entre outras informações relevantes. Ao finalizar o preenchimento das informações sob sua responsabilidade, o TARM encaminha a ligação para o Médico Regulador e, via sistema, ele também encaminha o fluxo para a etapa de Regulação. 

O Médico Regulador pode então conferir as informações de todos os chamados em sua tela, podendo escolher o chamado que preferir para dar andamento. O Médico Regulador consegue observar as informações já preenchidas pelo TARM e realizar as atualizações necessárias com base nas informações passadas a ele via telefone. O Médico Regulador realiza a avaliação da gravidade do caso e, com base nessa análise, determina o recurso mais apropriado selecionando, via sistema, a quantidade e tipo de unidade móvel que deseja liberar para o atendimento. O Médico Regulador encaminha a ligação para o Rádio Operador e via sistema ele também encaminha o fluxo para a etapa de Rádio. 

O Rádio Operador observa a solicitação designada pelo Médico Regulador podendo gerar a Ficha Individual de Regulação Médica, que apresentará um preenchimento automático de todas as informações descritas pelo TARM e pelo Médico Regulador. O sistema também permite gerar a Ficha de Atendimento Pré-hospitalar. O Rádio Operador poderá então liberar a saída da unidade móvel designada para a ocorrência.

A equipe assistencial recebe o chamado, podendo observar algumas informações no próprio sistema e também gerar o arquivo pdf da Ficha de Atendimento Pré-hospitalar. 

 #### **Observações:**
 > [!IMPORTANT]
>  **Observação 1:** Para que todo o fluxo de Receber Chamado e Realizar Regulação, descrito acima, ocorra, faz-se necessário o prévio cadastro das Bases de atendimento, dos Setores, dos Colaboradores, das Unidades (ou seja, da frota de ambulâncias e demais veículos), e por fim, das configurações de permissões para cada Colaborador em seus respectivos Setores.

> [!NOTE]
>  **Observação 2:** Nesta primeira versão, grande parte dos procedimentos são realizados pelo sistema, porém, ainda será necessária a impressão dos formulários para preenchimento manual complementar. A vantagem operacional do uso desta primeira versão é que boa parte dos dados serão preenchidos pelo TARM e pelo Médico Regulador por meio do sistema, sendo possível gerar os formulários parcialmente preenchidos. O preenchimento do formulário via sistema possibilita também a correção de erros de digitação de maneira mais prática, se comparado à versão impressa do formulário, evitando rasuras ou até mesmo a elaboração de uma nova ficha manualmente.
