## RNF_ST_002: O sistema deve registrar auditoria de criação de setores
**Descrição do requisito:** O sistema deve registrar automaticamente quem criou o setor e quando foi criado.

**Prioridade:** [x] Essencial  [ ] Importante  [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve estar logado e executando a operação de criar setor.
- O sistema deve ter configuração correta de timezone.

**Saídas e pós-condição:**
- O setor é criado com campos de auditoria preenchidos automaticamente (data/hora e usuário criador).
- Os dados de auditoria ficam visíveis na interface de detalhes do setor.
- Os campos de auditoria permanecem inalterados durante edições posteriores.

**Fluxo de eventos principal:**
- O usuário executa a operação de criar um novo setor.
- O sistema preenche automaticamente o campo `criado_em` com timestamp atual.
- O sistema preenche automaticamente o campo `criado_por` com o usuário logado.
- O setor é salvo no banco de dados com as informações de auditoria.
- Os dados de auditoria são exibidos na interface de detalhes.

**Fluxos secundários:**
- Caso não seja possível identificar o usuário criador, o sistema deve registrar erro no log.
- Durante operações de edição, os campos de auditoria devem permanecer inalterados.

**RFs vinculados:**
- [RF_ST_001](./RF_ST_001.md), [RF_ST_003](./RF_ST_003.md), [RF_ST_004](./RF_ST_004.md)
| Termo | Descrição |
|------|-----------|
| Auditoria | Processo de registro automático de informações sobre operações realizadas no sistema. |
| Timestamp | Marca temporal que registra exatamente quando uma operação foi realizada. |
| Integridade Referencial | Garantia de que referências entre tabelas permanecem válidas e consistentes. |
| Auto_now_add | Funcionalidade do Django que preenche automaticamente um campo na criação do registro. |
| ForeignKey | Tipo de campo que estabelece relacionamento com outro modelo (tabela) no banco de dados. |