# Recomendações de acessibilidade

Este documento tem como objetivo orientar a equipe de desenvolvimento sobre os requisitos de acessibilidade mais comuns que devem ser observados durante a implementação das páginas do sistema, com base na norma ABNT NBR 17225. Os exemplos de código apresentados foram extraídos do próprio sistema, a fim de ilustrar situações reais e facilitar a aplicação das correções necessárias.

A norma completa está disponível [no repositório do projeto](./base-conhecimento/ABNT%20NBR%2017225%20-%20Acessibilidade%20Digital.pdf). Um resumo dos seus principais pontos está disponível no site do [Foco Acessível](https://focoacessivel.com.br/blog/abnt-nbr-172252025-a-nova-norma-de-acessibilidade-digital-no-brasil/).

## 1. Links e botões

Sempre que um link ou botão tiver como conteúdo **apenas um ícone** ou outro elemento não textual, adicione um **atributo `aria-label`** com um **verbo que descreva a ação** que ele realiza.

✔️ **Exemplos:**

```html
<a href="/unidade/10/delete/15/" class="btn btn-outline-danger" aria-label="Excluir">
  <i class="mdi mdi-trash-can-outline" aria-hidden="true"></i>
</a>

```
```html
<button type="button" class="input-group-text mdi mdi-minus bg-danger text-white" aria-label="Diminuir o número de vítimas"></button>
```

---

## 2. Navegação por teclado

Após finalizar uma página com formulário, **faça um teste de navegação apenas com o teclado** (TAB, SHIFT+TAB, ENTER, etc).

✔️ **Verifique:**

* Se todos os **campos de formulário**, **links**, **botões** e outros elementos interativos recebem **foco visível** e são acessíveis apenas pelo teclado.
* Se o **indicador de foco** é claro e com bom contraste.

---

## 3. Hierarquia e uso correto de cabeçalhos

✔️ **Respeite a ordem hierárquica:**

* Use `<h2>`, `<h3>`, `<h4>`, etc., de forma sequencial e lógica.

✔️ **Use cabeçalhos apenas para identificar seções de conteúdo:**

* **Cada seção da página deve ter um cabeçalho apropriado.**
* **Evite usar cabeçalhos apenas para efeitos visuais** (se for apenas aparência, use outras tags com classes de estilo).

---

## 4. Mensagens de erro

✔️ Use `role="alert"` nas mensagens de erro gerais para garantir que os leitores de tela **anunciem os erros automaticamente**.

✔️ **Exemplo de uso:**

```html
{% if form.errors %}
  <div class="alert alert-danger" role="alert">
    <strong class="mdi mdi-alert">Erro!</strong> Por favor, corrija os erros abaixo e tente novamente.
  </div>
{% endif %}
```

## 5. Área de elementos interativos

Garanta que todos os elementos interativos (botões, links, checkboxes etc.) tenham um tamanho mínimo de **24x24 pixels CSS ou espaçamento suficiente ao redor** para facilitar a ativação por toque ou clique.

✔️ **Exemplos:**
![Três linhas de metas, ilustrando duas maneiras de atender a esse critério de sucesso e uma maneira de reprová-lo](https://www.w3.org/WAI/WCAG22/Understanding/img/target-spacing-toolbar.svg)

![Os itens do menu com uma altura de 24 pixels CSS estão adequados. Para os itens do menu que têm apenas 18 pixels CSS de altura, os círculos de espaçamento de 24 pixels CSS dos alvos em uma linha se sobreporão aos alvos e círculos dos itens de menu adjacentes, resultando em falha.](https://www.w3.org/WAI/WCAG22/Understanding/img/target-dropdown.svg)