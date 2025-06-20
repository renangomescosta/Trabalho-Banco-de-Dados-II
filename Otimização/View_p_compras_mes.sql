-- Cria a tabela física com os dados pré-calculados
CREATE MATERIALIZED VIEW gastos_mensais_por_cliente AS
SELECT
    -- Agrupa a data para o primeiro dia do mês, facilitando os filtros
    DATE_TRUNC('month', co.Data_compra)::date AS mes_da_compra,
    p.CPF,
    p.Nome AS nome_cliente,
    SUM(c.Quantidade_comprada * pr.Valor_unitario) AS gasto_total_no_mes
FROM
    Compra co
JOIN
    Contem c ON co.id_compra = c.id_compra
JOIN
    Produto pr ON c.id_produto = pr.id_produto
JOIN
    Pessoa p ON co.CPF_Cliente = p.CPF
-- Agrupa os resultados por mês e por cliente
GROUP BY
    mes_da_compra, p.CPF, p.Nome
-- Ordena para referência, mas não é estritamente necessário aqui
ORDER BY
    mes_da_compra DESC, gasto_total_no_mes DESC;

CREATE INDEX idx_gastos_mensais_mes ON gastos_mensais_por_cliente (mes_da_compra);


-- Esta consulta será EXTREMAMENTE RÁPIDA (poucos milissegundos)
SELECT *
FROM gastos_mensais_por_cliente
WHERE mes_da_compra = DATE_TRUNC('month', NOW())::date;