/*
1.	SELECT four columns from the Products table: 
product_code, product_name, list_price, and discount_percent. 
sort the result set by list price in descending sequence. 
*/

SELECT product_code, product_name, list_price, discount_percent 
FROM products
ORDER BY list_price DESC;

SELECT vendor_name, vendor_contact_last_name, vendor_contact_first_name
FROM vendors
ORDER BY vendor_contact_last_name, vendor_contact_first_name;

/*
2.	SELECT one column from the Customers table named full_name 
that joins the last_name and first_name columns.
Format this column like this: Doe, John
Sort the result set by last name in ascending sequence.
Return only the customers whose last name begins with letters from M to Z.
NOTE: When comparing strings of characters, ‘M’ comes before any string of characters that begins with ‘M’. For example, ‘M’ comes before ‘Murach’.
*/

SELECT CONCAT(last_name, ', ', first_name) AS 'full_name' 
FROM customers
WHERE last_name BETWEEN 'M%' AND 'Z%' 
	OR last_name LIKE 'Z%'
ORDER BY last_name ASC;

SELECT CONCAT(last_name, ', ', first_name) AS full_name,
	   substr(last_name, 1, 1)
FROM customers 
WHERE substr(last_name, 1, 1) BETWEEN 'm' AND 'z'
ORDER BY last_name;

SELECT CONCAT(vendor_contact_last_name, ', ', vendor_contact_first_name) AS full_name
FROM vendors
WHERE vendor_contact_last_name < 'D' OR vendor_contact_last_name LIKE 'E%'
ORDER BY vendor_contact_last_name, vendor_contact_first_name;

/*
3.	SELECT these columns from the Products table:
product_name	The product_name column
list_price	The list_price column
date_added	The date_added column
Return only the rows with a list price that’s greater than 500 and less than 2000.
Sort the result set in descending sequence by the date_added column.
*/
SELECT product_name, list_price, date_added 
FROM products
WHERE list_price > 500 and list_price < 2000
ORDER BY date_added DESC;

SELECT invoice_due_date AS "Due Date", 
       invoice_total AS "Invoice Total", 
       invoice_total / 10 AS "10%",
       invoice_total * 1.1 AS "Plus 10%"
FROM invoices
WHERE invoice_total >= 500 AND invoice_total <= 1000
ORDER BY invoice_due_date DESC;

/*
4.	SELECT these column names and data from the Products table:
product_name	The product_name column
list_price	The list_price column
discount_percent	The discount_percent column
discount_amount	A column that’s calculated from the previous two columns
discount_price	A column that’s calculated from the previous three columns
Round the discount_amount and discount_price columns to 2 decimal places.
Sort the result set by discount price in descending sequence.
Use the LIMIT clause so the result set contains only the first 5 rows.
*/
SELECT product_name, list_price, discount_percent,
    ROUND(list_price * (discount_percent / 100), 2) AS "discount_amount",
    ROUND(list_price - (list_price * (discount_percent / 100)), 2) AS "discount_price"
FROM products
ORDER BY 5 DESC
LIMIT 5;

SELECT invoice_number,
       invoice_total,
       payment_total + credit_total AS payment_credit_total,
       invoice_total - payment_total - credit_total AS balance_due
FROM invoices
WHERE invoice_total - payment_total - credit_total > 50
ORDER BY balance_due DESC
LIMIT 5;

/*
5.	SELECT these column names and data from the Order_Items table:
item_id	The item_id column
item_price	The item_price column
discount_amount	The discount_amount column
quantity	The quantity column
price_total	A column that’s calculated by multiplying the item price by the quantity
discount_total	A column that’s calculated by multiplying the discount amount by the quantity
item_total	A column that’s calculated by subtracting the discount amount from the item price and then multiplying by the quantity
Only return rows where the item_total is greater than 500.
Sort the result set by item total in descending sequence.
*/
SELECT item_id, item_price, discount_amount, quantity, 
	item_price * quantity AS "price_total",
    discount_amount * quantity AS "discount_total",
    (item_price - discount_amount) * quantity AS "item_total"
