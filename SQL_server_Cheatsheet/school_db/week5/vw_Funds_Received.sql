/****** Object:  View [dbo].[vw_Funds_Received]    Script Date: 2021-10-11 11:46:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_Funds_Received] AS

SELECT fr.id AS transaction_id, fr.transaction_date, fr.coa_acc_no,
       c.account_name AS 'coa_name', fr.total, frd.id AS frd_details_id,
	   frd.coa_acc_no AS frd_det_coa_acc_no, 
	   c.account_name,
	   frd.transaction_amount_funds, c.category--,
       --inp.id, inp.coa_acc_no AS bank_account,  inp.account_name AS 'bank_name', 
	   --i.status_invoice, ind.account_name AS id_account_name

FROM   Chart_Of_Accounts AS c
  LEFT JOIN dbo.Funds_Received as fr ON fr.coa_acc_no = c.acc_no
  LEFT JOIN
  ( select x.*,y.account_name from
    Funds_Received_Details x inner join Chart_Of_Accounts y  ON x.coa_acc_no = y.acc_no
  ) frd
  on fr.id = frd.funds_received_id
  WHERE c.acc_no = 110

 
GO


