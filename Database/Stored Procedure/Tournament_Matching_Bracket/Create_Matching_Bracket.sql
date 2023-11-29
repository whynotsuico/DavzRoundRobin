CREATE PROCEDURE [dbo].[Create_Matching_Bracket]
	@EventID int
	, @BracketName varchar(50)
	, @CategoryID int
	, @IsDone bit
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
		@EventID 
		, @BracketName 
		, @CategoryID 
		, @IsDone 
	)

	SELECT SCOPE_IDENTITY();
