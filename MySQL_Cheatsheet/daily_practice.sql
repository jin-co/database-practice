-- chapther 4 practice
-- 1
use ap;
SELECT * FROM vendors
JOIN invoices ON(vendors.vendor_id = invoices.vendor_id);

SELECT * FROM vendors
JOIN invoices USING(vendor_id);

SELECT * FROM vendors v, invoices i
WHERE v.vendor_id = i.vendor_id;

-- 2
SELECT v.vendor_name, i.invoice_number, i.invoice_date,
	i.invoice_total - i.payment_total - i.credit_total AS balance_total
FROM vendors v
JOIN invoices i ON v.vendor_id = i.vendor_id
WHERE (i.invoice_total - i.payment_total - i.credit_total) <> 0
ORDER BY v.vendor_name;

SELECT v.vendor_name, i.invoice_number, i.invoice_date,
	i.invoice_total - i.payment_total - i.credit_total AS balance_total
FROM vendors v, invoices i
WHERE v.vendor_id = i.vendor_id AND (i.invoice_total - i.payment_total - i.credit_total) <> 0
ORDER BY v.vendor_name;

SELECT v.vendor_name, i.invoice_number, i.invoice_date,
	i.invoice_total - i.payment_total - i.credit_total AS balance_total
FROM vendors v 
JOIN invoices i USING(vendor_id)
WHERE (i.invoice_total - i.payment_total - i.credit_total) <> 0
ORDER BY v.vendor_name;

-- 3
SELECT v.vendor_name, v.default_account_number, g.account_description 
FROM vendors v
JOIN general_ledger_accounts g ON v.default_account_number = g.account_number
ORDER BY account_description, vendor_name;

SELECT v.vendor_name, v.default_account_number, g.account_description 
FROM vendors v, general_ledger_accounts g
WHERE v.default_account_number = g.account_number
ORDER BY account_description, vendor_name;

-- 4
SELECT vendor_name, invoice_date, invoice_number, invoice_sequence, line_item_amount
FROM vendors v
JOIN invoices i ON v.vendor_id = i.vendor_id
JOIN invoice_line_items il ON i.invoice_id = il.invoice_id
ORDER BY vendor_name, invoice_date, invoice_number, invoice_sequence;

SELECT vendor_name, invoice_date, invoice_number, invoice_sequence, line_item_amount
FROM vendors v
JOIN invoices i USING(vendor_id)
JOIN invoice_line_items il USING(invoice_id)
ORDER BY vendor_name, invoice_date, invoice_number, invoice_sequence;

SELECT vendor_name, invoice_date, invoice_number, invoice_sequence, line_item_amount
FROM vendors v, invoices i, invoice_line_items il
WHERE v.vendor_id = i.vendor_id AND i.invoice_id = il.invoice_id
ORDER BY vendor_name, invoice_date, invoice_number, invoice_sequence;

-- 5
SELECT v1.vendor_id, 
       v1.vendor_name,
       CONCAT(v1.vendor_contact_first_name, ' ', v1.vendor_contact_last_name) AS contact_name
FROM vendors v1 JOIN vendors v2
    ON v1.vendor_id <> v2.vendor_id AND
       v1.vendor_contact_last_name = v2.vendor_contact_last_name  
ORDER BY v1.vendor_contact_last_name;

-- 6
SELECT g.account_number, g.account_description
FROM general_ledger_accounts g
LEFT JOIN invoice_line_items i ON g.account_number = i.account_number
WHERE i.invoice_id IS NULL;

SELECT g.account_number, g.account_description
FROM general_ledger_accounts g
LEFT JOIN invoice_line_items i USING(account_number)
WHERE i.invoice_id IS NULL;

-- 7
SELECT vendor_name, vendor_state
FROM vendors
WHERE vendor_state = 'CA'
UNION
SELECT vendor_name, 'Outside CA'
FROM vendors
WHERE vendor_state <> 'CA'
ORDER BY vendor_name;

SELECT * FROM invoices;
SELECT * FROM vendors;
SELECT * FROM general_ledger_accounts;
SELECT * FROM invoice_line_items;

CREATE TABLE z_invoices_copied AS
SELECT * FROM invoices;

CREATE TABLE z_invoices_copied2 AS
SELECT * 
FROM invoices
WHERE invoice_total - payment_total = 0;

drop TABLE z_invoices_copied2;

SELECT * FROM z_invoices_copied2;
SELECT * FROM z_invoices_copied;
SELECT * FROM invoices;

INSERT INTO invoices VALUES
(116, 98, '2345', '2020-02-02', 9344, 0, 0, 1, '2020-08-31', NULL);

USE ex;
SELECT * FROM color_sample;

INSERT INTO color_sample
VALUES(DEFAULT, DEFAULT, 'Orange');

INSERT INTO color_sample (color_name)
VALUES('Orange');

USE ap;
INSERT INTO invoice_archive
SELECT *
FROM invoices
WHERE invoice_total - payment_total - credit_total = 0;

UPDATE invoices
SET payment_total = 2000
WHERE invoice_number = '97.522';

UPDATE invoices
SET terms_id = 1
WHERE vendor_id = 
	(SELECT vendor_id
    FROM vendors
    WHERE vendor_name = 'Pacific Bell');
    
UPDATE invoices
SET terms_id = 1 
WHERE vendor_id IN
	(SELECT vendor_id
    FROM vendors
    WHERE vendor_state IN('CA', 'AZ', 'NV'));
    
DELETE FROM general_ledger_accounts
WHERE account_number = 306;

DELETE FROM invoice_line_items
WHERE invoice_id IN
	(SELECT invoice_id
    FROM invoices
    WHERE vendor_id = 115);

use ap;
SELECT * FROM terms;
INSERT INTO terms VALUES(
	6, 'Net due 120 days', 120); 
 
UPDATE terms 
SET 
	terms_description = 'Net due 125 days',
	terms_due_days = 125
WHERE terms_id = 6;

DELETE FROM terms
WHERE terms_id = 6;

SELECT * FROM invoices;
INSERT INTO invoices values(
	DEFAULT,
    32,
    'AX-014-027',
    '2018-8-1',
    434.58,
    0,
    0,
    2,
    '2018-8-31',
    null);

SELECT * FROM invoice_line_items;
INSERT INTO invoice_line_items (
	invoice_id,
    invoice_sequence,
    account_number,
    line_item_amount,
    line_item_description) 
