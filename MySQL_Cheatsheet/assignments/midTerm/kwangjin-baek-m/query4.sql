USE ex;	
    
    SELECT "BAD" AS account_status,
		   invoice_number,
		   invoice_due_date AS due_date,
		   credit_total
	FROM active_invoices
	WHERE credit_total > 100
UNION
	SELECT "Good",
		   invoice_number,
		   invoice_due_date AS due_date,
		   credit_total
	FROM active_invoices
	WHERE credit_total <= 100
ORDER BY due_date;