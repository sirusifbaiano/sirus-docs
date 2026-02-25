## RF_BA_008: O sistema deve permitir encaminhar o chamado para o próximo setor

**Descrição do caso de uso:**
O sistema deve permitir encaminhar o chamado para o **próximo setor** conforme definido no [Fluxo de Chamado](./../requisitos_fluxo/readme.md).
O encaminhamento é **sequencial**, sempre no sentido **para frente**, seguindo a ordem estabelecida no fluxo configurado para a base.

**Ator(es):**
Usuários pertencentes ao setor relacionado à **etapa atual** do fluxo de chamado.

**Prioridade:**
[x] Essencial  [ ] Importante  [ ] Desejável

---

### **Entradas e Pré-condições:**

- Deve existir um [**Fluxo de Chamado**](./../requisitos_fluxo/readme.md) configurado para a base atual ou central (ver [RF_FL_001](./../requisitos_fluxo/RF_FL_001.md)).
- O usuário deve pertencer ao setor vinculado à **etapa atual** do chamado.
- Para encaminhar um chamado já existente, o **último trâmite** deve ter sido **recebido (aceito)** por um usuário do setor atual.
- Caso seja o **primeiro encaminhamento**, o sistema identifica automaticamente o **primeiro setor (origem)** e o **segundo setor (destino)** do fluxo para iniciar o trâmite.

---

### **Saídas e Pós-condições:**

- É criado um novo registro de `TramiteChamado`, contendo as informações de **setor de origem**, **setor de destino**, **usuário criador** e **data/hora de criação**.
- O sistema exibe uma mensagem de sucesso informando o nome do novo setor de destino.
- Caso o encaminhamento não seja possível, o sistema exibe mensagem de erro e **não cria o trâmite**.

---

### **Fluxo de Eventos Principal:**

1. O usuário seleciona o chamado desejado.
2. O sistema verifica se o chamado possui trâmites anteriores:

   - Se **não houver**, cria o primeiro trâmite usando o **primeiro** e **segundo** setor do fluxo.
   - Se **já houver**, o sistema verifica se o **último trâmite** foi **aceito** (`aceito_por` preenchido).
3. O sistema identifica a **posição atual** no fluxo e obtém o **próximo setor** de acordo com a ordem (`ordem + 1`).
4. O sistema cria um novo registro de `TramiteChamado` com:

   - `setor_origem` = setor atual
   - `setor_destino` = próximo setor no fluxo
   - `criado_por` = usuário autenticado
   - `criado_em` = data/hora atual
5. O sistema exibe a mensagem:
   **“Chamado encaminhado para o setor {nome do setor}.”**

---

### **Fluxos Secundários:**

- **Chamado não encontrado:**
  O sistema retorna a mensagem **“Chamado não encontrado.”**

- **Usuário sem permissão:**

  - O sistema não exibe a opção de encaminhar chamado.
  - Caso o usuário tente acessar diretamente pela URL, o sistema retorna **erro HTTP 403 (Forbidden)**.

- **Chamado não recebido:**
  Se o último trâmite ainda não tiver sido aceito (`aceito_por` nulo), o sistema exibe:
  **“Não foi possível tramitar o chamado. Antes de encaminhar um chamado para um novo setor, é necessário que ele seja recebido no setor atual.”**

- **Fluxo inconsistente:**
  Caso não exista um próximo setor no fluxo, o sistema retorna erro:
  **“Próximo setor não encontrado. Verifique o fluxo de trabalho da central.”**

---

### **Requisitos Não-Funcionais (RNF) vinculados:**

- **RNF_001:** O encaminhamento deve ser processado em menos de 3 segundos.
- **RNF_002:** O sistema deve seguir padrões de acessibilidade.

---

### **Dicionário de Dados:**

Para mais detalhes sobre os campos e estrutura de dados utilizados, consulte o arquivo [DD_CH.md](./DD_CH.md).

---