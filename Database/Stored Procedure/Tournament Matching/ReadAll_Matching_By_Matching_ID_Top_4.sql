CREATE PROCEDURE [dbo].[ReadAll_Matching_By_Matching_ID_Top_4]
	@ID varchar(50)
AS
	SELECT TOP 4 * 
	FROM dbo.Tournament_Matching
	INNER JOIN dbo.Tournament_Matching_Bracket
	ON Tournament_Matching_Bracket_ID = Matching_Bracket_ID
	WHERE Matching_Bracket_ID = @ID AND Tournament_Matching_Is_Done = 0
	ORDER BY Tournament_Matching_Sort_Number ASC
