##  RF_ST_004: O sistema deve permitir editar Setor
**Descrição do caso de uso:** O sistema deve permitir alterar os dados de um setor previamente cadastrado.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Change` no model `Setor`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável
      
**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou ser membro de um setor que tenha a permissão de `Change` no model `Setor`.
- O setor a ser editado deve existir no sistema.
- O usuário deve ter acesso à base onde o setor está vinculado.
- Se o usuário não for Super Usuário, pode editar apenas setores de bases onde é responsável ou onde a central é responsável.
- O ID do setor deve ser válido e corresponder a um registro existente.
- Os novos dados devem ser válidos conforme as regras de negócio.
- O nome do setor deve ser único dentro da base selecionada.

**Saídas e pós-condição:**
- O sistema retorna uma mensagem informando o resultado da operação.
- As alterações são persistidas no banco de dados.
- O sistema sincroniza automaticamente as mudanças com o sistema de grupos do Django.
- Os membros são atualizados no grupo correspondente conforme as alterações.
- O histórico de auditoria é mantido (criado_por e criado_em permanecem inalterados).

**Fluxo de eventos principal:**
- O usuário acessa a listagem de setores ou detalhes de um setor específico.
- O usuário seleciona a opção "Editar" para o setor desejado.
- O sistema valida as permissões do usuário para edição.
- O sistema apresenta o formulário preenchido com os dados atuais do setor.
- O sistema pré-seleciona a base atual e filtra os membros disponíveis.
- O usuário modifica os dados necessários (nome, membros, permissões, status).
- O usuário clica no botão "Salvar".
- O sistema valida os dados modificados.
- O sistema atualiza os dados no banco de dados.
- O sistema sincroniza automaticamente o setor com o sistema de grupos.
- O sistema retorna uma mensagem de sucesso e redireciona para a listagem.

**Fluxos secundários:**
- Caso o setor não seja encontrado:
  - O sistema exibe uma mensagem de erro "Setor não encontrado".
  - O sistema redireciona para a listagem de setores.
- Caso o usuário não possua permissão de `Change` no model `Setor`:
  - O sistema **não exibe a opção "Editar"** na interface.
  - Se o usuário tentar acessar o formulário de edição diretamente pela URL, o sistema retorna **erro HTTP 403 (Forbidden)**.
- Caso o nome do setor já exista na base (exceto o próprio setor):
  - O sistema exibe uma mensagem de erro informando que o nome já está em uso.
  - O formulário permanece preenchido para correção.
- Caso ocorra falha na validação dos dados:
  - O sistema exibe mensagens de erro específicas para cada campo.
  - O formulário permanece preenchido com os dados inseridos.
- Caso a sincronização com o sistema de grupos falhe:
  - O sistema tenta reprocessar a sincronização automaticamente.
  - Se a falha persistir, registra o erro no log do sistema.
- Caso ocorra erro na atualização do banco de dados:
  - O sistema exibe uma mensagem de erro técnico.
  - A operação é cancelada e nenhuma alteração é persistida.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.
- RNF_003: Todos os campos obrigatórios dos formulários do sistema devem ser identificados com um asterisco (*) imediatamente após o seu label.
- RNF_ST_001: O sistema deve automaticamente sincronizar o setor com o sistema de grupos do Django para controle de permissões.
- RNF_ST_003: O sistema deve validar se o usuário possui as permissões necessárias para executar operações CRUD em setores.
- RNF_ST_004: O sistema deve filtrar os membros disponíveis para um setor baseado na base de cadastro do usuário.
- RNF_ST_005: O sistema deve permitir acesso diferenciado: superusuários acessam todas as bases, usuários normais apenas bases onde são responsáveis.

## Dicionário de termos:
| Termo | Descrição |
|------|-----------|
| Setor | É uma unidade organizacional dentro de uma base do SAMU, responsável por agrupar profissionais com funções similares e definir suas permissões de acesso ao sistema. |
| Base | É um ponto de apoio estratégico para as equipes de socorristas, que fornece infraestrutura e suporte. As bases descentralizadas são pontos de apoio para as equipes e veículos, garantindo um atendimento mais rápido. |
| Sincronização de Grupos | Processo automático que mantém a consistência entre o setor e o grupo correspondente no sistema de permissões do Django. |
| Auditoria | Registro automático de informações sobre quem criou o setor e quando, que deve ser preservado durante edições. |

## Dicionário de dados:
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_ST.md](./DD_ST.md).