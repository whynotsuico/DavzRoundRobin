CREATE PROCEDURE [dbo].[Read_Bike_Number_By_Bike_Number]
	@bikeNumber nvarchar(50)
AS
	SELECT *
	FROM Tournament_Registration
	WHERE Tournament_Registration_Drag_Bike_Number = @bikeNumber
