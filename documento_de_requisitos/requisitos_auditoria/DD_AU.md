# 📘 Dicionário de Dados — Módulo Auditoria

Este documento descreve as estruturas de dados e registros utilizados pelo módulo **Auditoria**, incluindo logs de acesso e registros gerados pelo `django-auditlog`.

---

## Modelo `UserSessionLog`

**Descrição:**  
O modelo `UserSessionLog` representa um acesso autenticado ao sistema. Cada login bem-sucedido gera um registro com usuário, IP, navegador, dispositivo, geolocalização e data do acesso.

| Nome do Atributo | Tipo de Dado | Descrição | Restrições |
| ---------------- | ------------- | ---------- | ----------- |
| `usuario` | ForeignKey (`User`) | Usuário autenticado no acesso registrado | Obrigatório. Relacionado com `AUTH_USER_MODEL`. Exclui em cascata (`on_delete=models.CASCADE`). |
| `endereco_ip` | GenericIPAddressField | Endereço IP utilizado no acesso | Opcional (`null=True`, `blank=True`). |
| `agente_usuario` | TextField | Agente do usuário bruto enviado pelo navegador | Opcional (`blank=True`). |
| `navegador` | CharField | Nome do navegador identificado a partir do agente do usuário | Máximo de 100 caracteres. Opcional (`blank=True`). |
| `dispositivo` | CharField | Dispositivo e sistema operacional identificados a partir do agente do usuário | Máximo de 100 caracteres. Opcional (`blank=True`). |
| `geolocalizacao` | JSONField | Dados de geolocalização do acesso | Valor padrão `{}`. Opcional (`blank=True`). |
| `criado_em` | DateTimeField | Data e hora do acesso | Definido automaticamente (`auto_now_add=True`). |

**Observações**
- O modelo é registrado no `django-auditlog`, permitindo gerar `LogEntry` para criação e atualização dos registros de acesso.
- O método `get_additional_data` envia IP, agente do usuário, navegador, dispositivo e geolocalização para `LogEntry.additional_data`.
- O atributo `geolocalizacao` armazena dados auxiliares de localização do acesso, como origem, cidade aproximada, coordenadas e estado da permissão do navegador.
- A geolocalização pode ter origem aproximada por IP ou coordenadas informadas pelo navegador, quando o usuário autoriza a captura.

---

## Registro `LogEntry` do `django-auditlog`

**Descrição:**  
O módulo Auditoria utiliza a tabela de logs do `django-auditlog` para consultar alterações em objetos auditáveis do sistema.

| Nome do Atributo | Tipo de Dado | Descrição | Restrições |
| ---------------- | ------------- | ---------- | ----------- |
| `content_type` | ForeignKey (`ContentType`) | Modelo auditado pelo registro | Obrigatório. |
| `object_id` | TextField | Identificador do objeto auditado | Armazenado como texto pelo `auditlog`. |
| `object_repr` | CharField | Representação textual do objeto auditado | Gerado pelo `auditlog`. |
| `action` | PositiveSmallIntegerField | Ação registrada: criação, edição ou exclusão | Valores definidos pelo `LogEntry.Action`. |
| `changes` | JSONField/TextField | Alterações registradas no objeto | Pode variar conforme a versão/configuração do `auditlog`. |
| `actor` | ForeignKey (`User`) | Usuário responsável pela ação | Pode ser nulo quando a alteração é feita pelo sistema. |
| `timestamp` | DateTimeField | Data e hora do registro | Definido pelo `auditlog`. |
| `additional_data` | JSONField | Dados complementares do objeto auditado | Usado para metadados dos logs de acesso. |

**Observações**
- A auditoria de chamados consulta logs do próprio chamado e de registros operacionais associados ao atendimento.
- Os nomes técnicos dos atributos de `LogEntry` seguem o contrato do `django-auditlog`.
- A tela central pode resumir registros auditados para facilitar a consulta operacional.
- A tela específica de auditoria do chamado exibe a linha do tempo completa do chamado e registros dependentes.

**Observações Gerais**
- A falha de registro ou enriquecimento de auditoria não deve impedir login ou navegação do usuário.
- O acesso à tela central e à auditoria do chamado depende da permissão `auditoria.view_usersessionlog`.
- A auditoria de chamados preserva logs mesmo quando há alteração ou exclusão do objeto auditado, desde que o registro exista no `auditlog`.
