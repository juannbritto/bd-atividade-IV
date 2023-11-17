CREATE DATABASE validacao;

USE validacao;

CREATE TABLE funcionarios(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    data_admissao DATE NOT NULL
);

DELIMITER //

CREATE TRIGGER tg_validar_admissao
BEFORE INSERT ON funcionarios
FOR EACH ROW
BEGIN
    IF NEW.data_admissao < CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A data de admissão dever ser maior que a data atual';
    END IF;
END //

DELIMITER ;

INSERT INTO funcionarios(nome, data_admissao)
VALUES('Joao', 20230101);