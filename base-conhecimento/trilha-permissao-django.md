---

# 📄 Sistema de Permissões no Django

## 🎯 Objetivo do documento

Este documento tem como objetivo explicar o funcionamento do sistema de permissões do Django utilizado neste projeto, abordando sua aplicação prática e os procedimentos para criar, atribuir e verificar permissões, tanto individualmente quanto por meio de grupos de usuários.

---

## 🔑 O que são permissões no Django?

O Django possui um sistema de autenticação e autorização embutido.
Cada modelo do Django possui, por padrão, **quatro permissões**:

* `add` – Pode adicionar registros.
* `change` – Pode editar registros.
* `delete` – Pode excluir registros.
* `view` – Pode visualizar registros.

Essas permissões são usadas para **controlar o acesso dos usuários** a diferentes partes do sistema, com base no que eles podem ou não fazer.

---

## ✅ Como atribuir permissões a um usuário?

**Usando a interface gráfica do Django:**

1. Vá até **Usuários** no `/admin`.
2. Clique em um usuário (ou crie um novo).
3. Role até a seção **Permissões**.
4. Selecione as permissões desejadas.
5. Clique em **Salvar**.

---

## ✅ Como criar e configurar grupos de permissões?

**Usando a interface gráfica do Django:**

1. Vá até **Grupos** no `/admin`.
2. Clique em **Adicionar um novo grupo**.
3. Dê um nome ao grupo (ex: `Médico`).
4. Selecione as permissões desejadas.
5. Clique em **Salvar**.

---

## ✅ Como atribuir permissões personalizadas a Models de diferentes apps no Django?

As permissões no Django **não são atribuídas diretamente aos apps**, mas sim aos **Models dentro desses apps**.

O Django associa automaticamente cada permissão ao seu respectivo app por meio do atributo `app_label`, que é baseado no **nome do app onde o model está definido** (e não no nome do Model).

---

## ✅ O que é `app_label`?

`app_label` é o **nome do app** ao qual um modelo pertence.

---

### ✅ Exemplo:

```python
# models.py no app chamado 'base'
class Unidade(models.Model):
    nome = models.CharField(max_length=255)
```

Esse modelo será automaticamente associado ao:

* `model`: `Unidade`
* `app_label`: `base`
* Permissões: `base.add_unidade`, `base.view_unidade`, etc.

---

## ✅ O que é `ContentType` no Django?

O `ContentType` é uma tabela interna do Django que registra todos os models instalados no projeto.

Cada registro representa um model específico, relacionando o nome do model (`model`) com o app em que ele está definido (`app_label`).

O Django usa o `ContentType` principalmente para:

- Associar permissões a um model específico
- Trabalhar com relacionamentos genéricos (`GenericForeignKey`)

---

### 🔎 Exemplo prático:

```python
from django.contrib.contenttypes.models import ContentType

# Recupera o ContentType do model Unidade (app base)
ct = ContentType.objects.get(app_label='base', model='unidade')
print(ct.id)  # ID interno usado, por exemplo, em permissões
```

---

## ✅ Como adicionar permissões personalizadas com `class Meta`

No Django, cada model representa uma tabela no banco de dados e recebe automaticamente as permissões padrão: `add`, `change`, `delete` e `view`.

Caso deseje criar permissões adicionais (ex: visualizar detalhes), você pode definir essas permissões diretamente na `class Meta` do model:

```python
class Unidade(models.Model):
    ...

    class Meta:
        permissions = [
            ("detail_unidade", "Pode ver os detalhes completos da unidade"),
        ]
```

---

## ✅ Como excluir as permissões que já foram criadas?

1. No Django Admin → **Permissões** → **Excluir** a permissão que não quer mais.

**Obs:** se “Permissões” não aparecer no admin, registre assim no `admin.py`:

```python
from django.contrib import admin
from django.contrib.auth.models import Permission

admin.site.register(Permission)
```

---

📄 Veja como funciona o uso de permissões em VIEWS na trilha:

**`docs/padroes-dev/codificação/permissoes-no-django.md`**

---
📄 Veja como funciona o uso de permissões em TEMPLATES na trilha:

**`docs/padroes-dev/codificação/permissoes-no-django.md`**

---


