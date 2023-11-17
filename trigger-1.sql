CREATE DATABASE biblioteca;

USE biblioteca;

CREATE TABLE Livros(
	id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL, 
    autor VARCHAR(255) NOT NULL,
    quantidade_estoque INT NOT NULL
);

CREATE TABLE Emprestimo(
	id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE NOT NULL,
    id_livro INT,
    FOREIGN KEY (id_livro) REFERENCES Livros(id_livro) 
);

DELIMITER //

CREATE TRIGGER tg_atualizar_estoque_livro
AFTER INSERT ON Emprestimo
FOR EACH ROW
BEGIN
    UPDATE Livros
    SET quantidade_estoque = quantidade_estoque - 1
    WHERE id_livro = NEW.id_livro;
END; //

DELIMITER ;

INSERT INTO Livros(titulo, autor, quantidade_estoque)
VALUES('A arte', 'Diogo', 10);

INSERT INTO Emprestimo(data_emprestimo, data_devolucao, id_livro)
VALUES(20230101, 20230102, 1);


SELECT * FROM Livros;

SELECT * FROM Emprestimo;