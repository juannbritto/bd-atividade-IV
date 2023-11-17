CREATE DATABASE relatorio;

USE relatorio;

CREATE TABLE clientes(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    telefone VARCHAR(22)
);

INSERT INTO clientes(nome, email, telefone)
VALUES('Joao', 'joao@gmail.com', 71923322332),
('Paula', 'paula@gmail.com', 71923322337),
('Diogo', 'diogo@gmail.com', 71923322338),
('Kailan', 'kailan@gmail.com', 71923322339);

CREATE TABLE pedidos(
	id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATE,
    valor_total DOUBLE,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

INSERT INTO pedidos(data_pedido, valor_total, id_cliente)
VALUES(20230505, 200,1),
(20230504, 500,1),
(20230403, 200,2),
(20230203, 200,4);

CREATE VIEW relatorio_pedidos_cliente AS
SELECT clientes.nome AS 'Nome Cliente', COUNT(pedidos.id_pedido) AS 'Numero de Pedidos', SUM(pedidos.valor_total) AS 'Valor total'
FROM clientes
INNER JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
GROUP BY clientes.id_cliente;

SELECT * FROM relatorio_pedidos_cliente;