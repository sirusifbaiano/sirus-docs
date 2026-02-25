## RF_BA_007: O sistema deve permitir receber o chamado

**Descrição do caso de uso:**
O sistema deve permitir que o usuário **receba** um chamado encaminhado para o seu setor, registrando o responsável (`aceito_por`), a data/hora do recebimento (`aceito_em`) e atualizando o status do chamado para **"EM_ANDAMENTO"**.

**Ator(es):**
Usuários que pertençam ao **setor de destino** do último trâmite do chamado.

**Prioridade:**
[x] Essencial  [ ] Importante  [ ] Desejável

---

### **Entradas e Pré-condições:**
- O usuário deve pertencer ao **setor** correspondente ao **setor_destino** do último trâmite do chamado.
- O chamado **não pode já ter sido aceito** por outro usuário do mesmo setor.
- Deve existir um **fluxo configurado** para a base atual, conforme [RF_FL_001](./../requisitos_fluxo/RF_FL_001.md).
---

### **Saídas e Pós-condições:**

- O trâmite é atualizado com os metadados.
- O status do chamado é atualizado para **“EM_ANDAMENTO”**.
- O sistema redireciona o usuário para a **página da etapa correspondente** do fluxo.
- Caso o recebimento não seja possível, o sistema exibe uma mensagem de erro e redireciona o usuário para a **lista de chamados**.

---

### **Fluxo de Eventos Principal:**

1. O usuário seleciona a opção **“Receber chamado”**.
2. O sistema verifica se o usuário pertence ao setor de destino do chamado.
3. O sistema busca o último trâmite do chamado referente a esse setor (`setor_destino`).
4. O sistema verifica se o trâmite **já foi aceito**:

   * Se **não foi aceito**, registra o recebimento (`aceito_por`, `aceito_em`) e altera o status do chamado para **“EM_ANDAMENTO”**.
   * Se **já foi aceito**, exibe mensagem informando o nome do usuário que já o recebeu.
5. O sistema verifica no **Fluxo de Chamado** qual é a etapa correspondente ao setor de destino.
6. O sistema redireciona o usuário para a **página da etapa** do fluxo (`chamado-etapa-{ordem}`).

---

### **Fluxos Secundários:**

- **Usuário sem permissão:**
  Se o usuário não for membro do setor de destino, o sistema retorna erro:
  **“Você não tem permissão para receber chamados nesse setor.”** (HTTP 403 - Forbidden)

- **Chamado já aceito:**
  Se o chamado já tiver sido recebido por outro usuário, o sistema exibe:
  **“Esse chamado já foi aceito no setor {setor} por {usuário}.”**

- **Fluxo inexistente:**
  Caso o sistema não encontre o fluxo para o setor de destino, é exibida a mensagem:
  **“Fluxo não encontrado para o setor de destino.”**

- **Chamado inexistente:**
  Caso o chamado informado não exista, o sistema retorna **“Chamado não encontrado.”**

---

### **Requisitos Não-Funcionais (RNF) vinculados:**

- **RNF_001:** A operação de recebimento deve ser processada em menos de 3 segundos.
- **RNF_002:** O sistema deve seguir padrões de acessibilidade.

---

### **Dicionário de Dados:**

Para mais detalhes sobre os campos utilizados no recebimento de chamados, consulte o arquivo [DD_CH.md](./DD_CH.md).

---