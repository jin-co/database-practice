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

-- exercise chapter 7
-- 1 
SELECT DISTINCT vendor_name
FROM vendors JOIN invoices
	USING(vendor_id)
ORDER BY vendor_name;

SELECT vendor_name 
FROM vendors
WHERE vendor_id IN
	(SELECT vendor_id FROM invoices)
ORDER BY vendor_name;

-- 2
SELECT invoice_number, invoice_total 
FROM invoices
WHERE payment_total > 
	(SELECT AVG(payment_total) FROM invoices
    WHERE payment_total > 0)
ORDER BY invoice_total DESC;

-- 3
SELECT account_number, account_description 
FROM general_ledger_accounts
WHERE account_number NOT IN
	(SELECT account_number FROM invoice_line_items);

SELECT account_number, account_description 
FROM general_ledger_accounts g
WHERE NOT EXISTS
	(SELECT account_number 
    FROM invoice_line_items
    WHERE account_number = g.account_number);

SELECT *
FROM general_ledger_accounts g
	LEFT JOIN invoice_line_items i
    USING (account_number)
WHERE i.invoice_id IS NULL;

-- 4
SELECT vendor_name, invoice_id, invoice_sequence, line_item_amount FROM vendors
	JOIN invoices USING(vendor_id)
    JOIN invoice_line_items USING(invoice_id)
WHERE invoice_id IN (
	SELECT invoice_id FROM invoice_line_items
	WHERE invoice_sequence > 1)
ORDER BY vendor_name, invoice_id, invoice_sequence;

-- 5
SELECT SUM(pay_total) AS total FROM (
	SELECT invoice_id, 
		   MAX(invoice_total) AS pay_total
	FROM invoices
	WHERE invoice_total - payment_total - credit_total > 0
	GROUP BY vendor_id) t;

-- 6
SELECT * FROM vendors;
SELECT vendor_name, vendor_city, vendor_state FROM vendors;

SELECT vendor_name, vendor_city, vendor_state
FROM vendors
WHERE CONCAT(vendor_state, vendor_city) NOT IN 
    (SELECT CONCAT(vendor_state, vendor_city) as vendor_city_state
     FROM vendors
     GROUP BY vendor_city_state
     HAVING COUNT(*) > 1)
ORDER BY vendor_state, vendor_city;

SELECT CONCAT(vendor_state, vendor_city) as vendor_city_state
     FROM vendors
     GROUP BY vendor_city_state
     HAVING COUNT(*) > 1;
     
-- 7
SELECT * FROM vendors;
SELECT * FROM invoices;

SELECT vendor_id, vendor_name, MIN(invoice_date)
FROM vendors v
	JOIN invoices USING(vendor_id)
GROUP BY vendor_id;

SELECT vendor_name, invoice_number,
       invoice_date, invoice_total
FROM invoices i JOIN vendors v
  ON i.vendor_id = v.vendor_id
WHERE invoice_date =
	(SELECT MIN(invoice_date)
    FROM invoices
    WHERE vendor_id = v.vendor_id);

-- 8
SELECT vendor_name, invoice_number,
       invoice_date, invoice_total
FROM invoices i
    JOIN
    (
      SELECT vendor_id, MIN(invoice_date) AS oldest_invoice_date
      FROM invoices
      GROUP BY vendor_id
    ) oi
    ON i.vendor_id = oi.vendor_id AND
       i.invoice_date = oi.oldest_invoice_date
    JOIN vendors v
    ON i.vendor_id = v.vendor_id
ORDER BY vendor_name;

-- 9
WITH max_invoice AS
(
	SELECT vendor_id, MAX(invoice_total) AS invoice_max
    FROM invoices
    WHERE invoice_total - credit_total - payment_total > 0
    GROUP BY vendor_id
)
SELECT SUM(invoice_max) AS sum_of_maximums
FROM max_invoice;

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


-- assignment 3
-- 1
USE my_guitar_shop;
/*
INSERT that adds this row to the Categories table:
category_name: Brass (automatically generates the category_id)

UPDATE the product_name column to “Woodwinds”, (use the category_id column to identify the row)

SELECT updated record. Save this output 
output1.txt.

DELETE the row you added (use the category_id column) 
Save all sql statements above in one file, query1.sql.
*/

SELECT * FROM categories;

INSERT INTO categories(category_name) VALUES("Brass");

UPDATE categories 
SET category_name = "Woodwinds"
WHERE category_id = 5;

DELETE FROM categories
WHERE category_id = 5;

-- 2
SELECT * FROM products;
SELECT * FROM order_items;
SELECT * FROM categories;

INSERT INTO products(
	   product_id,
	   category_id,
       product_code,
       product_name,
       description,
       list_price,
       discount_percent,
       date_added)
       VALUES(
       DEFAULT,
       4,
       "dgx_640",
       "Yamaha DGX 640 88-Key Digital Piano",
       "Long description to come.",
       799.99,
       0,
       sysdate());

UPDATE products SET discount_percent = 35 WHERE product_name = "Yamaha DGX 640 88-Key Digital Piano";

DELETE FROM products WHERE product_id = 13;
/*
INSERT to the Products table:
product_id: The next automatically generated ID 
category_id: 4
product_code: dgx_640
product_name: Yamaha DGX 640 88-Key Digital Piano
description: Long description to come.
list_price: 799.99
discount_percent: 0
date_added: Today’s date/time.
Use a column list for this statement.

UPDATE discount_percent column from 0% to 35%.

SELECT statement that displays your updated record. Save this output 

DELETE the row that you added to the Categories 
When you execute this statement, it will produce an error since 
the category has related rows in the Products table. To fix that, precede the DELETE 
statement with another DELETE statement that deletes all products in this category. 
(Remember that to code two or more statements in a script, you must end each 
statement with a semicolon.)
Save all sql statements above in one file, query2.sql
*/







