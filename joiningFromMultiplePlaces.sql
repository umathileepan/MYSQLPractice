Use sql_store;

SELECT order_id, o.customer_id, first_name, last_name 
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id; 
    
-- Implicit Join syntax
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id;
    
SELECT order_id, oi.product_id, quantity, oi.unit_price
FROM order_items oi
JOIN products p 
	ON oi.product_id = p.product_id;
    
SELECT *
FROM order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product_id;
    
Use sql_hr;

SELECT e.employee_id, e.first_name, m.first_name AS manager 
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;
    
SELECT o.order_id, o.order_date, c.first_name, c.last_name, os.name AS status 
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
Use sql_invoicing;

SELECT p.date, p.invoice_id, p.amount,c.name, pm.name
FROM payments p 
JOIN clients c 
	ON p.client_id = c.client_id
JOIN payment_methods pm 
	ON pm.payment_method_id = p.payment_method;

SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;
    
-- Outer join
SELECT c.customer_id, c.first_name, O.order_id
FROM customers c
RIGHT JOIN orders o 
	ON c.customer_id = o.order_id;
    
SELECT *
FROM products p 
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id;
    
SELECT o.order_date,o.order_id, c.first_name, s.name AS shippers, os.name AS status
FROM orders o 
JOIN customers c 
	ON o.customer_id = c.customer_id
LEFT JOIN shippers s
	ON o.shipper_id = s.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
-- Self Outer join
SELECT e.employee_id, e.first_name, m.first_name AS manager 
FROM employees e
LEFT JOIN employees m
	ON e.reports_to = m.employee_id;

-- Using clause
SELECT o.order_date,o.order_id, c.first_name, s.name AS shippers
FROM orders o 
JOIN customers c 
	USING(customer_id)
LEFT JOIN shippers s
	USING(shipper_id);
    
-- Using clause with composite key
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	USING(order_id,product_id);
    
SELECT p.date, c.name AS client, p.amount, pm.name
FROM payments p 
JOIN clients c
USING(client_id)
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_id;
    
-- Join two full tables using explicit syntax CROSS JOIN
SELECT *
FROM customers
CROSS JOIN orders
ORDER BY first_name;

SELECT *
FROM products
CROSS JOIN shippers;
-- Join two full tables using implicit syntax FROM
SELECT *
FROM customers, orders
ORDER BY first_name;

SELECT *
FROM products, shippers;
