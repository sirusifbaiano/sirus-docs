# 📘 Dicionário de Dados — Módulo Chamado

Este documento descreve as estruturas de dados dos modelos relacionados ao módulo **Chamado**, incluindo suas relações, tipos de dados, restrições e observações técnicas.

---

## Modelo `Chamado`

**Descrição:**  
O modelo `Chamado` representa um registro de ocorrência no sistema, armazenando informações sobre o solicitante, local, natureza do incidente, vítimas envolvidas, situação do atendimento e fluxo de tramitação.

| Nome do Atributo | Tipo de Dado | Descrição | Restrições |
| ---------------- | ------------- | ---------- | ----------- |
| `pessoa` | ForeignKey (`Pessoa`) | Pessoa associada ao chamado | Pode ser nulo (`null=True`), opcional (`blank=True`). Exclui em cascata (`on_delete=models.CASCADE`). |
| `base` | ForeignKey (`Base`) | Base responsável pelo chamado | Pode ser nulo (`null=True`), `related_name="base_chamado"`. |
| `solicitante_nome` | CharField | Nome do solicitante do chamado | Máximo 100 caracteres. Opcional. |
| `relacao_vitima` | CharField | Relação do solicitante com a vítima | Máximo 100 caracteres. Opcional. Escolhas em `RELACAO_VITIMA_CHOICES`. |
| `achados_clinicos` | TextField | Descrição dos achados clínicos | Opcional. |
| `conduta_medica` | TextField | Conduta médica adotada | Opcional. |
| `queixa_principal` | TextField | Queixa principal do paciente ou situação | Opcional. |
| `tipo_ocorrencia` | CharField | Tipo da ocorrência registrada | Máximo 100 caracteres. Opcional. Escolhas em `CHAMADO_OCORRENCIA_CHOICES`. |
| `gravidade` | CharField | Grau de gravidade da ocorrência | Máximo 20 caracteres. Opcional. Escolhas em `CHAMADO_GRAVIDADE_CHOICES`. |
| `uf` | CharField | Unidade federativa (estado) | Máximo 2 caracteres. Obrigatório. Escolhas em `ESTADOS_BR`. |
| `cidade` | CharField | Cidade do local da ocorrência | Máximo 100 caracteres. Obrigatório. |
| `logradouro` | CharField | Endereço (rua/avenida) | Máximo 200 caracteres. Opcional. |
| `numero` | CharField | Número do endereço | Máximo 20 caracteres. Opcional. |
| `bairro` | CharField | Bairro do endereço | Máximo 100 caracteres. Opcional. |
| `cep` | CharField | Código de endereçamento postal | Máximo 10 caracteres. Opcional. |
| `complemento` | CharField | Complemento do endereço | Texto livre. Opcional. |
| `ponto_referencia` | TextField | Ponto de referência para localização | Opcional. |
| `apoio_solicitado` | CharField | Tipo de apoio solicitado | Máximo 100 caracteres. Opcional. Escolhas em `ATENDIMENTO_APOIO_CHOICES`. |
| `descricao_unidades_desejadas` | TextField | Observações gerais sobre unidades solicitadas | Opcional. |
| `numero_vitimas` | IntegerField | Número total de vítimas | Deve ser positivo (`PositiveIntegerField`). Opcional. |
| `observacoes` | TextField | Observações adicionais do chamado | Opcional. |
| `origem` | CharField | Origem do chamado | Máximo 20 caracteres. Opcional. Escolhas em `CHAMADO_ORIGEM_CHOICES`. |
| `motivo` | CharField | Motivo da ocorrência | Máximo 100 caracteres. Opcional. Escolhas em `CHAMADO_MOTIVO_CHOICES`. |
| `status` | CharField | Status atual do chamado | Máximo 20 caracteres. Padrão `'PENDENTE'`. Escolhas em `CHAMADO_STATUS_CHOICES`. |
| `latitude` | FloatField | Latitude da ocorrência | Opcional. |
| `longitude` | FloatField | Longitude da ocorrência | Opcional. |
| `localizacao_validada` | BooleanField | Indica se a localização foi validada no mapa | Padrão `False`. |
| `justificativa_encerramento` | TextField | Justificativa para o encerramento final da ocorrência | Texto livre. Opcional. |
| `orientacao` | CharField | Orientação fornecida durante o atendimento | Texto livre. Opcional. |
| `incidente` | CharField | Tipo de incidente | Máximo 100 caracteres. Opcional. Escolhas em `INCIDENTE_CHOICES`. |
| `unidade_solicitadas` | JSONField | Lista de unidades solicitadas para o atendimento | Padrão `{}`. Opcional. |
| `nome_vitimas` | JSONField | Lista com nomes provisórios das vítimas | Padrão `[]`. Opcional. |
| `criado_em` | DateTimeField | Data e hora de criação do chamado | Definido automaticamente (`auto_now_add=True`). |
| `criado_por` | ForeignKey (`User`) | Usuário que criou o chamado | Pode ser nulo (`null=True`), opcional (`blank=True`). |
| `finalizado_em` | DateTimeField | Data e hora de finalização do chamado | Opcional. |
| `finalizado_por` | ForeignKey (`User`) | Usuário que finalizou o chamado | Pode ser nulo (`null=True`), opcional (`blank=True`). |

