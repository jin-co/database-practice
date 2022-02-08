USE QSTest;

CREATE TABLE Bills (
	BillId int NOT NULL PRIMARY KEY,
	Total decimal(18, 0) NOT NULL,
	TransactionDate date,
	DueDate date,
	Description varchar(255),
	Status varchar(50),
	SupplierId int NOT NULL,
	BillPaymentId int NOT NULL,
	COA_AccNo int NOT NULL
);

CREATE TABLE BillDetails (
	BillDetailId int NOT NULL PRIMARY KEY,
	Amount decimal(18, 0) NOT NULL,	
	BillId int NOT NULL,
	COA_AccNo int NOT NULL
);

CREATE TABLE BillPayments (
	BillPaymentId int NOT NULL PRIMARY KEY,
	Amount decimal(18, 0) NOT NULL,	
	TransactionDate date NOT NULL,
	Description varchar(255),
	COA_AccNo int NOT NULL
);

CREATE TABLE Customers (
	CustomerId int NOT NULL PRIMARY KEY,
	Name varchar(255) NOT NULL,
	ContactName varchar(255) NOT NULL,
	Email varchar(255) NOT NULL,
	Phone varchar(50) NOT NULL,
	Address varchar(255)	
);

CREATE TABLE ChartOfAccounts (
	AccNo int NOT NULL PRIMARY KEY,
	AccName varchar(255) NOT NULL,
	AccType varchar(50) NOT NULL,
	Description varchar(255),
	Category varchar(50) NOT NULL,
	DateInserted datetime,
	InsertedBy varchar(255),
	DateUpdated datetime,
	UpdatedBy varchar(255),
	Archived int	
);

CREATE TABLE Suppliers (
	SupplierId int NOT NULL PRIMARY KEY,
	Name varchar(255) NOT NULL,
	ContactName varchar(255) NOT NULL,
	Email varchar(255) NOT NULL,
	Phone varchar(50) NOT NULL,
	Address varchar(255)	
);

DROP TABLE IF EXISTS Customers;

