##  RF_UND_001: O sistema deve permitir cadastrar Unidade
**Descrição do caso de uso:** O sistema deve permitir criar uma nova unidade.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Add` no model `Unidade`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável
      
**Entradas e pré-condições:**
- Deve haver uma Base previamente cadastrada.
- O usuário entra com os dados da Unidade no formulário de cadastro.

**Saídas e pós-condição:**
- O sistema retorna uma mensagem informando o resultado da operação.

**Fluxo de eventos principal:**
- O usuário seleciona a opção Unidade no menu do sistema.
- O usuário seleciona a opção Adicionar nova unidade, representada por um símbolo de (+).
- O sistema oferece o formulário de criação da nova Unidade.
- O usuário entra com os dados da Unidade.
- O usuário clica no botão Salvar.
- O sistema insere os dados submetidos no banco de dados.
- O sistema retorna para o usuário uma mensagem informando que a Unidade foi criada com sucesso.

**Fluxos secundários:**
- Caso ocorra uma falha de comunicação com o banco de dados, uma mensagem de erro é retornada para o usuário e a operação é cancelada.
- Caso o usuário não possua permissão de `Add` no model `Unidade`:
  - O sistema **não exibe a opção de adicionar nova Unidade** (símbolo `+`) na interface.
  - Se o usuário tentar acessar o formulário de criação de Unidade diretamente pela URL, o sistema retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.
- RNF_003: Todos os campos obrigatórios dos formulários do sistema devem ser identificados com um asterisco (*) imediatamente após o seu label.


## Dicionário de termos:
| Termo | Descrição |
|------|-----------|
| Unidade | É o recurso operacional do SAMU responsável por realizar o atendimento direto às ocorrências. Pode ser composta por diferentes tipos de veículos (como ambulâncias de suporte básico ou avançado e motolâncias), equipados e tripulados conforme a gravidade do chamado, garantindo o deslocamento até o paciente e o transporte adequado até o serviço de saúde. |

## Dicionário de dados:
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_UND.md](./DD_UND.md).