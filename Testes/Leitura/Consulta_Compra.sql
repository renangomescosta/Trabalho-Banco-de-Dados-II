SELECT
    COALESCE(SUM(p.Valor_unitario * c.Quantidade_comprada), 0) AS valor_total_calculado
FROM
    Contem c
JOIN
    Produto p ON c.id_produto = p.id_produto
WHERE
    c.id_compra = 249752;