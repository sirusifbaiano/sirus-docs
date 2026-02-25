## RNF_ST_001: O sistema deve sincronizar automaticamente setores com grupos Django
**Descrição do requisito:** O sistema deve automaticamente sincronizar o setor com o sistema de grupos do Django para controle de permissões.

**Prioridade:** [x] Essencial  [ ] Importante  [ ] Desejável

**Entradas e pré-condições:**
- O setor deve estar sendo criado, editado ou ter membros/permissões alterados.
- O Django deve estar com sistema de autenticação e permissões funcionando.

**Saídas e pós-condição:**
- O grupo correspondente no Django é criado/atualizado automaticamente.
- Membros do setor são sincronizados com o grupo.
- Permissões do setor são sincronizadas com o grupo.

**Fluxo de eventos principal:**
- O usuário executa uma operação CRUD em setores (criar, editar, excluir, alterar membros ou permissões).
- O sistema executa automaticamente a sincronização através de Django signals.
- O grupo correspondente é criado/atualizado no sistema de permissões do Django.
- A sincronização ocorre de forma transparente ao usuário.

**Fluxos secundários:**
- Caso ocorra falha na sincronização, o sistema deve tentar reprocessar automaticamente.
- Se a falha persistir, deve registrar o erro no log do sistema.

**RFs vinculados:**
- [RF_ST_001](./RF_ST_001.md), [RF_ST_004](./RF_ST_004.md), [RF_ST_005](./RF_ST_005.md), [RF_ST_006](./RF_ST_006.md), [RF_ST_007](./RF_ST_007.md)