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

/* -- TRUNCATE(number, length) --  */
-- > cuts out
SELECT 12345.6789 AS value,
       TRUNCATE(12345.67, 0) AS nearest_dollar,              
       TRUNCATE(12345.67, 1) AS nearest_dime;

/* -- CEILING(number) --  */
SELECT 12345.6789 AS value,       
       CEILING(12345.67) AS nearest_dime;

/* -- FLOOR(number) --  */
SELECT 12345.6789 AS value,       
       FLOOR(12345.67) AS nearest_dime;
       
/* -- ABS(number) --  */
-- > absolute value
SELECT 12345.6789 AS value,       
       ABS(-12345.67) AS nearest_dime;
       
/* -- SIGN(number) --  */
-- > -1: negative / 1: positive / 0: zero
SELECT 12345.6789 AS value,
       SIGN(12345.67) AS positive,       
       SIGN(-12345.67) AS negative,
       SIGN(0) AS zero;

/* -- SQRT(number) --  */
-- > square root
SELECT 125.43 AS value,		       
       SQRT(125.43) AS square_root;

/* -- POWER(number, power) --  */
SELECT 9 AS value,		       
       POWER(9, 2) AS square_root;
       
/* -- RAND([integer]) --  */
-- > random
SELECT RAND() AS without_seed,
	   RAND(10) AS with_seed; -- same number every time

/* -- SUM --  */
SELECT COUNT(*) AS number_of_invoices,
    SUM(invoice_total - payment_total - credit_total) AS total_due
FROM invoices
WHERE vendor_id = 34;

-- floating point(e.g. DOUBLE, FLOAT) example
USE ex;
SELECT * FROM float_sample;

SELECT * FROM float_sample
WHERE float_value = 1;  -- only returns the exact same match

SELECT * FROM float_sample
WHERE float_value BETWEEN 0.9 AND 1.1;  -- getting approximate values

SELECT * FROM float_sample
WHERE ROUND(float_value, 2) = 1;  -- getting approximate values

/*================ DATE ================*/
/* -- NOW -- */
-- returns the current local date and time based on the system's clock
SELECT NOW();

/* -- SYSDATE -- */
-- returns the current local date and time based on the system's clock
SELECT SYSDATE();

/* -- CURRENT_TIMESTAMP -- */
-- returns the current local date and time based on the system's clock
SELECT CURRENT_TIMESTAMP();

SELECT CURRENT_TIMESTAMP;

/* -- CURDATE -- */
-- returns the current local date
SELECT CURDATE();

/* -- CURRENT_DATE -- */
-- returns the current local date
SELECT CURRENT_DATE();

SELECT CURRENT_DATE;

/* -- CURTIME -- */
-- returns the current local time
SELECT CURTIME();

/* -- CURRENT_TIME -- */
-- returns the current local time
SELECT CURRENT_TIME();

SELECT CURRENT_TIME;

/* -- UTC_DATE -- */
-- returns the current date in GMT(Greenwich Mean Time)
SELECT UTC_DATE();

SELECT UTC_DATE;

/* -- UTC_TIME -- */
-- returns the current time in GMT(Greenwich Mean Time)
SELECT UTC_TIME();

SELECT UTC_TIME;

/*----------------- DATE / TIME PARSING -----------------*/
/* -- DATE -- */
USE ap;
SELECT DATE(invoice_date) FROM invoices;

/* -- MONTH -- */
SELECT MONTH(invoice_date) FROM invoices;

/* -- DAYOFMONTH -- */
SELECT DAYOFMONTH(invoice_date) FROM invoices;

/* -- YEAR -- */
SELECT YEAR(invoice_date) FROM invoices;

/* -- HOUR -- */
SELECT HOUR(SYSDATE());

/* -- MINUTE -- */
SELECT MINUTE(SYSDATE());

/* -- SECOND -- */
SELECT SECOND(SYSDATE());

/* -- DAYOFWEEK -- */
-- returns day of week as an integer(sun: 1, ...)
SELECT DAYOFWEEK(SYSDATE());

/* -- QUARTER -- */
-- returns the quarter of the year as an integer
SELECT QUARTER(SYSDATE());

/* -- DAYOFYEAR -- */
SELECT DAYOFYEAR(SYSDATE());

/* -- WEEK(date,[1: week starts on Mon / 0: week starts on Sun]) -- */
-- returns the week of the year as an integer
SELECT WEEK(SYSDATE()) AS without_second_parameter,
	   WEEK(SYSDATE(), 0) AS week_start_Sun,
       WEEK(SYSDATE(), 1) AS week_start_Mon
FROM invoices;

/* -- LAST_DAY -- */
SELECT LAST_DAY(SYSDATE()),
	   LAST_DAY('2020-12-03');

