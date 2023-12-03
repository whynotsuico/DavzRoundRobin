CREATE PROCEDURE [dbo].[ReadAll_Winners_And_Losers_By_Matching_Bracket_ID]
	@ID INT
AS
BEGIN
    SELECT TOP 10
        TeamName
        , BikeNumber
        , SUM(CASE WHEN BikeNumber = Winner_Bike_Number THEN 1 ELSE 0 END) AS Wins
        , SUM(CASE WHEN BikeNumber = Loser_Bike_Number THEN 1 ELSE 0 END) AS Losses
    FROM
        (
            SELECT 
                Tournament_Matching_Left_Team_Name AS TeamName,
                Tournament_Matching_Left_Bike_Number AS BikeNumber,
                Tournament_Matching_Winner_Bike_Number AS Winner_Bike_Number,
                Tournament_Matching_Loser_Bike_Number AS Loser_Bike_Number
            FROM dbo.Tournament_Matching
            WHERE Tournament_Matching_Bracket_ID = @ID

            UNION ALL

            SELECT 
                Tournament_Matching_Right_Team_Name AS TeamName,
                Tournament_Matching_Right_Bike_Number AS BikeNumber,
                Tournament_Matching_Winner_Bike_Number AS Winner_Bike_Number,
                Tournament_Matching_Loser_Bike_Number AS Loser_Bike_Number
            FROM dbo.Tournament_Matching
            WHERE  Tournament_Matching_Bracket_ID = @ID
        ) AS Teams
    GROUP BY TeamName, BikeNumber
    ORDER BY Wins DESC;
END;
