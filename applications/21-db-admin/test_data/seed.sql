# A24 admin fixture: two tables, fixed rows (deterministic).
CREATE TABLE products (id, name, price)
INSERT INTO products VALUES (1, 'pen', 120)
INSERT INTO products VALUES (2, 'notebook', 450)
INSERT INTO products VALUES (3, 'eraser', 60)
CREATE TABLE suppliers (id, name)
INSERT INTO suppliers VALUES (1, 'acme')
INSERT INTO suppliers VALUES (2, 'globex')
