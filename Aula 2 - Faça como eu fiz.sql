---------------------------------------------------------------------
-- 📊 ANÁLISE DE VENDAS - CONSULTAS EXPLORATÓRIAS E TEMPORAIS
-- Banco de Dados: banco_de_dados_vendas.db
-- Descrição: Consultas SQL para análise de comportamento de vendas ao longo dos anos.
---------------------------------------------------------------------

-- 1️⃣ VISUALIZAÇÃO DAS TABELAS PRINCIPAIS
-- Objetivo: Verificar a estrutura e o conteúdo das tabelas base
--            do banco de dados para garantir integridade e coerência.

SELECT * FROM categorias;
SELECT * FROM fornecedores;
SELECT * FROM marcas;

-- Exibe apenas as primeiras 5 linhas da tabela de vendas
SELECT * FROM vendas LIMIT 5;


---------------------------------------------------------------------
-- 2️⃣ IDENTIFICAÇÃO DOS ANOS COM REGISTROS DE VENDAS
-- Objetivo: Extrair os diferentes anos em que ocorreram vendas,
--            utilizando a função strftime() para formatação da data.

SELECT DISTINCT(strftime('%Y', data_venda)) AS Ano
FROM vendas
ORDER BY Ano;


---------------------------------------------------------------------
-- 3️⃣ QUANTIDADE TOTAL DE VENDAS POR ANO
-- Objetivo: Calcular o volume total de vendas em cada ano
--            e identificar possíveis tendências de crescimento.

SELECT 
    strftime('%Y', data_venda) AS Ano, 
    COUNT(id_venda) AS total_venda
FROM vendas
GROUP BY Ano
ORDER BY Ano;


---------------------------------------------------------------------
-- 4️⃣ QUANTIDADE TOTAL DE VENDAS POR MÊS E ANO
-- Objetivo: Analisar a sazonalidade das vendas ao longo do tempo,
--            verificando variações mensais e padrões de consumo.

SELECT 
    strftime('%Y', data_venda) AS Ano, 
    strftime('%m', data_venda) AS Mes, 
    COUNT(id_venda) AS total_venda
FROM vendas
GROUP BY Ano, Mes
ORDER BY Ano, Mes;


---------------------------------------------------------------------
-- 5️⃣ MESES COM MAIOR EXPECTATIVA DE VENDAS
-- Contexto: A empresa acredita que os meses com maior movimento
--            são Janeiro (01 - Ano Novo), Novembro (11 - Black Friday)
--            e Dezembro (12 - Natal).
-- Objetivo: Verificar se há aumento real de vendas nesses períodos.

SELECT 
    strftime('%Y', data_venda) AS Ano, 
    strftime('%m', data_venda) AS Mes, 
    COUNT(id_venda) AS total_venda
FROM vendas
WHERE Mes IN ('01', '11', '12')
GROUP BY Ano, Mes
ORDER BY Ano, Mes;


---------------------------------------------------------------------
-- ✅ RESUMO ANALÍTICO (INSIGHTS ESPERADOS)
-- • Espera-se que os meses de Novembro e Dezembro apresentem picos de vendas
--   devido às campanhas sazonais (Black Friday e Natal).
-- • Janeiro pode demonstrar leve alta em função das compras pós-festas.
-- • Os demais meses devem manter comportamento estável ou sazonal conforme o setor.
---------------------------------------------------------------------
