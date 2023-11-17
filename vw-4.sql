CREATE DATABASE categoria;

USE categoria;

CREATE TABLE categorias(
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(255),
    descricao VARCHAR(255)
);

INSERT INTO categorias(nome_categoria, descricao)
VALUES('Limpeza', 'para limpeza'),
('Domestico', 'para uso domestico'),
('Alimento', 'uso alimentar'),
('Frios', 'produtos congelados');

CREATE TABLE produtos(
	id_produto INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(255),
    preco_unitario INT,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

INSERT INTO produtos(nome, preco_unitario, id_categoria) 
VALUES('Sabao', 5, 1),
('Vassoura', 15, 2),
('Leite', 9, 3),
('Frango', 18, 4);

CREATE VIEW relatorio_produtos_categoria AS
SELECT categorias.nome_categoria AS 'Nome Categorias', COUNT(produtos.id_produto) AS 'Quantidade de Produtos'
FROM categorias
LEFT JOIN produtos ON categorias.id_categoria = produtos.id_categoria
GROUP BY categorias.id_categoria;

SELECT * FROM relatorio_produtos_categoria;