
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.14.380' 
BEGIN

	Create Table TimeCardLocationMap
	(
		TimeCardLocationMapID INT NOT NULL IDENTITY (1, 1),
		TimeCardLocationMapOriginalCode nvarchar(50) NULL,
		TimeCardLocationMapNewCode nvarchar(50) NULL,
		CONSTRAINT PK_TimeCardLocationMap PRIMARY KEY CLUSTERED 
		(
			TimeCardLocationMapID
		) 
	)
	
	CREATE INDEX IDX_EmpMPFPlan_EmpID ON EmpMPFPlan 
	(
		EmpID
	)

	CREATE INDEX IDX_EmpAVCPlan_EmpID ON EmpAVCPlan 
	(
		EmpID
	)

	CREATE INDEX IDX_EmpORSOPlan_EmpID ON EmpORSOPlan 
	(
		EmpID
	)

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.14.387'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





