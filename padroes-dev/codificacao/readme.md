# Padrões de Codificação - Projeto SAMU/IFBAIANO
Este documento descreve os padrões de codificação para o projeto Django SAMU/IFBAIANO, visando manter a consistência e a organização do código.

## Convenções Gerais

- **Classes**: Devem iniciar com letra maiúscula (ex.: `MinhaClasse`).
- **Variáveis e Funções**: Devem seguir o padrão `CamelCase` iniciado por letra minúscula (ex.: `minhaFuncao`).

## Estrutura do Projeto

### Organização de Arquivos

- Cada aplicação deve conter um diretório chamado `api`, onde estarão localizados os **serializers** e **viewsets**.

- Os templates devem ser organizados da seguinte forma:
    - **`index.html`**: Listagem de todos os itens.
    - **`form.html`**: Usado para criar, editar e confirmar exclusão de registros.
    - **`detail.html`**: Exibição dos detalhes de um registro.

### Views

- Todas as views devem ser implementadas como **funções** (Function-Based Views).

### Exemplos de Nomeação de Variáveis e Funções

#### Variáveis
```python
# Incorreto
quantidadeItens = 10
nomeUsuario = "João"

# Correto
quantidade_itens = 10
nome_usuario = "João"
```

### Exemplos de Funções

#### Função Simples
```python
# Incorreto
def calcularSoma(a, b):
    """Calcula a soma de dois números."""
    return a + b
```

```python
# Correto
def calcular_soma(a, b):
    """Calcula a soma de dois números."""
    return a + b
```

### API

- A API deve conter apenas:
    - **Serializers**: Responsáveis pela serialização e desserialização dos dados.
    - **Viewsets**: Para gerenciar as operações CRUD via API.

## Exemplo de Estrutura

### Diretório de uma Aplicação

```
app_name/
├── api/
│   ├── serializers.py
│   ├── viewsets.py
├── views.py
├── models.py
├── urls.py
├── ...
```

### Exemplo de Código
#### URLs (`urls.py`)
```python
from django.urls import path
from . import views

urlpatterns = [
    path('<int:base_id>/', views.index, name="lista-itens"),
    path('<int:base_id>/<str:item_id>/', views.detalhe, name="lista-item"),
    path('<int:base_id>/edita/<str:item_id>/', views.edita, name="edita-item"),
    path('<int:base_id>/delete/<str:item_id>/', views.delete, name="delete-item"),
    path('<int:base_id>/novo/', views.novo, name="novo-item"),
]
```

### Nota Importante

Todas as URLs devem obrigatoriamente incluir o parâmetro `base_id`.

> **Nota**: Certifique-se de que o parâmetro `base_id` esteja presente em todas as URLs para evitar comportamentos inesperados ou erros.

#### View listar todos (`views.py`)
```python
from django.shortcuts import render
from .models import MeuModelo

def index(request, base_id):
        itens = MeuModelo.objects.filter(base=base_id).all()
        return render(request, 'app_name/index.html', {'itens': itens})

```

#### View Detalhar Item (`views.py`)
```python
from django.shortcuts import render, get_object_or_404
from .models import MeuModelo

def detalhe(request, base_id, id):
    """Exibe os detalhes de um item específico."""
    item = get_object_or_404(MeuModelo, base=base_id, id=id)
    return render(request, 'app_name/detail.html', {'item': item})
```

#### Serializer (`api/serializers.py`)
```python
from rest_framework import serializers
from .models import MeuModelo

class MeuModeloSerializer(serializers.ModelSerializer):
        class Meta:
                model = MeuModelo
                fields = '__all__'
```

#### Viewset (`api/viewsets.py`)
```python
from rest_framework import viewsets
from .serializers import MeuModeloSerializer
from .models import MeuModelo

class MeuModeloViewSet(viewsets.ModelViewSet):
        queryset = MeuModelo.objects.all()
        serializer_class = MeuModeloSerializer
```


### Padrão para Montar Páginas

As páginas do projeto devem seguir o padrão de organização e estrutura descrito abaixo para garantir consistência e reutilização de componentes.

#### Estrutura Geral

- **Templates/App/**: Devem ser organizados em diretórios específicos para cada funcionalidade, seguindo a estrutura abaixo:
    - **`index.html`**: Página principal com listagem de itens e botões de ação.
    - **`form.html`**: Formulário para criação, edição ou confirmação de exclusão de registros.
    - **`detail.html`**: Página para exibição detalhada de um item específico.

#### Componentes Reutilizáveis

- **Cards**: Utilizar o componente `card` do Bootstrap para exibir informações em caixas organizadas, com ícones e textos descritivos.
- **Modais**: Incluir modais reutilizáveis com o comando `{% include 'caminho/do/modal.html' %}`.

#### Scripts e Estilos

- **Scripts**: Devem ser carregados no bloco `{% block scripts_footer %}` para otimizar o carregamento da página.
- **Estilos**: Utilizar classes do Bootstrap para garantir responsividade e consistência visual. Outros estilos podem ser carregados no bloco `{% block scripts_header %}`

#### Exemplo de Página

Abaixo está um exemplo de como estruturar uma página utilizando os padrões descritos:

```html
{% extends '_base.html' %}

{% block scripts_header %}
    <link href="{% static 'css/estilo.css' %}" rel="stylesheet" />
{% endblock %}

{% block content %}
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h4>Título</h4>
                </div>
                <div class="card-body">
                    <p>Conteúdo do card.</p>
                </div>
            </div>
        </div>
    </div>

    {% include 'app/modal/modal_qualquer.html' %}
{% endblock %}

{% block scripts_footer %}
    <script src="{% static 'js/exemplo.js' %}"></script>
{% endblock %}
```


> **Nota**: Este código segue os padrões de codificação definidos neste documento, garantindo legibilidade e consistência. Os nomes de variáveis e funções utilizam o estilo `CamelCase`, e comentários e docstrings são usados para descrever a funcionalidade do código.
