
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

CREATE TABLE Bill_Details (
	bill_detail_id int NOT NULL PRIMARY KEY,
	amount decimal(18, 0) NOT NULL,	
	bill_id int FOREIGN KEY REFERENCES Bills(bill_id) NOT NULL,
	COA_acc_no int FOREIGN KEY REFERENCES Chart_Of_Accounts(acc_no) NOT NULL
);

CREATE TABLE Bill_Payments (
	bill_payment_id int NOT NULL PRIMARY KEY,
	amount decimal(18, 0) NOT NULL,	
	transaction_date date NOT NULL,
	description varchar(255),
	COA_acc_no int FOREIGN KEY REFERENCES Chart_Of_Accounts(acc_no) NOT NULL
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











SELECT * FROM bills;
SELECT * FROM bill_details;
SELECT * FROM bill_payments;
SELECT * FROM suppliers;
SELECT * FROM Chart_Of_Accounts;

INSERT INTO Chart_Of_Accounts (
	acc_no, acc_name, acc_type, description, category, inserted_by, 
	date_updated, updated_by, archived)
	VALUES
	(310, 'Account Payable', 'AP', NULL, 'Liabilities', NULL,
	NULL, NULL, NULL),
	(190, 'Office Equipment', 'FA Cost', NULL, 'Assets', NULL,
	NULL, NULL, NULL),
	(110, 'Bank Account', 'BANK', NULL, 'Assets', NULL,
	NULL, NULL, NULL);


INSERT INTO bills (bill_id, total, transaction_date, due_date, description, 
		status, supplier_id, bill_payment_id, coa_acc_no)
	VALUES (1, -4000.00, '2022-02-16', NULL, NULL, 'completed', 1, 1, 310);

INSERT INTO bill_details (bill_detail_id, amount, bill_id, coa_acc_no)
	VALUES (1, 4000.00, 1, 190);

INSERT INTO bill_payments (bill_payment_id, amount, transaction_date, description, coa_acc_no)
	VALUES (1, -4000.00, '2022-02-16', 'Purchase OE', 110);


INSERT INTO Suppliers (supplier_id, name, contact_name, email, phone, address) 
	VALUES(
		5,
		'New Kids', 
		'New Kids Con', 
		'newk@gmail.com', 
		'344566',
		'7th London, somewhere, where 11, Japen');
