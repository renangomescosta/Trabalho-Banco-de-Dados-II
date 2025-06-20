VACUUM ANALYZE contem;

-- Indexação
CREATE INDEX idx_contem_id_produto ON contem (id_produto);
CREATE INDEX idx_contem_id_compra ON contem (id_compra);
CREATE INDEX idx_compra_cpf_cliente ON compra (cpf_cliente);
CREATE INDEX IF NOT EXISTS idx_compra_cpf_cliente ON compra (cpf_cliente);
CREATE INDEX idx_compra_data_compra ON compra (Data_compra);
CREATE INDEX IF NOT EXISTS idx_pessoa_email ON pessoa (email);
CREATE INDEX IF NOT EXISTS idx_pessoa_nome ON pessoa (Nome);
CREATE INDEX IF NOT EXISTS idx_produto_nome ON produto (Nome);

-- GIN
CREATE EXTENSION IF NOT EXISTS pg_trgm;

DROP INDEX IF EXISTS idx_pessoa_nome;
DROP INDEX IF EXISTS idx_produto_nome; -- Cuidado, vamos recriar este abaixo

CREATE INDEX idx_gin_pessoa_nome ON pessoa USING gin (Nome gin_trgm_ops);
CREATE INDEX idx_gin_produto_nome ON produto USING gin (Nome gin_trgm_ops);
CREATE INDEX idx_gin_pessoa_endereco ON pessoa USING gin (Endereco gin_trgm_ops);