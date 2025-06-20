EXPLAIN ANALYZE
SELECT
    co.id_compra,          -- O ID da transação da compra
    co.CPF_Cliente,        -- O CPF de quem comprou
    co.Data_compra,        -- A data e hora exata da compra
    c.Quantidade_comprada, -- A quantidade específica de carne comprada nesta transação
    p.Nome AS Produto_Comprado -- O nome exato do produto para confirmação
FROM
    Produto p
JOIN
    Contem c ON p.id_produto = c.id_produto -- Junta Produto com os itens da compra
JOIN
    Compra co ON c.id_compra = co.id_compra   -- Junta os itens da compra com os dados gerais da compra
WHERE
    p.Nome LIKE 'Carne%'; -- Filtra para encontrar apenas produtos que começam com 'Carne' (Ex: "Carne Moída", "Carne de Sol", etc.)
