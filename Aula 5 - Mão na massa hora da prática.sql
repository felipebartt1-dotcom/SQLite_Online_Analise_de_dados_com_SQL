/* ============================================================
   ANÁLISE DE DADOS - BASE DE VENDAS
   ------------------------------------------------------------
   Objetivo:
   Realizar consultas analíticas sobre a base de dados de vendas,
   explorando informações sobre clientes, produtos, categorias
   e fornecedores entre os anos disponíveis.
   ============================================================ */


/* ============================================================
   01 - Quantos clientes existem na base de dados?
   ------------------------------------------------------------
   Conta o número total de clientes cadastrados na tabela CLIENTES.
   ============================================================ */
SELECT 
    COUNT(*) AS Qtd_Clientes 
FROM CLIENTES;


/* ============================================================
   02 - Quantos produtos foram vendidos no ano de 2022?
   ------------------------------------------------------------
   Conta a quantidade total de produtos vendidos no ano de 2022.
   ============================================================ */
SELECT 
    COUNT(iv.produto_id) AS Qtd_Produtos_Vendidos
FROM vendas v
JOIN itens_venda iv 
    ON v.id_venda = iv.venda_id
WHERE strftime('%Y', v.data_venda) = '2022';


/* ============================================================
   03 - Qual a categoria que mais vendeu em 2022?
   ------------------------------------------------------------
   Retorna a categoria com o maior número de vendas no ano de 2022.
   ============================================================ */
SELECT 
    COUNT(*) AS Qtd_Vendas, 
    c.nome_categoria AS Categoria
FROM itens_venda iv
JOIN vendas v 
    ON v.id_venda = iv.venda_id
JOIN produtos p 
    ON p.id_produto = iv.produto_id
JOIN categorias c 
    ON c.id_categoria = p.categoria_id
WHERE strftime('%Y', v.data_venda) = '2022'
GROUP BY Categoria
ORDER BY Qtd_Vendas DESC
LIMIT 1;


/* ============================================================
   04 - Qual o primeiro ano disponível na base de dados?
   ------------------------------------------------------------
   Obtém o ano mais antigo presente nas vendas registradas.
   ============================================================ */
SELECT 
    MIN(strftime('%Y', data_venda)) AS Ano 
FROM vendas;


/* ============================================================
   05 - Qual o fornecedor que mais vendeu no primeiro ano disponível?
   ------------------------------------------------------------
   Identifica o fornecedor com maior número de vendas no primeiro
   ano registrado (exemplo: 2020).
   ============================================================ */
SELECT 
    COUNT(*) AS Qtd_Vendas, 
    f.nome AS Fornecedor
FROM itens_venda iv
JOIN vendas v 
    ON v.id_venda = iv.venda_id
JOIN produtos p 
    ON p.id_produto = iv.produto_id
JOIN fornecedores f 
    ON f.id_fornecedor = p.fornecedor_id
WHERE strftime('%Y', v.data_venda) = '2020'
GROUP BY Fornecedor
ORDER BY Qtd_Vendas DESC
LIMIT 1;


/* ============================================================
   06 - Quanto o fornecedor que mais vendeu faturou no primeiro ano?
   ------------------------------------------------------------
   Retorna o total de vendas do fornecedor que mais vendeu no
   primeiro ano disponível (exemplo: 2020).
   ============================================================ */
SELECT 
    COUNT(*) AS Qtd_Vendas, 
    strftime('%Y', v.data_venda) AS Ano, 
    f.nome AS Fornecedor
FROM itens_venda iv
JOIN vendas v 
    ON v.id_venda = iv.venda_id
JOIN produtos p 
    ON p.id_produto = iv.produto_id
JOIN fornecedores f 
    ON f.id_fornecedor = p.fornecedor_id
WHERE strftime('%Y', v.data_venda) = '2020'
GROUP BY Fornecedor
ORDER BY Qtd_Vendas DESC
LIMIT 1;


/* ============================================================
   07 - Quais as duas categorias que mais venderam no total?
   ------------------------------------------------------------
   Lista as duas categorias com maior número de vendas considerando
   todos os anos da base de dados.
   ============================================================ */
SELECT 
    COUNT(*) AS Qtd_Vendas, 
    c.nome_categoria AS Categoria
FROM itens_venda iv
JOIN vendas v 
    ON v.id_venda = iv.venda_id
JOIN produtos p 
    ON p.id_produto = iv.produto_id
JOIN categorias c 
    ON c.id_categoria = p.categoria_id
GROUP BY Categoria
ORDER BY Qtd_Vendas DESC
LIMIT 2;


