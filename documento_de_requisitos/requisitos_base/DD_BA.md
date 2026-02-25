##  Dicionários de dados do modelo Base

**Descrição:** Este dicionário de dados descreve os atributos do modelo `Base`, que representa o local onde as unidades de atendimento estão alocadas, os setores são criados, o colaborador responsável é definido e outras informações relevantes.


| Nome do Atributo | Tipo de Dado          | Descrição                          | Restrições                                                                 |
|-------------------|-----------------------|--------------------------------------|----------------------------------------------------------------------------|
| `responsavel`     | ForeignKey           | Usuário responsável pela base       | Pode ser nulo (`null=True`) e opcional (`blank=True`). Relacionado com `auth.User`. |
| `nome`            | CharField            | Nome da base                        | Máximo de 255 caracteres.                                                 |
| `cidade`          | CharField            | Cidade onde a base está localizada  | Máximo de 255 caracteres.                                                 |
| `uf`              | CharField            | Estado (UF)                         | Máximo de 2 caracteres. Deve ser uma das opções definidas em `ESTADOS_BR`. Pode ser nulo. |
| `logradouro`      | CharField            | Logradouro                          | Máximo de 255 caracteres. Opcional (`null=True`, `blank=True`).           |
| `bairro`          | CharField            | Bairro                              | Máximo de 255 caracteres. Opcional (`null=True`, `blank=True`).           |
| `numero`          | CharField            | Número                              | Máximo de 20 caracteres. Opcional (`null=True`, `blank=True`).            |
| `complemento`     | CharField            | Complemento                         | Máximo de 255 caracteres. Opcional (`null=True`, `blank=True`).           |
| `central`         | ForeignKey           | Base central                        | Relacionamento com a própria classe `Base`. Pode ser nulo e opcional.     |
| `criado_em`       | DateTimeField        | Data de criação                     | Preenchido automaticamente no momento da criação (`auto_now_add=True`).   |
| `criado_por`      | ForeignKey           | Usuário que criou a base            | Relacionado com `auth.User`. Obrigatório.                                 |

**Observações**
- Os atributos `responsavel` e `criado_por` utilizam a tabela de usuários padrão do Django (`auth.User`) para relacionamentos.
- O atributo `central` permite que uma base seja associada a outra como sua base central.
- Os campos opcionais (`null=True`, `blank=True`) podem ser deixados em branco ou nulos no banco de dados.