CREATE PROCEDURE [dbo].[Get_Best_Team_Time_Tournament_Matching_By_Category_ID]
@CategoryID INT 
AS

WITH All_Times AS (
    SELECT 
        Tournament_Matching_Left_Rider_Name AS Team_Name,
        Tournament_Matching_Left_Team_Time AS Team_Time
    FROM Tournament_Matching
    INNER JOIN Tournament_Matching_Bracket ON Tournament_Matching_Bracket_ID = Matching_Bracket_ID
    WHERE Matching_Bracket_Category_ID = @CategoryID
    UNION ALL
    SELECT 
        Tournament_Matching_Right_Rider_Name AS Rider_Name,
        Tournament_Matching_Right_Team_Time AS Team_Time
    FROM Tournament_Matching
    INNER JOIN Tournament_Matching_Bracket ON Tournament_Matching_Bracket_ID = Matching_Bracket_ID
    WHERE Matching_Bracket_Category_ID = @CategoryID
)
SELECT TOP 10
    Team_Name,
    Team_Time
FROM All_Times
WHERE 
    Team_Time IS NOT NULL 
    AND Team_Time <> '' 
    AND Team_Time <> '0' 
    AND Team_Time <> '00:00.000'
ORDER BY Team_Time;
