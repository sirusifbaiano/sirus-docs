# Observações sobre a acessibilidade do sistema

## Ícones

- ~~Os ícones devem indicar aos leitores de tela que eles são imagens decorativas e, portanto, devem ser ignorados. Isso pode ser feito com o atributo `aria-hidden="true"` na tag do ícone.~~ ✅

## Indicador de foco

- As opções do campo de "período" dos filtros da página de chamados não são acessíveis pelo teclado. O mesmo problema está presente nas opções dos campos com "select2".
- ~~O indicador de foco não está visível no botão da página de login nem na maioria dos links ou botões das páginas. Isso pode ser corrigido com a aplicação da propriedade `outline` ou com a mudança da cor de fundo do elemento ao receber o foco.~~ ✅
- Os elementos da barra de contatos não recebem o foco e, após ser exibida, a barra não deixa de ser exibida sem o auxílio do mouse, o que dificulta a navegação somente por teclado.
- A página atende à exigência de não apresentar perda de conteúdo com o zoom de 200%, mas a barra lateral, após ser exibida, não responde adequadamente para desaparecer e seus links continuam recebendo o foco mesmo quando não estão visíveis.

## Cabeçalhos

- ~~Os cards possuem cabeçalhos `h2`, mas as páginas não possuem `h1`. Pode-se substituir a tag `span` com o nome da base por uma tag `h1`.~~ ✅
- ~~As páginas de detalhes de unidade, base e setores têm `h2` e `h4`, mas não `h1` e `h3`; alguns cabeçalhos não estão sendo usados para identificar seções de conteúdo.~~ ✅
- ~~O único cabeçalho na página de login é um `h3`.~~ ✅

## Gráficos

- Os gráficos do dashboard precisam de descrição.

## Textos alternativos

- Imagens de perfil usam `alt="User Image"` ao invés de descrever o nome do usuário.

## Contraste

- ~~Algumas cores não apresentam o contraste mínimo exigido com o texto. Isso pode ser verificado nas opções de inspecionar do navegador.~~ ✅

## Referências

- [ Bureau of Internet Accessibility. Are Your Website's Status Messages Accessible?](https://www.boia.org/blog/are-your-websites-status-messages-accessible#:~:text=Use%20appropriate%20ARIA%20roles%20for%20status%20messages%20that%20don%E2%80%99t%20cause%20a%20change%20of%20context.%C2%A0)
- [Foco Acessível. ABNT NBR 17225:2025 – A nova norma de acessibilidade digital no Brasil.](https://focoacessivel.com.br/blog/abnt-nbr-17225-2025-a-nova-norma-de-acessibilidade-digital-no-brasil.html#:~:text=Principais%20requisitos%20da%20norma)
- [Font Awesome. Accessibility.](https://fontawesome.com/v4/accessibility/#:~:text=%3Ca%20class%3D%22btn%20btn%2Ddanger%22%20href%3D%22path/to/settings%22%20aria%2Dlabel%3D%22Delete%22%3E%0A%20%20%3Ci%20class%3D%22fa%20fa%2Dtrash%2Do%22%20aria%2Dhidden%3D%22true%22%20title%3D%22Delete%20this%20item%3F%22%3E%3C/i%3E%0A%3C/a%3E)
