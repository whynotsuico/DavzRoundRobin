CREATE TABLE [dbo].[Tournament_Matching_Bracket]
(
	[Matching_Bracket_ID]                  INT NOT NULL PRIMARY KEY IDENTITY(1,1)
    , [Matching_Bracket_Event_ID]          INT NULL DEFAULT(0) FOREIGN KEY REFERENCES Tournament_Event(Tournament_Event_ID) ON DELETE CASCADE
    , [Matching_Bracket_Name]              NVARCHAR(50) NULL 
    , [Matching_Bracket_Category_ID]       INT NULL
    , [Matching_Bracket_Is_Done]           BIT NULL
)
