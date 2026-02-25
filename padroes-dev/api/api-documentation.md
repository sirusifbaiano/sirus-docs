# Documentação da API SAMU

A API está documentada de forma interativa utilizando Swagger e Redoc.

## Acesso à Documentação

* Swagger UI: [http://localhost:8000/swagger/](http://localhost:8000/swagger/)
* Redoc: [http://localhost:8000/redoc/](http://localhost:8000/redoc/)

## Autenticação

Esta API utiliza autenticação por token.

### Instruções:

1. Gere seu token de autenticação via painel admin.

2. No Swagger, clique no botão **Authorize**.

3. Insira o token no seguinte formato:

   ```
   Token seu_token_aqui
   ```
 É necessário usar o prefixo "Token"

4. Clique em **Authorize** e depois em **Close**.

## Importar via Postman

Você também pode importar os endpoints da API no Postman utilizando o arquivo de coleção:

**Arquivo:** `samu.postman_collection.json`

No Postman:

1. Clique em *Import*.
2. Selecione o arquivo `samu.postman_collection.json`.
3. Após importar, adicione o token no cabeçalho das requisições como:

   ```
   Authorization: Token seu_token_aqui
   ```

Mas já está previamente configurado

Agora você está autorizado a realizar chamadas autenticadas na API diretamente pela interface Swagger ou via Postman.

---

