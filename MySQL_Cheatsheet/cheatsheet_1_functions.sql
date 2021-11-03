/* functions */
-- to test function i don't need 'from' clauses
SELECT 1000 * (1 + .1);
SELECT "Ed" AS first_name, "Williams" AS last_name,
	CONCAT(LEFT("Ed", 1), LEFT("Williams", 1));

-- CONCAT
SELECT CONCAT(first_name, last_name) AS full_name FROM customers;

SELECT CONCAT(first_name," ", last_name) AS full_name FROM customers;

SELECT vendor_name,
       CONCAT(vendor_city, ', ', vendor_state, ' ', vendor_zip_code) 
           AS address
FROM vendors;

SELECT CONCAT(vendor_name, '''s Address: ') AS Vendor,
       CONCAT(vendor_city, ', ', vendor_state, ' ', vendor_zip_code) 
           AS Address
FROM vendors;

SELECT "Ed" AS first_name, "Williams" AS last_name,
    CONCAT(LEFT("Ed", 1), LEFT("Williams", 1)) AS initials;

-- substring(string, start, length)
SELECT SUBSTRING(name, 1, 3) FROM films;

-- upper / lower
SELECT UPPER(name) FROM rooms;
SELECT LOWER(name) FROM rooms;

-- date
SELECT DATE(start_time) FROM screenings;

-- month
SELECT MONTH(start_time) FROM screenings;

-- year
SELECT YEAR(start_time) FROM screenings;

-- LEFT(string, number_of_characters)
USE ap;
SELECT vendor_contact_first_name, vendor_contact_last_name,
       CONCAT(LEFT(vendor_contact_first_name, 1), 
              LEFT(vendor_contact_last_name, 1)) AS initials
FROM vendors;

-- FORMAT(number, decimal:optional) -> converts number to a character string(000,000,...)
SELECT FORMAT(121231441.43232, 2) AS format;

-- CHAR(val 1, val 2, ..) -> to binary string
-- - CHAR(9) -> tab
-- - CHAR(10) -> line feed
-- - CHAR(13) -> carriage return
SELECT CONCAT(vendor_name, CHAR(13, 10), vendor_address1, CHAR(13, 10),
	   vendor_city, ', ', vendor_state, ' ', vendor_zip_code) AS char_
FROM vendors
WHERE vendor_id = 1;

-- DATE_FORMAT(date, '%m/%d/%y')
SELECT DATE_FORMAT(CURRENT_DATE, '%m/%d/%y') AS 'MM/DD/YY',
       DATE_FORMAT(CURRENT_DATE, '%e-%b-%Y') AS 'DD-Mon-YYYY';

SELECT invoice_date,
       DATE_FORMAT(invoice_date, '%m/%d/%y') AS 'MM/DD/YY',
       DATE_FORMAT(invoice_date, '%e-%b-%Y') AS 'DD-Mon-YYYY'
FROM invoices
ORDER BY invoice_date;

-- ROUND(number, decimal)
SELECT 12345.6789 AS value,
       ROUND(12345.67) AS nearest_dollar,
       ROUND(12345.67, 1) AS nearest_dime;
       
SELECT invoice_date, invoice_total,
       ROUND(invoice_total) AS nearest_dollar,
       ROUND(invoice_total, 1) AS nearest_dime
FROM invoices
ORDER BY invoice_date;

-- SUM
SELECT COUNT(*) AS number_of_invoices,
    SUM(invoice_total - payment_total - credit_total) AS total_due
FROM invoices
WHERE vendor_id = 34;


