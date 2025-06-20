\copy Pessoa (CPF, Nome, Email, Telefone, Endereco, Aniversario) FROM '/tmp/meus_scripts_sql/DATA/Pessoas.csv' WITH (FORMAT CSV, DELIMITER ',', HEADER TRUE);
\copy Cliente (CPF, Pontuacao) FROM '/tmp/meus_scripts_sql/DATA/Cliente.csv' WITH (FORMAT CSV, DELIMITER ',', HEADER TRUE);
\copy Cargo (id_cargo, nome) FROM '/tmp/meus_scripts_sql/DATA/Cargo.csv' WITH (FORMAT CSV, DELIMITER ',', HEADER TRUE, QUOTE '"');
\copy Funcionario (CPF, Senha, Salario, id_cargo) FROM '/tmp/meus_scripts_sql/DATA/Funcionario.csv' WITH (FORMAT CSV, DELIMITER ',', HEADER TRUE);
SET datestyle TO 'DMY';
\copy Produto (id_produto, Nome, Quantidade_em_estoque, Prateleira, Corredor, Validade, Valor_unitario) FROM '/tmp/meus_scripts_sql/DATA/Produtos.csv' WITH (FORMAT CSV, DELIMITER ',', HEADER TRUE);
SET datestyle TO 'ISO, MDY';
\copy Compra (id_compra, CPF_Cliente, Valor_total, Data_compra) FROM '/tmp/meus_scripts_sql/DATA/Compra.csv' WITH (FORMAT CSV, DELIMITER ',', HEADER TRUE);
\copy Contem (id_compra, id_produto, Quantidade_comprada) FROM '/tmp/meus_scripts_sql/DATA/Contem.csv' WITH (FORMAT CSV, DELIMITER ',', HEADER TRUE);