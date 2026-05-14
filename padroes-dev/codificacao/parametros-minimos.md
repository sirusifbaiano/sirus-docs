# Validador de Parâmetros Mínimos por Base (`rules.py`)

Este documento detalha o funcionamento, a motivação e as diretrizes de uso do ecossistema de validação declarativa de parâmetros configurados no SIRUS.

---

## 1. O Que É?

É um motor de checagem em tempo de execução que impede que módulos ou serviços do SIRUS fiquem inoperantes de forma silenciosa devido à falta de configurações obrigatórias no banco de dados.

A arquitetura é dividida em duas partes:

1. **`rules.py` (Árvore Declarativa):**
   Um arquivo centralizador onde o desenvolvedor dita as regras de negócio de forma visual (quais chaves pertencem a qual app, quais são obrigatórias e sob quais condições).

2. **`checker.py` (O Motor):**
   Um validador genérico que processa as regras em memória com altíssima performance (`O(1)` de busca), isolando estritamente os contextos de cada base.

---

## 2. Por Que Usar? (Motivação)

No ecossistema do SAMU (SIRUS), diferentes bases ou instâncias utilizam recursos variados.

Por exemplo: uma base usa telefonia VOIP (Asterisk), enquanto outra pode usar apenas rádio.

Se o administrador ativar o VOIP mas esquecer de preencher a senha do banco de dados do Asterisk, o sistema falhará em produção.

O validador resolve isso:

- **Prevenção de Falhas:** Diagnostica ausências antes que o erro estoure na tela do usuário.
- **Autoexplicativo (Helpers):** Fornece instruções claras e imediatas na interface do sistema sobre para que serve o parâmetro e como corrigi-lo.
- **Centralização:** Evita que validações fiquem espalhadas em dezenas de `views.py` ou `forms.py`.

---

## 3. Como Funciona a Anatomia do Dicionário

As regras são definidas na constante `REGRAS_PARAMETROS`.

Cada elemento do dicionário cumpre um papel estrito:

- **Chave de Escopo/Contexto**
  Exemplo: `"GLOBAL"`, `"UNIDADE"`, `"CHAMADO"`

  Delimita o aplicativo ou módulo. Deve coincidir exatamente com as opções do campo `app` presentes no Model de Parâmetros para garantir o isolamento total.

- **Chave do Parâmetro Mestre**
  Exemplo: `"USE_VOIP"`, `"MAX_TEMPO"`

  É o parâmetro principal avaliado. O motor exige que ele exista e esteja preenchido no banco de dados por padrão.

- **`valor_gatilho`**

  Condição que dispara dependências.

  Se o valor atual no banco for igual ao gatilho, a lista `exige_chaves` é cobrada.

  Se for `None`, a verificação de gatilho é ignorada e as chaves filhas tornam-se obrigatórias incondicionalmente.

- **`exige_chaves`**

  Lista contendo os parâmetros secundários que passam a ser exigidos dentro do mesmo contexto caso o gatilho dispare.

- **`helper`**

  Texto explicativo que é injetado diretamente no HTML de alertas (opcional).

---

## 4. Como Usar (As 4 Variações de Escrita)

Ao criar ou atualizar regras, você pode adotar quatro sintaxes diferentes com base na complexidade do cenário.

---

### Variação A: Obrigatório Isolado (Sem Ajuda)

Use quando o parâmetro simplesmente precisa existir e o nome da chave já é óbvio para a equipe técnica.

```python
"UNIDADE": {
    "VERSAO_CONVENIO": None
}
```

---

### Variação B: Obrigatório Isolado (Com Helper Simplificado)

A forma mais rápida e elegante de criar um parâmetro obrigatório e já documentá-lo.

Basta passar uma string direta no valor da chave.

```python
"CHAMADO": {
    "ETAPA1_INDICA_RISCO": (
        "Define se o TARM deve obrigatoriamente indicar "
        "o risco inicial na abertura do chamado."
    )
}
```

---

### Variação C: Obrigatório com Desdobramento Incondicional

O parâmetro principal é obrigatório e, independentemente do valor salvo nele, ele sempre arrasta consigo a obrigatoriedade de preenchimento de parâmetros secundários.

```python
"GLOBAL": {
    "CNPJ_INSTITUICAO": {
        "valor_gatilho": None,
        "exige_chaves": [
            "RAZAO_SOCIAL",
            "INSCRICAO_ESTADUAL"
        ],
        "helper": (
            "Dados fiscais vitais para identificação "
            "da instituição."
        )
    }
}
```

---

### Variação D: Obrigatório com Desdobramento Condicional (Gatilho)

O parâmetro mestre deve existir.

Se ele for configurado com o valor exato do gatilho (os valores são convertidos e comparados em `string/lowercase`), uma árvore de novas dependências passa a ser exigida em cadeia.

```python
"UNIDADE": {
    "MAX_USB": {
        "valor_gatilho": 10,
        "exige_chaves": [
            "USB_BACKUP"
        ],
        "helper": (
            "Caso o limite de portas chegue a 10, "
            "o sistema exige uma unidade de backup cadastrada."
        )
    }
}
```

---

## 5. Como o Motor Processa (Por Trás dos Panos)

O método `ParamChecker.check_base(base)` utiliza dictionary comprehension para extrair do banco as informações usando uma tupla composta como chave de memória:

```python
params_base = {
    (app, chave): valor
    for app, chave, valor in (
        Parametro.objects
        .filter(base=base, valor__isnull=False)
        .values_list('app', 'chave', 'valor')
    )
}
```

Isso garante que, se a chave `MAX_USB` estiver configurada no contexto `GLOBAL`, o motor ainda considerará que ela está ausente no contexto `UNIDADE`, gerando o alerta correto de escopo isolado.

---

## 6. Exibição na Interface Visual

Caso o motor encontre erros, eles são repassados para o template HTML e renderizados utilizando o padrão de mensageria nativo do SIRUS:

```html
alert-block alert-danger bg-danger
```