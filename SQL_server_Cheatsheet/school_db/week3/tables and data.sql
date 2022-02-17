/****** Object:  Table [dbo].[class]    Script Date: 2021-09-20 11:03:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[class](
	[ClassID] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[section] [int] NOT NULL,
	[start_date] [smalldatetime] NULL,
	[teacherID] [int] NOT NULL,
 CONSTRAINT [PK_class] PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student]    Script Date: 2021-09-20 11:03:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student](
	[studentno] [varchar](50) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[program] [varchar](50) NOT NULL,
 CONSTRAINT [PK_student] PRIMARY KEY CLUSTERED 
(
	[studentno] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_class_link]    Script Date: 2021-09-20 11:03:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_class_link](
	[classID] [int] NOT NULL,
	[studentno] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[teacher]    Script Date: 2021-09-20 11:03:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teacher](
	[TeacherID] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[education_level] [varchar](50) NULL,
	[position] [varchar](50) NULL,
 CONSTRAINT [PK_teacher] PRIMARY KEY CLUSTERED 
(
	[TeacherID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[class] ON 
GO
INSERT [dbo].[class] ([ClassID], [name], [section], [start_date], [teacherID]) VALUES (2, N'PROG2390', 1, CAST(N'2021-09-07T00:00:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[class] ([ClassID], [name], [section], [start_date], [teacherID]) VALUES (5, N'PROG2390', 2, CAST(N'2021-09-07T00:00:00' AS SmallDateTime), 2)
GO
INSERT [dbo].[class] ([ClassID], [name], [section], [start_date], [teacherID]) VALUES (7, N'PROG1781', 3, CAST(N'2021-01-18T00:00:00' AS SmallDateTime), 3)
GO
INSERT [dbo].[class] ([ClassID], [name], [section], [start_date], [teacherID]) VALUES (8, N'PROG1781', 4, CAST(N'2021-01-18T00:00:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[class] ([ClassID], [name], [section], [start_date], [teacherID]) VALUES (9, N'PROG1781', 5, CAST(N'2021-01-18T00:00:00' AS SmallDateTime), 2)
GO
INSERT [dbo].[class] ([ClassID], [name], [section], [start_date], [teacherID]) VALUES (10, N'PROG1815', 1, CAST(N'2021-06-03T00:00:00' AS SmallDateTime), 4)
GO
SET IDENTITY_INSERT [dbo].[class] OFF
GO
INSERT [dbo].[student] ([studentno], [name], [program]) VALUES (N'1001', N'Jim Brady', N'CPA')
GO
INSERT [dbo].[student] ([studentno], [name], [program]) VALUES (N'1002', N'Tracy Jones', N'ITID')
GO
INSERT [dbo].[student] ([studentno], [name], [program]) VALUES (N'1003', N'Jennifer Smith', N'CP')
GO
INSERT [dbo].[student] ([studentno], [name], [program]) VALUES (N'1004', N'Samantha Garrett', N'CAD')
GO
INSERT [dbo].[student] ([studentno], [name], [program]) VALUES (N'1005', N'Tom Jones', N'CAS')
GO
INSERT [dbo].[student_class_link] ([classID], [studentno]) VALUES (2, N'1001')
GO
INSERT [dbo].[student_class_link] ([classID], [studentno]) VALUES (2, N'1002')
GO
INSERT [dbo].[student_class_link] ([classID], [studentno]) VALUES (5, N'1003')
GO
INSERT [dbo].[student_class_link] ([classID], [studentno]) VALUES (5, N'1004')
GO
INSERT [dbo].[student_class_link] ([classID], [studentno]) VALUES (5, N'1005')
GO
INSERT [dbo].[student_class_link] ([classID], [studentno]) VALUES (7, N'1001')
GO
INSERT [dbo].[student_class_link] ([classID], [studentno]) VALUES (7, N'1002')
GO
INSERT [dbo].[student_class_link] ([classID], [studentno]) VALUES (8, N'1003')
GO
INSERT [dbo].[student_class_link] ([classID], [studentno]) VALUES (9, N'1004')
GO
INSERT [dbo].[student_class_link] ([classID], [studentno]) VALUES (10, N'1005')
GO
SET IDENTITY_INSERT [dbo].[teacher] ON 
GO
INSERT [dbo].[teacher] ([TeacherID], [name], [education_level], [position]) VALUES (1, N'John Public', N'M. Sc', N'Professor')
GO
INSERT [dbo].[teacher] ([TeacherID], [name], [education_level], [position]) VALUES (2, N'Jane Doe', N'PhD', N'Professor')
GO
INSERT [dbo].[teacher] ([TeacherID], [name], [education_level], [position]) VALUES (3, N'Peter Thompson', N'B. Sc', N'Professor')
GO
INSERT [dbo].[teacher] ([TeacherID], [name], [education_level], [position]) VALUES (4, N'Tom Smith', N'Diploma', N'Instructor')
GO
SET IDENTITY_INSERT [dbo].[teacher] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_class]    Script Date: 2021-09-20 11:03:17 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_class] ON [dbo].[class]
(
	[name] ASC,
	[section] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_student_class_link]    Script Date: 2021-09-20 11:03:17 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_student_class_link] ON [dbo].[student_class_link]
(
	[classID] ASC,
	[studentno] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[class]  WITH CHECK ADD  CONSTRAINT [FK_class_teacher] FOREIGN KEY([teacherID])
REFERENCES [dbo].[teacher] ([TeacherID])
GO
ALTER TABLE [dbo].[class] CHECK CONSTRAINT [FK_class_teacher]
GO
ALTER TABLE [dbo].[student_class_link]  WITH CHECK ADD  CONSTRAINT [FK_student_class_link_class] FOREIGN KEY([classID])
REFERENCES [dbo].[class] ([ClassID])
GO
ALTER TABLE [dbo].[student_class_link] CHECK CONSTRAINT [FK_student_class_link_class]
GO
ALTER TABLE [dbo].[student_class_link]  WITH CHECK ADD  CONSTRAINT [FK_student_class_link_student] FOREIGN KEY([studentno])
REFERENCES [dbo].[student] ([studentno])
GO
ALTER TABLE [dbo].[student_class_link] CHECK CONSTRAINT [FK_student_class_link_student]
GO
