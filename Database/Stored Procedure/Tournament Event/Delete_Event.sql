CREATE PROCEDURE [dbo].[Delete_Event]
	@Event_ID varchar(250)
AS
	DELETE dbo.Tournament_Event
	WHERE Tournament_Event_ID = @Event_ID
