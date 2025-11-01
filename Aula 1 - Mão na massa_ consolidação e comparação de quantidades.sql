-- ============================================================
-- ZOOP MEGASTORE - CONSULTA DE CONHECIMENTO DAS TABELAS
-- Objetivo: Verificar a estrutura, amostragem e contagem de registros
-- em todas as tabelas do banco de dados.
-- ============================================================

-- ============================================================
-- 🔹 TABELA: categorias
-- Mostra todos os registros e a contagem total de categorias.
-- ============================================================
SELECT * FROM categorias;
SELECT COUNT(*) AS Total_Categorias FROM categorias;

-- ============================================================
-- 🔹 TABELA: produtos
-- Exibe uma amostra (5 primeiros registros) e total de produtos.
-- ============================================================
SELECT * FROM produtos LIMIT 5;
SELECT COUNT(*) AS Total_Produtos FROM produtos;

-- ============================================================
-- 🔹 TABELA: clientes
-- Exibe uma amostra (5 primeiros registros) e total de clientes.
-- ============================================================
SELECT * FROM clientes LIMIT 5;
SELECT COUNT(*) AS Total_Clientes FROM clientes;

-- ============================================================
-- 🔹 TABELA: fornecedores
-- Exibe todos os registros e a contagem de fornecedores.
-- ============================================================
SELECT * FROM fornecedores;
SELECT COUNT(*) AS Total_Fornecedores FROM fornecedores;

-- ============================================================
-- 🔹 TABELA: itens_venda
-- Exibe uma amostra de itens e a contagem total.
-- ============================================================
SELECT * FROM itens_venda LIMIT 5;
SELECT COUNT(*) AS Total_ItensVenda FROM itens_venda;

-- ============================================================
-- 🔹 TABELA: marcas
-- Exibe todos os registros e a contagem total de marcas.
-- ============================================================
SELECT * FROM marcas;
SELECT COUNT(*) AS Total_Marcas FROM marcas;

-- ============================================================
-- 🔹 TABELA: vendas
-- Exibe uma amostra (5 primeiros registros) e total de vendas.
-- ============================================================
SELECT * FROM vendas LIMIT 5;
SELECT COUNT(*) AS Vendas_Totais FROM vendas;

-- ============================================================
-- 🔹 RESUMO GERAL DE REGISTROS
-- Mostra o nome da tabela seguido pela quantidade de registros.
-- ============================================================
SELECT 'Categorias' AS Tabela, COUNT(*) AS Qtd FROM categorias
UNION ALL
SELECT 'Clientes' AS Tabela, COUNT(*) AS Qtd FROM clientes
UNION ALL
SELECT 'Fornecedores' AS Tabela, COUNT(*) AS Qtd FROM fornecedores
UNION ALL
SELECT 'ItensVenda' AS Tabela, COUNT(*) AS Qtd FROM itens_venda
UNION ALL
SELECT 'Marcas' AS Tabela, COUNT(*) AS Qtd FROM marcas
UNION ALL
SELECT 'Produtos' AS Tabela, COUNT(*) AS Qtd FROM produtos
UNION ALL
SELECT 'Vendas' AS Tabela, COUNT(*) AS Qtd FROM vendas;
