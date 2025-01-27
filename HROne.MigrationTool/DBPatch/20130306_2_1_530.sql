
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.1.527' 
BEGIN

	CREATE TABLE MPFSchemeTrustee
	(
		MPFSchemeTrusteeID INT NOT NULL IDENTITY (1, 1),
		MPFSchemeTrusteeCode NVARCHAR(20) NULL,
		MPFSchemeTrusteeName NVARCHAR(255) NULL,
		CONSTRAINT PK_MPFSchemeTrustee PRIMARY KEY CLUSTERED 
		(
			MPFSchemeTrusteeID
		) 
	)

	INSERT INTO MPFSchemeTrustee (MPFSchemeTrusteeCode,MPFSchemeTrusteeName)
	VALUES	('AIA','American International Assurance Company (Trustee) Limited')
	
	INSERT INTO MPFSchemeTrustee (MPFSchemeTrusteeCode,MPFSchemeTrusteeName)
	VALUES	('AXA','AXA China Region Trustees Limited')

	INSERT INTO MPFSchemeTrustee (MPFSchemeTrusteeCode,MPFSchemeTrusteeName)
	VALUES	('BOCI','BOCI-Prudential Trustee Limited')

	INSERT INTO MPFSchemeTrustee (MPFSchemeTrusteeCode,MPFSchemeTrusteeName)
	VALUES	('HSBC','HSBC Provident Fund Trustee (Hong Kong) Limited')

	INSERT INTO MPFSchemeTrustee (MPFSchemeTrusteeCode,MPFSchemeTrusteeName)
	VALUES	('HangSeng','HSBC Provident Fund Trustee (Hong Kong) Limited')

	INSERT INTO MPFSchemeTrustee (MPFSchemeTrusteeCode,MPFSchemeTrusteeName)
	VALUES	('Manulife','Manulife Provident Funds Trust Company Limited')

	INSERT INTO MPFScheme (MPFSchemeCode,MPFSchemeDesc,MPFSchemeTrusteeCode)
	VALUES ('ES00020','SHKP MPF Employer Sponsored Scheme','RBC')

	INSERT INTO MPFScheme (MPFSchemeCode,MPFSchemeDesc,MPFSchemeTrusteeCode)
	VALUES ('MT00504','AXA MPF - Simple Plan','AXA')
	
	INSERT INTO MPFScheme (MPFSchemeCode,MPFSchemeDesc,MPFSchemeTrusteeCode)
	VALUES ('MT00547','My Choice Mandatory Provident Fund Scheme','BOCI')

	UPDATE MPFScheme
	SET MPFSchemeTrusteeCode='RBC'
	WHERE MPFSchemeCode='MT00415' OR MPFSchemeCode='MT00423'
	
	UPDATE MPFSCHEME
	SET MPFSchemeDesc='AIA MPF - Basic Value Choice'
	WHERE MPFSchemeCode='MT00156'

	UPDATE MPFSCHEME
	SET MPFSchemeDesc='AIA MPF - Simple Value Choice'
	WHERE MPFSchemeCode='MT00431'
	
	UPDATE MPFSCHEME
	SET MPFSchemeDesc='BOC-Prudential Easy-Choice Mandatory Provident Fund Scheme'
	WHERE MPFSchemeCode='MT00091'

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.1.530'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





