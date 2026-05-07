## RF_NOT_004: O sistema deve permitir configurar preferências de notificações

**Descrição do caso de uso:** O sistema deve permitir que o usuário configure suas preferências de recebimento de notificações por evento e canal de entrega.

**Ator(es):** Usuário autenticado.

**Prioridade:**   [ ] Essencial       [x] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve estar autenticado no sistema.

**Saídas e pós-condição:**
- O sistema salva as preferências de notificações definidas pelo usuário.

**Fluxo de eventos principal:**
- O usuário acessa a página de notificações do sistema.
- O usuário clica no ícone de configurações.
- O sistema exibe a página de preferências listando os eventos disponíveis.
- O usuário seleciona os canais de entrega desejados para cada evento (sistema, e-mail, etc.).
- O usuário salva as alterações.
- O sistema registra as preferências configuradas.

**Fluxos secundários:**
- Caso ocorra uma falha de comunicação com o banco de dados, uma mensagem de erro é retornada para o usuário e a operação é cancelada.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_NOT.md](./DD_NOT.md).