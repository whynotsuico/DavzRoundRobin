CREATE PROCEDURE [dbo].[Delete_Category]
	@Category_ID varchar(250)
AS
	DELETE dbo.Tournament_Category
	WHERE Tournament_Category_ID = @Category_ID
