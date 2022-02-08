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