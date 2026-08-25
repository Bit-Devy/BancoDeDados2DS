CREATE TABLE Cliente (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    Email VARCHAR(150) NOT NULL,
    Data_Cadastro DATE NOT NULL
);

INSERT INTO Cliente (Nome, Email, Data_Cadastro) 
VALUES 
('Ana Silva', 'ana.silva@example.com', '2026-05-26'),
('Carlos Silva', 'carlos.silva@example.com', '2023-02-20'),
('Beatriz Souza', 'beatriz.s@example.com', '2023-03-10');

SELECT * FROM Cliente;

DROP TABLE Cliente;

SELECT * FROM Cliente;
