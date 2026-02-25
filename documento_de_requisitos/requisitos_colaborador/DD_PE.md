## Dicionários de dados do modelo Pessoa

**Descrição:** Este dicionário de dados descreve os atributos do modelo `Pessoa`, que representa os dados pessoais, clínicos e de contato de indivíduos, vinculados opcionalmente a um usuário do sistema, pessoas com usuário associado são **Colaboradores**.

| Nome do Atributo         | Tipo de Dado  | Descrição                                         | Restrições                                                                                 |
| ------------------------ | ------------- | ------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| `imagem_perfil`          | ImageField    | Foto de perfil da pessoa                          | Armazenada em `perfil/`. Opcional (`null=True`, `blank=True`).                             |
| `usuario`                | OneToOneField | Usuário do sistema associado                      | Relacionado com `auth.User`. Opcional (`null=True`, `blank=True`).                         |
| `nome`                   | CharField     | Nome completo da pessoa                           | Máximo de 100 caracteres. Obrigatório.                                                     |
| `email`                  | EmailField    | E-mail da pessoa                                  | Único. Opcional (`null=True`, `blank=True`).                                               |
| `rg`                     | CharField     | Documento de identidade (RG)                      | Único. Máximo de 20 caracteres. Opcional (`null=True`, `blank=True`).                      |
| `cpf`                    | CharField     | Cadastro de Pessoa Física (CPF)                   | Máximo de 14 caracteres (com pontuação). Obrigatório. Único. Validação via `validate_cpf`. |
| `dataNascimentoReal`     | DateField     | Data de nascimento real                           | Opcional (`null=True`, `blank=True`).                                                      |
| `dataNascimentoEstimada` | DateField     | Data de nascimento estimada                       | Opcional (`null=True`, `blank=True`).                                                      |
| `sexo`                   | CharField     | Sexo da pessoa                                    | Até 2 caracteres. Escolha em `SEXO_OPCOES`. Opcional.                                      |
| `estadoCivil`            | CharField     | Estado civil                                      | Até 20 caracteres. Escolha em `ESTADO_CIVIL_OPCOES`. Opcional.                             |
| `nacionalidade`          | CharField     | Nacionalidade                                     | Até 2 caracteres. Escolha em `PAISES`. Valor padrão `"BR"`.                                |
| `naturalidade`           | CharField     | Naturalidade (cidade de origem)                   | Máximo de 200 caracteres. Opcional.                                                        |
| `telefone`               | CharField     | Telefone fixo                                     | Máximo de 20 caracteres. Opcional.                                                         |
| `telefoneCelular`        | CharField     | Telefone celular                                  | Máximo de 20 caracteres. Opcional.                                                         |
| `uf`                     | CharField     | Estado (UF) de residência                         | Até 2 caracteres. Escolha em `ESTADOS_BR`. Opcional.                                       |
| `cidade`                 | CharField     | Cidade de residência                              | Máximo de 100 caracteres. Opcional.                                                        |
| `logradouro`             | CharField     | Logradouro (rua, avenida, etc.)                   | Máximo de 200 caracteres. Opcional.                                                        |
| `numero`                 | CharField     | Número da residência                              | Máximo de 20 caracteres. Opcional.                                                         |
| `complemento`            | CharField     | Complemento do endereço                           | Máximo de 100 caracteres. Opcional.                                                        |
| `bairro`                 | CharField     | Bairro de residência                              | Máximo de 100 caracteres. Opcional.                                                        |
| `cep`                    | CharField     | Código de Endereçamento Postal                    | Máximo de 10 caracteres. Opcional.                                                         |
| `historicoClinico`       | TextField     | Histórico clínico do paciente                     | Opcional.                                                                                  |
| `nomeMae`                | CharField     | Nome da mãe                                       | Máximo de 100 caracteres. Opcional.                                                        |
| `nomePai`                | CharField     | Nome do pai                                       | Máximo de 100 caracteres. Opcional.                                                        |
| `telefoneMae`            | CharField     | Telefone da mãe                                   | Máximo de 20 caracteres. Opcional.                                                         |
| `telefonePai`            | CharField     | Telefone do pai                                   | Máximo de 20 caracteres. Opcional.                                                         |
| `telefoneResponsavel`    | CharField     | Telefone do responsável legal                     | Máximo de 20 caracteres. Opcional.                                                         |
| `telefoneContato`        | CharField     | Telefone para contato                             | Máximo de 20 caracteres. Opcional.                                                         |
| `telefoneRecado`         | CharField     | Telefone para recado                              | Máximo de 20 caracteres. Opcional.                                                         |
| `tipoSanguineo`          | CharField     | Tipo sanguíneo                                    | Até 5 caracteres. Escolha em `TIPO_SANGUINEO_OPCOES`. Opcional.                            |
| `alergias`               | TextField     | Alergias conhecidas                               | Opcional.                                                                                  |
| `doencasPreExistentes`   | TextField     | Doenças pré-existentes                            | Opcional.                                                                                  |
| `medicamentosEmUso`      | TextField     | Medicamentos em uso                               | Opcional.                                                                                  |
| `deficienciaVisual`      | BooleanField  | Indica se a pessoa possui deficiência visual      | Valor padrão `False`.                                                                      |
| `deficienciaAuditiva`    | BooleanField  | Indica se a pessoa possui deficiência auditiva    | Valor padrão `False`.                                                                      |
| `deficienciaMotora`      | BooleanField  | Indica se a pessoa possui deficiência motora      | Valor padrão `False`.                                                                      |
| `deficienciaIntelectual` | BooleanField  | Indica se a pessoa possui deficiência intelectual | Valor padrão `False`.                                                                      |
| `observacoes`            | TextField     | Observações gerais                                | Opcional.                                                                                  |
| `criado_por`             | ForeignKey    | Usuário que criou o registro                      | Relacionado com `auth.User`. Opcional (`null=True`, `blank=True`).                         |
| `criado_em`              | DateTimeField | Data de criação do registro                       | Preenchido automaticamente (`auto_now_add=True`).                                          |
| `base_cadastro`          | ForeignKey    | Base onde a pessoa foi cadastrada                 | Relacionado com `Base`. Opcional (`null=True`, `blank=True`).                              |

**Observações**

* Os atributos `usuario`, `criado_por` e `base_cadastro` usam relacionamentos (`auth.User` e `Base`).
* O campo `cpf` é obrigatório e validado por regra própria (`validate_cpf`) para garantir formato e dígitos verificadores.
* Os campos de contato e de endereço são opcionais, podendo ser preenchidos parcialmente.
* Campos booleanos de deficiência permitem indicar múltiplas condições.