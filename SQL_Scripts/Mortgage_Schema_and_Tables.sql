USE [Mortgage_OLAP]
GO

/****** Object:  Table [dbo].[Dim_Borrower]    Script Date: 4/19/2026 1:37:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dim_Borrower](
	[BorrowerKey] [int] IDENTITY(1,1) NOT NULL,
	[Borrower_SSN] [int] NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BorrowerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



USE [Mortgage_OLAP]
GO

/****** Object:  Table [dbo].[Dim_Loan]    Script Date: 4/19/2026 1:38:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dim_Loan](
	[LoanKey] [int] IDENTITY(1,1) NOT NULL,
	[Loan_ID] [int] NOT NULL,
	[LoanAmount] [int] NULL,
	[Purpose] [varchar](50) NULL,
	[Referral] [varchar](50) NULL,
	[CreditCardAuth] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[LoanKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Mortgage_OLAP]
GO

/****** Object:  Table [dbo].[Dim_Property]    Script Date: 4/19/2026 1:39:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dim_Property](
	[PropertyKey] [int] IDENTITY(1,1) NOT NULL,
	[Property_ID] [int] NOT NULL,
	[Address] [varchar](100) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[Zip] [varchar](20) NULL,
	[AgentName] [varchar](50) NULL,
	[AgentPhone] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PropertyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Mortgage_OLAP]
GO

/****** Object:  Table [dbo].[Fact_Financials]    Script Date: 4/19/2026 1:39:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Fact_Financials](
	[Financial_Key] [int] IDENTITY(1,1) NOT NULL,
	[Loan_Key] [int] NULL,
	[Borrower_Key] [int] NULL,
	[Property_Key] [int] NULL,
	[Loan_Date] [date] NULL,
	[MonthlyIncome] [decimal](15, 2) NULL,
	[LoanAmount] [decimal](15, 2) NULL,
	[Purchase Price] [decimal](15, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Financial_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Mortgage_OLAP]
GO

/****** Object:  Table [dbo].[Fact_Mortgage_Applications]    Script Date: 4/19/2026 1:40:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Fact_Mortgage_Applications](
	[FactKey] [int] IDENTITY(1,1) NOT NULL,
	[BorrowerKey] [int] NULL,
	[PropertyKey] [int] NULL,
	[LoanKey] [int] NULL,
	[MonthlyIncome] [money] NULL,
	[Bonuses] [money] NULL,
	[Commission] [money] NULL,
	[OtherIncome] [money] NULL,
	[Checking] [int] NULL,
	[Savings] [int] NULL,
	[RetirementFund] [int] NULL,
	[MutualFund] [int] NULL,
	[YearsAtThisAddress] [int] NULL,
	[RecordCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[FactKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Fact_Mortgage_Applications] ADD  DEFAULT ((1)) FOR [RecordCount]
GO

ALTER TABLE [dbo].[Fact_Mortgage_Applications]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Borrower] FOREIGN KEY([BorrowerKey])
REFERENCES [dbo].[Dim_Borrower] ([BorrowerKey])
GO

ALTER TABLE [dbo].[Fact_Mortgage_Applications] CHECK CONSTRAINT [FK_Fact_Borrower]
GO

ALTER TABLE [dbo].[Fact_Mortgage_Applications]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Loan] FOREIGN KEY([LoanKey])
REFERENCES [dbo].[Dim_Loan] ([LoanKey])
GO

ALTER TABLE [dbo].[Fact_Mortgage_Applications] CHECK CONSTRAINT [FK_Fact_Loan]
GO

ALTER TABLE [dbo].[Fact_Mortgage_Applications]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Property] FOREIGN KEY([PropertyKey])
REFERENCES [dbo].[Dim_Property] ([PropertyKey])
GO

ALTER TABLE [dbo].[Fact_Mortgage_Applications] CHECK CONSTRAINT [FK_Fact_Property]
GO


USE [Mortgage_OLAP]
GO

/****** Object:  Table [dbo].[Final_OLAP_Master]    Script Date: 4/19/2026 1:40:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Final_OLAP_Master](
	[Loan_ID] [int] NULL,
	[Property_ID] [int] NULL,
	[CreditCardAuthorization] [varchar](20) NULL,
	[Referral] [varchar](50) NULL,
	[Loan_Date] [date] NULL,
	[Borrower_FirstName] [varchar](50) NULL,
	[Borrower_LastName] [varchar](50) NULL,
	[Borrower_Email] [varchar](100) NULL,
	[Home_Phone] [varchar](20) NULL,
	[Marital_Status] [varchar](20) NULL,
	[Date_of_Birth] [date] NULL,
	[Current_Street_Address] [varchar](200) NULL,
	[Borrower_City] [varchar](100) NULL,
	[Borrower_State] [varchar](50) NULL,
	[Borrower_Zip] [varchar](20) NULL,
	[YearsAtThisAddress] [int] NULL,
	[Sex] [varchar](10) NULL,
	[Ethnicity] [varchar](50) NULL,
	[Race] [varchar](50) NULL,
	[Property_City] [varchar](100) NULL,
	[Property_State] [varchar](50) NULL,
	[Property_Zip] [varchar](20) NULL,
	[RealEstateAgentName] [varchar](100) NULL,
	[RealEstateAgentPhone] [varchar](20) NULL,
	[RealEstateAgentEmail] [varchar](100) NULL,
	[MonthlyIncome] [decimal](15, 2) NULL,
	[Bonuses] [decimal](15, 2) NULL,
	[Commission] [decimal](15, 2) NULL,
	[OtherIncome] [decimal](15, 2) NULL,
	[Rent_or_Own] [varchar](10) NULL,
	[Checking] [int] NULL,
	[Savings] [int] NULL,
	[RetirementFund] [int] NULL,
	[MutualFund] [int] NULL,
	[Borrower_SSN] [varchar](11) NULL,
	[Source_System] [varchar](20) NULL,
	[Cell_Phone] [varchar](20) NULL
) ON [PRIMARY]
GO


USE [Mortgage0]
GO

/****** Object:  Table [dbo].[Borrower_Details0]    Script Date: 4/19/2026 1:41:46 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Borrower_Details0](
	[SSN] [int] NOT NULL,
	[Borrower_FirstName] [varchar](50) NULL,
	[Borrower_LastName] [varchar](50) NULL,
	[Borrower_Email] [varchar](100) NULL,
	[Home_Phone] [varchar](20) NULL,
	[Cell_Phone] [varchar](20) NULL,
	[Marital_Status] [varchar](20) NULL,
	[Date_of_Birth] [date] NULL,
	[Current_Street_Address] [varchar](200) NULL,
	[City] [varchar](100) NULL,
	[State] [varchar](2) NULL,
	[Zip] [varchar](10) NULL,
	[YearsAtThisAddress] [int] NULL,
	[Sex] [varchar](10) NULL,
	[Ethnicity] [varchar](50) NULL,
	[Race] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[SSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Mortgage0]
GO

/****** Object:  Table [dbo].[Financial_Details]    Script Date: 4/19/2026 1:42:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Financial_Details](
	[SSN] [int] NOT NULL,
	[MonthlyIncome] [varchar](20) NULL,
	[Bonuses] [varchar](20) NULL,
	[Commission] [varchar](20) NULL,
	[OtherIncome] [varchar](20) NULL,
	[Rent_or_Own] [varchar](10) NULL,
	[Checking] [int] NULL,
	[Savings] [int] NULL,
	[RetirementFund] [int] NULL,
	[MutualFund] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Financial_Details]  WITH CHECK ADD FOREIGN KEY([SSN])
REFERENCES [dbo].[Borrower_Details0] ([SSN])
GO


USE [Mortgage0]
GO

/****** Object:  Table [dbo].[Loan_Details]    Script Date: 4/19/2026 1:42:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Loan_Details](
	[Loan_ID] [int] NOT NULL,
	[SSN] [int] NOT NULL,
	[Property_ID] [int] NOT NULL,
	[CreditCardAuthorization] [varchar](20) NULL,
	[Referral] [varchar](50) NULL,
	[Loan_Date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Loan_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Loan_Details]  WITH CHECK ADD FOREIGN KEY([Property_ID])
REFERENCES [dbo].[Property_Details] ([Property_ID])
GO

ALTER TABLE [dbo].[Loan_Details]  WITH CHECK ADD FOREIGN KEY([SSN])
REFERENCES [dbo].[Borrower_Details0] ([SSN])
GO


USE [Mortgage0]
GO

/****** Object:  Table [dbo].[Master_Table_CombinedAll]    Script Date: 4/19/2026 1:43:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Master_Table_CombinedAll](
	[Loan_ID] [int] NULL,
	[Property_ID] [int] NULL,
	[CreditCardAuthorization] [varchar](20) NULL,
	[Referral] [varchar](50) NULL,
	[Loan_Date] [date] NULL,
	[Borrower_FirstName] [varchar](50) NULL,
	[Borrower_LastName] [varchar](50) NULL,
	[Borrower_Email] [varchar](100) NULL,
	[Home_Phone] [varchar](20) NULL,
	[Marital_Status] [varchar](20) NULL,
	[Date_of_Birth] [date] NULL,
	[Current_Street_Address] [varchar](200) NULL,
	[Borrower_City] [varchar](100) NULL,
	[Borrower_State] [varchar](50) NULL,
	[Borrower_Zip] [varchar](20) NULL,
	[YearsAtThisAddress] [int] NULL,
	[Sex] [varchar](10) NULL,
	[Ethnicity] [varchar](50) NULL,
	[Race] [varchar](50) NULL,
	[Property_City] [varchar](100) NULL,
	[Property_State] [varchar](50) NULL,
	[Property_Zip] [varchar](20) NULL,
	[RealEstateAgentName] [varchar](100) NULL,
	[RealEstateAgentPhone] [varchar](20) NULL,
	[RealEstateAgentEmail] [varchar](100) NULL,
	[MonthlyIncome] [decimal](15, 2) NULL,
	[Bonuses] [decimal](15, 2) NULL,
	[Commission] [decimal](15, 2) NULL,
	[OtherIncome] [decimal](15, 2) NULL,
	[Rent_or_Own] [varchar](10) NULL,
	[Checking] [int] NULL,
	[Savings] [int] NULL,
	[RetirementFund] [int] NULL,
	[MutualFund] [int] NULL,
	[Borrower_SSN] [varchar](11) NULL,
	[Source_System] [varchar](20) NULL,
	[Cell_Phone] [varchar](20) NULL
) ON [PRIMARY]
GO


USE [Mortgage0]
GO

/****** Object:  Table [dbo].[mortgage-staging]    Script Date: 4/19/2026 1:43:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mortgage-staging](
	[Borrower_FirstName] [varchar](50) NULL,
	[Borrower_LastName] [varchar](50) NULL,
	[Borrower_Email] [varchar](100) NULL,
	[Borrower_SSN] [varchar](11) NULL,
	[Home_Phone] [varchar](20) NULL,
	[Current Street Address] [varchar](50) NULL,
	[YearsAtThisAddress] [int] NULL,
	[MonthlyIncome] [decimal](15, 2) NULL,
	[Bonuses] [decimal](15, 2) NULL,
	[Commission] [decimal](15, 2) NULL,
	[OtherIncome] [decimal](15, 2) NULL,
	[Purpose_of_Loan] [varchar](20) NULL,
	[Property_Usage] [varchar](20) NULL,
	[LoanAmount] [int] NULL,
	[Purchase_Price] [int] NULL,
	[Number_of_Units] [int] NULL,
	[Sex] [varchar](10) NULL,
	[Ethnicity] [varchar](50) NULL,
	[Race] [varchar](50) NULL,
	[Co_Borrower_FirstName] [varchar](50) NULL,
	[Co_Borrower_LastName] [varchar](50) NULL,
	[Co_Borrower_Email] [varchar](100) NULL,
	[CreditCardAuthorization] [varchar](20) NULL,
	[Checking] [int] NULL,
	[Savings] [int] NULL,
	[RetirementFund] [int] NULL,
	[MutualFund] [int] NULL,
	[Referral] [varchar](50) NULL,
	[RealEstateAgentName] [varchar](100) NULL,
	[RealEstateAgentPhone] [varchar](20) NULL,
	[RealEstateAgentEmail] [varchar](100) NULL,
	[Loan_ID] [int] NULL,
	[Property_ID] [int] NULL,
	[Loan_date] [date] NULL,
	[CellPhone] [varchar](20) NULL,
	[Marital_Status] [varchar](20) NULL,
	[Date_of_Birth] [date] NULL,
	[Current_Street_Address] [varchar](200) NULL,
	[Borrower_City] [varchar](100) NULL,
	[Borrower_State] [varchar](50) NULL,
	[Borrower_Zip] [varchar](20) NULL,
	[Property_City] [varchar](100) NULL,
	[Property_State] [varchar](50) NULL,
	[Property_Zip] [varchar](20) NULL,
	[Rent_or_Own] [varchar](10) NULL
) ON [PRIMARY]
GO


USE [Mortgage0]
GO

/****** Object:  Table [dbo].[Property_Details]    Script Date: 4/19/2026 1:44:19 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Property_Details](
	[Property_ID] [int] NOT NULL,
	[SSN] [int] NOT NULL,
	[Property_City] [varchar](100) NULL,
	[Property_State] [varchar](2) NULL,
	[Property_Zip] [varchar](10) NULL,
	[RealEstateAgentName] [varchar](100) NULL,
	[RealEstateAgentPhone] [varchar](20) NULL,
	[RealEstateAgentEmail] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Property_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Property_Details]  WITH CHECK ADD FOREIGN KEY([SSN])
REFERENCES [dbo].[Borrower_Details0] ([SSN])
GO


USE [Mortgage0]
GO

/****** Object:  Table [dbo].[Stage_XML_Data_Load]    Script Date: 4/19/2026 1:44:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Stage_XML_Data_Load](
	[Loan_ID] [int] NULL,
	[Borrower_SSN] [varchar](11) NULL,
	[BorrowerFirstName] [varchar](50) NULL,
	[BorrowerLastName] [varchar](50) NULL,
	[BorrowerEmail] [varchar](100) NULL,
	[HomePhone] [varchar](20) NULL,
	[CellPhone] [varchar](20) NULL,
	[MaritalStatus] [varchar](50) NULL,
	[DateofBirth] [date] NULL,
	[CurrentCityStreetAddress] [varchar](100) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](2) NULL,
	[Zip] [varchar](10) NULL,
	[YearsAtThisAddress] [int] NULL,
	[Sex] [varchar](10) NULL,
	[Ethnicity] [varchar](20) NULL,
	[Race] [varchar](20) NULL,
	[MonthlyIncome] [decimal](15, 2) NULL,
	[Bonuses] [decimal](15, 2) NULL,
	[Commission] [decimal](15, 2) NULL,
	[OtherIncome] [decimal](15, 2) NULL,
	[RentorOwn] [varchar](50) NULL,
	[Checking] [int] NULL,
	[Savings] [int] NULL,
	[RetirementFund] [int] NULL,
	[MutualFund] [int] NULL,
	[PurposeofLoan] [varchar](50) NULL,
	[Property_ID] [int] NULL,
	[LoanAmount] [int] NULL,
	[PurchasePrice] [int] NULL,
	[NumberofUnits] [int] NULL,
	[CreditCardAuthorization] [varchar](20) NULL,
	[Referral] [varchar](50) NULL,
	[CoBorrowerSSN] [varchar](20) NULL,
	[PropertyUsage] [varchar](50) NULL,
	[PropertyCity] [varchar](50) NULL,
	[PropertyState] [varchar](2) NULL,
	[PropertyZip] [varchar](10) NULL,
	[RealEstateAgentName] [varchar](100) NULL,
	[RealEstateAgentPhone] [varchar](20) NULL,
	[RealEstateAgentEmail] [varchar](100) NULL,
	[Cell_Phone] [varchar](20) NULL,
	[Marital_Status] [varchar](20) NULL,
	[Date_of_Birth] [date] NULL,
	[Current_Street_Address] [varchar](200) NULL,
	[Borrower_City] [varchar](100) NULL,
	[Borrower_State] [varchar](50) NULL,
	[Borrower_Zip] [varchar](20) NULL,
	[Property_City] [varchar](100) NULL,
	[Property_State] [varchar](50) NULL,
	[Property_Zip] [varchar](20) NULL,
	[Rent_or_Own] [varchar](10) NULL,
	[Co_Borrower_FirstName] [varchar](50) NULL,
	[Co_Borrower_LastName] [varchar](50) NULL,
	[Co_Borrower_Email] [varchar](100) NULL,
	[Loan_date] [date] NULL
) ON [PRIMARY]
GO


USE [Mortgage0]
GO

/****** Object:  Table [dbo].[Stage-OLTP_Data_Load]    Script Date: 4/19/2026 1:45:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Stage-OLTP_Data_Load](
	[Loan_ID] [int] NULL,
	[Borrower_SSN] [varchar](11) NULL,
	[Property_ID] [int] NULL,
	[CreditCardAuthorization] [varchar](20) NULL,
	[Referral] [varchar](50) NULL,
	[Loan_Date] [date] NULL,
	[Borrower_FirstName] [varchar](50) NULL,
	[Borrower_LastName] [varchar](50) NULL,
	[Borrower_Email] [varchar](100) NULL,
	[Home_Phone] [varchar](20) NULL,
	[Cell_Phone] [varchar](20) NULL,
	[Marital_Status] [varchar](20) NULL,
	[Date_of_Birth] [date] NULL,
	[Current_Street_Address] [varchar](200) NULL,
	[Borrower_City] [varchar](100) NULL,
	[Borrower_State] [varchar](50) NULL,
	[Borrower_Zip] [varchar](20) NULL,
	[YearsAtThisAddress] [int] NULL,
	[Sex] [varchar](10) NULL,
	[Ethnicity] [varchar](50) NULL,
	[Race] [varchar](50) NULL,
	[Property_City] [varchar](100) NULL,
	[Property_State] [varchar](50) NULL,
	[Property_Zip] [varchar](20) NULL,
	[RealEstateAgentName] [varchar](100) NULL,
	[RealEstateAgentPhone] [varchar](20) NULL,
	[RealEstateAgentEmail] [varchar](100) NULL,
	[MonthlyIncome] [decimal](15, 2) NULL,
	[Bonuses] [decimal](15, 2) NULL,
	[Commission] [decimal](15, 2) NULL,
	[OtherIncome] [decimal](15, 2) NULL,
	[Rent_or_Own] [varchar](10) NULL,
	[Checking] [int] NULL,
	[Savings] [int] NULL,
	[RetirementFund] [int] NULL,
	[MutualFund] [int] NULL
) ON [PRIMARY]
GO


USE [Mortgage_OLAP]
GO

/****** Object:  StoredProcedure [dbo].[proc_LoansProcessed_ToDate]    Script Date: 4/19/2026 1:46:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[proc_LoansProcessed_ToDate]
    @ReportDate DATE
AS
BEGIN
    SELECT 
        -- This logic creates the categories for your Page 9 Pie Chart
        CASE 
            WHEN M.Loan_Date = @ReportDate THEN 'Today'
            WHEN M.Loan_Date >= DATEADD(day, -7, @ReportDate) THEN 'WeekToDate'
            WHEN MONTH(M.Loan_Date) = MONTH(@ReportDate) AND YEAR(M.Loan_Date) = YEAR(@ReportDate) THEN 'MonthToDate'
            ELSE 'YearToDate'
        END AS ToDate,
        DATENAME(month, M.Loan_Date) + ' ' + CAST(YEAR(M.Loan_Date) AS VARCHAR) AS [Report Month],
        M.Borrower_FirstName + ' ' + M.Borrower_LastName AS [BorrowerName],
        F.LoanAmount,
        F.MonthlyIncome
    FROM Fact_Financials F
    JOIN Final_OLAP_Master M ON F.Loan_Key = M.Loan_ID 
    JOIN Dim_Borrower B ON F.Borrower_Key = B.BorrowerKey
    WHERE M.Loan_Date <= @ReportDate;
END;

GO


