USE [master]
GO
/****** Object:  Database [DB_CAI]    Script Date: 3/14/2020 10:25:37 AM ******/
CREATE DATABASE [DB_CAI]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_CAI', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.RAM\MSSQL\DATA\DB_CAI.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DB_CAI_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.RAM\MSSQL\DATA\DB_CAI_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DB_CAI] SET COMPATIBILITY_LEVEL = 110
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
ALTER DATABASE [DB_CAI] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DB_CAI] SET AUTO_CREATE_STATISTICS ON 
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
ALTER DATABASE [DB_CAI] SET  DISABLE_BROKER 
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
USE [DB_CAI]
GO
/****** Object:  StoredProcedure [dbo].[usp_AddUsers]    Script Date: 3/14/2020 10:25:38 AM ******/
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
	@MobileNo NVARCHAR(20),
	@IsActivated BIT=true,
	@IsDeleted BIT=false	
AS
BEGIN TRY
 DECLARE @UserIdTemp INT,
   @TimeStamp DATE;
	SET @TimeStamp= GETDATE()
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRANSACTION trInsertUser;
    -- Insert statements for procedure here
	INSERT INTO dbo.tblUser(RoleId,UserName,EmailId,[Password],[MobileNo],[TimeStamp],IsActivated,IsDeleted)
	             VALUES(1,@UserName,@EmailId,@Password,@MobileNo,@TimeStamp,1,0)
	
	SET @UserIdTemp =@@IDENTITY

	INSERT INTO [dbo].[tblProfile]
           ([UserId]
           ,[FirstName]
           ,[MiddleName]
           ,[LastName]
           ,[CountryCode]
           ,[PhoneNo]
           ,[AltPhoneNo]
           ,[PANNo]
           ,[UID]
           ,[IsResident]
           ,[TimeStamp])
     VALUES
           (
		   @UserIdTemp
           ,NULL
		   ,NULL
		   ,NULL
		   ,NULL
		   ,NULL
		   ,NULL
		   ,NULL
		   ,NULL
		   ,NULL
           ,GETDATE()
		   )

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
/****** Object:  StoredProcedure [dbo].[usp_BankAccountDelete]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_BankAccountDelete]
(
	@Id int
)

AS

SET NOCOUNT ON

DELETE FROM [tblBankAccount]
WHERE [Id] = @Id

GO
/****** Object:  StoredProcedure [dbo].[usp_BankAccountInsert]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_BankAccountInsert]
(
	@UserId int,
	@BankName nvarchar(20),
	@IFSC nvarchar(50),
	@AccountNumber nvarchar(50),
	@AccountTyepe nvarchar(50),
	@IsPrimary nchar(10),
	@TimeStamp datetime
)

AS

SET NOCOUNT ON

INSERT INTO [tblBankAccount]
(
	[UserId],
	[BankName],
	[IFSC],
	[AccountNumber],
	[AccountTyepe],
	[IsPrimary],
	[TimeStamp]
)
VALUES
(
	@UserId,
	@BankName,
	@IFSC,
	@AccountNumber,
	@AccountTyepe,
	@IsPrimary,
	@TimeStamp
)

SELECT SCOPE_IDENTITY()

GO
/****** Object:  StoredProcedure [dbo].[usp_BankAccountSelect]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_BankAccountSelect]
(
	@Id int
)

AS

SET NOCOUNT ON

SELECT 
	[Id],
	[UserId],
	[BankName],
	[IFSC],
	[AccountNumber],
	[AccountTyepe],
	[IsPrimary],
	[TimeStamp]
FROM [tblBankAccount]
WHERE [Id] = @Id

GO
/****** Object:  StoredProcedure [dbo].[usp_BankAccountSelectAll]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_BankAccountSelectAll]

AS

SET NOCOUNT ON

SELECT 	[Id],
	[UserId],
	[BankName],
	[IFSC],
	[AccountNumber],
	[AccountTyepe],
	[IsPrimary],
	[TimeStamp]
FROM [tblBankAccount]

GO
/****** Object:  StoredProcedure [dbo].[usp_BankAccountUpdate]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_BankAccountUpdate]
(
	@Id int,
	@UserId int,
	@BankName nvarchar(20),
	@IFSC nvarchar(50),
	@AccountNumber nvarchar(50),
	@AccountTyepe nvarchar(50),
	@IsPrimary nchar(10),
	@TimeStamp datetime
)

AS

SET NOCOUNT ON

UPDATE [tblBankAccount]
SET	[UserId] = @UserId,
	[BankName] = @BankName,
	[IFSC] = @IFSC,
	[AccountNumber] = @AccountNumber,
	[AccountTyepe] = @AccountTyepe,
	[IsPrimary] = @IsPrimary,
	[TimeStamp] = @TimeStamp
WHERE [Id] = @Id

GO
/****** Object:  StoredProcedure [dbo].[usp_GetUserById]    Script Date: 3/14/2020 10:25:38 AM ******/
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
SELECT * FROM tblUser usr
INNER JOIN tblProfile  profile ON usr.Id=profile.UserId WHERE usr.Id = @Id;  
END  


