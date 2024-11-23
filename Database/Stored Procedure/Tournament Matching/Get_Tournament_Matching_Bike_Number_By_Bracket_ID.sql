CREATE PROCEDURE [dbo].[Get_Tournament_Matching_Bike_Number_By_Bracket_ID]
	@ID INT
AS
BEGIN
   
SELECT DISTINCT Bike_Number, Team_Name
FROM (
    SELECT [Tournament_Matching_Left_Bike_Number] AS Bike_Number, [Tournament_Matching_Left_Team_Name] AS Team_Name
    FROM Tournament_Matching
    WHERE [Tournament_Matching_Bracket_ID] = @ID
    AND [Tournament_Matching_Left_Bike_Number] IS NOT NULL
    AND [Tournament_Matching_Left_Team_Name] IS NOT NULL

    UNION

    SELECT [Tournament_Matching_Right_Bike_Number] AS Bike_Number, [Tournament_Matching_Right_Team_Name] AS Team_Name
    FROM Tournament_Matching
    WHERE [Tournament_Matching_Bracket_ID] = @ID
    AND [Tournament_Matching_Right_Bike_Number] IS NOT NULL
    AND [Tournament_Matching_Right_Team_Name] IS NOT NULL
) AS CombinedResults
END;
