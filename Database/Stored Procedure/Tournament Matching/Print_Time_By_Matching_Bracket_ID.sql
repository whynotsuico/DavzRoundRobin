CREATE PROCEDURE [dbo].[Print_Time_By_Matching_Bracket_ID]
	@ID INT
	, @BikeNumber VARCHAR(250)
AS
BEGIN
   SELECT
    CASE
        WHEN @BikeNumber = [Tournament_Matching_Left_Bike_Number] THEN [Tournament_Matching_Left_Team_Name]
        WHEN @BikeNumber = [Tournament_Matching_Right_Bike_Number] THEN [Tournament_Matching_Right_Team_Name]
        ELSE 'Not Assigned'
    END AS Team_Name,
    CASE
        WHEN @BikeNumber = [Tournament_Matching_Left_Bike_Number] THEN [Tournament_Matching_Left_Team_Time]
        WHEN @BikeNumber = [Tournament_Matching_Right_Bike_Number] THEN [Tournament_Matching_Right_Team_Time]
        ELSE NULL
    END AS Time,
    CASE
        WHEN @BikeNumber = [Tournament_Matching_Left_Bike_Number] THEN [Tournament_Matching_Left_Team_Top_Speed]
        WHEN @BikeNumber = [Tournament_Matching_Right_Bike_Number] THEN [Tournament_Matching_Right_Team_Top_Speed]
        ELSE NULL
    END AS Top_Speed
FROM
    Tournament_Matching
WHERE
    @BikeNumber IN ([Tournament_Matching_Left_Bike_Number], [Tournament_Matching_Right_Bike_Number])
    AND   Tournament_Matching_Bracket_ID = @ID 
END;