GO
/****** Object:  StoredProcedure [dbo].[usp_ProfileDelete]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_ProfileDelete]
(
	@Id int
)

AS

SET NOCOUNT ON

DELETE FROM [tblProfile]
WHERE [Id] = @Id

GO
/****** Object:  StoredProcedure [dbo].[usp_ProfileInsert]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_ProfileInsert]
(
	@UserId int,
	@FirstName nvarchar(20),
	@MiddleName nvarchar(20),
	@LastName nvarchar(20),
	@CountryCode nvarchar(10),
	@PhoneNo nvarchar(15),
	@AltPhoneNo nvarchar(15),
	@PANNo nvarchar(10),
	@UID nvarchar(20),
	@IsResident nvarchar(10),
	@TimeStamp datetime
)

AS

SET NOCOUNT ON

INSERT INTO [tblProfile]
(
	[UserId],
	[FirstName],
	[MiddleName],
	[LastName],
	[CountryCode],
	[PhoneNo],
	[AltPhoneNo],
	[PANNo],
	[UID],
	[IsResident],
	[TimeStamp]
)
VALUES
(
	@UserId,
	@FirstName,
	@MiddleName,
	@LastName,
	@CountryCode,
	@PhoneNo,
	@AltPhoneNo,
	@PANNo,
	@UID,
	@IsResident,
	@TimeStamp
)

SELECT SCOPE_IDENTITY()

GO
/****** Object:  StoredProcedure [dbo].[usp_ProfileSelect]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_ProfileSelect]
(
	@Id int
)

AS

SET NOCOUNT ON

SELECT 
	[Id],
	[UserId],
	[FirstName],
	[MiddleName],
	[LastName],
	[CountryCode],
	[PhoneNo],
	[AltPhoneNo],
	[PANNo],
	[UID],
	[IsResident],
	[TimeStamp]
FROM [tblProfile]
WHERE [Id] = @Id

GO
/****** Object:  StoredProcedure [dbo].[usp_ProfileSelectAll]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_ProfileSelectAll]

AS

SET NOCOUNT ON

SELECT [tStamp],
	[Id],
	[UserId],
	[FirstName],
	[MiddleName],
	[LastName],
	[CountryCode],
	[PhoneNo],
	[AltPhoneNo],
	[PANNo],
	[UID],
	[IsResident],
	[TimeStamp]
FROM [tblProfile]

GO
/****** Object:  StoredProcedure [dbo].[usp_ProfileUpdate]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_ProfileUpdate]
(
	@Id int,
	@UserId int,
	@FirstName nvarchar(20),
	@MiddleName nvarchar(20),
	@LastName nvarchar(20),
	@CountryCode nvarchar(10),
	@PhoneNo nvarchar(15),
	@AltPhoneNo nvarchar(15),
	@PANNo nvarchar(10),
	@UID nvarchar(20),
	@IsResident nvarchar(10),
	@TimeStamp datetime
)

AS

SET NOCOUNT ON

UPDATE [tblProfile]
SET [UserId] = @UserId,
	[FirstName] = @FirstName,
	[MiddleName] = @MiddleName,
	[LastName] = @LastName,
	[CountryCode] = @CountryCode,
	[PhoneNo] = @PhoneNo,
	[AltPhoneNo] = @AltPhoneNo,
	[PANNo] = @PANNo,
	[UID] = @UID,
	[IsResident] = @IsResident,
	[TimeStamp] = @TimeStamp
WHERE [Id] = @Id

GO
/****** Object:  StoredProcedure [dbo].[usp_Report_Error]    Script Date: 3/14/2020 10:25:38 AM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_UpdateEmailConfirmation]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ram Nunna
-- Create date: 09-MAR-2020
-- Description:	Update confirm email info
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdateEmailConfirmation] 
@EmailId NVARCHAR(50)  
AS  
BEGIN  
UPDATE [dbo].[tblUser] SET 
						[IsEmailVerified] =1 
						,[EmailVerifiedDate]=GETDATE()
						WHERE EmailId =@EmailId

END  


GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateMobileConfirmation]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ram Nunna
-- Create date: 09-MAR-2020
-- Description:	Update mobile no confirmation info
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdateMobileConfirmation] 
@UserId INT 
AS  
BEGIN  
UPDATE [dbo].[tblUser] SET 
						 [IsMobileNoVerified] =1 
						,[MobileNoVerifiedDate]=GETDATE()
						WHERE Id =@UserId

END  


GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateOtp]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ram
-- Create date: 11-03-2020
-- Description:	Update OTP detail by user
-- =============================================
CREATE PROCEDURE[dbo].[usp_UpdateOtp] -- 5,'123456'
-- Add the parameters for the stored procedure here
	@UserId INT,
	@Otp NVARCHAR(10)
AS  
BEGIN  
--set current date and time for last updation
BEGIN TRY
DECLARE @TimeStamp DATE;
	SET @TimeStamp= GETDATE()
-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;  
BEGIN TRANSACTION trSaveOtp;
 IF NOT EXISTS (SELECT 1 FROM [dbo].[tblOtp] WHERE UserId=@UserId)
 BEGIN 
	INSERT INTO [dbo].[tblOtp]
           ([UserId]
           ,[OTP]
           ,[UpdatedBy]
           ,[CreatedDt])
     VALUES
           (@UserId
           ,@Otp
           ,@UserId
           ,GETDATE()
		   )
 END
 ELSE 
 BEGIN 
	UPDATE [dbo].[tblOtp] 
		SET [OTP]=@Otp 
		WHERE UserId=@UserId
 END

COMMIT TRANSACTION trSaveOtp;
END TRY
BEGIN CATCH
        -- report exception
        EXEC dbo.usp_Report_Error;       
        -- Test if the transaction is uncommittable.  
        IF (XACT_STATE()) = -1  
        BEGIN   
            ROLLBACK TRANSACTION trSaveOtp;  
        END;  		  
    END CATCH
END  


GO
/****** Object:  StoredProcedure [dbo].[usp_UpdatePanNo]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ram
-- Create date: 11-03-2020
-- Description:	Update Pan detail by user
-- =============================================
CREATE PROCEDURE[dbo].[usp_UpdatePanNo]  
-- Add the parameters for the stored procedure here
	@UserId INT,
	@PanNo NVARCHAR(10)
AS  
BEGIN  
--set current date and time for last updation
BEGIN TRY
DECLARE @TimeStamp DATE;
	SET @TimeStamp= GETDATE()
-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;  
BEGIN TRANSACTION trUpdatePan;
 IF EXISTS (SELECT 1 FROM [dbo].[tblUser] WHERE Id=@UserId)
 BEGIN 
	
	UPDATE [dbo].[tblUser] 
		SET [PanNo]=@PanNo
			,[IsPanNoVerified]=1
			,[PanNoVerifiedDate]=GETDATE()
		WHERE Id=@UserId
 END

COMMIT TRANSACTION trUpdatePan;
END TRY
BEGIN CATCH
        -- report exception
        EXEC dbo.usp_Report_Error;       
        -- Test if the transaction is uncommittable.  
        IF (XACT_STATE()) = -1  
        BEGIN   
            ROLLBACK TRANSACTION trUpdatePan;  
        END;  		  
    END CATCH
END  


GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateUser]    Script Date: 3/14/2020 10:25:38 AM ******/
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
	@MobileNo NVARCHAR(20),
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
	[MobileNo]=@MobileNo,
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
/****** Object:  StoredProcedure [dbo].[usp_UserSelectAll]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ram
-- Create date: 08-Jan-2019
-- Description:	select all user records.
-- =============================================
CREATE PROCEDURE [dbo].[usp_UserSelectAll]
AS
SET NOCOUNT ON

SELECT [tStamp]
      ,[Id]
      ,[RoleId]
      ,[UserName]
      ,[EmailId]
      ,[Password]
      ,[MobileNo]
      ,[TimeStamp]
      ,[IsActivated]
      ,[IsUserActivatedDate]
      ,[IsEmailVerified]
      ,[EmailVerifiedDate]
      ,[IsMobileNoVerified]
      ,[MobileNoVerifiedDate]
      ,[IsPanNoVerified]
      ,[PanNoVerifiedDate]
      ,[IsDeleted]
  FROM [dbo].[tblUser] 

GO
/****** Object:  StoredProcedure [dbo].[usp_ValidateOtp]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ram
-- Create date: 13-03-2020
-- Description:	Update OTP detail by user & update mobile info
-- =============================================
CREATE PROCEDURE[dbo].[usp_ValidateOtp] 
-- Add the parameters for the stored procedure here
	@UserId INT,
	@MobileNo NVARCHAR(20),
	@Otp NVARCHAR(10)
AS  
BEGIN  

DECLARE @IsOtpValid BIT=0 

IF EXISTS(SELECT 1 FROM [dbo].[tblOtp] WHERE UserId=@UserId AND OTP=@Otp)
BEGIN 
	SET @IsOtpValid=1; 
	EXEC usp_UpdateMobileConfirmation @UserId
END 
ELSE 
BEGIN 
	SET @IsOtpValid=0;
END 
	SELECT @IsOtpValid AS IsOtpValid
END
GO
/****** Object:  Table [dbo].[tblAMC]    Script Date: 3/14/2020 10:25:38 AM ******/
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
/****** Object:  Table [dbo].[tblBankAccount]    Script Date: 3/14/2020 10:25:38 AM ******/
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
/****** Object:  Table [dbo].[tblFund]    Script Date: 3/14/2020 10:25:38 AM ******/
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
/****** Object:  Table [dbo].[tblOtp]    Script Date: 3/14/2020 10:25:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOtp](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[OTP] [nvarchar](10) NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
 CONSTRAINT [PK_tblOtp] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProfile]    Script Date: 3/14/2020 10:25:38 AM ******/
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
/****** Object:  Table [dbo].[tblRole]    Script Date: 3/14/2020 10:25:38 AM ******/
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
/****** Object:  Table [dbo].[tblScheme]    Script Date: 3/14/2020 10:25:38 AM ******/
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
/****** Object:  Table [dbo].[tblUser]    Script Date: 3/14/2020 10:25:38 AM ******/
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
	[MobileNo] [nvarchar](20) NULL,
	[PanNo] [nvarchar](20) NULL,
	[TimeStamp] [datetime] NULL,
	[IsActivated] [bit] NULL,
	[IsUserActivatedDate] [datetime] NULL,
	[IsEmailVerified] [bit] NULL,
	[EmailVerifiedDate] [datetime] NULL,
	[IsMobileNoVerified] [bit] NULL,
	[MobileNoVerifiedDate] [datetime] NULL,
	[IsPanNoVerified] [bit] NULL,
	[PanNoVerifiedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tblOtp] ON 