/* -- DAYNAME -- */
SELECT DAYNAME(SYSDATE());

/* -- MONTHNAME -- */
SELECT MONTHNAME(SYSDATE());

/* -- DATE_FORMAT / TIME_FORMAT -- */
-- data / tiem format string
-- - %m -> month numeric(01, 02, ...)
-- - %c -> month numeric(1, 2, ...)
-- - %M -> month name(January, ...)
-- - %b -> abbreviated month name(Jan, ...)
-- - %d -> day numeric(01, 02, ...)
-- - %e -> day numeric(1, 2, ...)
-- - %D -> day with suffix(1st, 2nd, ...)
-- - %y -> year numeric two digit
-- - %Y -> year numeric four digit
-- - %W -> week name(Sunday, ...)
-- - %a -> abbreviated week name(Sun, ...)
-- - %H -> hour(01, ..., 23)
-- - %k -> hour(1, ..., 23)
-- - %h -> hour(01, ..., 12)
-- - %l -> hour(1, ..., 12)
-- - %i -> minute(01, ..., 59)
-- - %r -> time 12-hour(hh:mm:ss AM or PM)
-- - %T -> time 24-hour(hh:mm:ss)
-- - %S -> second(01, ..., 59)
-- - %p -> AM or PM

-- DATE_FORMAT(date, format)
SELECT DATE_FORMAT(CURRENT_DATE, '%m/%d/%y') AS 'MM/DD/YY',
       DATE_FORMAT(CURRENT_DATE, '%e-%b-%Y') AS 'DD-Mon-YYYY';

SELECT invoice_date,
       DATE_FORMAT(invoice_date, '%m/%d/%y') AS 'MM/DD/YY',
       DATE_FORMAT(invoice_date, '%e-%b-%Y') AS 'DD-Mon-YYYY'
FROM invoices
ORDER BY invoice_date;

SELECT DATE_FORMAT('2020-12-11', '%m/%d/%y');
SELECT DATE_FORMAT('2020-12-11', '%m/%d/%y');
SELECT DATE_FORMAT('2020-12-11', '%W/%M/%D, %Y');
SELECT DATE_FORMAT('2020-12-11', '%e-%b-%y');
SELECT DATE_FORMAT('2020-12-11', '%r');
SELECT DATE_FORMAT('2020-12-11 16:23', '%r');
SELECT TIME_FORMAT('16:23', '%r');
SELECT TIME_FORMAT('16:23', '%l:%i %p');

-- TIME_FORMAT(time, format) --
SELECT TIME_FORMAT(TIME(SYSDATE()), '%m');

/* -- EXTRACT(unit FROM date) -- */
-- parsing
SELECT EXTRACT(SECOND FROM SYSDATE());
SELECT EXTRACT(MINUTE FROM SYSDATE());
SELECT EXTRACT(HOUR FROM SYSDATE());
SELECT EXTRACT(DAY FROM SYSDATE());
SELECT EXTRACT(MONTH FROM SYSDATE());
SELECT EXTRACT(YEAR FROM SYSDATE());
SELECT EXTRACT(MINUTE_SECOND FROM SYSDATE());  -- minutes and seconds
SELECT EXTRACT(HOUR_MINUTE FROM SYSDATE());  -- hour and minutes
SELECT EXTRACT(DAY_HOUR FROM SYSDATE());  -- day and hours
SELECT EXTRACT(YEAR_MONTH FROM SYSDATE());  -- year and month
SELECT EXTRACT(HOUR_SECOND FROM SYSDATE());  -- hours, minutes, and seconds
SELECT EXTRACT(DAY_MINUTE FROM SYSDATE());  -- day, hours, and minutes
SELECT EXTRACT(DAY_SECOND FROM SYSDATE());  -- day, hours, minutes, and seconds

/* -- DATE_ADD(date, INTERVAL expression unit) -- */
SELECT DATE_ADD('2020-12-31', INTERVAL 1 DAY);
SELECT DATE_ADD('2020-12-31', INTERVAL 1 MONTH);
SELECT DATE_ADD('2020-12-31 23:59:59', INTERVAL 1 SECOND);
SELECT DATE_ADD('2020-12-31', INTERVAL -1 DAY);  -- negative in ADD: sub
SELECT DATE_ADD('2020-12-31', INTERVAL 1 YEAR);
SELECT DATE_ADD('2020-2-29', INTERVAL 1 YEAR); 
SELECT DATE_ADD('2019-2-29', INTERVAL 1 YEAR);


/* -- DATE_SUB(date, INTERVAL expression unit) -- */
SELECT DATE_SUB('2020-12-31', INTERVAL 1 DAY);
SELECT DATE_SUB('2020-12-31', INTERVAL -1 DAY);  -- negative in SUB: add

