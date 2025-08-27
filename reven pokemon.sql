Banco de Dados db_revenda_pokemon_ryan

-- 1. Consulta com filtro LIKE
-- Procurar clientes com nome contendo "ash" (case-insensitive)
SELECT * FROM clientes WHERE nome ILIKE '%ash%';

-- 2. EXPLAIN da consulta com LIKE
EXPLAIN ANALYZE SELECT * FROM clientes WHERE nome ILIKE '%ash%';

-- 3. Criar índice na coluna nome da tabela clientes
CREATE INDEX idx_clientes_nome ON clientes(nome);

-- 4. Repetir consulta com LIKE e EXPLAIN após criação do índice
EXPLAIN ANALYZE SELECT * FROM clientes WHERE nome ILIKE '%ash%';

-- 5. Alterar coluna telefone (varchar) para int - poderá causar erro
-- Pode gerar erro se houver caracteres não numéricos
ALTER TABLE clientes ALTER COLUMN telefone TYPE BIGINT USING telefone::bigint;

-- Caso haja erro, rodar essa limpeza antes (removendo caracteres não numéricos)
-- UPDATE clientes SET telefone = regexp_replace(telefone, '[^0-9]', '', 'g');
-- Depois tentar alterar novamente:
-- ALTER TABLE clientes ALTER COLUMN telefone TYPE BIGINT USING telefone::bigint;

-- 6. Alterar coluna estoque (int) para varchar
ALTER TABLE produtos ALTER COLUMN estoque TYPE VARCHAR(10);

-- 7. Criar usuário com seu nome e dar todas permissões em todas as tabelas
CREATE USER ryan WITH PASSWORD 'senha_segura';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO ryan;

-- 8. Criar usuário para colega com permissão apenas de SELECT na tabela clientes
CREATE USER colega WITH PASSWORD 'senha_colega';
GRANT SELECT ON clientes TO colega;

-- 9. Testes (para serem exec no usuário colega):

-- SELECT (deve funcionar)
-- SELECT * FROM clientes;

-- INSERT (deve falhar)
-- INSERT INTO clientes (nome, email) VALUES ('Teste', 'teste@poke.com');

-- UPDATE (deve falhar)
-- UPDATE clientes SET nome = 'Atualizado' WHERE id = 1;

-- 10. Consultas com JOINs


SELECT c.nome, p.status
FROM clientes c
INNER JOIN pedidos p ON c.id = p.id_cliente;


SELECT c.nome, p.status
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.id_cliente;


SELECT c.nome, p.status
FROM clientes c
RIGHT JOIN pedidos p ON c.id = p.id_cliente;



SELECT p.id, pa.valor_pago
FROM pedidos p
INNER JOIN pagamentos pa ON p.id = pa.id_pedido;

SELECT p.id, pa.valor_pago
FROM pedidos p
LEFT JOIN pagamentos pa ON p.id = pa.id_pedido;


SELECT p.id, pa.valor_pago
FROM pedidos p
RIGHT JOIN pagamentos pa ON p.id = pa.id_pedido;

-- INNER JOIN
SELECT pr.nome, a.nota
FROM produtos pr
INNER JOIN avaliacoes a ON pr.id = a.id_produto;

-- LEFT JOIN
SELECT pr.nome, a.nota
FROM produtos pr
LEFT JOIN avaliacoes a ON pr.id = a.id_produto;

-- RIGHT JOIN
SELECT pr.nome, a.nota
FROM produtos pr
RIGHT JOIN avaliacoes a ON pr.id = a.id_produto;

-- Consulta 4: pedidos × pedido_produto
-- INNER JOIN
SELECT pe.id, pp.quantidade
FROM pedidos pe
INNER JOIN pedido_produto pp ON pe.id = pp.id_pedido;

-- LEFT JOIN
SELECT pe.id, pp.quantidade
FROM pedidos pe
LEFT JOIN pedido_produto pp ON pe.id = pp.id_pedido;

-- RIGHT JOIN
SELECT pe.id, pp.quantidade
FROM pedidos pe
RIGHT JOIN pedido_produto pp ON pe.id = pp.id_pedido;

-- 11. Atualizar registros com colunas NULL
UPDATE pagamentos SET data_pagamento = '2025-08-10' WHERE data_pagamento IS NULL;
UPDATE pedidos SET status = 'Pago' WHERE status IS NULL;

-- 12. Executar novamente as consultas JOIN para comparar resultados (igual as consultas acima)


