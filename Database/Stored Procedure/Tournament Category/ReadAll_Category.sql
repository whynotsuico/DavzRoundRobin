CREATE PROCEDURE [dbo].[ReadAll_Category]
AS
	SELECT * FROM dbo.Tournament_Category
	WHERE Tournament_Category_ID
	NOT IN (SELECT Registration_Category_Category_ID FROM Tournament_Registration_Category)
