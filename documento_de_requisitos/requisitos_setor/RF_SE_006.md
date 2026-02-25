##  RF_ST_006: O sistema deve permitir gerenciar Membros do Setor
**Descrição do caso de uso:** O sistema deve permitir adicionar e remover membros (usuários) de um setor específico.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Change` no model `Setor`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável
      
**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou ser membro de um setor que tenha a permissão de `Change` no model `Setor`.
- O setor deve existir no sistema e estar ativo.
- O usuário deve ter acesso à base onde o setor está vinculado.
- Os membros disponíveis para seleção devem estar cadastrados na mesma base do setor.
- Os usuários devem ter perfil ativo no sistema.
- Se o usuário não for Super Usuário, pode gerenciar apenas setores de bases onde é responsável.

**Saídas e pós-condição:**
- O sistema retorna uma mensagem informando o resultado da operação.
- Os membros são adicionados ou removidos do setor conforme solicitado.
- O sistema automaticamente sincroniza os membros com o grupo correspondente no Django.
- Os usuários ganham ou perdem as permissões associadas ao setor.
- O histórico de auditoria do setor é preservado.

**Fluxo de eventos principal:**
- O usuário acessa a funcionalidade de edição de um setor específico.
- O sistema apresenta o formulário com a lista atual de membros do setor.
- O sistema filtra e exibe apenas usuários válidos baseados na base do setor.
- O usuário seleciona ou deseleciona membros conforme necessário.
- O sistema traduz as permissões para exibição amigável ao usuário.
- O usuário clica no botão "Salvar".
- O sistema valida as alterações nos membros.
- O sistema atualiza os relacionamentos Many-to-Many no banco de dados.
- O sistema executa automaticamente a sincronização com grupos Django.
- O sistema retorna uma mensagem de sucesso.

**Fluxos secundários:**
- Caso o setor não seja encontrado ou esteja inativo:
  - O sistema exibe uma mensagem de erro apropriada.
  - O sistema redireciona para a listagem de setores.
- Caso o usuário não possua permissão para alterar membros:
  - O sistema **não exibe os campos de seleção de membros** como editáveis.
  - Se tentativa direta via URL, o sistema retorna **erro HTTP 403 (Forbidden)**.
- Caso um usuário selecionado não seja válido para a base:
  - O sistema filtra automaticamente usuários inválidos.
  - Uma mensagem de aviso é exibida sobre usuários removidos da seleção.
- Caso a sincronização com grupos Django falhe:
  - O sistema tenta reprocessar automaticamente via signals.
  - Se persistir a falha, registra no log mas mantém as alterações no setor.
- Caso ocorra erro na atualização dos relacionamentos:
  - O sistema reverte todas as alterações.
  - Uma mensagem de erro técnico é exibida.
  - O estado anterior é restaurado.

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
| Membro | Usuário do sistema que pode ser associado a um ou mais setores, herdando as permissões definidas para esses setores. |
| Setor | É uma unidade organizacional dentro de uma base do SAMU, responsável por agrupar profissionais com funções similares e definir suas permissões de acesso ao sistema. |
| Sincronização de Grupos | Processo automático que mantém os usuários do setor sincronizados com o grupo correspondente no sistema de permissões do Django. |
| Relacionamento Many-to-Many | Permite que um usuário pertença a vários setores e um setor tenha vários usuários. |
| Signal | Mecanismo do Django que executa código automaticamente quando certas ações ocorrem (como alteração de membros). |

## Dicionário de dados:
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_ST.md](./DD_ST.md).