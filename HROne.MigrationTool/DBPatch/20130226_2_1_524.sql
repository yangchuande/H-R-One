
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.1.523' 
BEGIN

	ALTER TABLE PaymentRecord ALTER COLUMN
		PayRecRemark NTEXT NULL
		      			
	ALTER TABLE ClaimsAndDeductions ALTER COLUMN
		CNDRemark NTEXT NULL

	UPDATE TaxPayment
	SET TaxPayDesc='Back Pay, Payment in Lieu of Notice, Terminal Awards or Gratuities'
	WHERE TaxFormType in ('B')
	AND TaxPayCode ='f'
	
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.1.524'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





