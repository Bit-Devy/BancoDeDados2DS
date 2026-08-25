-- ==========================================
-- 1. CRIAÇÃO DAS TABELAS E RELACIONAMENTOS
-- ==========================================

CREATE TABLE Tipo_Assinante (
    cd_tipo INT PRIMARY KEY,
    ds_tipo VARCHAR(50)
);

CREATE TABLE Municipio (
    cd_municipio INT PRIMARY KEY,
    ds_municipio VARCHAR(100)
);

CREATE TABLE Ramo_Atividade (
    cd_ramo INT PRIMARY KEY,
    ds_ramo VARCHAR(100)
);

CREATE TABLE Assinante (
    cd_assinante INT PRIMARY KEY,
    nm_assinante VARCHAR(100),
    cd_tipo INT,
    cd_ramo INT,
    FOREIGN KEY (cd_tipo) REFERENCES Tipo_Assinante(cd_tipo),
    FOREIGN KEY (cd_ramo) REFERENCES Ramo_Atividade(cd_ramo)
);

CREATE TABLE Endereco (
    cd_endereco INT PRIMARY KEY,
    cd_assinante INT,
    cd_municipio INT,
    ds_endereco VARCHAR(200),
    FOREIGN KEY (cd_assinante) REFERENCES Assinante(cd_assinante),
    FOREIGN KEY (cd_municipio) REFERENCES Municipio(cd_municipio)
);

CREATE TABLE Telefone (
    cd_telefone INT PRIMARY KEY,
    cd_endereco INT,
    n_fone VARCHAR(20),
    FOREIGN KEY (cd_endereco) REFERENCES Endereco(cd_endereco)
);

-- ==========================================
-- 2. INSERÇÃO DE DADOS DE EXEMPLO
-- ==========================================

INSERT INTO Tipo_Assinante VALUES (1, 'Residencial');
INSERT INTO Tipo_Assinante VALUES (2, 'Comercial');

INSERT INTO Municipio VALUES (1, 'Pelotas');
INSERT INTO Municipio VALUES (2, 'Natal');
INSERT INTO Municipio VALUES (3, 'João Câmara');
INSERT INTO Municipio VALUES (4, 'Curitiba');

INSERT INTO Ramo_Atividade VALUES (1, 'Tecnologia');
INSERT INTO Ramo_Atividade VALUES (2, 'Comércio');

-- Assinantes (incluindo casos com múltiplos telefones, sem ramo e com tipos diferentes)
INSERT INTO Assinante VALUES (1, 'Ana Souza', 1, 1);       -- Residencial, Tecnologia (tem 2 telefones)
INSERT INTO Assinante VALUES (2, 'Carlos Silva', 2, NULL);   -- Comercial, sem ramo
INSERT INTO Assinante VALUES (3, 'Mariana Costa', 1, 1);    -- Residencial em Pelotas
INSERT INTO Assinante VALUES (4, 'Comércio Alfa', 2, 2);     -- Comercial em Natal
INSERT INTO Assinante VALUES (5, 'Loja Beta', 2, 2);         -- Comercial em João Câmara

-- Endereços
INSERT INTO Endereco VALUES (10, 1, 4, 'Rua das Flores, 123');
INSERT INTO Endereco VALUES (20, 2, 4, 'Av. Brasil, 456');
INSERT INTO Endereco VALUES (30, 3, 1, 'Rua Quinze, 100');       -- Pelotas
INSERT INTO Endereco VALUES (40, 4, 2, 'Av. Infante Dom Henrique'); -- Natal
INSERT INTO Endereco VALUES (50, 5, 3, 'Rua Principal, 200');      -- João Câmara

-- Telefones
INSERT INTO Telefone VALUES (100, 10, '(41) 99999-1111');
INSERT INTO Telefone VALUES (101, 10, '(41) 98888-2222'); -- Segundo telefone da Ana (Premium)
INSERT INTO Telefone VALUES (102, 20, '(41) 97777-3333');
INSERT INTO Telefone VALUES (103, 30, '(53) 98111-4444');
INSERT INTO Telefone VALUES (104, 40, '(84) 3211-1111');
INSERT INTO Telefone VALUES (105, 50, '(84) 3262-2222');


-- ==========================================
-- 3. CONSULTAS DOS EXERCÍCIOS
-- ==========================================

-- Exercício 2 e 3: Relatório de Contatos com Aliases e INNER JOIN
SELECT a.nm_assinante, e.ds_endereco, t.n_fone 
FROM Assinante a 
INNER JOIN Endereco e ON a.cd_assinante = e.cd_assinante 
INNER JOIN Telefone t ON e.cd_endereco = t.cd_endereco;


-- Exercício 4 e 5: Auditoria e Tratamento de Nulos (LEFT JOIN)
SELECT a.nm_assinante, r.ds_ramo 
FROM Assinante a 
LEFT JOIN Ramo_Atividade r ON a.cd_ramo = r.cd_ramo 
ORDER BY r.ds_ramo, a.nm_assinante;


-- Exercício 6 e 7: Múltiplas Junções e Filtros Geográficos (Pelotas / Residencial)
SELECT a.nm_assinante 
FROM Assinante a 
INNER JOIN Tipo_Assinante ta ON a.cd_tipo = ta.cd_tipo 
INNER JOIN Endereco e ON a.cd_assinante = e.cd_assinante 
INNER JOIN Municipio m ON e.cd_municipio = m.cd_municipio 
WHERE m.ds_municipio = 'Pelotas' AND ta.ds_tipo = 'Residencial';


-- Exercício 8 e 9: Identificação de Clientes Premium (Subconsultas com HAVING)
SELECT nm_assinante 
FROM Assinante 
WHERE cd_assinante IN (
    SELECT e.cd_assinante 
    FROM Endereco e 
    JOIN Telefone t ON e.cd_endereco = t.cd_endereco 
    GROUP BY e.cd_assinante 
    HAVING COUNT(t.cd_telefone) > 1
);


-- Exercício 10 e 11: Automação com Visões (Views - Comerciais em Natal ou João Câmara)
CREATE VIEW vw_relatorio_comercial AS 
SELECT a.nm_assinante, t.n_fone 
FROM Assinante a 
INNER JOIN Tipo_Assinante ta ON a.cd_tipo = ta.cd_tipo 
INNER JOIN Endereco e ON a.cd_assinante = e.cd_assinante 
INNER JOIN Municipio m ON e.cd_municipio = m.cd_municipio 
INNER JOIN Telefone t ON e.cd_endereco = t.cd_endereco 
WHERE ta.ds_tipo = 'Comercial' AND m.ds_municipio IN ('Natal', 'João Câmara');

-- Testando a View criada:
SELECT * FROM vw_relatorio_comercial;
