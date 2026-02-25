
# 🧪 Padrão de Testes Automatizados - SIRUS 1.0

Este documento estabelece as diretrizes e a estrutura técnica para a implementação de testes automatizados no ecossistema Django do projeto SIRUS. A conformidade com este padrão é obrigatória para garantir a integridade dos dados e a confiabilidade de todos os processos do sistema.

---

## 1. Organização do Código de Teste

Para manter a modularidade e a manutenibilidade do software, os testes devem ser organizados em pacotes dentro de cada aplicação (app). Não é permitido o uso de arquivos de teste isolados na raiz do aplicativo.

### Estrutura de Diretórios Obrigatória:

* O diretório `tests/` deve ser criado na raiz de cada aplicação.
* Deve conter obrigatoriamente um arquivo `__init__.py`.
* Cada componente do Django deve ter seu próprio arquivo de teste dedicado, iniciando com o prefixo `test_`.

```text
nome_do_app/
├── tests/
│   ├── __init__.py
│   ├── test_models.py
│   ├── test_views.py
│   ├── test_forms.py
│   └── test_api.py

```

---

## 2. Componentes de Cobertura (Mínimo Obrigatório)

Cada aplicação deve implementar, no mínimo, as seguintes suítes de teste para assegurar a robustez genérica do sistema:

### 🔹 Modelos (`test_models.py`)

* Validar a persistência correta dos dados e integridade dos campos no banco de dados.
* Testar restrições de unicidade, integridade referencial e comportamentos de métodos customizados dentro dos modelos.

### 🔹 Visualizações (`test_views.py`)

* Verificar o código de status HTTP retornado para diferentes perfis de acesso (ex: 200 OK, 302 Redirect, 403 Forbidden).
* Garantir que as regras de permissão configuradas por setor e colaborador sejam estritamente respeitadas.
* Validar se o contexto enviado para os templates contém as informações necessárias para a renderização correta da interface.

### 🔹 Formulários (`test_forms.py`)

* Testar a validação de campos obrigatórios e condicionais em todos os níveis do sistema.
* Garantir que as lógicas de limpeza e validação de dados previnam a inserção de informações inconsistentes ou rasuras digitais.
* Verificar se mensagens de erro adequadas são disparadas para entradas de dados inválidas.

### 🔹 Interface de API (`test_api.py`)

* Validar a estrutura de resposta (JSON) e o contrato de dados dos endpoints.
* Testar a integração e o fluxo de dados entre diferentes módulos e estados do sistema.
* Verificar a segurança, autenticação e autorização em todas as requisições de API.

---

## 3. Padrões de Nomenclatura e Boas Práticas

* **Arquivos:** Devem obrigatoriamente iniciar com o prefixo `test_`.
* **Funções e Métodos:** Devem ser descritivos e iniciar com `test_`. Exemplo: `test_validacao_integridade_dados_persistidos`.
* **Isolamento:** Cada teste deve ser independente, utilizando a infraestrutura de `TestCase` do Django para garantir o rollback automático do banco de dados após cada execução.
* **Foco:** Os testes devem cobrir tanto casos de sucesso (caminho feliz) quanto casos de falha e exceções.

---

## 4. Execução dos Testes

Para rodar toda a suíte de testes do projeto:

```bash
python manage.py test

```

Para rodar testes de uma aplicação ou componente específico:

```bash
python manage.py test nome_do_app.tests.test_models

```

---

> **Nota:** Este padrão visa reduzir a incidência de erros operacionais e assegurar que as correções de bugs não gerem regressões em funcionalidades já homologadas.