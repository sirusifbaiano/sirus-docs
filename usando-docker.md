# 🐳 Guia de Execução com Docker Compose

## 📌 O que é Docker Compose?
O Docker Compose é uma ferramenta para definir e executar aplicativos multi-contêiner no Docker. Podendo criar um ambiente para o projeto sem precisar instalar dependências diretamente no seu sistema operacional.

## 🗂️ Estrutura do Projeto
A estrutura do repositório está organizada da seguinte forma:
```
├── Dockerfile                #Define a imagem do container
├── docker-compose.yml        #Define os serviços e como rodá-los
├── entrypoint.sh             #Script de entrada para iniciar o Django
├── requirements.txt          #Dependências da aplicação
├── .env                      #Arquivo com variáveis de ambiente (criar manualmente)
├── code/                     #Código-fonte do projeto Django
│   ├── base/
│   ├── dashboard/
│   ├── db.sqlite3            
│   ├── manage.py
│   ├── samu/                 #Aplicação do Django
│   ├── static/               #Arquivos estáticos
│   └── templates/            #Templates
├── docs/                     #Documentação do projeto
│   ├── base-conhecimento/
│   ├── diagramas/
│   ├── estrutura-do-repositorio/
│   ├── padroes-dev/
│   ├── paleta-de-cores.md
│   ├── requisitos/
│   ├── usando-docker.md      #📄 Este arquivo
│   └── usando-venv.md
└── readme.md
```

## 🎯 1. Pré-requisitos

### 🔹 Verifique se o Docker está instalado

```bash
docker --version
docker compose version
        ou
docker-compose version
```

Se ambos os comandos retornarem a versão, está tudo certo para prosseguir ✅

## 🎯 2. Executando o Projeto com Docker Compose

### 🔹 Passo 1: Acesse o diretório do projeto

```bash
cd ~/samu
```

### 🔹 Passo 2: Crie o arquivo .env na raiz do projeto

Crie um arquivo chamado .env com o seguinte conteúdo:

```ini
DB_NAME=samu_db
DB_USER=samu_user
DB_PASSWORD=samu_pass
DJANGO_SUPERUSER_USERNAME=admin
DJANGO_SUPERUSER_EMAIL=admin@example.com
DJANGO_SUPERUSER_PASSWORD=admin
PGADMIN_EMAIL=admin@admin.com
PGADMIN_PASSWORD=admin
```

### 🔹 Passo 3: Suba os containers

```bash
docker compose up -d --build
            ou 
docker-compose up -d --build
```

✅ Isso irá:
- Construir as imagens
- Iniciar a aplicação Django
- Criar o superusuário automaticamente
- Subir o serviço do pgAdmin

### 🔹 Passo 4: Acesse no navegador

- **Aplicação Django**: http://localhost:8000
- **PgAdmin**: http://localhost:5050
  - Login: admin@admin.com
  - Senha: admin

## 🎯 3. Comandos Úteis

```bash
# Ver os logs da aplicação
docker compose logs -f

# Acessar o terminal do container da aplicação
docker compose exec web bash

# Parar todos os containers
docker compose down
```