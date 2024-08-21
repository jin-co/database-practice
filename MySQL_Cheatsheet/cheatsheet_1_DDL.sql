/* Data Definition Language */
SHOW DATABASES;

/*============= DATABASE(SCHEMA) =============*/
CREATE DATABASE test;
DROP DATABASE test;
USE test;  -- gose into test database
SHOW TABLES;
DESCRIBE test;

CREATE DATABASE coffee_store;
USE coffee_store;
SHOW TABLES;

/*============= TABLE =============*/
/*------------- CREATE -------------*/
CREATE TABLE invoices
(
  invoice_id            INT            PRIMARY KEY   AUTO_INCREMENT,
  vendor_id             INT            NOT NULL,
  invoice_number        VARCHAR(50)    NOT NULL,
  invoice_date          DATE           NOT NULL,
  invoice_total         DECIMAL(9,2)   NOT NULL,
  payment_total         DECIMAL(9,2)                 DEFAULT 0,
  credit_total          DECIMAL(9,2)                 DEFAULT 0,
  terms_id              INT            NOT NULL,
  invoice_due_date      DATE           NOT NULL,
  payment_date          DATE,
  CONSTRAINT invoices_fk_vendors
    FOREIGN KEY (vendor_id)
    REFERENCES vendors (vendor_id),
  CONSTRAINT invoices_fk_terms
    FOREIGN KEY (terms_id)
    REFERENCES terms (terms_id)
);

CREATE TABLE products (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    price DECIMAL(3, 2)
);

CREATE TABLE customers (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    gender ENUM('M', 'F'),
    phone_number VARCHAR(12)
);