FROM order_items
WHERE (item_price - discount_amount) * quantity > 500
ORDER BY (item_price - discount_amount) * quantity DESC;

SELECT invoice_number, 
       invoice_date, 
       invoice_total - payment_total - credit_total AS balance_due,
       payment_date
FROM invoices
WHERE payment_date IS NULL;

/*
6.	Write a SELECT statement that returns these columns from the Orders table:
order_id	The order_id column
order_date	The order_date column
ship_date	The ship_date column
Return only the rows where the ship_date column contains a null value.
*/
SELECT order_id, order_date, ship_date 
FROM orders
WHERE ship_date IS NULL;

/*
7.	Write a SELECT statement without a FROM clause that uses the NOW function to create a row with these columns:
today_unformatted	The NOW function unformatted
today_formatted	The NOW function in this format: 
DD-Mon-YYYY
This displays a number for the day, an abbreviation for the month, and a four-digit year.
*/
SELECT  NOW() AS today_unformatted,
	DATE_FORMAT(NOW(), '%d-%b-%Y') AS today_formatted;
    
SELECT DATE_FORMAT(CURRENT_DATE, '%m-%d-%Y') AS "current_date";

/*
8.	Write a SELECT statement without a FROM clause that creates a row with these columns:
price	100 (dollars)
tax_rate	.07 (7 percent)
tax_amount	The price multiplied by the tax
total	The price plus the tax
To calculate the fourth column, add the expressions you used for the first and third columns.
*/
SELECT 100 AS price, 0.07 AS tex_rate,
	100 * 0.07 AS tax_amount,
    100 + (100 * 0.07) AS total;

SELECT 50000 AS starting_principle,
       50000 * .065 AS interest,
       (50000) + (50000 * .065) AS principle_plus_interest;
       
/*
2-1
SELECT that joins the Categories table to the Products table and 
returns these columns: 
category_name, 
product_name, 
list_price.
Sort by category_name and then by product_name in ascending 
*/ 
SELECT category_name, 
	   product_name, 
	   list_price
FROM categories
	JOIN products USING(category_id)
ORDER BY category_name ASC, product_name ASC;

/*
2-2
SELECT that joins the Customers table to the Addresses table and 
returns these columns: 
first_name, 
last_name, 
line1, 
city, 
state, 
zip_code.
Return one row for each address for the customer 
with an email address of 
allan.sherwood@yahoo.com.
*/
SELECT first_name, 
	   last_name, 
	   line1, 
	   city, 
	   state, 
	   zip_code
FROM customers
	JOIN addresses USING(customer_id)
WHERE email_address = 'allan.sherwood@yahoo.com';

/*
2-3
SELECT joins the Customers table to the Addresses table and 
returns these columns: 
first_name, 
last_name, 
line1, 
city, 
state, 
zip_code.
Return one row for each customer, but only return addresses that are the shipping 
address for a customer
*/   
-- need check 
SELECT first_name, 
	   last_name, 
	   line1, 
	   city, 
	   state, 
	   zip_code,
       shipping_address_id
FROM customers
	JOIN addresses USING(customer_id);

/*
2-4
SELECT joins 
Customers, Orders, Order_Items, and Products tables. 
return these columns: 
last_name, 
first_name, 
order_date, 
product_name, 
item_price, 
discount_amount, 
quantity.
Use aliases for the tables.
Sort by last_name, order_date, and product_name
*/   
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

/*
2-5
SELECT the product_name and list_price columns 
from the Products table.
Return one row for each product that has the same list price as another product.
Hint: Use a self-join to check that the product_id columns aren’t equal but the 
list_price columns are equal.
Sort the result set by product_name.
*/
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

/*
2-6
SELECT these two columns: 
category_name from the Categories 
product_id from the Products table
Return one row for each category that has never been used. Hint: Use an outer join 
and only return rows where the product_id column contains a null value
*/
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

/*
2-7
UNION to generate a result set consisting of three columns 
from the Orders table: 
ship_status A calculated column that contains a value of SHIPPED or NOT SHIPPED
order_id The order_id column
order_date The order_date column
If the order has a value in the ship_date column, the ship_status column should 
contain a value of SHIPPED. Otherwise, it should contain a value of NOT SHIPPED.
Sort by order_date
*/
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
WHERE ship_date IS NULL
ORDER BY order_date;

