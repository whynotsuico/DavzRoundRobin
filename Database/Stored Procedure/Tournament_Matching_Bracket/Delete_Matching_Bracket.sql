CREATE PROCEDURE [dbo].[Delete_Matching_Bracket]
	@ID int
AS
	DELETE dbo.Tournament_Matching_Bracket
	WHERE Matching_Bracket_ID = @ID
