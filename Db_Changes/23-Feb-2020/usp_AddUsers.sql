USE [DB_CAI]
GO
/****** Object:  StoredProcedure [dbo].[usp_AddUsers]    Script Date: 2/23/2020 7:18:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ankit Dixit
-- Create date: 19-11-2019
-- Description:	Add record in tblUser table.
-- =============================================
ALTER PROCEDURE [dbo].[usp_AddUsers]   
	-- Add the parameters for the stored procedure here
	@UserName NVARCHAR(50),
	@EmailId NVARCHAR(50),
	@Password NVARCHAR(50),
	@MobileNo NVARCHAR(20),
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
	INSERT INTO dbo.tblUser(RoleId,UserName,EmailId,[Password],[MobileNo],[TimeStamp],IsActivated,IsDeleted)
	             VALUES(1,@UserName,@EmailId,@Password,@MobileNo,@TimeStamp,1,0)
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

