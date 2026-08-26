CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    nomeCliente VARCHAR(100),
    emailCliente VARCHAR(100)
);

CREATE TABLE Compras (
    CompraID INT PRIMARY KEY,
    ClienteID INT,
    NomeLivro VARCHAR(100),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID)
);
-- Inserção de dados na tabela Clientes
INSERT INTO Clientes VALUES 
(1, 'Carlos Silva', 'carlos@email.com'),
(2, 'Ana Souza', 'ana@email.com'),
(3, 'Mariana Costa', 'mariana@email.com');

-- Inserção de dados na tabela Compras
INSERT INTO Compras VALUES 
(101, 1, 'O Hobbit'),
(102, 1, '1984'),
(103, 2, 'Dom Casmurro'),
(104, 3, 'Quarto de Despejo');

-- Consultas solicitadas
SELECT * FROM Clientes;
SELECT * FROM Compras;
