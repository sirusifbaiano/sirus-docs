## Dicionários de dados do modelo Fluxo

**Descrição:** Este dicionário de dados descreve os atributos do modelo `Fluxo`, que representa o fluxo de chamado, determinando as etapas do processo e os setores responsáveis em cada fase.

| Nome do Atributo | Tipo de Dado          | Descrição                          | Restrições                                                                 |
|-----------------|---------------------|-----------------------------------|----------------------------------------------------------------------------|
| `central`       | ForeignKey           | Central de regulação associada ao fluxo | Relacionamento com o modelo `Base`. Obrigatório. Relacionado à base central que gerencia o fluxo. |
| `setor`         | ForeignKey           | Setor responsável por uma etapa do fluxo | Relacionamento com o modelo `Setor`. Obrigatório. Cada etapa deve ter um setor definido. |
| `ordem`         | PositiveIntegerField | Ordem de execução da etapa do fluxo | Valores positivos. Indica a sequência das etapas, do menor para o maior. Obrigatório. |
| `criado_em`     | DateTimeField        | Data e hora de criação do registro do fluxo | Preenchido automaticamente no momento da criação (`auto_now_add=True`). Obrigatório. |
| `atualizado_em` | DateTimeField        | Data e hora da última atualização do registro do fluxo | Atualizado automaticamente sempre que o registro é modificado (`auto_now=True`). Obrigatório. |

**Observações**
- Cada fluxo de chamado deve conter exatamente 4 etapas, cada uma associada a um setor previamente cadastrado.  
- Os campos `criado_em` e `atualizado_em` são gerenciados automaticamente pelo Django.  
- Os relacionamentos com `Base` e `Setor` garantem integridade referencial no banco de dados.
