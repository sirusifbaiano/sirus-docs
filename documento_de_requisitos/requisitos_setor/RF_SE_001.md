##  RF_ST_001: O sistema deve permitir cadastrar Setor
**Descrição do caso de uso:** O sistema deve permitir criar um novo setor vinculado a uma base específica.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Add` no model `Setor`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável
      
**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou ser membro de um setor que tenha a permissão de `Add` no model `Setor`.
- O usuário deve selecionar uma base válida para vincular o setor.
- Se o usuário for um Super Usuário, ele pode associar o setor a qualquer base existente.
- Se o usuário não for Super Usuário, ele pode associar o setor apenas às bases onde é responsável ou onde a central é responsável.
- O setor deve ter um nome único dentro da base selecionada.
- Os membros disponíveis para seleção devem ser filtrados pela base de cadastro do usuário.

**Saídas e pós-condição:**
- O sistema retorna uma mensagem informando o resultado da operação.
- O setor é automaticamente criado como um grupo no sistema de permissões do Django.
- Os membros selecionados são automaticamente adicionados ao grupo correspondente.
- O sistema registra automaticamente quem criou o setor e quando foi criado.

**Fluxo de eventos principal:**
- O usuário acessa o menu de setores de uma base específica.
- O usuário seleciona a opção Adicionar novo setor, representada por um símbolo de ` + `.
- O sistema oferece o formulário de criação do novo Setor.
- O sistema pré-preenche o campo base com a base atual.
- O sistema exibe apenas os membros válidos baseados na base selecionada.
- O usuário entra com os dados do Setor (nome, membros, permissões).
- O usuário clica no botão Salvar.
- O sistema valida os dados submetidos.
- O sistema insere os dados no banco de dados.
- O sistema sincroniza automaticamente o setor com o sistema de grupos.
- O sistema retorna uma mensagem informando que o setor foi criado com sucesso.

**Fluxos secundários:**
- Caso ocorra uma falha de comunicação com o banco de dados, uma mensagem de erro é retornada para o usuário e a operação é cancelada.
- Caso o usuário não possua permissão de `Add` no model `Setor`:
  - O sistema **não exibe a opção de adicionar novo Setor** (símbolo `+`) na interface.
  - Se o usuário tentar acessar o formulário de criação de Setor diretamente pela URL, o sistema retorna **erro HTTP 403 (Forbidden)**.
- Caso o nome do setor já exista na base selecionada:
  - O sistema exibe uma mensagem de erro informando que o nome já está em uso.
  - O formulário permanece preenchido para correção.
- Caso a sincronização com o sistema de grupos falhe:
  - O sistema tenta reprocessar a sincronização automaticamente.
  - Se a falha persistir, registra o erro no log do sistema.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.
- RNF_003: Todos os campos obrigatórios dos formulários do sistema devem ser identificados com um asterisco (*) imediatamente após o seu label.
- RNF_ST_001: O sistema deve automaticamente sincronizar o setor com o sistema de grupos do Django para controle de permissões.
- RNF_ST_002: O sistema deve registrar automaticamente quem criou o setor e quando foi criado.
- RNF_ST_003: O sistema deve validar se o usuário possui as permissões necessárias para executar operações CRUD em setores.
- RNF_ST_004: O sistema deve filtrar os membros disponíveis para um setor baseado na base de cadastro do usuário.
- RNF_ST_005: O sistema deve permitir acesso diferenciado: superusuários acessam todas as bases, usuários normais apenas bases onde são responsáveis.

## Dicionário de termos:
| Termo | Descrição |
|------|-----------|
| Setor | É uma unidade organizacional dentro de uma base do SAMU, responsável por agrupar profissionais com funções similares e definir suas permissões de acesso ao sistema. |
| Base | É um ponto de apoio estratégico para as equipes de socorristas, que fornece infraestrutura e suporte. As bases descentralizadas são pontos de apoio para as equipes e veículos, garantindo um atendimento mais rápido. |
| Grupo Django | Sistema nativo do Django para gerenciamento de permissões, onde cada setor é automaticamente mapeado como um grupo. |
| Membro | Usuário do sistema que pode ser associado a um ou mais setores, herdando as permissões definidas para esses setores. |

## Dicionário de dados:
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_ST.md](./DD_ST.md).