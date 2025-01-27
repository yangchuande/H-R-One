
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.09.0227' 
BEGIN

	CREATE TABLE EmpWorkingSummary
	(
		EmpWorkingSummaryID int NOT NULL IDENTITY (1, 1),
		EmpID int NULL,
		EmpWorkingSummaryAsOfDate datetime NULL,
		EmpWorkingSummaryRestDayEntitled real NULL,
		EmpWorkingSummaryRestDayTaken real NULL,
		EmpWorkingSummaryTotalWorkingDays real NULL,
		EmpWorkingSummaryTotalWorkingHours real NULL,
		CONSTRAINT PK_EmpWorkingSummary PRIMARY KEY CLUSTERED 
		(
			EmpWorkingSummaryID
		) 
	)
	
	CREATE TABLE MinimumWage
	(
		MinimumWageID int NOT NULL,
		MinimumWageEffectiveDate datetime NULL,
		MinimumWageHourlyRate real NULL,
		CONSTRAINT PK_MinimumWage PRIMARY KEY CLUSTERED 
		(
			MinimumWageID
		)
	)
	
	ALTER TABLE EmpPayroll ADD
		EmpPayrollTotalWorkingHour REAL NULL

	ALTER TABLE PaymentRecord ADD
		PayRecIsRestDayPayment int NULL

	ALTER TABLE PayrollGroup ADD
		PayGroupRestDayHasWage int NULL,
		PayGroupRestDayProrataFormula int NULL,
		PayGroupAdditionalRemunerationPayCodeID int NULL
	
	Update PaymentCode
	Set PaymentTypeID = (Select PaymentTypeID from PaymentType where PaymentTypeCode='OTHERS')
	Where PaymentTypeID = (Select PaymentTypeID from PaymentType where PaymentTypeCode='OTPAY')
	AND PaymentCodeIsWages=1

	Update PaymentCode
	Set PaymentCodeIsWages=1
	Where PaymentTypeID = (Select PaymentTypeID from PaymentType where PaymentTypeCode='OTPAY')
	AND PaymentCodeIsWages=0
		
	
	INSERT INTO SystemFunction
    (	FunctionCode
       ,Description
       ,FunctionCategory
       ,FunctionIsHidden)
     VALUES
           ('PAY013','Employee Working Summary', 'Payroll', 0)
           
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.10.0228'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





