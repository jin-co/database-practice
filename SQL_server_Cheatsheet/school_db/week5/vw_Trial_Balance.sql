/****** Object:  View [dbo].[vw_Trial_Balance]    Script Date: 2021-10-11 11:47:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_Trial_Balance] AS

SELECT it.inv_det_coa_acc_no as account_code,  it.id_account_name as account_name, it.category,
(CASE WHEN SUM(transaction_amount_inv) > 0 THEN SUM(transaction_amount_inv) ELSE 0 END) AS debit_bal,
(CASE WHEN SUM(transaction_amount_inv) < 0 THEN SUM(transaction_amount_inv) ELSE 0 END) AS credit_bal
FROM   vw_Invoice_Transactions_AR AS it
group by it.inv_det_coa_acc_no, it.id_account_name, it.category

UNION ALL

SELECT it.bill_det_coa_acc_no as account_code,  it.bd_account_name as account_name, it.category,
(CASE WHEN SUM(transaction_amount_bill) > 0 THEN SUM(transaction_amount_bill) ELSE 0 END) AS debit_bal,
(CASE WHEN SUM(transaction_amount_bill) < 0 THEN SUM(transaction_amount_bill) ELSE 0 END) AS credit_bal
FROM   vw_Bill_Transactions_AP AS it
where it.bill_det_coa_acc_no IS NOT NULL
group by it.bill_det_coa_acc_no, it.bd_account_name, it.category


UNION ALL
--funds received
SELECT it.frd_det_coa_acc_no as account_code,  it.coa_name as account_name, it.category,
(CASE WHEN SUM(transaction_amount_funds) > 0 THEN SUM(transaction_amount_funds) ELSE 0 END) AS debit_bal,
(CASE WHEN SUM(transaction_amount_funds) < 0 THEN SUM(transaction_amount_funds) ELSE 0 END) AS credit_bal
FROM   vw_Funds_Received AS it
where it.frd_det_coa_acc_no IS NOT NULL
group by it.frd_det_coa_acc_no, it.coa_name, it.category



UNION ALL
--funds spent
SELECT it.fsd_det_coa_acc_no as account_code,  it.coa_name as account_name, it.category,
(CASE WHEN SUM(transaction_amount_funds_spent) > 0 THEN SUM(transaction_amount_funds_spent) ELSE 0 END) AS debit_bal,
(CASE WHEN SUM(transaction_amount_funds_spent) < 0 THEN SUM(transaction_amount_funds_spent) ELSE 0 END) AS credit_bal
FROM   vw_Funds_Spent AS it
where it.fsd_det_coa_acc_no IS NOT NULL
group by it.fsd_det_coa_acc_no, it.coa_name, it.category



UNION ALL
-- all AP (bill transactions)
SELECT it.ap_account as account_code,  it.coa_name as account_name, it.category,
-(CASE WHEN SUM(transaction_amount_bill) < 0 THEN SUM(transaction_amount_bill) ELSE 0 END) AS debit_bal,
-(CASE WHEN SUM(transaction_amount_bill) > 0 THEN SUM(transaction_amount_bill) ELSE 0 END) AS credit_bal
FROM   vw_Bill_Transactions_AP AS it
where it.status_bills = 0 --AND it.bill_det_coa_acc_no IS NOT NULL 
group by it.ap_account, it.coa_name, it.category

UNION ALL
--all AR (invoice transactions)
   SELECT it.ar_account as account_code,  it.coa_name as account_name, it.category,
-(CASE WHEN SUM(transaction_amount_inv) < 0 THEN SUM(transaction_amount_inv) ELSE 0 END) AS debit_bal,
-(CASE WHEN SUM(transaction_amount_inv) > 0 THEN SUM(transaction_amount_inv) ELSE 0 END) AS credit_bal
FROM   vw_Invoice_Transactions_AR AS it
where it.status_invoice = 0 
group by it.ar_account, it.coa_name, it.category

UNION ALL
-- all bill payments 
SELECT it.bank_account as account_code,  it.bank_name as account_name, it.category,
-(CASE WHEN SUM(transaction_amount_bill) < 0 THEN SUM(transaction_amount_bill) ELSE 0 END) AS debit_bal,
-(CASE WHEN SUM(transaction_amount_bill) > 0 THEN SUM(transaction_amount_bill) ELSE 0 END) AS credit_bal
FROM   vw_Bill_Transactions_AP AS it
where it.status_bills = 1
group by it.bank_account, it.bank_name, it.category

UNION ALL
--all invoice payments
   SELECT it.bank_account as account_code,  it.bank_name as account_name, it.category,
-(CASE WHEN SUM(transaction_amount_inv) < 0 THEN SUM(transaction_amount_inv) ELSE 0 END) AS debit_bal,
-(CASE WHEN SUM(transaction_amount_inv) > 0 THEN SUM(transaction_amount_inv) ELSE 0 END) AS credit_bal
FROM   vw_Invoice_Transactions_AR AS it
where it.status_invoice = 1 
group by it.bank_account, it.bank_name, it.category


UNION ALL
--all funds received
SELECT it.coa_acc_no as account_code,  it.coa_name as account_name, it.category,
-(CASE WHEN SUM(transaction_amount_funds) < 0 THEN SUM(transaction_amount_funds) ELSE 0 END) AS debit_bal,
-(CASE WHEN SUM(transaction_amount_funds) > 0 THEN SUM(transaction_amount_funds) ELSE 0 END) AS credit_bal
FROM   vw_Funds_Received AS it
group by it.coa_acc_no, it.coa_name, it.category

UNION ALL
--all funds spent
SELECT it.coa_acc_no as account_code,  it.coa_name as account_name, it.category,
-(CASE WHEN SUM(transaction_amount_funds_spent) < 0 THEN SUM(transaction_amount_funds_spent) ELSE 0 END) AS debit_bal,
-(CASE WHEN SUM(transaction_amount_funds_spent) > 0 THEN SUM(transaction_amount_funds_spent) ELSE 0 END) AS credit_bal
FROM   vw_Funds_Spent AS it
group by it.coa_acc_no, it.coa_name, it.category

--ORDER BY account_code
GO


