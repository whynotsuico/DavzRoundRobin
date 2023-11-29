CREATE PROCEDURE [dbo].[ReadAll_Registration_By_Category_And_Event_ID]
	
	@CategoryID		INT
	, @EventID		INT

AS
	SELECT * 
	FROM dbo.Tournament_Registration
	WHERE Tournament_Registration_Category_ID = @CategoryID
	AND Tournament_Registration_Event_ID = @EventID

