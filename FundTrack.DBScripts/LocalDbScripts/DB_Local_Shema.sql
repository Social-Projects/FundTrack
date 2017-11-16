USE [master]
GO
/****** Object:  Database [fundtrackss]    Script Date: 16.11.2017 10:14:52 ******/
CREATE DATABASE [fundtrackss]
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [fundtrackss].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [fundtrackss] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [fundtrackss] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [fundtrackss] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [fundtrackss] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [fundtrackss] SET ARITHABORT OFF 
GO
ALTER DATABASE [fundtrackss] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [fundtrackss] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [fundtrackss] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [fundtrackss] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [fundtrackss] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [fundtrackss] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [fundtrackss] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [fundtrackss] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [fundtrackss] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [fundtrackss] SET  ENABLE_BROKER 
GO
ALTER DATABASE [fundtrackss] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [fundtrackss] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [fundtrackss] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [fundtrackss] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [fundtrackss] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [fundtrackss] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [fundtrackss] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [fundtrackss] SET RECOVERY FULL 
GO
ALTER DATABASE [fundtrackss] SET  MULTI_USER 
GO
ALTER DATABASE [fundtrackss] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [fundtrackss] SET DB_CHAINING OFF 
GO
USE [fundtrackss]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 16.11.2017 10:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	


GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 16.11.2017 10:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 16.11.2017 10:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Building] [nvarchar](100) NOT NULL,
	[City] [nvarchar](100) NOT NULL,
	[Country] [nvarchar](100) NOT NULL,
	[Street] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[AutoImportInterval]    Script Date: 16.11.2017 10:14:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AutoImportInterval](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Interval] [int] NOT NULL,
	[OrgId] [int] NOT NULL,
	[LastUpdateDate] [datetime2](7) NULL,
 CONSTRAINT [PK_AutoImportIntervals] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Balances]    Script Date: 16.11.2017 10:14:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Balances](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[BalanceDate] [datetime] NOT NULL,
	[OrgAccountId] [int] NOT NULL,
 CONSTRAINT [PK_Balance] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[BankAccounts]    Script Date: 16.11.2017 10:14:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankAccounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccNumber] [nvarchar](20) NULL,
	[BankName] [nvarchar](50) NULL,
	[CardNumber] [nvarchar](16) NULL,
	[EDRPOU] [nvarchar](10) NULL,
	[MFO] [nvarchar](6) NULL,
	[MerchantId] [int] NULL,
	[MerchantPassword] [nvarchar](max) NULL,
	[OrgId] [int] NOT NULL,
	[IsDonationEnabled] [bit] NULL,
	[ExtractMerchantId] [int] NULL,
	[ExtractMerchantPassword] [nvarchar](max) NULL,
	[IsExtractEnabled] [bit] NULL,
	[BankId] [int] NOT NULL,
 CONSTRAINT [PK_BankAccount] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[BankImportDetails]    Script Date: 16.11.2017 10:14:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankImportDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [nvarchar](max) NOT NULL,
	[AppCode] [int] NULL,
	[Card] [nvarchar](16) NOT NULL,
	[CardAmount] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Rest] [nvarchar](max) NOT NULL,
	[Terminal] [nvarchar](max) NOT NULL,
	[Trandate] [datetime] NOT NULL,
	[IsLooked] [bit] NOT NULL DEFAULT ((0)),
	[FinOpId] [int] NULL,
 CONSTRAINT [PK_BankImportDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[BankImports]    Script Date: 16.11.2017 10:14:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankImports](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Credit] [decimal](18, 2) NOT NULL,
	[Debet] [decimal](18, 2) NOT NULL,
	[IdMerchant] [int] NOT NULL,
	[Signature] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_BankImport] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Banks]    Script Date: 16.11.2017 10:14:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BankName] [nvarchar](max) NOT NULL,
	[MFO] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Banks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[BannedOrganizations]    Script Date: 16.11.2017 10:14:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BannedOrganizations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[OrganizationId] [int] NOT NULL,
 CONSTRAINT [PK_BannedOrganization] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[BannedUsers]    Script Date: 16.11.2017 10:14:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BannedUsers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_BannedUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Complaints]    Script Date: 16.11.2017 10:14:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Complaints](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[IsLooked] [bit] NOT NULL,
	[OrganizationId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_Complaint] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Currencies]    Script Date: 16.11.2017 10:14:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currencies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](30) NOT NULL,
	[ShortName] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Donations]    Script Date: 16.11.2017 10:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [float] NOT NULL,
	[CurrencyId] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[DonationDate] [datetime2](7) NOT NULL DEFAULT (getutcdate()),
	[DonatorEmail] [nvarchar](max) NULL,
	[OrderId] [uniqueidentifier] NOT NULL,
	[TargetId] [int] NULL,
	[UserId] [int] NULL,
	[OrgAccountId] [int] NOT NULL,
 CONSTRAINT [PK_DonationId] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[EventImages]    Script Date: 16.11.2017 10:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventId] [int] NOT NULL,
	[ImageUrl] [nvarchar](max) NOT NULL,
	[IsMain] [bit] NOT NULL,
 CONSTRAINT [PK_EventImage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Events]    Script Date: 16.11.2017 10:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[OrganizationId] [int] NOT NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ExternalContacts]    Script Date: 16.11.2017 10:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExternalContacts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ServiceId] [int] NOT NULL,
	[ServiceLogin] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_ExternalContact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ExternalServices]    Script Date: 16.11.2017 10:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExternalServices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
 CONSTRAINT [PK_ExternalServices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[FinOpImages]    Script Date: 16.11.2017 10:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FinOpImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FinOpId] [int] NOT NULL,
	[ImageUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_FinOpImages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[FinOps]    Script Date: 16.11.2017 10:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FinOps](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccFromId] [int] NULL,
	[AccToId] [int] NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[DonationId] [int] NULL,
	[FinOpDate] [datetime] NOT NULL DEFAULT (getutcdate()),
	[TargetId] [int] NULL,
	[UserId] [int] NULL,
	[FinOpType] [int] NOT NULL,
 CONSTRAINT [PK_FinOp] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[GoodsCategories]    Script Date: 16.11.2017 10:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GoodsCategories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GoodsTypeId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_GoodsCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[GoodsTypes]    Script Date: 16.11.2017 10:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GoodsTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_GoodsType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Membershipes]    Script Date: 16.11.2017 10:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Membershipes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrgId] [int] NULL,
	[RoleId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_Membership] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[OfferedItemImages]    Script Date: 16.11.2017 10:14:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OfferedItemImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImageUrl] [nvarchar](max) NOT NULL,
	[IsMain] [bit] NOT NULL,
	[OfferedItemId] [int] NOT NULL,
 CONSTRAINT [PK_OfferedItemImage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[OfferedItems]    Script Date: 16.11.2017 10:14:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OfferedItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[GoodsCategoryId] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[StatusId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_OfferedItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[OrgAccounts]    Script Date: 16.11.2017 10:14:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrgAccounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountType] [nvarchar](10) NOT NULL,
	[BankAccId] [int] NULL,
	[CurrencyId] [int] NOT NULL,
	[CurrentBalance] [decimal](18, 2) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[OrgAccountName] [nvarchar](100) NOT NULL,
	[OrgId] [int] NOT NULL,
	[TargetId] [int] NULL,
	[CreationDate] [datetime2](7) NOT NULL DEFAULT ('0001-01-01T00:00:00.000'),
	[UserId] [int] NULL,
 CONSTRAINT [PK_OrgAccount] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[OrgAddresses]    Script Date: 16.11.2017 10:15:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrgAddresses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AddressId] [int] NOT NULL,
	[OrgId] [int] NOT NULL,
 CONSTRAINT [PK_OrgAddress] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[OrganizationResponses]    Script Date: 16.11.2017 10:15:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrganizationResponses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[OfferedItemId] [int] NOT NULL,
	[OrganizationId] [int] NOT NULL,
 CONSTRAINT [PK_OrganizationResponse] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Organizations]    Script Date: 16.11.2017 10:15:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organizations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Name] [nvarchar](100) NOT NULL,
	[LogoUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[PasswordResets]    Script Date: 16.11.2017 10:15:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PasswordResets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExpireDate] [datetime] NOT NULL,
	[GUID] [nvarchar](max) NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_PasswordReset] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Phones]    Script Date: 16.11.2017 10:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Number] [nvarchar](15) NOT NULL,
	[PhoneType] [nvarchar](20) NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[RequestedItemImages]    Script Date: 16.11.2017 10:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestedItemImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImageUrl] [nvarchar](max) NOT NULL,
	[IsMain] [bit] NOT NULL,
	[RequestedItemId] [int] NOT NULL,
 CONSTRAINT [PK_<RequestedItemImage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[RequestedItems]    Script Date: 16.11.2017 10:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestedItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[GoodsCategoryId] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[OrganizationId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_RequestedItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 16.11.2017 10:15:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Statuses]    Script Date: 16.11.2017 10:15:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statuses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[SubscribeOrganizations]    Script Date: 16.11.2017 10:15:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscribeOrganizations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrganizationId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_SubscribeOrganization] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 16.11.2017 10:15:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON),
 CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TagFinOps]    Script Date: 16.11.2017 10:15:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TagFinOps](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FinOpId] [int] NOT NULL,
	[TagId] [int] NOT NULL,
 CONSTRAINT [PK_TagFinOp] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Tags]    Script Date: 16.11.2017 10:15:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagName] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Targets]    Script Date: 16.11.2017 10:15:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Targets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TargetName] [nvarchar](50) NOT NULL,
	[OrganizationId] [int] NULL DEFAULT ((0)),
	[ParentTargetId] [int] NULL,
 CONSTRAINT [PK_Target] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[UserAddresses]    Script Date: 16.11.2017 10:15:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAddresses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AddressId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_UserAddress] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[UserResponses]    Script Date: 16.11.2017 10:15:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserResponses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[OfferedItemId] [int] NULL,
	[RequestedItemId] [int] NOT NULL,
	[StatusId] [int] NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_UserResponse] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Users]    Script Date: 16.11.2017 10:15:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[FB_Link] [nvarchar](max) NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Login] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[PhotoUrl] [nvarchar](max) NULL DEFAULT (N'https://s3.eu-central-1.amazonaws.com/fundtrack/default-user-image.png'),
	[AuthorizationToken] [nvarchar](max) NULL,
	[Salt] [nvarchar](max) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Index [IX_AutoImportInterval_OrgId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_AutoImportInterval_OrgId] ON [dbo].[AutoImportInterval]
