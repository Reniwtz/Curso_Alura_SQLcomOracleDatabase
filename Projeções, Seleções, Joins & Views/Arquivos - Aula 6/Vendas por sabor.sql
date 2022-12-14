
SELECT TP.SABOR, INF.QUANTIDADE FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO;

SELECT TP.SABOR, NF.DATA_VENDA, INF.QUANTIDADE FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO;

SELECT TP.SABOR, TO_CHAR(NF.DATA_VENDA, 'YYYY') AS ANO, INF.QUANTIDADE FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO;

SELECT TP.SABOR, TO_CHAR(NF.DATA_VENDA, 'YYYY') AS ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDIDA FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
GROUP BY TP.SABOR, TO_CHAR(NF.DATA_VENDA, 'YYYY');

SELECT TP.SABOR, TO_CHAR(NF.DATA_VENDA, 'YYYY') AS ANO, 
SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDIDA FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE TO_CHAR(NF.DATA_VENDA, 'YYYY') = '2016'
GROUP BY TP.SABOR, TO_CHAR(NF.DATA_VENDA, 'YYYY');

--- QUARDAR ELA
SELECT TP.SABOR, TO_CHAR(NF.DATA_VENDA, 'YYYY') AS ANO, 
SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDIDA FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE TO_CHAR(NF.DATA_VENDA, 'YYYY') = '2016'
GROUP BY TP.SABOR, TO_CHAR(NF.DATA_VENDA, 'YYYY')
ORDER BY SUM(INF.QUANTIDADE) DESC;

-- 613309 / TOTAL DE VENDA --> % VENDA DA MANGA
-- 487625 / TOTAL DE VENDA --> % VENDA DA MELANCIA

SELECT TO_CHAR(NF.DATA_VENDA, 'YYYY') AS ANO, 
SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDIDA FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE TO_CHAR(NF.DATA_VENDA, 'YYYY') = '2016'
GROUP BY TO_CHAR(NF.DATA_VENDA, 'YYYY')
ORDER BY SUM(INF.QUANTIDADE) DESC;

SELECT VENDA_SABOR.SABOR, VENDA_SABOR.ANO, VENDA_SABOR.QUANTIDADE_VENDIDA, 
TOTAL_VENDA.QUANTIDADE_VENDIDA AS TOTAL FROM 
(
SELECT TP.SABOR, TO_CHAR(NF.DATA_VENDA, 'YYYY') AS ANO, 
SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDIDA FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE TO_CHAR(NF.DATA_VENDA, 'YYYY') = '2016'
GROUP BY TP.SABOR, TO_CHAR(NF.DATA_VENDA, 'YYYY')
ORDER BY SUM(INF.QUANTIDADE) DESC
) VENDA_SABOR
INNER JOIN
(
SELECT TO_CHAR(NF.DATA_VENDA, 'YYYY') AS ANO, 
SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDIDA FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE TO_CHAR(NF.DATA_VENDA, 'YYYY') = '2016'
GROUP BY TO_CHAR(NF.DATA_VENDA, 'YYYY')
ORDER BY SUM(INF.QUANTIDADE) DESC
) TOTAL_VENDA
ON VENDA_SABOR.ANO = TOTAL_VENDA.ANO;

SELECT VENDA_SABOR.SABOR, VENDA_SABOR.ANO, VENDA_SABOR.QUANTIDADE_VENDIDA, 
TOTAL_VENDA.QUANTIDADE_VENDIDA AS TOTAL,
ROUND(((VENDA_SABOR.QUANTIDADE_VENDIDA/TOTAL_VENDA.QUANTIDADE_VENDIDA)*100),2) AS PARTICIPACAO
FROM 
(
SELECT TP.SABOR, TO_CHAR(NF.DATA_VENDA, 'YYYY') AS ANO, 
SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDIDA FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE TO_CHAR(NF.DATA_VENDA, 'YYYY') = '2016'
GROUP BY TP.SABOR, TO_CHAR(NF.DATA_VENDA, 'YYYY')
ORDER BY SUM(INF.QUANTIDADE) DESC
) VENDA_SABOR
INNER JOIN
(
SELECT TO_CHAR(NF.DATA_VENDA, 'YYYY') AS ANO, 
SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDIDA FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE TO_CHAR(NF.DATA_VENDA, 'YYYY') = '2016'
GROUP BY TO_CHAR(NF.DATA_VENDA, 'YYYY')
ORDER BY SUM(INF.QUANTIDADE) DESC
) TOTAL_VENDA
ON VENDA_SABOR.ANO = TOTAL_VENDA.ANO;

SELECT VENDA_SABOR.SABOR, VENDA_SABOR.ANO, VENDA_SABOR.QUANTIDADE_VENDIDA, 
ROUND(((VENDA_SABOR.QUANTIDADE_VENDIDA/TOTAL_VENDA.QUANTIDADE_VENDIDA)*100),2) AS PARTICIPACAO
FROM 
(
SELECT TP.SABOR, TO_CHAR(NF.DATA_VENDA, 'YYYY') AS ANO, 
SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDIDA FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE TO_CHAR(NF.DATA_VENDA, 'YYYY') = '2016'
GROUP BY TP.SABOR, TO_CHAR(NF.DATA_VENDA, 'YYYY')
ORDER BY SUM(INF.QUANTIDADE) DESC
) VENDA_SABOR
INNER JOIN
(
SELECT TO_CHAR(NF.DATA_VENDA, 'YYYY') AS ANO, 
SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDIDA FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE TO_CHAR(NF.DATA_VENDA, 'YYYY') = '2016'
GROUP BY TO_CHAR(NF.DATA_VENDA, 'YYYY')
ORDER BY SUM(INF.QUANTIDADE) DESC
) TOTAL_VENDA
ON VENDA_SABOR.ANO = TOTAL_VENDA.ANO



