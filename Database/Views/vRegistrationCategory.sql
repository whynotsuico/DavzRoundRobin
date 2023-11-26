CREATE VIEW [dbo].[vRegistrationCategory]
AS

SELECT		*
FROM		Tournament_Registration_Category
INNER JOIN	Tournament_Category ON Registration_Category_Category_ID = Tournament_Category_ID