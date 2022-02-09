
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
