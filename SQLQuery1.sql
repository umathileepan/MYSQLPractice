CREATE DATABASE school_system;
DROP DATABASE school_system;
Use school_system;
CREATE TABLE Students
(
	student_id int NOT NULL PRIMARY KEY,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	address varchar(100) NOT NULL,
	city varchar(100) NOT NULL,
	county varchar(100) NOT NULL,
	post_code varchar(100) NOT NULL,
	country varchar(100) NOT NULL,
	email varchar(255) NOT NULL,
	contact_no varchar(20) NOT NULL,
	date_of_birth date NOT NULL,
);
DROP TABLE Students;
ALTER TABLE Students ADD blood_group varchar(50) NOT NULL;
ALTER TABLE Students DROP COLUMN blood_group;
ALTER TABLE Students ALTER COLUMN date_of_birth datetime;
SELECT * FROM Students;