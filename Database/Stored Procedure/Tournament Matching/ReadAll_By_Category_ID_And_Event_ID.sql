CREATE PROCEDURE [dbo].[ReadAll_By_Category_ID_And_Event_ID]
	@CategoryID varchar(50)
	, @EventID varchar(50)
AS
	SELECT * 
	FROM dbo.Tournament_Matching
	INNER JOIN dbo.Tournament_Matching_Bracket
	ON Tournament_Matching_Bracket_ID = Matching_Bracket_ID
	WHERE Matching_Bracket_Category_ID = @CategoryID 
	AND Matching_Bracket_Event_ID = @EventID
