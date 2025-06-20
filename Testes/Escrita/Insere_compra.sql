BEGIN;

WITH proximo_id AS (
    SELECT MAX(id_compra) + 1 AS id FROM compra
),
nova_compra AS (
    INSERT INTO Compra (
        id_compra,
        CPF_Cliente, 
        Data_compra, 
        Valor_total 
    ) 
    SELECT 
        id,
        '111.222.333-44',
        NOW(),
        0
    FROM proximo_id
    RETURNING id_compra
)
INSERT INTO Contem (
    id_compra, 
    id_produto, 
    quantidade_comprada
)
SELECT
    nc.id_compra,
    itens.id_produto,
    itens.quantidade
FROM 
    nova_compra nc,
    (VALUES
        (778, 2),
        (105, 1),
        (42, 10),
        (812, 1),
        (23, 5)
    ) AS itens(id_produto, quantidade);

COMMIT;