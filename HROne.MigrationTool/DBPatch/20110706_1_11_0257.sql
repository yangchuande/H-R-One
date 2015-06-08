
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.11.0256' 
BEGIN

		
	UPDATE SYSTEMFUNCTION
		SET Description='Imployee Employee Information'
		WHERE FunctionCode='PER999'
		
		
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.11.0257'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





