USE sql_inventory;
USE sql_hr;
USE sql_store;
USE sql_invoicing;

-- Find products that are more expensive than Lettuce(id=3)
SELECT name, unit_price FROM products GROUP BY name
HAVING unit_price > (SELECT unit_price FROM products WHERE product_id = 3);

-- Find employee who earns more than Average
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Find the product that have never been ordered
SELECT *
FROM products
WHERE product_id NOT IN (SELECT DISTINCT product_id 
FROM order_items);

-- Find clients without invoices
SELECT * FROM clients WHERE client_id NOT IN (SELECT DISTINCT client_id FROM invoices);

SELECT * FROM clients LEFT JOIN invoices USING(client_id) WHERE invoice_id IS NULL;

-- Find customer who has ordered Lettuce(id=3)
-- sort out with inner and outer query
SELECT customer_id, first_name, last_name 
FROM customers c 
WHERE customer_id IN(SELECT o.customer_id
FROM order_items oi
JOIN orders o USING(order_id)
WHERE product_id = 3);

-- Find customer who has ordered Lettuce(id=3)
-- sort out with JOIN QUERY 
SELECT DISTINCT customer_id, first_name, last_name
FROM customers c 
JOIN orders o USING(customer_id)
JOIN order_items oi USING(order_id)
WHERE product_id=3;

-- Select invoices lager than all invoices of client 3
SELECT *
FROM invoices
WHERE invoice_total > (SELECT MAX(invoice_total) FROM invoices WHERE client_id = 3);

SELECT *
FROM invoices
WHERE invoice_total > ALL (SELECT invoice_total FROM invoices WHERE client_id = 3);

-- Select clients with at least two invoices
SELECT * FROM clients WHERE client_id = ANY
(SELECT client_id
FROM invoices
GROUP BY client_id
HAVING COUNT(*) >= 2);

-- Select employees whose salary is above the average in their office
SELECT * 
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees WHERE office_id = e.office_id);

-- Get invoices that are larger than the client's average invoice amount
SELECT * FROM invoices i WHERE invoice_total > 
(SELECT AVG(invoice_total) FROM invoices WHERE client_id = i.client_id);

-- Select clients that have an invoice
SELECT * FROM clients WHERE client_id IN (
	SELECT DISTINCT client_id
    FROM invoices
);

SELECT * FROM clients c WHERE EXISTS (SELECT client_id FROM invoices WHERE client_id = c.client_id);

-- Find the product that have never been ordered
SELECT *
FROM products p
WHERE NOT EXISTS (SELECT DISTINCT product_id 
FROM order_items WHERE product_id = p.product_id);