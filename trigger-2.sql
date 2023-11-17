CREATE DATABASE Banco;

USE Banco;

CREATE TABLE contas(
	id_conta INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    Saldo DECIMAL(10,2)
);

CREATE TABLE transacoes(
	id_transacao INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(20),
    valor Decimal(10,2),
    id_conta INT,
    FOREIGN KEY (id_conta) REFERENCES contas(id_conta)
);

DELIMITER //

CREATE TRIGGER tg_atualizar_saldo_conta
AFTER INSERT ON transacoes
FOR EACH ROW
BEGIN
    DECLARE novo_saldo DECIMAL(10,2);
    IF NEW.tipo = 'entrada' THEN 
        SET novo_saldo = (SELECT saldo + NEW.valor FROM contas WHERE id_conta = NEW.id_conta); 
    ELSE 
        SET novo_saldo = (SELECT saldo - NEW.valor FROM contas WHERE id_conta = NEW.id_conta);
    END IF;
    UPDATE contas SET saldo = novo_saldo WHERE id_conta = NEW.id_conta;
END; //

DELIMITER ;

INSERT INTO contas(nome, saldo)
VALUES('Joao', 200);

INSERT INTO transacoes(tipo, valor, id_conta)
VALUES('entrada', 100, 1);

SELECT * FROM contas;

INSERT INTO transacoes(tipo, valor, id_conta)
VALUES('saida', 100, 1);

SELECT * FROM contas;