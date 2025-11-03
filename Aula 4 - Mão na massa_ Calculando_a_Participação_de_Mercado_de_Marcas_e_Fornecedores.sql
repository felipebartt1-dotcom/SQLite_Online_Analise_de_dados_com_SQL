------------------------------------------------------------
-- 📊 Análise de Vendas por Marca e Fornecedor
-- Curso: SQLite Online – Análise de Dados com SQL (Alura)
-- Autor: Felipe Barletta
-- Objetivo: Calcular a porcentagem de vendas por marca e por fornecedor
------------------------------------------------------------


------------------------------------------------------------
-- 1️⃣ Análise de Marcas
-- Calcula a porcentagem de participação de cada marca no total de vendas.
-- A soma das porcentagens deve se aproximar de 100%.
------------------------------------------------------------
SELECT nome_marca,
       Qtd_Vendas,
       ROUND(100.0 * Qtd_Vendas / (SELECT COUNT(*) FROM itens_venda), 2) || '%' AS Porcentagem
FROM (
  SELECT m.nome AS Nome_Marca,
         COUNT(iv.produto_id) AS Qtd_Vendas
  FROM itens_venda iv
  JOIN vendas v ON v.id_venda = iv.venda_id
  JOIN produtos p ON p.id_produto = iv.produto_id
  JOIN marcas m ON m.id_marca = p.marca_id
  GROUP BY Nome_Marca
  ORDER BY Qtd_Vendas DESC
);


------------------------------------------------------------
-- 2️⃣ Análise de Fornecedores
-- Calcula a porcentagem de vendas atribuída a cada fornecedor.
-- Permite comparar a performance entre diferentes fornecedores.
------------------------------------------------------------
SELECT nome_fornecedor,
       Qtd_Vendas,
       ROUND(100.0 * Qtd_Vendas / (SELECT COUNT(*) FROM itens_venda), 2) || '%' AS Porcentagem
FROM (
  SELECT f.nome AS Nome_Fornecedor,
         COUNT(iv.produto_id) AS Qtd_Vendas
  FROM itens_venda iv
  JOIN vendas v ON v.id_venda = iv.venda_id
  JOIN produtos p ON p.id_produto = iv.produto_id
  JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
  GROUP BY Nome_Fornecedor
  ORDER BY Qtd_Vendas DESC
);
