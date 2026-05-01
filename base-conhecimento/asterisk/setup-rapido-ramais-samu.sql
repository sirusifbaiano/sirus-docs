/*
  Este documento apresenta uma maneira facil de preparar o ambiente com uma
  configuracao rapida de ramais basicos do Asterisk no contexto do SAMU/SIRUS.

  O script cria:
  - a fila TARM: fila-tarm;
  - dois ramais TARM: 2001 e 2002;
  - dois membros da fila TARM: PJSIP/2001 e PJSIP/2002;
  - dez ramais externos de teste usados pelo infra/telefone-externo: 7001 ate 7010;
  - um ramal de regulacao: 2101;
  - um ramal de radio: 2102.

  Observacoes:
  - Use apenas em ambiente de desenvolvimento/teste.
  - As senhas sao simples de proposito para facilitar teste local.
  - Em producao, use senhas fortes e nao use pool fixo compartilhado.
  - A criacao automatica de ramais/identidades externas ainda e futura.
  - Depois de rodar, recarregue o Asterisk:
      docker exec asterisk-dev asterisk -rx "pjsip reload"
      docker exec asterisk-dev asterisk -rx "queue reload all"
      docker exec asterisk-dev asterisk -rx "dialplan reload"
  - Guia de execucao:
      como-rodar-setup-rapido.md
*/

BEGIN;

-- ============================================================
-- 1. FILA TARM
-- tabela queues: cria/atualiza a fila usada pelo dialplan
-- ============================================================

INSERT INTO queues (
    name,
    musiconhold,
    timeout,
    retry,
    wrapuptime,
    ringinuse,
    setinterfacevar,
    setqueuevar,
    setqueueentryvar,
    autofill,
    strategy,
    joinempty,
    leavewhenempty,
    reportholdtime
)
VALUES (
    'fila-tarm',
    'default',
    20,
    3,
    5,
    'no',
    'yes',
    'yes',
    'yes',
    'yes',
    'rrmemory',
    'yes',
    'no',
    'yes'
)
ON CONFLICT (name) DO UPDATE SET
    musiconhold = EXCLUDED.musiconhold,
    timeout = EXCLUDED.timeout,
    retry = EXCLUDED.retry,
    wrapuptime = EXCLUDED.wrapuptime,
    ringinuse = EXCLUDED.ringinuse,
    setinterfacevar = EXCLUDED.setinterfacevar,
    setqueuevar = EXCLUDED.setqueuevar,
    setqueueentryvar = EXCLUDED.setqueueentryvar,
    autofill = EXCLUDED.autofill,
    strategy = EXCLUDED.strategy,
    joinempty = EXCLUDED.joinempty,
    leavewhenempty = EXCLUDED.leavewhenempty,
    reportholdtime = EXCLUDED.reportholdtime;

-- ============================================================
-- 2. AORS
-- tabela ps_aors: controla registros/contatos dos endpoints
-- ============================================================

INSERT INTO ps_aors (id, max_contacts, remove_existing, qualify_frequency)
VALUES
    ('2001', 1, 'yes', 60),
    ('2002', 1, 'yes', 60),
    ('2101', 1, 'yes', 60),
    ('2102', 1, 'yes', 60),
    ('7001', 1, 'yes', 60),
    ('7002', 1, 'yes', 60),
    ('7003', 1, 'yes', 60),
    ('7004', 1, 'yes', 60),
    ('7005', 1, 'yes', 60),
    ('7006', 1, 'yes', 60),
    ('7007', 1, 'yes', 60),
    ('7008', 1, 'yes', 60),
    ('7009', 1, 'yes', 60),
    ('7010', 1, 'yes', 60)
ON CONFLICT (id) DO UPDATE SET
    max_contacts = EXCLUDED.max_contacts,
    remove_existing = EXCLUDED.remove_existing,
    qualify_frequency = EXCLUDED.qualify_frequency;

-- ============================================================
-- 3. AUTENTICACOES
-- tabela ps_auths: usuario/senha SIP
-- ============================================================

INSERT INTO ps_auths (id, auth_type, username, password)
VALUES
    ('2001', 'userpass', '2001', '12345678'),
    ('2002', 'userpass', '2002', '12345678'),
    ('2101', 'userpass', '2101', '12345678'),
    ('2102', 'userpass', '2102', '12345678'),
    ('7001', 'userpass', '7001', '12345678'),
    ('7002', 'userpass', '7002', '12345678'),
    ('7003', 'userpass', '7003', '12345678'),
    ('7004', 'userpass', '7004', '12345678'),
    ('7005', 'userpass', '7005', '12345678'),
    ('7006', 'userpass', '7006', '12345678'),
    ('7007', 'userpass', '7007', '12345678'),
    ('7008', 'userpass', '7008', '12345678'),
    ('7009', 'userpass', '7009', '12345678'),
    ('7010', 'userpass', '7010', '12345678')
