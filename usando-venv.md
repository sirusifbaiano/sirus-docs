## 📌 O que é uv?

O **uv** é um gerenciador de projetos Python ultra-rápido. Diferente do fluxo antigo (`venv` + `pip`), o `uv` utiliza um arquivo de trava (`uv.lock`) para garantir que todos os desenvolvedores utilizem exatamente as mesmas versões de bibliotecas.

---

## 🎯 1. Preparando o Ambiente

Se você acabou de clonar o repositório, não precisa criar o ambiente manualmente ou ativar o pip. Basta rodar:

```bash
uv sync

```

**O que este comando faz?**

1. Verifica se a versão correta do Python está instalada (e instala se necessário).
2. Cria a pasta `.venv/`.
3. Instala todas as dependências do projeto baseadas no `uv.lock`.
4. Remove pacotes extras que não deveriam estar lá.

---

## 🎯 2. Executando o Projeto

Com o `uv`, você tem duas opções para rodar o Django:

### 🔹 Opção A: Usando o atalho `uv run` (Recomendado)

Você não precisa ativar o ambiente virtual. O `uv` gerencia isso para você em cada comando:

```bash
uv run python manage.py runserver

```

### 🔹 Opção B: Ativando o ambiente (Modo Tradicional)

Se preferir o terminal "clássico" com o prefixo `(.venv)`:

* **Linux/macOS:** `source .venv/bin/activate`
* **Windows:** `.venv\Scripts\activate`

---

## 🎯 3. Adicionando Novas Dependências

Para adicionar uma nova biblioteca ao projeto (como o `django-filter`):

```bash
uv add django-filter

```

Isso atualizará automaticamente o `pyproject.toml` e o `uv.lock`.

---

## 🎯 Recapitulando os Comandos (Fluxo UV Sync)

| Ação | Comando |
| --- | --- |
| **Instalar tudo e configurar** | `uv sync` |
| **Rodar o servidor** | `uv run python manage.py runserver` |
| **Rodar migrações** | `uv run python manage.py migrate` |
| **Adicionar novo pacote** | `uv add <nome>` |
| **Atualizar todos os pacotes** | `uv lock --upgrade` |

---

> **Nota:** Como o projeto agora usa `uv sync`, o arquivo `requirements.txt` torna-se opcional ou apenas para exportação/compatibilidade com sistemaslegados. O "coração" das dependências agora são os arquivos `pyproject.toml` e `uv.lock`.