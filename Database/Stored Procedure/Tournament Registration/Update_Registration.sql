CREATE PROCEDURE [dbo].[Update_Registration]
	@ID int
	, @EventID varchar(50)
	, @RideName varchar(50)
	, @BikeNumber varchar(50)
	, @CategoryID varchar(50)
	, @TeamName varchar(50)
	, @IsAlreadyBracket bit
AS
	UPDATE dbo.Tournament_Registration
	SET
		Tournament_Registration_Event_ID = @EventID
		, Tournament_Registration_Rider_Name = @RideName
		, Tournament_Registration_Drag_Bike_Number = @BikeNumber
		, Tournament_Registration_Category_ID = @CategoryID
		, Tournament_Registration_Team_Name = @TeamName
		, Tournament_Registration_Is_Already_Bracket = @IsAlreadyBracket
	WHERE
		Tournament_Registration_ID = @ID
