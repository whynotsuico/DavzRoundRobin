CREATE PROCEDURE [dbo].[Update_Category]
	@Category_ID varchar(250),
	@Category_Name varchar(250)
AS
	UPDATE dbo.Tournament_Category
	SET 
		Tournament_Category_Name = @Category_Name
	WHERE 
		Tournament_Category_ID = @Category_ID
