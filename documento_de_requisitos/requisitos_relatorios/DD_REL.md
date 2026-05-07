## Dicionário de dados do modelo Relatorio

**Descrição:** Este dicionário de dados descreve os atributos do modelo `Relatorio`, responsável por armazenar os modelos de relatórios utilizados pelo sistema.

| Nome do Atributo | Tipo de Dado    | Descrição                                      | Restrições                                                                 |
|-------------------|-----------------|--------------------------------------------------|----------------------------------------------------------------------------|
| `nome`            | CharField       | Nome do relatório                               | Máximo de 100 caracteres.                                                 |
| `descricao`       | CharField       | Descrição resumida do relatório                 | Máximo de 250 caracteres. Pode ser nulo (`null=True`).                    |
| `html`            | TextField       | Estrutura HTML do relatório                     | Campo obrigatório.                                                        |
| `criado_em`       | DateTimeField   | Data de criação do relatório                    | Preenchido automaticamente (`auto_now_add=True`).                         |
| `base`            | ForeignKey      | Base associada ao relatório                     | Relacionado com o modelo `Base`. Obrigatório.                             |

**Observações**
- O atributo `html` armazena a estrutura completa do relatório gerado pelo editor visual.
- O atributo `base` relaciona o relatório a uma base específica do sistema.
