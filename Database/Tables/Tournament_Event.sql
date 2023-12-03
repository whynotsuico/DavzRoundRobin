CREATE TABLE [dbo].[Tournament_Event]
(
	[Tournament_Event_ID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Tournament_Event_Name] NVARCHAR(250) NOT NULL, 
    [Tournament_Event_Create_Date] DATETIME NOT NULL, 
    [Tournament_Event_Start_Date] DATE NULL, 
    [Tournament_Event_End_Date] DATE NULL, 
    [Tournament_Event_Is_Active] BIT NULL DEFAULT (0)
)
