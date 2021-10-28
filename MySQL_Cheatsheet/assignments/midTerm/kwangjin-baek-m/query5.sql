USE ex;	

SELECT invoice_id, 
	   invoice_total, 
       payment_total, 
       credit_total,
       (invoice_total + credit_total) - payment_total AS due_payment
FROM active_invoices
WHERE invoice_due_date >= '2014-07-01'
ORDER BY due_payment DESC;