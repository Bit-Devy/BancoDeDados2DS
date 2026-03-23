CREATE TABLE Mercadorias (
    Codigo_Mercadoria INT PRIMARY KEY,
    Nome_Mercadoria VARCHAR(100) NOT NULL,
    Valor_Unitario DECIMAL(10, 2) NOT NULL,
    Observacoes TEXT
);

SELECT * FROM Mercadorias;
