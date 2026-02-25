## RF_CH_006: O sistema deve permitir encerrar Chamado

**Descrição do caso de uso:** O sistema deve permitir que o **Médico Regulador** encerre um Chamado, registrando o motivo/justificativa de encerramento, em dois momentos específicos do fluxo.

**Ator(es):** **Médico Regulador** e/ou membros de setores que tenham permissão de \`Editar\` no model \`Chamado\`.

**Prioridade:** \[x] Essencial \[ ] Importante \[ ] Desejável

**Entradas e pré-condições:**
* O usuário deve ser um **Médico Regulador** ou membro de setor que tenha permissão de \`Editar\` no model \`Chamado\`.
* O chamado deve estar na fase 2 (Regulação) ou fase 4 (Equipe de Campo).

**Saídas e pós-condição:**
* O status do Chamado é alterado para "Encerrado".
* O sistema registra a **Justificativa de Encerramento** e as informações adicionais (se aplicável).
* O chamado não pode mais ter seu fluxo alterado ou ser editado.

**Fluxo de eventos principal:**
1.  O usuário seleciona a opção `Atuar em chamado` na linha do chamado em que se deseja atuar, representado por um símbolo de uma tela de computador.
2.  O sistema verifica se o Chamado está na **fase 2 (Regulação)** ou **fase 4 (Equipe de Campo)**.
3.  O usuário seleciona a opção "Encerrar Chamado" (ou equivalente).
4.  O sistema exibe o formulário de encerramento, exigindo o preenchimento do campo **Justificativa de Encerramento**.
5.  **Se o chamado estiver na fase 4 (Equipe de Campo):** O sistema apresenta os campos opcionais "**Apoio solicitado**", "**Incidente**" e "**Orientação/Conduta Final**" para preenchimento. Ainda, ele só poderá atuar neste momento se o chamado já tiver sido recebido naquela etapa.
6.  O Médico Regulador confirma o encerramento.
7.  O sistema atualiza o status do Chamado para "Encerrado".

**Fluxos secundários:**
* **Caso o chamado não esteja nas fases permitidas (2 ou 4):** O sistema **não exibe** a opção "Encerrar Chamado" ou, se a tentativa ocorrer via API, retorna uma mensagem de erro indicando que a ação não é permitida para o estado atual do chamado.
* **Caso o usuário não possua permissão de \`Editar\` no model \`Chamado\`:** O sistema não exibe a opção de encerramento.
* **Caso o campo **Justificativa de Encerramento** não seja preenchido:** O sistema exibe uma mensagem de erro e impede a conclusão da ação.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.
- RNF_003: Todos os campos obrigatórios dos formulários do sistema devem ser identificados com um asterisco (*) imediatamente após o seu label.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo \[DD\_CH.md](./DD_CH.md).