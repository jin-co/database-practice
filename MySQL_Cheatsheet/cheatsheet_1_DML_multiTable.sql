/* DML multitable JOIN */

SELECT * FROM products;
SELECT * FROM orders;

SELECT p.name, o.order_time FROM orders o
INNER JOIN products p ON o.product_id = p.id;

SELECT p.name, o.order_time FROM orders o
INNER JOIN products p ON o.product_id = p.id;

SELECT o.id, c.phone_number, c.last_name, o.order_time FROM orders o
LEFT JOIN customers c ON o.customer_id = c.id
LIMIT 10;

SELECT o.id, c.phone_number, c.last_name, o.order_time FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.id
LIMIT 10;

SELECT p.name, p.price, c.first_name, c.last_name, o.order_time FROM products p
JOIN orders o ON p.id = o.product_id
JOIN customers c on c.id = o.customer_id
WHERE c.last_name = 'Martin'
ORDER BY 1;

SELECT * from orders;
SELECT * from customers;
SELECT * from orders o
JOIN customers c ON c.id = o.customer_id
WHERE o.product_id = 4;

SELECT * FROM products p
JOIN orders o ON o.product_id = p.id
WHERE o.order_time BETWEEN '2017-01-15' AND '2017-02-14'
AND p.name = 'Filter'; 

SELECT * FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN products p ON o.product_id = p.id
WHERE c.gender = 'F';

SELECT invoice_id, vendor_id, invoice_total
FROM invoices
ORDER BY invoice_id
LIMIT 2, 3;

SELECT invoice_id, vendor_id, invoice_total
FROM invoices
ORDER BY invoice_id
LIMIT 100, 1000;
  
SELECT department_name, last_name, project_number
FROM departments d
    LEFT JOIN employees e
        ON d.department_number = e.department_number
    LEFT JOIN projects p
        ON e.employee_id = p.employee_id
ORDER BY department_name, last_name;

USE ap;
SELECT department_name, last_name, project_number
FROM departments d
    JOIN employees e
        ON d.department_number = e.department_number
    LEFT JOIN projects p
        ON e.employee_id = p.employee_id
ORDER BY department_name, last_name;

/* JOIN with USING */
-- simplified syntax
-- the table must be joined by a column that has the same name in both tables separated with commas
SELECT invoice_number, vendor_name
FROM vendors 
    JOIN invoices USING (vendor_id)
ORDER BY invoice_number;

/* implisit JOIN from another database */
-- another way to join
-- differences: 
-- - comma separated tables in from
-- - use where instead of on(like a condition)
SELECT invoice_number, vendor_name
FROM vendors v, invoices i
WHERE v.vendor_id = i.vendor_id;

/* UNION */
-- - must have same number of columns and same types 
-- - by default, removes repatitive data in clude ALL to call all the data
-- - column names are taken from the first table(alias has no effect)
-- - can simulate full outer join(mysql has no full outer join) by combining union, left join, and right join
SELECT 'Active' AS source, invoice_number, invoice_date, invoice_total
    FROM active_invoices
    WHERE invoice_date >= '2018-06-01'
UNION
    SELECT 'Paid' AS source, invoice_number, invoice_date, invoice_total
    FROM paid_invoices
    WHERE invoice_date >= '2018-06-01'
ORDER BY invoice_total DESC;

SELECT 'Active' AS source, invoice_number, invoice_date, invoice_total
    FROM invoices
    WHERE invoice_total - payment_total - credit_total > 0
UNION
    SELECT 'Paid' AS source, invoice_number, invoice_date, invoice_total
    FROM invoices
    WHERE invoice_total - payment_total - credit_total <= 0
ORDER BY invoice_total DESC;

SELECT invoice_number, vendor_name, '33% Payment' AS payment_type,
        invoice_total AS total, invoice_total * 0.333 AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total > 10000
UNION
    SELECT invoice_number, vendor_name, '50% Payment' AS payment_type,
        invoice_total AS total, invoice_total * 0.5 AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total BETWEEN 500 AND 10000
UNION
    SELECT invoice_number, vendor_name, 'Full amount' AS payment_type,
        invoice_total AS total, invoice_total AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total < 500
ORDER BY payment_type, vendor_name, invoice_number;

SELECT department_name AS dept_name, d.department_number AS d_dept_no,
           e.department_number AS e_dept_no, last_name
    FROM departments d 
        LEFT JOIN employees e 
        ON d.department_number = e.department_number
