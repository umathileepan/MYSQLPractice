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

SELECT c.customer_id, order_id, c.first_name, c.last_name  FROM customers c JOIN orders o ON c.customer_id = o.customer_id;

SELECT e.employee_id,e.first_name, m.first_name AS manager FROM employees e JOIN employees m ON e.reports_to = m.employee_id;

SELECT o.order_id, o.order_date, c.first_name, c.last_name, os.name AS status FROM orders o JOIN customers c ON o.customer_id = c.customer_id 
				JOIN order_statuses os ON o.status = os.order_status_id;
                
SELECT p.date, p.invoice_id,p.amount, c.name, pm.name AS payment_method FROM payments p JOIN clients c ON p.client_id = c.client_id JOIN payment_methods pm ON p.payment_method = pm.payment_method_id;

SELECT p.product_id , p.name, oi.quantity FROM products p LEFT JOIN order_items oi ON p.product_id = oi.product_id;  

SELECT client_id, SUM(invoice_total) AS total_sales FROM invoices GROUP BY client_id;

SELECT client_id, SUM(invoice_total) AS total_sales FROM invoices GROUP BY client_id HAVING total_sales > 500;

SELECT client_id, SUM(invoice_total) AS total_sales, COUNT(*) AS number_of_invoices FROM invoices GROUP BY client_id
 HAVING total_sales > 500 AND number_of_invoices > 5;

SELECT c.first_name, c.state, SUM(unit_price * quantity) AS total  FROM orders o JOIN customers c USING (customer_id) 
	JOIN order_items oi USING (order_id) GROUP BY state HAVING state = 'VA' AND total > 100;
    
SELECT pm.name AS payment_method, SUM(amount) AS total FROM payments p JOIN payment_methods pm ON p.payment_method =pm.payment_method_id GROUP BY pm.name WITH ROLLUP;

SELECT * FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT p.product_id FROM products p WHERE p.product_id NOT IN (SELECT DISTINCT oi.product_id FROM order_items oi);

SELECT * FROM clients WHERE client_id NOT IN (SELECT DISTINCT client_id FROM invoices);

SELECT customer_id, first_name, last_name FROM customers WHERE customer_id IN (SELECT customer_id FROM order_items JOIN orders USING (order_id) where product_id = 3);

SELECT DISTINCT customer_id, first_name, last_name FROM customers c JOIN orders o USING (customer_id) JOIN order_items oi USING(order_id) WHERE oi.product_id = 3;

