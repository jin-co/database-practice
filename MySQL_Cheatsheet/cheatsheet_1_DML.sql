/* Data Manipulate Language */

-- ============= SELECT =============
/*
select -> the columns in the result set
---* distinct -> eliminates duplicate data(rows)
---- comes right after SELECT 

---* all -> opposite of discinct / default so no need to specify
---- comes right after SELECT 

from -> database name from which the query retrieves the data
where -> condition
---* comparision operators
---- when compared with null, the result alway will be null(use IS NULL instead)
---- no case-sensitive('WHAT' 'what' the same)
---- anything can be compared(MYSQL automatically converts the type to compare)

---* compound condition(NOT, AND, OR)
---- precedence(when they are used in a sequence): NOT(1), AND(2), OR(3)
order by -> order [ASC(default) / DESC]
limit -> the number of rows to return
*/
SELECT * FROM products;

SELECT first_name, phone_number 
FROM customers 
WHERE gender = 'F' AND last_name = 'Bluth';

-- DISTINCT
SELECT DISTINCT coffee_origin FROM products;

SELECT DISTINCT vendor_city, vendor_state
FROM vendors
ORDER BY vendor_city;


-- (NOT) IN -> each expression in the list is automatically converted to the same type
-- -* order dosen't matter
SELECT * FROM customers WHERE last_name IN ('Taylor', 'Bluth', 'Armstrong');
SELECT * FROM customers WHERE last_name NOT IN ('Taylor', 'Bluth', 'Armstrong');

-- (NOT) BETWEEN 
-- -* order matters(lower limit should come first)
-- -* limits are inclusive
SELECT DISTINCT customer_id, product_id FROM orders
WHERE order_time BETWEEN '2017-02-01' AND '2017-02-28'
ORDER BY 1;