UNION
    SELECT department_name AS dept_name, d.department_number AS d_dept_no,
           e.department_number AS e_dept_no, last_name
    FROM departments d 
        RIGHT JOIN employees e 
        ON d.department_number = e.department_number
ORDER BY dept_name;

/* DML JOIN from another database */
SELECT vendor_name, customer_last_name, customer_first_name, vendor_state AS state, vendor_city AS city
FROM vendors v
	JOIN om.customers c  -- om is database name
    ON v.vendor_zip_code = c.customer_zip
ORDER BY state, city;

/* COMPOUND JOIN from another database */
USE ex;
SELECT DISTINCT v1.vendor_name, v1.vendor_city, 
    v1.vendor_state
FROM vendors v1 JOIN vendors v2
    ON v1.vendor_city = v2.vendor_city AND
       v1.vendor_state = v2.vendor_state AND
       v1.vendor_name <> v2.vendor_name
ORDER BY v1.vendor_state, v1.vendor_city;

/* SELF JOIN from another database */
-- must use alias
-- used for grouping
SELECT DISTINCT v1.vendor_name, v1.vendor_city, v1.vendor_state
FROM vendors v1 JOIN vendors v2
	ON v1.vendor_city = v2.vendor_city AND
	   v1.vendor_state = v2.vendor_state AND
       v1.vendor_name <> v2.vendor_name
ORDER BY v1.vendor_state, v1.vendor_city;

/* JOIN with NATURAL */
-- joins every column that has the same name from two tables
-- prone to error so barely used
USE ap;
SELECT invoice_number, vendor_name
FROM vendors 
    NATURAL JOIN invoices
ORDER BY invoice_number;
 
USE ex;
SELECT department_name AS dept_name, last_name, project_number
FROM departments
    NATURAL JOIN employees
    LEFT JOIN projects USING (employee_id)
ORDER BY department_name;

/* JOIN with CROSS */
-- joins one row with every row from another table(also called uncontrolled join)
use ex;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT d.department_number, department_name, employee_id, last_name
FROM departments d JOIN employees
ORDER BY d.department_number;

SELECT departments.department_number, department_name, employee_id, 
    last_name
FROM departments CROSS JOIN employees
ORDER BY departments.department_number;

/* ============= SUBQUERY ============= */
-- is a SELECT statement that's coded within another SQL statement
-- for this to work it must be always enclosed in parentheses
-- it is the same as SELECT statement but it cannot have ORDER BY clause
-- can come in WHERE, HAVING, FROM, SELECT

/*
-- * subquery and join are interchangable 
     -> the difference is that subquery cannot be included in a column in the result set
     -> 'NOT IN' in subquery can typically restated using an outer join
-- * the only case that a subquery is not interchanable with join is 
	 when it returns an aggregate value in a WHERE condition
*/

/*
-- - in WHERE 
-> the subquery must return a single value
-> correlated subquery is typically used
-> it is easier to use JOIN instead
*/
SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE invoice_total > 
	(SELECT AVG(invoice_total)
    FROM invoices);

SELECT invoice_number, invoice_date, invoice_total
FROM invoices JOIN vendors
	USING(vendor_id)
WHERE vendor_state = 'CA'
ORDER BY invoice_date;

SELECT invoice_number, invoice_date, invoice_total
FROM invoices 
WHERE vendor_id IN (SELECT vendor_id FROM
		vendors WHERE vendor_state = 'CA')
ORDER BY invoice_date;

SELECT vendor_id, vendor_name, vendor_state
FROM vendors
WHERE vendor_id NOT IN
	(SELECT DISTINCT vendor_id
    FROM invoices)
ORDER BY vendor_id;

SELECT v.vendor_id, vendor_name, vendor_state
FROM vendors v LEFT JOIN invoices i 
	USING(vendor_id)
WHERE i.vendor_id IS NULL
ORDER BY vendor_id;

SELECT first_name, last_name FROM employees -- find the name (first_name, last_name) of the employees 
WHERE manager_id in (select employee_id -- who have a manager 
FROM employees WHERE department_id -- and worked in a USA based department.
IN (SELECT department_id FROM departments WHERE location_id 
IN (select location_id from locations where country_id='US')));

