CREATE PROCEDURE [dbo].[Read_Registration]
	@ID varchar(25)
AS
	SELECT * FROM dbo.Tournament_Registration
	WHERE Tournament_Registration_ID = @ID
