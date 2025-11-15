Este projeto implementa o esquema de banco de dados para um sistema de e-commerce, com base em um modelo lógico refinado. O objetivo é estruturar os dados de forma normalizada, garantindo integridade e eficiência nas consultas.

Refinamentos do Modelo Lógico
O esquema foi projetado para atender aos seguintes requisitos de negócio:

Cliente (Generalização/Especialização): Um cliente (Cliente) pode ser Pessoa Física (PF) ou Pessoa Jurídica (PJ). Foi implementada uma superclasse Cliente e duas subclasses (PessoaFisica, PessoaJuridica) para refletir essa especialização, garantindo que um cliente não possa ser ambos.

Múltiplos Pagamentos: Um único pedido (Pedido) pode ser pago usando múltiplas formas (ex: Cartão de Crédito + PIX). Isso é modelado com uma tabela Pagamento que tem uma relação 1:N com Pedido.

Entrega: Informações de statusEntrega e codigoRastreio são armazenadas diretamente na tabela Pedido para fácil consulta e rastreamento.

Ecossistema Marketplace: O modelo inclui entidades para Fornecedor, Vendedor (terceirizado) e Estoque, permitindo que um produto tenha múltiplos fornecedores, vendedores e localizações de estoque.
