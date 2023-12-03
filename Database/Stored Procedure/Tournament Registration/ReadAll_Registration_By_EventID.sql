CREATE PROCEDURE [dbo].[ReadAll_Registration_By_EventID]
	@EventID		INT
	,@CategoryID    INT
AS
	SELECT *
	INTO 
	#tmpEntry
	FROM Tournament_Registration
	WHERE Tournament_Registration_Event_ID = @EventID
	AND (@CategoryID = -1 OR Tournament_Registration_Category_ID = @CategoryID)
	
	SELECT DISTINCT Registraion_Category_ID, Tournament_Category_Name FROM #tmpEntry
	INNER JOIN vRegistrationCategory ON Registraion_Category_ID = Tournament_Registration_Category_ID
	
	SELECT *FROM #tmpEntry
	
	DROP TABLE #tmpEntry

