----------------------------------
-- CRIAÇÃO DO BANCO DE DADOS
----------------------------------
CREATE DATABASE IF NOT EXISTS sistema_vendas;
USE sistema_vendas;

----------------------------------
-- Tabela categoria
----------------------------------
CREATE TABLE IF NOT EXISTS Categoria (
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualização DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    Ativo TINYINT(1) DEFAULT 1
);

----------------------------------
-- Tabela FormaPagamento
----------------------------------
CREATE TABLE IF NOT EXISTS FormaPagamento (
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT, 
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    Ativo TINYINT(1) DEFAULT 1
);

----------------------------------
-- Tabela Produto
----------------------------------
CREATE TABLE IF NOT EXISTS Produto (
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10, 2) NOT NULL DEFAULT 0,
    CategoriaID INT,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    Ativo TINYINT(1) DEFAULT 1,
    INDEX idx_nome_descricao (Nome), -- Adiciona indece nas colunas Nome
    CONSTRAINT fk_categoria_produto FOREIGN KEY (CategoriaID) REFERENCES Categoria(Id)
);

----------------------------------
-- Tabela CLiente
----------------------------------
CREATE TABLE IF NOT EXISTS Cliente (
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Telefone VARCHAR(20),
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    Ativo TINYINT(1) DEFAULT 1,
    INDEX idx_nome (Nome)
);

ALTER TABLE Cliente
	ADD COLUMN DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP;

----------------------------------
-- Tabela Pedido
----------------------------------
CREATE TABLE IF NOT EXISTS Pedido (
	Id INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    DataPedido DATETIME,
    FormaPagamento INT,
    Status VARCHAR(50),
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(id),
    FOREIGN KEY (FormaPagamento) REFERENCES FormaPagamento(Id)
);

----------------------------------
-- Tabela ItemPedido
----------------------------------
CREATE TABLE IF NOT EXISTS 	ItemPedido (
	Id INT AUTO_INCREMENT PRIMARY KEY,
    PedidoID INT,
    ProdutoID INT,
    Quantidade INT,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    FOREIGN KEY (PedidoID) REFERENCES Pedido(Id),
    FOREIGN KEY (ProdutoID) REFERENCES Produto(Id)
);

----------------------------------
-- Tabela GrupoUsuário
----------------------------------
CREATE TABLE IF NOT EXISTS GrupoUsuario (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    Ativo TINYINT(1) DEFAULT 1
);

----------------------------------
-- Tabela Permissao
----------------------------------
CREATE TABLE IF NOT EXISTS Permissao (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    Ativo TINYINT(1) DEFAULT 1
);

----------------------------------
-- Tabela PermissaoGrupo
----------------------------------
CREATE TABLE IF NOT EXISTS PermissaoGrupo (
    PermissaoID INT,
    GrupoUsuarioID INT,
    PRIMARY KEY (PermissaoID, GrupoUsuarioID),
    FOREIGN KEY (PermissaoID) REFERENCES Permissao(Id),
    FOREIGN KEY (GrupoUsuarioID) REFERENCES GrupoUsuario(Id)
);

----------------------------------
-- Tabela Usuario
----------------------------------      
CREATE TABLE IF NOT EXISTS Usuario (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    NomeUsuario VARCHAR(50) NOT NULL,
    Senha VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    GrupoUsuarioID INT,
    Ativo TINYINT(1) DEFAULT 1,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    UNIQUE (NomeUsuario), -- Restrição UNIQUE na coluna NomeUsuario
    UNIQUE (Email), -- Restrição UNIQUE na coluna Email
    FOREIGN KEY (GrupoUsuarioID) REFERENCES GrupoUsuario(Id)
);