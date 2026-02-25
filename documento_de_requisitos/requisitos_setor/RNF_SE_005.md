## RNF_ST_005: O sistema deve implementar controle de acesso hierárquico
**Descrição do requisito:** O sistema deve permitir acesso diferenciado: superusuários acessam todas as bases, usuários normais apenas bases onde são responsáveis.

**Prioridade:** [x] Essencial  [ ] Importante  [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve estar logado no sistema.
- O usuário deve tentar acessar funcionalidades de setores.
- O sistema deve ter bases cadastradas com responsáveis definidos.

**Saídas e pós-condição:**
- Super usuários visualizam todos os setores de todas as bases.
- Usuários normais visualizam apenas setores de bases onde são responsáveis.
- Tentativas de acesso não autorizado retornam erro 404.

**Fluxo de eventos principal:**
- O usuário tenta acessar funcionalidades de setores (listar, detalhar, editar, excluir).
- O sistema verifica se o usuário é superusuário.
- Se for superusuário, remove restrições de acesso.
- Se não for superusuário, aplica filtros baseados nas bases onde é responsável.
- O sistema exibe apenas setores das bases autorizadas.

**Fluxos secundários:**
- Caso o usuário não seja responsável por nenhuma base, uma mensagem informativa é exibida.
- Tentativas de acesso direto a setores não autorizados retornam erro 404.
- Logs de acesso são registrados para auditoria.

**RFs vinculados:**
- [RF_ST_002](./RF_ST_002.md), [RF_ST_003](./RF_ST_003.md), [RF_ST_004](./RF_ST_004.md), [RF_ST_005](./RF_ST_005.md)
| Termo | Descrição |
|------|-----------|
| Hierarquia de Acesso | Sistema que define diferentes níveis de permissão baseado no papel do usuário. |
| Super Usuário | Usuário com privilégios administrativos máximos, sem restrições de acesso. |
| Base Central | Base que serve como centro de controle para outras bases descentralizadas. |
| Filtro Q | Objeto do Django para construir consultas complexas com operadores lógicos. |
| Edge Case | Situação incomum ou limite que pode não ser coberta pelo fluxo normal do sistema. |