-- (NOT) LIKE -> degrades performance(use only when it's necessary)
-- -* wildcards
-- -** % -> any string zero or more
SELECT * FROM customers
WHERE last_name LIKE 'W%';  -- % : zero or more

SELECT * FROM customers
WHERE last_name LIKE '%o%'; 

SELECT * FROM products
WHERE price LIKE '3%';  -- note : when used with a number I need to put them in a single quote
-- -** _ -> any single character
SELECT * FROM customers
WHERE first_name LIKE '_o_';  -- _ : only one

-- (NOT) REGEXP -> degrades performance(use only when it's necessary)

-- IS NULL / IS NOT NULL -> not the same as a zero or an empty string
SELECT * FROM customers
WHERE phone_number IS NULL;
SELECT * FROM customers
WHERE phone_number IS NOT NULL;


-- calculated column
SELECT invoice_number, invoice_date, invoice_total,
    invoice_total - payment_total - credit_total AS balance_due
FROM invoices;

-- ORDER BY
-- -* sequence order in ASC : special character -> numbers -> letters
-- -* NULL apperas first in the sort sequence(both in ASC, DESC)
-- -* any column in the base table can be used even then they are not included in the SELECT clause
-- -* ways
-- -** by column name
SELECT * FROM products
ORDER BY price DESC;

-- -** by alias
USE ap;
SELECT invoice_id, 
       invoice_id / 3 AS decimal_quotient,
       invoice_id DIV 3 AS integer_quotient,
       invoice_id % 3 AS remainder
FROM invoices
ORDER BY remainder;

-- -** by expression
SELECT vendor_name,
  CONCAT(vendor_city, ', ', vendor_state, ' ', vendor_zip_code) AS address
FROM vendors
ORDER BY CONCAT(vendor_contact_last_name, vendor_contact_first_name);

-- -** by column position
USE coffee_store;
SELECT * FROM products
ORDER BY 2, 1;

-- LIMIT(offset, length)
SELECT * FROM customers
LIMIT 5;  -- limits the number of rows

USE ap;
SELECT invoice_id, vendor_id, invoice_total
FROM invoices
ORDER BY invoice_id
LIMIT 2, 3;

SELECT invoice_id, vendor_id, invoice_total
FROM invoices
ORDER BY invoice_id
LIMIT 100, 1000;

-- -* offeset starts with index 0(just consider it exclusive)
SELECT * FROM customers
LIMIT 5 OFFSET 5;  -- offset : starting point
use cinema_booking;

/* alias */
-- as alias
SELECT name, name AS coffee FROM products;

-- as "ali as" : to include spaces or special characters enclose the alias with "" of ''
SELECT invoice_number AS "Invoice Number", invoice_date AS Date,
       invoice_total AS Total
FROM invoices;

/*============= INSERT =============*/
-- columns that is PK or have a default value can be omitted
USE cinema_booking;

INSERT INTO products (name, price, coffee_origin)
VALUES ('Espresso', 2.5, 'Brazil');

INSERT INTO products (name, price, coffee_origin) 
VALUES ('Macchiato', 2.5, 'Brazil'), ('Cappuccino', 2.5, 'Peru');

INSERT INTO products (name, price, coffee_origin) 
VALUES 
	('Latte', 3.5, 'Peru'),
    ('Americano', 3.0, 'Indonesia'),
    ('Flat white', 3.5, 'India'),
    ('Filter', 2.5, 'Peru');

-- insert with default
USE ex;
SELECT * FROM color_sample;

INSERT INTO color_sample  -- using default: for PK, column with default)
VALUES(DEFAULT, DEFAULT, 'Orange');

INSERT INTO color_sample (color_name)  -- PK, column with default value omitted
VALUES('Orange');

-- insert with subquery
USE ap;
INSERT INTO invoice_archive
SELECT *
FROM invoices
WHERE invoice_total - payment_total - credit_total = 0;

-- - to demonstrate the advantage of using subquery in this
-- -- the same statement with a column list will be like this
INSERT INTO invoice_archive
    (invoice_id, vendor_id, invoice_number, invoice_total, credit_total,
    payment_total, terms_id, invoice_date, invoice_due_date)
SELECT
    invoice_id, vendor_id, invoice_number, invoice_total, credit_total, 
    payment_total, terms_id, invoice_date, invoice_due_date
FROM invoices
WHERE invoice_total - payment_total - credit_total = 0;


/*================ operators ================*/
 USE ex;

SELECT * FROM null_sample
WHERE invoice_total = 0;

SELECT * FROM null_sample
WHERE invoice_total <> 0;
/*============= UPDATE =============*/
USE cinema_booking;

UPDATE products 
SET coffee_origin = 'Sri Lanka' 
WHERE id = 7;
--  by default, in where clause, only pk can be put when updating. to change this use the code below
SET SQL_SAFE_UPDATES = 0;
-- or to turn it off
-- - Edit -> Preferences -> SQL Editor -> uncheck 'Safe Updates' at the bottom

UPDATE products
SET price = 3.25, coffee_origin = 'Ethiopia'
WHERE name = 'Americano';

UPDATE products
SET coffee_origin = 'Colombia'
WHERE coffee_origin = 'Brazil';

UPDATE invoices
SET credit_total = 35.89
WHERE invoice_number = '367447';

UPDATE invoices
SET invoice_due_date = DATE_ADD(invoice_due_date, INTERVAL 30 DAY)
WHERE terms_id = 4;

-- update with subquery
UPDATE invoices
SET terms_id = 1
WHERE vendor_id = 
	(SELECT vendor_id
    FROM vendors
    WHERE vendor_name = 'Pacific Bell');

/* ============= DELETE ============= */
--  by default, in where clause, only pk can be put when updating. to change this use the code below
-- - *if I turn off the safety and forget to add where if will delete all the data from the table
DELETE FROM people
WHERE name = 'John';

DELETE FROM people;  -- delete everything

DELETE FROM invoices
WHERE invoice_number = '4-342-8069';

DELETE FROM invoices
WHERE invoice_total - payment_total - credit_total = 0;

ALTER TABLE products AUTO_INCREMENT = 1;


