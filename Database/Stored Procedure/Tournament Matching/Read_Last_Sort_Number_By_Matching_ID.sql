CREATE PROCEDURE [dbo].[Read_Last_Sort_Number_By_Matching_ID]
	@ID INT
AS
	SELECT TOP 1 Tournament_Matching_Sort_Number
    FROM Tournament_Matching
    WHERE Tournament_Matching_Bracket_ID = @ID
    ORDER BY Tournament_Matching_Sort_Number DESC;