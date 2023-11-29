CREATE PROCEDURE [dbo].[ReadAll_By_Category_ID_And_Event_ID]
	@Category_ID varchar(50)
	, @Event_ID varchar(50)
AS
	SELECT * FROM dbo.Tournament_Matching
	INNER JOIN dbo.Tournament_Matching_Bracket ON dbo.Tournament_Matching.Tournament_Matching_Bracket_ID = dbo.Tournament_Matching_Bracket.Matching_Bracket_ID

	WHERE Matching_Bracket_Category_ID = @Category_ID AND Matching_Bracket_Event_ID = @Event_ID