/* -- DATEDIFF(date1, date2) -- */
SELECT DATEDIFF('2020-12-31', '2021-12-31');

/* -- TO_DAYS(date) -- */
-- - since year 0(not reliable for dates before 1582
SELECT TO_DAYS('2021-12-31');
SELECT TO_DAYS('2021-12-30') - TO_DAYS('2021-12-31');

/* -- TIME_TO_SEC(time) -- */
-- - seconds elapsed since midnight
SELECT TIME_TO_SEC('12:31');
SELECT TIME_TO_SEC('12:31') - TIME_TO_SEC('12:30');

/* -- date / time searching technic -- */
USE ex;
SELECT * FROM date_sample;

-- ignoring time values
SELECT * FROM date_sample
WHERE start_date >= '2018-02-28' AND start_date < '2018-03-01';

SELECT * FROM date_sample
WHERE MONTH(start_date) = 2 AND
	  DAYOFMONTH(start_date) = 28 AND
      YEAR(start_date) = 2018;
      
SELECT * FROM date_sample
WHERE DATE_FORMAT(start_date, '%m-%d-%Y') = '02-28-2018';

SELECT * FROM date_sample
WHERE DATE_FORMAT(start_date, '%T') = '10:00:00';

SELECT * FROM date_sample
WHERE EXTRACT(HOUR_SECOND FROM start_date) = 100000;

SELECT * FROM date_sample WHERE HOUR(start_date) = 9;

SELECT * FROM date_sample
WHERE EXTRACT(HOUR_MINUTE FROM start_date) BETWEEN 900 AND 1200;

/*================ CASE ================*/
USE ap;
-- simple case: tests the expression in the CASE against the expression in the WHEN
SELECT invoice_number, terms_id,
	CASE terms_id
		WHEN 1 THEN 'due 10 days'
		WHEN 2 THEN 'due 20 days'
		WHEN 3 THEN 'due 30 days'
		WHEN 4 THEN 'due 40 days'
		WHEN 5 THEN 'due 50 days'
	END AS terms    
FROM invoices;

-- searched case: tests the expression in each WHEN
SELECT invoice_number, invoice_total, invoice_date, invoice_due_date,
	CASE
		WHEN DATEDIFF(NOW(), invoice_due_date) > 30
			THEN 'over 30 days past due'
		WHEN DATEDIFF(NOW(), invoice_due_date) > 0
			THEN '1 to 30 days past due'
		ELSE 'current'
	END AS invoice_status
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0;

/*================ IF ================*/
SELECT vendor_name,
	IF(vendor_city = 'Fresno', 'y', 'n') AS is_city_fresno
FROM vendors;

/*================ IFNULL ================*/
-- if null, use value provided instead of showing null
SELECT payment_date,
	IFNULL(payment_date, 'no pay') AS new_date
FROM invoices;

/*================ COALESCE ================*/
-- similar to IFNULL
SELECT payment_date,
	   COALESCE(payment_date, 'no pay') AS new_date
FROM invoices;

/*================ REGULAR EXPRESSION ================*/
-- case insensitive by default
/*
^ : begining
$ : end
. : single character
[] : any single character listed in the bracket
[char1 - char2] :any single character within the given range
| : or
* : zero of more
(charlist)* : zero or more occurrences of the sequence of characters in parentheses
*/
/* -- REGEXP_LIKE(expr, pattern) -- */
SELECT REGEXP_LIKE('abc123', '123');
SELECT REGEXP_LIKE('abc123', '^123');

/* -- REGEXP_INSTR(expr, pattern, [start]) -- */
-- returns the index of the first character of the substring that matches pattern
-- returns 0 in not found
SELECT REGEXP_INSTR('abc123', '123');

SELECT DISTINCT vendor_city, REGEXP_INSTR(vendor_city, ' ') AS space_index
FROM vendors
WHERE REGEXP_INSTR(vendor_city, ' ') > 0;

/* -- REGEXP_SUBSTR(expr, pattern, [start]) -- */
-- returns the first substring that matches pattern
-- returns NULL in not found
SELECT REGEXP_SUBSTR('abc123', '[A-Z][1-9]*$');

SELECT vendor_city, REGEXP_SUBSTR(vendor_city, '^SAN|LOS') AS city_match
FROM vendors
WHERE REGEXP_SUBSTR(vendor_city, '^SAN|LOS') IS NOT NULL;

/* -- REGEXP_REPLACE(expr, pattern, replace, [start]) -- */
-- replace everything that matches the pattern
SELECT REGEXP_REPLACE('abc123', '1|2','3');

SELECT vendor_name, vendor_address1,
	   REGEXP_REPLACE(vendor_address1, 'STREET', 'St') AS new_address1
FROM vendors
WHERE REGEXP_LIKE(vendor_address1, 'STREET');

