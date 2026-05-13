## RF_AU_002: O sistema deve registrar auditoria de login

**Descrição do caso de uso:** O sistema deve registrar informações de acesso sempre que um usuário autenticar com sucesso, incluindo usuário, IP, navegador, dispositivo, geolocalização aproximada e data/hora do acesso.

**Ator(es):** Usuário autenticado.

**Prioridade:**   [x] Essencial       [ ] Importante      [ ] Desejável

**Entradas e pré-condições:**
- O usuário deve concluir o login com sucesso.
- A requisição deve conter informações de IP e, quando disponível, agente do usuário.

**Saídas e pós-condição:**
- O sistema cria um registro `UserSessionLog` para o acesso.
- O sistema registra a criação do acesso no `django-auditlog`.
- Quando o navegador autoriza a geolocalização, o sistema atualiza o registro de acesso com coordenadas mais precisas.

**Fluxo de eventos principal:**
- O usuário autentica no sistema.
- O sistema captura o IP da requisição.
- O sistema identifica navegador e dispositivo a partir do agente do usuário.
- O sistema consulta a geolocalização aproximada do IP quando aplicável.
- O sistema cria o registro de acesso.
- O sistema mantém na sessão a pendência de enriquecimento por geolocalização do navegador.
- Caso o navegador envie latitude e longitude válidas, o sistema atualiza o mesmo registro de acesso.

**Fluxos secundários:**
- Caso o IP seja local, privado ou loopback, o sistema registra a origem como rede local.
- Caso a consulta externa de geolocalização falhe, o login continua normalmente e o registro é criado sem bloquear o usuário.
- Caso o usuário negue a geolocalização do navegador, o sistema limpa a pendência da sessão sem interromper a navegação.
- Caso latitude ou longitude estejam ausentes ou fora do intervalo válido, o sistema retorna erro de validação.

**Requisitos Não-Funcionais (RNF) vinculados:**
- RNF_001: O fluxo de autenticação deve responder em menos de 3 segundos sob condições normais de uso.
- RNF_002: O sistema deve ter recursos de acessibilidade.

**Dicionário de dados:**
Para mais detalhes sobre os campos e estrutura de dados, consulte o arquivo [DD_AU.md](./DD_AU.md).
