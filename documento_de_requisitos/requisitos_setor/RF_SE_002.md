##  RF_ST_002: O sistema deve permitir listar Setores
**Descrição do caso de uso:** O sistema deve permitir visualizar a lista de todos os setores cadastrados, filtrados por base.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `View` no model `Setor`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável
      
**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou ser membro de um setor que tenha a permissão de `View` no model `Setor`.
- O usuário deve acessar o sistema através de uma base específica.
- Se o usuário for um Super Usuário, pode visualizar setores de qualquer base.
- Se o usuário não for Super Usuário, pode visualizar apenas setores das bases onde é responsável ou onde a central é responsável.
- O usuário deve ter acesso a pelo menos uma base para visualizar setores.

**Saídas e pós-condição:**
- O sistema exibe uma lista com todos os setores filtrados pela base atual.
- A lista mostra informações básicas de cada setor (nome, base vinculada, status ativo).
- O sistema oferece opções de ação para cada setor (visualizar, editar, excluir) baseadas nas permissões do usuário.
- A interface permite navegação para outras funcionalidades relacionadas aos setores.

**Fluxo de eventos principal:**
- O usuário acessa o menu principal do sistema.
- O usuário seleciona uma base específica (se aplicável).
- O usuário seleciona a opção "Setores" no menu da base.
- O sistema aplica os filtros de segurança baseados no usuário logado.
- O sistema recupera todos os setores vinculados à base atual.
- O sistema exibe a lista de setores em formato de tabela ou cards.
- O sistema apresenta as opções de ação disponíveis para cada setor.
- O usuário pode navegar pela lista ou selecionar ações específicas.

**Fluxos secundários:**
- Caso não existam setores cadastrados na base:
  - O sistema exibe uma mensagem informativa "Nenhum setor encontrado".
  - O sistema oferece a opção de cadastrar o primeiro setor (se o usuário tiver permissão).
- Caso o usuário não possua permissão de `View` no model `Setor`:
  - O sistema **não exibe a opção "Setores"** no menu da base.
  - Se o usuário tentar acessar a listagem diretamente pela URL, o sistema retorna **erro HTTP 403 (Forbidden)**.
- Caso ocorra erro na consulta ao banco de dados:
  - O sistema exibe uma mensagem de erro técnico.
  - O sistema registra o erro no log para análise.
- Caso o usuário não tenha acesso a nenhuma base:
  - O sistema exibe uma mensagem informando a falta de acesso.
  - O sistema redireciona para a página inicial ou de login.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.
- RNF_003: Todos os campos obrigatórios dos formulários do sistema devem ser identificados com um asterisco (*) imediatamente após o seu label.
- RNF_ST_003: O sistema deve validar se o usuário possui as permissões necessárias para executar operações CRUD em setores.
- RNF_ST_005: O sistema deve permitir acesso diferenciado: superusuários acessam todas as bases, usuários normais apenas bases onde são responsáveis.

## Dicionário de termos:
| Termo | Descrição |
|------|-----------|
| Setor | É uma unidade organizacional dentro de uma base do SAMU, responsável por agrupar profissionais com funções similares e definir suas permissões de acesso ao sistema. |
| Base | É um ponto de apoio estratégico para as equipes de socorristas, que fornece infraestrutura e suporte. As bases descentralizadas são pontos de apoio para as equipes e veículos, garantindo um atendimento mais rápido. |
| Filtro de Segurança | Mecanismo que restringe o acesso aos dados baseado nas permissões e hierarquia do usuário logado. |
| Status Ativo | Campo booleano que indica se o setor está ativo (true) ou inativo (false) no sistema. |

## Dicionário de dados:
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_ST.md](./DD_ST.md).