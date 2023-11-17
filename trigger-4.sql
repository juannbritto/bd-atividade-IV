CREATE DATABASE estoque;

USE estoque;

CREATE TABLE produtos(
	id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    quantidade_estoque INT NOT NULL
);

CREATE TABLE vendas(
	id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATETIME
);

CREATE TABLE itens_venda(
	id_item_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_venda INT,
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
    id_produto INT,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    quantidade INT
);

DELIMITER //

CREATE TRIGGER tg_quantidade_estoque
BEFORE INSERT ON itens_venda
FOR EACH ROW
BEGIN
    DECLARE quantidade_em_estoque INT;

    SELECT quantidade_estoque INTO quantidade_em_estoque
    FROM produtos
    WHERE id_produto = NEW.id_produto;

    IF quantidade_em_estoque < NEW.quantidade THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O produto está fora de estoque';        
    END IF;
END; //

DELIMITER ;


INSERT INTO produtos(nome, quantidade_estoque)
VALUES('Vassoura', 500);

INSERT INTO vendas(data_venda)
VALUES(20231116);

INSERT INTO itens_venda(id_venda, id_produto, quantidade)
VALUES(1,1,600); 

INSERT INTO itens_venda(id_venda, id_produto, quantidade)
VALUES(1,1,400);