CREATE TABLE orders (
	id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    order_time DATETIME,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE test (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    age INT
);

CREATE TABLE addresses (
	id INT,
    house_number INT,
	city VARCHAR(20),
    postcode VARCHAR(7)
);

CREATE TABLE people (
	id INT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    address_id INT
); 

CREATE TABLE pets (
	id INT,
    name VARCHAR(20),
    species VARCHAR(20), 
    owner_id INT
); 

-- IF NOT EXISTS
CREATE TABLE IF NOT EXISTS orders (
	id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    order_time DATETIME,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- copying from an existing table
CREATE TABLE department_copy (SELECT * FROM departments);
CREATE TABLE department_copy AS SELECT * FROM departments;

/*------------- CREATE Copy -------------*/--  
-- this only copies columns and data(not contraints, PK, FK, indexes)
-- - I can use SELECT with everything I would with normal SELECT statement

-- -* full copy
-- copies the sctucture and data
CREATE TABLE z_invoices_copied AS
SELECT * FROM invoices;

-- -* partial copy
CREATE TABLE z_invoices_copied2 AS
SELECT * 
FROM invoices
WHERE invoice_total - payment_total = 0;

-- -* LIKE copy
-- copies the sctucture
CREATE TABLE IF NOT EXISTS dup_countries LIKE countries;

/*------------- ALTER -------------*/
CREATE INDEX invoices_vendor_id_index ON invoices (vendor_id);

ALTER TABLE products AUTO_INCREMENT = 100; -- setting auto inclement to 100
TRUNCATE products; -- setting the PK to start back at 1

-- RENAME table
ALTER TABLE countries RENAME country_new;
-- RENAME column
ALTER TABLE employee_copy RENAME COLUMN address TO addresses;

-- ADD [something]
ALTER TABLE locations ADD region_id  INT;

ALTER TABLE locations ADD ID  INT FIRST; --  add a columns ID as the first column of the table locations

ALTER TABLE locations ADD region_id INT AFTER state_province; -- add a column region_id after state_province to the table locations

ALTER TABLE invoices ADD balance_due DECIMAL(9,2);

ALTER TABLE locations ADD PRIMARY KEY(location_id);

ALTER TABLE addresses ADD PRIMARY KEY (id);

ALTER TABLE locations ADD PRIMARY KEY(location_id,country_id);

ALTER TABLE people ADD CONSTRAINT u_email UNIQUE (email);
-- here u_email is the unique id for the constraint
-- to remove the constraint
ALTER TABLE people DROP INDEX u_email;

ALTER TABLE people ADD COLUMN email VARCHAR(20);

ALTER TABLE invoices ADD balance_due DECIMAL(9,2);

ALTER TABLE pets ADD CONSTRAINT FK_Owner_id FOREIGN KEY (owner_id) REFERENCES people (id);

ALTER TABLE pets ADD CONSTRAINT u_species UNIQUE (species);

ALTER TABLE products ADD COLUMN coffee_origin VARCHAR(30);

ALTER TABLE people ADD CONSTRAINT FK_PeopleAddress FOREIGN KEY (address_id) REFERENCES addresses(id);

ALTER TABLE job_history ADD CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES jobs(job_id) 
ON UPDATE RESTRICT 
ON DELETE CASCADE;

ALTER TABLE job_history ADD INDEX indx_job_id(job_id);

ALTER TABLE jobs ADD CONSTRAINT CHECK(max_salary <= 25000);

-- MODIFY
ALTER TABLE addresses MODIFY postcode CHAR(7);

ALTER TABLE locations MODIFY country_id INT;

ALTER TABLE addresses MODIFY city VARCHAR(30);

ALTER TABLE addresses MODIFY city CHAR(30);

ALTER TABLE addresses MODIFY city INT;

ALTER TABLE addresses MODIFY city INT NOT NULL;

-- CHANGE
ALTER TABLE pets CHANGE `name` `first_name` VARCHAR(15);

ALTER TABLE locations CHANGE state_province state varchar(25); -- changing column name(maintains the data in it)

-- DROP [something]
ALTER TABLE invoices DROP COLUMN balance_due;

ALTER TABLE locations DROP city; -- drop the column city from the table

ALTER TABLE locations DROP state_province, ADD state varchar(25) AFTER city; -- changing column name with the same type and size(when data exists, this might not be the solution)

ALTER TABLE addresses DROP PRIMARY KEY;  -- thing is when dropping pk, not null stays not null

ALTER TABLE invoices DROP COLUMN balance_due;

ALTER TABLE people DROP FOREIGN KEY FK_PeopleAddress;

ALTER TABLE pets CHANGE `species` `new_species` VARCHAR(20);  -- note : it is back tick not a single quotes

ALTER TABLE pets CHANGE `new_species` `species` VARCHAR(20);  

ALTER TABLE pets DROP INDEX u_species;  -- note : wheng dropping unique, use index

ALTER TABLE job_history DROP INDEX indx_job_id;

/*------------- DROP -------------*/
DROP INDEX invoices_vendor_id_index ON invocies;

/*------------- TRUNCATE -------------*/
-- drops the table and recreate the table without any data in it -> table remains
TRUNCATE TABLE test; 

/* constrant */

-- PRIMARY KEY
CREATE TABLE IF NOT EXISTS countries ( 
	country_id varchar(2) NOT NULL UNIQUE PRIMARY KEY,
	country_name varchar(40) NOT NULL,
	region_id decimal(10,0) NOT NULL
);

-- -* composite key
CREATE TABLE IF NOT EXISTS countries (
	country_id varchar(2) NOT NULL UNIQUE DEFAULT '',
	country_name varchar(40) DEFAULT NULL,
	region_id decimal(10,0) NOT NULL,
	PRIMARY KEY (country_id, region_id)
);

-- -* AUTO_INCREMENT
CREATE TABLE IF NOT EXISTS countries ( 
	country_id integer NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	country_name varchar(40) NOT NULL,
	region_id decimal(10,0) NOT NULL
);
DESC countries;

-- FOREIGN KEY(foreignKeyName) REFERENCES tableName(columnNameForForeignKey)
/*
the foreign key column job_id contain only those values 
which are exists in the jobs table.
*/ 
CREATE TABLE job_history ( 
	employee_id decimal(6,0) NOT NULL PRIMARY KEY, -- does not contain any duplicate value at the time of insertion
	start_date date NOT NULL, 
	end_date date NOT NULL, 
	job_id varchar(10) NOT NULL, 
	department_id decimal(4,0) DEFAULT NULL, 
	FOREIGN KEY (job_id) REFERENCES jobs(job_id)
)ENGINE=InnoDB;

/*
the foreign key columns combined by 
department_id and manager_id columns contain only those unique combination values, 
which combinations are exists in the departments table.
*/
CREATE TABLE IF NOT EXISTS employees ( 
	employee_id decimal(6,0) NOT NULL PRIMARY KEY, 
	first_name varchar(20) DEFAULT NULL, 
	last_name varchar(25) NOT NULL, 
	email varchar(25) NOT NULL, 
	phone_number varchar(20) DEFAULT NULL, 
	hire_date date NOT NULL, 
	job_id varchar(10) NOT NULL, 
	salary decimal(8,2) DEFAULT NULL, 
	commission_pct decimal(2,2) DEFAULT NULL, 
	manager_id decimal(6,0) DEFAULT NULL, 
	department_id decimal(4,0) DEFAULT NULL, 
	FOREIGN KEY(department_id, manager_id) 
	REFERENCES  departments(department_id, manager_id)
)ENGINE=InnoDB;

/* 
The InnoDB Engine have been used to create the tables.
"A foreign key constraint is not required merely to join two tables. 
For storage engines other than InnoDB, 
it is possible when defining a column to use a REFERENCES 
tbl_name(col_name) clause, which has no actual effect, 
and serves only as a memo or comment to you that the column 
which you are currently defining is intended to refer to a column in another table." 
- Reference dev.mysql.com
*/
CREATE TABLE IF NOT EXISTS employees ( 
	employee_id decimal(6,0) NOT NULL PRIMARY KEY,
	first_name varchar(20) DEFAULT NULL, 
	last_name varchar(25) NOT NULL, 
	email varchar(25) NOT NULL, 
	phone_number varchar(20) DEFAULT NULL, 
	hire_date date NOT NULL, 
	job_id varchar(10) NOT NULL, 
	salary decimal(8,2) DEFAULT NULL, 
	commission_pct decimal(2,2) DEFAULT NULL, 
	manager_id decimal(6,0) DEFAULT NULL, 
	department_id decimal(4,0) DEFAULT NULL, 
	FOREIGN KEY (department_id)
	REFERENCES departments(department_id), -- the foreign key reference by the column department_id of departments table, can contain only those values which are exists in the departments table
	FOREIGN KEY (job_id) 
	REFERENCES jobs(job_id)
)ENGINE=InnoDB;

-- ON DELETE CASCADE ON UPDATE RESTRICT
-- -* when the record in the parent table is deleted and reject any updates
CREATE TABLE IF NOT EXISTS employees (
	employee_id DECIMAL(6,0) NOT NULL PRIMARY KEY, 
    first_name VARCHAR(20) DEFAULT NULL, 
    last_name VARCHAR(25) NOT NULL, 
    job_id INTEGER NOT NULL,
    salary DECIMAL(8, 2) DEFAULT NULL,
    FOREIGN KEY(job_id)
    REFERENCES jobs(job_id)
    ON DELETE CASCADE ON UPDATE RESTRICT   
) ENGINE = InnoDB;

-- ON DELETE SET NULL ON UPDATE SET NULL
CREATE TABLE IF NOT EXISTS employees (
	employee_id DECIMAL(6, 0) NOT NULL PRIMARY KEY,
    first_name VARCHAR(20) DEFAULT NULL, 
    last_name VARCHAR(25) NOT NULL, 
    job_id INTEGER, 
    salary DECIMAL(8, 2) DEFAULT NULL,
    FOREIGN KEY (job_id)
    REFERENCES jobs(job_id)
    ON DELETE SET NULL -- resets the foreign key column values in the child table(employees) to NULL when the record in the parent table(jobs) is deleted
    ON UPDATE SET NULL -- resets the values in the rows in the child table(employees) to NULL values when the rows in the parent table(jobs) are updated.
) ENGINE = InnoDB;

-- ON DELETE NO ACTION ON UPDATE NO ACTION
-- -* reject the deletion and any updates
CREATE TABLE IF NOT EXISTS employees ( 
	employee_id DECIMAL(6,0) NOT NULL PRIMARY KEY, 
    first_name VARCHAR(20) DEFAULT NULL, 
    last_name VARCHAR(25) NOT NULL, 
    job_id INTEGER NOT NULL, 
    salary DECIMAL(8,2) DEFAULT NULL, 
	FOREIGN KEY(job_id) 
	REFERENCES jobs(job_id)
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION
)ENGINE=InnoDB;

-- NOT NULL
CREATE TABLE IF NOT EXISTS countries ( 
	country_id varchar(2) NOT NULL,
	country_name varchar(40) NOT NULL,
	region_id decimal(10,0) NOT NULL
);

-- CHECK(column condition)
CREATE TABLE IF NOT EXISTS jobs (
	job_id VARCHAR(15) NOT NULL,
    job_title DECIMAL(6, 0),
    min_salary DECIMAL(6, 0),
    max_salary DECIMAL(6, 0)
    CHECK(max_salary <= 25000)
);

CREATE TABLE IF NOT EXISTS countries ( 
	country_id varchar(2) NOT NULL,
	country_name varchar(40) 
		NOT NULL
		CHECK(country_name IN('Italy', 'India', 'China')),
	region_id decimal(10,0) 
);

CREATE TABLE IF NOT EXISTS job_history ( 
	employee_id decimal(6,0) NOT NULL, 
	start_date date NOT NULL, 
	end_date date NOT NULL
	CHECK (end_date LIKE '--/--/----'), 
	job_id varchar(10) NOT NULL, 
	department_id decimal(4,0) NOT NULL 
);

-- UNIQUE(column) -> no duplicate values are allowed
CREATE TABLE IF NOT EXISTS countries ( 
	country_id varchar(2) NOT NULL,
	country_name varchar(40) NOT NULL,
	region_id decimal(10,0) NOT NULL,
	UNIQUE(country_id)
);

-- DEFAULT value 
CREATE TABLE IF NOT EXISTS jobs ( 
	job_id varchar(10) NOT NULL UNIQUE, 
	job_title varchar(35) NOT NULL DEFAULT ' ', 
	min_salary decimal(6,0) DEFAULT 8000, 
	max_salary decimal(6,0) DEFAULT NULL
);



