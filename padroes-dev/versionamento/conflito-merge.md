# ⚠️ Manual de Resolução de Conflitos: Fluxo de Manobra

Este guia estabelece o protocolo oficial para resolução de conflitos de integração quando as Branches de Destino (como `dev` ou `release`) possuem restrições de escrita (proteção de branch). O processo envolve a criação de uma **Branch Intermediária** para resolver os conflitos localmente, garantindo a integridade do código e a continuidade do desenvolvimento sem comprometer a estabilidade das branches protegidas.

## 1. O Conceito: A "Branch Intermediária"

Quando o Git identifica conflitos entre uma **Branch de Origem** (onde o trabalho foi desenvolvido) e uma **Branch de Destino** (onde o código deve ser integrado) e esta última é protegida, não é possível resolver o problema diretamente no servidor.

A solução é a criação de uma **Branch Intermediária** (manobra), que serve como um ambiente seguro para resolver divergências e validar o código antes da integração final.



## 2. Fluxo de Trabalho Padronizado

### Passo 1: Sincronização e Preparo
Antes de iniciar a resolução, atualize seu repositório local com o estado mais recente do servidor para garantir que está trabalhando sobre a última versão estável.

```bash
git checkout [Branch-de-Destino]
git pull origin [Branch-de-Destino]
git checkout [Branch-de-Origem]
git pull origin [Branch-de-Origem]
```

### Passo 2: Criação da Branch Intermediária
Crie uma nova branch a partir da **Branch de Destino**. Utilize um nome que identifique a manobra, por exemplo: `fix/resolve-conflito-[id-da-tarefa]`.

```bash
git checkout [Branch-de-Destino]
git checkout -b fix/resolve-conflito-integracao
```

### Passo 3: Execução do Merge Local
Inicie a fusão da **Branch de Origem** para dentro da sua nova branch intermediária:

```bash
git merge [Branch-de-Origem]
```
> O Git interromperá o processo e listará os arquivos em estado de conflito (**Both Modified**).

### Passo 4: Resolução Manual
Abra os arquivos sinalizados no seu editor de preferência.
* Analise as marcações `<<<<<<< HEAD` (Destino) e `>>>>>>> [Origem]`.
* Resolva a lógica, garantindo que não faltem vírgulas em arquivos de configuração (ex: `settings.py`) ou dependências.
* Remova as marcações de conflito (<<<<<<<, =======, >>>>>>>).

### Passo 5: Validação Obrigatória (CI Local)
Diferente de fluxos genéricos, é **obrigatório** rodar o script de testes oficial antes de concluir o merge:

```bash
./ci-test.sh
```
*Se o script falhar ou retornar erros de módulo não encontrado, corrija o código antes de prosseguir.*

### Passo 6: Publicação
Com os testes aprovados, finalize o merge e envie a branch de manobra para o servidor:

```bash
git add .
git commit -m "fix: resolve conflitos de integração via branch intermediária"
git push origin fix/resolve-conflito-integracao
```



## 3. Conclusão da Entrega (Pull Request)

Com a branch no servidor, siga estes passos na interface do GitHub/GitLab:
1.  Acesse o Pull Request (PR) original que apresentava conflitos.
2.  Altere a branch de **"Source/Origem"** do PR para a sua nova **Branch Intermediária**.
3.  O sistema validará que não há mais conflitos e o botão de **Merge** ficará habilitado para os arquitetos.

## 4. Estrutura de Atuação

* **Novos Recursos:** Devem usar este fluxo ao integrar `feat/<descricao>` (derivada da `dev`) para a `dev`.
* **Correções:** Devem usar este fluxo ao integrar `hotfix/<descricao>` (derivada da `release`) para a `release`.
* **Arquitetos:** Utilizam este fluxo para integrações de alto nível, como merges entre `release` e `main`.