CREATE TABLE [dbo].[Tournament_Registration]
(
	[Tournament_Registration_ID]                              INT           NOT NULL PRIMARY KEY IDENTITY
    , [Tournament_Registration_Event_ID]                      INT           NOT NULL FOREIGN KEY REFERENCES Tournament_Event(Tournament_Event_ID) ON DELETE CASCADE
    , [Tournament_Registration_Rider_Name]                    NVARCHAR(250) NULL
    , [Tournament_Registration_Drag_Bike_Number]              NVARCHAR(100) NULL 
    , [Tournament_Registration_Category_ID]                   INT           NOT NULL FOREIGN KEY REFERENCES Tournament_Registration_Category(Registration_Category_ID) ON DELETE CASCADE
    , [Tournament_Registration_Team_Name]                     NVARCHAR(250) NULL
    , [Tournament_Registration_Is_Already_Bracket]            BIT NOT NULL  DEFAULT (0)
)
