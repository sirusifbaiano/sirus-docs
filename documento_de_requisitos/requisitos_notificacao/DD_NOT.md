# 📘 Dicionário de Dados — Módulo Notificação

Este documento descreve as estruturas de dados dos modelos relacionados ao módulo **Notificação**, incluindo suas relações, tipos de dados, restrições e observações técnicas.

---

## Modelo Evento

**Descrição:** O modelo `Evento` representa os tipos de eventos utilizados no sistema de notificações.

| Nome do Atributo | Tipo de Dado       | Descrição                                  | Restrições                                                                 |
|-------------------|--------------------|----------------------------------------------|----------------------------------------------------------------------------|
| `nome`            | SlugField          | Identificador único do evento               | Máximo de 100 caracteres. Deve ser único (`unique=True`).                 |
| `descricao`       | CharField          | Descrição resumida do evento                | Máximo de 150 caracteres.                                                 |
| `titulo`          | CharField          | Título padrão da notificação                | Máximo de 255 caracteres.                                                 |
| `mensagem`        | TextField          | Mensagem padrão da notificação              | Campo obrigatório.                                                        |
| `permissions`     | ManyToManyField    | Permissões relacionadas ao evento           | Relacionamento com `Permission` do Django.                                |
| `permissions_hash`| JSONField          | Estrutura auxiliar de permissões            | Valor padrão vazio (`default=list`). |

**Observações**
- O atributo `permissions` utiliza o modelo `Permission` do Django para relacionar permissões aos eventos.
- O atributo `nome` é utilizado como identificador único do evento no sistema.
- O atributo `permissions_hash` armazena uma representação estruturada das permissões associadas ao evento.

---

## Modelo Notificacao

**Descrição:** O modelo `Notificacao` representa as notificações enviadas aos usuários do sistema.

| Nome do Atributo | Tipo de Dado       | Descrição                                   | Restrições                                                                 |
|-------------------|--------------------|-----------------------------------------------|----------------------------------------------------------------------------|
| `destinatario`    | ForeignKey         | Usuário destinatário da notificação          | Relacionado com `auth.User`. Obrigatório.                                 |
| `titulo`          | CharField          | Título da notificação                        | Máximo de 255 caracteres.                                                 |
| `mensagem`        | TextField          | Conteúdo da notificação                      | Campo obrigatório.                                                        |
| `criada_em`       | DateTimeField      | Data de criação da notificação               | Preenchido automaticamente (`auto_now_add=True`).                         |
| `lida_em`         | DateTimeField      | Data em que a notificação foi lida           | Pode ser nulo (`null=True`).                                              |
| `lida`            | BooleanField       | Indica se a notificação foi lida             | Valor padrão `False`.                                                     |
| `url`             | URLField           | Link relacionado à notificação               | Pode ser nulo (`null=True`).                                              |
| `evento`          | ForeignKey         | Evento relacionado à notificação             | Relacionado com `Evento`. Obrigatório.                                    |

**Observações**
- O atributo `destinatario` utiliza a tabela padrão de usuários do Django (`auth.User`).

---

## Modelo PreferenciaDeNotificacao

**Descrição:** O modelo `PreferenciaDeNotificacao` representa as preferências de recebimento de notificações dos usuários por evento e canal de entrega.

| Nome do Atributo | Tipo de Dado       | Descrição                                        | Restrições                                                                 |
|-------------------|--------------------|----------------------------------------------------|----------------------------------------------------------------------------|
| `usuario`         | ForeignKey         | Usuário associado à preferência                  | Relacionado com `auth.User`. Obrigatório.                                 |
| `evento`          | ForeignKey         | Evento associado à preferência                   | Relacionado com `Evento`. Obrigatório.                                    |
| `sistema`         | BooleanField       | Define se o usuário receberá notificações no sistema | Valor padrão `True`.                                                   |
| `email`           | BooleanField       | Define se o usuário receberá notificações por e-mail | Valor padrão `False`.                                                  |

**Observações**
- O atributo `usuario` utiliza a tabela padrão de usuários do Django (`auth.User`).
- O atributo `evento` relaciona a preferência a um evento específico do sistema.
- Existe uma restrição de unicidade (`UniqueConstraint`) que impede múltiplos registros para o mesmo usuário e evento.
