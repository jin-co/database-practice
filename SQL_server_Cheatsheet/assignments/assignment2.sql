SELECT * FROM bills;
SELECT * FROM bills_details;
SELECT * FROM bill_payments;
SELECT * FROM suppliers;

INSERT INTO bills (
		id, 
		transaction_date, 
		due_date, 
		description_bills, 
		reference,
		total,
		status_bills,
		supplier_id,
		bill_payment_id,
		coa_acc_no)
	VALUES (
		6,
		'2022-02-16',
		NULL,
		NULL,
		'IN1212',
		-4000.00,
		1,
		5,
		2,
		310
	);

INSERT INTO bills_details (
		id,
		transaction_amount_bill,
		bill_id,
		coa_acc_no)
	VALUES (
		10,
		4000.00,
		6,
		190
	);

INSERT INTO bill_payments (
		id,
		transaction_date,
		description_payment,
		reference,
		total,
		coa_acc_no)
	VALUES (
		2,
		'2022-02-16',
		'Purchase OE',
		NULL,
		-4000.00,
		110
	);