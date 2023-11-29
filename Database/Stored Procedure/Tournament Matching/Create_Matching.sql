CREATE PROCEDURE [dbo].[Create_Matching]
	@Sort_Number varchar(250)
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
	INSERT INTO dbo.Tournament_Matching
	(
		Tournament_Matching_Sort_Number
		, Tournament_Matching_Right_Rider_Name
		, Tournament_Matching_Left_Rider_Name
		, Tournament_Matching_Right_Team_Name
		, Tournament_Matching_Left_Bike_Number
		, Tournament_Matching_Right_Bike_Number
		, Tournament_Matching_Winner_Bike_Number
		, Tournament_Matching_Loser_Bike_Number
		, Tournament_Matching_Bracket_ID
		, Tournament_Matching_Is_Done
		, Tournament_Matching_Left_Team_Name
	)
	VALUES
	(
		@Sort_Number  
		, @Right_Rider_Name  
		, @Left_Rider_Name  
		, @Right_Team_Name  
		, @Left_Bike_Number  
		, @Right_Bike_Number  
		, @Winner_Bike_Number  
		, @Loser_Bike_Number  
		, @Bracket_ID  
		, @Is_Done  
		, @Left_Team_Name  
	)
