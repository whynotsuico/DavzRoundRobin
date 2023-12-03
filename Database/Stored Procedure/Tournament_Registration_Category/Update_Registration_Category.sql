CREATE PROCEDURE [dbo].[Update_Registration_Category]
	@ID varchar(50)
	, @Category_ID varchar(50)
	, @Event_ID varchar(50)
AS
	UPDATE dbo.Tournament_Registration_Category
	SET
	Registration_Category_Category_ID =@Category_ID
	, Registration_Category_Event_ID = @Event_ID

	WHERE Registration_Category_ID = @ID