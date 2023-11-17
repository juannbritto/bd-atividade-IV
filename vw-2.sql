CREATE DATABASE estoque;

USE estoque;

CREATE TABLE produtos(
	id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    preco_unitario DOUBLE,
    categoria VARCHAR(50)
);

INSERT INTO produtos(nome, preco_unitario, categoria)
VALUES('Vassoura', 20, 'Domestico'),
('Leite', 13, 'Alimento'),
('Sabao', 8, 'Limpeza'),
('Pão', 0.50, 'Alimento');

CREATE TABLE estoque(
	quantidade INT,
    id_produto INT,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)    
);

INSERT INTO estoque(quantidade, id_produto)
VALUES(300,1),
(200,2),
(700,3),
(100,4);

CREATE VIEW estoque_critico AS
SELECT produtos.nome AS 'nome do produto', estoque.quantidade AS 'quantidade em estoque'
FROM produtos
INNER JOIN estoque ON produtos.id_produto = estoque.id_produto
WHERE estoque.quantidade < 500;

SELECT * FROM estoque_critico;