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

