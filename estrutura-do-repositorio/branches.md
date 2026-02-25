# Documentação das branches

## Estrutura de branches
Este repositório possui a estrutura de branches descrita a seguir.

![branches](https://itknowledgeexchange.techtarget.com/coffee-talk/files/2021/01/gitflow-release-branch.jpg)

### `main`
Esta branch contém a **versão estável** do projeto. Nenhuma alteração deve ser feita diretamente nela. O código somente será incorporado a ela após passar pelos testes na `release`.

### `release`
Esta branch será usada para **testes e validação de código**. Todos os pull requests devem ser abertos para ela. A equipe de testes atua nela, validando as alterações antes da publicação na `main`.

### `dev`
Esta branch é destinada ao código em **desenvolvimento**. Ela é o local para a integração das funcionalidades antes de enviá-las para a `release`.

## Material de apoio

Para entender melhor o modelo Git Flow, recomendamos o vídeo:

🎥 [Git Flow // Dicionário do Programador](https://www.youtube.com/watch?v=oweffeS8TRc&t=9s)

Apesar de o vídeo abordar o uso de branches `feature`, neste projeto, a princípio, elas não serão utilizadas. As funcionalidades devem partir diretamente da branch `dev`.
