CREATE DATABASE IF NOT EXISTS sql_store2;
USE sql_store2;
DROP TABLE IF EXISTS customer;
CREATE TABLE IF NOT EXISTS customers
(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    points INT NOT NULL DEFAULT 0
);

ALTER TABLE customers 
	ADD contact_no SMALLINT NOT NULL AFTER email;
    
CREATE TABLE IF NOT EXISTS orders
(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    FOREIGN KEY fk_orders_customers (customer_id)
    REFERENCES customers (customer_id)
		ON UPDATE CASCADE
        ON DELETE NO ACTION
);