SELECT vendor_name, vendor_state
  FROM vendors
  WHERE vendor_state = 'CA'
UNION
  SELECT vendor_name, 'Outside CA'
  FROM vendors
  WHERE vendor_state <> 'CA'
ORDER BY vendor_name;
SELECT * FROM vendors;

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

-- 3
USE swexpert;
SHOW TABLES;
SELECT * FROM consultant;
/*
 Add a new record as follows:
c_id: 106 
c_last: (Your last name) 
c_first: (Your first name) 
c_mi: (Your middle initial) 
c_add: (Your fake address) 
c_city: (Your fake city) 
c_state: (Your fake province code) 
c_zip: (Your fake postal code) 
c_phone: (Your fake phone) 
c_email: (Your fake email)
*/

INSERT INTO consultant(
			c_id, c_last, c_first, c_mi,
            c_add, c_city, c_state, c_zip,
			c_phone, c_email)
       VALUES(
			106, "Baek", "Kwangjin", "K",
            "1234 Broadway", "Hermagor", "AA", "12345",
            "1234567890", "gogo@go.com");
            
-- 4
SELECT * FROM client;
/*
new client. Add a new record as follows: 
client_id: 17 
client_name: City of Waterloo 
contact_last: Jaworsky 
contact_first: Dave 
contact_phone: 519 886 1550 
*/
INSERT INTO client(
			client_id, client_name, contact_last,
            contact_first, contact_phone)
       VALUES(
			17, "City of Waterloo", "Jaworsky",
            "Dave", "519 886 1550");

-- 5
SELECT * FROM project;
SELECT * FROM client;
SELECT * FROM consultant;
/*
a new project for the client Dave Jaworsky(id: 17) 
Add a new project named 'ION Rapid Transit' with a project ID of 
88. The parent project of 'ION Rapid Transit' project is unassigned.
*/
INSERT INTO project(
			p_id, project_name, client_id,
            mgr_id, parent_p_id)
       VALUES(
			88, "ION Rapid Transit", 17,
            106, NULL);
            
-- 6 
SELECT * FROM project;
SELECT * FROM client;
SELECT * FROM consultant;
/*
 Write an UPDATE statement that modifies the parent project of Project table. Assign 
all projects without a parent project to the newly added project. The parent project of 
'ION Rapid Transit' project must remain unassigned. 
*/
UPDATE project SET parent_p_id = 88
WHERE parent_p_id IS NULL AND p_id <> 88;

-- midterm

/*
-- 1
Write an INSERT statement that adds this row to the color_sample table: 
Code the INSERT statement so MySQL automatically generates the color_id column. 
*/

USE ex;
INSERT INTO color_sample VALUES(DEFAULT, 783, 'Red');

/*
-- 2
Write a statement that modifies the color_sample table. Change the color_name column to "Green" for
the record you just added to the color_sample table. This statement should use the color_id column to 
identify the row. 
*/
USE ex;
UPDATE color_sample SET color_name = 'Green' WHERE color_id = 6;

/*
-- 3
Write a statement that deletes all rows in the color_sample table that does not have a value in the 
color_name column.  
*/
USE ex;
SET SQL_SAFE_UPDATES = 0;

DELETE FROM color_sample WHERE color_name IS NULL;


/*
-- 4
select result set consisting of three columns from the active_invoices table: 
• Account Status: A calculated column that contains a value of GOOD or BAD 
• Invoice Number: The invoice_number column 
• Due date: The invoice_due_date column 
• Credit Total: the credit_total column 
If the invoice has a value greater than 100 in the credit_total column, the account _status 
column should contain a value of BAD. Otherwise, it should contain a value of GOOD. 
Sort the final result set by due_date.  
*/
SELECT "BAD" AS account_status,
	   invoice_number,
	   invoice_due_date AS due_date,
       credit_total
FROM active_invoices
WHERE credit_total > 100
UNION
SELECT "Good",
	   invoice_number,
	   invoice_due_date AS due_date,
       credit_total
