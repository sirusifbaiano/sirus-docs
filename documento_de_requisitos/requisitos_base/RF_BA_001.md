##  RF_BA_001: O sistema deve permitir cadastrar Base
**Descrição do caso de uso:** O sistema deve permitir criar uma nova base.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Add` no model `Base`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável
      
**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou ser membro de um setor que tenha a permissão de `Add` no model `Base`.
- O usuário só pode associar como central daquela nova base, bases já existentes.
- As opções acessíveis no campo 'Base central' devem ser APENAS aquelas bases que o usuário logado é o responsável.
- Se o usuário for um Super Usuário, ele poderá associar qualquer base como central.

**Saídas e pós-condição:**
- O sistema retorna uma mensagem informando o resultado da operação.

**Fluxo de eventos principal:**
- O usuário seleciona a opção Base de atendimento no menu do sistema.
- O usuário seleciona a opção Adicionar nova base, representada por um símbolo de ` + `.
- O sistema oferece o formulário de criação da nova Base.
- O usuário entra com os dados da Base.
- O usuário clica no botão Salvar.
- O sistema insere os dados submetidos no banco de dados.
- O sistema retorna para o usuário uma mensagem informando que a base de atendimento foi criada com sucesso.

**Fluxos secundários:**
- Caso ocorra uma falha de comunicação com o banco de dados, uma mensagem de erro é retornada para o usuário e a operação é cancelada.
- Caso o usuário não possua permissão de `Add` no model `Base`:
  - O sistema **não exibe a opção de adicionar nova Base** (símbolo `+`) na interface.
  - Se o usuário tentar acessar o formulário de criação de Base diretamente pela URL, o sistema retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.
- RNF_003: Todos os campos obrigatórios dos formulários do sistema devem ser identificados com um asterisco (*) imediatamente após o seu label.


## Dicionário de termos:
| Termo | Descrição |
|------|-----------|
| Base | É um ponto de apoio estratégico para as equipes de socorristas, que fornece infraestrutura e suporte. As bases descentralizadas são pontos de apoio para as equipes e veículos, garantindo um atendimento mais rápido. |
| Base central | É o centro de controle e coordenação de todas as atividades do SAMU naquela região. A base centralizada possui a estrutura para a Central de Regulação de Urgências (CRU), onde o atendimento é planejado. |

## Dicionário de dados:
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_BA.md](./DD_BA.md).