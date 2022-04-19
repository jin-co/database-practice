/*
1.	creates a VIEW which ONLY displays 
the product names and description of orders 
shipped to the city Kitchener 
where the cost of the order details 
(hint: Quantity x UnitPrice) is greater than $200 . 
The view should display unique product names and 
description. 
(Hint: Use distinct <fieldname1> , 
<fieldname2> … to display distinct records) [3 marks]
*/
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM OrderDetails;

CREATE VIEW vw_order_shpped_kichener AS
SELECT DISTINCT productName, description FROM products p
JOIN OrderDetails od ON p.productId = od.productId
JOIN Orders o ON od.orderId = o.orderId
WHERE 
	city = 'Kitchener'
	AND
	hasBeenShipped = 1
	AND
	quantity * unitPrice > 200;


/*
2.	Write the SQL statement which updates 
the UnitPrice field 
for all records in OrderDetails by 20%. 
*/
UPDATE OrderDetails SET 
	unitPrice = unitPrice * 1.2;

INSERT INTO Orders 
VALUES (
1, 
GETDATE(), 
'jin', 
'd', 
'e', 
'e', 
'e', 
'e', 
'e', 
'e', 
'e', 
1);


/*
writer a view
a.	The first and last names of all customers 
who placed orders between 
January 1, 2022 and April 30, 2022 inclusively
*/

SELECT firstName, lastName FROM Orders
WHERE 
	orderDate >= '2022-01-01' 
	AND 
	orderDate <= '2022-04-30';

/*
writer a view
b.	The first and last names of all customers 
who have a Conestoga College email address. 
(Hint: Email contains conestogac.on.ca)
*/

SELECT firstName, lastName FROM orders
WHERE email LIKE '%conestogac.on.ca';


SELECT * FROM Floors;