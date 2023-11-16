CREATE PROCEDURE [dbo].[Update_Registration]
	@Registration_ID varchar(50)
	, @Event_ID varchar(50)
	, @Rider_Name varchar(50)
	, @Bike_Number varchar(50)
	, @Category_ID varchar(50)
	, @Team_Name varchar(50)
AS
	UPDATE dbo.Tournament_Registration
	SET
		Tournament_Registration_Event_ID = @Event_ID
		, Tournament_Registration_Rider_Name = @Rider_Name
		, Tournament_Registration_Drag_Bike_Number = @Bike_Number
		, Tournament_Registration_Category_ID = @Category_ID
		, Tournament_Registration_Team_Name = @Team_Name
	WHERE
		Tournament_Registration_ID = @Registration_ID
