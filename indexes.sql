USE sql_store;
EXPLAIN SELECT customer_id FROM customers WHERE state = 'CA';
CREATE INDEX idx_customers ON customers (state);

-- Write a query to find customers with more than 1000 points. 
EXPLAIN SELECT customer_id FROM customers WHERE points > 1000;
CREATE INDEX idx_customers_points ON customers (points);
DROP INDEX idx_customers_points ON customers;

-- view indexes on our table
SHOW INDEXES IN customers;

SELECT * FROM mysql.user;

SET PASSWORD FOR root = 'admin';

-- Given permission to new user
CREATE USER uma IDENTIFIED BY '1234';
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON sql_store.* TO uma;