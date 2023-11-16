CREATE PROCEDURE [dbo].[Create_Event]
	@Event_Name varchar(250)
	, @Event_CreateDate Datetime
	, @Event_StartDate Datetime
	, @Event_EndDate Datetime
AS
	INSERT INTO dbo.Tournament_Event
	(
		Tournament_Event_Name
		, Tournament_Event_Create_Date
		, Tournament_Event_Start_Date
		, Tournament_Event_End_Date
	)
	VALUES
	(
		@Event_Name
		, @Event_CreateDate
		, @Event_StartDate
		, @Event_EndDate
	)