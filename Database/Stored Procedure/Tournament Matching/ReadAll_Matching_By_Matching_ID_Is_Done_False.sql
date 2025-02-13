﻿CREATE PROCEDURE [dbo].[ReadAll_Matching_By_Matching_ID_Is_Done_False]
	@ID INT
AS
	SELECT * 
	FROM dbo.Tournament_Matching
	INNER JOIN dbo.Tournament_Matching_Bracket
	ON Tournament_Matching_Bracket_ID = Matching_Bracket_ID
	WHERE Matching_Bracket_ID = @ID AND Tournament_Matching_Is_Done = 0
	ORDER BY Tournament_Matching_Sort_Number ASC
	OFFSET 1 ROW
	FETCH NEXT 2147483647 ROW ONLY;

