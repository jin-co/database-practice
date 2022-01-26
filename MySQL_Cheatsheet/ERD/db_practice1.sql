CREATE TABLE employees
(
  employee_id            INT            PRIMARY KEY   AUTO_INCREMENT
);

CREATE TABLE projects
(
  project_id            INT            PRIMARY KEY   AUTO_INCREMENT
);

CREATE TABLE departments
(
  department_id            INT            PRIMARY KEY   AUTO_INCREMENT
);

CREATE TABLE assigned_projects
(
  employee_id            INT,
  project_id             INT
);
ALTER TABLE projects ADD department_id int;
ALTER TABLE projects ADD CONSTRAINT department_id FOREIGN KEY (department_id) REFERENCES departments (departments_id);
ALTER TABLE projects ADD FOREIGN KEY (department_id) REFERENCES departments (department_id);
ALTER TABLE departments DROP COLUMN project_id;

ALTER TABLE departments DROP FOREIGN KEY project_id;

ALTER TABLE employees ADD email VARCHAR(30);
ALTER TABLE departments ADD departments_name  VARCHAR(20);

ALTER TABLE locations ADD ID  INT FIRST; --  add a columns ID as the first column of the table locations

ALTER TABLE locations ADD region_id INT AFTER state_province; -- add a column region_id after state_province to the table locations

ALTER TABLE invoices ADD balance_due DECIMAL(9,2);

-- assignment 1
CREATE SCHEMA assignmen1;
USE assignmen1;

CREATE TABLE tenants
(
	tenant_id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE buildings
(
	building_id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE apartments
(
	apartment_id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE parkinglots
(
	parkinglot_id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE building_parkinglots
(
	parkinglot_id INT, 
    building_id INT
);

ALTER TABLE buildings ADD COLUMN
( 
	buinding_name VARCHAR(20),
    street VARCHAR(50),
    city VARCHAR(20),
    province VARCHAR(20),
    country VARCHAR(20),
    postal_code VARCHAR(20)
);

ALTER TABLE buildings 
DROP street, 
DROP city, 
DROP province, 
DROP country, 
DROP postal_code;

ALTER TABLE apartments ADD COLUMN
( 
	unit_number VARCHAR(20),
    leased BOOL
); 
 

ALTER TABLE tenants ADD COLUMN
( 
	last_name VARCHAR(20),    
    first_name VARCHAR(20)
);


ALTER TABLE parkinglots ADD COLUMN
( 
	parkinglot_name VARCHAR(20)
);

CREATE TABLE addresses
(
	address_id INT PRIMARY KEY, 
    street VARCHAR(50),
    city VARCHAR(20),
    province VARCHAR(20),
    country VARCHAR(20),
    postal_code VARCHAR(20)
);



