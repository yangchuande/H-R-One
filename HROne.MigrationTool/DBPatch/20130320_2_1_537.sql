
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.1.536' 
BEGIN

	UPDATE Authorizer
		SET AuthorizerSkipEmailAlert = 0
		WHERE AuthorizerSkipEmailAlert IS NULL
		
	UPDATE Authorizer
		SET AuthorizerIsReadOnly = 0
		WHERE AuthorizerIsReadOnly IS NULL

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.1.537'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





