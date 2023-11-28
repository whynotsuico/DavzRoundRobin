CREATE PROCEDURE [dbo].[Create_Matching_Bracket]
	@Event_ID int
	, @Bracket_Name varchar(50)
	, @Category_ID int
	, @Is_Done bit
AS
	INSERT INTO dbo.Tournament_Matching_Bracket
	(
		Matching_Bracket_Event_ID
		, Matching_Bracket_Name
		, Matching_Bracket_Category_ID
		, Matching_Bracket_Is_Done
	)
	VALUES
	(
		@Event_ID 
		, @Bracket_Name 
		, @Category_ID 
		, @Is_Done 
	)
