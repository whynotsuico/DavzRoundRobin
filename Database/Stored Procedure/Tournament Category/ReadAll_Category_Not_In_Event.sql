﻿CREATE PROCEDURE [dbo].[ReadAll_Category_Not_In_Event]
 @EventID INT

AS
	SELECT * FROM dbo.Tournament_Category
	WHERE Tournament_Category_ID
	NOT IN (SELECT Registration_Category_Category_ID FROM Tournament_Registration_Category
			WHERE Registration_Category_Event_ID = @EventID)