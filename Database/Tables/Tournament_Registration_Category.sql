CREATE TABLE [dbo].[Tournament_Registration_Category]
(
	[Registraion_Category_ID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Registration_Category_Category_ID] INT NOT NULL, 
    [Registration_Category_Event_ID] INT NOT NULL
)
