USE college;

SELECT * FROM students;

ALTER TABLE students
CHANGE COLUMN first_nmae first_name VARCHAR(100) NOT NULL ;

ALTER TABLE students 
CHANGE COLUMN date_of_birth date_of_birth DATE NOT NULL ;

ALTER TABLE students
CHANGE COLUMN contact_no contact_no VARCHAR(50) NOT NULL;

INSERT INTO students (first_name, last_name, date_of_birth, address, city, county, post_code, country, email, contact_no)
VALUES ('Smith', 'Jhon', '2005/06/02', '78 Colin Road', 'Crawly', 'Crawley', 'SA31DT', 'UK', 'jhon@hotmail.com', '07899231674');

INSERT INTO students (first_name, last_name, date_of_birth, address, city, county, post_code, country, email, contact_no)
VALUES ('Jelani', 'Joshva','2006/08/22', '08 Clyde Road', 'Croydon', 'Croydon', 'CR31DT', 'UK', 'joshva@hotmail.com', '07304323167');

INSERT INTO students (first_name, last_name, date_of_birth, address, city, county, post_code, country, email, contact_no)
VALUES ('Charls', 'Adam','2006/09/02', '43 Hill Avenue', 'Croydon', 'London', 'CR01EW', 'UK', 'Adam@hotmail.com', '07704323151');