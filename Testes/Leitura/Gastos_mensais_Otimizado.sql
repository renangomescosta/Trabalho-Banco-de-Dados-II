SELECT
    -- Informações do Cliente
    p.Nome AS Nome_Cliente,
    p.CPF,

    -- Cálculo do Gasto Total (CORRIGIDO: usando o preço da tabela Produto)
    SUM(c.Quantidade_comprada * pr.Valor_unitario) AS Gasto_Total_No_Mes

FROM
    Contem c -- Começando pela tabela de itens

-- Juntando com as outras tabelas para obter os detalhes
JOIN
    Compra co ON c.id_compra = co.id_compra
JOIN
    Produto pr ON c.id_produto = pr.id_produto -- O Join com Produto é essencial para pegar o preço
JOIN
    Pessoa p ON co.CPF_Cliente = p.CPF

WHERE
    -- Filtra as compras para incluir apenas aquelas feitas no mês atual.
    -- DATE_TRUNC('month', NOW()) encontra o primeiro momento do mês corrente.
    co.Data_compra >= DATE_TRUNC('month', NOW())

GROUP BY
    -- Agrupamos por cliente para somar todas as suas compras
    p.CPF, p.Nome

ORDER BY
    -- Ordena para mostrar os clientes que mais gastaram no topo
    Gasto_Total_No_Mes DESC;
