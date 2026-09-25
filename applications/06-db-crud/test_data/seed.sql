# shop seed script for A20 script mode + A24 admin fixture
CREATE TABLE products (id, name, price)
INSERT INTO products VALUES (1, 'pen', 120)
INSERT INTO products VALUES (2, 'notebook', 450)
INSERT INTO products VALUES (3, 'eraser', 60)
SELECT * FROM products
UPDATE products SET price = 400 WHERE name = 'notebook'
SELECT id, name, price FROM products WHERE price = 400
