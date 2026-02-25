##  RF_BA_002: O sistema deve permitir que o usuário liste os chamados
**Descrição do caso de uso:** O sistema deve permitir que os usuários liste os chamados da base no sistema.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Visualizar` no model `Chamado`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável
      
**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou membro de setor que tenha permissão de `Visualizar` no model `Chamado`.

**Saídas e pós-condição:**
- O sistema exibe a lista dos Chamados conforme a base e a permissão do usuário.

**Fluxo de eventos principal:**
- O usuário seleciona a opção "Chamados" no menu do sistema.
- O sistema apresenta a lista de Chamados.
- O usuário pode visualizar informações resumidas (nome dos solicitantes, vitimas, setor atual, status, local de ocorrência).

**Fluxos secundários:**
- Caso não haja chamados, o sistema retorna a mensagem: “Nenhum registro encontrado.”.
- Caso o usuário não possua permissão de `Visualizar` no model `Chamado`, o sistema:
  - Não exibe a opção Chamados no menu.
  - Caso tente acessar diretamente pela URL, retorna **erro HTTP 403 (Forbidden)**.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar a lista em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_CH.md](./DD_CH.md).

