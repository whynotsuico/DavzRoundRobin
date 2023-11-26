CREATE PROCEDURE [dbo].[ReadAll_Registration_By_EventID]
	@ID varchar(25)
AS
	SELECT * FROM Tournament_Registration
	WHERE Tournament_Registration_Event_ID = @ID
