-- =================================================================================
-- CONSULTA NÃO OTIMIZADA DE GASTO MENSAL POR CLIENTE
-- Esta versão junta todas as tabelas primeiro e depois agrega,
-- o que pode ser ineficiente para grandes volumes de dados.
-- =================================================================================

SELECT
    -- Informações do Cliente
    p.Nome AS Nome_Cliente,
    p.CPF,

    -- Cálculo do Gasto Total
    SUM(c.Quantidade_comprada * pr.Valor_unitario) AS Gasto_Total_No_Mes

FROM
    Contem c -- Começando pela tabela de itens

-- Juntando com as outras tabelas para obter os detalhes
JOIN
    Compra co ON c.id_compra = co.id_compra
JOIN
    Produto pr ON c.id_produto = pr.id_produto
JOIN
    Pessoa p ON co.CPF_Cliente = p.CPF

WHERE
    -- Filtra as compras para incluir apenas aquelas feitas no mês atual.
    co.Data_compra >= DATE_TRUNC('month', NOW())

GROUP BY
    -- Agrupamos por cliente para somar todas as suas compras
    p.CPF, p.Nome

ORDER BY
    -- Ordena para mostrar os clientes que mais gastaram no topo
    Gasto_Total_No_Mes DESC;
