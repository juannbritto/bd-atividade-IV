CREATE DATABASE cidade;

USE cidade;

CREATE TABLE clientes(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    endereco VARCHAR(255),
    cidade VARCHAR(255)
);

INSERT INTO clientes(nome, endereco, cidade)
VALUES('Joao', 'Cajazeiras', 'Salvador'),
('Pedro', 'Valeria', 'Salvador'),
('Larissa', 'Osasco', 'São Paulo'),
('Fernando', 'Santos', 'São Paulo');

CREATE TABLE pagamento(
	id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    data_pagamento DATE,
    valor_pagamento INT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

INSERT INTO pagamento(data_pagamento, valor_pagamento, id_cliente)
VALUES(20230202, 2000, 1),
(20230101, 3000, 2),
(20230303, 1500, 3),
(20230505, 4500, 4);

CREATE VIEW relatorio_pagamentos_cidade AS
SELECT clientes.cidade AS 'Cidade', SUM(pagamento.valor_pagamento) AS 'Valor Total'
FROM clientes
INNER JOIN pagamento ON clientes.id_cliente = pagamento.id_cliente
GROUP BY clientes.cidade;

SELECT * FROM relatorio_pagamentos_cidade;