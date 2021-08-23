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

call get_payments(null,1);

-- Mosh's solution for the above requirement
DROP PROCEDURE IF EXISTS get_payments;

DELIMITER $$
CREATE PROCEDURE get_payments(client_id INT, payment_method_id TINYINT)
BEGIN
	SELECT * FROM payments p
    WHERE p.client_id = IFNULL(client_id, p.client_id) AND p.payment_method = IFNULL(payment_method_id, p.payment_method);
END$$
DELIMITER ;

-- Validation
DELIMITER $$
CREATE PROCEDURE `make_payment`(invoice_id INT, payment_amount DECIMAL(9,2), payment_date DATE)
BEGIN
	IF payment_amount <= 0 THEN
		SIGNAL SQLSTATE '22003' SET MESSAGE_TEXT = 'Invalid payment amount';
	END IF;
	UPDATE invoices i 
    SET
		i.payment_total = payment_amount,
        i.payment_date = payment_date
	WHERE i.invoice_id = invoice_id;
END$$
DELIMITER ;

USE sql_invoicing;
DROP procedure IF EXISTS get_unpaid_invoices_for_client;

DELIMITER $$
USE sql_invoicing$$
CREATE PROCEDURE get_unpaid_invoices_for_client (client_id INT, OUT invoices_count INT,OUT invoices_total DECIMAL(9,2))
BEGIN
	SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices i 
    WHERE i.client_id = client_id
		AND payment_total = 0;
END$$

DELIMITER ;

-- User or session variables
SET @invoices_count = 0;

DELIMITER $$
CREATE PROCEDURE get_risk_factor()
BEGIN
	DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9,2);
    DECLARE invoices_count INT;
    
    SELECT COUNT(*), SUM(invoices_total)
    INTO invoices_count, invoices_total
    FROM invoices;
    
    SET risk_factor = invoices_total / invoices_count * 5;
    
    SELECT risk_factor;
END$$
DELIMITER ;

-- Function
DROP function IF EXISTS `get_risk_factor_for_client`;

DELIMITER $$
CREATE FUNCTION get_risk_factor_for_client (client_id INT)
RETURNS INTEGER
READS SQL DATA
BEGIN
	DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9,2);
    DECLARE invoices_count INT;
    
    SELECT COUNT(*), SUM(invoices_total)
    INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id;
    
    SET risk_factor = invoices_total / invoices_count * 5;
    
    RETURN risk_factor;
END$$

DELIMITER ;

SELECT client_id, name, get_risk_factor_for_client(client_id) AS risk_factor
FROM clients;
