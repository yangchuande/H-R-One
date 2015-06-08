
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.3.573' 
BEGIN
	
	--	Only update the version number to re-run the Import_Employee.sql

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.3.576'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





