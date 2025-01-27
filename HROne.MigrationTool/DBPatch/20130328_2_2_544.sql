
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.1.541' 
BEGIN

	INSERT INTO EmpRosterTableGroup (EmpID, EmpRosterTableGroupEffFr, EmpRosterTableGroupEffTo, RosterTableGroupID, EmpRosterTableGroupIsSupervisor)
		SELECT EmpID, EmpPosEffFr, EmpPosEffTo, RosterTableGroupID, EmpPosIsRosterTableGroupSupervisor
		FROM EmpPositionInfo
		WHERE RosterTableGroupID <> 0

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.2.544'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





