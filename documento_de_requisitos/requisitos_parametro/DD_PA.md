# DD_PA.md
## Dicionário de Dados – Entidade Parametro

Este documento descreve os campos da entidade `Parametro`, responsável por armazenar configurações utilizadas pelos diferentes módulos do sistema.

---

# Entidade: Parametro

| Campo | Tipo | Obrigatório | Descrição |
|------|------|------|------|
| id | Integer | Sim | Identificador único do parâmetro. |
| base | ForeignKey (Base) | Sim | Base do sistema à qual o parâmetro está vinculado. |
| app | CharField | Sim | Contexto do módulo do sistema onde o parâmetro será utilizado. |
| chave | CharField | Sim | Identificador da variável do parâmetro. |
| valor | CharField | Sim | Valor associado ao parâmetro. |
| nome | CharField | Sim | Nome exibido no formulário ou interface do sistema. |
| descricao | TextField | Não | Descrição detalhada sobre a finalidade do parâmetro. |
| criado_em | DateTime | Sim | Data e hora de criação do parâmetro. |
| criado_por | ForeignKey (User) | Sim | Usuário responsável pela criação do parâmetro. |
| alterado_em | DateTime | Não | Data e hora da última alteração realizada no parâmetro. |

---

# Regras de Negócio

| Regra | Descrição |
|------|------|
| RN_001 | Cada parâmetro deve estar associado a uma base. |
| RN_002 | Não pode existir dois parâmetros com a mesma combinação de `base` e `chave`. |
| RN_003 | Apenas administradores podem criar ou alterar parâmetros através do painel administrativo. |
| RN_004 | Parâmetros são utilizados para configurar comportamentos do sistema em diferentes módulos. |

---

# Valores permitidos para o campo `app`

| Valor | Descrição |
|------|------|
| GLOBAL | Parâmetro utilizado globalmente no sistema |
| BASE | Parâmetro específico da base |
| DASHBOARD | Parâmetro utilizado no dashboard |
| SETOR | Parâmetro relacionado aos setores |
| COLABORADOR | Parâmetro relacionado aos colaboradores |
| UNIDADE | Parâmetro relacionado às unidades |
| CHAMADO | Parâmetro relacionado aos chamados |
| FLUXO | Parâmetro relacionado aos fluxos do sistema |
| RELATORIOS | Parâmetro relacionado aos relatórios |
| NOTIFICACAO | Parâmetro relacionado às notificações |

---

# Relacionamentos

| Entidade | Tipo | Descrição |
|------|------|------|
| Base | Many-to-One | Um parâmetro pertence a uma base. |
| User | Many-to-One | Um usuário pode criar vários parâmetros. |

---

# Observações

* Os parâmetros são utilizados pelo sistema para permitir configurações dinâmicas.
* A integridade dos dados é garantida pela restrição `unique_together (base, chave)`.
* A criação e edição de parâmetros deve ocorrer exclusivamente através do painel administrativo do sistema.