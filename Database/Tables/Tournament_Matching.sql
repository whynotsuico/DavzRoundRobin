CREATE TABLE [dbo].[Tournament_Matching]
(
	[Tournament_Matching_ID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Tournament_Matching_Category_ID] INT NULL, 
    [Tournament_Matching_Sort_Number] INT NULL, 
    [Tournament_Matching_Registration_ID] INT NULL, 
    [Tournament_Matching_Registration_Rider_Name] NVARCHAR(250) NULL, 
    [Tournament_Matching_Registration_Team_Name] VARCHAR(100) NULL, 
    [Tournament_Matching_Left_Bike_Number] NVARCHAR(50) NULL, 
    [Tournament_Matching_Right_Bike_Number] NVARCHAR(50) NULL, 
    [Tournament_Matching_Winner_Bike_Number] NVARCHAR(50) NULL, 
    [Tournament_Matching_Loser_Bike_Number] NVARCHAR(50) NULL, 
    [Tournament_Matching_Bracket_ID] INT NULL, 
    [Tournament_Matching_Is_Done] BIT NULL
)
