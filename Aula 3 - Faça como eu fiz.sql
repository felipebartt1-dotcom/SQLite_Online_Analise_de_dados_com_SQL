------------------------------------------------------------
-- Análise de vendas na Black Friday por fornecedor e categoria
-- Curso: SQLite Online – Análise de dados com SQL (Alura)
-- Autor: Felipe Barletta
------------------------------------------------------------

------------------------------------------------------------
-- 1️⃣ Cálculo do total de vendas de cada fornecedor na Black Friday para validar a análise
------------------------------------------------------------
SELECT SUM(Qtd_Vendas)
FROM(
    SELECT strftime('%Y/%m', v.data_venda) AS 'Ano/Mes',
           f.nome AS Nome_Fornecedor,
           COUNT(iv.produto_id) AS Qtd_Vendas
    FROM itens_venda iv
    JOIN vendas v ON v.id_venda = iv.venda_id
    JOIN produtos p ON p.id_produto = iv.produto_id
    JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
    GROUP BY Nome_Fornecedor, 'Ano/Mes'
    ORDER BY 'Ano/Mes', Qtd_Vendas
);

------------------------------------------------------------
-- 2️⃣ Análise das vendas por categoria de produtos na Black Friday
------------------------------------------------------------
SELECT strftime('%Y', v.data_venda) AS 'Ano',
       c.nome_categoria AS Nome_Categoria,
       COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN produtos p ON p.id_produto = iv.produto_id
JOIN categorias c ON c.id_categoria = p.categoria_id
WHERE strftime('%m', v.data_venda) = '11' -- Filtra apenas novembro (Black Friday)
GROUP BY Nome_Categoria, 'Ano'
ORDER BY 'Ano', Qtd_Vendas DESC;

------------------------------------------------------------
-- 3️⃣ Validação da consistência das vendas registradas
-- Verifica se o total de vendas por fornecedor confere com o total geral
------------------------------------------------------------
SELECT SUM(Qtd_Vendas)
FROM(
    SELECT strftime('%Y/%m', v.data_venda) AS 'Ano/Mes',
           f.nome AS Nome_Fornecedor,
           COUNT(iv.produto_id) AS Qtd_Vendas
    FROM itens_venda iv
    JOIN vendas v ON v.id_venda = iv.venda_id
    JOIN produtos p ON p.id_produto = iv.produto_id
    JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
    GROUP BY Nome_Fornecedor, 'Ano/Mes'
    ORDER BY 'Ano/Mes', Qtd_Vendas
);

------------------------------------------------------------
-- 4️⃣ Análise da performance de vendas do fornecedor 'NebulaNetworks'
-- Mostra a evolução mensal das vendas desse fornecedor
------------------------------------------------------------
SELECT strftime('%Y/%m', v.data_venda) AS 'Ano/Mes',
       COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN produtos p ON p.id_produto = iv.produto_id
JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
WHERE f.nome = 'NebulaNetworks'
GROUP BY 'Ano/Mes'
ORDER BY 'Ano/Mes', Qtd_Vendas;