FROM active_invoices
WHERE credit_total <= 100
ORDER BY due_date;

/*
-- 5
Write a SELECT from the active_invoices table: 
invoice_id, 
invoice_total, 
payment_total, 
credit_total, 
due_payment (Add the invoice total to the credit total, then subtract the payment total amount). 

where the invoice_due_date after ‘2014-07-01’ included. 
Sort by due_payment in descending sequence. 
*/
SELECT invoice_id, 
	   invoice_total, 
       payment_total, 
       credit_total,
       (invoice_total + credit_total) - payment_total AS due_payment,
       invoice_due_date AS test_row
FROM active_invoices
WHERE invoice_due_date >= '2014-07-01'
ORDER BY due_payment DESC;

/*
-- 6
SELECT joins the employees table to the projects table (Use aliases for the tables)
returns these columns: 
employee ID, 
first name, 
last name, 
project number  
Return only the employees that do not have any project. 
*/
SELECT e.employee_ID,
	   e.first_name,
       e.last_name,
       p.project_number
FROM employees e
LEFT JOIN projects p USING(employee_id)
WHERE p.project_number IS NULL;

/*
-- 7
SELECT joins the order_details table to the items table(Use aliases for the tables) 
returns these columns: 
order_id, 
item_id, 
order_qty, 
title, 
artist, 
unit_price
Sort the result to display the highest unit price first. 
*/
USE om;
SELECT o.order_id, 
	   o.item_id,
       o.order_qty,
       i.title,
       i.artist,
       i.unit_price 
FROM order_details o
JOIN items i USING(item_id)
ORDER BY unit_price DESC;

SELECT * FROM order_details;
SELECT * FROM items;

SELECT * FROM employees;
SELECT * FROM projects;
SELECT * FROM active_invoices;
SELECT * FROM color_sample;
SHOW TABLES;

-- ch 7-1
SELECT DISTINCT vendor_name
FROM vendors JOIN invoices
USING(vendor_id)
ORDER BY vendor_id;

SELECT vendor_name FROM vendors
WHERE vendor_id IN (
SELECT DISTINCT vendor_id FROM invoices)
ORDER BY vendor_id;

-- ch 7-2
SELECT invoice_number, invoice_total
FROM invoices
WHERE payment_total > (
	SELECT AVG(payment_total) 
	FROM invoices
	WHERE payment_total > 0)
ORDER BY invoice_total DESC;

-- ch 7-3
SELECT account_number, account_description 
FROM general_ledger_accounts
WHERE account_number NOT IN (
	SELECT account_number FROM invoice_line_items)
ORDER BY account_number;

SELECT account_number, account_description 
FROM general_ledger_accounts g
WHERE NOT EXISTS (
	SELECT * FROM invoice_line_items
    WHERE account_number = g.account_number)
ORDER BY account_number;

SELECT account_number, account_description
FROM general_ledger_accounts
	left JOIN invoice_line_items USING(account_number)
WHERE invoice_id IS NULL
ORDER BY account_number;

-- ch 7-4
SELECT vendor_name, invoice_id, invoice_sequence, line_item_amount
FROM vendors
	JOIN invoices
		USING(vendor_id)
	JOIN invoice_line_items
		USING(invoice_id)
WHERE invoice_id IN (
			SELECT invoice_id
			FROM invoice_line_items
			WHERE invoice_sequence > 1
			)
ORDER BY vendor_name, invoice_id, invoice_sequence;

-- ch 7-5 
SELECT SUM(max_of_invoices) 
FROM (SELECT MAX(invoice_total) AS max_of_invoices
	FROM invoices 
	WHERE payment_date IS NULL 
	GROUP BY vendor_id) t;

SELECT SUM(invoice_max) AS sum_of_maximums
FROM (SELECT vendor_id, MAX(invoice_total) AS invoice_max
      FROM invoices
      WHERE invoice_total - credit_total - payment_total > 0
      GROUP BY vendor_id) t;

