-- 1. Quantos pedidos foram feitos por cada cliente, mostrando nome, tipo de cliente e total de pedidos, ordenado pelo total de pedidos em ordem decrescente: 
SELECT
    c.nome,
    c.tipo_cliente,
    COUNT(p.id_pedido) AS total_pedidos
FROM
    Cliente c
LEFT JOIN
    Pedido p ON c.id_cliente = p.id_cliente
GROUP BY
    c.id_cliente, c.nome, c.tipo_cliente
ORDER BY
    total_pedidos DESC;
-- 2. Listar todos os vendedores que também são fornecedores (interseção entre vendedores e fornecedores):
SELECT
    v.nome AS nome_vendedor,
    f.nome AS nome_fornecedor
FROM
    Vendedor v
INNER JOIN
    Produto p ON v.id_vendedor = p.id_vendedor
INNER JOIN
    Fornecedor f ON p.id_fornecedor = f.id_fornecedor
WHERE v.nome = f.nome;
-- 3. Relação de produtos, fornecedores e estoques, incluindo o nome do vendedor que gerencia o produto, ordenado pelo nome do produto:
SELECT
    p.nome AS nome_produto,
    f.nome AS nome_fornecedor,
    e.quantidade AS quantidade_estoque,
    v.nome AS nome_vendedor
FROM
    Produto p
JOIN
    Fornecedor f ON p.id_fornecedor = f.id_fornecedor
JOIN
    Estoque e ON p.id_produto = e.id_produto
JOIN
    Vendedor v ON p.id_vendedor = v.id_vendedor
ORDER BY
    nome_produto;
-- 4. Relação de nomes dos fornecedores e nomes dos produtos, mostrando apenas os fornecedores que fornecem mais de 5 produtos:
SELECT
    f.nome AS nome_fornecedor,
    COUNT(p.id_produto) AS total_produtos
FROM
    Fornecedor f
JOIN
    Produto p ON f.id_fornecedor = p.id_fornecedor
GROUP BY
    f.id_fornecedor, f.nome
HAVING
    COUNT(p.id_produto) > 5
ORDER BY
    total_produtos DESC;
-- 5. Listar clientes (nome e tipo) que fizeram pedidos em um determinado período (ex: entre '2023-01-01' e '2023-12-31') e cujo valor total dos pedidos seja superior a R$ 1000:
SELECT
    c.nome,
    c.tipo_cliente,
    SUM(pa.valor) AS total_gasto
FROM
    Cliente c
JOIN
    Pedido p ON c.id_cliente = p.id_cliente
JOIN
    Pagamento pa ON p.id_pedido = pa.id_pedido
WHERE
    p.data_pedido BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY
    c.id_cliente, c.nome, c.tipo_cliente
HAVING
    SUM(pa.valor) > 1000
ORDER BY
    total_gasto DESC;