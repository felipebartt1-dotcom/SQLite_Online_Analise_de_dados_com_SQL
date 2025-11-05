/* ===========================================================
   RELATÓRIO DE VENDAS POR CATEGORIA E MARCA - ANO DE 2022
   -----------------------------------------------------------
   Objetivo:
   - Calcular a quantidade total de vendas em 2022;
   - Identificar a participação percentual de cada categoria
     e de cada marca no total de vendas do ano.

   Tabelas envolvidas:
   - itens_venda: contém os produtos vendidos em cada venda;
   - vendas: registra a data e o identificador da venda;
   - produtos: informações dos produtos vendidos;
   - categorias: descreve a categoria de cada produto;
   - marcas: descreve a marca de cada produto.

   Funções utilizadas:
   - strftime('%Y', v.data_venda): extrai o ano da data da venda;
   - COUNT(): conta o número de produtos vendidos;
   - ROUND() / printf(): formata o percentual de vendas.

   ===========================================================
*/


-- ===========================================================
-- ANÁLISE POR CATEGORIA
-- ===========================================================

-- Calcula a quantidade total de itens vendidos em 2022
WITH Total_Vendas AS (
    SELECT COUNT(*) AS Total_Vendas_2022
    FROM itens_venda iv
    JOIN vendas v 
        ON v.id_venda = iv.venda_id
    WHERE strftime('%Y', v.data_venda) = '2022'
)

-- Calcula o total e o percentual de vendas por categoria
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


-- ===========================================================
-- ANÁLISE POR MARCA
-- ===========================================================

-- Calcula a quantidade total de itens vendidos em 2022
WITH Total_Vendas AS (
    SELECT COUNT(*) AS Total_Vendas_2022
    FROM itens_venda iv
    JOIN vendas v 
        ON v.id_venda = iv.venda_id
    WHERE strftime('%Y', v.data_venda) = '2022'
)

-- Calcula o total e o percentual de vendas por marca
SELECT 
    Nome_Marca, 
    Qtd_Vendas, 
    printf('%.2f%%', 100.0 * Qtd_Vendas / tv.Total_Vendas_2022) AS Porcentagem
FROM (
    SELECT 
        m.nome AS Nome_Marca, 
        COUNT(iv.produto_id) AS Qtd_Vendas
    FROM itens_venda iv
    JOIN vendas v 
        ON v.id_venda = iv.venda_id
    JOIN produtos p 
        ON p.id_produto = iv.produto_id
    JOIN categorias c 
        ON c.id_categoria = p.categoria_id
  	JOIN marcas m
  		ON m.id_marca = p.marca_id
    WHERE strftime('%Y', v.data_venda) = '2022'
    GROUP BY Nome_Marca
    ORDER BY Qtd_Vendas DESC
), Total_Vendas tv;

