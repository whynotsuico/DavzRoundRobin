CREATE PROCEDURE [dbo].[Davz_Settings_Update]
	@ShowTimer BIT
	,@Length   varchar(250)
	,@PrinterName   varchar(250)
	,@TimerSeconds   INT
AS
	UPDATE dbo.Davz_Settings
	SET 
		Davz_Settings_Show_Timer = @ShowTimer
		, Davz_Settings_Length	 = @Length
		, Davz_Settings_Printer_Name = @PrinterName
		, Davz_Settings_Timer_Seconds = @TimerSeconds
