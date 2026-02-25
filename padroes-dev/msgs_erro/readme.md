# Padrão para o uso de páginas de erro

Este documento descreve os padrões de desenvolvimento para exibição e tratamento de erros utilizando a função `samu.utils.render_erro`.

## Estrutura dos Templates

Todos os templates de erro devem estar dentro do diretório global de templates e seguir a seguinte estrutura:

```
templates/
├── _erro.html
├── 403.html
├── 404.html
├── 500.html
└── ...
```

O arquivo `_erro.html` serve como **template base**, sendo estendido pelos arquivos de erro específicos (403, 404, 500, etc.).

## Estrutura do Template Base (`_erro.html`)

O arquivo `_erro.html` define a estrutura comum de todas as páginas de erro.
Ele utiliza blocos que podem ser sobrescritos pelos templates específicos:

- **`titulo`** → Define o título da página (usado na tag `<title>`).
- **`codigo`** → Define o código do erro (ex: 404, 403, 500).
- **`mensagem`** → Define a mensagem principal exibida ao usuário.
- **`detalhes`** → Fornece uma explicação complementar ou orientação.
- **`acoes`** → Define os botões de ação, como “Voltar” ou “Ir para o início”.

## Criando um Template de Erro Específico

Para criar uma nova página de erro, basta **estender** o `_erro.html` e sobrescrever os blocos desejados.

**Exemplo (403.html):**
```django
{% extends "_erro.html" %}

{% block titulo %}Erro 403 - Acesso Negado{% endblock %}
{% block codigo %}403{% endblock %}
{% block mensagem %}Acesso Negado{% endblock %}
{% block detalhes %}Você não tem permissão para acessar esta página.{% endblock %}
```

## Função `render_erro`

A função `samu.utils.render_erro` deve ser utilizada em views, decorators ou middlewares para gerar páginas de erro com base nesse padrão.

**Exemplo de uso:**
```python
from samu.utils import render_erro

def minha_view(request):
    if not request.user.has_perm('app.permissao_exemplo'):
        return render_erro(
            request,
            codigo=403,
            mensagem="Acesso negado",
            detalhes="Você não possui as permissões necessárias."
        )
```

## Parâmetros da função `render_erro`

| Parâmetro     | Tipo   | Descrição |
|---------------|--------|------------|
| `request`     | HttpRequest | Requisição atual do Django. |
| `codigo`      | int | Código do erro (ex: 403, 404, 500). |
| `mensagem`    | str | Mensagem principal exibida ao usuário. |
| `detalhes`    | str | Texto adicional explicando o erro. |
| `voltar_url`  | str | URL para o botão de retorno (opcional). |

## Boas práticas

- Utilize `render_erro` **em vez de HttpResponseForbidden** ou `HttpResponseNotFound` diretamente.
- Centralize a aparência dos erros — qualquer alteração no `_erro.html` refletirá automaticamente em todas as páginas.
- Mantenha mensagens de erro **claras, empáticas e informativas**.
- Evite expor detalhes técnicos sensíveis em ambiente de produção.
