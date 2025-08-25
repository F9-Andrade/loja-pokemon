CREATE DATABASE db_revenda_pokemon_ryan;
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    telefone VARCHAR(20),
    data_cadastro TIMESTAMP DEFAULT 
);
CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('Jogo', 'Acessório', 'Colecionável')),
    plataforma VARCHAR(50),
    preco NUMERIC(10,2) NOT NULL CHECK (preco > 0),
    estoque INT DEFAULT 0
);
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES clientes(id),
    data_pedido TIMESTAMP DEFAULT,
    status VARCHAR(20) DEFAULT 'Pendente',
    forma_pagamento VARCHAR(50) NOT NULL
);
CREATE TABLE pagamentos (
    id SERIAL PRIMARY KEY,
    id_pedido INT UNIQUE REFERENCES pedidos(id),
    valor_pago NUMERIC(10,2) CHECK (valor_pago > 0),
    metodo_pagamento VARCHAR(50) NOT NULL,
    data_pagamento DATE,
    confirmado BOOLEAN DEFAULT FALSE
);
CREATE TABLE avaliacoes (
    id SERIAL PRIMARY KEY,
    id_produto INT REFERENCES produtos(id),
    id_cliente INT REFERENCES clientes(id),
    nota INT CHECK (nota >= 1 AND nota <= 5),
    comentario TEXT,
    data_avaliacao TIMESTAMP DEFAULT 
);
CREATE TABLE pedido_produto (
    id_pedido INT REFERENCES pedidos(id),
    id_produto INT REFERENCES produtos(id),
    quantidade INT NOT NULL CHECK (quantidade > 0),
    PRIMARY KEY (id_pedido, id_produto)
);
SELECT * FROM vw_detalhes_pedidos;
SELECT * FROM vw_avaliacoes_produtos;
INSERT INTO clientes (nome, email, cpf, telefone) VALUES
('Ash Ketchum', 'ash@poke.com', '123.456.789-00', '11999990001'),
('Misty', 'misty@poke.com', '987.654.321-00', '11999990002'),
('Brock', 'brock@poke.com', '456.789.123-00', '11999990003'),
('Gary Oak', 'gary@poke.com', '321.654.987-00', '11999990004'),
('May', 'may@poke.com', '789.123.456-00', '11999990005'),
('Dawn', 'dawn@poke.com', '147.258.369-00', '11999990006'),
('Cynthia', 'cynthia@poke.com', '159.357.486-00', '11999990007'),
('Serena', 'serena@poke.com', '753.951.852-00', '11999990008'),
('James', 'james@rocket.com', '258.369.147-00', '11999990009'),
('Jessie', 'jessie@rocket.com', '963.852.741-00', '11999990010');
INSERT INTO produtos (nome, tipo, plataforma, preco, estoque) VALUES
('Pokémon Scarlet', 'Jogo', 'Nintendo Switch', 299.90, 20),
('Pokémon Violet', 'Jogo', 'Nintendo Switch', 299.90, 15),
('Pokémon Legends: Arceus', 'Jogo', 'Nintendo Switch', 349.90, 10),
('Pelúcia Pikachu', 'Colecionável', NULL, 89.90, 50),
('Pokébola Realista', 'Colecionável', NULL, 129.90, 25),
('Case Switch Pikachu', 'Acessório', 'Nintendo Switch', 79.90, 30),
('Pokémon Blue', 'Jogo', 'Game Boy', 199.90, 5),
('Chaveiro Eevee', 'Colecionável', NULL, 29.90, 40),
('Camiseta Pokémon Master', 'Acessório', NULL, 59.90, 35),
('Pokémon Sword', 'Jogo', 'Nintendo Switch', 249.90, 12);
INSERT INTO pedidos (id_cliente, forma_pagamento, status) VALUES
(1, 'Cartão', 'Pago'),
(2, 'Pix', 'Pendente'),
(3, 'Boleto', 'Pago'),
(4, 'Cartão', 'Cancelado'),
(5, 'Pix', 'Pago'),
(6, 'Cartão', 'Enviado'),
(7, 'Boleto', 'Pago'),
(8, 'Pix', 'Pago'),
(9, 'Cartão', 'Pendente'),
(10, 'Pix', 'Pago');
INSERT INTO pagamentos (id_pedido, valor_pago, metodo_pagamento, data_pagamento, confirmado) VALUES
(1, 299.90, 'Cartão', '2025-08-01', TRUE),
(2, 299.90, 'Pix', NULL, FALSE),
(3, 199.90, 'Boleto', '2025-08-02', TRUE),
(4, 89.90, 'Cartão', '2025-08-03', FALSE),
(5, 129.90, 'Pix', '2025-08-04', TRUE),
(6, 349.90, 'Cartão', '2025-08-05', TRUE),
(7, 59.90, 'Boleto', '2025-08-06', TRUE),
(8, 79.90, 'Pix', '2025-08-07', TRUE),
(9, 249.90, 'Cartão', NULL, FALSE),
(10, 89.90, 'Pix', '2025-08-08', TRUE);
INSERT INTO avaliacoes (id_produto, id_cliente, nota, comentario) VALUES
(1, 1, 5, 'Jogo incrível!'),
(2, 2, 4, 'Muito bom!'),
(3, 3, 5, 'Adorei o novo formato.'),
(4, 4, 3, 'Esperava mais da pelúcia.'),
(5, 5, 5, 'Pokébola muito realista.'),
(6, 6, 4, 'Boa qualidade.'),
(7, 7, 5, 'Clássico nostálgico.'),
(8, 8, 4, 'Fofo e barato.'),
(9, 9, 3, 'Estampa poderia ser melhor.'),
(10, 10, 5, 'Excelente jogo!');
INSERT INTO pedido_produto (id_pedido, id_produto, quantidade) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 7, 1),
(4, 4, 2),
(5, 5, 1),
(6, 3, 1),
(7, 9, 
