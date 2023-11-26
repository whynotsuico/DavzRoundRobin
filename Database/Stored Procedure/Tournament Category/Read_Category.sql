CREATE PROCEDURE [dbo].[Read_Category]
	@Category_ID varchar(250)
AS
	SELECT * FROM dbo.Tournament_Category
	WHERE Tournament_Category_ID = @Category_ID
