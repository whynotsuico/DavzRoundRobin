CREATE PROCEDURE [dbo].[ReadAll_Matching_Bracket_By_Category_ID_And_Event_ID]
	@CategoryID varchar(50)
	, @EventID varchar(50)
AS
	SELECT * 
	FROM Tournament_Matching_Bracket
	WHERE Matching_Bracket_Category_ID = @CategoryID 
	AND Matching_Bracket_Event_ID = @EventID
