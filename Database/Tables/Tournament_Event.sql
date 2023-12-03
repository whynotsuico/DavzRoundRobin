CREATE TABLE [dbo].[Tournament_Event]
(
	[Tournament_Event_ID]                 INT           NOT NULL PRIMARY KEY IDENTITY(1,1)
    , [Tournament_Event_Name]             NVARCHAR(250) NOT NULL 
    , [Tournament_Event_Create_Date]      DATETIME      NOT NULL DEFAULT(GETDATE())
    , [Tournament_Event_Start_Date]       DATE          NULL
    , [Tournament_Event_End_Date]         DATE          NULL 
    , [Tournament_Event_Is_Active]        BIT           NOT NULL DEFAULT (0)
)
