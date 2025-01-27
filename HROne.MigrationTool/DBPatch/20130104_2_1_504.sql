
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.1.494' 
BEGIN

	ALTER TABLE RosterTableGroup ADD
		RosterTableGroupExtendData NTEXT NULL

	ALTER TABLE AttendanceRecord ADD
		LeaveAppID INT NULL
           
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.1.504'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





