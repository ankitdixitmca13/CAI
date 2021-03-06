USE [master]
GO
/****** Object:  Database [DB_CAI]    Script Date: 04-01-2020 10:57:39 AM ******/
CREATE DATABASE [DB_CAI]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_CAI', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\DB_CAI.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DB_CAI_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\DB_CAI_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DB_CAI] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_CAI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_CAI] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_CAI] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_CAI] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_CAI] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_CAI] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_CAI] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DB_CAI] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_CAI] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_CAI] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_CAI] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_CAI] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_CAI] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_CAI] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_CAI] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_CAI] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DB_CAI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_CAI] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_CAI] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_CAI] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_CAI] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_CAI] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_CAI] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_CAI] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DB_CAI] SET  MULTI_USER 
GO
ALTER DATABASE [DB_CAI] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_CAI] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_CAI] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_CAI] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DB_CAI] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DB_CAI]
GO
/****** Object:  Table [dbo].[tblAMC]    Script Date: 04-01-2020 10:57:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAMC](
	[tStamp] [timestamp] NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AMCName] [nvarchar](50) NULL,
	[TimeStamp] [datetime] NULL,
 CONSTRAINT [PK_tblAMC] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblBankAccount]    Script Date: 04-01-2020 10:57:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBankAccount](
	[tStamp] [timestamp] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[BankName] [nvarchar](20) NULL,
	[IFSC] [nvarchar](50) NULL,
	[AccountNumber] [nvarchar](50) NULL,
	[AccountTyepe] [nvarchar](50) NULL,
	[IsPrimary] [nchar](10) NULL,
	[TimeStamp] [datetime] NULL,
 CONSTRAINT [PK_tblBankAccount] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblFund]    Script Date: 04-01-2020 10:57:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFund](
	[tStamp] [timestamp] NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AMCId] [int] NULL,
	[FundName] [nvarchar](50) NULL,
	[Offer] [nvarchar](50) NULL,
	[RTA] [nvarchar](10) NULL,
	[SchemeCode] [nvarchar](50) NULL,
	[TimeStamp] [datetime] NULL,
 CONSTRAINT [PK_tblFund] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProfile]    Script Date: 04-01-2020 10:57:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProfile](
	[tStamp] [timestamp] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[FirstName] [nvarchar](20) NULL,
	[MiddleName] [nvarchar](20) NULL,
	[LastName] [nvarchar](20) NULL,
	[CountryCode] [nvarchar](10) NULL,
	[PhoneNo] [nvarchar](15) NULL,
	[AltPhoneNo] [nvarchar](15) NULL,
	[PANNo] [nvarchar](10) NULL,
	[UID] [nvarchar](20) NULL,
	[IsResident] [nvarchar](10) NULL,
	[TimeStamp] [datetime] NULL,
 CONSTRAINT [PK_tblProfile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 04-01-2020 10:57:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblScheme]    Script Date: 04-01-2020 10:57:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblScheme](
	[tStamp] [timestamp] NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SchemeName] [nvarchar](50) NULL,
	[TimeStamp] [datetime] NULL,
 CONSTRAINT [PK_tblScheme] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 04-01-2020 10:57:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[tStamp] [timestamp] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[UserName] [nvarchar](50) NULL,
	[EmailId] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[TimeStamp] [datetime] NULL,
	[IsActivated] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  StoredProcedure [dbo].[usp_AddUsers]    Script Date: 04-01-2020 10:57:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ankit Dixit
-- Create date: 19-11-2019
-- Description:	Add record in tblUser table.
-- =============================================
CREATE PROCEDURE [dbo].[usp_AddUsers]   
	-- Add the parameters for the stored procedure here
	@UserName NVARCHAR(50),
	@EmailId NVARCHAR(50),
	@Password NVARCHAR(50),
	@IsActivated BIT=true,
	@IsDeleted BIT=false	
AS
BEGIN TRY
 DECLARE
   @TimeStamp DATE;
	SET @TimeStamp= GETDATE()
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRANSACTION trInsertUser;
    -- Insert statements for procedure here
	INSERT INTO dbo.tblUser(RoleId,UserName,EmailId,[Password],[TimeStamp],IsActivated,IsDeleted)
	             VALUES(1,@UserName,@EmailId,@Password,@TimeStamp,@IsActivated,@IsDeleted)
	COMMIT TRANSACTION trInsertUser;
END TRY
  BEGIN CATCH
        -- report exception
        EXEC dbo.usp_Report_Error;       
        -- Test if the transaction is uncommittable.  
        IF (XACT_STATE()) = -1  
        BEGIN   
            ROLLBACK TRANSACTION trInsertUser;  
        END;  		  
    END CATCH

GO
/****** Object:  StoredProcedure [dbo].[usp_GetUserById]    Script Date: 04-01-2020 10:57:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ankit Dixit
-- Create date: 03-12-2019
-- Description:	Get User detail by id
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetUserById] 
@Id INT  
AS  
BEGIN  
-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;  
    -- Select statements for procedure here
SELECT * FROM tblUser WHERE Id = @Id;  
END  

GO
/****** Object:  StoredProcedure [dbo].[usp_Report_Error]    Script Date: 04-01-2020 10:57:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ankit Dixit
-- Create date: 19-11-2019
-- Description: Raise The Error during the perform proc call in catch block
-- =============================================
CREATE PROC [dbo].[usp_Report_Error]
AS
BEGIN
    DECLARE @ErrorNumber INT;
	DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
	DECLARE @ErrorLine INT;
	DECLARE @ErrorProcedure NVARCHAR(50);
	DECLARE @ErrorMessage NVARCHAR(max);
    SELECT   
       @ErrorNumber= ERROR_NUMBER(), 
        @ErrorSeverity=ERROR_SEVERITY(),
        @ErrorState=ERROR_STATE(),
        @ErrorLine=ERROR_LINE (), 
        @ErrorProcedure=ERROR_PROCEDURE(),
        @ErrorMessage=ERROR_MESSAGE(); 
 RAISERROR (@ErrorNumber, -- Error Number.  
             @ErrorSeverity, -- Severity.  
             @ErrorState, -- State. 
			 @ErrorLine,--Line number
			 @ErrorProcedure, --Proc Name
			 @ErrorMessage -- Message text
             ); 		 
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateUser]    Script Date: 04-01-2020 10:57:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ankit Dixit
-- Create date: 03-12-2019
-- Description:	Update User detail by id
-- =============================================
CREATE PROCEDURE[dbo].[usp_UpdateUser]  
-- Add the parameters for the stored procedure here
@Id INT,
	@UserName NVARCHAR(50),
	@EmailId NVARCHAR(50),
	@Password NVARCHAR(50),
	@IsActivated BIT,
	@IsDeleted BIT 
AS  
BEGIN  
--set current date and time for last updation
BEGIN TRY
DECLARE @TimeStamp DATE;
	SET @TimeStamp= GETDATE()
-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;  
BEGIN TRANSACTION trUpdateUser;
 -- Update statements for procedure here
UPDATE tblUser SET  
    UserName = @UserName,    
    EmailId = @EmailId,  
    [Password] = @Password,
	[TimeStamp]= @TimeStamp, 
    @IsActivated = @IsActivated,  
    @IsDeleted = @IsDeleted 
WHERE Id = @Id  
COMMIT TRANSACTION trUpdateUser;
END TRY
BEGIN CATCH
        -- report exception
        EXEC dbo.usp_Report_Error;       
        -- Test if the transaction is uncommittable.  
        IF (XACT_STATE()) = -1  
        BEGIN   
            ROLLBACK TRANSACTION trUpdateUser;  
        END;  		  
    END CATCH
END  

GO
USE [master]
GO
ALTER DATABASE [DB_CAI] SET  READ_WRITE 
GO
