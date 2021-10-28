/* Summary query */
-- AVG, SUM -> must result in numeric value
-- MIN, MAX, COUNT -> result in numeric, date, or string
-- all of the aggregate function ignore null except for COUNT(*)
-- by default, duplicate values are included(use DISTINCT, to get rid of)

USE ap;

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

USE cinema_booking;

SELECT * FROM customers;

SELECT count(first_name) FROM customers;  -- dosen't include null

SELECT SUM(no_seats) FROM rooms;

SELECT MAX(length_min) FROM films;

SELECT MIN(length_min) FROM films;

SELECT name, MIN(length_min) FROM films; -- this throws an error(as the number of name and min values dosen't match)  -> use group by to solve this

SELECT AVG(length_min) FROM films;

-- 1. How many bookings did customer id 10 make in October 2017.
SELECT COUNT(*) FROM bookings
WHERE customer_id = 10;

-- 2. Count the number of screenings for Blade Runner 2049 in October 2017. 
SELECT COUNT(*) FROM screenings s
JOIN films f ON s.film_id = f.id 
WHERE f.name = 'Blade Runner 2049';

-- 3. Count the number of unique customers who made a booking for October 2017.
SELECT COUNT(DISTINCT(customer_id)) FROM bookings;

SELECT * FROM bookings;
SELECT customer_id, screening_id, count(id) FROM bookings
GROUP BY customer_id, screening_id;

SELECT f.name, s.start_time, c.first_name, c.last_name, count(b.id) FROM films f 
JOIN screenings s ON f.id = s.film_id
JOIN bookings b ON s.id = b.screening_id
JOIN customers c ON c.id = b.customer_id
GROUP BY f.name, s.start_time, c.first_name, c.last_name;

SELECT customer_id, screening_id, COUNT(id) FROM bookings
GROUP BY customer_id, screening_id
HAVING customer_id = 10;

-- 1. Select the customer id and count the number of reserved seats grouped by customer for 
-- October 2017. 

SELECT b.customer_id, COUNT(rs.id) FROM bookings b 
JOIN reserved_seat rs ON b.id = rs.booking_id
GROUP BY b.customer_id;

-- 2. Select the film name and count the number of screenings for each film that is over
-- 2 hours long.

SELECT f.name, f.length_min, COUNT(s.id) FROM films f
JOIN screenings s ON f.id = s.film_id 
GROUP BY f.name, f.length_min
HAVING f.length_min > 120;

/*================= GROUP BY =================*/
-- if two or more GROUP BY clauses are use, they form hierarchical order(becomes subordibate)
-- MySQL 8.0.13 or later doesn't do default sorting
SELECT vendor_id, ROUND(AVG(invoice_total), 2)
FROM invoices; -- total

SELECT vendor_id, ROUND(AVG(invoice_total), 2)
FROM invoices
GROUP BY vendor_id; -- groups by id

SELECT vendor_id, ROUND(AVG(invoice_total), 2)
FROM invoices
GROUP BY vendor_id
HAVING AVG(invoice_total) > 2000; -- adding condition

SELECT vendor_state, vendor_city, COUNT(*),
	ROUND(AVG(invoice_total), 2)
FROM invoices i
JOIN vendors v ON i.vendor_id = v.vendor_id
GROUP BY vendor_state, vendor_city
HAVING COUNT(*) > 2;

-- WHERE VS HAVING
-- - WHERE -> come before GROUP BY
-- -- can refer to any column
-- -- cannot contain aggregate functions

-- - HAVING -> come after GROUP BY
-- -- only refer to a column in the SELECT clause
-- -- can contain aggregate functions

SELECT vendor_state, vendor_city, COUNT(*),
	ROUND(AVG(invoice_total), 2)
FROM invoices i
JOIN vendors v ON i.vendor_id = v.vendor_id
GROUP BY vendor_name
HAVING AVG(invoice_total) > 500;

SELECT vendor_state, vendor_city, COUNT(*),
	ROUND(AVG(invoice_total), 2)
FROM invoices i
JOIN vendors v ON i.vendor_id = v.vendor_id
WHERE invoice_total > 500
GROUP BY vendor_name;

-- WITH ROLLUP
-- - summary at the end
-- - summarizes each group specified in GROUP BY(group subtotal and entire total at the end)
-- -- summary rows have null so to get rid of null use IF(GROUNPING)
-- - MySQL 8.0.13 or later can use DISTINCT and ORDER BY
SELECT vendor_id,
	COUNT(*),
    SUM(invoice_total)
FROM invoices
GROUP BY vendor_id WITH ROLLUP
ORDER BY 1;

-- GROUPING
-- - used with 'WITH ROLLUP' to get rid of null values
-- - returns 1 if the expression is null. Otherwise, it returns 0
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

SELECT IF(GROUPING(invoice_date) = 1, 'Grand totals', invoice_date) AS invoice_date,
	IF(GROUPING(payment_date) = 1, 'Invoice date totals', payment_date) AS payment_date,
    SUM(invoice_total) AS invoice_total,
    SUM(invoice_total - credit_total - payment_total) AS balance_due
FROM invoices
WHERE invoice_date BETWEEN '2018-07-24' AND '2018-07-31'
GROUP BY invoice_date, payment_date WITH ROLLUP
HAVING GROUPING(invoice_date) = 1 OR GROUPING(payment_date) = 1;

/*================= OVER(window function) =================*/
-- not collapsed to a single row
-- (unlike aggragate functions that use GROUP BY, the groups, or partitions)
SELECT vendor_id, invoice_date, invoice_total,
	SUM(invoice_total) OVER() AS total_invoices, 
    -- OVER(): entire result set is treated as a single partition
    SUM(invoice_total) OVER(PARTITION BY vendor_id 
    -- aggregation is performed on each partition
		ORDER BY invoice_total) AS vendor_total 
        -- ORDER BY: values with in each partition are sorted and from one row to the next are cumulative
FROM invoices
WHERE invoice_total > 5000;

-- FRAMES 
-- - relative to the current row(it can move within a partition as the current row changes)
-- - can be defined as the number of rows before and after the current row(ROWS) or
-- - can be defined as a range of values based on the value of the current row(RANGE)
-- - if and ORDER BY clause is used, I have to use 'ROWS' keyword -> values are accumulated up until the current row
-- - if only starting row is specified then the ending row is the current row
-- - to specify both start and ending row use 'BETWEEN' keyword
-- - syntex
-- -- {ROWS | RANGE} {frame_start | BETWEEN frame_start AND frame_end}
-- - values for frame_start and frame_end
-- -- CURRENT ROW: the frame starts of ends with the current row
-- -- UNBOUNDED PRECEDING: the frame starts of ends with the first row in the partition
-- -- UNBOUNDED FOLLOWING: the frame starts of ends with the last row in the partition
-- -- expr PRECEDING: 
-- -- -- with 'ROWS': starts expr rows before the current row
-- -- -- with 'RANGE': starts expr rows before the current row whose value is expr less than the value of the current row
-- -- expr FOLLOWING: 
-- -- -- with 'ROWS': starts expr rows after the current row
-- -- -- with 'RANGE': starts expr rows after the current row whose value is expr greater than the value of the current row

SELECT vendor_id, invoice_date, invoice_total,
	SUM(invoice_total) OVER() AS total_invoices,
    SUM(invoice_total) OVER(PARTITION BY vendor_id 
		ORDER BY invoice_date 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS vendor_total
FROM invoices
WHERE invoice_date BETWEEN '2018-04-01' AND '2018-04-30';

SELECT MONTH(invoice_date) AS month, SUM(invoice_total) AS total_invoices,
       ROUND(AVG(SUM(invoice_total)) OVER(ORDER BY MONTH(invoice_date)
           RANGE BETWEEN 3 PRECEDING AND CURRENT ROW), 2) AS 4_month_avg
FROM invoices
GROUP BY MONTH(invoice_date);

-- - with 'WINDOW' KEYWORD
-- -- used to define a named window
-- -- should come after the HAVING and before the ORDER BY
-- -- to use a named window, code it on the OVER clause
SELECT vendor_id, invoice_date, invoice_total,
       SUM(invoice_total) OVER vendor_window AS vendor_total,
       ROUND(AVG(invoice_total) OVER vendor_window, 2) AS vendor_avg,
       MAX(invoice_total) OVER vendor_window AS vendor_max,
       MIN(invoice_total) OVER vendor_window AS vendor_min
FROM invoices
WHERE invoice_total > 5000
WINDOW vendor_window AS (PARTITION BY vendor_id);
