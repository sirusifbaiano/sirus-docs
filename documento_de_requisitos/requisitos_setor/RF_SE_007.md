##  RF_ST_007: O sistema deve permitir gerenciar Permissões do Setor
**Descrição do caso de uso:** O sistema deve permitir definir e alterar as permissões de acesso associadas a um setor.

**Ator(es):** Super usuário e/ou membros de setores que tenham permissão de `Change` no model `Setor`.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável
      
**Entradas e pré-condições:**
- O usuário deve ser um Super Usuário ou ser membro de um setor que tenha a permissão de `Change` no model `Setor`.
- O setor deve existir no sistema e estar ativo.
- O usuário deve ter acesso à base onde o setor está vinculado.
- As permissões disponíveis devem estar cadastradas no sistema (excluindo permissões padrão do Django e tokens).
- Se o usuário não for Super Usuário, pode gerenciar apenas setores de bases onde é responsável.

**Saídas e pós-condição:**
- O sistema retorna uma mensagem informando o resultado da operação.
- As permissões são associadas ou desassociadas do setor conforme solicitado.
- O sistema automaticamente sincroniza as permissões com o grupo correspondente no Django.
- Todos os membros do setor ganham ou perdem as permissões alteradas.
- As permissões são exibidas de forma traduzida e amigável na interface.

**Fluxo de eventos principal:**
- O usuário acessa a funcionalidade de edição de um setor específico.
- O sistema apresenta o formulário com as permissões atualmente associadas ao setor.
- O sistema filtra e exibe apenas permissões válidas (ID >= 25, excluindo tokens).
- O sistema traduz as permissões técnicas para termos em português brasileiro.
- O usuário seleciona ou deseleciona permissões conforme necessário.
- O usuário clica no botão "Salvar".
- O sistema valida as alterações nas permissões.
- O sistema atualiza os relacionamentos Many-to-Many de permissões.
- O sistema executa automaticamente a sincronização com grupos Django.
- O sistema retorna uma mensagem de sucesso.

**Fluxos secundários:**
- Caso o setor não seja encontrado ou esteja inativo:
  - O sistema exibe uma mensagem de erro apropriada.
  - O sistema redireciona para a listagem de setores.
- Caso o usuário não possua permissão para alterar permissões:
  - O sistema **não exibe os campos de seleção de permissões** como editáveis.
  - Se tentativa direta via URL, o sistema retorna **erro HTTP 403 (Forbidden)**.
- Caso uma permissão selecionada seja inválida:
  - O sistema filtra automaticamente permissões inválidas.
  - Uma mensagem de aviso é exibida sobre permissões removidas da seleção.
- Caso a sincronização com grupos Django falhe:
  - O sistema tenta reprocessar automaticamente.
  - Se persistir a falha, registra no log mas mantém as alterações no setor.
- Caso ocorra erro na atualização dos relacionamentos:
  - O sistema reverte todas as alterações.
  - Uma mensagem de erro técnico é exibida.
  - O estado anterior é restaurado.

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
| Permissão | Direito de acesso específico a uma funcionalidade do sistema, baseado no modelo de permissões do Django. |
| Setor | É uma unidade organizacional dentro de uma base do SAMU, responsável por agrupar profissionais com funções similares e definir suas permissões de acesso ao sistema. |
| Tradução de Permissões | Sistema que converte permissões técnicas do Django (como "can add base") para termos amigáveis em português ("Adicionar Base"). |
| Grupo Django | Sistema nativo do Django onde cada setor é mapeado como um grupo, herdando todas as permissões definidas. |
| Sincronização de Permissões | Processo que garante que as permissões do setor sejam refletidas no grupo correspondente do Django. |

## Dicionário de dados:
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_ST.md](./DD_ST.md).