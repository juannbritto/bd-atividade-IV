CREATE DATABASE relatorio_funcionario;

USE relatorio_funcionario;

CREATE TABLE funcionarios(
	id_funcionario  INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    cargo VARCHAR(30),
    salario INT
);

INSERT INTO funcionarios(nome, cargo, salario)
VALUES('joao', 'gerente', 2000),
('Pedro', 'Auxiliar', 1300),
('Paulo', 'Diretor', 5000),
('Fernando', 'Coordenador', 3000);

CREATE TABLE vendas(
	id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE,
    valor_venda int,
    id_funcionario INT,
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

INSERT INTO vendas(data_venda, valor_venda, id_funcionario)
VALUES(20230202, 2000, 1),
(20230303, 5000, 1),
(20230404, 1500, 2),
(20230505, 3500, 4);

CREATE VIEW relatorio_vendas_funcionario AS
SELECT funcionarios.nome AS 'Nome Funcionario', COUNT(vendas.id_venda) AS 'Numero de Vendas', SUM(vendas.valor_venda) AS 'Total Vendas'
FROM funcionarios
INNER JOIN vendas ON funcionarios.id_funcionario = vendas.id_funcionario
GROUP BY funcionarios.id_funcionario;

SELECT * FROM relatorio_vendas_funcionario;