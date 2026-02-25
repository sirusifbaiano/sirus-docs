-- Script de inserção de dados iniciais via pgAdmin
-- Contém dados de exemplo para os modelos: Base, Setor, Unidade e tabelas relacionadas do Django (auth.Group)
-- Alguns IDs começam em 10 para evitar conflito com dados já existentes nos ambientes locais

INSERT INTO auth_group (id, name)
VALUES
  (10, 'Coordenadores'),
  (11, 'Condutores'),
  (12, 'Técnicos');

INSERT INTO base_base (id, nome, cidade, uf, logradouro, bairro, numero, complemento, criado_em, central_id, criado_por_id)
VALUES
(10, 'Base Guanambi', 'Guanambi', 'BA', 'Rua A', 'Centro', '123', 'Ao lado da praça', NOW(), null, 1),
(11, 'Base Caetité', 'Caetité', 'BA', 'Rua B', 'Centro', '456', NULL, NOW(), 10, 1),
(12, 'Base Caculé', 'Caculé', 'BA', 'Rua C', 'Centro', '789', 'Próxima à praça', NOW(), 10, 1),
(13, 'Base Botuporã', 'Botuporã', 'BA', 'Rua D', 'Centro', '101', NULL, NOW(), 10, 1),
(14, 'Base Candiba', 'Candiba', 'BA', 'Rua E', 'Centro', '202', NULL, NOW(), 10, 1),
(15, 'Base Carinhanha', 'Carinhanha', 'BA', 'Rua F', 'Centro', '303', 'Perto da praça', NOW(), 10, 1),
(16, 'Base Ibiassucê', 'Ibiassucê', 'BA', 'Rua G', 'Centro', '404', NULL, NOW(), 10, 1),
(17, 'Base Igaporã', 'Igaporã', 'BA', 'Rua H', 'Centro', '505', NULL, NOW(), 10, 1),
(18, 'Base Iuiú', 'Iuiú', 'BA', 'Rua I', 'Centro', '606', 'Ao lado da escola', NOW(), 10, 1),
(19, 'Base Jacaraci', 'Jacaraci', 'BA', 'Rua J', 'Centro', '707', NULL, NOW(), 10, 1),
(20, 'Base Lagoa Real', 'Lagoa Real', 'BA', 'Rua K', 'Centro', '808', NULL, NOW(), 10, 1),
(21, 'Base Malhada', 'Malhada', 'BA', 'Rua L', 'Centro', '909', NULL, NOW(), 10, 1),
(22, 'Base Matina', 'Matina', 'BA', 'Rua M', 'Centro', '010', NULL, NOW(), 10, 1),
(23, 'Base Mortugaba', 'Mortugaba', 'BA', 'Rua N', 'Centro', '111', NULL, NOW(), 10, 1),
(24, 'Base Palmas de Monte Alto', 'Palmas de Monte Alto', 'BA', 'Rua O', 'Centro', '121', NULL, NOW(), 10, 1),
(25, 'Base Pindaí', 'Pindaí', 'BA', 'Rua P', 'Centro', '131', NULL, NOW(), 10, 1),
(26, 'Base Riacho de Santana', 'Riacho de Santana', 'BA', 'Rua Q', 'Centro', '141', NULL, NOW(), 10, 1),
(27, 'Base Rio do Antônio', 'Rio do Antônio', 'BA', 'Rua R', 'Centro', '151', NULL, NOW(), 10, 1),
(28, 'Base Sebastião Laranjeiras', 'Sebastião Laranjeiras', 'BA', 'Rua S', 'Centro', '161', NULL, NOW(), 10, 1),
(29, 'Base Tanque Novo', 'Tanque Novo', 'BA', 'Rua T', 'Centro', '171', NULL, NOW(), 10, 1),
(30, 'Base Urandi', 'Urandi', 'BA', 'Rua U', 'Centro', '181', NULL, NOW(), 10, 1);

INSERT INTO setor_setor (id, nome, base_id, grupo_id, ativo, criado_em, criado_por_id)
VALUES
  (10, 'Setor Administrativo', 10, 10, true, NOW(), 1),
  (11, 'Setor Operacional', 11, 11, true, NOW(), 1),
  (12, 'Setor Técnico', 12, 12, true, NOW(), 1),
  (13, 'Setor Operacional', 13, 11, true, NOW(), 1),
  (14, 'Setor Administrativo', 14, 10, true, NOW(), 1),
  (15, 'Setor Técnico', 15, 12, true, NOW(), 1),
  (16, 'Setor Operacional', 16, 11, true, NOW(), 1),
  (17, 'Setor Administrativo', 17, 10, true, NOW(), 1),
  (18, 'Setor Técnico', 18, 12, true, NOW(), 1),
  (19, 'Setor Operacional', 19, 11, true, NOW(), 1),
  (20, 'Setor Administrativo', 20, 10, true, NOW(), 1),
  (21, 'Setor Técnico', 21, 12, true, NOW(), 1),
  (22, 'Setor Operacional', 22, 11, true, NOW(), 1),
  (23, 'Setor Administrativo', 23, 10, true, NOW(), 1),
  (24, 'Setor Técnico', 24, 12, true, NOW(), 1),
  (25, 'Setor Operacional', 25, 11, true, NOW(), 1),
  (26, 'Setor Administrativo', 26, 10, true, NOW(), 1),
  (27, 'Setor Técnico', 27, 12, true, NOW(), 1),
  (28, 'Setor Operacional', 28, 11, true, NOW(), 1),
  (29, 'Setor Administrativo', 29, 10, true, NOW(), 1),
  (30, 'Setor Técnico', 30, 12, true, NOW(), 1);

