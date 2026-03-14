## Dicionários de dados do modelo Colaborador

**Descrição:** Este dicionário de dados descreve os atributos do modelo `Colaborador`. Este modelo utiliza **herança de multi-tabela (Multi-table Inheritance)** em relação ao modelo `Pessoa`. Ele representa os profissionais que atuam no sistema, estendendo os dados pessoais com informações de atuação técnica e registros profissionais.

| Nome do Atributo | Tipo de Dado | Descrição | Restrições                                                                                 |
| --- | --- | --- |--------------------------------------------------------------------------------------------|
| `funcao` | CharField | Atuação técnica ou cargo do profissional | Máximo de 30 caracteres. Escolha em `COLABORADOR_FUNCAO_CHOICES`. Opcional (`blank=True`). |
| `registro_profissional` | CharField | Identificação de conselho de classe (CRM, etc) | Máximo de 50 caracteres. Opcional (`null=True`, `blank=True`).                             |
| *(Atributos de Pessoa)* | - | Todos os campos definidos no modelo `Pessoa` | Herdados via vínculo de herança. Acessíveis diretamente pela instância de `Colaborador`.   |

**Observações**

* O modelo `Colaborador` herda todos os campos de `Pessoa`. No banco de dados, isso é implementado através de um `OneToOneField` implícito que atua como chave primária.
* O campo `funcao` utiliza a lista de constantes `COLABORADOR_FUNCAO_CHOICES`, que inclui: `MEDICO`, `ENFERMEIRO`, `TECNICO_ENFERMAGEM`, `CONDUTOR`, `TARM` e `RADIO_OPERADOR`.
* Embora o campo `funcao` seja tecnicamente opcional no banco de dados (`blank=True`), a regra de negócio aplicada na camada de interface (`forms.py`) exige o seu preenchimento para a conclusão do cadastro.