SELECT first_name, last_name, salary 
FROM employees 
WHERE employees.salary = (SELECT min_salary -- whose salary is equal to the minimum salary for their job grade.
FROM jobs
WHERE employees.job_id = jobs.job_id);

SELECT first_name, last_name, salary 
FROM employees 
WHERE department_id IN  
(SELECT department_id FROM departments WHERE department_name LIKE 'IT%') -- works in any of the IT departments
AND salary > (SELECT avg(salary) FROM employees); -- who earns more than the average salary

SET @i = 0; 
SELECT i, employee_id  -- a query to fetch even numbered records from employees table.
FROM (SELECT @i := @i + 1 AS i, employee_id FROM employees)
a WHERE MOD(a.i, 2) = 0;

SELECT DISTINCT salary 
FROM employees e1 
WHERE 5 = (SELECT COUNT(DISTINCT salary) -- 5th maximum salary in the employees table
FROM employees  e2 
WHERE e2.salary >= e1.salary);

SELECT * FROM (
SELECT * FROM employees ORDER BY employee_id DESC LIMIT 10) sub -- select last 10 records from a table.
ORDER BY employee_id ASC;

SELECT DISTINCT salary 
FROM employees a 
WHERE 3 >= (SELECT COUNT(DISTINCT salary) 
FROM employees b 
WHERE b.salary >= a.salary) -- get 3 maximum salaries.
ORDER BY a.salary DESC;

SELECT DISTINCT salary 
FROM employees a 
WHERE  3 >= (SELECT COUNT(DISTINCT salary) 
FROM employees b 
WHERE b.salary <= a.salary) -- get 3 minimum salaries.
ORDER BY a.salary DESC;

SELECT *
FROM employees emp1
WHERE (1) = (
SELECT COUNT(DISTINCT(emp2.salary)) -- get nth maximum salaries of employees.
FROM employees emp2
WHERE emp2.salary > emp1.salary);

-- comparison operator
-- - used in WHERE clause
-- - if used with ANY, SOME, ALL keyword -> returns a list
/* -- -- syntax
WHERE expression comparison_operator [SOME|ANY|ALL] (subquery)
*/
SELECT invoice_number, invoice_date,
	invoice_total - payment_total - credit_total AS balance_due
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0
  AND invoice_total - payment_total - credit_total < 
	( SELECT AVG(invoice_total - payment_total - credit_total)
    FROM invoices
    WHERE invoice_total - payment_total - credit_total > 0)
ORDER BY invoice_total DESC;

-- - ALL
-- -- if no rows are returned, it is always true
-- -- if the rows returned contains null, it is always false
/*
x > ALL(1,2) -> returns true if x is greater than maximum value(x > 2)
x < ALL(1,2) -> returns true if x is less than minimum value(x < 1)
x = ALL(1,2) -> returns true if x is equal to all the value(s) returned(x = 1 and x = 2)
x <> ALL(1,2) -> returns true if x is not one of the value(s) returned(x NOT IN (1,2))
*/
SELECT vendor_name, invoice_number, invoice_total
FROM invoices i 
	JOIN vendors v USING(vendor_id)
WHERE invoice_total > ALL
	(SELECT invoice_total
    FROM invoices
    WHERE vendor_id = 34);

-- - ANY(=SOME)
-- -- if the subquery doesn't return any values, or if it only returns null, it is always false
/*
x > ANY(1,2) -> returns true if x is greater than minimum value(x > 1)
x < ANY(1,2) -> returns true if x is less than maximum value(x < 2)
x = ANY(1,2) -> returns true if x is equal to any of the value(s) returned(x IN(1,2))
x <> ANY(1,2) -> returns true if x is not equal to aleast one of the value(s) returned(x <> 1 OR x <> 2)
*/
SELECT vendor_name, invoice_number, invoice_total
FROM vendors 
	JOIN invoices USING(vendor_id)
WHERE invoice_total < ANY
	(SELECT invoice_total
    FROM invoices
    WHERE vendor_id = 115);

-- -- same result but easier to read
SELECT vendor_name, invoice_number, invoice_total
FROM vendors 
	JOIN invoices USING(vendor_id)
WHERE invoice_total <
	(SELECT MAX(invoice_total)
    FROM invoices
    WHERE vendor_id = 115);
    
-- - correlated
-- -- excuted once for each row that's processed by the main query
SELECT vendor_id, invoice_number, invoice_total
FROM invoices i
WHERE invoice_total >
	(SELECT AVG(invoice_total)
    FROM invoices
    WHERE vendor_id = i.vendor_id)
