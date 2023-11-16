CREATE PROCEDURE [dbo].[Create_Category]
	@Category_Name varchar(250)
AS
	INSERT INTO dbo.Tournament_Category
	(
		Tournament_Category_Name
	)
	VALUES
	(
		@Category_Name
	)
