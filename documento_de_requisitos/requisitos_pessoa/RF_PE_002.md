
## RF_PE_002: O sistema deve permitir que cada usuário altere sua senha

**Descrição do caso de uso:**
O sistema deve permitir que cada usuário autenticado altere sua senha de acesso, garantindo maior segurança na autenticação.

**Ator(es):** Usuário autenticado.

**Prioridade:**   [x] Essencial  [ ] Importante  [ ] Desejável

---

**Entradas e pré-condições:**

* O usuário deve estar autenticado no sistema.
* O usuário deve informar a nova senha e confirmá-la.
* A nova senha deve atender às regras de segurança definidas pelo sistema (ex.: mínimo de 8 caracteres, contendo letras e números).

---

**Saídas e pós-condição:**

* O sistema grava a nova senha do usuário no banco de dados, devidamente criptografada.
* O sistema retorna uma mensagem confirmando a alteração bem-sucedida da senha.
* O usuário poderá realizar login apenas com a nova senha.

---

**Fluxo de eventos principal:**

1. O usuário acessa o menu **Alterar Senha**.
2. O sistema exibe o formulário solicitando **senha atual**, **nova senha** e **confirmação da nova senha**.
3. O usuário preenche os campos e clica em **Salvar**.
4. O sistema valida se a senha atual está correta.
5. O sistema valida se a nova senha atende aos critérios de segurança e se a confirmação coincide.
6. O sistema atualiza a senha no banco de dados (com criptografia).
7. O sistema exibe a mensagem de sucesso.

---

**Fluxos secundários:**

* Caso a senha atual informada seja inválida:

  * O sistema exibe a mensagem **"Senha atual incorreta."**

* Caso a nova senha não atenda aos critérios de segurança:

  * O sistema exibe a mensagem **"A nova senha deve conter no mínimo 8 caracteres, incluindo letras e números."**

* Caso a confirmação da senha não coincida com a nova senha:

  * O sistema exibe a mensagem **"A confirmação da nova senha não corresponde."**

* Caso ocorra falha no banco de dados:

  * O sistema retorna uma mensagem de erro e mantém a senha anterior.

---

**Requisitos Não-Funcionais (RNF) vinculados:**

* RNF_004: As senhas devem ser armazenadas utilizando algoritmo de criptografia seguro (ex.: PBKDF2, bcrypt).
* RNF_005: A alteração de senha deve ser concluída em até 2 segundos após a validação dos dados.
* RNF_006: A interface de alteração de senha deve ser responsiva e acessível.

---

**Dicionário de termos:**

| Termo                | Descrição                                                             |
| -------------------- | --------------------------------------------------------------------- |
| Senha atual          | Senha cadastrada no sistema e utilizada pelo usuário na autenticação. |
| Nova senha           | Senha definida pelo usuário para substituir a atual.                  |
| Confirmação de senha | Campo para evitar erros de digitação ao criar nova senha.             |

---

## Dicionário de dados:

Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_PE.md](./DD_PE.md).

---