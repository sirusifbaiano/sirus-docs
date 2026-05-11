# Integração Mobile e Backend (Sirus SAMU)

A comunicação opera em três camadas: HTTP/REST, WebSockets e Firebase Cloud Messaging (FCM).

---

## 1. HTTP/REST

### 1.1 `HttpService` (`lib/data/services/httpService.dart`)
- **Autenticação:** Adiciona o cabeçalho `Authorization: Bearer <token>` nas requisições.
- **Refresh Token Automático:** Ao receber status HTTP 401, suspende a requisição em curso, invoca `AuthService().refreshAccessToken()` para renovar o token e reexecuta a chamada original. Falhas de renovação invalidam a sessão local.

### 1.2 `MobileApiService` (`lib/data/services/mobileApiService.dart`)
- **Push Tokens:** Registra o token FCM via POST em `/api/auth/push_checkin/`, associando o identificador do hardware ao usuário.
- **Sincronização em Lote:** Executa a persistência de pacotes de geolocalização retidos offline via POST em `/api/tracking/` (`syncTrackingBatch`).

---

## 2. WebSockets

### 2.1 `UnidadeConsumer` (`dashboard/consumers.py`)
Atende e gerencia conexões na rota `ws/unidade/<codigo_vinculacao>/`.
- **Handshake:** O socket exige autenticação via query string (`?token=<token_key>`). Este token é um *DRF Auth Token* recebido e persistido no mobile durante o processo de **vinculação do dispositivo** à unidade, atuando como uma chave de *Service Account* do hardware. O método `validarDRFToken` atesta essa vinculação hardware-unidade antes de aceitar a conexão.
- **Roteamento:** A conexão é atribuída a um *channel group* identificado pelo código da viatura (ex: `SIRUS-UN-0001`).
- **Estado Inicial:** Durante o `connect`, o servidor transmite os chamados com status pendente ou em andamento (`enviarChamadosPendentes()`).
- **Rastreamento:** Decodifica payloads de `localizacao`, insere as coordenadas em um buffer de memória e retransmite para o grupo `rastreamento` através do `RastreamentoConsumer`.

### 2.2 `WebSocketService` (`lib/data/services/websocketService.dart`)
- **Conexão:** Instancia a conexão no URI `${AppConstants.wsBaseUrl}/ws/unidade/<codigo>/?token=<token>`.
- **Rastreamento GPS:** Assina eventos do módulo de geolocalização nativo e estrutura pacotes JSON (latitude, longitude, velocidade, direção) sob a chave de payload `localizacao`.
- **Roteamento Interno:** Interpreta payloads recebidos (`novo_chamado`, `mensagem`, `erro`, `conectado`) e engatilha atualizações de estado e overlay. Responde a requisições de keepalive (`ping` / `pong`).
- **Tolerância a Falhas:** Trata quedas abruptas de conexão aplicando *Exponential Backoff*. Os intervalos de reconexão escalam de 5s até o teto de 60s.

---

## 3. Firebase Cloud Messaging (FCM)

### 3.1 `FCMAdapter` (`notificacao/push/fcm.py`)
- Realiza a comunicação direta com a API do Firebase via Firebase Admin SDK.
- Transmite payloads de dados para tokens únicos ou em lotes acionados por eventos de alteração de estado dos chamados.

### 3.2 `FCMService` (`lib/data/services/fcmService.dart`)
- **Permissões e Registro:** Executa solicitação de permissões nativas, requerendo a propriedade `criticalAlert`. Registra o token via callback `onTokenRefresh`.
- **Processamento de Payloads:**
  - **Foreground:** Eventos interceptados via `FirebaseMessaging.onMessage`. O payload aciona a camada `NotificationService`.
  - **Background / Terminated:** Eventos interceptados por um isolate em background (`@pragma('vm:entry-point') firebaseMessagingBackgroundHandler`). O pacote sinaliza a exibição de notificações de alta prioridade (Heads-up) no SO.
  - **Message Opened App:** Captura o intent nativo de toque na notificação para roteamento do usuário.
