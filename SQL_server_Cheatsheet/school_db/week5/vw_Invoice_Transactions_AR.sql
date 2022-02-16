/****** Object:  View [dbo].[vw_Invoice_Transactions_AR]    Script Date: 2021-10-11 11:47:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_Invoice_Transactions_AR] AS

SELECT i.id AS transaction_id, i.transaction_date, i.coa_acc_no AS ar_account, 
       c.account_name AS 'coa_name', i.total, ind.id AS inv_details_id,
	   ind.coa_acc_no AS inv_det_coa_acc_no, ind.transaction_amount_inv, 
       inp.id, inp.coa_acc_no AS bank_account,  inp.account_name AS 'bank_name', 
	   i.status_invoice, ind.account_name AS id_account_name, c.category




FROM   Chart_Of_Accounts AS c
  LEFT JOIN dbo.Invoices as i ON i.coa_acc_no = c.acc_no
  LEFT JOIN
  ( select x.*,y.account_name from
    Invoice_Details x inner join Chart_Of_Accounts y  ON x.coa_acc_no = y.acc_no
  ) ind
  on i.id = ind.invoice_id
  LEFT JOIN
  ( select x.*, y.account_name from
    Invoices_Payments x inner join Chart_Of_Accounts y  ON x.coa_acc_no = y.acc_no
  ) inp
  on i.invoice_payment_id = inp.id
WHERE c.acc_no = 120






GO


