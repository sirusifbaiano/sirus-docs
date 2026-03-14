##  RF_CO_001: O sistema deve permitir cadastrar Colaboradores
**Descrição do caso de uso:** O sistema deve permitir criar uma novo colaborador.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Add` no model `Pessoa` e que possuam um Token.

**Prioridade:**   [x] Essencial       [ ] Importante       [ ] Desejável
      
**Entradas e pré-condições:**
- É necessário existir [base](../requisitos_base/DD_BA.md) criadas
- É necessário existir [setores](../requisitos_setor//DD_BA.md) criados para a base ou sub-bases da base em que o usuário que está realizando a operação.
- É necessário que o usuário que irá realizar a operação, possua um Token, token esse que é fornecido pelo administrador do sistema.
- O usuário deve ser membro de um setor que tenha a permissão de `Add` no model `Pessoa` ou deve ser um super usuário.
- As opções acessíveis no campo 'setores' devem ser APENAS setores da base atual e setores de base que têm a base atual como central.


**Saídas e pós-condição:**
- O sistema retorna uma mensagem informando o resultado da operação.

**Fluxo de eventos principal:**
- O usuário seleciona a opção Colaboradores no menu do sistema.
- O usuário seleciona a opção Adicionar novo Colaborador, representada por um símbolo de ` + `.
- O sistema oferece o formulário de criação da novo colaborador.
- O usuário entra com os dados do colaborador.
- O usuário clica no botão Salvar.
- O sistema insere os dados submetidos no banco de dados.
- O sistema retorna para o usuário uma mensagem informando que o colaborar foi criada com sucesso.

**Fluxos secundários:**
- Caso já exista uma pessoa com o CPF fornecido:
  - O sistema deverá autocompletar os campos do formulário com os dados da pessoa, ao salvar, a pessoa será atualizada com as novas informações.
- Caso ocorra uma falha de comunicação com o banco de dados, uma mensagem de erro é retornada para o usuário e a operação é cancelada.
- Caso o usuário não possua permissão de `Add` no model `Pessoa`:
  - O sistema **não exibe a opção de adicionar novo Colaborador** (símbolo `+`) na interface.
  - Se o usuário tentar acessar o formulário de criação de Colaborador diretamente pela URL, o sistema retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.
- RNF_003: Todos os campos obrigatórios dos formulários do sistema devem ser identificados com um asterisco (*) imediatamente após o seu label.


## Dicionário de termos:
| Termo | Descrição |
|------|-----------|
| Colaborador | Colaborador é uma pessoa que possui acesso ao sistema, e está associada a algum setor  |
| Base | É um ponto de apoio estratégico para as equipes de socorristas, que fornece infraestrutura e suporte. As bases descentralizadas são pontos de apoio para as equipes e veículos, garantindo um atendimento mais rápido. |
| Base central | É o centro de controle e coordenação de todas as atividades do SAMU naquela região. A base centralizada possui a estrutura para a Central de Regulação de Urgências (CRU), onde o atendimento é planejado. |

## Dicionário de dados:
Para detalhes sobre campos e estrutura de dados, consulte os arquivos [DD_CO.md](./DD_CO.md) para os campos de colaboradores e
[DD_PE.md](../requisitos_pessoa/DD_PE.md) para os campos herdados de Pessoa.