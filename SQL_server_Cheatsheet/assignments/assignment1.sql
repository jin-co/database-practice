USE QSTest;

DROP TABLE Bills;
DROP TABLE Bill_Details;
DROP TABLE Bill_Payments;
DROP TABLE Customers;
DROP TABLE Chart_Of_Accounts;
DROP TABLE Suppliers;

CREATE TABLE Bills (
	bill_id int NOT NULL PRIMARY KEY,
	total decimal(18, 0) NOT NULL,
	transaction_date date,
	due_date date,
	description varchar(255),
	status varchar(50),
	supplier_id int NOT NULL,
	bill_payment_id int NOT NULL,
	COA_acc_no int NOT NULL
);

CREATE TABLE Bill_Details (
	bill_detail_id int NOT NULL PRIMARY KEY,
	amount decimal(18, 0) NOT NULL,	
	bill_id int NOT NULL,
	COA_acc_no int NOT NULL
);

CREATE TABLE Bill_Payments (
	bill_payment_id int NOT NULL PRIMARY KEY,
	amount decimal(18, 0) NOT NULL,	
	transaction_date date NOT NULL,
	description varchar(255),
	COA_acc_no int NOT NULL
);

CREATE TABLE Customers (
	customer_id int NOT NULL PRIMARY KEY,
	name varchar(255) NOT NULL,
	contact_name varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	phone varchar(50) NOT NULL,
	address varchar(255)	
);

CREATE TABLE Chart_Of_Accounts (
	acc_no int NOT NULL PRIMARY KEY,
	acc_name varchar(255) NOT NULL,
	acc_type varchar(50) NOT NULL,
	description varchar(255),
	category varchar(50) NOT NULL,
	date_inserted datetime,
	inserted_by varchar(255),
	date_updated datetime,
	updated_by varchar(255),
	archived int	
);

CREATE TABLE Suppliers (
	supplier_id int NOT NULL PRIMARY KEY,
	name varchar(255) NOT NULL,
	contact_name varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	phone varchar(50) NOT NULL,
	address varchar(255)	
);

DROP TABLE IF EXISTS Customers;

--DROP VIEW BillsBillDetails;
--DROP VIEW BillsBillPayments;
--DROP VIEW BillsBillPayment;

/*
CREATE VIEW Bill_BillDetails
AS  
SELECT Bills.*
FROM Bills LEFT OUTER JOIN Bill_Details
ON Bills.bill_id = Bill_Details.bill_id;
*/
/*
CREATE VIEW Bill_BillPayments
AS  
SELECT Bills.*
FROM Bills LEFT OUTER JOIN Bill_Payments  
ON Bills.bill_payment_id = Bill_Payments.bill_payment_id; 
*/
/*
CREATE VIEW Bill_BillPayment
AS  
SELECT Bills.*
FROM Bills INNER JOIN Bill_Payments  
ON Bills.bill_payment_id = Bill_Payments.bill_payment_id;
*/

INSERT INTO Suppliers (
	supplier_id, name, contact_name, email, phone, address) 
	VALUES(
		1,
		'New Kids', 
		'New Kids Con', 
		'newk@gmail.com', 
		'000-000-0001',
		'somewhere');

INSERT INTO Bill_Payments (
	bill_payment_id,
	amount,	
	transaction_date,
	description,
	COA_acc_no)
	VALUES(
		1,
		4000,
		CONVERT(DATE, SYSDATETIME()),
		'purchased office equipment',
		110
	);
