CREATE PROCEDURE [dbo].[Read_Matching_Bracket]
	@ID int
AS
	SELECT * FROM dbo.Tournament_Matching_Bracket
	WHERE Matching_Bracket_ID = @ID
