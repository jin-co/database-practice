/****** Object:  Table [dbo].[Bill_Payments]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Bill_Payments]') AND type in (N'U'))
DROP TABLE [dbo].[Bill_Payments]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill_Payments](
	[id] [int] NOT NULL,
	[transaction_date] [date] NOT NULL,
	[description_payment] [varchar](255) NULL,
	[reference] [varchar](255) NULL,
	[total] [decimal](20, 2) NOT NULL,
	[coa_acc_no] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bills]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Bills]') AND type in (N'U'))
DROP TABLE [dbo].[Bills]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bills](
	[id] [int] NOT NULL,
	[transaction_date] [date] NOT NULL,
	[due_date] [date] NULL,
	[description_bills] [varchar](255) NULL,
	[reference] [varchar](255) NULL,
	[total] [decimal](20, 2) NOT NULL,
	[status_bills] [int] NULL,
	[supplier_id] [int] NULL,
	[bill_payment_id] [int] NULL,
	[coa_acc_no] [int] NOT NULL,
 CONSTRAINT [PK__Bills__3213E83FF71D4283] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bills_Details]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Bills_Details]') AND type in (N'U'))
DROP TABLE [dbo].[Bills_Details]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bills_Details](
	[id] [int] NOT NULL,
	[transaction_amount_bill] [decimal](20, 2) NOT NULL,
	[bill_id] [int] NULL,
	[coa_acc_no] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chart_Of_Accounts]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Chart_Of_Accounts]') AND type in (N'U'))
DROP TABLE [dbo].[Chart_Of_Accounts]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chart_Of_Accounts](
	[acc_no] [int] NOT NULL,
	[account_name] [varchar](255) NOT NULL,
	[account_type] [varchar](50) NOT NULL,
	[description_coa] [varchar](255) NULL,
	[category] [varchar](50) NOT NULL,
	[inserted_at] [datetime] NULL,
	[inserted_by] [varchar](255) NULL,
	[updated_at] [datetime] NULL,
	[updated_by] [varchar](255) NULL,
	[is_archived] [int] NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK__Chart_Of__3213E83FD3FEBA6A] PRIMARY KEY CLUSTERED 
(
	[acc_no] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Customers]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customers]') AND type in (N'U'))
DROP TABLE [dbo].[Customers]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customer_name] [varchar](255) NOT NULL,
	[secondary_contact_name] [varchar](255) NULL,
	[email] [varchar](255) NULL,
	[phone] [varchar](255) NULL,
	[fax] [varchar](255) NULL,
	[customer_address] [varchar](255) NULL,
 CONSTRAINT [PK__Customer__3213E83F765CC61F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Funds_Received]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Funds_Received]') AND type in (N'U'))
DROP TABLE [dbo].[Funds_Received]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funds_Received](
	[id] [int] NOT NULL,
	[transaction_date] [date] NOT NULL,
	[description_funds_Received] [varchar](255) NULL,
	[reference] [varchar](255) NULL,
	[total] [decimal](20, 2) NOT NULL,
	[customer_id] [int] NULL,
	[coa_acc_no] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Funds_Received_Details]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Funds_Received_Details]') AND type in (N'U'))
DROP TABLE [dbo].[Funds_Received_Details]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funds_Received_Details](
	[id] [int] NOT NULL,
	[transaction_amount_funds] [decimal](20, 2) NOT NULL,
	[funds_received_id] [int] NULL,
	[coa_acc_no] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Funds_Spent]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Funds_Spent]') AND type in (N'U'))
DROP TABLE [dbo].[Funds_Spent]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funds_Spent](
	[id] [int] NOT NULL,
	[transaction_date] [date] NOT NULL,
	[description_funds_spent] [varchar](255) NULL,
	[reference] [varchar](255) NULL,
	[total] [decimal](20, 2) NOT NULL,
	[supplier_id] [int] NULL,
	[coa_acc_no] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Funds_Spent_Details]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Funds_Spent_Details]') AND type in (N'U'))
DROP TABLE [dbo].[Funds_Spent_Details]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funds_Spent_Details](
	[id] [int] NOT NULL,
	[transaction_amount_funds_spent] [decimal](20, 2) NOT NULL,
	[funds_spent_id] [int] NULL,
	[coa_acc_no] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice_Details]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoice_Details]') AND type in (N'U'))
DROP TABLE [dbo].[Invoice_Details]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice_Details](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[transaction_amount_inv] [decimal](20, 2) NULL,
	[invoice_id] [int] NULL,
	[coa_acc_no] [int] NOT NULL,
 CONSTRAINT [PK__Invoice___3213E83F90CA9996] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[invoice_status]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[invoice_status]') AND type in (N'U'))
DROP TABLE [dbo].[invoice_status]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[invoice_status](
	[code] [varchar](50) NOT NULL,
	[value] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices]') AND type in (N'U'))
DROP TABLE [dbo].[Invoices]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[transaction_date] [date] NOT NULL,
	[due_date] [date] NULL,
	[description_invoices] [varchar](255) NULL,
	[reference] [varchar](255) NULL,
	[total] [decimal](20, 2) NOT NULL,
	[status_invoice] [int] NOT NULL,
	[customer_id] [int] NULL,
	[invoice_payment_id] [int] NULL,
	[coa_acc_no] [int] NOT NULL,
 CONSTRAINT [PK__Invoices__3213E83F23AD5C4C] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoices_Payments]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices_Payments]') AND type in (N'U'))
DROP TABLE [dbo].[Invoices_Payments]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices_Payments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[transaction_date] [date] NOT NULL,
	[description_pay] [varchar](255) NULL,
	[reference] [varchar](255) NULL,
	[total] [decimal](20, 2) NOT NULL,
	[coa_acc_no] [int] NOT NULL,
 CONSTRAINT [PK__Invoices__3213E83F226C4DEC] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Suppliers]    Script Date: 2021-10-04 2:13:21 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Suppliers]') AND type in (N'U'))
DROP TABLE [dbo].[Suppliers]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[id] [int] NOT NULL,
	[name_suppliers] [varchar](255) NULL,
	[contact_person] [varchar](255) NULL,
	[email] [varchar](255) NULL,
	[phone] [varchar](255) NULL,
	[fax] [varchar](255) NULL,
	[address_supplier] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Index [IX_Chart_Of_Accounts]    Script Date: 2021-10-04 2:13:21 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Chart_Of_Accounts] ON [dbo].[Chart_Of_Accounts]
(
	[acc_no] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO

ALTER TABLE [dbo].[Invoices] ADD  CONSTRAINT [DF_Invoices_transaction_date]  DEFAULT (getdate()) FOR [transaction_date]
GO
ALTER TABLE [dbo].[Invoices] ADD  CONSTRAINT [DF_Invoices_status_invoice]  DEFAULT ((0)) FOR [status_invoice]
GO
ALTER TABLE [dbo].[Bill_Payments]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Payments_Chart_Of_Accounts] FOREIGN KEY([coa_acc_no])
REFERENCES [dbo].[Chart_Of_Accounts] ([acc_no])
GO
ALTER TABLE [dbo].[Bill_Payments] CHECK CONSTRAINT [FK_Bill_Payments_Chart_Of_Accounts]
GO
ALTER TABLE [dbo].[Bills]  WITH CHECK ADD  CONSTRAINT [FK_Bills_Chart_Of_Accounts] FOREIGN KEY([coa_acc_no])
REFERENCES [dbo].[Chart_Of_Accounts] ([acc_no])
GO
ALTER TABLE [dbo].[Bills] CHECK CONSTRAINT [FK_Bills_Chart_Of_Accounts]
GO
ALTER TABLE [dbo].[Bills_Details]  WITH CHECK ADD  CONSTRAINT [FK_Bills_Details_Bills] FOREIGN KEY([coa_acc_no])
REFERENCES [dbo].[Chart_Of_Accounts] ([acc_no])
GO
ALTER TABLE [dbo].[Bills_Details] CHECK CONSTRAINT [FK_Bills_Details_Bills]
GO
ALTER TABLE [dbo].[Bills_Details]  WITH CHECK ADD  CONSTRAINT [FK_Bills_Details_Bills1] FOREIGN KEY([bill_id])
REFERENCES [dbo].[Bills] ([id])
GO
ALTER TABLE [dbo].[Bills_Details] CHECK CONSTRAINT [FK_Bills_Details_Bills1]
GO

ALTER TABLE [dbo].[Funds_Received]  WITH CHECK ADD  CONSTRAINT [FK_Funds_Received_Chart_Of_Accounts] FOREIGN KEY([coa_acc_no])
REFERENCES [dbo].[Chart_Of_Accounts] ([acc_no])
GO
ALTER TABLE [dbo].[Funds_Received] CHECK CONSTRAINT [FK_Funds_Received_Chart_Of_Accounts]
GO
ALTER TABLE [dbo].[Funds_Received]  WITH CHECK ADD  CONSTRAINT [FK_Funds_Received_Customers] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([id])
GO
ALTER TABLE [dbo].[Funds_Received] CHECK CONSTRAINT [FK_Funds_Received_Customers]
GO
ALTER TABLE [dbo].[Funds_Received_Details]  WITH CHECK ADD  CONSTRAINT [FK_Funds_Received_Details_Chart_Of_Accounts] FOREIGN KEY([coa_acc_no])
REFERENCES [dbo].[Chart_Of_Accounts] ([acc_no])
GO
ALTER TABLE [dbo].[Funds_Received_Details] CHECK CONSTRAINT [FK_Funds_Received_Details_Chart_Of_Accounts]
GO
ALTER TABLE [dbo].[Funds_Received_Details]  WITH CHECK ADD  CONSTRAINT [FK_Funds_Received_Details_Funds_Received] FOREIGN KEY([funds_received_id])
REFERENCES [dbo].[Funds_Received] ([id])
GO
ALTER TABLE [dbo].[Funds_Received_Details] CHECK CONSTRAINT [FK_Funds_Received_Details_Funds_Received]
GO
ALTER TABLE [dbo].[Funds_Spent]  WITH CHECK ADD  CONSTRAINT [FK_Funds_Spent_Chart_Of_Accounts] FOREIGN KEY([coa_acc_no])
REFERENCES [dbo].[Chart_Of_Accounts] ([acc_no])
GO
ALTER TABLE [dbo].[Funds_Spent] CHECK CONSTRAINT [FK_Funds_Spent_Chart_Of_Accounts]
GO
ALTER TABLE [dbo].[Funds_Spent]  WITH CHECK ADD  CONSTRAINT [FK_Funds_Spent_Suppliers] FOREIGN KEY([supplier_id])
REFERENCES [dbo].[Suppliers] ([id])
GO
ALTER TABLE [dbo].[Funds_Spent] CHECK CONSTRAINT [FK_Funds_Spent_Suppliers]
GO
ALTER TABLE [dbo].[Funds_Spent_Details]  WITH CHECK ADD  CONSTRAINT [FK_Funds_Spent_Details_Chart_Of_Accounts] FOREIGN KEY([coa_acc_no])
REFERENCES [dbo].[Chart_Of_Accounts] ([acc_no])
GO
ALTER TABLE [dbo].[Funds_Spent_Details] CHECK CONSTRAINT [FK_Funds_Spent_Details_Chart_Of_Accounts]
GO
ALTER TABLE [dbo].[Funds_Spent_Details]  WITH CHECK ADD  CONSTRAINT [FK_Funds_Spent_Details_Funds_Spent] FOREIGN KEY([funds_spent_id])
REFERENCES [dbo].[Funds_Spent] ([id])
GO
ALTER TABLE [dbo].[Funds_Spent_Details] CHECK CONSTRAINT [FK_Funds_Spent_Details_Funds_Spent]
GO
ALTER TABLE [dbo].[Invoice_Details]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Details_Chart_Of_Accounts] FOREIGN KEY([coa_acc_no])
REFERENCES [dbo].[Chart_Of_Accounts] ([acc_no])
GO
ALTER TABLE [dbo].[Invoice_Details] CHECK CONSTRAINT [FK_Invoice_Details_Chart_Of_Accounts]
GO
ALTER TABLE [dbo].[Invoice_Details]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Details_Invoices] FOREIGN KEY([invoice_id])
REFERENCES [dbo].[Invoices] ([id])
GO
ALTER TABLE [dbo].[Invoice_Details] CHECK CONSTRAINT [FK_Invoice_Details_Invoices]
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD  CONSTRAINT [FK_Invoices_Chart_Of_Accounts] FOREIGN KEY([coa_acc_no])
REFERENCES [dbo].[Chart_Of_Accounts] ([acc_no])
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [FK_Invoices_Chart_Of_Accounts]
GO
ALTER TABLE [dbo].[Invoices_Payments]  WITH CHECK ADD  CONSTRAINT [FK_Invoices_Payments_Chart_Of_Accounts] FOREIGN KEY([coa_acc_no])
REFERENCES [dbo].[Chart_Of_Accounts] ([acc_no])
GO
ALTER TABLE [dbo].[Invoices_Payments] CHECK CONSTRAINT [FK_Invoices_Payments_Chart_Of_Accounts]
GO

/****** Object:  Table [dbo].[users]    Script Date: 2021-10-04 9:18:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[access_level] [varchar](50) NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[username] ASC,
	[password] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_access_level]  DEFAULT ('user') FOR [access_level]
GO
