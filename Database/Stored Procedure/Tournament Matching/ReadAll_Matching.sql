CREATE PROCEDURE [dbo].[ReadAll_Matching]

 @BracketID INT

AS
	SELECT * FROM dbo.Tournament_Matching
	WHERE Tournament_Matching_Bracket_ID = @BracketID
