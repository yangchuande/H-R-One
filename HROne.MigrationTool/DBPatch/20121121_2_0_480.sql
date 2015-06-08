
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.0.479' 
BEGIN
	
	ALTER TABLE PayrollGroup ADD 
		PayGroupLeaveDefaultCutOffDay int NULL
           
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.0.480'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





