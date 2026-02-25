## RNF_ST_003: O sistema deve validar permissões para operações CRUD em setores
**Descrição do requisito:** O sistema deve validar se o usuário possui as permissões necessárias para executar operações CRUD em setores.

**Prioridade:** [x] Essencial  [ ] Importante  [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve estar logado no sistema.
- O usuário deve tentar executar uma operação CRUD em setores.
- O sistema de permissões do Django deve estar funcionando.

**Saídas e pós-condição:**
- Usuários com permissão adequada conseguem executar a operação.
- Usuários sem permissão recebem erro HTTP 403 (Forbidden).
- A interface exibe apenas opções disponíveis para o nível de acesso do usuário.

**Fluxo de eventos principal:**
- O usuário tenta executar uma operação CRUD em setores (listar, criar, editar, excluir, detalhar).
- O sistema valida automaticamente as permissões através de decorators.
- Se o usuário possui a permissão necessária, a operação é executada.
- Se o usuário não possui permissão, o sistema retorna erro HTTP 403.

**Fluxos secundários:**
- Caso o usuário não esteja logado, o sistema retorna HTTP 401 e redireciona para login.
- Tentativas de acesso não autorizado são registradas no log do sistema.
- Super usuários têm acesso total independente de permissões específicas.

**RFs vinculados:**
- [RF_ST_001](./RF_ST_001.md), [RF_ST_002](./RF_ST_002.md), [RF_ST_003](./RF_ST_003.md), [RF_ST_004](./RF_ST_004.md), [RF_ST_005](./RF_ST_005.md), [RF_ST_006](./RF_ST_006.md), [RF_ST_007](./RF_ST_007.md), [RF_ST_008](./RF_ST_008.md)
| Termo | Descrição |
|------|-----------|
| CRUD | Operações básicas: Create (Criar), Read (Ler), Update (Atualizar), Delete (Excluir). |
| Permission Required | Decorator do Django que valida se o usuário possui uma permissão específica. |
| HTTP 403 Forbidden | Código de status que indica que o servidor entendeu a requisição mas recusa autorizar. |
| Escalação de Privilégios | Tentativa de obter permissões mais altas do que as originalmente concedidas. |
| Middleware | Componente que processa requisições antes que cheguem às views. |