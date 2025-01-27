
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.10.0235' 
BEGIN

	ALTER TABLE AttendanceRecord ADD
		AttendanceRecordCalculateLunchTimeMins INT NULL,
		AttendanceRecordActualLunchTimeMins INT NULL
	
	ALTER TABLE EmpWorkingSummary ADD
		EmpWorkingSummaryTotalLunchTimeHours REAL NULL

	ALTER TABLE WorkHourPattern ADD
		WorkHourPatternContractWorkHoursPerDay REAL NULL,
		WorkHourPatternContractLunchTimeHoursPerDay REAL NULL
		
	ALTER TABLE PayrollGroup ADD
		PayGroupLunchTimeHasWage INT NULL
		
	ALTER TABLE ClaimsAndDeductions ADD
		CNDIsRestDayPayment INT NULL

	Update TaxPayment
		Set TaxPayDesc='Any Other Rewards, Allowances or Perquisites. Nature: '
		Where TaxPayCode='k1'



   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.10.0236'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





