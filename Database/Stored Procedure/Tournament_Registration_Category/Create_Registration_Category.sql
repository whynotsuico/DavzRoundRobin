CREATE PROCEDURE [dbo].[Create_Registration_Category]
	@Category_ID varchar(50)
	, @Event_ID varchar(50)
AS
	INSERT INTO dbo.Tournament_Registration_Category
	(
		Registration_Category_Category_ID
		, Registration_Category_Event_ID
	)
	VALUES
	(
		@Category_ID
		, @Event_ID
	)