VALUES(
	115,
    1,
    160,
    180.23,
    'Hard drive'),
    (
	115,
    2,
    527,
    254.35,
    'Exchange Server update');

UPDATE invoices SET
	credit_total = invoice_total * 0.1,
    payment_total = invoice_total - credit_total
WHERE invoice_id = 115;

UPDATE vendors SET
	default_account_number = 403
WHERE vendor_id = 44;

SELECT * FROM vendors WHERE vendor_id = 7;
SELECT * FROM invoices WHERE terms_id = 2;
SELECT * FROM terms;

UPDATE invoices SET
	terms_id = 2
WHERE vendor_id IN
	(SELECT vendor_id
    FROM vendors
    WHERE default_terms_id = 7);

DELETE FROM invoice_line_items
WHERE invoice_id = 115;

DELETE FROM invoices
WHERE invoice_id = 115;

SELECT 'After 2018-1-1', 
	COUNT(*), 
	ROUND(AVG(invoice_total), 2),
    SUM(invoice_total),
    MAX(invoice_total),
    MIN(invoice_total)
FROM invoices;

SELECT MAX(vendor_name),
	MIN(vendor_name),
    COUNT(vendor_name),
    COUNT(DISTINCT vendor_name)
FROM vendors;

SELECT vendor_id, ROUND(AVG(invoice_total), 2)
FROM invoices;

SELECT vendor_id, ROUND(AVG(invoice_total), 2)
FROM invoices
GROUP BY vendor_id;	

SELECT vendor_id, ROUND(AVG(invoice_total), 2)
FROM invoices
GROUP BY vendor_id
HAVING AVG(invoice_total) > 2000;

SELECT vendor_state, vendor_city, COUNT(*),
	ROUND(AVG(invoice_total), 2)
FROM invoices i
JOIN vendors v ON i.vendor_id = v.vendor_id
GROUP BY vendor_state, vendor_city;

SELECT vendor_id,
	COUNT(*),
    SUM(invoice_total)
FROM invoices
GROUP BY vendor_id WITH ROLLUP;

SELECT invoice_date, payment_date,
SUM(invoice_total) AS invoice_total,
SUM(invoice_total - credit_total - payment_total) AS balance_due
FROM invoices
GROUP BY invoice_date, payment_date WITH ROLLUP;

SELECT IF(GROUPING(invoice_date) = 1, 'Grand totals', invoice_date),
	IF(GROUPING(payment_date) = 1, 'Invoice date totals', payment_date),
    SUM(invoice_total) AS invoice_total,
SUM(invoice_total - credit_total - payment_total) AS balance_due
FROM invoices
GROUP BY invoice_date, payment_date WITH ROLLUP;

SELECT vendor_id, invoice_date, invoice_total,
	SUM(invoice_total) OVER() AS total_invoices,
    SUM(invoice_total) OVER(PARTITION BY vendor_id 
		ORDER BY invoice_total) AS vendor_total
FROM invoices
WHERE invoice_total > 5000;

