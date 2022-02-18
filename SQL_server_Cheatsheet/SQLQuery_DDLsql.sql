USE QSTest;

/* CREATE */
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
SELECT * FROM cinemas;

/* INSERT */
INSERT INTO cinemas (logo, name, description) 
VALUES('http', 'Cinema6', 'test'); -- if the PK is auto, just omit then it will be added

INSERT INTO cinemas (logo, name, description) 
VALUES
	('http', 'Cinema6', 'test'),
	('http', 'Cinema6', 'test'),
	('http', 'Cinema6', 'test');

-- OUTPUT
-- -> Works like a mini select (returns the value as well)
-- -> can be used with all 'CRUD'
INSERT INTO cinemas (logo, name, description) -- as insering
OUTPUT inserted.CinemaId -- show the value being inserted
VALUES('http', 'Cinema6', 'test');

/* UPDATE */
UPDATE cinemas SET logo = 'https://changed' WHERE CinemaId = 1004;

UPDATE cinemas SET 
	logo = 'https://changed',
	name = 'different',
	Description = 'good'
WHERE CinemaId = 1005;

-- OUTPUT
-- -> Works like a mini select (returns the value as well)
-- -> can be used with all 'CRUD'
UPDATE cinemas SET logo = 'https://output' 
OUTPUT inserted.CinemaId
WHERE CinemaId = 1006

/* DELETE */
DELETE FROM cinemas WHERE CinemaId = 1006;

-- OUTPUT
-- -> Works like a mini select (returns the value as well)
-- -> can be used with all 'CRUD'
DELETE FROM cinemas
OUTPUT deleted.CinemaId -- show the value being inserted
WHERE CinemaId = 1006;


/* DROP */
DROP TABLE IF EXISTS Customers;

/* VIEW */
CREATE VIEW vw_name AS
SELECT * FROM cinemas
WHERE name = 'cinema 1';
