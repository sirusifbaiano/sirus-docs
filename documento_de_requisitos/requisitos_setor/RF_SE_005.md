##  RF_ST_005: O sistema deve permitir excluir Setor
**Descrição do caso de uso:** O sistema deve permitir remover um setor previamente cadastrado.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Delete` no model `Setor`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável
      
**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou ser membro de um setor que tenha a permissão de `Delete` no model `Setor`.
- O setor a ser excluído deve existir no sistema.
- O usuário deve ter acesso à base onde o setor está vinculado.
- Se o usuário não for Super Usuário, pode excluir apenas setores de bases onde é responsável ou onde a central é responsável.
- O ID do setor deve ser válido e corresponder a um registro existente.
- O setor não deve ter dependências que impeçam sua exclusão (verificar regras de integridade referencial).

**Saídas e pós-condição:**
- O sistema retorna uma mensagem informando o resultado da operação.
- O setor é removido permanentemente do banco de dados.
- O grupo correspondente no sistema de permissões do Django é automaticamente removido.
- Todos os usuários são automaticamente removidos do grupo excluído.
- Relacionamentos Many-to-Many são automaticamente limpos.

**Fluxo de eventos principal:**
- O usuário acessa a listagem de setores ou detalhes de um setor específico.
- O usuário seleciona a opção "Excluir" para o setor desejado.
- O sistema valida as permissões do usuário para exclusão.
- O sistema apresenta um formulário de confirmação com detalhes do setor.
- O sistema exibe avisos sobre as consequências da exclusão.
- O usuário confirma a exclusão clicando no botão "Confirmar Exclusão".
- O sistema valida novamente as permissões e integridade dos dados.
- O sistema remove todos os relacionamentos Many-to-Many.
- O sistema remove o grupo correspondente do sistema Django.
- O sistema exclui o setor do banco de dados.
- O sistema retorna uma mensagem de sucesso e redireciona para a listagem.

**Fluxos secundários:**
- Caso o setor não seja encontrado:
  - O sistema exibe uma mensagem de erro "Setor não encontrado".
  - O sistema redireciona para a listagem de setores.
- Caso o usuário não possua permissão de `Delete` no model `Setor`:
  - O sistema **não exibe a opção "Excluir"** na interface.
  - Se o usuário tentar acessar o formulário de exclusão diretamente pela URL, o sistema retorna **erro HTTP 403 (Forbidden)**.
- Caso o usuário cancele a operação:
  - O sistema retorna à página anterior sem fazer alterações.
  - Nenhuma operação de exclusão é executada.
- Caso existam dependências que impedem a exclusão:
  - O sistema exibe uma mensagem explicando as dependências existentes.
  - O sistema sugere ações necessárias antes da exclusão.
  - A operação é cancelada sem alterações.
- Caso ocorra erro na remoção do banco de dados:
  - O sistema exibe uma mensagem de erro técnico.
  - A operação é cancelada e o setor permanece inalterado.
  - O erro é registrado no log do sistema.
- Caso falhe a remoção do grupo Django:
  - O sistema tenta reprocessar a remoção do grupo.
  - Se a falha persistir, registra o erro no log.
  - A exclusão do setor pode continuar se a integridade permitir.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O sistema deve retornar o resultado em menos de 3 segundos.
- RNF_002: O sistema deve ter recursos de acessibilidade.
- RNF_003: Todos os campos obrigatórios dos formulários do sistema devem ser identificados com um asterisco (*) imediatamente após o seu label.
- RNF_ST_001: O sistema deve automaticamente sincronizar o setor com o sistema de grupos do Django para controle de permissões.
- RNF_ST_003: O sistema deve validar se o usuário possui as permissões necessárias para executar operações CRUD em setores.
- RNF_ST_005: O sistema deve permitir acesso diferenciado: superusuários acessam todas as bases, usuários normais apenas bases onde são responsáveis.

## Dicionário de termos:
| Termo | Descrição |
|------|-----------|
| Setor | É uma unidade organizacional dentro de uma base do SAMU, responsável por agrupar profissionais com funções similares e definir suas permissões de acesso ao sistema. |
| Base | É um ponto de apoio estratégico para as equipes de socorristas, que fornece infraestrutura e suporte. As bases descentralizadas são pontos de apoio para as equipes e veículos, garantindo um atendimento mais rápido. |
| Integridade Referencial | Conjunto de regras que garantem que as referências entre tabelas do banco de dados permaneçam válidas. |
| Relacionamento Many-to-Many | Tipo de relacionamento onde um setor pode ter vários membros e um membro pode pertencer a vários setores. |
| Exclusão em Cascata | Processo automático que remove registros dependentes quando o registro principal é excluído. |

## Dicionário de dados:
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_ST.md](./DD_ST.md).