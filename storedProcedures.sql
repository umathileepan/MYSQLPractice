USE sql_invoicing;

DROP PROCEDURE IF EXISTS get_client_by_state;

DELIMITER $$
CREATE PROCEDURE get_client_by_state(state CHAR(2))
BEGIN
	IF state IS NULL THEN
		SET state = 'CA';
	END IF;
    
	SELECT * FROM clients c
    WHERE c.state = state;
END $$
DELIMITER ;

call get_client_by_state(null);

-- Write a stored procedure to return invoices for a given client

DROP PROCEDURE IF EXISTS get_invoices_by_client;

DELIMITER $$
CREATE PROCEDURE get_invoices_by_client(client_id INT)
BEGIN
	SELECT * FROM invoices i WHERE i.client_id = client_id;
END$$
DELIMITER ;

call get_invoices_by_client(1);

-- Write a stored procedure called get_payments with two parameters
DROP PROCEDURE IF EXISTS get_payments;

DELIMITER $$
CREATE PROCEDURE get_payments(client_id INT, payment_method_id TINYINT)
BEGIN
	SELECT * FROM payments p
    JOIN payment_methods pm ON p.payment_method = pm.payment_method_id
    JOIN clients c USING(client_id)
    WHERE c.client_id = client_id AND pm.payment_method_id = payment_method_id;
END$$
DELIMITER ;

call get_payments(5,1);

-- Mosh's solution for the above requirement
DROP PROCEDURE IF EXISTS get_payments;

DELIMITER $$
CREATE PROCEDURE get_payments(client_id INT, payment_method_id TINYINT)
BEGIN
	SELECT * FROM payments p
    WHERE p.client_id = IFNULL(client_id, p.client_id) AND p.payment_method = IFNULL(payment_method_id, p.payment_method);
END$$
DELIMITER ;