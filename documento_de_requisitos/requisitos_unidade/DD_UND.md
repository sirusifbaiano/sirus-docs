##  Dicionários de dados do modelo Unidade

**Descrição:** Este dicionário de dados descreve os atributos do modelo `Unidade`, que representa a unidade de atendimento móvel destinada ao suporte e deslocamento em chamados.


## Dicionário de dados:
| Nome do Atributo | Tipo de Dado      | Descrição                          | Restrições                                                                | 
|-------------------|------------------|------------------------------------|---------------------------------------------------------------------------|
| `id`              | AutoField(PK)    | Identificador único da unidade     | preenchidos automaticamente                                               |
| `base`            | ForeignKey       | Base vinculada                     | Relacionado com `Base`. (`null=True`, `blank=True`)                       |
| `nome`            | CharField        | Nome da unidade                    | Máximo de 255 caracteres.                                                 |
| `tipo`            | CharField        | Tipo de unidade (USB/USA/MOBU)     | Máximo de 255 caracteres. (`null=True`, `blank=True`)                     |
| `fabricante`      | CharField        | Fabricante do veículo (ex: "Mercedes-Benz") | Máximo de 255 caracteres.                                        |
| `modelo`          | CharField        | Modelo do veículo (ex: "Sprinter 515")      | Máximo de 255 caracteres.                                        |
| `cor`             | CharField        | Cor predominante da unidade         | Máximo de 255 caracteres. Opcional (`null=True`, `blank=True`).          |
| `chassi`          | CharField        | Número do chassi (único)            | Máximo de 255 caracteres. Opcional (`null=True`, `blank=True`).          |
| `renavam`         | CharField        | Código RENAVAM (único)              | Máximo de 255 caracteres. Opcional (`null=True`, `blank=True`).          |
| `placa`           | CharField        | Placa do veículo (formato AAA0X00, único)| Máximo de 255 caracteres.                                           |
| `status`          | CharField        | Status operacional (Disponível/Manutenção/Em ocorrência/Em limpeza terminal) | Máximo de 255 caracteres. Opcional (`null=True`, `blank=True`). |
| `lotacao`         | IntegerField     | Capacidade de transporte (≥1 pessoa)         | Opcional (`null=True`, `blank=True`).                           |
| `ano`             | IntegerField     | Ano de fabricação (1900-ano atual)           | Opcional (`null=True`, `blank=True`).                           |
| `criado_em`       | CharField        | Data/hora de criação automática              | preenchidos automaticamente                                     |
| `criado_por`      | CharField        | Usuário responsável pelo cadastro            | preenchidos automaticamente                                     |


**Observações**
- O atributo `criado_por` utiliza a tabela de usuários padrão do Django (`auth.User`) para relacionamentos.
- Os campos opcionais (`null=True`, `blank=True`) podem ser deixados em branco ou nulos no banco de dados.
