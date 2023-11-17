CREATE DATABASE gerenciamento;

USE gerenciamento;

CREATE TABLE alunos(
	id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    data_nascimento DATE,
    serie INT
);

CREATE TABLE matriculas(
	id_matricula INT PRIMARY KEY AUTO_INCREMENT,
    data_matricula DATE,
    status VARCHAR(20),
    id_aluno INT,
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)
);

DELIMITER //

CREATE TRIGGER tg_serie_idade
BEFORE INSERT ON matriculas
FOR EACH ROW
BEGIN
    DECLARE idade_aluno INT;

    SELECT TIMESTAMPDIFF(YEAR, alunos.data_nascimento, CURDATE()) INTO idade_aluno
    FROM alunos
    WHERE alunos.id_aluno = NEW.id_aluno;

    IF NEW.serie = 8 AND idade_aluno < 15 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O aluno não atende aos requisitos de idade para a série.';        
    ELSEIF NEW.serie = 7 AND idade_aluno < 14 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O aluno não atende aos requisitos de idade para a série.';
        
    END IF;
END; //

DELIMITER ;

INSERT INTO alunos(nome, data_nascimento, serie)
VALUES('Joao', 20020101, 8);

INSERT INTO matriculas(data_matricula, status, id_aluno)
VALUES(CURDATE(), 'matriculado', 1);

SELECT * FROM alunos;

SELECT * FROM matriculas;



