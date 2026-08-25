-- 1. CRIAÇÃO DAS TABELAS (Configuração Inicial)
CREATE TABLE jogador (
    id_jogador INT PRIMARY KEY,
    nome VARCHAR(50),
    status_jogador VARCHAR(10), -- free ou premium
    anos_inativo INT
);

CREATE TABLE biblioteca (
    id_jogo INT PRIMARY KEY,
    nome_jogo VARCHAR(50),
    genero VARCHAR(30),
    id_jogador INT,
    FOREIGN KEY (id_jogador) REFERENCES jogador(id_jogador)
);

-- 2. POPULANDO O BANCO DE DADOS (10 Jogos Populares)
INSERT INTO jogador VALUES
(1, 'Carlos', 'premium', 0), 
(2, 'Amanda', 'free', 3),
(3, 'Bruno', 'free', 0), 
(4, 'Danielle', 'premium', 4),
(5, 'Lucas', 'free', 1);

INSERT INTO biblioteca VALUES
(101, 'Minecraft', 'Sandbox', 1), 
(102, 'GTA V', 'Ação', 1),
(103, 'League of Legends', 'MOBA', 2), 
(104, 'Valorant', 'FPS', 3),
(105, 'Counter-Strike 2', 'FPS', 3), 
(106, 'The Witcher 3', 'RPG', NULL),
(107, 'Cyberpunk 2077', 'RPG', NULL), 
(108, 'Elden Ring', 'RPG', 5),
(109, 'Fortnite', 'Battle Royale', 5), 
(110, 'Roblox', 'Sandbox', 5);

-- 3. CONSULTAS SIMPLES
-- Consulta A: Selecionar todos os dados da tabela jogador
SELECT * FROM jogador;

-- Consulta B: Selecionar colunas específicas da biblioteca
SELECT nome_jogo, genero FROM biblioteca;

-- 4. ATUALIZAÇÕES (UPDATE)
-- Atualização A: Alterar status do jogador ID 1
UPDATE jogador SET status_jogador = 'premium' WHERE id_jogador = 1;

-- Atualização B: Alterar gênero do jogo ID 102
UPDATE biblioteca SET genero = 'Aventura' WHERE id_jogo = 102;

-- 5. CONSULTA COM DISTINCT
-- Listar os gêneros cadastrados sem trazer nomes repetidos
SELECT DISTINCT genero FROM biblioteca;

-- 6. CONSULTA COM WHERE E BETWEEN
-- Filtrar jogadores inativos dentro de uma faixa de 1 a 3 anos
SELECT * FROM jogador WHERE anos_inativo BETWEEN 1 AND 3;

-- 7. CONSULTA COM WHERE E AND
-- Filtrar jogadores que usam conta free E possuem alguma inatividade
SELECT * FROM jogador WHERE status_jogador = 'free' AND anos_inativo > 0;

-- 8. CONSULTAS COM JOIN
-- Consulta A: Trazer apenas correspondências exatas entre as duas tabelas
SELECT jogador.nome, biblioteca.nome_jogo
FROM jogador
INNER JOIN biblioteca ON jogador.id_jogador = biblioteca.id_jogador;

-- Consulta B: Trazer todos os registros da tabela à esquerda (jogador)
SELECT jogador.nome, biblioteca.nome_jogo
FROM jogador
LEFT JOIN biblioteca ON jogador.id_jogador = biblioteca.id_jogador;

-- Consulta C: Trazer todos os registros da tabela à direita (biblioteca)
SELECT jogador.nome, biblioteca.nome_jogo
FROM jogador
RIGHT JOIN biblioteca ON jogador.id_jogador = biblioteca.id_jogador;

-- 9. REMOÇÃO DE REGISTROS
-- Deletar do banco jogadores inativos há mais de 2 anos
DELETE FROM jogador WHERE anos_inativo > 2;