ON CONFLICT (id) DO UPDATE SET
    auth_type = EXCLUDED.auth_type,
    username = EXCLUDED.username,
    password = EXCLUDED.password;

-- ============================================================
-- 4. ENDPOINTS INTERNOS
-- tabela ps_endpoints: ramais internos WebRTC
-- ============================================================

INSERT INTO ps_endpoints (
    id,
    transport,
    aors,
    auth,
    context,
    from_domain,
    from_user,
    disallow,
    allow,
    direct_media,
    force_rport,
    ice_support,
    rewrite_contact,
    rtp_symmetric,
    use_avpf,
    media_encryption,
    webrtc,
    dtls_auto_generate_cert,
    dtls_fingerprint,
    dtls_setup,
    dtls_verify,
    rtcp_mux,
    bundle,
    media_use_received_transport,
    rtp_keepalive,
    allow_transfer,
    refer_blind_progress,
    trust_connected_line,
    send_connected_line
)
VALUES
    (
        '2001', 'transport-ws', '2001', '2001', 'samu-tarm',
        '127.0.0.1', '2001', 'all', 'opus,ulaw',
        'no', 'yes', 'yes', 'yes', 'yes', 'yes',
        'dtls', 'yes', 'yes', 'SHA-256', 'actpass', 'fingerprint',
        'yes', 'yes', 'yes', 20, 'yes', 'yes', 'yes', 'yes'
    ),
    (
        '2002', 'transport-ws', '2002', '2002', 'samu-tarm',
        '127.0.0.1', '2002', 'all', 'opus,ulaw',
        'no', 'yes', 'yes', 'yes', 'yes', 'yes',
        'dtls', 'yes', 'yes', 'SHA-256', 'actpass', 'fingerprint',
        'yes', 'yes', 'yes', 20, 'yes', 'yes', 'yes', 'yes'
    ),
    (
        '2101', 'transport-ws', '2101', '2101', 'samu-equipe',
        '127.0.0.1', '2101', 'all', 'opus,ulaw',
        'no', 'yes', 'yes', 'yes', 'yes', 'yes',
        'dtls', 'yes', 'yes', 'SHA-256', 'actpass', 'fingerprint',
        'yes', 'yes', 'yes', 20, 'yes', 'yes', 'yes', 'yes'
    ),
    (
        '2102', 'transport-ws', '2102', '2102', 'samu-equipe',
        '127.0.0.1', '2102', 'all', 'opus,ulaw',
        'no', 'yes', 'yes', 'yes', 'yes', 'yes',
        'dtls', 'yes', 'yes', 'SHA-256', 'actpass', 'fingerprint',
        'yes', 'yes', 'yes', 20, 'yes', 'yes', 'yes', 'yes'
    )
ON CONFLICT (id) DO UPDATE SET
    transport = EXCLUDED.transport,
    aors = EXCLUDED.aors,
    auth = EXCLUDED.auth,
    context = EXCLUDED.context,
    from_domain = EXCLUDED.from_domain,
    from_user = EXCLUDED.from_user,
    disallow = EXCLUDED.disallow,
    allow = EXCLUDED.allow,
    direct_media = EXCLUDED.direct_media,
    force_rport = EXCLUDED.force_rport,
    ice_support = EXCLUDED.ice_support,
    rewrite_contact = EXCLUDED.rewrite_contact,
    rtp_symmetric = EXCLUDED.rtp_symmetric,
    use_avpf = EXCLUDED.use_avpf,
    media_encryption = EXCLUDED.media_encryption,
    webrtc = EXCLUDED.webrtc,
    dtls_auto_generate_cert = EXCLUDED.dtls_auto_generate_cert,
    dtls_fingerprint = EXCLUDED.dtls_fingerprint,
    dtls_setup = EXCLUDED.dtls_setup,
    dtls_verify = EXCLUDED.dtls_verify,
    rtcp_mux = EXCLUDED.rtcp_mux,
    bundle = EXCLUDED.bundle,
    media_use_received_transport = EXCLUDED.media_use_received_transport,
    rtp_keepalive = EXCLUDED.rtp_keepalive,
    allow_transfer = EXCLUDED.allow_transfer,
    refer_blind_progress = EXCLUDED.refer_blind_progress,
    trust_connected_line = EXCLUDED.trust_connected_line,
    send_connected_line = EXCLUDED.send_connected_line;

-- ============================================================
-- 5. RAMAIS EXTERNOS DE TESTE
-- tabela ps_endpoints: pool usado pelo infra/telefone-externo
-- ============================================================

