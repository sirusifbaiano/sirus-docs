
# 🧩 Padrões de Desenvolvimento – Permissões no Django

## ✅ Sempre criar permissão `detail_model` na `class Meta` 

Essa permissão é usada para controle de acesso à visualização detalhada do objeto.

```python
class Meta:
    permissions = [
        ("detail_unidade", "Pode ver os detalhes completos da unidade")
    ]
```
> ⚠️ Deve-se adicionar no model, dentro da `class Meta`, o atributo `permissions` com a permissão `detail_*` sempre que for necessário controlar o acesso à visualização detalhada de um registro.

> ⚠️ Após definir as permissões personalizadas, lembre-se de rodar `makemigrations` e `migrate`.

> ℹ️ Para o ambiente Docker, veja os comandos indicados na seção **trilha-docker**.

---

## ✅ Usar `@setor_permission_required` nas views

Deixa explícito que uma view requer permissão para ser acessada.

```python
from django.contrib.auth.decorators import permission_required

@setor_permission_required('base.detail_unidade', raise_exception=True)
def ver_detalhes(request, id):
    ...
```

> ⚠️ Deve-se proteger a view com o decorator @setor_permission_required, utilizando a permissão no formato app_label.permission_codename (por exemplo, base.detail_unidade).

> Isso garante que somente usuários com essa permissão possam acessar a view.

> O parâmetro raise_exception=True faz com que o Django retorne erro 403 (proibido) automaticamente se o usuário não tiver a permissão.

---

## ✅ Usar `perms.app_label.permission_codename` nos templates HTML

Permite controlar elementos visuais com base nas permissões do usuário.

```django
{% if perms.base.detail_unidade %}
    <a href="{% url 'unidade:detalhe' unidade.id %}">Ver detalhes</a>
{% endif %}
```
> ⚠️ Deve-se usar a variável perms.app_label.permission_codename nos templates para exibir elementos da interface apenas para usuários com permissão específica.

---


## ✅ Evitar o uso de `is_superuser`

O uso de `is_superuser` deve ser reservado para situações específicas, como acesso ao painel administrativo.

Usar permissões explícitas torna o sistema mais seguro, flexível e aderente às regras de negócio.

---

ℹ️ Este documento complementa o material conceitual em:  
📄 `docs/base-conhecimento/trilha-permissao-django.md`