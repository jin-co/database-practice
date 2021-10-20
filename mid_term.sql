
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