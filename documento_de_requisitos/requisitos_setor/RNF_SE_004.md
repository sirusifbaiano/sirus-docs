## RNF_ST_004: O sistema deve filtrar membros por base no setor
**Descrição do requisito:** O sistema deve filtrar os membros disponíveis para um setor baseado na base de cadastro do usuário.

**Prioridade:** [x] Essencial  [ ] Importante  [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve estar criando ou editando um setor.
- Uma base deve estar selecionada para o setor.
- Devem existir usuários cadastrados no sistema vinculados a bases.

**Saídas e pós-condição:**
- Apenas usuários cadastrados na mesma base do setor aparecem na lista de membros disponíveis.
- Usuários de outras bases não são selecionáveis.
- A validação impede associação de membros inválidos.

**Fluxo de eventos principal:**
- O usuário acessa o formulário de criação ou edição de setor.
- O sistema identifica a base selecionada para o setor.
- O sistema filtra automaticamente os usuários disponíveis baseado na base.
- Apenas usuários vinculados à mesma base são exibidos na lista de membros.
- O sistema valida a seleção antes de salvar o setor.

**Fluxos secundários:**
- Caso não existam usuários válidos para a base, o campo de membros permanece vazio.
- Se a base do setor for alterada, a lista de membros é atualizada automaticamente.
- Tentativas de associar usuários inválidos são rejeitadas pelo sistema.

**RFs vinculados:**
- [RF_ST_001](./RF_ST_001.md), [RF_ST_004](./RF_ST_004.md), [RF_ST_006](./RF_ST_006.md)
| Termo | Descrição |
|------|-----------|
| Filtro Dinâmico | Mecanismo que ajusta automaticamente as opções disponíveis baseado em outros critérios. |
| Base de Cadastro | Base onde o usuário foi originalmente registrado no sistema. |
| Queryset | Objeto do Django que representa uma consulta ao banco de dados. |
| Values_list | Método que retorna apenas valores específicos de uma consulta, não objetos completos. |
| Select_related | Otimização que inclui dados relacionados na consulta original. |