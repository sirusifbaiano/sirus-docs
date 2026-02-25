# 🐳 **Trilha Prática: Docker e Docker Compose**

Aprenda a usar os principais comandos de **Docker** e **Docker Compose** para gerenciar containers, imagens, volumes e serviços.

---

## ⚠️ Sobre `docker compose` vs `docker-compose`

Ambos funcionam, mas:
- **`docker-compose`** (com hífen) era o **comando antigo**, instalado como um binário separado.
- **`docker compose`** (com espaço) é o **comando novo**, integrado diretamente ao Docker a partir da versão **20.10**.

---

### 🔹 **1. Comandos Essenciais do Docker**

🔸 Ver versões:  
```bash
docker --version
docker compose version
```

🔸 Listar containers:
```bash
docker ps          # Containers em execução  
docker ps -a       # Todos containers, incluindo parados
```

🔸 Parar e remover containers:
```bash
docker stop <nome|id>  
docker rm <nome|id>  
docker rm -f <nome|id>
```

🔸 Imagens:
```bash
docker images               # Lista imagens  
docker rmi <imagem>         # Remove imagem  
docker pull <imagem>        # Baixa imagem  
docker build -t nome .      # Cria imagem personalizada
```

🔸 Execução e acesso:
```bash
docker run -it ubuntu bash              # Executa container interativo  
docker exec -it <container> bash        # Acessa container em execução
```

### 🔹 **2. Trabalhando com Volumes e Portas**

🔸 Criando container com volume:
```bash
docker run -v $(pwd):/app -it python bash
```

🔸 Expondo portas:
```bash
docker run -p 8080:80 nginx
```

🔸 Listar volumes:
```bash
docker volume ls
docker volume inspect <volume>
docker volume rm <volume>
```

### 🔹 **3. Docker Compose**

🔸 Subir e parar serviços:
```bash
docker compose up -d --build
docker compose down
```

🔸 Acessar terminal do container da aplicação:
```bash
docker compose exec web bash
```

🔸 Ver status e logs:
```bash
docker compose ps
docker compose logs -f
```

🔸 Reiniciar e reconstruir serviços:
```bash
docker compose restart
docker compose up -d --build
```

## 🐋 Documentação Oficial
https://docs.docker.com/

## 🎥 Vídeos Recomendados

📺 O mínimo que você precisa saber sobre Docker!
https://www.youtube.com/watch?v=ntbpIfS44Gw

📺 DOCKER COMPOSE É FACIL | Aprenda Docker Compose em 15 minutos
https://www.youtube.com/watch?v=D_ha0g9yS2E&t=478s
