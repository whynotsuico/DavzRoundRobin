CREATE PROCEDURE [dbo].[Read_Registration_Category]
	@ID varchar(50)
AS
	SELECT * FROM vRegistrationCategory

	WHERE Registration_Category_ID = @ID