**Propriedades:**
- `ultimo_tramite`: retorna o último trâmite do chamado.  
- `fluxo_atual`: retorna o fluxo correspondente ao setor do último trâmite.

---

## Modelo `TramiteChamado`

**Descrição:**  
Registra a movimentação (trâmite) de um chamado entre setores, incluindo origem, destino, usuários envolvidos e horários de criação e aceite.

| Nome do Atributo | Tipo de Dado | Descrição | Restrições |
| ---------------- | ------------- | ---------- | ----------- |
| `chamado` | ForeignKey (`Chamado`) | Chamado ao qual o trâmite pertence | Obrigatório (`null=False`, `blank=False`). Exclui em cascata (`on_delete=models.CASCADE`). |
| `criado_por` | ForeignKey (`User`) | Usuário que criou o trâmite | Opcional (`null=True`, `blank=True`). `related_name='tramite_criador'`. |
| `aceito_por` | ForeignKey (`User`) | Usuário que aceitou o trâmite | Opcional (`null=True`, `blank=True`). `related_name='tramite_receptor'`. |
| `setor_origem` | ForeignKey (`Setor`) | Setor de onde partiu o trâmite | Obrigatório. `related_name='tramite_origem'`. |
| `setor_destino` | ForeignKey (`Setor`) | Setor de destino do trâmite | Obrigatório. `related_name='tramite_destino'`. |
| `criado_em` | DateTimeField | Data e hora em que o trâmite foi criado | Definido automaticamente (`auto_now_add=True`). |
| `aceito_em` | DateTimeField | Data e hora em que o trâmite foi aceito | Opcional (`null=True`, `blank=True`). |

**Meta:**  
`ordering = ['aceito_por']`

---

## Modelo `UnidadeChamado`

**Descrição:**  
Representa a associação entre um chamado e uma unidade operacional enviada para atendê-lo, incluindo informações sobre alocação e status da unidade.

| Nome do Atributo | Tipo de Dado | Descrição | Restrições |
| ---------------- | ------------- | ---------- | ----------- |
| `chamado` | ForeignKey (`Chamado`) | Chamado ao qual a unidade está vinculada | Obrigatório. `related_name='unidade_chamado'`. |
| `unidade` | ForeignKey (`Unidade`) | Unidade designada para o chamado | Obrigatório. `related_name='chamado_unidade'`. |
| `alocado_por` | ForeignKey (`User`) | Usuário responsável pela alocação | Opcional. `related_name='unidade_alocado_por'`. |
| `alocado_em` | DateTimeField | Data e hora da alocação | Atualizado automaticamente (`auto_now=True`). |
| `status` | CharField | Situação atual da unidade no chamado | Obrigatório. Máximo 20 caracteres. Escolhas em `UNIDADE_CHAMADO_STATUS`. |

