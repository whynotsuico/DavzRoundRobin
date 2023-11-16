CREATE PROCEDURE [dbo].[Create_Matching]
	@Category_ID varchar(250)
	, @Sort_Number varchar(250)
	, @Registration_ID varchar(250)
	, @Rider_Name varchar(250)
	, @Registration_Bike_Number varchar(250)
	, @Left_Bike_Number varchar(250)
	, @Right_Bike_Number varchar(250)
	, @Winner_Bike_Number varchar(250)
AS
	INSERT INTO dbo.Tournament_Matching
	(
		Tournament_Matching_Category_ID
		, Tournament_Matching_Sort_Number
		, Tournament_Matching_Registration_ID
		, Tournament_Matching_Registration_Rider_Name
		, Tournament_Matching_Registration_Bike_Number
		, Tournament_Matching_Left_Bike_Number
		, Tournament_Matching_Right_Bike_Number
		, Tournament_Matching_Winner_Bike_Number
	)
	VALUES
	(
		@Category_ID
		, @Sort_Number
		, @Registration_ID
		, @Rider_Name
		, @Registration_Bike_Number
		, @Left_Bike_Number
		, @Right_Bike_Number
		, @Winner_Bike_Number
	)
