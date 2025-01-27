
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.1.524' 
BEGIN

	ALTER TABLE TaxEmp ADD
		TaxEmpIsReleasePrintoutToESS INT NULL

	ALTER TABLE LeaveCode ADD
		LeaveCodeIsShowMedicalCertOption INT NULL
		      				
	INSERT INTO SystemFunction
    (	FunctionCode
       ,Description
       ,FunctionCategory
       ,FunctionIsHidden)
     VALUES
           ('TAX006','Release Tax Report to ESS', 'Taxation', 0)
           		      				
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.1.526'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





