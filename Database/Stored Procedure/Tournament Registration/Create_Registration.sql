CREATE PROCEDURE [dbo].[Create_Registration]
	@EventID varchar(250)
	, @RiderName varchar(50)
	, @BikeNumber varchar(50)
	, @CategoryID varchar(50)
	, @TeamName varchar(50)
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
		@EventID  
		, @RiderName 
		, @BikeNumber 
		, @CategoryID 
		, @TeamName 
	)