(
	[OrgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Balances_OrgAccountId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_Balances_OrgAccountId] ON [dbo].[Balances]
(
	[OrgAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_BankAccounts_BankId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_BankAccounts_BankId] ON [dbo].[BankAccounts]
(
	[BankId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_BankAccounts_OrgId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_BankAccounts_OrgId] ON [dbo].[BankAccounts]
(
	[OrgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_BankImportDetails_FinOpId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_BankImportDetails_FinOpId] ON [dbo].[BankImportDetails]
(
	[FinOpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_BannedOrganizations_OrganizationId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_BannedOrganizations_OrganizationId] ON [dbo].[BannedOrganizations]
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_BannedUsers_UserId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_BannedUsers_UserId] ON [dbo].[BannedUsers]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Complaints_OrganizationId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_Complaints_OrganizationId] ON [dbo].[Complaints]
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Complaints_UserId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_Complaints_UserId] ON [dbo].[Complaints]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Donations_CurrencyId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_Donations_CurrencyId] ON [dbo].[Donations]
(
	[CurrencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Donations_OrgAccountId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_Donations_OrgAccountId] ON [dbo].[Donations]
(
	[OrgAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Donations_TargetId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_Donations_TargetId] ON [dbo].[Donations]
(
	[TargetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Donations_UserId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_Donations_UserId] ON [dbo].[Donations]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_EventImages_EventId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_EventImages_EventId] ON [dbo].[EventImages]
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Events_OrganizationId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_Events_OrganizationId] ON [dbo].[Events]
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_ExternalContacts_ServiceId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_ExternalContacts_ServiceId] ON [dbo].[ExternalContacts]
(
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_ExternalContacts_UserId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_ExternalContacts_UserId] ON [dbo].[ExternalContacts]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_FinOpImages_FinOpId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_FinOpImages_FinOpId] ON [dbo].[FinOpImages]
(
	[FinOpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_FinOps_AccFromId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_FinOps_AccFromId] ON [dbo].[FinOps]
(
	[AccFromId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_FinOps_AccToId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_FinOps_AccToId] ON [dbo].[FinOps]
(
	[AccToId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_FinOps_DonationId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_FinOps_DonationId] ON [dbo].[FinOps]
(
	[DonationId] ASC
)
WHERE ([DonationId] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_FinOps_TargetId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_FinOps_TargetId] ON [dbo].[FinOps]
(
	[TargetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_FinOps_UserId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_FinOps_UserId] ON [dbo].[FinOps]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_GoodsCategories_GoodsTypeId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_GoodsCategories_GoodsTypeId] ON [dbo].[GoodsCategories]
(
	[GoodsTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Membershipes_OrgId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_Membershipes_OrgId] ON [dbo].[Membershipes]
(
	[OrgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Membershipes_RoleId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_Membershipes_RoleId] ON [dbo].[Membershipes]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Membershipes_UserId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Membershipes_UserId] ON [dbo].[Membershipes]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_OfferedItemImages_OfferedItemId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_OfferedItemImages_OfferedItemId] ON [dbo].[OfferedItemImages]
(
	[OfferedItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_OfferedItems_GoodsCategoryId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_OfferedItems_GoodsCategoryId] ON [dbo].[OfferedItems]
(
	[GoodsCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_OfferedItems_StatusId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_OfferedItems_StatusId] ON [dbo].[OfferedItems]
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_OfferedItems_UserId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_OfferedItems_UserId] ON [dbo].[OfferedItems]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_OrgAccounts_BankAccId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_OrgAccounts_BankAccId] ON [dbo].[OrgAccounts]
(
	[BankAccId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_OrgAccounts_CurrencyId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_OrgAccounts_CurrencyId] ON [dbo].[OrgAccounts]
(
	[CurrencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_OrgAccounts_OrgId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_OrgAccounts_OrgId] ON [dbo].[OrgAccounts]
(
	[OrgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_OrgAccounts_TargetId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_OrgAccounts_TargetId] ON [dbo].[OrgAccounts]
(
	[TargetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_OrgAccounts_UserId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_OrgAccounts_UserId] ON [dbo].[OrgAccounts]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_OrgAddresses_AddressId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_OrgAddresses_AddressId] ON [dbo].[OrgAddresses]
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_OrgAddresses_OrgId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_OrgAddresses_OrgId] ON [dbo].[OrgAddresses]
(
	[OrgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_OrganizationResponses_OfferedItemId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_OrganizationResponses_OfferedItemId] ON [dbo].[OrganizationResponses]
(
	[OfferedItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_OrganizationResponses_OrganizationId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_OrganizationResponses_OrganizationId] ON [dbo].[OrganizationResponses]
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_PasswordResets_UserID]    Script Date: 16.11.2017 10:15:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_PasswordResets_UserID] ON [dbo].[PasswordResets]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Phones_UserId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_Phones_UserId] ON [dbo].[Phones]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_RequestedItemImages_RequestedItemId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_RequestedItemImages_RequestedItemId] ON [dbo].[RequestedItemImages]
(
	[RequestedItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_RequestedItems_GoodsCategoryId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_RequestedItems_GoodsCategoryId] ON [dbo].[RequestedItems]
(
	[GoodsCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_RequestedItems_OrganizationId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_RequestedItems_OrganizationId] ON [dbo].[RequestedItems]
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_RequestedItems_StatusId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_RequestedItems_StatusId] ON [dbo].[RequestedItems]
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_SubscribeOrganizations_OrganizationId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_SubscribeOrganizations_OrganizationId] ON [dbo].[SubscribeOrganizations]
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_SubscribeOrganizations_UserId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_SubscribeOrganizations_UserId] ON [dbo].[SubscribeOrganizations]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_TagFinOps_FinOpId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_TagFinOps_FinOpId] ON [dbo].[TagFinOps]
(
	[FinOpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_TagFinOps_TagId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_TagFinOps_TagId] ON [dbo].[TagFinOps]
(
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Targets_OrganizationId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_Targets_OrganizationId] ON [dbo].[Targets]
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_Targets_ParentTargetId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_Targets_ParentTargetId] ON [dbo].[Targets]
(
	[ParentTargetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_UserAddresses_AddressId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_UserAddresses_AddressId] ON [dbo].[UserAddresses]
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_UserAddresses_UserId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_UserAddresses_UserId] ON [dbo].[UserAddresses]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_UserResponses_OfferedItemId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UserResponses_OfferedItemId] ON [dbo].[UserResponses]
(
	[OfferedItemId] ASC
)
WHERE ([OfferedItemId] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_UserResponses_RequestedItemId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_UserResponses_RequestedItemId] ON [dbo].[UserResponses]
(
	[RequestedItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_UserResponses_StatusId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_UserResponses_StatusId] ON [dbo].[UserResponses]
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/****** Object:  Index [IX_UserResponses_UserId]    Script Date: 16.11.2017 10:15:05 ******/
CREATE NONCLUSTERED INDEX [IX_UserResponses_UserId] ON [dbo].[UserResponses]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[AutoImportInterval]  WITH CHECK ADD  CONSTRAINT [FK_AutoImportIntervals_Organization] FOREIGN KEY([OrgId])
REFERENCES [dbo].[Organizations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AutoImportInterval] CHECK CONSTRAINT [FK_AutoImportIntervals_Organization]
GO
ALTER TABLE [dbo].[Balances]  WITH CHECK ADD  CONSTRAINT [FK_Balance_OrgAccount] FOREIGN KEY([OrgAccountId])
REFERENCES [dbo].[OrgAccounts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Balances] CHECK CONSTRAINT [FK_Balance_OrgAccount]
GO
ALTER TABLE [dbo].[BankAccounts]  WITH CHECK ADD  CONSTRAINT [FK_BankAccount_Bank] FOREIGN KEY([BankId])
REFERENCES [dbo].[Banks] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BankAccounts] CHECK CONSTRAINT [FK_BankAccount_Bank]
GO
ALTER TABLE [dbo].[BankAccounts]  WITH CHECK ADD  CONSTRAINT [FK_BankAccount_Organization] FOREIGN KEY([OrgId])
REFERENCES [dbo].[Organizations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BankAccounts] CHECK CONSTRAINT [FK_BankAccount_Organization]
GO
ALTER TABLE [dbo].[BankAccounts]  WITH CHECK ADD  CONSTRAINT [FK_BankAccounts_Bank] FOREIGN KEY([BankId])
REFERENCES [dbo].[Banks] ([Id])
GO
ALTER TABLE [dbo].[BankAccounts] CHECK CONSTRAINT [FK_BankAccounts_Bank]
GO
ALTER TABLE [dbo].[BankImportDetails]  WITH CHECK ADD  CONSTRAINT [FK_BankImportDetails_FinOp] FOREIGN KEY([FinOpId])
REFERENCES [dbo].[FinOps] ([Id])
GO
ALTER TABLE [dbo].[BankImportDetails] CHECK CONSTRAINT [FK_BankImportDetails_FinOp]
GO
ALTER TABLE [dbo].[BannedOrganizations]  WITH CHECK ADD  CONSTRAINT [FK_BannedOrganization_Organization] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organizations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BannedOrganizations] CHECK CONSTRAINT [FK_BannedOrganization_Organization]
GO
ALTER TABLE [dbo].[BannedUsers]  WITH CHECK ADD  CONSTRAINT [FK_BannedUser_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BannedUsers] CHECK CONSTRAINT [FK_BannedUser_User]
GO
ALTER TABLE [dbo].[Complaints]  WITH CHECK ADD  CONSTRAINT [FK_Complaint_Organization] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organizations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Complaints] CHECK CONSTRAINT [FK_Complaint_Organization]
GO
ALTER TABLE [dbo].[Complaints]  WITH CHECK ADD  CONSTRAINT [FK_Complaint_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Complaints] CHECK CONSTRAINT [FK_Complaint_User]
GO
ALTER TABLE [dbo].[Donations]  WITH CHECK ADD  CONSTRAINT [FK_Donation_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currencies] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Donations] CHECK CONSTRAINT [FK_Donation_Currency]
GO
ALTER TABLE [dbo].[Donations]  WITH CHECK ADD  CONSTRAINT [FK_Donation_Target] FOREIGN KEY([TargetId])
REFERENCES [dbo].[Targets] ([Id])
GO
ALTER TABLE [dbo].[Donations] CHECK CONSTRAINT [FK_Donation_Target]
GO
ALTER TABLE [dbo].[Donations]  WITH CHECK ADD  CONSTRAINT [FK_Donation_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Donations] CHECK CONSTRAINT [FK_Donation_User]
GO
ALTER TABLE [dbo].[Donations]  WITH CHECK ADD  CONSTRAINT [FK_Donations_OrgAccounts_OrgAccountId] FOREIGN KEY([OrgAccountId])
REFERENCES [dbo].[OrgAccounts] ([Id])
GO
ALTER TABLE [dbo].[Donations] CHECK CONSTRAINT [FK_Donations_OrgAccounts_OrgAccountId]
GO
ALTER TABLE [dbo].[EventImages]  WITH CHECK ADD  CONSTRAINT [FK_EvantImage_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Events] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventImages] CHECK CONSTRAINT [FK_EvantImage_Event]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Event_Organization] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organizations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Event_Organization]
GO
ALTER TABLE [dbo].[ExternalContacts]  WITH CHECK ADD  CONSTRAINT [FK_ExternalContact_ExternalService] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[ExternalServices] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ExternalContacts] CHECK CONSTRAINT [FK_ExternalContact_ExternalService]
GO
ALTER TABLE [dbo].[ExternalContacts]  WITH CHECK ADD  CONSTRAINT [FK_ExternalContact_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ExternalContacts] CHECK CONSTRAINT [FK_ExternalContact_User]
GO
ALTER TABLE [dbo].[FinOpImages]  WITH CHECK ADD  CONSTRAINT [FK_FinOpImages_FinOps_FinOpId] FOREIGN KEY([FinOpId])
REFERENCES [dbo].[FinOps] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FinOpImages] CHECK CONSTRAINT [FK_FinOpImages_FinOps_FinOpId]
GO
ALTER TABLE [dbo].[FinOps]  WITH CHECK ADD  CONSTRAINT [FK_FinOp_OrgAccountFrom] FOREIGN KEY([AccFromId])
REFERENCES [dbo].[OrgAccounts] ([Id])
GO
ALTER TABLE [dbo].[FinOps] CHECK CONSTRAINT [FK_FinOp_OrgAccountFrom]
GO
ALTER TABLE [dbo].[FinOps]  WITH CHECK ADD  CONSTRAINT [FK_FinOp_OrgAccountTo] FOREIGN KEY([AccToId])
REFERENCES [dbo].[OrgAccounts] ([Id])
GO
ALTER TABLE [dbo].[FinOps] CHECK CONSTRAINT [FK_FinOp_OrgAccountTo]
GO
ALTER TABLE [dbo].[FinOps]  WITH CHECK ADD  CONSTRAINT [FK_FinOp_Target] FOREIGN KEY([TargetId])
REFERENCES [dbo].[Targets] ([Id])
GO
ALTER TABLE [dbo].[FinOps] CHECK CONSTRAINT [FK_FinOp_Target]
GO
ALTER TABLE [dbo].[FinOps]  WITH CHECK ADD  CONSTRAINT [FK_FinOp_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[FinOps] CHECK CONSTRAINT [FK_FinOp_User]
GO
ALTER TABLE [dbo].[FinOps]  WITH CHECK ADD  CONSTRAINT [FK_FinOps_Donations_DonationId] FOREIGN KEY([DonationId])
REFERENCES [dbo].[Donations] ([Id])
GO
ALTER TABLE [dbo].[FinOps] CHECK CONSTRAINT [FK_FinOps_Donations_DonationId]
GO
ALTER TABLE [dbo].[GoodsCategories]  WITH CHECK ADD  CONSTRAINT [FK_GoodsCategory_GoodsType] FOREIGN KEY([GoodsTypeId])
REFERENCES [dbo].[GoodsTypes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GoodsCategories] CHECK CONSTRAINT [FK_GoodsCategory_GoodsType]
GO
ALTER TABLE [dbo].[Membershipes]  WITH CHECK ADD  CONSTRAINT [FK_Membership_Organization] FOREIGN KEY([OrgId])
REFERENCES [dbo].[Organizations] ([Id])
GO
ALTER TABLE [dbo].[Membershipes] CHECK CONSTRAINT [FK_Membership_Organization]
GO
ALTER TABLE [dbo].[Membershipes]  WITH CHECK ADD  CONSTRAINT [FK_Membership_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Membershipes] CHECK CONSTRAINT [FK_Membership_Role]
GO
ALTER TABLE [dbo].[Membershipes]  WITH CHECK ADD  CONSTRAINT [FK_Membership_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Membershipes] CHECK CONSTRAINT [FK_Membership_User]
GO
ALTER TABLE [dbo].[OfferedItemImages]  WITH CHECK ADD  CONSTRAINT [FK_OfferedItemImage_OfferedItem] FOREIGN KEY([OfferedItemId])
REFERENCES [dbo].[OfferedItems] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OfferedItemImages] CHECK CONSTRAINT [FK_OfferedItemImage_OfferedItem]
GO
ALTER TABLE [dbo].[OfferedItems]  WITH CHECK ADD  CONSTRAINT [FK_OfferedItems_GoodsCategory] FOREIGN KEY([GoodsCategoryId])
REFERENCES [dbo].[GoodsCategories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OfferedItems] CHECK CONSTRAINT [FK_OfferedItems_GoodsCategory]
GO
ALTER TABLE [dbo].[OfferedItems]  WITH CHECK ADD  CONSTRAINT [FK_OfferedItems_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Statuses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OfferedItems] CHECK CONSTRAINT [FK_OfferedItems_Status]
GO
ALTER TABLE [dbo].[OfferedItems]  WITH CHECK ADD  CONSTRAINT [FK_OfferedItems_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OfferedItems] CHECK CONSTRAINT [FK_OfferedItems_Users_UserId]
GO
ALTER TABLE [dbo].[OrgAccounts]  WITH CHECK ADD  CONSTRAINT [FK_OrgAccount_BankAccount] FOREIGN KEY([BankAccId])
REFERENCES [dbo].[BankAccounts] ([Id])
GO
ALTER TABLE [dbo].[OrgAccounts] CHECK CONSTRAINT [FK_OrgAccount_BankAccount]
GO
ALTER TABLE [dbo].[OrgAccounts]  WITH CHECK ADD  CONSTRAINT [FK_OrgAccount_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currencies] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrgAccounts] CHECK CONSTRAINT [FK_OrgAccount_Currency]
GO
ALTER TABLE [dbo].[OrgAccounts]  WITH CHECK ADD  CONSTRAINT [FK_OrgAccount_Organization] FOREIGN KEY([OrgId])
REFERENCES [dbo].[Organizations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrgAccounts] CHECK CONSTRAINT [FK_OrgAccount_Organization]
GO
ALTER TABLE [dbo].[OrgAccounts]  WITH CHECK ADD  CONSTRAINT [FK_OrgAccount_Targets] FOREIGN KEY([TargetId])
REFERENCES [dbo].[Targets] ([Id])
GO
ALTER TABLE [dbo].[OrgAccounts] CHECK CONSTRAINT [FK_OrgAccount_Targets]
GO
ALTER TABLE [dbo].[OrgAccounts]  WITH CHECK ADD  CONSTRAINT [FK_OrgAccounts_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[OrgAccounts] CHECK CONSTRAINT [FK_OrgAccounts_Users_UserId]
GO
ALTER TABLE [dbo].[OrgAddresses]  WITH CHECK ADD  CONSTRAINT [FK_OrgAddress_Address] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Addresses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrgAddresses] CHECK CONSTRAINT [FK_OrgAddress_Address]
GO
ALTER TABLE [dbo].[OrgAddresses]  WITH CHECK ADD  CONSTRAINT [FK_OrgAddress_Organization] FOREIGN KEY([OrgId])
REFERENCES [dbo].[Organizations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrgAddresses] CHECK CONSTRAINT [FK_OrgAddress_Organization]
GO
ALTER TABLE [dbo].[OrganizationResponses]  WITH CHECK ADD  CONSTRAINT [FK_OrganizationResponse_OfferedItem] FOREIGN KEY([OfferedItemId])
REFERENCES [dbo].[OfferedItems] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrganizationResponses] CHECK CONSTRAINT [FK_OrganizationResponse_OfferedItem]
GO
ALTER TABLE [dbo].[OrganizationResponses]  WITH CHECK ADD  CONSTRAINT [FK_OrganizationResponse_Organization] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organizations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrganizationResponses] CHECK CONSTRAINT [FK_OrganizationResponse_Organization]
GO
ALTER TABLE [dbo].[PasswordResets]  WITH CHECK ADD  CONSTRAINT [FK_PasswordReset_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PasswordResets] CHECK CONSTRAINT [FK_PasswordReset_User]
GO
ALTER TABLE [dbo].[Phones]  WITH CHECK ADD  CONSTRAINT [FK_Phone_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Phones] CHECK CONSTRAINT [FK_Phone_User]
GO
ALTER TABLE [dbo].[RequestedItemImages]  WITH CHECK ADD  CONSTRAINT [FK_<RequestedItemImage_<RequestedItem] FOREIGN KEY([RequestedItemId])
REFERENCES [dbo].[RequestedItems] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RequestedItemImages] CHECK CONSTRAINT [FK_<RequestedItemImage_<RequestedItem]
GO
ALTER TABLE [dbo].[RequestedItems]  WITH CHECK ADD  CONSTRAINT [FK_RequestedItem_GoodsCategory] FOREIGN KEY([GoodsCategoryId])
REFERENCES [dbo].[GoodsCategories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RequestedItems] CHECK CONSTRAINT [FK_RequestedItem_GoodsCategory]
GO
ALTER TABLE [dbo].[RequestedItems]  WITH CHECK ADD  CONSTRAINT [FK_RequestedItem_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Statuses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RequestedItems] CHECK CONSTRAINT [FK_RequestedItem_Status]
GO
ALTER TABLE [dbo].[RequestedItems]  WITH CHECK ADD  CONSTRAINT [FK_RequestedItems_Organizations_OrganizationId] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organizations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RequestedItems] CHECK CONSTRAINT [FK_RequestedItems_Organizations_OrganizationId]
GO
ALTER TABLE [dbo].[SubscribeOrganizations]  WITH CHECK ADD  CONSTRAINT [FK_SubscribeOrganization_Organization] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organizations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SubscribeOrganizations] CHECK CONSTRAINT [FK_SubscribeOrganization_Organization]
GO
ALTER TABLE [dbo].[SubscribeOrganizations]  WITH CHECK ADD  CONSTRAINT [FK_SubscribeOrganization_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SubscribeOrganizations] CHECK CONSTRAINT [FK_SubscribeOrganization_User]
GO
ALTER TABLE [dbo].[TagFinOps]  WITH CHECK ADD  CONSTRAINT [FK_TagFinOp_FinOp] FOREIGN KEY([FinOpId])
REFERENCES [dbo].[FinOps] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TagFinOps] CHECK CONSTRAINT [FK_TagFinOp_FinOp]
GO
ALTER TABLE [dbo].[TagFinOps]  WITH CHECK ADD  CONSTRAINT [FK_TagFinOp_Tag] FOREIGN KEY([TagId])
REFERENCES [dbo].[Tags] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TagFinOps] CHECK CONSTRAINT [FK_TagFinOp_Tag]
GO
ALTER TABLE [dbo].[Targets]  WITH CHECK ADD  CONSTRAINT [FK_Targets_Organizations_OrganizationId] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organizations] ([Id])
GO
ALTER TABLE [dbo].[Targets] CHECK CONSTRAINT [FK_Targets_Organizations_OrganizationId]
GO
ALTER TABLE [dbo].[Targets]  WITH CHECK ADD  CONSTRAINT [FK_Targets_Targets_ParentTargetId] FOREIGN KEY([ParentTargetId])
REFERENCES [dbo].[Targets] ([Id])
GO
ALTER TABLE [dbo].[Targets] CHECK CONSTRAINT [FK_Targets_Targets_ParentTargetId]
GO
ALTER TABLE [dbo].[UserAddresses]  WITH CHECK ADD  CONSTRAINT [FK_UserAddress_Address] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Addresses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserAddresses] CHECK CONSTRAINT [FK_UserAddress_Address]
GO
ALTER TABLE [dbo].[UserAddresses]  WITH CHECK ADD  CONSTRAINT [FK_UserAddress_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserAddresses] CHECK CONSTRAINT [FK_UserAddress_User]
GO
ALTER TABLE [dbo].[UserResponses]  WITH CHECK ADD  CONSTRAINT [FK_UserResponse_OfferedItem] FOREIGN KEY([OfferedItemId])
REFERENCES [dbo].[OfferedItems] ([Id])
GO
ALTER TABLE [dbo].[UserResponses] CHECK CONSTRAINT [FK_UserResponse_OfferedItem]
GO
ALTER TABLE [dbo].[UserResponses]  WITH CHECK ADD  CONSTRAINT [FK_UserResponse_RequestedItem] FOREIGN KEY([RequestedItemId])
REFERENCES [dbo].[RequestedItems] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserResponses] CHECK CONSTRAINT [FK_UserResponse_RequestedItem]
GO
ALTER TABLE [dbo].[UserResponses]  WITH CHECK ADD  CONSTRAINT [FK_UserResponse_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Statuses] ([Id])
GO
ALTER TABLE [dbo].[UserResponses] CHECK CONSTRAINT [FK_UserResponse_Status]
GO
ALTER TABLE [dbo].[UserResponses]  WITH CHECK ADD  CONSTRAINT [FK_UserResponse_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserResponses] CHECK CONSTRAINT [FK_UserResponse_User]
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 16.11.2017 10:15:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	


GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 16.11.2017 10:15:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	


GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 16.11.2017 10:15:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	


GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 16.11.2017 10:15:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	


GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 16.11.2017 10:15:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	


GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 16.11.2017 10:15:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	


GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 16.11.2017 10:15:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	


GO
USE [master]
GO
ALTER DATABASE [fundtrackss] SET  READ_WRITE 
GO
