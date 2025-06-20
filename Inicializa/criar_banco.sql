-- Criação da tabela Pessoa (não tem FK para outras tabelas, pode ser criada primeiro)
CREATE TABLE Pessoa (
    CPF VARCHAR(14) PRIMARY KEY, -- CPF como chave primária (PK)
    Nome VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Telefone VARCHAR(20),
    Endereco VARCHAR(255),
    Aniversario DATE
);

-- Criação da tabela Cliente (referencia Pessoa)
CREATE TABLE Cliente (
    CPF VARCHAR(14) PRIMARY KEY, -- CPF do cliente como chave primária (PK)
    Pontuacao INT DEFAULT 0,
    FOREIGN KEY (CPF) REFERENCES Pessoa(CPF),

    CONSTRAINT chk_pontuacao_nao_negativo CHECK (Pontuacao >= 0)
);

-- Criação da tabela Cargo (não tem FK para outras tabelas, pode ser criada cedo)
CREATE TABLE Cargo (
    id_cargo SERIAL PRIMARY KEY, -- ID do cargo como chave primária (PK) - Corrigido de AUTO_INCREMENT para SERIAL
    nome VARCHAR(255) NOT NULL UNIQUE
);

-- Criação da tabela Funcionario (referencia Pessoa e Cargo)
CREATE TABLE Funcionario (
    CPF VARCHAR(14) PRIMARY KEY, -- CPF do funcionário como chave primária (PK)
    Salario DECIMAL(10, 2),
    Senha VARCHAR(255) NOT NULL,
    id_cargo INT NOT NULL, -- Chave estrangeira (FK) referenciando Cargo
    FOREIGN KEY (CPF) REFERENCES Pessoa(CPF),
    FOREIGN KEY (id_cargo) REFERENCES Cargo(id_cargo),

    CONSTRAINT chk_salario_nao_negativo CHECK (Salario >= 0)
);

-- Criação da tabela Produto (não tem FK para outras tabelas, pode ser criada cedo)
CREATE TABLE Produto (
    id_produto SERIAL PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Quantidade_em_estoque INT NOT NULL,
    Prateleira VARCHAR(50),
    Corredor VARCHAR(50),
    Validade DATE,
    Valor_unitario DECIMAL(10, 2) NOT NULL,

    CONSTRAINT chk_estoque_nao_negativo CHECK (Quantidade_em_estoque >= 0),
    CONSTRAINT chk_valor_unitario_nao_negativo CHECK (Valor_unitario >= 0)
);


-- Criação da tabela Compra (referencia Cliente)
CREATE TABLE Compra (
    id_compra SERIAL PRIMARY KEY, -- ID da compra como chave primária (PK) - Corrigido de AUTO_INCREMENT para SERIAL
    CPF_Cliente VARCHAR(14),         
    Valor_total DECIMAL(10, 2) NOT NULL,
    Data_compra TIMESTAMP NOT NULL, -- Corrigido de DATETIME para TIMESTAMP
    FOREIGN KEY (CPF_Cliente) REFERENCES Cliente(CPF)
);

-- Criação da tabela Contem (tabela de relacionamento entre Compra e Produto)
CREATE TABLE Contem (
    id_compra INT NOT NULL,         -- Parte da chave primária composta e chave estrangeira (FK)
    id_produto INT NOT NULL,        -- Parte da chave primária composta e chave estrangeira (FK)
    Quantidade_comprada INT NOT NULL,
    PRIMARY KEY (id_compra, id_produto),
    FOREIGN KEY (id_compra) REFERENCES Compra(id_compra),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);