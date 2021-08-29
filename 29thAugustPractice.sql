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

SELECT * FROM customers WHERE state IN('CA','GA','FL');

SELECT * FROM customers WHERE state NOT IN('CA','GA','FL');

SELECT * FROM products WHERE quantity_in_stock IN('49','38','72');

SELECT * FROM products WHERE quantity_in_stock BETWEEN 30 AND 90;

SELECT * FROM customers WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT * FROM customers WHERE last_name LIKE 'b%ey';

SELECT * FROM customers WHERE last_name LIKE '_____y';

SELECT * FROM customers WHERE address LIKE '%trail%' OR address LIKE '%avenue%';
 
SELECT * FROM customers WHERE phone LIKE '%9' ;

SELECT * FROM customers WHERE address REGEXP 'trail$';

SELECT * FROM customers WHERE first_name REGEXP '^mer|Shel|Erich';

SELECT * FROM customers WHERE last_name REGEXP '[abd]e';

SELECT * FROM customers WHERE first_name REGEXP 'elka|amber';

SELECT * FROM customers WHERE last_name REGEXP 'EY$|ON$';

SELECT * FROM customers WHERE last_name REGEXP '^MY|SE';

SELECT * FROM customers WHERE last_name REGEXP 'B[RU]';

SELECT * FROM customers WHERE phone IS NULL;

SELECT * FROM customers WHERE phone IS NOT NULL;

SELECT * FROM orders WHERE shipped_date IS NULL; 

SELECT * FROM customers ORDER BY first_name DESC, state DESC;

SELECT *, (unit_price * quantity) AS total_price FROM order_items WHERE order_id = 2 ORDER BY (unit_price * quantity) DESC;

SELECT *, (unit_price * quantity) AS total_price FROM order_items WHERE order_id = 2 ORDER BY total_price DESC;

SELECT * FROM customers LIMIT 10;

SELECT * FROM customers LIMIT 6,10;

SELECT * FROM customers ORDER BY points DESC LIMIT 3;