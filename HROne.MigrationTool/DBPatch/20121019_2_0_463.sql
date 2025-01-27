
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.0.461' 
BEGIN
	
	UPDATE PayrollBatch 
		SET PayBatchIsESSPaySlipRelease=0
		WHERE PayBatchIsESSPaySlipRelease IS NULL
	
	INSERT INTO SystemFunction
    (	FunctionCode
       ,Description
       ,FunctionCategory
       ,FunctionIsHidden)
     VALUES
           ('PAY015','Release Pay Slip to ESS', 'Payroll', 0)
           
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.0.463'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





