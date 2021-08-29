SELECT name, unit_price, unit_price*1.1 AS new_price
FROM products ORDER BY name;

SELECT * FROM customers;

SELECT * FROM customers  WHERE points > 1000;

SELECT * FROM customers WHERE state <> 'VA';

SELECT * FROM customers  WHERE birth_date > '1990-01-01'AND points > 1000;

SELECT * FROM customers  WHERE birth_date > '1990-01-01' OR points > 1000 AND state = 'VA';

SELECT * FROM customers  WHERE NOT (birth_date > '1990-01-01' OR points > 1000 AND state = 'VA');

SELECT * FROM orders  WHERE order_date < now();

SELECT order_id, unit_price * quantity AS total_price FROM order_items WHERE order_id = 6 AND (unit_price * quantity) >30;