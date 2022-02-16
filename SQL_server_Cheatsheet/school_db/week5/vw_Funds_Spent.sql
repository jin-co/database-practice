/****** Object:  View [dbo].[vw_Funds_Spent]    Script Date: 2021-10-11 11:46:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_Funds_Spent] AS

SELECT fs.id AS transaction_id, fs.transaction_date, fs.coa_acc_no,
       c.account_name AS 'coa_name', fs.total, fsd.id AS fsd_details_id,
	   fsd.coa_acc_no AS fsd_det_coa_acc_no, 
	   c.account_name AS fsd_details_coa_name,
	   fsd.transaction_amount_funds_spent, c.category

FROM   Chart_Of_Accounts AS c
  LEFT JOIN dbo.Funds_Spent fs ON fs.coa_acc_no = c.acc_no
  LEFT JOIN
  ( select x.*,y.account_name from
    Funds_Spent_Details x inner join Chart_Of_Accounts y  ON x.coa_acc_no = y.acc_no
  ) fsd
  on fs.id = fsd.funds_spent_id
  WHERE c.acc_no = 110

 
GO


