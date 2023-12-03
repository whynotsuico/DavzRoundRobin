CREATE TABLE [dbo].[Tournament_Registration_Category]
(
	[Registration_Category_ID]                    INT NOT NULL PRIMARY KEY IDENTITY(1,1)
    , [Registration_Category_Category_ID]         INT NOT NULL DEFAULT(0) FOREIGN KEY REFERENCES Tournament_Category(Tournament_Category_ID) ON DELETE CASCADE
    , [Registration_Category_Event_ID]            INT NOT NULL DEFAULT(0) FOREIGN KEY REFERENCES Tournament_Event(Tournament_Event_ID)       
)
