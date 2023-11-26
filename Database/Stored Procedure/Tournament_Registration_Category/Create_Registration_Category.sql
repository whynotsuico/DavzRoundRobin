CREATE PROCEDURE [dbo].[Create_Registration_Category]
	@CategoryID INT
	, @EventID  INT
AS
	IF NOT EXISTS (
        SELECT 1
        FROM dbo.Tournament_Registration_Category
        WHERE Registration_Category_Category_ID = @CategoryID
            AND Registration_Category_Event_ID = @EventID
    )
    BEGIN
        INSERT INTO dbo.Tournament_Registration_Category (
            Registration_Category_Category_ID,
            Registration_Category_Event_ID
        )
        VALUES (
            @CategoryID,
            @EventID
        )
    END
    ELSE
    BEGIN
      SELECT 0
    END