-- ch 7-6
SELECT vendor_name, vendor_city, vendor_state
FROM vendors
WHERE CONCAT(vendor_state, vendor_city) NOT IN 
    (SELECT CONCAT(vendor_state, vendor_city) as vendor_city_state
     FROM vendors
     GROUP BY vendor_city_state
     HAVING COUNT(*) > 1)
ORDER BY vendor_state, vendor_city;

-- ch 7-7
SELECT screening_id, customer_id,
(SELECT COUNT(seat_id)
FROM reserved_seats WHERE booking_id = b.id)
FROM bookings b;

SELECT (SELECT vendor_name
		FROM vendors WHERE vendor_id = i.vendor_id) AS vendor_name,
	   invoice_number, 
	   MIN(invoice_date), 
       invoice_total
FROM invoices i GROUP BY vendor_name ORDER BY vendor_name;

SELECT vendor_name, invoice_number, MIN(invoice_date), invoice_total
FROM vendors
	JOIN invoices USING(vendor_id) GROUP BY vendor_name ORDER BY vendor_name;

SELECT vendor_name, invoice_number,
       invoice_date, invoice_total
FROM invoices i JOIN vendors v
  ON i.vendor_id = v.vendor_id
WHERE invoice_date =
  (SELECT MIN(invoice_date)
   FROM invoices 
   WHERE vendor_id = i.vendor_id)
ORDER BY vendor_name;

-- ch 7-8
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

-- ch 7-9
WITH max_invoice AS
(
	SELECT vendor_id, MAX(invoice_total) AS invoice_max
    FROM invoices
    WHERE invoice_total - credit_total - payment_total > 0
    GROUP BY vendor_id
)
SELECT SUM(invoice_max) AS sum_of_maximums
FROM max_invoice;

-- ch 8-1
SELECT invoice_total,
	   FORMAT(invoice_total, 1),
       CONVERT(invoice_total, SIGNED),
       CAST(invoice_total AS SIGNED)
FROM invoices;

-- ch 8-2
SELECT invoice_date,
	   CAST(invoice_date AS DATETIME),
	   CAST(invoice_date AS CHAR(7))       
FROM invoices;

SELECT * FROM vendors;          
SELECT * FROM general_ledger_accounts;
SELECT * FROM invoices;

-- A_4
/*
1. SELECT that returns these columns: 
• The count of the number of orders in the Orders table 
• The sum of the tax_amount columns in the Orders table
*/
SELECT COUNT(*) AS orders_count,
	   SUM(tax_amount) AS tax_amount_sum
FROM orders;

/*
2. SELECT that returns one row for each category that has products 
with these columns: 
• The category_name column from the Categories table 
• The count of the products in the Products table 
• The list price of the most expensive product in the Products table 
Sort the category with the most products appears first. 
*/
SELECT category_name,
	   COUNT(*) AS products_count,
       MAX(list_price) AS most_expensive_product
FROM categories
	JOIN products USING(category_id)
GROUP BY category_name
ORDER BY products_count DESC;

/*
3. SELECT that answers this question: 
What is the total amount ordered for each product? Return these columns: 
• The product name from the Products table 
• The total amount for each product in the Order_Items 
(Hint: total amount: (the item price - the discount amount) * the quantity
Use WITH ROLLUP to include the grand total
*/
SELECT product_name,
       SUM((item_price - discount_amount) * quantity) AS total_amount
FROM order_items
	JOIN products USING(product_id)
GROUP BY product_id
WITH ROLLUP;

/*
4. SELECT that returns the category_name column from the Categories table. 
Return one row for each category that has never been assigned to 
any product in the Products table. To do that, use a subquery and include the NOT 
EXISTS operator as part of your solution. 
*/
SELECT category_name
FROM categories c
WHERE NOT EXISTS(
	SELECT * FROM products
    WHERE category_id = c.category_id);

/*
5. Display average evaluation score for consultant ID (EVALUATEE_ID) 105. 
Round the retrieved value to one decimal place.
*/
USE swexpert;

SELECT ROUND(AVG(score), 1) AS score_avg
FROM evaluation
WHERE evaluatee_id = 105;

