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