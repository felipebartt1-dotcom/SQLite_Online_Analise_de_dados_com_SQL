---------------------------------------------------------------------
-- 📊 ANÁLISE DE VENDAS - BLACK FRIDAY
-- Banco de Dados: banco_de_dados_vendas.db
-- Autor: Felipe Barletta
-- Descrição: Consultas para análise do papel dos fornecedores e das
--            categorias de produtos durante o mês da Black Friday.
---------------------------------------------------------------------

---------------------------------------------------------------------
-- 1️⃣ PAPEL DOS FORNECEDORES NA BLACK FRIDAY
-- Objetivo: Identificar a contribuição de cada fornecedor nas vendas,
--            agrupando por mês e fornecedor.

SELECT 
    strftime('%Y/%m', v.data_venda) AS 'Ano/Mês',  -- Ano e mês da venda
    f.nome AS Nome_Fornecedor,                     -- Nome do fornecedor
    COUNT(iv.produto_id) AS Qtd_Vendas            -- Quantidade de produtos vendidos
FROM itens_venda iv
JOIN vendas v
    ON v.id_venda = iv.venda_id
JOIN produtos p
    ON p.id_produto = iv.produto_id
JOIN fornecedores f
    ON f.id_fornecedor = p.fornecedor_id
GROUP BY Nome_Fornecedor, 'Ano/Mês'
ORDER BY Nome_Fornecedor;


---------------------------------------------------------------------
-- 2️⃣ CATEGORIAS DE PRODUTOS NA BLACK FRIDAY
-- Objetivo: Identificar as categorias de produtos mais vendidas
--            no mês de Novembro (Black Friday).

SELECT 
    strftime('%Y', v.data_venda) AS 'Ano',       -- Ano da venda
    c.nome_categoria AS Nome_Categoria,          -- Nome da categoria do produto
    COUNT(iv.produto_id) AS Qtd_Vendas           -- Quantidade de produtos vendidos
FROM itens_venda iv
JOIN vendas v
    ON v.id_venda = iv.venda_id
JOIN produtos p
    ON p.id_produto = iv.produto_id
JOIN categorias c
    ON c.id_categoria = p.categoria_id
WHERE strftime('%m', v.data_venda) = '11'      -- Apenas vendas de Novembro
GROUP BY Nome_Categoria, 'Ano'
ORDER BY 'Ano', Qtd_Vendas DESC;


---------------------------------------------------------------------
-- ✅ RESUMO ANALÍTICO (INSIGHTS ESPERADOS)
-- • Identificar quais fornecedores mais contribuem para o volume de vendas
--   durante a Black Friday, permitindo ações estratégicas de parceria.
-- • Determinar quais categorias de produtos apresentam maior demanda
--   no mês de Novembro, útil para planejamento de estoque e marketing.
---------------------------------------------------------------------
