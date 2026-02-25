## RF_DA_001: O sistema deve exibir as Unidades num dashboard

**Descrição do caso de uso:** O sistema deve exibir as Unidades num _dashboard_.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Visualizar` no model `Unidade`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou membro de setor que tenha permissão de `Visualizar` no model `Unidade`.

**Saídas e pós-condição:**
- O sistema exibe os status e as cidades das Unidades, bem como um filtro que permita selecionar as Unidades por cidade, conforme a permissão do usuário. Se uma Unidade estiver atentendo um chamado, também deve ser exibido um contador com o tempo decorrido desde o início do atendimento.


**Fluxo de eventos principal:**
- O usuário seleciona a opção "_Dashboard_" e, em seguida, a opção "Status das unidades" no menu do sistema.
- O sistema exibe um _dashboard_ com as unidades numa nova guia.


**Fluxos secundários:**
- Caso não haja Unidades cadastradas, o sistema retorna a mensagem: “Nenhuma unidade encontrada”.
- Caso o usuário não possua permissão de `Visualizar` no model `Unidade`, o sistema:
  - Não exibe a opção "Status das unidades" no menu.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve exibir as Unidades em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.
- RNF_003: O _dashboard_ deve ser atualizado em tempo real.