INSERT INTO unidade_unidade (id, nome, tipo, fabricante, modelo, cor, chassi, renavam, placa, status, lotacao, ano, base_id, criado_em, criado_por_id)
VALUES
(10, 'USB I', 'USB', 'Mercedes-Benz', 'Sprinter', 'Branco', '1234567890', '9876543210', 'ABC-1234', 'dis', 4, 2020, 10, NOW(), 1),
(11, 'USB II', 'USB', 'Fiat', 'Ducato', 'Branco', '1234567891', '9876543211', 'DEF-5678', 'dis', 4, 2021, 10, NOW(), 1),
(12, 'USA I', 'USA', 'Mercedes-Benz', 'Sprinter', 'Vermelho', '1234567892', '9876543212', 'GHI-9876', 'mam', 4, 2020, 10, NOW(), 1),
(13, 'USA II', 'USA', 'Fiat', 'Ducato', 'Vermelho', '1234567893', '9876543213', 'JKL-1357', 'dis', 4, 2021, 10, NOW(), 1),
(15, 'Motolância', 'MOTO', 'Honda', 'XRE 190', 'Preta', '1234567895', '9876543215', 'PQR-3690', 'oco', 1, 2020, 10, NOW(), 1),
(16, 'USB I', 'USB', 'Mercedes-Benz', 'Sprinter', 'Branco', '1234567896', '9876543216', 'STU-1234', 'dis', 4, 2020, 11, NOW(), 1),
(17, 'USA I', 'USA', 'Fiat', 'Ducato', 'Vermelho', '1234567897', '9876543217', 'VWX-5678', 'dis', 4, 2021, 11, NOW(), 1),
(18, 'USB I', 'USB', 'Mercedes-Benz', 'Sprinter', 'Branco', '1234567898', '9876543220', 'YZA-9876', 'dis', 4, 2020, 12, NOW(), 1),
(19, 'USA I', 'USA', 'Fiat', 'Ducato', 'Vermelho', '1234567899', '9876543221', 'BCD-1357', 'dis', 4, 2021, 12, NOW(), 1),
(20, 'USB', 'USB', 'Mercedes-Benz', 'Sprinter', 'Branco', '1234567900', '9876543222', 'EFG-2468', 'oco', 4, 2020, 13, NOW(), 1),
(21, 'USB', 'USB', 'Fiat', 'Ducato', 'Branco', '1234567901', '9876543223', 'HIJ-3690', 'dis', 4, 2021, 14, NOW(), 1),
(22, 'USB', 'USB', 'Mercedes-Benz', 'Sprinter', 'Branco', '1234567902', '9876543224', 'KLM-1234', 'dis', 4, 2020, 15, NOW(), 1),
(23, 'USB', 'USB', 'Fiat', 'Ducato', 'Branco', '1234567903', '9876543225', 'NOP-5678', 'dis', 4, 2021, 16, NOW(), 1),
(24, 'USB', 'USB', 'Mercedes-Benz', 'Sprinter', 'Branco', '1234567904', '9876543226', 'QRS-1357', 'lim', 4, 2020, 17, NOW(), 1),
(25, 'USB', 'USB', 'Fiat', 'Ducato', 'Branco', '1234567905', '9876543227', 'TUV-2468', 'dis', 4, 2021, 18, NOW(), 1),
(26, 'USB', 'USB', 'Mercedes-Benz', 'Sprinter', 'Branco', '1234567906', '9876543228', 'WXY-3690', 'oco', 4, 2020, 19, NOW(), 1),
(27, 'USB', 'USB', 'Fiat', 'Ducato', 'Branco', '1234567907', '9876543229', 'ZAB-1234', 'dis', 4, 2021, 20, NOW(), 1),
(28, 'USB', 'USB', 'Mercedes-Benz', 'Sprinter', 'Branco', '1234567908', '9876543230', 'CDE-2468', 'dis', 4, 2020, 21, NOW(), 1),
(29, 'USB', 'USB', 'Fiat', 'Ducato', 'Branco', '1234567909', '9876543231', 'FGH-3690', 'dis', 4, 2021, 22, NOW(), 1),
(30, 'USB', 'USB', 'Mercedes-Benz', 'Sprinter', 'Branco', '1234567910', '9876543232', 'IJK-1357', 'dis', 4, 2020, 23, NOW(), 1),
(31, 'USB', 'USB', 'Fiat', 'Ducato', 'Branco', '1234567911', '9876543233', 'LMN-2468', 'dis', 4, 2021, 24, NOW(), 1),
(32, 'USB', 'USB', 'Mercedes-Benz', 'Sprinter', 'Branco', '1234567912', '9876543234', 'OPQ-3690', 'dis', 4, 2020, 25, NOW(), 1),
(33, 'USB', 'USB', 'Fiat', 'Ducato', 'Branco', '1234567913', '9876543235', 'RST-1234', 'dis', 4, 2021, 26, NOW(), 1),
(34, 'USB', 'USB', 'Mercedes-Benz', 'Sprinter', 'Branco', '1234567914', '9876543236', 'UVW-2468', 'dis', 4, 2020, 27, NOW(), 1),
(35, 'USB', 'USB', 'Fiat', 'Ducato', 'Branco', '1234567915', '9876543237', 'XYZ-3690', 'mam', 4, 2021, 28, NOW(), 1),
(36, 'USB', 'USB', 'Mercedes-Benz', 'Sprinter', 'Branco', '1234567916', '9876543238', 'ABC-1357', 'dis', 4, 2020, 29, NOW(), 1),
(37, 'USB', 'USB', 'Fiat', 'Ducato', 'Branco', '1234567917', '9876543239', 'DEF-2468', 'dis', 4, 2021, 30, NOW(), 1);