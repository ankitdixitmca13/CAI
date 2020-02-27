
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

CREATE PROCEDURE [dbo].[usp_BankAccountDelete]
(
	@Id int
)

AS

SET NOCOUNT ON

DELETE FROM [tblBankAccount]
WHERE [Id] = @Id
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

CREATE PROCEDURE [dbo].[usp_ProfileDelete]
(
	@Id int
)

AS

SET NOCOUNT ON

DELETE FROM [tblProfile]
WHERE [Id] = @Id
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
