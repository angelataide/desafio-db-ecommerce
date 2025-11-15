-- Pergunta: Qual o número total de pedidos por cliente?
SELECT
    c.nome AS Cliente,
    c.tipoCliente AS Tipo,
    COUNT(p.idPedido) AS TotalPedidos
FROM
    Cliente c
JOIN
    Pedido p ON c.idCliente = p.idCliente
GROUP BY
    c.idCliente;

-- Pergunta: Existem vendedores (terceiros) que também são fornecedores de produtos?
SELECT
    v.razaoSocial,
    v.CNPJ
FROM
    Vendedor v
WHERE
    v.CNPJ IN (SELECT CNPJ FROM Fornecedor);

-- Pergunta: Qual fornecedor fornece cada produto e onde ele está estocado?
SELECT
    p.nomeProduto AS Produto,
    p.categoria AS Categoria,
    f.razaoSocial AS Fornecedor,
    e.localizacao AS LocalEstoque,
    pe.quantidade AS QtdEstoque
FROM
    Produto p
JOIN
    ProdutoFornecedor pf ON p.idProduto = pf.idProduto
JOIN
    Fornecedor f ON pf.idFornecedor = f.idFornecedor
JOIN
    ProdutoEstoque pe ON p.idProduto = pe.idProduto
JOIN
    Estoque e ON pe.idEstoque = e.idEstoque
ORDER BY
    Produto;

-- Pergunta: Quais produtos são fornecidos por qual fornecedor?
SELECT
    f.razaoSocial AS Fornecedor,
    p.nomeProduto AS Produto
FROM
    Fornecedor f
JOIN
    ProdutoFornecedor pf ON f.idFornecedor = pf.idFornecedor
JOIN
    Produto p ON pf.idProduto = p.idProduto
ORDER BY
    Fornecedor, Produto;

-- Pergunta: Qual o valor total de cada pedido (soma dos itens + frete)?
SELECT
    p.idPedido,
    c.nome AS Cliente,
    -- Atributo derivado complexo
    (SUM(ip.precoUnitario * ip.quantidade) + p.frete) AS ValorTotalPedido
FROM
    Pedido p
JOIN
    Cliente c ON p.idCliente = c.idCliente
JOIN
    ItemPedido ip ON p.idPedido = ip.idPedido
GROUP BY
    p.idPedido, c.nome, p.frete
ORDER BY
    ValorTotalPedido DESC;

-- Pergunta: Quais categorias tiveram um volume total de vendas (em unidades) superior a 1?
SELECT
    p.categoria,
    SUM(ip.quantidade) AS TotalUnidadesVendidas
FROM
    Produto p
JOIN
    ItemPedido ip ON p.idProduto = ip.idProduto
GROUP BY
    p.categoria
HAVING -- Filtro aplicado APÓS o agrupamento
    TotalUnidadesVendidas > 1;
