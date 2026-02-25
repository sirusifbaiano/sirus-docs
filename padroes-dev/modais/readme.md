# Padrão para o uso de modais

Este documento descreve os padrões de desenvolvimento para modais utilizados no projeto.

## Estrutura do Modal

Os modais devem ser criados sempres dentro de uma pasta chamada de "modal" dentro da pasta de templates de seu respectivo app.


A estrutura de diretórios para os modais deve seguir o padrão abaixo:
```
templates/
├──app/
│   ├── modal/
│   │   ├── exemplo.html
│   │   ├── outro_exemplo.html
│   │   └── ...
│   ├── index.html
│   ├── form.html
│   └── detail.html
├── _base.html
├── ...
```
Sendo **`modal/`** o diretório onde os arquivos HTML dos modais são armazenados.

### Criando um Modal

Para criar um modal seguindo o exemplo fornecido, siga os passos abaixo:

1. **Crie o arquivo HTML do modal**  
    Dentro do diretório `modal/` do seu app, crie um arquivo HTML, por exemplo, `meu_modal.html`.

2. **Extenda o template base do modal**  
    No início do arquivo, utilize a diretiva `{% extends %}` para herdar o layout de `_modal_base.html` (modal sestreito) ou  `_modal_base_lg.html` (modal largo):
    ```django
    {% extends '_modal_base.html' %}
    ```
    Quando vc realiza essa extensão, você tem 3 blocos a disposição para uso. Como descrito a seguir:


    2.1. **Defina o título do modal**  
    Utilize o bloco `head_modal` para definir o título do modal:
    ```django
    {% block head_modal %}
      <h5 class="text-white">Título do modal</h5>
    {% endblock %}
    ```

    2.2. **Adicione o conteúdo do corpo do modal**  
    No bloco `body_modal`, insira o conteúdo principal do modal:
    ```django
    {% block body_modal %}
      <div class="row m-2">
         <div class="row h3">Conteudo do modal</div>
      </div>
    {% endblock %}
    ```

    2.3. **Configure o rodapé do modal**  
    No bloco `footer_modal`, adicione os elementos do rodapé, como botões, mensagens, etc:
    ```django
    {% block footer_modal %}
      <button type="button" class="btn" data-dismiss="modal">Cancelar</button>
      <button type="button" class="btn ">Salvar</button>
    {% endblock %}
    ```

Seguindo essas etapas, você terá um modal funcional e consistente com os padrões do projeto.

3. **Inclua o modal no template principal**  
    Após criar o modal, é necessário incluí-lo no template principal do app para que ele possa ser utilizado.

    3.1. **Adicione o botão de acionamento do modal**  
    No template principal, insira um botão ou link que acione o modal. Utilize o atributo `data-toggle="modal"` e `data-target="#modal-base"` para associar o botão ao modal:
    ```html
    <button type="button" class="btn" data-toggle="modal" data-target="#modal-base">
      Abrir Modal
    </button>
    ```

    3.2. **Inclua o modal no template**  
    No final do template onde se deseja exibir o modal, inclua o modal utilizando a diretiva `{% include %}` para carregar o arquivo HTML do modal:
    ```django
    {% include 'app/modal/meu_modal.html' %}
    ```
    Recomenda-se  que se faça isso antes do `{% endblock content %}`. Certifique-se que o caminho para o arquivo do modal está correto. Deve-se informar o caminho completo a partir do diretórop base dos tamplates.