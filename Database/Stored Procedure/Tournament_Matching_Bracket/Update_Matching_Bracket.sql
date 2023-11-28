CREATE PROCEDURE [dbo].[Update_Matching_Bracket]
	@ID int
	, @Event_ID int
	, @Bracket_Name varchar(50)
	, @Category_ID int
	, @Is_Done bit
AS
	UPDATE dbo.Tournament_Matching_Bracket
	SET
	Matching_Bracket_Event_ID = @Event_ID
	, Matching_Bracket_Name = @Bracket_Name
	, Matching_Bracket_Category_ID = @Category_ID
	, Matching_Bracket_Is_Done = @Is_Done

	WHERE
	Matching_Bracket_ID = @ID
