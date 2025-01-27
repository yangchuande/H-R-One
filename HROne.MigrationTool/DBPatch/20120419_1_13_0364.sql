
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.13.0361' 
BEGIN

	UPDATE AuditTrail
	SET FunctionID= (SELECT FunctionID FROM SystemFunction where FunctionCode='PER002')
	WHERE FunctionID= (SELECT FunctionID FROM SystemFunction where FunctionCode='PER007')
	AND AuditTrailID IN
	(
		SELECT DISTINCT AuditTrailID 
		FROM AuditTrailDetail
		WHERE TableName='EmpBankAccount'
	)
		
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.13.0364'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





