USE ecommerce_desafio;

-- Clientes
INSERT INTO Cliente (nome, email, telefone, endereco, tipoCliente) VALUES
('Maria Silva', 'maria.silva@email.com', '11987654321', 'Rua A, 123, São Paulo', 'PF'),
('Tech Solutions Ltda', 'contato@techsolutions.com', '1133334444', 'Av. B, 456, São Paulo', 'PJ'),
('João Pereira', 'joao.pereira@email.com', '21912345678', 'Rua C, 789, Rio de Janeiro', 'PF');

-- Detalhes PF/PJ
INSERT INTO PessoaFisica (idCliente, CPF, dataNascimento) VALUES
(1, '11122233344', '1990-05-15'),
(3, '55566677788', '1985-11-30');

INSERT INTO PessoaJuridica (idCliente, CNPJ, razaoSocial, nomeFantasia) VALUES
(2, '12345678000199', 'Tech Solutions e Comércio Ltda', 'Tech Solutions');

-- Produtos
INSERT INTO Produto (nomeProduto, descricao, categoria, preco) VALUES
('Notebook UltraSlim', 'Notebook leve com SSD de 512GB e 16GB RAM', 'Eletrônicos', 4500.00),
('Smartphone X', 'Smartphone com câmera de 108MP', 'Eletrônicos', 2800.00),
('Cadeira Gamer Ergonômica', 'Cadeira com ajuste lombar e braços 4D', 'Móveis', 1800.00);

-- Pedidos
INSERT INTO Pedido (idCliente, statusPedido, frete, statusEntrega, codigoRastreio) VALUES
(1, 'Enviado', 25.50, 'Em trânsito', 'BR123456789'),
(2, 'Em processamento', 0.00, 'Aguardando envio', NULL),
(1, 'Entregue', 30.00, 'Entregue', 'BR987654321');

-- Pagamentos (Pedido 1 pago com 2 métodos)
INSERT INTO Pagamento (idPedido, tipoPagamento, valor, statusPagamento) VALUES
(1, 'Cartão de Crédito', 2000.00, 'Aprovado'),
(1, 'PIX', 825.50, 'Aprovado'), -- Valor do Smartphone (2800) + Frete (25.50) = 2825.50. Erro no DML, vamos corrigir.
-- Corrigindo DML do Pagamento
DELETE FROM Pagamento WHERE idPedido = 1;
INSERT INTO Pagamento (idPedido, tipoPagamento, valor, statusPagamento) VALUES
(1, 'Cartão de Crédito', 2800.00, 'Aprovado'), -- Pagando o Smartphone
(1, 'PIX', 25.50, 'Aprovado'), -- Pagando o Frete
(2, 'Boleto', 9000.00, 'Pendente'), -- Pagando 2 Notebooks
(3, 'Cartão de Crédito', 1830.00, 'Aprovado'); -- Pagando a Cadeira + Frete

-- Itens dos Pedidos
INSERT INTO ItemPedido (idPedido, idProduto, quantidade, precoUnitario) VALUES
(1, 2, 1, 2800.00), -- Maria comprou 1 Smartphone
(2, 1, 2, 4500.00), -- Tech Solutions comprou 2 Notebooks
(3, 3, 1, 1800.00); -- Maria comprou 1 Cadeira

-- Fornecedores
INSERT INTO Fornecedor (razaoSocial, CNPJ, email) VALUES
('Eletrônicos Delta S.A.', '11111111000111', 'vendas@delta.com'),
('Móveis Conforto Ltda', '22222222000122', 'contato@conforto.com');

-- Vendedores (Marketplace)
INSERT INTO Vendedor (razaoSocial, CNPJ, nomeFantasia, localizacao) VALUES
('PC Rápido Info', '33333333000133', 'PC Rápido', 'Santa Catarina'),
('Casa Gamer Store', '44444444000144', 'Casa Gamer', 'Paraná'),
('Delta Revenda', '11111111000111', 'Delta Eletrônicos', 'São Paulo'); -- Este Vendedor é também um Fornecedor (mesmo CNPJ)

-- Estoque
INSERT INTO Estoque (localizacao) VALUES
('Galpão SP-01'),
('Galpão RJ-05');

-- Mapeamentos M:N
INSERT INTO ProdutoFornecedor (idProduto, idFornecedor) VALUES
(1, 1), -- Notebook (Delta)
(2, 1), -- Smartphone (Delta)
(3, 2); -- Cadeira (Conforto)

INSERT INTO ProdutoEstoque (idProduto, idEstoque, quantidade) VALUES
(1, 1, 50),  -- Notebook no Galpão SP
(2, 1, 100), -- Smartphone no Galpão SP
(3, 2, 30);  -- Cadeira no Galpão RJ

INSERT INTO ProdutoVendedor (idProduto, idVendedor, quantidade) VALUES
(1, 1, 20), -- Notebook (PC Rápido)
(1, 3, 30), -- Notebook (Delta Revenda)
(3, 2, 15); -- Cadeira (Casa Gamer)
