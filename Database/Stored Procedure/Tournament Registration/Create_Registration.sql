CREATE PROCEDURE [dbo].[Create_Registration]
	@Event_ID varchar(250)
	, @Rider_Name varchar(50)
	, @Bike_Number varchar(50)
	, @Category_ID varchar(50)
	, @Team_Name varchar(50)
AS
	INSERT INTO dbo.Tournament_Registration
	(
		Tournament_Registration_Event_ID
		, Tournament_Registration_Rider_Name
		, Tournament_Registration_Drag_Bike_Number
		, Tournament_Registration_Category_ID
		, Tournament_Registration_Team_Name
	)
	VALUES
	(
		@Event_ID  
		, @Rider_Name 
		, @Bike_Number 
		, @Category_ID 
		, @Team_Name 
	)
