CREATE TABLE [dbo].[Tournament_Matching_Bracket]
(
	[Matching_Bracket_ID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Matching_Bracket_Event_ID] INT NULL, 
    [Matching_Bracket_Name] NVARCHAR(50) NULL, 
    [Matching_Bracket_Category_ID] INT NULL, 
    [Matching_Bracket_Is_Done] BIT NULL
)
