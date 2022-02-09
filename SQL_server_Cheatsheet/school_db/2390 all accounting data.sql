delete from Funds_Received_Details
go
delete from Funds_Received
go
delete from Funds_Spent_Details
go
delete from Funds_Spent
go
delete from Bills_Details
go
delete from Bill_Payments
go
delete from Bills
go
delete from Invoice_Details
go
delete from Invoices_Payments
go
delete from Invoices
go



INSERT [dbo].[Funds_Received] ([id], [transaction_date], [description_funds_Received], [reference], [total], [customer_id], [coa_acc_no]) VALUES (1, CAST(N'2007-07-25' AS Date), N'Interest from bank', NULL, CAST(250.00 AS Decimal(20, 2)), NULL, 110)
GO
INSERT [dbo].[Funds_Received] ([id], [transaction_date], [description_funds_Received], [reference], [total], [customer_id], [coa_acc_no]) VALUES (2, CAST(N'2007-08-25' AS Date), N'Proceeds from shares issue', NULL, CAST(2000.00 AS Decimal(20, 2)), NULL, 110)
GO
INSERT [dbo].[Funds_Received_Details] ([id], [transaction_amount_funds], [funds_received_id], [coa_acc_no]) VALUES (1, CAST(-250.00 AS Decimal(20, 2)), 1, 530)
GO
INSERT [dbo].[Funds_Received_Details] ([id], [transaction_amount_funds], [funds_received_id], [coa_acc_no]) VALUES (2, CAST(-2000.00 AS Decimal(20, 2)), 2, 410)
GO
INSERT [dbo].[Bills] ([id], [transaction_date], [due_date], [description_bills], [reference], [total], [status_bills], [supplier_id], [bill_payment_id], [coa_acc_no]) VALUES (1, CAST(N'2006-07-20' AS Date), NULL, NULL, N'IN100', CAST(-300.00 AS Decimal(20, 2)), 0, 2, NULL, 310)
GO
INSERT [dbo].[Bills] ([id], [transaction_date], [due_date], [description_bills], [reference], [total], [status_bills], [supplier_id], [bill_payment_id], [coa_acc_no]) VALUES (2, CAST(N'2006-07-20' AS Date), NULL, NULL, N'IN101', CAST(-180.00 AS Decimal(20, 2)), 0, 2, NULL, 310)
GO
INSERT [dbo].[Bills] ([id], [transaction_date], [due_date], [description_bills], [reference], [total], [status_bills], [supplier_id], [bill_payment_id], [coa_acc_no]) VALUES (3, CAST(N'2006-07-20' AS Date), NULL, NULL, N'IN102', CAST(-220.00 AS Decimal(20, 2)), 0, 1, NULL, 310)
GO
INSERT [dbo].[Bills] ([id], [transaction_date], [due_date], [description_bills], [reference], [total], [status_bills], [supplier_id], [bill_payment_id], [coa_acc_no]) VALUES (4, CAST(N'2006-12-28' AS Date), NULL, NULL, N'IN1256', CAST(-1710.00 AS Decimal(20, 2)), 1, 4, 1, 310)
GO
INSERT [dbo].[Bills] ([id], [transaction_date], [due_date], [description_bills], [reference], [total], [status_bills], [supplier_id], [bill_payment_id], [coa_acc_no]) VALUES (5, CAST(N'2007-02-20' AS Date), NULL, NULL, N'IN1257', CAST(-1610.00 AS Decimal(20, 2)), 0, 3, NULL, 310)
GO
INSERT [dbo].[Bills_Details] ([id], [transaction_amount_bill], [bill_id], [coa_acc_no]) VALUES (1, CAST(300.00 AS Decimal(20, 2)), 1, 780)
GO
INSERT [dbo].[Bills_Details] ([id], [transaction_amount_bill], [bill_id], [coa_acc_no]) VALUES (2, CAST(180.00 AS Decimal(20, 2)), 2, 780)
GO
INSERT [dbo].[Bills_Details] ([id], [transaction_amount_bill], [bill_id], [coa_acc_no]) VALUES (3, CAST(220.00 AS Decimal(20, 2)), 3, 780)
GO
INSERT [dbo].[Bills_Details] ([id], [transaction_amount_bill], [bill_id], [coa_acc_no]) VALUES (4, CAST(600.00 AS Decimal(20, 2)), 4, 190)
GO
INSERT [dbo].[Bills_Details] ([id], [transaction_amount_bill], [bill_id], [coa_acc_no]) VALUES (5, CAST(650.00 AS Decimal(20, 2)), 4, 210)
GO
INSERT [dbo].[Bills_Details] ([id], [transaction_amount_bill], [bill_id], [coa_acc_no]) VALUES (6, CAST(460.00 AS Decimal(20, 2)), 4, 200)
GO
INSERT [dbo].[Bills_Details] ([id], [transaction_amount_bill], [bill_id], [coa_acc_no]) VALUES (7, CAST(800.00 AS Decimal(20, 2)), 5, 200)
GO
INSERT [dbo].[Bills_Details] ([id], [transaction_amount_bill], [bill_id], [coa_acc_no]) VALUES (8, CAST(450.00 AS Decimal(20, 2)), 5, 190)
GO
INSERT [dbo].[Bills_Details] ([id], [transaction_amount_bill], [bill_id], [coa_acc_no]) VALUES (9, CAST(360.00 AS Decimal(20, 2)), 5, 210)
GO
INSERT [dbo].[Funds_Spent] ([id], [transaction_date], [description_funds_spent], [reference], [total], [supplier_id], [coa_acc_no]) VALUES (1, CAST(N'2011-01-12' AS Date), N'Payment of interest', NULL, CAST(-745.00 AS Decimal(20, 2)), NULL, 110)
GO
INSERT [dbo].[Funds_Spent] ([id], [transaction_date], [description_funds_spent], [reference], [total], [supplier_id], [coa_acc_no]) VALUES (2, CAST(N'2011-01-13' AS Date), N'Payment of taxes', NULL, CAST(-600.00 AS Decimal(20, 2)), NULL, 110)
GO
INSERT [dbo].[Funds_Spent_Details] ([id], [transaction_amount_funds_spent], [funds_spent_id], [coa_acc_no]) VALUES (1, CAST(745.00 AS Decimal(20, 2)), 1, 830)
GO
INSERT [dbo].[Funds_Spent_Details] ([id], [transaction_amount_funds_spent], [funds_spent_id], [coa_acc_no]) VALUES (2, CAST(600.00 AS Decimal(20, 2)), 2, 840)
GO
SET IDENTITY_INSERT [dbo].[Invoices] ON 
GO
INSERT [dbo].[Invoices] ([id], [transaction_date], [due_date], [description_invoices], [reference], [total], [status_invoice], [customer_id], [invoice_payment_id], [coa_acc_no]) VALUES (1, CAST(N'2019-12-05' AS Date), NULL, N'Invoice 1', N'123456789', CAST(2000.00 AS Decimal(20, 2)), 1, 1, 1, 120)
GO
INSERT [dbo].[Invoices] ([id], [transaction_date], [due_date], [description_invoices], [reference], [total], [status_invoice], [customer_id], [invoice_payment_id], [coa_acc_no]) VALUES (2, CAST(N'2019-12-06' AS Date), CAST(N'2021-09-13' AS Date), N'Invoice 2', N'1', CAST(2000.00 AS Decimal(20, 2)), 1, 2, 2, 120)
GO
INSERT [dbo].[Invoices] ([id], [transaction_date], [due_date], [description_invoices], [reference], [total], [status_invoice], [customer_id], [invoice_payment_id], [coa_acc_no]) VALUES (3, CAST(N'2019-12-07' AS Date), NULL, N'Invoice 3', NULL, CAST(2500.00 AS Decimal(20, 2)), 0, 3, NULL, 120)
GO
SET IDENTITY_INSERT [dbo].[Invoices] OFF
GO
SET IDENTITY_INSERT [dbo].[Invoice_Details] ON 
GO
INSERT [dbo].[Invoice_Details] ([id], [transaction_amount_inv], [invoice_id], [coa_acc_no]) VALUES (1, CAST(-1000.00 AS Decimal(20, 2)), 1, 510)
GO
INSERT [dbo].[Invoice_Details] ([id], [transaction_amount_inv], [invoice_id], [coa_acc_no]) VALUES (2, CAST(-600.00 AS Decimal(20, 2)), 1, 510)
GO
INSERT [dbo].[Invoice_Details] ([id], [transaction_amount_inv], [invoice_id], [coa_acc_no]) VALUES (3, CAST(-400.00 AS Decimal(20, 2)), 1, 510)
GO
INSERT [dbo].[Invoice_Details] ([id], [transaction_amount_inv], [invoice_id], [coa_acc_no]) VALUES (4, CAST(-600.00 AS Decimal(20, 2)), 2, 510)
GO
INSERT [dbo].[Invoice_Details] ([id], [transaction_amount_inv], [invoice_id], [coa_acc_no]) VALUES (5, CAST(-400.00 AS Decimal(20, 2)), 2, 510)
GO
INSERT [dbo].[Invoice_Details] ([id], [transaction_amount_inv], [invoice_id], [coa_acc_no]) VALUES (6, CAST(-1000.00 AS Decimal(20, 2)), 2, 510)
GO
INSERT [dbo].[Invoice_Details] ([id], [transaction_amount_inv], [invoice_id], [coa_acc_no]) VALUES (7, CAST(-500.00 AS Decimal(20, 2)), 3, 510)
GO
INSERT [dbo].[Invoice_Details] ([id], [transaction_amount_inv], [invoice_id], [coa_acc_no]) VALUES (9, CAST(-750.00 AS Decimal(20, 2)), 3, 510)
GO
INSERT [dbo].[Invoice_Details] ([id], [transaction_amount_inv], [invoice_id], [coa_acc_no]) VALUES (75, CAST(1250.00 AS Decimal(20, 2)), 3, 510)
GO
SET IDENTITY_INSERT [dbo].[Invoice_Details] OFF
GO
INSERT [dbo].[Bill_Payments] ([id], [transaction_date], [description_payment], [reference], [total], [coa_acc_no]) VALUES (1, CAST(N'2007-06-25' AS Date), N'Purchase FA', NULL, CAST(-1710.00 AS Decimal(20, 2)), 110)
GO
SET IDENTITY_INSERT [dbo].[Invoices_Payments] ON 
GO
INSERT [dbo].[Invoices_Payments] ([id], [transaction_date], [description_pay], [reference], [total], [coa_acc_no]) VALUES (1, CAST(N'2007-08-26' AS Date), N'Receipt from William', N'111', CAST(2000.00 AS Decimal(20, 2)), 110)
GO
INSERT [dbo].[Invoices_Payments] ([id], [transaction_date], [description_pay], [reference], [total], [coa_acc_no]) VALUES (2, CAST(N'2007-08-26' AS Date), N'Receipt from Randy', NULL, CAST(2000.00 AS Decimal(20, 2)), 110)
GO
SET IDENTITY_INSERT [dbo].[Invoices_Payments] OFF
GO
