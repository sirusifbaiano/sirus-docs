## RF_PE_003: O sistema deve permitir que cada usuário remova sua foto de perfil

**Descrição do caso de uso:**
O sistema deve permitir que o usuário autenticado remova sua foto de perfil, retornando à imagem padrão do sistema.

**Ator(es):** Usuário autenticado.

**Prioridade:**   [ ] Essencial  [x] Importante  [ ] Desejável

---

**Entradas e pré-condições:**

* O usuário deve estar autenticado no sistema.
* O usuário deve possuir uma foto de perfil cadastrada.

---

**Saídas e pós-condição:**

* O sistema remove a foto atual do perfil e substitui pela imagem padrão.
* O sistema retorna uma mensagem de confirmação da remoção da foto.

---

**Fluxo de eventos principal:**

1. O usuário acessa a página de **Editar Perfil**.
2. O usuário clica na opção **Remover Foto**.
3. O sistema solicita confirmação da ação.
4. O usuário confirma a remoção.
5. O sistema exclui a foto do diretório de mídia.
6. O sistema vincula a imagem padrão ao usuário.
7. O sistema exibe mensagem de sucesso.

---

**Fluxos secundários:**

* Caso o usuário não possua foto cadastrada:

  * O sistema exibe a mensagem **"Você não possui foto para remover."**

* Caso ocorra erro ao remover a foto (ex.: falha no servidor de arquivos):

  * O sistema exibe a mensagem **"Erro ao remover foto de perfil. Tente novamente."**

---

**Requisitos Não-Funcionais (RNF) vinculados:**

* RNF_002: O sistema deve suportar upload e exclusão de imagens de até 5MB.
* RNF_003: O sistema deve ser responsivo e acessível em diferentes dispositivos.
* RNF_007: O sistema deve liberar espaço em disco após a exclusão da imagem de perfil.

---

**Dicionário de termos:**

| Termo              | Descrição                                                                           |
| ------------------ | ----------------------------------------------------------------------------------- |
| Foto de perfil     | Imagem associada ao usuário, exibida no topbar e nas páginas do sistema.            |
| Imagem padrão      | Imagem genérica utilizada pelo sistema quando o usuário não possui foto cadastrada. |
| Diretório de mídia | Local onde as imagens de perfil são armazenadas no servidor.                        |

## Dicionário de dados:

Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_PE.md](./DD_PE.md).

---