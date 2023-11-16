CREATE PROCEDURE [dbo].[Delete_Registration]
	@Registration_ID varchar(50)
AS
	DELETE dbo.Tournament_Registration
	WHERE Tournament_Registration_ID = @Registration_ID
