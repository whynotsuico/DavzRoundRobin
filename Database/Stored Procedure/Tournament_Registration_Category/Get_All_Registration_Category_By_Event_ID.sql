CREATE PROCEDURE [dbo].[Get_All_Registration_Category_By_Event_ID]
 @EventID INT

AS
	SELECT * 
	FROM 
	vRegistrationCategory
	WHERE Registration_Category_Event_ID = @EventID