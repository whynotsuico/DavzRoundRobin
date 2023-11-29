CREATE PROCEDURE [dbo].[ReadAll_Matching_Bracket_By_Category_ID_And_Event_ID]
	@Category_ID varchar(50)
	, @Event_ID varchar(50)
AS
	SELECT * 
	FROM Tournament_Matching_Bracket
	WHERE Matching_Bracket_Category_ID = @Category_ID AND Matching_Bracket_Event_ID = @Event_ID
