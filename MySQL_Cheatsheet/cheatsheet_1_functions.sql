/* functions */
-- to test function i don't need 'from' clauses
SELECT 1000 * (1 + .1);
SELECT "Ed" AS first_name, "Williams" AS last_name,
	CONCAT(LEFT("Ed", 1), LEFT("Williams", 1));

/*================ string ================*/

/* -- CONCAT --  */
-- > if one value is null the result is null
SELECT CONCAT(first_name, last_name) AS full_name FROM customers;

SELECT CONCAT(first_name, " ", last_name) AS full_name FROM customers;

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

-- - IFNULL: to deal with NULL values
SELECT c_last, c_first,
	   CONCAT(c_first, ' ', IFNULL(c_mi, ''), ' ', c_last) AS full_name
FROM consultant
	JOIN project_consultant USING(c_id)
	JOIN project USING(p_id)
WHERE p_id IN (SELECT p_id FROM project_consultant
WHERE c_id = 100);

/* -- CONCAT_WS --  */
-- > CONCAT with specified separator, if the delimeter is null the result is null(not the value)
SELECT CONCAT_WS(', ', 'last', 'first');

/* -- SUBSTRING(string, start, length) --  */
SELECT SUBSTRING(name, 1, 3) FROM films;

SELECT SUBSTRING('(333) 333-1212', 7, 8);

/* -- SUBSTRING_INDEX(string, index) --  */
SELECT SUBSTRING_INDEX('http://www.murach.com', '.', -2);

-- parsing
USE ex;
SELECT emp_name,
	   SUBSTRING_INDEX(emp_name, ' ', 1) AS first_name,
	   SUBSTRING_INDEX(emp_name, ' ', -1) AS last_name
FROM string_sample;

SELECT emp_name,
	   SUBSTRING(emp_name, 1, LOCATE(' ', emp_name) - 1) AS first_name,
	   SUBSTRING(emp_name, LOCATE(' ', emp_name) + 1) AS last_name
FROM string_sample;   

/* -- UPPER / LOWER --  */
SELECT UPPER(name) FROM rooms;
SELECT LOWER(name) FROM rooms;

/* -- LEFT(string, number_of_characters) --  */ 
-- > returns specified number of characters from the beginning of the string
USE ap;
SELECT vendor_contact_first_name, vendor_contact_last_name,
       CONCAT(LEFT(vendor_contact_first_name, 1), 
              LEFT(vendor_contact_last_name, 1)) AS initials
FROM vendors;

SELECT LEFT('mysql', 3);

/* -- RIGHT(string, number_of_characters) --  */
-- > returns specified number of characters from the end of the string
USE ap;
SELECT vendor_contact_first_name, vendor_contact_last_name,
       CONCAT(RIGHT(vendor_contact_first_name, 1), 
              RIGHT(vendor_contact_last_name, 1)) AS initials
FROM vendors;

SELECT RIGHT('mysql', 3);

SELECT RIGHT('(222) 000-1212', 13);

/* -- REPLACE(search, find, replace) --  */
SELECT REPLACE(RIGHT('(222) 000-1212', 13),') ', '-');

/* -- INSERT(string, search, length, insert) --  */
SELECT INSERT('mysql', 1, 0, "jin's ");
SELECT INSERT('mysql', 1, 0, 'jin''s ');

/* -- LOCATE(value, target) --  */
-- > returns index(1 based) of first match
SELECT LOCATE('sql', ' mysql');

SELECT LOCATE('-', ' my my---sql');

-- to find a character
SELECT emp_name,
	   LOCATE(' ', emp_name) AS first_name,
	   LOCATE(' ', emp_name, LOCATE(' ', emp_name) + 1) AS second_space
FROM string_sample;

/* -- REVERSE(string) --  */
-- > returns characters in reverse order
SELECT REVERSE(' my my---sql');

/* -- LPAD(string, length, pad) --  */
-- > left pad
SELECT LPAD('mysql', 13, '*');
SELECT LPAD('mysql', 3, '*');  -- pad leng it shorter than the word -> truncated

/* -- RPAD(string, length, pad) --  */
-- > right pad
SELECT RPAD('mysql', 13, '*');

/* -- RTRIM(string) --  */
-- > trim right
SELECT RTRIM('    mysql    ');

/* -- LTRIM(string) --  */
-- > trim left
SELECT LTRIM('    mysql    ');

/* -- TRIM(string) --  */
-- > trim both ends
SELECT TRIM('    mysql    ');

/* -- SPACE(count) --  */
-- > returns space character repeated count times

/* -- REPEAT(string, count) --  */
-- > repeated count times

/* -- FORMAT(number, decimal:optional) -> converts number to a character string(000,000,...) --  */
SELECT FORMAT(121231441.43232, 2) AS format;

-- CHAR(val 1, val 2, ..) -> to binary string
-- - CHAR(9) -> tab
-- - CHAR(10) -> line feed
-- - CHAR(13) -> carriage return
SELECT CONCAT(vendor_name, CHAR(13, 10), vendor_address1, CHAR(13, 10),
	   vendor_city, ', ', vendor_state, ' ', vendor_zip_code) AS char_
FROM vendors
WHERE vendor_id = 1;

SELECT invoice_date,
	   CAST(invoice_date AS DATETIME),
	   CAST(invoice_date AS CHAR(7))       
FROM invoices;

/*================ DATE ================*/
/* -- DATE -- */
SELECT DATE(start_time) FROM screenings;

/* -- MONTH -- */
SELECT MONTH(start_time) FROM screenings;

/* -- YEAR -- */
SELECT YEAR(start_time) FROM screenings;

/* -- DATE_FORMAT(date, '%m/%d/%y') -- */
SELECT DATE_FORMAT(CURRENT_DATE, '%m/%d/%y') AS 'MM/DD/YY',
       DATE_FORMAT(CURRENT_DATE, '%e-%b-%Y') AS 'DD-Mon-YYYY';

SELECT invoice_date,
       DATE_FORMAT(invoice_date, '%m/%d/%y') AS 'MM/DD/YY',
       DATE_FORMAT(invoice_date, '%e-%b-%Y') AS 'DD-Mon-YYYY'
FROM invoices
ORDER BY invoice_date;

/*================ NUMERIC ================*/
/* -- ROUND(number, [length]) --  */
-- > rounds up
SELECT 12345.6789 AS value,
       ROUND(12345.67) AS nearest_dollar,       
       ROUND(12345.67, -1) AS left_side_rounded,
       ROUND(12345.67, 1) AS nearest_dime;
       
SELECT invoice_date, invoice_total,
       ROUND(invoice_total) AS nearest_dollar,
       ROUND(invoice_total, 1) AS nearest_dime
FROM invoices
ORDER BY invoice_date;

/* -- TRUNCATE(number, [length]) --  */
-- > cuts out


/* -- CEILING(number) --  */
/* -- FLOOR(number) --  */
/* -- ABS(number) --  */
-- > absolute value

/* -- SIGN(number) --  */
-- > -1: negative / 1: positive / 0: zero

/* -- SQRT(number) --  */
-- > square root

/* -- POWER(number, power) --  */
/* -- RAND([integer]) --  */
-- > random

/* -- SUM --  */
SELECT COUNT(*) AS number_of_invoices,
    SUM(invoice_total - payment_total - credit_total) AS total_due
FROM invoices
WHERE vendor_id = 34;


