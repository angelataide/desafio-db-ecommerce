CREATE DATABASE IF NOT EXISTS ecommerce_desafio;
USE ecommerce_desafio;

-- Tabela Cliente (Superclasse)
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    endereco VARCHAR(255),
    tipoCliente ENUM('PF', 'PJ') NOT NULL
);

-- Tabela Pessoa Física (Subclasse de Cliente)
CREATE TABLE PessoaFisica (
    idCliente INT PRIMARY KEY,
    CPF CHAR(11) NOT NULL UNIQUE,
    dataNascimento DATE,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Pessoa Jurídica (Subclasse de Cliente)
CREATE TABLE PessoaJuridica (
    idCliente INT PRIMARY KEY,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    razaoSocial VARCHAR(255) NOT NULL,
    nomeFantasia VARCHAR(255),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Produto
CREATE TABLE Produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    nomeProduto VARCHAR(255) NOT NULL,
    descricao TEXT,
    categoria VARCHAR(100),
    preco DECIMAL(10, 2) NOT NULL,
    CHECK (preco > 0)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    dataPedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    statusPedido ENUM('Em processamento', 'Enviado', 'Entregue', 'Cancelado') DEFAULT 'Em processamento',
    frete DECIMAL(10, 2) DEFAULT 0.00,
    statusEntrega ENUM('Aguardando envio', 'Em trânsito', 'Saiu para entrega', 'Entregue') DEFAULT 'Aguardando envio',
    codigoRastreio VARCHAR(50),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Pagamento (Suporta múltiplos pagamentos por pedido)
CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT,
    tipoPagamento ENUM('Cartão de Crédito', 'Boleto', 'PIX', 'Vale-Presente') NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    statusPagamento ENUM('Pendente', 'Aprovado', 'Recusado') DEFAULT 'Pendente',
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- Tabela ItemPedido (Tabela associativa M:N entre Pedido e Produto)
CREATE TABLE ItemPedido (
    idPedido INT,
    idProduto INT,
    quantidade INT NOT NULL,
    precoUnitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (idPedido, idProduto),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    localizacao VARCHAR(255) NOT NULL
);

-- Tabela ProdutoEstoque (Tabela associativa M:N entre Produto e Estoque)
CREATE TABLE ProdutoEstoque (
    idProduto INT,
    idEstoque INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (idProduto, idEstoque),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idEstoque) REFERENCES Estoque(idEstoque)
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razaoSocial VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    email VARCHAR(255),
    telefone VARCHAR(20)
);

-- Tabela ProdutoFornecedor (Tabela associativa M:N entre Produto e Fornecedor)
CREATE TABLE ProdutoFornecedor (
    idProduto INT,
    idFornecedor INT,
    PRIMARY KEY (idProduto, idFornecedor),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idFornecedor) REFERENCES Fornecedor(idFornecedor)
);

-- Tabela Vendedor (Terceirizado/Marketplace)
CREATE TABLE Vendedor (
    idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    razaoSocial VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) UNIQUE,
    nomeFantasia VARCHAR(255),
    localizacao VARCHAR(255)
);

-- Tabela ProdutoVendedor (Tabela associativa M:N entre Produto e Vendedor)
CREATE TABLE ProdutoVendedor (
    idProduto INT,
    idVendedor INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (idProduto, idVendedor),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idVendedor) REFERENCES Vendedor(idVendedor)
);
