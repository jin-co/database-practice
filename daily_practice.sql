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

-- exercise 6
SELECT * FROM vendors;
SELECT * FROM invoices;

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
ORDER BY payment_total_sum DESC
