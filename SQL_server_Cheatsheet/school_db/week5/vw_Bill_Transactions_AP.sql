/****** Object:  View [dbo].[vw_Bill_Transactions_AP]    Script Date: 2021-10-11 11:45:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_Bill_Transactions_AP] AS

SELECT b.id AS transaction_id, b.transaction_date, b.coa_acc_no AS ap_account, 
       c.account_name AS 'coa_name', b.total, bd.id AS bill_details_id,
	   bd.coa_acc_no AS bill_det_coa_acc_no, bd.transaction_amount_bill, 
       bp.id, bp.coa_acc_no AS bank_account, 
	   bp.account_name AS 'bank_name', 
	   b.status_bills, bd.account_name AS bd_account_name, c.category


FROM   Chart_Of_Accounts AS c
  LEFT JOIN dbo.Bills as b ON b.coa_acc_no = c.acc_no
  LEFT JOIN
  ( select x.*,y.account_name from
    Bills_Details x inner join Chart_Of_Accounts y  ON x.coa_acc_no = y.acc_no
  ) bd
  on b.id = bd.bill_id
  LEFT JOIN
  ( select x.*, y.account_name from
    Bill_Payments x inner join Chart_Of_Accounts y  ON x.coa_acc_no = y.acc_no
  ) bp
  on b.bill_payment_id = bp.id
WHERE c.acc_no = 310

 
GO


