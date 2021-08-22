USE sql_invoicing;
USE sql_store;

SELECT 
	MAX(invoice_total) AS highest,
    MIN(invoice_total) AS lowest,
    AVG(invoice_total) AS average,
    SUM(invoice_total) AS total,
    SUM(invoice_total * 1.1) AS total,
    COUNT(invoice_total) AS number_of_invoices,
    COUNT(payment_date) AS count_of_payment,
    COUNT(*) AS total_records,
    COUNT(DISTINCT client_id) AS total_record
FROM invoices
WHERE invoice_date > '2019-07-01';

SELECT
	'First half of 2019' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT
	'Second half of 2019' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'
UNION
SELECT
	'Total' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31';

-- Find total sales for each client
SELECT 
	client_id,
    SUM(invoice_total) AS total_sales
FROM invoices i 
WHERE invoice_date >= '2019-07-01'
GROUP BY client_id
ORDER BY total_sales DESC;

-- Find total sales for state and city
SELECT 
	state,
    city,
    SUM(invoice_total) AS total_sales
FROM invoices i 
JOIN clients c USING (client_id)
GROUP BY state, city;

-- Find payment group by date and payment method

SELECT 
	p.date,
    pm.name AS payment_method,
    SUM(p.amount) AS total_payments
FROM payments p
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id
GROUP BY p.date, pm.name
ORDER BY p.date;

-- Find total sales for each client who has more than certain amount : filter data
SELECT 
	client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(*) AS number_of_invoices
FROM invoices i 
GROUP BY client_id
HAVING total_sales > 500 AND number_of_invoices > 5;

-- Get the customers located in Virginia who have spent more than $100
SELECT 
	c.customer_id,
	c.first_name,
    c.last_name,
    state,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o USING(customer_id)
JOIN order_items oi USING(order_id)
WHERE state = 'VA'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING total_sales > 100;

