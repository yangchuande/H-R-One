
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.0.420' 
BEGIN

	ALTER TABLE PayrollGroup ADD
		PayGroupIsSkipStatHol INT NULL
		
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.0.421'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





