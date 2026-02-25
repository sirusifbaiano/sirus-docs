##  RF_ST_008: O sistema deve permitir controlar Status do Setor
**Descrição do caso de uso:** O sistema deve permitir ativar ou desativar um setor através do campo "ativo".

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Change` no model `Setor`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável
      
**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou ser membro de um setor que tenha a permissão de `Change` no model `Setor`.
- O setor deve existir no sistema.
- O usuário deve ter acesso à base onde o setor está vinculado.
- Se o usuário não for Super Usuário, pode alterar status apenas de setores de bases onde é responsável.
- O novo status deve ser um valor booleano válido (ativo = true/false).

**Saídas e pós-condição:**
- O sistema retorna uma mensagem informando o resultado da operação.
- O status do setor é atualizado no banco de dados.
- Se o setor for desativado, suas funcionalidades ficam restritas mas os dados são preservados.
- Se o setor for reativado, todas as funcionalidades voltam a funcionar normalmente.
- A sincronização com grupos Django é mantida independentemente do status.
- O histórico de auditoria é preservado.

**Fluxo de eventos principal:**
- O usuário acessa a funcionalidade de edição de um setor específico.
- O sistema apresenta o formulário com o status atual do setor (ativo/inativo).
- O usuário altera o status do campo "Ativo" conforme necessário.
- O usuário pode alterar outros campos simultaneamente se desejar.
- O usuário clica no botão "Salvar".
- O sistema valida as permissões e dados.
- O sistema atualiza o status no banco de dados.
- O sistema mantém a sincronização com grupos Django.
- O sistema retorna uma mensagem de sucesso informando a alteração.

**Fluxos secundários:**
- Caso o setor não seja encontrado:
  - O sistema exibe uma mensagem de erro "Setor não encontrado".
  - O sistema redireciona para a listagem de setores.
- Caso o usuário não possua permissão para alterar o status:
  - O sistema **não exibe o campo "Ativo"** como editável.
  - Se tentativa direta via URL, o sistema retorna **erro HTTP 403 (Forbidden)**.
- Caso o valor do status seja inválido:
  - O sistema exibe uma mensagem de erro de validação.
  - O formulário permanece preenchido para correção.
- Caso ocorra erro na atualização do banco de dados:
  - O sistema exibe uma mensagem de erro técnico.
  - A operação é cancelada e o status anterior é mantido.
  - O erro é registrado no log do sistema.
- Caso a alteração afete outros processos do sistema:
  - O sistema processa as alterações de forma transacional.
  - Se houver conflitos, desfaz todas as alterações.

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
| Status Ativo | Campo booleano que determina se o setor está ativo (funcionando normalmente) ou inativo (funcionalidades restritas). |
| Setor | É uma unidade organizacional dentro de uma base do SAMU, responsável por agrupar profissionais com funções similares e definir suas permissões de acesso ao sistema. |
| Desativação | Processo de tornar um setor inativo, restringindo funcionalidades mas preservando dados históricos. |
| Reativação | Processo de tornar um setor inativo novamente ativo, restaurando todas as funcionalidades. |
| Processamento Transacional | Execução de operações de forma que todas sejam bem-sucedidas ou todas sejam desfeitas em caso de erro. |

## Dicionário de dados:
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_ST.md](./DD_ST.md).