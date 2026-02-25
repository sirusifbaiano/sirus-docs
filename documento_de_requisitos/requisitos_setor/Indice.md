# 📑 Índice de Requisitos Funcionais - Setor

Este diretório contém os requisitos funcionais relacionados à funcionalidade Setor.

Clique em um requisito para visualizar seu conteúdo completo.

## Requisitos Funcionais

| Código | Requisito | Descrição do caso de uso |
|--------|-----------|--------------------------|
| RF_ST_001 | Cadastrar Setor | O sistema deve permitir criar um novo setor vinculado a uma base específica. |
| RF_ST_002 | Listar Setores | O sistema deve permitir visualizar a lista de todos os setores cadastrados, filtrados por base. |
| RF_ST_003 | Detalhar Setor | O sistema deve permitir acessar e visualizar os detalhes completos de um setor cadastrado. |
| RF_ST_004 | Editar Setor | O sistema deve permitir alterar os dados de um setor previamente cadastrado. |
| RF_ST_005 | Excluir Setor | O sistema deve permitir remover um setor previamente cadastrado. |
| RF_ST_006 | Gerenciar Membros do Setor | O sistema deve permitir adicionar e remover membros (usuários) de um setor específico. |
| RF_ST_007 | Gerenciar Permissões do Setor | O sistema deve permitir definir e alterar as permissões de acesso associadas a um setor. |
| RF_ST_008 | Controlar Status do Setor | O sistema deve permitir ativar ou desativar um setor através do campo "ativo". |

## Requisitos Não Funcionais

| Código | Requisito | Descrição |
|--------|-----------|-----------|
| RNF_ST_001 | Sincronização Automática | O sistema deve automaticamente sincronizar o setor com o sistema de grupos do Django para controle de permissões. |
| RNF_ST_002 | Auditoria de Criação | O sistema deve registrar automaticamente quem criou o setor e quando foi criado. |
| RNF_ST_003 | Segurança de Acesso | O sistema deve validar se o usuário possui as permissões necessárias para executar operações CRUD em setores. |
| RNF_ST_004 | Filtro de Membros por Base | O sistema deve filtrar os membros disponíveis para um setor baseado na base de cadastro do usuário. |
| RNF_ST_005 | Controle de Acesso Hierárquico | O sistema deve permitir acesso diferenciado: superusuários acessam todas as bases, usuários normais apenas bases onde são responsáveis. |
