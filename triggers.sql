USE sql_invoicing

DELIMITER $$

CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments 
    FOR EACH ROW
BEGIN
	UPDATE invoices 
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
END $$
DELIMITER ;


INSERT INTO payments
VALUES(DEFAULT,2,1,'1990-09-01',63,1)

-- Create a trigger that gets fired when we delete a payment
DELIMITER $$
DROP TRIGGER IF EXISTS payments_after_delete;

CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW 
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
END $$

DELIMITER ;


DELETE FROM payments
WHERE payment_id = 14;

SHOW TRIGGERS