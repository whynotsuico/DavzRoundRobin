CREATE PROCEDURE [dbo].[Update_Event]
	@Event_ID varchar(250)
	, @Event_Name varchar(250)
	, @Event_CreateDate Datetime
	, @Event_StartDate Datetime
	, @Event_EndDate Datetime
	, @Event_IsActive bit
AS
	UPDATE dbo.Tournament_Event
	SET
		Tournament_Event_Name = @Event_Name
		, Tournament_Event_Create_Date = @Event_CreateDate
		, Tournament_Event_Start_Date = @Event_StartDate
		, Tournament_Event_End_Date = @Event_EndDate
		, Tournament_Event_Is_Active = @Event_IsActive
	WHERE
	Tournament_Event_ID = @Event_ID


   UPDATE Tournament_Event
   SET Tournament_Event_Is_Active = 0
   WHERE Tournament_Event_ID <> @Event_ID

