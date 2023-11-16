CREATE PROCEDURE [dbo].[Delete_Matching]
	@Matching_ID int
AS
	DELETE dbo.Tournament_Matching
	WHERE Tournament_Matching_ID = @Matching_ID
