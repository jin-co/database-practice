
SELECT * FROM Invoices;
SELECT * FROM Invoice_Details;
SELECT * FROM Invoices_Payments;

SELECT * FROM Invoices i
INNER JOIN Invoice_Details id ON i.id = id.invoice_id;

SELECT * FROM Invoices i
LEFT OUTER JOIN Invoice_Details id ON i.id = id.invoice_id;

SELECT * FROM Invoices i
RIGHT OUTER JOIN Invoice_Details id ON i.id = id.invoice_id;

SELECT * FROM Invoices i
INNER JOIN Invoices_Payments ip ON i.invoice_payment_id = ip.id;

SELECT * FROM Invoices i
LEFT JOIN Invoices_Payments ip ON i.invoice_payment_id = ip.id;


SELECT * FROM bills;
SELECT * FROM bill_payments;

-- select all records in the bills table that have payments
SELECT * FROM bills WHERE bill_payment_id IS NOT NULL;
SELECT * FROM bills b 
RIGHT JOIN bill_payments bp 
ON  b.bill_payment_id = bp.id;

-- select all records in the bills table that DO NOT have payments
SELECT * FROM bills WHERE bill_payment_id IS NULL;

-- show the totals of all transactions 
-- in the bills_details table for each bill_id
SELECT * FROM bills_details;
SELECT * FROM bills;

SELECT SUM(transaction_amount_bill) FROM bills_details bd
JOIN bills b ON b.id = bd.bill_id
GROUP BY b.id;