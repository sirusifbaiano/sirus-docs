
## RF_PE_001: O sistema deve permitir que cada usuário visualize e edite seu perfil

**Descrição do caso de uso:**
O sistema deve permitir que cada usuário autenticado visualize e edite seu perfil pessoal, incluindo a foto e os dados cadastrados.

**Ator(es):** Usuário autenticado.

**Prioridade:**   [x] Essencial  [ ] Importante  [ ] Desejável

---

**Entradas e pré-condições:**

* O usuário deve estar autenticado no sistema.
* Deve existir uma instância de `Pessoa` vinculada ao usuário (`Pessoa.usuario`).
* O usuário não pode ser superusuário (estes são redirecionados para o dashboard e não acessam o perfil).

---

**Saídas e pós-condição:**

* O sistema retorna uma mensagem informando o resultado da operação (perfil visualizado ou atualizado com sucesso).
* O sistema atualiza a imagem e os dados pessoais no banco de dados, quando alterados.

---

**Fluxo de eventos principal:**

1. O usuário acessa o menu **Perfil** no topbar.
2. O sistema exibe a página de **Visualização de Perfil**, mostrando dados da `Pessoa` vinculada ao usuário.
3. O usuário pode selecionar a opção **Editar Perfil**.
4. O sistema exibe o formulário com os dados já preenchidos.
5. O usuário altera os dados desejados (ex.: nome, foto).
6. O usuário clica no botão **Salvar**.
7. O sistema grava as alterações no banco de dados.
8. O sistema retorna uma mensagem de sucesso.

---

**Fluxos secundários:**

* Caso a pessoa vinculada ao usuário não seja encontrada:

  * O sistema retorna uma mensagem **"Perfil não encontrado ou você não tem permissão para acessá-lo."**
  * O usuário é redirecionado para o dashboard.

* Caso o usuário seja superusuário:

  * O sistema exibe a mensagem **"Administradores não podem acessar o perfil."**
  * O usuário é redirecionado para o dashboard.

* Caso a operação de salvar falhe (ex.: problema no banco de dados):

  * O sistema exibe uma mensagem de erro.

* Caso o usuário tente alterar um perfil que não é dele:

  * O sistema retorna **erro HTTP 403 (Forbidden)**.

---

**Requisitos Não-Funcionais (RNF) vinculados:**

* RNF_001: O sistema deve carregar a página de perfil em menos de 3 segundos.
* RNF_002: O sistema deve suportar upload de imagens de perfil com tamanho de até 5MB.
* RNF_003: O sistema deve ser responsivo e acessível, garantindo que a visualização e edição do perfil funcionem em dispositivos móveis e leitores de tela.

---

## Dicionário de termos:

| Termo               | Descrição                                                                                      |
| ------------------- | ---------------------------------------------------------------------------------------------- |
| Perfil              | Conjunto de informações pessoais de cada usuário no sistema, armazenadas na entidade `Pessoa`. |
| Usuário autenticado | Pessoa que possui login e senha cadastrados no sistema.                                        |
| Foto de perfil      | Imagem associada ao usuário, exibida no topbar e nas páginas do sistema.                       |
| Dashboard           | Página inicial do sistema acessada após o login.                                               |

---

## Dicionário de dados:

Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_PE.md](./DD_PE.md).

---

