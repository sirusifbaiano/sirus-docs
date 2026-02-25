## RF_BA_004: O sistema deve permitir atuar na terceira fase do Chamado

**Descrição do caso de uso:**  
O sistema deve permitir ao usuário atuar na terceira fase do chamado, conforme o fluxo configurado.

**Ator(es):**  
Usuários pertencentes ao setor relacionado à terceira etapa do fluxo de chamado.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- É necessário que haja [**Fluxo de chamado**](./../requisitos_fluxo/readme.md) configurado para a base atual ou para a base central, conforme [RF_FL_001](./../requisitos_fluxo/RF_FL_001.md).
- O chamado deve ter passado pelas etapas anteriores:
  - [Criado](./RF_CH_002.md) e [encaminhado](./RF_CH_008.md) na [primeira](./RF_CH_002.md) etapa.
  - [Recebido](./RF_CH_007.md) e [encaminhado](./RF_CH_008.md) na [segunda](./RF_CH_003.md) etapa.
- O usuário deve pertencer ao setor relacionado à terceira etapa do fluxo.

**Saídas e pós-condição:**
- O chamado é encaminhado para o próximo setor configurado no fluxo.
- O sistema retorna uma mensagem informando o resultado da operação.

**Fluxo de eventos principal:**
- O usuário seleciona a opção **Chamados** no menu do sistema.
- O usuário seleciona a opção **Receber chamado no setor** na linha do chamado em que se deseja atuar, representada por um símbolo de arquivo com seta para baixo.
- O sistema exibe o formulário da terceira etapa do chamado, apresentando as unidades disponíveis e seus respectivos status para seleção e acompanhamento.
- O usuário preenche os campos necessários do chamado.
- O usuário clica no botão [**Encaminhar**](./RF_CH_008.md).
- O sistema insere os dados submetidos no banco de dados.
- O sistema retorna para o usuário uma mensagem informando que o chamado foi encaminhado para o próximo setor com sucesso.

**Fluxos secundários:**
- Caso ocorra uma falha de comunicação com o banco de dados, uma mensagem de erro é retornada para o usuário e a operação é cancelada.
- Caso o usuário não seja membro do setor relacionado à terceira etapa do fluxo de chamado:
  - O sistema abre o formulário, mas **não permite salvar** na interface.
  - Se o usuário tentar salvar o formulário por outros meios, o sistema retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.
- RNF_003: Todos os campos obrigatórios dos formulários do sistema devem ser identificados com um asterisco (*) imediatamente após o seu label.

---

## Dicionário de termos
| Termo | Descrição |
|--------|------------|
| Base | Ponto de apoio estratégico para as equipes de socorristas, que fornece infraestrutura e suporte. As bases descentralizadas são pontos de apoio para as equipes e veículos, garantindo um atendimento mais rápido. |
| Base central | Centro de controle e coordenação de todas as atividades do SAMU na região. A base centralizada possui a estrutura para a Central de Regulação de Urgências (CRU), onde o atendimento é planejado. |

## Dicionário de dados
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_CH.md](./DD_CH.md).
