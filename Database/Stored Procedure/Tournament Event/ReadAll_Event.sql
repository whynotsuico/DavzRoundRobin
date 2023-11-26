CREATE PROCEDURE [dbo].[ReadAll_Event]
AS
	SELECT * FROM dbo.Tournament_Event
	ORDER BY Tournament_Event_Create_Date DESC
