CREATE TABLE Orders (
	order_id int NOT NULL PRIMARY KEY,
	order_date datetime NOT NULL,
	first_name varchar(160) NOT NULL,
	last_name varchar(160) NOT NULL,
	address varchar(70) NOT NULL,
	city varchar(40) NOT NULL,
	state varchar(40) NOT NULL,
	postal_code varchar(10) NOT NULL,
	country varchar(40) NOT NULL,
	phone varchar(24) NULL,
	email varchar(max) NOT NULL,
	has_been_shipped bit NOT NULL
);

CREATE TABLE Order_Details (
	order_detail_id int NOT NULL PRIMARY KEY,
	order_id int FOREIGN KEY REFERENCES Orders(order_id) NOT NULL,
	product_id int FOREIGN KEY REFERENCES Products(product_id) NOT NULL,
	quantity int NOT NULL,
	unit_price float,
);

CREATE TABLE Products (
	product_id int NOT NULL PRIMARY KEY,
	product_name varchar(100) NOT NULL,
	description varchar(MAX) NOT NULL
);

CREATE TABLE Invoices (
	id int NOT NULL PRIMARY KEY,
	transaction_date DATE NOT NULL,
	due_date DATE,
	description_invoices VARCHAR(255),
	reference VARCHAR(255),
	total DECIMAL(20, 2) NOT NULL,
	status_invoice INT NOT NULL,
	customer_id INT NOT NULL,
	invoice_payment_id INT NOT NULL,
	coa_acc_no INT NOT NULL
);

INSERT INTO Invoices (
	id,
	transaction_date,
	due_date,
	description_invoices,
	reference,
	total,
	status_invoice,
	customer_id,
	invoice_payment_id,
	coa_acc_no
) VALUES (
	1,
	'2022-02-23',
	NULL,
	NULL,
	NULL,
	'1',
	10000,
	1,
	1,
	120
);

CREATE TABLE Invoice_details (
	id int NOT NULL PRIMARY KEY,
	transaction_amount_inv DECIMAL(20, 2),	
	invoice_id INT,
	coa_acc_no INT NOT NULL
);

INSERT INTO Invoice_details(
	id,
	transaction_amount_inv,	
	invoice_id,
	coa_acc_no)
	VALUES(
	1,
	NULL,
	1,
	510
	);

UPDATE Invoices SET invoice_payment_id = 2 WHERE id = 1;

CREATE TABLE Invoice_payments (
	id int NOT NULL PRIMARY KEY,
	transaction_date DATE NOT NULL,	
	description_pay VARCHAR(255),
	reference VARCHAR(255),
	total DECIMAL(20, 2) NOT NULL,	
	coa_acc_no INT NOT NULL
);

INSERT INTO Invoice_payments(
	id,
	transaction_date,	
	description_pay,
	reference,
	total,	
	coa_acc_no)
	VALUES(
	1,
	'2022-02-23',
	'',
	NULL,
	10,000,
	110
	);
SELECT * FROM Orders;
SELECT * FROM Order_Details;
SELECT * FROM Products;

DELETE FROM Order_Details WHERE quantity < 10;

INSERT INTO Orders(order_id, order_date, first_name, last_name,
address, city, state, postal_code, country, phone, email, has_been_shipped)
VALUES (
	101,
	'2022-02-23',
	'John',
	'Public',
	'123 Main Street',
	'Toronto',
	'ON',
	'M7G 2T5',
	'Canada',
	'905-111-1111',
	'jpublic@email.com',
	0
);

SELECT last_name FROM orders WHERE city = 'Waterloo';
SELECT last_name FROM orders WHERE city = 'Kitchener';

SELECT last_name FROM orders WHERE city = 'Waterloo'
UNION
SELECT last_name FROM orders WHERE city = 'Kitchener';

CREATE VIEW vw_order_of_product AS
SELECT DISTINCT product_name, description FROM Products;

SELECT o.order_id, o.order_date, o.first_name, o.last_name, p.product_name,
od.quantity, od.unit_price
FROM Orders o 
JOIN Order_Details od ON (o.order_id = od.order_id)
JOIN Products p ON (od.product_id = p.product_id)
WHERE o.has_been_shipped <= 0;

SELECT *, SUM(od.quantity) * od.unit_price AS 'total_cost' 
FROM orders o JOIN Order_Details od ON (o.order_id = od.order_id)
GROUP BY 
	o.order_id,
	o.order_date,
	o.first_name ,
	o.last_name ,
	o.address ,
	o.city ,
	o.state ,
	o.postal_code ,
	o.country ,
	o.phone,
	o.email ,
	o.has_been_shipped,
	od.order_detail_id,
	od.order_id,
	od.product_id,
	od.quantity,
	od.unit_price;



CREATE TABLE Bills (
	bill_id int NOT NULL PRIMARY KEY,
	total decimal(18, 0) NOT NULL,
	transaction_date date,
	due_date date,
	description varchar(255),
	status varchar(50),
	supplier_id int FOREIGN KEY REFERENCES Suppliers(supplier_id) NOT NULL,
	bill_payment_id int FOREIGN KEY REFERENCES Bill_Payments(bill_payment_id) NOT NULL,
	COA_acc_no int FOREIGN KEY REFERENCES Chart_Of_Accounts(acc_no) NOT NULL
);