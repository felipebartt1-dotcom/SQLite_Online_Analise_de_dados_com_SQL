-- ======================================================
-- AJUSTE DE VALORES INCORRETOS NA TABELA PRODUTOS
-- ======================================================
-- Parâmetros de preços válidos:
-- - Bola de Futebol → entre 20 e 100
-- - Chocolate       → entre 10 e 50
-- - Celular         → entre 80 e 5000
-- - Livro de Ficção → entre 10 e 200
-- - Camisa          → entre 80 e 200
-- ======================================================


-- ======================================================
-- Produto: Bola de Futebol
-- ======================================================

-- Consulta para identificar valores fora do padrão
SELECT nome_produto, preco
FROM produtos
WHERE nome_produto = 'Bola de Futebol'
  AND (preco < 20 OR preco > 100)
ORDER BY preco;

-- Atualiza valores incorretos para NULL
UPDATE produtos
SET preco = NULL
WHERE nome_produto = 'Bola de Futebol'
  AND (preco < 20 OR preco > 100);



-- ======================================================
-- Produto: Chocolate
-- ======================================================

-- Consulta para identificar valores fora do padrão
SELECT nome_produto, preco
FROM produtos
WHERE nome_produto = 'Chocolate'
  AND (preco < 10 OR preco > 50)
ORDER BY preco;

-- Atualiza valores incorretos para NULL
UPDATE produtos
SET preco = NULL
WHERE nome_produto = 'Chocolate'
  AND (preco < 10 OR preco > 50);



-- ======================================================
-- Produto: Celular
-- ======================================================

-- Consulta para identificar valores fora do padrão
SELECT nome_produto, preco
FROM produtos
WHERE nome_produto = 'Celular'
  AND (preco < 80 OR preco > 5000)
ORDER BY preco;

-- Atualiza valores incorretos para NULL
UPDATE produtos
SET preco = NULL
WHERE nome_produto = 'Celular'
  AND (preco < 80 OR preco > 5000);



-- ======================================================
-- Produto: Livro de Ficção
-- ======================================================

-- Consulta para identificar valores fora do padrão
SELECT nome_produto, preco
FROM produtos
WHERE nome_produto = 'Livro de Ficção'
  AND (preco < 10 OR preco > 200)
ORDER BY preco;

-- Atualiza valores incorretos para NULL
UPDATE produtos
SET preco = NULL
WHERE nome_produto = 'Livro de Ficção'
  AND (preco < 10 OR preco > 200);



-- ======================================================
-- Produto: Camisa
-- ======================================================

-- Consulta para identificar valores fora do padrão
SELECT nome_produto, preco
FROM produtos
WHERE nome_produto = 'Camisa'
  AND (preco < 80 OR preco > 200)
ORDER BY preco;

-- Atualiza valores incorretos para NULL
UPDATE produtos
SET preco = NULL
WHERE nome_produto = 'Camisa'
  AND (preco < 80 OR preco > 200);
