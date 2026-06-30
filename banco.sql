-- =========================
-- BANCO DE DADOS
-- =========================
CREATE DATABASE ControleEstoqueDB;
GO

USE ControleEstoqueDB;
GO

-- =========================
-- LIMPAR TABELAS (SEGURANÇA)
-- =========================
DROP TABLE IF EXISTS Estoque;
DROP TABLE IF EXISTS Produtos;
DROP TABLE IF EXISTS Fornecedores;
DROP TABLE IF EXISTS Categorias;
GO

-- =========================
-- TABELA CATEGORIAS
-- =========================
CREATE TABLE Categorias (
    CategoriaID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL UNIQUE
);
GO

-- =========================
-- TABELA FORNECEDORES
-- =========================
CREATE TABLE Fornecedores (
    FornecedorID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Contato VARCHAR(100),
    Telefone VARCHAR(20)
);
GO

-- =========================
-- TABELA PRODUTOS
-- =========================
CREATE TABLE Produtos (
    ProdutoID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(255),
    Preco DECIMAL(10,2) NOT NULL,
    CategoriaID INT,
    FornecedorID INT,

    CONSTRAINT FK_Produtos_Categorias
        FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID),

    CONSTRAINT FK_Produtos_Fornecedores
        FOREIGN KEY (FornecedorID) REFERENCES Fornecedores(FornecedorID)
);
GO

-- =========================
-- TABELA ESTOQUE
-- =========================
CREATE TABLE Estoque (
    EstoqueID INT IDENTITY(1,1) PRIMARY KEY,
    ProdutoID INT UNIQUE,
    Quantidade INT NOT NULL CHECK (Quantidade >= 0),
    DataAtualizacao DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Estoque_Produtos
        FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);
GO

-- =========================
-- INSERTS (DADOS DE TESTE)
-- =========================

-- Categorias
INSERT INTO Categorias (Nome)
VALUES ('Eletrônicos'), ('Informática'), ('Papelaria');

-- Fornecedores
INSERT INTO Fornecedores (Nome, Contato, Telefone)
VALUES
('Tech Distribuidora', 'João Silva', '11999999999'),
('ABC Informática', 'Maria Souza', '11888888888'),
('Papelaria Central', 'Carlos Lima', '11777777777');

-- Produtos
INSERT INTO Produtos (Nome, Descricao, Preco, CategoriaID, FornecedorID)
VALUES
('Mouse Gamer', 'Mouse RGB', 150.00, 2, 1),
('Teclado Mecânico', 'Teclado com LED', 300.00, 2, 2),
('Caderno', 'Caderno 200 folhas', 25.00, 3, 3);

-- Estoque
INSERT INTO Estoque (ProdutoID, Quantidade)
VALUES
(1, 20),
(2, 15),
(3, 50);

GO

-- =========================
-- CONSULTA FINAL (RELATÓRIO)
-- =========================
SELECT
    P.ProdutoID,
    P.Nome AS Produto,
    P.Preco,
    P.Descricao,
    C.Nome AS Categoria,
    F.Nome AS Fornecedor,
    E.Quantidade,
    E.DataAtualizacao
FROM Produtos P
LEFT JOIN Categorias C ON C.CategoriaID = P.CategoriaID
LEFT JOIN Fornecedores F ON F.FornecedorID = P.FornecedorID
LEFT JOIN Estoque E ON E.ProdutoID = P.ProdutoID;
GO