CREATE PROCEDURE [dbo].[Update_Matching]
	@ID varchar(50)
	, @Category_ID varchar(250)
	, @Sort_Number varchar(250)
	, @Right_Rider_Name varchar(250)
	, @Left_Rider_Name varchar(250)
	, @Right_Team_Name varchar(250)
	, @Left_Bike_Number varchar(250)
	, @Right_Bike_Number varchar(250)
	, @Winner_Bike_Number varchar(250)
	, @Loser_Bike_Number varchar(250)
	, @Bracket_ID varchar(250)
	, @Is_Done bit
	, @Left_Team_Name varchar(250)
AS
	UPDATE dbo.Tournament_Matching
	SET
		Tournament_Matching_Category_ID = @Category_ID
		, Tournament_Matching_Sort_Number = @Sort_Number
		, Tournament_Matching_Right_Rider_Name = @Right_Rider_Name
		, Tournament_Matching_Left_Rider_Name = @Left_Rider_Name
		, Tournament_Matching_Right_Team_Name = @Right_Team_Name
		, Tournament_Matching_Left_Bike_Number = @Left_Bike_Number
		, Tournament_Matching_Right_Bike_Number = @Right_Bike_Number
		, Tournament_Matching_Winner_Bike_Number = @Winner_Bike_Number
		, Tournament_Matching_Loser_Bike_Number = @Loser_Bike_Number
		, Tournament_Matching_Bracket_ID = @Bracket_ID
		, Tournament_Matching_Is_Done = @Is_Done
		, Tournament_Matching_Left_Team_Name = @Left_Team_Name
	WHERE
		Tournament_Matching_ID = @ID