GO
INSERT [dbo].[tblOtp] ([ID], [UserId], [OTP], [UpdatedBy], [CreatedDt]) VALUES (1, 5, N'139746', 5, CAST(0x0000AB7C00A7E995 AS DateTime))
GO
INSERT [dbo].[tblOtp] ([ID], [UserId], [OTP], [UpdatedBy], [CreatedDt]) VALUES (2, 1, N'968147', 1, CAST(0x0000AB7D00A39A48 AS DateTime))
GO
INSERT [dbo].[tblOtp] ([ID], [UserId], [OTP], [UpdatedBy], [CreatedDt]) VALUES (3, 2, N'102346', 2, CAST(0x0000AB7E00872338 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tblOtp] OFF
GO
SET IDENTITY_INSERT [dbo].[tblProfile] ON 

GO
INSERT [dbo].[tblProfile] ([Id], [UserId], [FirstName], [MiddleName], [LastName], [CountryCode], [PhoneNo], [AltPhoneNo], [PANNo], [UID], [IsResident], [TimeStamp]) VALUES (1, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000AB79009AD4F8 AS DateTime))
GO
INSERT [dbo].[tblProfile] ([Id], [UserId], [FirstName], [MiddleName], [LastName], [CountryCode], [PhoneNo], [AltPhoneNo], [PANNo], [UID], [IsResident], [TimeStamp]) VALUES (2, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000AB79009B58C1 AS DateTime))
GO
INSERT [dbo].[tblProfile] ([Id], [UserId], [FirstName], [MiddleName], [LastName], [CountryCode], [PhoneNo], [AltPhoneNo], [PANNo], [UID], [IsResident], [TimeStamp]) VALUES (3, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000AB79009CF13C AS DateTime))
GO
INSERT [dbo].[tblProfile] ([Id], [UserId], [FirstName], [MiddleName], [LastName], [CountryCode], [PhoneNo], [AltPhoneNo], [PANNo], [UID], [IsResident], [TimeStamp]) VALUES (4, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000AB7A009B0A11 AS DateTime))
GO
INSERT [dbo].[tblProfile] ([Id], [UserId], [FirstName], [MiddleName], [LastName], [CountryCode], [PhoneNo], [AltPhoneNo], [PANNo], [UID], [IsResident], [TimeStamp]) VALUES (5, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000AB7B008841ED AS DateTime))
GO
INSERT [dbo].[tblProfile] ([Id], [UserId], [FirstName], [MiddleName], [LastName], [CountryCode], [PhoneNo], [AltPhoneNo], [PANNo], [UID], [IsResident], [TimeStamp]) VALUES (6, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000AB7E0086F0A2 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tblProfile] OFF
GO
SET IDENTITY_INSERT [dbo].[tblUser] ON 