SELECT vendor_id, invoice_date, invoice_total,
	SUM(invoice_total) OVER() AS total_invoices,
    SUM(invoice_total) OVER(PARTITION BY vendor_id 
		ORDER BY invoice_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS vendor_total
FROM invoices
WHERE invoice_date BETWEEN '2018-04-01' AND '2018-04-30';

SELECT vendor_id, invoice_date, invoice_total,
       SUM(invoice_total) OVER(PARTITION BY vendor_id) AS vendor_total,
       ROUND(AVG(invoice_total) OVER(PARTITION BY vendor_id), 2) AS vendor_avg,
       MAX(invoice_total) OVER(PARTITION BY vendor_id) AS vendor_max,
       MIN(invoice_total) OVER(PARTITION BY vendor_id) AS vendor_min
FROM invoices
WHERE invoice_total > 5000;

SELECT vendor_id, invoice_date, invoice_total,
       SUM(invoice_total) OVER vendor_window AS vendor_total,
       ROUND(AVG(invoice_total) OVER vendor_window, 2) AS vendor_avg,
       MAX(invoice_total) OVER vendor_window AS vendor_max,
       MIN(invoice_total) OVER vendor_window AS vendor_min
FROM invoices
WHERE invoice_total > 5000
WINDOW vendor_window AS (PARTITION BY vendor_id);

SELECT vendor_id, invoice_date, invoice_total,
       SUM(invoice_total) OVER (vendor_window ORDER BY invoice_date ASC) AS invoice_date_asc,
       SUM(invoice_total) OVER (vendor_window ORDER BY invoice_date DESC) AS invoice_date_desc
FROM invoices
WHERE invoice_total > 5000
WINDOW vendor_window AS (PARTITION BY vendor_id);

-- exercise chapter 6
-- 1
SELECT vendor_id, SUM(invoice_total) AS invoice_total_sum
FROM invoices
GROUP BY vendor_id;

-- 2
SELECT vendor_name, SUM(payment_total) AS payment_total_sum
FROM invoices
JOIN vendors USING(vendor_id)
GROUP BY vendor_name
ORDER BY payment_total_sum DESC;

SELECT vendor_name, SUM(payment_total) AS payment_total_sum
FROM vendors v JOIN invoices i
  ON v.vendor_id = i.vendor_id
GROUP BY vendor_name
ORDER BY payment_total_sum DESC;

-- 3
SELECT vendor_name, COUNT(*), SUM(invoice_total) 
FROM vendors v
JOIN invoices i USING(vendor_id)
GROUP BY vendor_id
ORDER BY 2 DESC;

SELECT vendor_name, COUNT(*) AS invoice_count,
       SUM(invoice_total) AS invoice_total_sum
FROM vendors v JOIN invoices i
  ON v.vendor_id = i.vendor_id
GROUP BY vendor_name
ORDER BY invoice_count DESC;

-- 4
SELECT * FROM invoice_line_items;
SELECT * FROM general_ledger_accounts;
SELECT account_description,
	COUNT(*) AS account_number_count,
    SUM(line_item_amount) AS line_item_amount_sum
FROM general_ledger_accounts
	JOIN invoice_line_items
	USING(account_number)
GROUP BY account_description
HAVING account_number_count > 1
ORDER BY line_item_amount_sum DESC;

SELECT account_description, COUNT(*) AS line_item_count,
       SUM(line_item_amount) AS line_item_amount_sum
FROM general_ledger_accounts gl 
  JOIN invoice_line_items li
    ON gl.account_number = li.account_number
GROUP BY account_description
HAVING line_item_count > 1
ORDER BY line_item_amount_sum DESC;

-- 5
/* this one throws an erro, adding a 'invoice_date' to SELECT clause fixes the 
error but only returns 3 results */
-- SELECT account_description,
-- 	COUNT(*) AS account_number_count,
--     SUM(line_item_amount) AS line_item_amount_sum
-- FROM invoice_line_items
-- 	JOIN general_ledger_accounts
-- 	USING(account_number)
--     JOIN invoices i
--     USING(invoice_id)
-- GROUP BY account_description
-- HAVING account_number_count > 1 AND i.invoice_date BETWEEN '2018-04-01' AND '2018-06-30'
-- ORDER BY line_item_amount_sum DESC;

SELECT account_description,
	COUNT(*) AS account_number_count,
    SUM(line_item_amount) AS line_item_amount_sum
FROM invoice_line_items
	JOIN general_ledger_accounts
	USING(account_number)
    JOIN invoices i
    USING(invoice_id)
WHERE i.invoice_date BETWEEN '2018-04-01' AND '2018-06-30'
GROUP BY account_description
HAVING account_number_count > 1
ORDER BY line_item_amount_sum DESC;

SELECT account_description, COUNT(*) AS line_item_count,
       SUM(line_item_amount) AS line_item_amount_sum
FROM general_ledger_accounts gl 
  JOIN invoice_line_items li
    ON gl.account_number = li.account_number
  JOIN invoices i
    ON li.invoice_id = i.invoice_id
WHERE invoice_date BETWEEN '2018-04-01' AND '2018-06-30'
GROUP BY account_description
HAVING line_item_count > 1
ORDER BY line_item_amount_sum DESC;

-- 6
SELECT account_number, 
	SUM(account_number) AS account_number_sum
FROM invoice_line_items
GROUP BY account_number WITH ROLLUP;

-- 7
SELECT vendor_name,
	COUNT(DISTINCT li.account_number) AS account_number_count
FROM vendors v
	JOIN invoices i
    USING(vendor_id)
    JOIN invoice_line_items li
    USING(invoice_id)
GROUP BY vendor_name
HAVING account_number_count > 1;

SELECT vendor_name,
       COUNT(DISTINCT li.account_number) AS number_of_gl_accounts
FROM vendors v 
  JOIN invoices i
    ON v.vendor_id = i.vendor_id
  JOIN invoice_line_items li
    ON i.invoice_id = li.invoice_id
GROUP BY vendor_name
HAVING number_of_gl_accounts > 1
ORDER BY vendor_name;

-- 8
SELECT IF(GROUPING(terms_id) = 1, 'Grand Totals', terms_id) AS terms_id,
	IF(GROUPING(vendor_id) = 1,'Terms ID Totals', vendor_id) AS vendor_id,
    MAX(payment_date) AS payment_date_max,
    SUM(invoice_total - payment_total - credit_total) AS balance_due
FROM invoices i
	-- JOIN vendors v USING(vendor_id)
GROUP BY terms_id, vendor_id WITH ROLLUP;

SELECT IF(GROUPING(terms_id) = 1, 'Grand Totals', terms_id) AS terms_id,
       IF(GROUPING(vendor_id) = 1, 'Terms ID Totals', vendor_id) AS vendor_id,
       MAX(payment_date) AS max_payment_date,
       SUM(invoice_total - credit_total - payment_total) AS balance_due
FROM invoices
GROUP BY terms_id, vendor_id WITH ROLLUP;

-- 9
SELECT vendor_id,
	invoice_total - payment_total - credit_total AS balance_due,
    SUM(invoice_total - payment_total - credit_total) OVER() AS total_due,
    SUM(invoice_total - payment_total - credit_total) OVER(PARTITION BY vendor_id
		ORDER BY invoice_total - payment_total - credit_total) AS total_due
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0;

SELECT vendor_id, invoice_total - payment_total - credit_total AS balance_due,
	   SUM(invoice_total - payment_total - credit_total) OVER() AS total_due,
       SUM(invoice_total - payment_total - credit_total) OVER(PARTITION BY vendor_id
           ORDER BY invoice_total - payment_total - credit_total) AS vendor_due
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0;

-- 10
SELECT vendor_id,
	invoice_total - payment_total - credit_total AS balance_due,
    SUM(invoice_total - payment_total - credit_total) OVER() AS total_due,
    SUM(invoice_total - payment_total - credit_total) OVER vendor_window AS total_due,
	ROUND(AVG(invoice_total - payment_total - credit_total) OVER vendor_window, 2) AS due_average
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0
WINDOW vendor_window AS(PARTITION BY vendor_id ORDER BY invoice_total - payment_total - credit_total);

SELECT vendor_id, invoice_total - payment_total - credit_total AS balance_due,
	   SUM(invoice_total - payment_total - credit_total) OVER() AS total_due,
       SUM(invoice_total - payment_total - credit_total) OVER vendor_window AS vendor_due,
       ROUND(AVG(invoice_total - payment_total - credit_total) OVER vendor_window, 2) AS vendor_avg
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0
WINDOW vendor_window AS (PARTITION BY vendor_id ORDER BY invoice_total - payment_total - credit_total);

-- 11
SELECT MONTH(invoice_date) AS month,
	SUM(invoice_total),
    ROUND(AVG(invoice_total) OVER( order by month(invoice_date) range between 3 preceding and current row), 2)
FROM invoices
GROUP BY month
WINDOW month_window AS(PARTITION BY invoice_date ORDER BY MONTH(invoice_date));

SELECT MONTH(invoice_date) AS month, SUM(invoice_total) AS total_invoices,
       ROUND(AVG(SUM(invoice_total)) OVER(ORDER BY MONTH(invoice_date)
           RANGE BETWEEN 3 PRECEDING AND CURRENT ROW), 2) AS 4_month_avg
FROM invoices
GROUP BY MONTH(invoice_date);

SELECT * FROM invoice_line_items;
SELECT * FROM general_ledger_accounts;
SELECT * FROM invoices;
SELECT * FROM vendors;
SHOW TABLES;

SELECT category_name, 
	   product_name, 
	   list_price
FROM categories
	JOIN products USING(category_id)
ORDER BY category_name ASC, product_name ASC;

SELECT first_name, 
	   last_name, 
	   line1, 
	   city, 
	   state, 
	   zip_code
FROM customers
	JOIN addresses USING(customer_id)
WHERE email_address = 'allan.sherwood@yahoo.com';

SELECT first_name, 
	   last_name, 
	   line1, 
	   city, 
	   state, 
	   zip_code,
       shipping_address_id
FROM customers
	JOIN addresses USING(customer_id);

SELECT last_name, 
first_name, 
order_date, 
product_name, 
item_price, 
discount_amount, 
quantity
FROM Customers c 
	JOIN Orders o USING(customer_id)
    JOIN Order_Items oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
ORDER BY last_name, order_date, product_name;

SELECT p1.product_name, p1.list_price
FROM products p1
	JOIN products p2 
		ON p1.product_id <> p2.product_id
		AND p1.list_price = p2.list_price
ORDER BY product_name;

SELECT v1.vendor_id, 
       v1.vendor_name,
       CONCAT(v1.vendor_contact_first_name, ' ', v1.vendor_contact_last_name) AS contact_name
FROM vendors v1 JOIN vendors v2
    ON v1.vendor_id <> v2.vendor_id AND
       v1.vendor_contact_last_name = v2.vendor_contact_last_name  
ORDER BY v1.vendor_contact_last_name;

SELECT category_name,
	   product_id
FROM categories
	LEFT JOIN products USING(category_id)
WHERE product_id IS NULL;

SELECT gl.account_number, account_description, invoice_id
FROM general_ledger_accounts gl LEFT JOIN invoice_line_items li
  ON gl.account_number = li.account_number
WHERE li.invoice_id IS NULL
ORDER BY gl.account_number;

SELECT 'SHIPPED' AS ship_status,
	   order_id,
       order_date
FROM orders
WHERE ship_date IS NOT NULL
UNION
SELECT 'NOT SHIPPED',
	   order_id,
       order_date
FROM orders
WHERE ship_date IS NULL;

SELECT vendor_name, vendor_state
  FROM vendors
  WHERE vendor_state = 'CA'
UNION
  SELECT vendor_name, 'Outside CA'
  FROM vendors
  WHERE vendor_state <> 'CA'
ORDER BY vendor_name;
SELECT * FROM vendors;

/* ============= SUBQUERY ============= */
-- is a SELECT statement that's coded within another SQL statement
-- for this to work it must be always enclosed in parentheses
-- it is the same as SELECT statement but it cannot have ORDER BY clause
-- can come in WHERE, HAVING, FROM, SELECT

/*
-- * subquery and join are interchangable 
--   the difference is subquery cannot be included in a column in the result set
-- * the only case that a subquery is not interchanable with 
--   join is when it returns an aggregate value in a WHERE condition
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

-- comparison operator
-- - if used with ANY, SOME, ALL keyword -> returns a list
SELECT invoice_number, invoice_date,
	invoice_total - payment_total - credit_total AS balance_due
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0
  AND invoice_total - payment_total - credit_total < 
	( SELECT AVG(invoice_total - payment_total - credit_total)
    FROM invoices
    WHERE invoice_total - payment_total - credit_total > 0)
ORDER BY invoice_total DESC;

SELECT vendor_name, invoice_number, invoice_total
FROM invoices i 
	JOIN vendors v USING(vendor_id)
WHERE invoice_total > ALL
	(SELECT invoice_total
    FROM invoices
    WHERE vendor_id = 34);
    
SELECT vendor_name, invoice_number, invoice_total
FROM vendors 
	JOIN invoices USING(vendor_id)
WHERE invoice_total < ANY
	(SELECT invoice_total
    FROM invoices
    WHERE vendor_id = 115);
    
SELECT vendor_name, invoice_number, invoice_total
FROM vendors 
	JOIN invoices USING(vendor_id)
WHERE invoice_total <
	(SELECT MAX(invoice_total)
    FROM invoices
    WHERE vendor_id = 115);
    
SELECT vendor_id, invoice_number, invoice_total
FROM invoices i
WHERE invoice_total >
	(SELECT AVG(invoice_total)
    FROM invoices
    WHERE vendor_id = i.vendor_id)
ORDER BY vendor_id, invoice_total;

SELECT vendor_id, vendor_name, vendor_state
FROM vendors
WHERE NOT EXISTS
	(SELECT *
    FROM invoices
    WHERE vendor_id = vendors.vendor_id);
    
SELECT vendor_name,
	(SELECT MAX(invoice_date) FROM invoices
	WHERE vendor_id = vendors.vendor_id) AS latest_inv
FROM vendors
ORDER BY latest_inv DESC;


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

SELECT t1.vendor_state, vendor_name, t1.sum_of_invoices
FROM
    (
        -- invoice totals by vendor
        SELECT vendor_state, vendor_name,
            SUM(invoice_total) AS sum_of_invoices
        FROM vendors v JOIN invoices i 
            ON v.vendor_id = i.vendor_id
        GROUP BY vendor_state, vendor_name
    ) t1
    JOIN
        (
            -- top invoice totals by state
            SELECT vendor_state,  
                   MAX(sum_of_invoices) AS sum_of_invoices
            FROM
            (
                 -- invoice totals by vendor
                 SELECT vendor_state, vendor_name,
                     SUM(invoice_total) AS sum_of_invoices
                 FROM vendors v JOIN invoices i 
                     ON v.vendor_id = i.vendor_id
                 GROUP BY vendor_state, vendor_name
            ) t2
            GROUP BY vendor_state
        ) t3
    ON t1.vendor_state = t3.vendor_state AND 
       t1.sum_of_invoices = t3.sum_of_invoices
ORDER BY vendor_state;

-- step by step
SELECT vendor_state, vendor_name, SUM(invoice_total) AS sum_of_invoices
FROM vendors v JOIN invoices i 
    ON v.vendor_id = i.vendor_id
GROUP BY vendor_state, vendor_name;

SELECT vendor_state, MAX(sum_of_invoices) AS sum_of_invoices
FROM
(
     SELECT vendor_state, vendor_name,
         SUM(invoice_total) AS sum_of_invoices
     FROM vendors v JOIN invoices i 
         ON v.vendor_id = i.vendor_id
     GROUP BY vendor_state, vendor_name
) t
GROUP BY vendor_state;

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



/* data type */
-- int
-- float(m, d) : m -> how long(in total) / d -> how long to the decimal point // appoximate -> rounds
-- decimal(m, d) : fixed precision -> dosen't round // 'm': precision(maximum number of total digits -> 1 ~ 65) / 'd': scale(the number of digits to the right of the decimal -> 0 ~ 30 *but cannot be greater than precision)
-- char(n) : fixed length, 'n' is the maximum number of charater between 0 ~ 255 // MySQL must reserve 4 byte for each character so 'n * 4'
-- varchar(n) : Variable length, 'n' 'n' is the maximum number of charater between 0 ~ 255 // for English and Latin, needs 1 byte more so 'n' + 1
-- enum('m', 'f') : for defined value
-- boolean
-- date : date(YYYY-MM-DD)
-- datetime : combination date and time from midnight Jan. 1. 1970 to Dec. 31. 9999. (YYYY-MM-DD HH:MM:SS)
-- time : time(HHH-MM-SS)
-- year : year(YYYY) // allowed vales -> 1901 ~ 2155
-- timestamp : automaticaaly updated time when a row is inserted or updated combination date and time from midnight Jan. 1. 1970 to the year 2037 (YYYY-MM-DD HH:MM:SS)

/* data usages under utf8mb4 character set */
-- 1 byte: Latin, digits, punctuations
-- 2 byte: European,  Middle East letters
-- 3 byte: Korean, Chinese, Japanese
-- 4 byte: Emojis, icons

/* tips */
-- there is a concept of return type(value, list) so use it accordingly


-- mid
USE ap;

SHOW TABLES;

SELECT * FROM terms;

INSERT INTO terms VALUES(DEFAULT, "Special terms", 60);

UPDATE terms SET terms_due_days = 120 WHERE terms_id = 7;

DELETE FROM terms WHERE terms_id = 6;

ALTER TABLE terms AUTO_INCREMENT = 1;

USE my_guitar_shop;
SELECT * FROM orders WHERE ship_date IS NULL;
SELECT * FROM orders WHERE ship_date IS NOT NULL;

SELECT "NOT SHIPPED" AS ship_status, order_id, order_date 
FROM orders WHERE ship_date IS NULL
UNION
SELECT "SHIPPED" AS ship_status, order_id, order_date 
FROM orders WHERE ship_date IS NOT NULL
ORDER BY order_date;

USE swexpert;

SHOW TABLES;

SELECT DISTINCT CONCAT(c_first,' ', c_last) AS name, c_city FROM consultant
ORDER BY 1 DESC;

SELECT * FROM consultant;
SHOW TABLES;

SELECT * FROM project;

SELECT p_id, project_name FROM project
WHERE parent_p_id IS NOT NULL;

SHOW TABLES;
SELECT product_code, product_name, list_price, discount_percent 
FROM products
ORDER BY list_price DESC;

SELECT CONCAT(first_name, ', ', last_name) AS full_name,
	   substr(last_name, 1, 1)
FROM customers 
WHERE last_name BETWEEN 'm%' AND 'z%'
ORDER BY last_name;

/*
My SQL
implicit comversion
string  in a numeric expression 
-> if the string starts with a letter of character: 0
-> if the string starts with a number: returns that number until encountered with no numeric values
*/

SELECT * FROM products;
SELECT product_name, list_price, date_added FROM products
WHERE list_price > 500 AND list_price < 2000
ORDER BY date_added DESC;

SELECT product_name,
	   list_price,
       discount_percent,
       ROUND(list_price * (discount_percent / 100), 2) AS discount_amount,
       ROUND((list_price - (list_price * (discount_percent / 100))), 2) AS discount_price
FROM products
ORDER BY discount_price DESC
LIMIT 5;

SELECT item_id,
	   item_price,
	   discount_amount,
       quantity,
       item_price * quantity AS price_total,
       discount_amount * quantity AS discount_total,
       (item_price - discount_amount) * quantity AS item_total
FROM order_items
WHERE (item_price - discount_amount) * quantity > 500
ORDER BY item_total DESC;

SELECT order_id,
	   order_date,
       ship_date
FROM orders
WHERE ship_date IS NULL;

SELECT NOW() AS today_unformatted,
	   DATE_FORMAT(NOW(), '%d-%b-%Y') AS today_formatted;
       
USE ap;
SELECT * FROM vendors;
SELECT * FROM invoices;

SELECT vendor_id, SUM(invoice_total) FROM invoices
GROUP BY vendor_id;

SELECT vendor_name, SUM(payment_total) FROM vendors
JOIN invoices USING(vendor_id)
GROUP BY vendor_name
ORDER BY 2 DESC;

SELECT vendor_name, 
	   COUNT(*) AS invoice_count,
       SUM(invoice_total)
FROM vendors
JOIN invoices USING(vendor_id)
GROUP BY vendor_name
ORDER BY 2 DESC;

SELECT account_description,
	   COUNT(*) AS count,
       SUM(line_item_amount) AS sum
FROM general_ledger_accounts
JOIN invoice_line_items USING(account_number)
GROUP BY account_description
HAVING COUNT(*) > 1
ORDER BY 3 DESC;

SELECT account_description, COUNT(*) AS line_item_count,
       SUM(line_item_amount) AS line_item_amount_sum
FROM general_ledger_accounts gl 
  JOIN invoice_line_items li
    ON gl.account_number = li.account_number
GROUP BY account_description
HAVING line_item_count > 1
ORDER BY line_item_amount_sum DESC;

SELECT account_description,
	   COUNT(*) AS count,
       SUM(line_item_amount) AS sum
FROM general_ledger_accounts
JOIN invoice_line_items USING(account_number)
JOIN invoices USING(invoice_id)
WHERE invoice_date BETWEEN '2018-04-01' AND '2018-06-30'
GROUP BY account_description
HAVING COUNT(*) > 1
ORDER BY 3 DESC;

SELECT account_description, COUNT(*) AS line_item_count,
       SUM(line_item_amount) AS line_item_amount_sum
FROM general_ledger_accounts gl 
  JOIN invoice_line_items li
    ON gl.account_number = li.account_number
  JOIN invoices i
    ON li.invoice_id = i.invoice_id
WHERE invoice_date BETWEEN '2018-04-01' AND '2018-06-30'
GROUP BY account_description
HAVING line_item_count > 1
ORDER BY line_item_amount_sum DESC;

SELECT * FROM invoices;
SELECT * FROM general_ledger_accounts;
SELECT * FROM invoice_line_items;

SELECT account_number,  
	   SUM(line_item_amount)
FROM general_ledger_accounts
JOIN invoice_line_items USING(account_number)
GROUP BY account_number WITH ROLLUP;


SELECT * FROM vendors;
SELECT * FROM invoices;
SELECT * FROM general_ledger_accounts;
SELECT * FROM invoice_line_items;

SELECT vendor_name,
       COUNT(DISTINCT li.account_number) AS number_of_gl_accounts
FROM vendors v 
  JOIN invoices i
    ON v.vendor_id = i.vendor_id
  JOIN invoice_line_items li
    ON i.invoice_id = li.invoice_id
GROUP BY vendor_name
HAVING number_of_gl_accounts > 1
ORDER BY vendor_name;

SELECT terms_id, 
	   vendor_id,
       MAX(payment_date) AS max_payment_date,
	   SUM(invoice_total - payment_total - credit_total)
FROM invoices
GROUP BY terms_id, vendor_id WITH ROLLUP;

SELECT IF(GROUPING(terms_id) = 1, 'Grand Totals', terms_id) AS terms_id,
       IF(GROUPING(vendor_id) = 1, 'Terms ID Totals', vendor_id) AS vendor_id,
       MAX(payment_date) AS max_payment_date,
       SUM(invoice_total - credit_total - payment_total) AS balance_due
FROM invoices
GROUP BY terms_id, vendor_id WITH ROLLUP;

SELECT vendor_id,
	   invoice_total - payment_total -credit_total AS balance_due,
       SUM(invoice_total - payment_total -credit_total) OVER() AS total,
       SUM(invoice_total - payment_total -credit_total) OVER(PARTITION BY vendor_id) AS each_row
FROM invoices
WHERE invoice_total - payment_total -credit_total > 0;

SELECT vendor_id, invoice_total - payment_total - credit_total AS balance_due,
	   SUM(invoice_total - payment_total - credit_total) OVER() AS total_due,
       SUM(invoice_total - payment_total - credit_total) OVER(PARTITION BY vendor_id
           ORDER BY invoice_total - payment_total - credit_total) AS vendor_due
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0;

SELECT vendor_id,
	   invoice_total - payment_total -credit_total AS balance_due,
       SUM(invoice_total - payment_total -credit_total) OVER() AS total,
       SUM(invoice_total - payment_total -credit_total) OVER vendor_window AS each_row,
       AVG(invoice_total - payment_total -credit_total) OVER vendor_window AS balance_avg
FROM invoices
WHERE invoice_total - payment_total -credit_total > 0
WINDOW vendor_window AS (PARTITION BY vendor_id);

SELECT vendor_id, invoice_total - payment_total - credit_total AS balance_due,
	   SUM(invoice_total - payment_total - credit_total) OVER() AS total_due,
       SUM(invoice_total - payment_total - credit_total) OVER vendor_window AS vendor_due,
       ROUND(AVG(invoice_total - payment_total - credit_total) OVER vendor_window, 2) AS vendor_avg
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0
WINDOW vendor_window AS (PARTITION BY vendor_id ORDER BY invoice_total - payment_total - credit_total);

SELECT MONTH(invoice_date),
	   SUM(invoice_total), 
       AVG(SUM(invoice_total)) OVER(ORDER BY MONTH(invoice_date)
			RANGE BETWEEN 3 PRECEDING AND CURRENT ROW) AS 4_month_avg
FROM invoices
GROUP BY MONTH(invoice_date);

SELECT MONTH(invoice_date) AS month, SUM(invoice_total) AS total_invoices,
       ROUND(AVG(SUM(invoice_total)) OVER(ORDER BY MONTH(invoice_date)
           RANGE BETWEEN 3 PRECEDING AND CURRENT ROW), 2) AS 4_month_avg
FROM invoices
GROUP BY MONTH(invoice_date);

SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE invoice_total > (SELECT AVG(invoice_total)
FROM invoices);
    
SELECT * FROM invoices;

SELECT invoice_number, invoice_date, invoice_total
FROM invoices
	JOIN vendors USING(vendor_id)
WHERE vendor_state = 'CA'
ORDER BY invoice_date;

SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE vendor_id IN (SELECT vendor_id FROM vendors
WHERE vendor_state = 'CA')
ORDER BY invoice_date;

SELECT * FROM vendors;
SELECT * FROM invoices;

SELECT invoice_number, invoice_date,
	   invoice_total - payment_total - credit_total AS balance_due
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0
  AND invoice_total - payment_total - credit_total <
	(
		SELECT AVG(invoice_total - payment_total - credit_total)
        FROM invoices
        WHERE invoice_total - payment_total - credit_total > 0
	);

-- get invoice larget than the largest invoice for vendor 34
SELECT * FROM vendors;
SELECT * FROM invoices;
SELECT vendor_name, invoice_number, invoice_total
FROM invoices JOIN vendors USING(vendor_id)
WHERE invoice_total > 
	(SELECT MAX(invoice_total) FROM invoices
	 WHERE vendor_id = 34);
     
SELECT * FROM vendors;
SELECT * FROM invoices;
SELECT vendor_name, invoice_number, invoice_total
FROM vendors JOIN invoices USING(vendor_id)
WHERE invoice_total > 
	(SELECT MAX(invoice_total) FROM invoices
	 WHERE vendor_id = 34);
     
SELECT * FROM vendors;
SELECT * FROM invoices;
SELECT vendor_name, invoice_number, invoice_total
FROM vendors JOIN invoices USING(vendor_id)
WHERE invoice_total > ALL
	(SELECT invoice_total FROM invoices
	 WHERE vendor_id = 34);

SELECT * FROM vendors;
SELECT * FROM invoices;
SELECT vendor_name, invoice_number, invoice_total
FROM vendors JOIN invoices USING(vendor_id)
WHERE invoice_total < ANY(SELECT invoice_total FROM invoices WHERE vendor_id = 115);

SELECT vendor_name, invoice_number, invoice_total
FROM vendors JOIN invoices USING(vendor_id)
WHERE invoice_total < (SELECT MAX(invoice_total) FROM invoices WHERE vendor_id = 115);

SELECT vendor_id, invoice_number, invoice_total
FROM invoices i 
WHERE invoice_total >
	(SELECT AVG(invoice_total)
     FROM invoices
     WHERE vendor_id = i.vendor_id)
ORDER BY vendor_id, invoice_total;

SELECT vendor_id, vendor_name, vendor_state
FROM vendors
WHERE EXISTS (SELECT * FROM invoices WHERE vendor_id = vendors.vendor_id);

SELECT vendor_name, MAX(invoice_date) AS latest_inv
FROM vendors v
	LEFT JOIN invoices i ON v.vendor_id = i.vendor_id
GROUP BY vendor_name
ORDER BY latest_inv DESC;

SELECT vendor_name,
	(SELECT MAX(invoice_date) FROM invoices
    WHERE vendor_id = vendors.vendor_id)
    FROM vendors;

SELECT vendor_name, MAX(invoice_date) FROM vendors
left JOIN invoices USING(vendor_id)
GROUP BY vendor_name;

SELECT vendor_name,
	(SELECT MAX(invoice_date) FROM invoices WHERE vendor_id = vendors.vendor_id)
FROM vendors;

SELECT vendor_name, vendor_state, MAX(sum_of_invoices) FROM 
(
	SELECT vendor_state, vendor_name,
    SUM(invoice_total) AS sum_of_invoices
    FROM vendors v JOIN invoices i
    ON v.vendor_id = i.vendor_id
    GROUP BY vendor_state, vendor_name) t
    GROUP BY vendor_state;
SELECT vendor_name, vendor_state, MAX(sum_of_invoices) FROM
(
	SELECT vendor_state, vendor_name,
    SUM(invoice_total) AS sum_of_invoices
    FROM vendors v JOIN invoices i
    USING(vendor_id) GROUP BY vendor_state, vendor_name ) t GROUP BY vendor_state;
SELECT vendor_state, vendor_name, SUM(invoice_total) FROM vendors
JOIN invoices USING(vendor_id)
GROUP BY vendor_name, vendor_state;

SELECT vendor_state, MAX(sum_of_invoices) AS max_sum_of_invoices
FROM
(
	SELECT vendor_state, vendor_name,
		SUM(invoice_total) AS sum_of_invoices
	FROM vendors v JOIN invoices i USING(vendor_id)
    GROUP BY vendor_state, vendor_name
) t
GROUP BY vendor_state;

SELECT t1.vendor_state, vendor_name, t1.sum_of_invoices
FROM 
(
	SELECT vendor_state, vendor_name,
    SUM(invoice_total) AS sum_of_invoices
    FROM vendors v JOIN invoices i USING(vendor_id)
    GROUP BY vendor_state, vendor_name) t1
    JOIN
    (
		SELECT vendor_state, MAX(sum_of_invoices) AS sum_of_invoices
        FROM
        (
			SELECT vendor_state, vendor_name,
            SUM(invoice_total) AS sum_of_invoices
            FROM vendors v JOIN invoices i USING(vendor_id)
            GROUP BY vendor_state, vendor_name
		) t2
        GROUP BY vendor_state
	) t3
    ON t1.vendor_state = t3.vendor_state AND
	   t1.sum_of_invoices = t3.sum_of_invoices;
WITH summary AS
(
	SELECT vendor_state, vendor_name, SUM(invoice_total) AS sum_of_invoices
    FROM vendors v JOIN invoices i
    USING(vendor_id)
    GROUP BY vendor_state, vendor_name),
    top_in_state AS
    (	
		SELECT vendor_state, MAX(sum_of_invoices) AS sum_of_invoices
        FROM summary
        GROUP BY vendor_state)
        SELECT summary.vendor_state, summary.vendor_name,
        top_in_state.sum_of_invoices
        FROM summary JOIN top_in_state
        ON summary.vendor_state = top_in_state.vendor_state AND
        summary.sum_of_invoices = top_in_state.sum_of_invoices;
        
WITH RECURSIVE employees_cte AS
(
	SELECT employee_id,
	CONCAT(first_name, ' ', last_name) AS employee_name,
    1 AS ranking
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT employees.employee_id,
    CONCAT(first_name, ' ', last_name),
    ranking + 1
    FROM employees
    JOIN employees_cte
    ON employees.manager_id = employees_cte.employee_id)
    SELECT * FROM employees_cte;
    
SELECT vendor_name,
	   CONCAT_WS(', ', vendor_contact_last_name,
				 vendor_contact_first_name) AS contact_name,
		RIGHT(vendor_phone, 8) AS phone
        FROM vendors
        WHERE LEFT(vendor_phone, 4) = '(559'
        ORDER BY contact_name;

CREATE SCHEMA hr;
USE hr;

CREATE TABLE countries (
	country_id INT,
    country_name VARCHAR(30),
    region_id INT
);

CREATE TABLE IF NOT EXISTS countries (
	country_id INT,
    country_name VARCHAR(30),
    region_id INT
);

CREATE TABLE IF NOT EXISTS dup_countries LIKE countries;

CREATE TABLE IF NOT EXISTS dup_countries AS SELECT * FROM countries;

SELECT * FROM countries;
SELECT * FROM dup_countries;

CREATE TABLE IF NOT EXISTS countries ( 
	country_id varchar(2) NOT NULL,
	country_name varchar(40) NOT NULL,
	region_id decimal(10,0) NOT NULL
);

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

CREATE TABLE IF NOT EXISTS countries ( 
	country_id varchar(2) NOT NULL,
	country_name varchar(40) NOT NULL,
	region_id decimal(10,0) NOT NULL,
	UNIQUE(country_id)
);

CREATE TABLE IF NOT EXISTS jobs ( 
	job_id varchar(10) NOT NULL UNIQUE, 
	job_title varchar(35) NOT NULL DEFAULT ' ', 
	min_salary decimal(6,0) DEFAULT 8000, 
	max_salary decimal(6,0) DEFAULT NULL
);

CREATE TABLE job_history ( 
	employee_id decimal(6,0) NOT NULL PRIMARY KEY, 
	start_date date NOT NULL, 
	end_date date NOT NULL, 
	job_id varchar(10) NOT NULL, 
	department_id decimal(4,0) DEFAULT NULL, 
	FOREIGN KEY (job_id) REFERENCES jobs(job_id)
)ENGINE=InnoDB;

INSERT INTO countries VALUES (
	DEFAULT,
    'Japan',
    10
);

INSERT INTO countries VALUES 
	(DEFAULT, 'Canada', 11),
	(DEFAULT, 'China', 12),
	(DEFAULT, 'India', 13);

CREATE TABLE country_new AS SELECT * FROM countries;
DROP TABLE country_new;

SELECT * FROM countries;

CREATE TABLE IF NOT EXISTS countries (
	country_id VARCHAR(2),
    country_name VARCHAR(40)
    CHECK(country_name IN('Italy', 'India', 'China')),
    region_id DECIMAL(10, 0)
);

CREATE TABLE IF NOT EXISTS job_history (
	 employee_id DECIMAL(6, 0) NOT NULL, 
     start_date DATE NOT NULL, 
     end_date DATE NOT NULL
     CHECK(end_date LIKE '--/--/----'),	
     job_id VARCHAR(10) NOT NULL, 
     department_id DECIMAL(4, 0) NOT NULL
);

CREATE TABLE IF NOT EXISTS countries (
	country_id VARCHAR(2) NOT NULL, 
    country_name VARCHAR(40) NOT NULL,
    region_id DECIMAL(10, 0) NOT NULL,
    UNIQUE(country_id) -- no duplicate data against column country_id will be allowed at the time of insertion
);

CREATE TABLE IF NOT EXISTS jobs (
	job_id VARCHAR(10) NOT NULL UNIQUE, 
    job_title VARCHAR(35) NOT NULL DEFAULT ' ', -- he default value for job_title is blank
    min_salary DECIMAL(6, 0) DEFAULT 8000,
    max_salary DECIMAL(6, 0) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS countries (
	country_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY, 
    country_name VARCHAR(20),
    region_id INT
);

CREATE TABLE IF NOT EXISTS countries (
	country_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY, 
    country_name VARCHAR(20) NOT NULL,
    region_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS countries (
	country_id varchar(2) NOT NULL UNIQUE DEFAULT '',
	country_name varchar(40) DEFAULT NULL,
	region_id decimal(10,0) NOT NULL,
PRIMARY KEY (country_id, region_id)); -- combination of columns country_id and region_id will be unique.

CREATE TABLE job_history ( 
	employee_id decimal(6,0) NOT NULL PRIMARY KEY, 
	start_date date NOT NULL, 
	end_date date NOT NULL, 
	job_id varchar(10) NOT NULL, 
	department_id decimal(4,0) DEFAULT NULL, 
	FOREIGN KEY (job_id) REFERENCES jobs(job_id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS employees ( 
	employee_id decimal(6,0) NOT NULL PRIMARY KEY, 
	first_name varchar(20) DEFAULT NULL, 
	last_name varchar(25) NOT NULL, 
	email varchar(25) NOT NULL, 
	phone_number varchar(20) DEFAULT NULL, 
	hire_date date NOT NULL, 
	job_id varchar(10) NOT NULL, 
	salary decimal(8,2) DEFAULT NULL, 
	commissiont_pct decimal(2,2) DEFAULT NULL, 
	manager_id decimal(6,0) DEFAULT NULL, 
	department_id decimal(4,0) DEFAULT NULL, 
	FOREIGN KEY(department_id, manager_id) -- foreign key columns combined by department_id and manager_id
	REFERENCES departments(department_id, manager_id) -- contain only those unique combination values, which combinations are exists in the departments table
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS employees ( 
	employee_id decimal(6,0) NOT NULL PRIMARY KEY, 
	first_name varchar(20) DEFAULT NULL, 
	last_name varchar(25) NOT NULL, 
	email varchar(25) NOT NULL, 
	phone_number varchar(20) DEFAULT NULL, 
	hire_date date NOT NULL, 
	job_id varchar(10) NOT NULL, 
	salary decimal(8,2) DEFAULT NULL, 
	commissiont_pct decimal(2,2) DEFAULT NULL, 
	manager_id decimal(6,0) DEFAULT NULL, 
	department_id decimal(4,0) DEFAULT NULL, 
	FOREIGN KEY(department_id) 
	REFERENCES departments(department_id),
    FOREIGN KEY(job_id) 
	REFERENCES departments(job_id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS employees ( 
	employee_id decimal(6,0) NOT NULL PRIMARY KEY, 
	first_name varchar(20) DEFAULT NULL, 
	last_name varchar(25) NOT NULL, 
	email varchar(25) NOT NULL, 
	phone_number varchar(20) DEFAULT NULL, 
	hire_date date NOT NULL, 
	job_id varchar(10) NOT NULL, 
	salary decimal(8,2) DEFAULT NULL, 
	commissiont_pct decimal(2,2) DEFAULT NULL, 
	manager_id decimal(6,0) DEFAULT NULL, 
	department_id decimal(4,0) DEFAULT NULL, 
	FOREIGN KEY(department_id) 
	REFERENCES departments(department_id)
	ON DELETE CASCADE ON UPDATE RESTRICT ,
    FOREIGN KEY(job_id) 
	REFERENCES departments(job_id)
    ON DELETE CASCADE ON UPDATE RESTRICT 
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS employees ( 
	employee_id decimal(6,0) NOT NULL PRIMARY KEY, 
	first_name varchar(20) DEFAULT NULL, 
	last_name varchar(25) NOT NULL, 
	job_id INTEGER, 
	salary decimal(8,2) DEFAULT NULL, 
	FOREIGN KEY(job_id) 
	REFERENCES  jobs(job_id)
	ON DELETE SET NULL 
	ON UPDATE SET NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS employees ( 
	employee_id decimal(6,0) NOT NULL PRIMARY KEY, 
	first_name varchar(20) DEFAULT NULL, 
	last_name varchar(25) NOT NULL, 
	job_id INTEGER, 
	salary decimal(8,2) DEFAULT NULL, 
	FOREIGN KEY(job_id) 
	REFERENCES  jobs(job_id)
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION
)ENGINE=InnoDB;

UPDATE employees SET email='not available'
WHERE department_id=(
	SELECT department_id 
	FROM departments 
	WHERE department_name='Accounting');
    
UPDATE jobs, employees
	SET jobs.min_salary = jobs.min_salary + 2000,
	jobs.max_salary = obs.max_salary + 2000,
	employees.salary = employees.salary + (employees.salary * .20),
	employees.commission_pct = employees.commission_pct + .10
	WHERE jobs.job_id = 'PU_CLERK' AND employees.job_id = 'PU_CLERK';

-- subquery 15 -> set..
SET @i = 0; 
SELECT i, employee_id  -- a query to fetch even numbered records from employees table.
FROM (SELECT @i := @i + 1 AS i, employee_id FROM employees)
a WHERE MOD(a.i, 2) = 0;

