
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.13.0339' 
BEGIN

	UPDATE TaxPayment
	SET TaxPayDesc='Payment in Lieu of Notice, Back Pay, Terminal Awards, or Gratuities'
	WHERE TaxFormType in ('F', 'G')
	AND TaxPayCode ='d'

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.13.0358'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





