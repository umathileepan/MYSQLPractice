Use sql_store;

SELECT order_id, o.customer_id, first_name, last_name 
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id; 
    
SELECT order_id, oi.product_id, quantity, oi.unit_price
FROM order_items oi
JOIN products p 
	ON oi.product_id = p.product_id;
    
SELECT *
FROM order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product_id;
    
Use sql_hr;

SELECT * 
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;