---

## Modelo `AtendimentoPessoa`

**Descrição:**  
Armazena os dados clínicos e operacionais referentes ao atendimento de uma pessoa em um chamado, incluindo sinais vitais, evolução, destino e conduta médica.

| Nome do Atributo | Tipo de Dado | Descrição | Restrições |
| ---------------- | ------------- | ---------- | ----------- |
| `chamado` | ForeignKey (`Chamado`) | Chamado ao qual o atendimento pertence | Obrigatório. `related_name='atendimento_chamado'`. |
| `pessoa` | ForeignKey (`Pessoa`) | Pessoa vinculada ao atendimento | Opcional. `on_delete=SET_NULL`. |
| `acompanhante` | ForeignKey (`Pessoa`) | Pessoa acompanhante | Opcional. |
| `finalizado` | BooleanField | Indica se o atendimento foi finalizado | Padrão `False`. |
| `nome_provisorio` | CharField | Nome provisório da vítima | Máximo 60 caracteres. Opcional. |
| `tipo` | CharField | Tipo de atendimento | Máximo 50 caracteres. Opcional. |
| `risco` | CharField | Classificação de risco | Máximo 50 caracteres. Opcional. |
| `queixa` | TextField | Queixa relatada | Opcional. |
| `pulso`, `pa`, `fr`, `so2`, `temperatura`, `glicemia` | CharField | Sinais vitais medidos durante o atendimento | Máximo 50 caracteres. Todos opcionais. |
| `situacaoDoLocal` | CharField | Situação observada no local | Máximo 100 caracteres. Opcional. |
| `situacaoVitima` | CharField | Situação da vítima | Máximo 100 caracteres. Opcional. |
| `usoCinto`, `usoCapacete` | CharField | Uso de equipamentos de segurança | Máximo 50 caracteres. Opcional. |
| `acidenteTrabalho` | BooleanField | Indica se foi acidente de trabalho | Padrão `False`. |
| `dataHoraChegada`, `dataHoraSaida`, `dataHoraChegadaDestino`, `dataHoraLiberacaoUnidade` | DateTimeField | Datas e horários do atendimento | Todos opcionais. |
| `observacoes` | TextField | Observações gerais | Opcional. |
| `lesaoTraumatica`, `choqueHipovolemico`, `queimadura`, `intercorreciaTransporte`, `ginecoObstetrico` | BooleanField | Indicadores clínicos do paciente | Todos opcionais (com padrões). |
| `descLesaoTraumatica`, `pele`, `tipoQueimadura`, `grauQueimadura`, `glasgow`, `dilacaoPupilar`, `descrIntercorreciaTransporte`, `destinoPaciente`, `tipoReceptor`, `nomeReceptor`, `numRegistroConselho`, `tipoEvolucao`, `conduta`, `condicaoPaciente` | CharField | Campos descritivos relacionados ao atendimento | Opcionais. |
| `percQueimadura` | FloatField | Percentual estimado de queimadura | Opcional. |
| `evolucao`, `diagnosticoMedico` | TextField | Detalhes da evolução clínica e diagnóstico | Opcionais. |

**Propriedades:**
- `nome_provisorio_asterisco`: retorna o nome provisório com sufixo `***`.

**Permissões:**
- `('detail_chamado', 'Pode ver os detalhes do atendimento do chamado')`.

---

## Observações Gerais

- Campos com `null=True` e `blank=True` são opcionais tanto no banco de dados quanto nos formulários Django.  
- `JSONField` é usado para armazenar listas ou dicionários diretamente no banco.  
- Relações com `on_delete=models.CASCADE` implicam exclusão em cascata.  
- Datas com `auto_now_add=True` são definidas automaticamente na criação.  
- Todos os modelos incluem referências explícitas a usuários (`User`) e entidades operacionais (`Setor`, `Unidade`, `Pessoa`).

---
