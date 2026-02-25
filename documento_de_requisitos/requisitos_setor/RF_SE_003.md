##  RF_ST_003: O sistema deve permitir detalhar Setor
**Descrição do caso de uso:** O sistema deve permitir acessar e visualizar os detalhes completos de um setor cadastrado.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `View` no model `Setor` ou permissão específica `detail_setor`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável
      
**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou ser membro de um setor que tenha a permissão de `View` no model `Setor` ou a permissão específica `detail_setor`.
- O setor a ser detalhado deve existir no sistema.
- O usuário deve ter acesso à base onde o setor está vinculado.
- Se o usuário não for Super Usuário, pode visualizar apenas setores de bases onde é responsável ou onde a central é responsável.
- O ID do setor deve ser válido e corresponder a um registro existente.

**Saídas e pós-condição:**
- O sistema exibe todos os detalhes do setor selecionado.
- São mostradas informações como: nome, base vinculada, membros associados, permissões definidas, status ativo, data de criação e usuário criador.
- O sistema apresenta opções de ação disponíveis (editar, excluir) baseadas nas permissões do usuário.
- A interface permite navegação de volta para a listagem ou para outras funcionalidades.

**Fluxo de eventos principal:**
- O usuário acessa a listagem de setores de uma base.
- O usuário seleciona um setor específico para visualizar os detalhes.
- O sistema valida as permissões do usuário para o setor selecionado.
- O sistema recupera todas as informações do setor do banco de dados.
- O sistema exibe uma página com os detalhes completos do setor.
- O sistema apresenta os membros associados ao setor.
- O sistema mostra as permissões definidas para o setor de forma traduzida.
- O usuário pode navegar para outras ações ou voltar à listagem.

**Fluxos secundários:**
- Caso o setor não seja encontrado:
  - O sistema exibe uma mensagem de erro "Setor não encontrado".
  - O sistema redireciona para a listagem de setores.
- Caso o usuário não possua permissão para visualizar o setor:
  - O sistema retorna **erro HTTP 403 (Forbidden)**.
  - Uma mensagem de acesso negado é exibida.
- Caso o usuário não tenha acesso à base do setor:
  - O sistema retorna **erro HTTP 404 (Not Found)**.
  - O sistema redireciona para uma página de erro ou listagem válida.
- Caso ocorra erro na consulta ao banco de dados:
  - O sistema exibe uma mensagem de erro técnico.
  - O sistema registra o erro no log para análise.
  - O usuário é redirecionado para a página anterior.

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
| Permissão detail_setor | Permissão específica do modelo Setor que permite visualizar detalhes completos de um setor. |
| Membros Associados | Usuários do sistema que foram vinculados ao setor e herdam suas permissões. |
| Permissões Traduzidas | Interface que converte as permissões técnicas do Django para termos em português brasileiro mais amigáveis ao usuário. |

## Dicionário de dados:
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_ST.md](./DD_ST.md).