INSERT INTO ps_endpoints (
    id,
    transport,
    aors,
    auth,
    context,
    from_domain,
    from_user,
    disallow,
    allow,
    direct_media,
    force_rport,
    ice_support,
    rewrite_contact,
    rtp_symmetric,
    use_avpf,
    media_encryption,
    webrtc,
    dtls_auto_generate_cert,
    dtls_fingerprint,
    dtls_setup,
    dtls_verify,
    rtcp_mux,
    bundle,
    media_use_received_transport,
    rtp_keepalive,
    allow_transfer,
    refer_blind_progress,
    trust_connected_line,
    send_connected_line
)
SELECT
    id,
    'transport-ws',
    id,
    id,
    'site-publico',
    '127.0.0.1',
    id,
    'all',
    'opus,ulaw',
    'no',
    'yes',
    'yes',
    'yes',
    'yes',
    'yes',
    'dtls',
    'yes',
    'yes',
    'SHA-256',
    'actpass',
    'fingerprint',
    'yes',
    'yes',
    'yes',
    20,
    'no',
    'yes',
    'yes',
    'yes'
FROM (
    VALUES
        ('7001'),
        ('7002'),
        ('7003'),
        ('7004'),
        ('7005'),
        ('7006'),
        ('7007'),
        ('7008'),
        ('7009'),
        ('7010')
) AS ramais_externos(id)
ON CONFLICT (id) DO UPDATE SET
    transport = EXCLUDED.transport,
    aors = EXCLUDED.aors,
    auth = EXCLUDED.auth,
    context = EXCLUDED.context,
    from_domain = EXCLUDED.from_domain,
    from_user = EXCLUDED.from_user,
    disallow = EXCLUDED.disallow,
    allow = EXCLUDED.allow,
    direct_media = EXCLUDED.direct_media,
    force_rport = EXCLUDED.force_rport,
    ice_support = EXCLUDED.ice_support,
    rewrite_contact = EXCLUDED.rewrite_contact,
    rtp_symmetric = EXCLUDED.rtp_symmetric,
    use_avpf = EXCLUDED.use_avpf,
    media_encryption = EXCLUDED.media_encryption,
    webrtc = EXCLUDED.webrtc,
    dtls_auto_generate_cert = EXCLUDED.dtls_auto_generate_cert,
    dtls_fingerprint = EXCLUDED.dtls_fingerprint,
    dtls_setup = EXCLUDED.dtls_setup,
    dtls_verify = EXCLUDED.dtls_verify,
    rtcp_mux = EXCLUDED.rtcp_mux,
    bundle = EXCLUDED.bundle,
    media_use_received_transport = EXCLUDED.media_use_received_transport,
    rtp_keepalive = EXCLUDED.rtp_keepalive,
    allow_transfer = EXCLUDED.allow_transfer,
    refer_blind_progress = EXCLUDED.refer_blind_progress,
    trust_connected_line = EXCLUDED.trust_connected_line,
    send_connected_line = EXCLUDED.send_connected_line;

-- ============================================================
-- 6. MEMBROS DA FILA
-- tabela queue_members: adiciona os dois TARMs na fila
-- ============================================================

WITH new_members AS (
    SELECT *
    FROM (
        VALUES
            ('fila-tarm', 'PJSIP/2001', 'TARM 2001', 'PJSIP/2001', 0, 0, 5, 'no', NULL),
            ('fila-tarm', 'PJSIP/2002', 'TARM 2002', 'PJSIP/2002', 0, 0, 5, 'no', NULL)
    ) AS rows(queue_name, interface, membername, state_interface, penalty, paused, wrapuptime, ringinuse, reason_paused)
),
numbered AS (
    SELECT
        (SELECT COALESCE(MAX(uniqueid), 0) FROM queue_members) + ROW_NUMBER() OVER (ORDER BY interface) AS uniqueid,
        *
    FROM new_members
)
INSERT INTO queue_members (
    uniqueid,
    queue_name,
    interface,
    membername,
    state_interface,
    penalty,
    paused,
    wrapuptime,
    ringinuse,
    reason_paused
)
SELECT
    uniqueid,
    queue_name,
    interface,
    membername,
    state_interface,
    penalty,
    paused,
    wrapuptime,
    ringinuse,
    reason_paused
FROM numbered
ON CONFLICT (queue_name, interface) DO UPDATE SET
    membername = EXCLUDED.membername,
    state_interface = EXCLUDED.state_interface,
    penalty = EXCLUDED.penalty,
    paused = EXCLUDED.paused,
    wrapuptime = EXCLUDED.wrapuptime,
    ringinuse = EXCLUDED.ringinuse,
    reason_paused = EXCLUDED.reason_paused;

COMMIT;

/*
  Como testar depois:

  1. Registrar TARM 2001:
     usuario: 2001
     senha: 12345678

  2. Registrar TARM 2002:
     usuario: 2002
     senha: 12345678

  3. Registrar regulacao:
     usuario: 2101
     senha: 12345678

  4. Registrar radio:
     usuario: 2102
     senha: 12345678

  5. Registrar telefone externo de teste:
     usuario: 7001
     senha: 12345678

  6. Ligar para 192 e verificar se o contexto site-publico envia a chamada
     para a fila e chama 2001 ou 2002.

  Navegacao da documentacao:
  - Anterior: como-rodar-setup-rapido.md
  - Indice: README.md
  - Proximo: fim da trilha
*/
