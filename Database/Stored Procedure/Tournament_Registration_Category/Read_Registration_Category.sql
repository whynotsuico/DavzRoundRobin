CREATE PROCEDURE [dbo].[Read_Registration_Category]
	@ID varchar(50)
AS
	SELECT * FROM dbo.Tournament_Registration_Category

	WHERE Registraion_Category_ID = @ID
