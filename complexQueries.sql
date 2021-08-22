USE sql_inventory;

-- Find products that are more expensive than Lettuce(id=3)
SELECT name, unit_price FROM products GROUP BY name
HAVING unit_price > (SELECT unit_price FROM products WHERE product_id = 3);

-- Find employee who earns more than Average
USE sql_hr;
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Find the product that have never been ordered
USE sql_store;
SELECT *
FROM products
WHERE product_id NOT IN (SELECT DISTINCT product_id 
FROM order_items);

USE sql_invoicing;
-- Find clients without invoices
SELECT * FROM clients WHERE client_id NOT IN (SELECT DISTINCT client_id FROM invoices);

SELECT * FROM clients LEFT JOIN invoices USING(client_id) WHERE invoice_id IS NULL;

-- Find customer who has ordered Lettuce(id=3)
SELECT customer_id, first_name, last_name 
FROM customers c 
WHERE customer_id IN(SELECT c.customer_id
FROM order_items oi
JOIN orders USING(order_id)
WHERE product_id = 3);


