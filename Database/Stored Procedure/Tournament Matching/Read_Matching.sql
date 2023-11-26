CREATE PROCEDURE [dbo].[Read_Matching]
	@ID varchar(25)
AS
	SELECT * FROM dbo.Tournament_Matching
	WHERE Tournament_Matching_ID = @ID