ORDER BY vendor_id, invoice_total;

-- - (NOT)EXISTS
-- -- generally used with correlated subqueries
-- -- to test (no rows) | (one or more rows) are returned by the subquery
-- -- doen't matter what columns(as it doesn't return a result set) I specify, so * is generally used

SELECT vendor_id, vendor_name, vendor_state
FROM vendors
WHERE NOT EXISTS
	(SELECT *
    FROM invoices
    WHERE vendor_id = vendors.vendor_id);
    
/*
-- - in SELECT 
-> the subquery must return a single value
-> correlated subquery is typically used
-> it is easier to use JOIN instead
*/
SELECT vendor_name,
	(SELECT MAX(invoice_date) FROM invoices
	WHERE vendor_id = vendors.vendor_id) AS latest_inv
FROM vendors
ORDER BY latest_inv DESC;

SELECT employee_id, first_name, last_name, -- display the employee ID, first name, last name, and department names of all employees.
(SELECT department_name FROM departments d
 WHERE e.department_id = d.department_id) department 
 FROM employees e ORDER BY department;

/*
-- - in FROM 
-> must assign an alias to it
-> 
*/

SELECT vendor_state, MAX(sum_of_invoices) AS max_sum_of_invoices
FROM
(
	SELECT vendor_state, vendor_name,
		SUM(invoice_total) AS sum_of_invoices
	FROM vendors v JOIN invoices i
		USING(vendor_id)
	GROUP BY vendor_state, vendor_name
) t
GROUP BY vendor_state
ORDER BY vendor_state;

-- correlated -> inner query uses data from outter query and runs multiple times
SELECT screening_id, customer_id,
(SELECT COUNT(seat_id)
FROM reserved_seats WHERE booking_id = b.id)
FROM bookings b;

-- non correlated -> inner query is independent from outter query and runs only one time
SELECT id, start_time FROM screenings
WHERE film_id IN
	(SELECT id from films
	WHERE length_min > 120);
    
SELECT MAX(no_seats) FROM
(SELECT booking_id, COUNT(seat_id) AS no_seats FROM reserved_seats 
GROUP BY booking_id) b;

USE cinema_booking_system; 

-- 1. Select the film name and length for all films with a length greater than the average film length. 

SELECT name, length_min FROM films 
WHERE length_min >
(SELECT AVG(length_min) FROM films);

SELECT AVG(length_min) FROM films;

-- 2. Select the maximum number and the minimum number of screenings for a particular film.

SELECT MAX(id), MIN(id) FROM
(SELECT film_id, COUNT(id) AS id FROM screenings
GROUP BY film_id) a;

-- 3. Select each film name and the number of screenings for that film.

SELECT name, 
(SELECT COUNT(id) FROM screenings 
WHERE film_id = f.id
)
FROM films f;

/* ============= CTE(Common Table Expression) ============= */
-- similar to subquery
-- only exists in the memory
WITH summary AS
(
    SELECT vendor_state, vendor_name, SUM(invoice_total) AS sum_of_invoices
    FROM vendors v JOIN invoices i 
        ON v.vendor_id = i.vendor_id
    GROUP BY vendor_state, vendor_name
),
top_in_state AS
(
    SELECT vendor_state, MAX(sum_of_invoices) AS sum_of_invoices
    FROM summary
    GROUP BY vendor_state
)
SELECT summary.vendor_state, summary.vendor_name, top_in_state.sum_of_invoices
FROM summary JOIN top_in_state
    ON summary.vendor_state = top_in_state.vendor_state AND
       summary.sum_of_invoices = top_in_state.sum_of_invoices
ORDER BY summary.vendor_state;

-- - recursive
USE ex;
WITH RECURSIVE employees_cte AS
(
        -- Anchor member
        SELECT employee_id, 
            CONCAT(first_name, ' ', last_name) AS employee_name, 
            1 AS ranking
        FROM employees
        WHERE manager_id IS NULL
    UNION ALL
        -- Recursive member
        SELECT employees.employee_id, 
            CONCAT(first_name, ' ', last_name), 
            ranking + 1
        FROM employees
            JOIN employees_cte
            ON employees.manager_id = employees_cte.employee_id
)
SELECT *
FROM employees_cte
ORDER BY ranking, employee_id;