/* ============================================================
   08 - Comparativo das duas categorias mais vendidas ao longo dos anos.
   ------------------------------------------------------------
   Cria uma tabela comparativa mostrando o total de vendas por ano
   para as duas categorias com maior volume de vendas.
   ============================================================ */
SELECT 
    Categoria,
    SUM(CASE WHEN Ano = '2020' THEN Total_de_Vendas ELSE 0 END) AS '2020',
    SUM(CASE WHEN Ano = '2021' THEN Total_de_Vendas ELSE 0 END) AS '2021',
    SUM(CASE WHEN Ano = '2022' THEN Total_de_Vendas ELSE 0 END) AS '2022',
    SUM(CASE WHEN Ano = '2023' THEN Total_de_Vendas ELSE 0 END) AS '2023'
FROM (
    SELECT 
        c.nome_categoria AS Categoria,
        strftime('%Y', v.data_venda) AS Ano,
        SUM(v.total_venda) AS Total_de_Vendas
    FROM itens_venda iv
    JOIN produtos p 
        ON iv.produto_id = p.id_produto
    JOIN categorias c 
        ON p.categoria_id = c.id_categoria
    JOIN vendas v 
        ON iv.venda_id = v.id_venda
    GROUP BY c.nome_categoria, strftime('%Y', v.data_venda)
)
GROUP BY Categoria
ORDER BY SUM(Total_de_Vendas) DESC
LIMIT 2;


/* ============================================================
   09 - Porcentagem de vendas por categoria em 2022.
   ------------------------------------------------------------
   Calcula a participação percentual de cada categoria nas vendas
   do ano de 2022.
   ============================================================ */
WITH Total_Vendas AS (
    SELECT COUNT(*) AS Total_Vendas_2022
    FROM itens_venda iv
    JOIN vendas v 
        ON v.id_venda = iv.venda_id
    WHERE strftime('%Y', v.data_venda) = '2022'
)
SELECT 
    Nome_Categoria, 
    Qtd_Vendas, 
    ROUND(100.0 * Qtd_Vendas / tv.Total_Vendas_2022, 2) || '%' AS Porcentagem
FROM (
    SELECT 
        c.nome_categoria AS Nome_Categoria, 
        COUNT(iv.produto_id) AS Qtd_Vendas
    FROM itens_venda iv
    JOIN vendas v 
        ON v.id_venda = iv.venda_id
    JOIN produtos p 
        ON p.id_produto = iv.produto_id
    JOIN categorias c 
        ON c.id_categoria = p.categoria_id
    WHERE strftime('%Y', v.data_venda) = '2022'
    GROUP BY Nome_Categoria
    ORDER BY Qtd_Vendas DESC
), Total_Vendas tv;


/* ============================================================
   10 - Diferença percentual entre a melhor e a pior categoria em 2022.
   ------------------------------------------------------------
   Mostra quanto (%) a categoria mais vendida supera a menos vendida
   no ano de 2022.
   ============================================================ */
WITH Total_Vendas AS (
    SELECT COUNT(*) AS Total_Vendas_2022
    FROM itens_venda iv
    JOIN vendas v 
        ON v.id_venda = iv.venda_id
    WHERE strftime('%Y', v.data_venda) = '2022'
),
Vendas_Por_Categoria AS (
    SELECT 
        c.nome_categoria AS Nome_Categoria, 
        COUNT(iv.produto_id) AS Qtd_Vendas
    FROM itens_venda iv
    JOIN vendas v 
        ON v.id_venda = iv.venda_id
    JOIN produtos p 
        ON p.id_produto = iv.produto_id
    JOIN categorias c 
        ON c.id_categoria = p.categoria_id
    WHERE strftime('%Y', v.data_venda) = '2022'
    GROUP BY Nome_Categoria
),
Melhor_Pior_Categorias AS (
    SELECT 
        MIN(Qtd_Vendas) AS Pior_Vendas, 
        MAX(Qtd_Vendas) AS Melhor_Vendas
    FROM Vendas_Por_Categoria
)
-- O CROSS JOIN é utilizado para combinar os resultados das CTEs,
-- resultando em um único conjunto de dados consolidado.
SELECT 
    Nome_Categoria, 
    Qtd_Vendas, 
    ROUND(100.0 * Qtd_Vendas / tv.Total_Vendas_2022, 2) || '%' AS Porcentagem,
    ROUND(100.0 * (Qtd_Vendas - Melhor_Vendas) / Melhor_Vendas, 2) || '%' AS Porcentagem_Mais_Que_Melhor
FROM Vendas_Por_Categoria
CROSS JOIN Total_Vendas tv
CROSS JOIN Melhor_Pior_Categorias;
