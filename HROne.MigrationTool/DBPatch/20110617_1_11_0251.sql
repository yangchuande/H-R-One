
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.11.0249' 
BEGIN

		
	ALTER TABLE RequestEmpPersonalInfo ADD
		RequestEmpResAddrAreaCode NVARCHAR(100) NULL
		
		
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.11.0251'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





