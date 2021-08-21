USE sql_store;
INSERT INTO customers
VALUES (DEFAULT, 'John', 'Smith', NULL, NULL, 'address', 'city', 'CA', DEFAULT);

INSERT INTO customers(first_name,last_name,address,city,state)
VALUES ('Uma', 'Thileepan', 'Croydon', 'Croydoncity', 'LA');

-- inserting multiple rows
INSERT INTO shippers (name)
VALUES('Shipper1'),
	  ('Shipper2'),
      ('Shipper3');
      
-- Insert three rows in the product table
INSERT INTO products
VALUES(DEFAULT, 'Cover', 500, 4.40),
	  (DEFAULT, 'Product2', 300, 3.40),
      (DEFAULT, 'Cover2', 200, 2.40);
      
-- Insert rows into multiple table
INSERT INTO orders (customer_id, order_date, status)
VALUES(1, '2021-08-21',1);

INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 1, 1, 2.95),
	   (LAST_INSERT_ID(), 2, 1, 3.95);
       
-- COPY DATA FROM ONE TABLE TO ANOTHER TABLE
CREATE TABLE order_archived AS
SELECT * FROM orders;

-- Using Select statement as a sub query in an insert statement
INSERT INTO oreder_archived
SELECT *
FROM orders
WHERE order_date < '2021-01-01';

Use sql_invoicing;

DROP TABLE invoice_archived;
CREATE TABLE invoice_archived AS
SELECT i.invoice_id, i.number, c.name AS name, i.invoice_total, i.payment_total, i.invoice_date, i.payment_date, i.due_date
FROM invoices i
JOIN clients c 
USING(client_id)
WHERE payment_date IS NOT NULL;

UPDATE invoices
SET payment_total = 10, payment_date = '2021-01-01'
WHERE invoice_id = 1;

UPDATE invoices
SET payment_total = invoice_total * 0.5, payment_date = due_date
WHERE invoice_id = 3;

UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';

-- Using sub queries in UPDATE statement
UPDATE invoices
SET payment_total = invoice_total * 0.5, payment_date = due_date
WHERE invoice_id = 
		(SELECT client_id
		 FROM clients
		 WHERE name = 'Myworks');
         
UPDATE invoices
SET payment_total = invoice_total * 0.5, payment_date = due_date
WHERE client_id IN 
			(SELECT client_id
            FROM clients
            WHERE state IN ('CA', 'NY'));
            
DELETE FROM invoices
WHERE invoice_id = 1;

