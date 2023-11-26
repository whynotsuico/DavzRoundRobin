CREATE PROCEDURE [dbo].[Delete_Registration_Category]
	@ID varchar(50)
AS
	DELETE dbo.Tournament_Registration_Category
	WHERE Registraion_Category_ID = @ID
