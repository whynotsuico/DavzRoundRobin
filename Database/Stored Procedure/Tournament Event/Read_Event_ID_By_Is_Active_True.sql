CREATE PROCEDURE [dbo].[Read_Event_ID_By_Is_Active_True]
AS
	SELECT Tournament_Event_ID
	FROM Tournament_Event
	WHERE Tournament_Event_Is_Active = 1