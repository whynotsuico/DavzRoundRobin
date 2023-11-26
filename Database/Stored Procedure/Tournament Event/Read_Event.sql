CREATE PROCEDURE [dbo].[Read_Event]
	@ID varchar(25)
AS
	SELECT * FROM dbo.Tournament_Event
	WHERE Tournament_Event_ID = @ID
