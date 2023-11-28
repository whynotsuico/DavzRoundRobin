CREATE PROCEDURE [dbo].[Update_Matching]
	@Matching_ID int
	, @Category_ID int
	, @Sort_Number int
	, @Registration_ID int
	, @Rider_Name varchar(250)
	, @Registration_Team_Name varchar(250)
	, @Left_Bike_Number varchar(250)
	, @Right_Bike_Number varchar(250)
	, @Winner_Bike_Number varchar(250)
AS
	UPDATE dbo.Tournament_Matching
	SET
		Tournament_Matching_Category_ID = @Category_ID
		, Tournament_Matching_Sort_Number = @Sort_Number
		, Tournament_Matching_Registration_ID = @Registration_ID
		, Tournament_Matching_Registration_Rider_Name = @Rider_Name
		, Tournament_Matching_Registration_Team_Name = @Registration_Team_Name
		, Tournament_Matching_Left_Bike_Number = @Left_Bike_Number
		, Tournament_Matching_Right_Bike_Number = @Right_Bike_Number
		, Tournament_Matching_Winner_Bike_Number = @Winner_Bike_Number
	WHERE
		Tournament_Matching_ID = @Matching_ID
