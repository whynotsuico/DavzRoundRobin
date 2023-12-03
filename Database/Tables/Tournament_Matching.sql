CREATE TABLE [dbo].[Tournament_Matching]
(
	[Tournament_Matching_ID]                        INT NOT NULL PRIMARY KEY IDENTITY(1,1)
    , [Tournament_Matching_Sort_Number]             INT                 NOT NULL DEFAULT(0)
    , [Tournament_Matching_Right_Rider_Name]        NVARCHAR(250)       NULL
    , [Tournament_Matching_Left_Rider_Name]         NVARCHAR(250)       NULL 
    , [Tournament_Matching_Right_Team_Name]         VARCHAR(100)        NULL 
    , [Tournament_Matching_Left_Bike_Number]        NVARCHAR(50)        NULL 
    , [Tournament_Matching_Right_Bike_Number]       NVARCHAR(50)        NULL 
    , [Tournament_Matching_Winner_Bike_Number]      NVARCHAR(50)        NULL
    , [Tournament_Matching_Loser_Bike_Number]       NVARCHAR(50)        NULL 
    , [Tournament_Matching_Bracket_ID]              INT                 NULL     FOREIGN KEY REFERENCES Tournament_Matching_Bracket(Matching_Bracket_ID) ON DELETE CASCADE
    , [Tournament_Matching_Is_Done]                 BIT                 NOT NULL DEFAULT(0)
    , [Tournament_Matching_Left_Team_Name]          NVARCHAR(250)       NULL
)
