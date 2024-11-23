CREATE TABLE [dbo].[Davz_Settings]
(
	[Davz_Settings_ID]					INT NOT NULL PRIMARY KEY IDENTITY(1,1)
    , [Davz_Settings_Show_Timer]		BIT NOT NULL DEFAULT(1)
    , [Davz_Settings_Length]		    VARCHAR(200) NULL
    , [Davz_Settings_Printer_Name]		VARCHAR(200) NULL
    , [Davz_Settings_Timer_Seconds]		INT NOT NULL DEFAULT(15)
)