/*
6. Count the number of consultants who are certified in skill ID 1. 
*/
SELECT COUNT(*) AS skill_id_1_count
FROM consultant_skill
WHERE skill_id = 1;

/*
7. List the first and last name of every consultant who has ever worked on a 
project with consultant Mark Myers. Include Mark Myers in the result set. Use a 
subquery. use the consultant's full name in your query
*/
SELECT DISTINCT c_first, c_last,
	   CONCAT(c_first, ' ', IFNULL(c_mi, ''), ' ', c_last) AS full_name
FROM consultant
	JOIN project_consultant USING(c_id)
	JOIN project USING(p_id)
WHERE p_id IN (SELECT p_id FROM project_consultant
WHERE c_id = 100);

/*
8. Use the UNION operator to generate a result set consisting of two 
columns: project ID and name. The result must include all the projects with 
completed evaluations AND projects managed by consultant with last name that 
starts with 'Z'. Use a subquery. Remove any duplicate results
*/
	SELECT p_id, project_name 
	FROM project
	WHERE p_id IN (
		SELECT p_id FROM project_consultant
		WHERE c_id = (
			SELECT c_id FROM consultant
			WHERE c_last LIKE 'Z%'))
UNION
	SELECT p_id, project_name FROM project
	WHERE p_id IN (SELECT p_id FROM evaluation);            

/*
9. ALTER TABLE statement that adds a new 'total_days' column to 
the project_consultant table. 
a. This new column should have a default value of 0 (zero). 
b. Update the new column with the difference of ROLL OFF and ROLL ON dates
c. Display all the contents of project_consultant table. Save output as output9.txt
d. Drop the 'total_days' column. 
*/
ALTER TABLE project_consultant
ADD COLUMN total_days INT DEFAULT(0);

SET SQL_SAFE_UPDATES = 0;

UPDATE project_consultant SET total_days = roll_off_date - roll_on_date;

ALTER TABLE project_consultant
DROP COLUMN total_days;

--
DESCRIBE project_consultant;
SELECT * FROM consultant;
SELECT * FROM project_consultant;
SELECT * FROM project;
SELECT * FROM evaluation;

SHOW TABLES;
SELECT *, (item_price - discount_amount) * quantity AS total_amount FROM order_items;
USE my_guitar_shop;
SHOW TABLES;

-- A_5
/*
1. Write a SELECT statement that returns these columns from the Products 
• list_price -> FORMAT with 2 digits to the right of the decimal point 
• discount_percent -> CAST column as an integer 
• discount_amount -> calculated using the list_price and discount_percent -> ROUND the result so it has 2 decimal digits 
• month_day_added -> uses the DATE_FORMAT (as part of your solution) to return the date_added column in 
this format: MM-DD.
*/
USE my_guitar_shop;
SELECT FORMAT(list_price, 2) AS list_price,
	   CAST(discount_percent AS SIGNED) AS discount_percent,
       ROUND((list_price * (1 - (discount_percent / 100))), 2) AS discount_amount,
       DATE_FORMAT(date_added, '%m-%d') AS month_day_added  
FROM products;

/*
2. SELECT these columns from the Orders 
• order_date
• order_date -> DATE_FORMAT four-digit year 
• order_date -> DATE_FORMAT: Mon-DD-YYYY. 
• order_date -> DATE_FORMAT: only the hours, minutes and seconds on a 12-hour clock with an am/pm indicator. 
• order_date -> DATE_FORMAT: MM/DD/YY HH:M
*/
SELECT order_date,
	   DATE_FORMAT(order_date, '%Y') AS four_digit_year,
       DATE_FORMAT(order_date, '%b-%d-%Y') AS 'Mon-DD-YYYY',
       DATE_FORMAT(order_date, '%r') AS 'h:m:s am/pm',
       DATE_FORMAT(order_date, '%m/%d/%y %H:%i') AS 'mm/dd/yy hh:mi'
FROM orders;

SELECT order_date,
	   order_date AS four_digit_year,
       order_date AS mon_dd_yyyy,
       order_date AS 'h:m:s am/pm',
       order_date AS 'mm/dd/yy hh:mi'
FROM orders;

SELECT * FROM orders;