GO
INSERT [dbo].[tblUser] ([Id], [RoleId], [UserName], [EmailId], [Password], [MobileNo], [PanNo], [TimeStamp], [IsActivated], [IsUserActivatedDate], [IsEmailVerified], [EmailVerifiedDate], [IsMobileNoVerified], [MobileNoVerifiedDate], [IsPanNoVerified], [PanNoVerifiedDate], [IsDeleted]) VALUES (1, 1, NULL, N'nunnaramudu@gmail.com', N'9QJuBvrVnUDTK3H5LjTwPA==AID8373dFHj2M/GVOTxjGg==', N'9059910248', N'', CAST(0x0000AB7B00000000 AS DateTime), 1, NULL, 1, CAST(0x0000AB7B00888393 AS DateTime), 1, CAST(0x0000AB7D00A3C817 AS DateTime), 1, CAST(0x0000AB7D009C76DA AS DateTime), 0)
GO
INSERT [dbo].[tblUser] ([Id], [RoleId], [UserName], [EmailId], [Password], [MobileNo], [PanNo], [TimeStamp], [IsActivated], [IsUserActivatedDate], [IsEmailVerified], [EmailVerifiedDate], [IsMobileNoVerified], [MobileNoVerifiedDate], [IsPanNoVerified], [PanNoVerifiedDate], [IsDeleted]) VALUES (2, 1, NULL, N'ramu19.com@gmail.com', N'BtNRJWleJwadVOnnEQEPng==VQ1xPW+0+NUjifdUhA6b8w==', N'9878988888', NULL, CAST(0x0000AB7E00000000 AS DateTime), 1, NULL, 1, CAST(0x0000AB7E0087187B AS DateTime), 1, CAST(0x0000AB7E008B1A14 AS DateTime), NULL, NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[tblUser] OFF
GO
USE [master]
GO
ALTER DATABASE [DB_CAI] SET  READ_WRITE 
GO
