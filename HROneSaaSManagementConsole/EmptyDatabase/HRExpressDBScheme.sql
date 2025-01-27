--	Database Scheme for 1.00.0029 SP3
--	Table to be drop in future
--	- CountryCode
--	- FinalPayment ( not EmpFinalPayment)
CREATE TABLE AuditTrail
(
	AuditTrailID int NOT NULL IDENTITY (1, 1),
	UserID int NULL,
	FunctionID int NULL,
	EmpID int NULL,
	CreateDate datetime NULL,
	CONSTRAINT PK_AuditTrail PRIMARY KEY CLUSTERED 
	(
		AuditTrailID
	) 
)

CREATE TABLE AuditTrailDetail
(
	AuditTrailDetailID int NOT NULL IDENTITY (1, 1),
	AuditTrailID int NULL,
	TableName nvarchar(50) NULL,
	ActionType nvarchar(50) NULL,
	Remark text NULL,
	CONSTRAINT PK_AuditTrailDetail PRIMARY KEY CLUSTERED 
	(
		AuditTrailDetailID
	)
)

CREATE TABLE AuthorizationGroup
(
	AuthorizationGroupID int NOT NULL IDENTITY (1, 1),
	AuthorizationCode nvarchar(20) NULL,
	AuthorizationDesc nvarchar(100) NULL,
	AuthorizationGroupIsApproveEEInfo int NULL,
	AuthorizationGroupIsApproveLeave int NULL,
	AuthorizationGroupIsReceiveOtherGrpAlert int NULL,
	CONSTRAINT PK_AuthorizationGroup PRIMARY KEY CLUSTERED 
	(
		AuthorizationGroupID
	)
)

CREATE TABLE Authorizer
(
	AuthorizerID int NOT NULL,
	EmpID int NULL,
	AuthorizationGroupID int NULL,
	CONSTRAINT PK_Authorizer PRIMARY KEY CLUSTERED 
	(
		AuthorizerID
	)
)

CREATE TABLE AVCPlan
(
	AVCPlanID int NOT NULL IDENTITY (1, 1),
	AVCPlanCode nvarchar(20) NULL,
	AVCPlanDesc nvarchar(100) NULL,
	AVCPlanEmployerResidual int NULL,
	AVCPlanEmployeeResidual int NULL,
	AVCPlanUseMPFExemption int NULL,
	AVCPlanJoinDateStart int NULL,
	AVCPlanContributeMaxAge int NULL,
	AVCPlanContributeMinRI int NULL,
	AVCPlanMaxEmployerVC decimal(15, 2) NULL,
	AVCPlanMaxEmployeeVC decimal(15, 2) NULL,
	CONSTRAINT PK_AVCPlan PRIMARY KEY CLUSTERED 
	(
		AVCPlanID
	)
)

CREATE TABLE AVCPlanDetail
(
	AVCPlanDetailID int NOT NULL IDENTITY (1, 1),
	AVCPlanID int NULL,
	AVCPlanDetailYearOfService int NULL,
	AVCPlanDetailERBelowRI decimal(15, 2) NULL,
	AVCPlanDetailERAboveRI decimal(15, 2) NULL,
	AVCPlanDetailERFix decimal(15, 2) NULL,
	AVCPlanDetailEEBelowRI decimal(15, 2) NULL,
	AVCPlanDetailEEAboveRI decimal(15, 2) NULL,
	AVCPlanDetailEEFix decimal(15, 2) NULL,
	CONSTRAINT PK_AVCPlanDetail PRIMARY KEY CLUSTERED 
	(
		AVCPlanDetailID
	) 
)
	
CREATE TABLE CessationReason
(
	CessationReasonID int NOT NULL IDENTITY (1, 1),
	CessationReasonCode nvarchar(20) NULL,
	CessationReasonDesc nvarchar(100) NULL,
	CessationReasonIsSeverancePay int NULL,
	CessationReasonIsLongServicePay int NULL,
	CONSTRAINT PK_CessationReason PRIMARY KEY CLUSTERED 
	(
		CessationReasonID
	) 
)

CREATE TABLE ClaimsAndDeductions
(
	CNDID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	CNDEffDate datetime NULL,
	PayCodeID int NULL,
	CNDAmount decimal(15, 4) NULL,
	CurrencyID nvarchar(3) NULL,
	CNDPayMethod nvarchar(1) NULL,
	EmpAccID int NULL,
	CNDRemark nvarchar(200) NULL,
	CNDNumOfDayAdj real NULL,
	PayRecID int NULL,
	CONSTRAINT PK_ClaimsAndDeductions PRIMARY KEY CLUSTERED 
	(
		CNDID
	) 
)

CREATE TABLE Company
(
	CompanyID int NOT NULL IDENTITY (1, 1),
	CompanyCode nvarchar(20) NULL,
	CompanyName nvarchar(100) NULL,
	CompanyAddress nvarchar(200) NULL,
	CompanyContactPerson nvarchar(100) NULL,
	CompanyContactNo nvarchar(50) NULL,
	CompanyFaxNo nvarchar(50) NULL,
	CompanyBRNo nvarchar(50) NULL,
	CompanyBankAccountNo nvarchar(9) NULL,
	CompanyBankCode nvarchar(3) NULL,
	CompanyBranchCode nvarchar(3) NULL,
	CONSTRAINT PK_Company PRIMARY KEY CLUSTERED 
	(
		CompanyID
	) 
)

CREATE TABLE CostAllocation
(
	CostAllocationID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpPayrollID int NULL,
	CostAllocationStatus nvarchar(1) NULL,
	CostAllocationTrialRunDate datetime NULL,
	CostAllocationTrialRunBy int NULL,
	CostAllocationConfirmDate datetime NULL,
	CostAllocationConfirmBy int NULL,
	CONSTRAINT PK_CostAllocation PRIMARY KEY CLUSTERED 
	(
		CostAllocationID
	) 
)

CREATE TABLE CostAllocationDetail
(
	CostAllocationDetailID int NOT NULL IDENTITY (1, 1),
	CostAllocationID int NULL,
	CompanyID int NULL,
	CostCenterID int NULL,
	PaymentCodeID int NULL,
	CostAllocationDetailAmount decimal(15, 4) NULL,
	PayRecID int NULL,
	CONSTRAINT PK_CostAllocationDetail PRIMARY KEY CLUSTERED 
	(
		CostAllocationDetailID
	) 
)

CREATE TABLE CostAllocationDetailHElement
(
	CostAllocationDetailHElementID int NOT NULL IDENTITY (1, 1),
	CostAllocationDetailID int NULL,
	HElementID int NULL,
	HLevelID int NULL,
	CONSTRAINT PK_CostAllocationDetailHElement PRIMARY KEY CLUSTERED 
	(
		CostAllocationDetailHElementID
	)
)

CREATE TABLE CostCenter
(
	CostCenterID int NOT NULL IDENTITY (1, 1),
	CostCenterCode nvarchar(20) NOT NULL,
	CostCenterDesc nvarchar(100) NULL,
	CONSTRAINT PK_CostCenter PRIMARY KEY CLUSTERED 
	(
		CostCenterID
	)
)

CREATE TABLE Country
(
	CountryCode nvarchar(10) NOT NULL,
	CountryDesc nvarchar(50) NULL,
	CONSTRAINT PK_Country PRIMARY KEY CLUSTERED 
	(
		CountryCode
	)
)

CREATE TABLE EmpAVCPlan
(
	EmpAVCID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpAVCEffFr datetime NULL,
	EmpAVCEffTo datetime NULL,
	AVCPlanID int NULL,
	EmpAVCEROverrideSetting int NULL,
	EmpAVCERBelowRI decimal(15, 2) NULL,
	EmpAVCERAboveRI decimal(15, 2) NULL,
	EmpAVCERFix decimal(15, 2) NULL,
	EmpAVCEEOverrideSetting int NULL,
	EmpAVCEEBelowRI decimal(15, 2) NULL,
	EmpAVCEEAboveRI decimal(15, 2) NULL,
	EmpAVCEEFix decimal(15, 2) NULL,
	CONSTRAINT PK_EmpAVCPlan PRIMARY KEY CLUSTERED 
	(
		EmpAVCID
	)
)

CREATE TABLE EmpBankAccount
(
	EmpBankAccountID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpBankCode nvarchar(3) NULL,
	EmpBranchCode nvarchar(3) NULL,
	EmpAccountNo nvarchar(9) NULL,
	EmpBankAccountHolderName nvarchar(100) NULL,
	EmpAccDefault int NULL,
	CONSTRAINT PK_EmpBankAccount PRIMARY KEY CLUSTERED 
	(
		EmpBankAccountID
	)
)

CREATE TABLE EmpContractTerms
(
	EmpContractID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpContractCompanyName nvarchar(100) NULL,
	EmpContractCompanyContactNo nvarchar(100) NULL,
	EmpContractCompanyAddr nvarchar(100) NULL,
	EmpContractEmployedFrom datetime NULL,
	EmpContractEmployedTo datetime NULL,
	EmpContractGratuity decimal(15, 4) NULL,
	CurrencyID nvarchar(3) NULL,
	CONSTRAINT PK_EmpContractTerms PRIMARY KEY CLUSTERED 
	(
		EmpContractID
	)
)

CREATE TABLE EmpCostCenter
(
	EmpCostCenterID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpCostCenterEffFr datetime NULL,
	EmpCostCenterEffTo datetime NULL,
	CONSTRAINT PK_EmpCostCenter PRIMARY KEY CLUSTERED 
	(
		EmpCostCenterID
	)
)

CREATE TABLE EmpCostCenterDetail
(
	EmpCostCenterDetailID int NOT NULL IDENTITY (1, 1),
	EmpCostCenterID int NULL,
	CostCenterID int NULL,
	EmpCostCenterPercentage real NULL,
	EmpCostCenterDetailIsDefault int NULL,
	CONSTRAINT PK_EmpCostCenterDetail PRIMARY KEY CLUSTERED 
	(
		EmpCostCenterDetailID
	)
)

CREATE TABLE EmpDependant
(
	EmpDependantID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpDependantSurname nvarchar(20) NULL,
	EmpDependantOtherName nvarchar(40) NULL,
	EmpDependantChineseName nvarchar(50) NULL,
	EmpDependantGender nvarchar(1) NULL,
	EmpDependantHKID nvarchar(12) NULL,
	EmpDependantPassportNo nvarchar(40) NULL,
	EmpDependantPassportIssuedCountry nvarchar(40) NULL,
	EmpDependantRelationship nvarchar(100) NULL,
	CONSTRAINT PK_EmpDependant PRIMARY KEY CLUSTERED 
	(
		EmpDependantID
	) 
)

CREATE TABLE EmpFinalPayment
(
	EmpFinalPayID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	PayCodeID int NULL,
	EmpFinalPayAmount decimal(15, 4) NULL,
	CurrencyID nvarchar(3) NULL,
	EmpFinalPayMethod nvarchar(50) NULL,
	EmpAccID int NULL,
	EmpFinalPayIsAutoGen int NULL,
	EmpFinalPayNumOfDayAdj real NULL,
	LeaveAppID int NULL,
	PayRecID nvarchar(10) NULL,
	EmpFinalPayRemark ntext NULL,
	CONSTRAINT PK_EmpFinalPayment PRIMARY KEY CLUSTERED 
	(
		EmpFinalPayID
	) 
)

CREATE TABLE EmpHierarchy
(
	EmpHierarchyID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpPosID int NULL,
	HElementID int NULL,
	HLevelID int NULL,
	CONSTRAINT PK_EmpHierarchy PRIMARY KEY CLUSTERED 
	(
		EmpHierarchyID
	)
)

CREATE TABLE EmploymentType
(
	EmploymentTypeID int NOT NULL IDENTITY (1, 1),
	EmploymentTypeCode nvarchar(20) NULL,
	EmploymentTypeDesc nvarchar(100) NULL,
	CONSTRAINT PK_EmploymentType PRIMARY KEY CLUSTERED 
	(
		EmploymentTypeID
	)
)

CREATE TABLE EmpMPFPlan
(
	EmpMPFID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpMPFEffFr datetime NULL,
	EmpMPFEffTo datetime NULL,
	MPFPlanID int NULL,
	EmpMPFPlanExtendData ntext NULL,
	CONSTRAINT PK_EmpMPFPlan PRIMARY KEY CLUSTERED 
	(
		EmpMPFID
	)
)

CREATE TABLE EmpORSOPlan
(
	EmpORSOID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpORSOEffFr datetime NULL,
	EmpORSOEffTo datetime NULL,
	ORSOPlanID int NULL,
	CONSTRAINT PK_EmpORSOPlan PRIMARY KEY CLUSTERED 
	(
		EmpORSOID
	)
)

CREATE TABLE EmpPayroll
(
	EmpPayrollID int NOT NULL IDENTITY (1, 1),
	PayPeriodID int NULL,
	EmpID int NULL,
	EmpPayStatus nvarchar(1) NULL,
	PayBatchID int NULL,
	EmpPayIsRP nvarchar(1) NULL,
	EmpPayIsCND nvarchar(1) NULL,
	EmpPayIsHistoryAdj nvarchar(1) NULL,
	EmpPayTrialRunDate datetime NULL,
	EmpPayTrialRunBy int NULL,
	EmpPayConfirmDate datetime NULL,
	EmpPayConfirmBy int NULL,
	EmpPayNumOfDayCount real NULL,
	CONSTRAINT PK_EmpPayroll PRIMARY KEY CLUSTERED 
	(
		EmpPayrollID
	)
)

CREATE TABLE EmpPersonalInfo
(
	EmpID int NOT NULL IDENTITY (1, 1),
	EmpNo nvarchar(20) NULL,
	EmpStatus nvarchar(3) NULL,
	EmpEngSurname nvarchar(20) NULL,
	EmpEngOtherName nvarchar(55) NULL,
	EmpChiFullName nvarchar(50) NULL,
	EmpAlias nvarchar(100) NULL,
	EmpHKID nvarchar(50) NULL,
	EmpGender nvarchar(1) NULL,
	EmpMaritalStatus nvarchar(50) NULL,
	EmpDateOfBirth datetime NULL,
	EmpPlaceOfBirth nvarchar(100) NULL,
	EmpNationality nvarchar(100) NULL,
	EmpPassportNo nvarchar(40) NULL,
	EmpPassportIssuedCountry nvarchar(40) NULL,
	EmpPassportExpiryDate datetime NULL,
	EmpResAddr nvarchar(200) NULL,
	EmpResAddrAreaCode nvarchar(1) NULL,
	EmpCorAddr nvarchar(200) NULL,
	EmpDateOfJoin datetime NULL,
	EmpServiceDate datetime NULL,
	EmpNoticePeriod int NULL,
	EmpNoticeUnit nvarchar(1) NULL,
	EmpProbaPeriod int NULL,
	EmpProbaUnit nvarchar(1) NULL,
	EmpProbaLastDate datetime NULL,
	EmpEmail nvarchar(100) NULL,
	EmpHomePhoneNo nvarchar(100) NULL,
	EmpMobileNo nvarchar(100) NULL,
	EmpOfficePhoneNo nvarchar(100) NULL,
	Remark ntext NULL,
	PreviousEmpID int NULL,
	EmpPW nvarchar(50) NULL,
	EmpInternalEmail nvarchar(100) NULL,
	CONSTRAINT PK_EmpPersonalInfo PRIMARY KEY CLUSTERED 
	(
		EmpID
	)
)

CREATE TABLE EmpPlaceOfResidence
(
	EmpPoRID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpPoRFrom datetime NULL,
	EmpPoRTo datetime NULL,
	EmpPoRLandLord nvarchar(100) NULL,
	EmpPoRLandLordAddr nvarchar(110) NULL,
	EmpPoRPropertyAddr nvarchar(110) NULL,
	EmpPoRNature nvarchar(19) NULL,
	EmpPoRPayToLandER numeric(18, 4) NOT NULL,
	EmpPoRPayToLandEE numeric(18, 4) NOT NULL,
	EmpPoRRefundToEE numeric(18, 4) NOT NULL,
	EmpPoRPayToERByEE numeric(18, 4) NOT NULL,
	CONSTRAINT PK_EmpPlaceOfResidence PRIMARY KEY CLUSTERED 
	(
		EmpPoRID
	)
)

CREATE TABLE EmpPositionInfo
(
	EmpPosID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpPosEffFr datetime NULL,
	EmpPosEffTo datetime NULL,
	CompanyID int NULL,
	PositionID int NULL,
	RankID int NULL,
	StaffTypeID int NULL,
	PayGroupID int NULL,
	LeavePlanID int NULL,
	EmpFirstAuthorizationGp int NULL,
	EmpSecondAuthorizationGp int NULL,
	CONSTRAINT PK_EmpPositionInfo PRIMARY KEY CLUSTERED 
	(
		EmpPosID
	)
)


CREATE TABLE EmpQualification
(
	EmpQualificationID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	QualificationID int NULL,
	EmpQualificationFrom datetime NULL,
	EmpQualificationTo datetime NULL,
	EmpQualificationInstitution nvarchar(100) NULL,
	EmpQualificationRemark ntext NULL,
	CONSTRAINT PK_EmpQualification PRIMARY KEY CLUSTERED 
	(
		EmpQualificationID
	)
)

CREATE TABLE EmpRecurringPayment
(
	EmpRPID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpRPEffFr datetime NULL,
	EmpRPEffTo datetime NULL,
	PayCodeID int NULL,
	EmpRPAmount decimal(15, 4) NULL,
	CurrencyID nvarchar(3) NULL,
	EmpRPUnit nvarchar(1) NULL,
	EmpRPMethod nvarchar(1) NULL,
	EmpAccID int NULL,
	EmpRPRemark nvarchar(50) NULL,
	CONSTRAINT PK_EmpRecurringPayment PRIMARY KEY CLUSTERED 
	(
		EmpRPID
	) 
)

CREATE TABLE EmpRequest
(
	EmpRequestID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpRequestType nvarchar(50) NULL,
	EmpRequestRecordID int NULL,
	EmpRequestCreateDate datetime NULL,
	EmpRequestModifyDate datetime NULL,
	EmpRequestStatusCode nvarchar(50) NULL,
	CONSTRAINT PK_EmpRequest PRIMARY KEY CLUSTERED 
	(
		EmpRequestID
	) 
)

CREATE TABLE EmpSkill
(
	EmpSkillID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	SkillID int NULL,
	SkillLevelID int NULL,
	CONSTRAINT PK_EmpSkill PRIMARY KEY CLUSTERED 
	(
		EmpSkillID
	)
)

CREATE TABLE EmpSpouse
(
	EmpSpouseID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	EmpSpouseSurname nvarchar(20) NULL,
	EmpSpouseOtherName nvarchar(40) NULL,
	EmpSpouseChineseName nvarchar(50) NULL,
	EmpSpouseHKID nvarchar(12) NULL,
	EmpSpousePassportNo nvarchar(40) NULL,
	EmpSpousePassportIssuedCountry nvarchar(40) NULL,
	CONSTRAINT PK_EmpSpouse PRIMARY KEY CLUSTERED 
	(
		EmpSpouseID
	) 
)

CREATE TABLE EmpTermination
(
	EmpTermID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	CessationReasonID int NULL,
	EmpTermResignDate datetime NULL,
	EmpTermNoticePeriod int NULL,
	EmpTermNoticeUnit nvarchar(1) NULL,
	EmpTermLastDate datetime NULL,
	EmpTermRemark ntext NULL,
	EmpTermIsTransferCompany int NULL,
	NewEmpID int NULL,
	CONSTRAINT PK_EmpTermination PRIMARY KEY CLUSTERED 
	(
		EmpTermID
	)
)

CREATE TABLE FinalPayment
(
	FinalPayID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	PayCodeID int NULL,
	FinalPayAmount decimal(15, 4) NULL,
	Currency nvarchar(50) NULL,
	EmpFinalPayMethod nvarchar(50) NULL,
	EmpAccID int NULL,
	EmpFinalPayRemark nvarchar(50) NULL,
	EmpFialPayIsAutoGen nchar(10) NULL,
	CONSTRAINT PK_FinalPayment PRIMARY KEY CLUSTERED 
	(
		FinalPayID
	)
)

CREATE TABLE HierarchyElement
(
	HElementID int NOT NULL IDENTITY (1, 1),
	CompanyID int NULL,
	HElementCode nvarchar(20) NULL,
	HElementDesc nvarchar(100) NULL,
	HLevelID int NULL,
	CONSTRAINT PK_HierarchyElement PRIMARY KEY CLUSTERED 
	(
		HElementID
	)
)

CREATE TABLE HierarchyLevel
(
	HLevelID int NOT NULL IDENTITY (1, 1),
	HLevelCode nvarchar(20) NULL,
	HLevelDesc nvarchar(100) NULL,
	HLevelSeqNo int NULL,
	CONSTRAINT PK_HierarchyLevel PRIMARY KEY CLUSTERED 
	(
		HLevelID
	) 
)

CREATE TABLE LeaveApplication
(
	LeaveAppID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	LeaveCodeID int NULL,
	LeaveAppUnit nvarchar(1) NULL,
	LeaveAppDateFrom datetime NULL,
	LeaveAppDateTo datetime NULL,
	LeaveAppTimeFrom int NULL,
	LeaveAppTimeTo int NULL,
	LeaveAppDays decimal(15, 4) NULL,
	LeaveAppRemark ntext NULL,
	LeaveAppNoPayProcess int NULL,
	EmpPaymentID int NULL,
	EmpPayrollID int NULL,
	CONSTRAINT PK_LeaveApplication PRIMARY KEY CLUSTERED 
	(
		LeaveAppID
	)
)

CREATE TABLE LeaveBalance
(
	LeaveBalanceID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	LeaveTypeID int NULL,
	LeaveBalanceEffectiveDate datetime NULL,
	LeaveBalanceBF real NULL,
	LeaveBalanceForfeiture real NULL,
	LeaveBalanceEntitled real NULL,
	LeaveBalancePeriod int NULL,
	LeaveBalanceIsSettlement smallint NULL,
	LeaveBalanceIsFirst smallint NULL,
	CONSTRAINT PK_LeaveBalance PRIMARY KEY CLUSTERED 
	(
		LeaveBalanceID
	) 
)	
CREATE TABLE LeaveBalanceAdjustment
(
	LeaveBalAdjID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	LeaveBalAdjDate datetime NULL,
	LeaveTypeID int NULL,
	LeaveBalAdjType nvarchar(50) NULL,
	LeaveBalAdjValue real NULL,
	LeaveBalAdjRemark ntext NULL,
	CONSTRAINT PK_LeaveBalanceAdjustment PRIMARY KEY CLUSTERED 
	(
		LeaveBalAdjID
	)
)

CREATE TABLE LeaveCode
(
	LeaveCodeID int NOT NULL IDENTITY (1, 1),
	LeaveCode nvarchar(20) NULL,
	LeaveCodeDesc nvarchar(100) NULL,
	LeaveTypeID int NULL,
	LeaveCodePayRatio decimal(15, 4) NULL,
	LeaveCodeLeaveAllowPaymentCodeID int NULL,
	LeaveCodeLeaveDeductPaymentCodeID int NULL,
	LeaveCodeLeaveDeductFormula int NULL,
	LeaveCodeLeaveAllowFormula int NULL,
	LeaveCodePayAdvance int NULL,
	PaymentCodeID int NULL,
	CONSTRAINT PK_LeaveCode PRIMARY KEY CLUSTERED 
	(
		LeaveCodeID
	)
)

CREATE TABLE LeavePlan
(
	LeavePlanID int NOT NULL IDENTITY (1, 1),
	LeavePlanCode nvarchar(20) NULL,
	LeavePlanDesc nvarchar(100) NULL,
	LeavePlanALMaxBF int NULL,
	LeavePlanSL1MaxBF int NULL,
	LeavePlanSL2MaxBF int NULL,
	CONSTRAINT PK_LeavePlan PRIMARY KEY CLUSTERED 
	(
		LeavePlanID
	)
)

CREATE TABLE LeavePlanEntitle
(
	LeavePlanEntitleID int NOT NULL IDENTITY (1, 1),
	LeavePlanID int NULL,
	LeaveTypeID int NULL,
	LeavePlanEntitleYearOfService int NULL,
	LeavePlanEntitleDays int NULL,
	CONSTRAINT PK_LeavePlanEntitle PRIMARY KEY CLUSTERED 
	(
		LeavePlanEntitleID
	)
)	

CREATE TABLE LeaveType
(
	LeaveTypeID int NOT NULL IDENTITY (1, 1),
	LeaveType nvarchar(20) NULL,
	LeaveTypeDesc nvarchar(100) NULL,
	LeaveDecimalPlace int NULL,
	LeaveSystemUse int NULL,
	CONSTRAINT PK_LeaveType PRIMARY KEY CLUSTERED 
	(
		LeaveTypeID
	)
)	

CREATE TABLE MPFParameter
(
	MPFParamID int NOT NULL IDENTITY (1, 1),
	MPFParamEffFr datetime NULL,
	MPFParamMinMonthly decimal(15, 4) NULL,
	MPFParamMaxMonthly decimal(15, 4) NULL,
	MPFParamMinDaily decimal(15, 4) NULL,
	MPFParamMaxDaily decimal(15, 4) NULL,
	MPFParamEEPercent decimal(15, 4) NULL,
	MPFParamERPercent decimal(15, 4) NULL,
	CONSTRAINT PK_MPFParameter PRIMARY KEY CLUSTERED 
	(
		MPFParamID
	)
)

CREATE TABLE MPFPlan
(
	MPFPlanID int NOT NULL IDENTITY (1, 1),
	MPFPlanCode nvarchar(20) NULL,
	MPFPlanDesc nvarchar(100) NULL,
	MPFPlanTrusteeName nvarchar(100) NULL,
	MPFPlanSchemeNo nvarchar(20) NULL,
	MPFPlanCompanyName nvarchar(100) NULL,
	MPFPlanCompanyAddress nvarchar(200) NULL,
	MPFPlanContactName nvarchar(100) NULL,
	MPFPlanContactNo nvarchar(20) NULL,
	MPFSchemeID int NULL,
	MPFPlanParticipationNo nvarchar(50) NULL,
	MPFPlanExtendData ntext NULL,
	CONSTRAINT PK_MPFPlan PRIMARY KEY CLUSTERED 
	(
		MPFPlanID
	)
)	

CREATE TABLE MPFRecord
(
	MPFRecordID int NOT NULL IDENTITY (1, 1),
	EmpPayrollID int NOT NULL,
	MPFPlanID int NOT NULL,
	AVCPlanID int NOT NULL,
	MPFRecPeriodFr datetime NOT NULL,
	MPFRecPeriodTo datetime NOT NULL,
	MPFRecType nvarchar(1) NOT NULL,
	MPFRecCalMCRI decimal(15, 4) NULL,
	MPFRecCalMCER decimal(15, 4) NULL,
	MPFRecCalMCEE decimal(15, 4) NULL,
	MPFRecCalVCRI decimal(15, 4) NULL,
	MPFRecCalVCER decimal(15, 4) NULL,
	MPFRecCalVCEE decimal(15, 4) NULL,
	MPFRecActMCRI decimal(15, 4) NULL,
	MPFRecActMCER decimal(15, 4) NULL,
	MPFRecActMCEE decimal(15, 4) NULL,
	MPFRecActVCRI decimal(15, 4) NULL,
	MPFRecActVCER decimal(15, 4) NULL,
	MPFRecActVCEE decimal(15, 4) NULL,
	CONSTRAINT PK_MPFRecord PRIMARY KEY CLUSTERED 
	(
		MPFRecordID
	)
)

CREATE TABLE MPFScheme
(
	MPFSchemeID int NOT NULL IDENTITY (1, 1),
	MPFSchemeCode nvarchar(20) NOT NULL,
	MPFSchemeDesc nvarchar(100) NOT NULL,
	CONSTRAINT PK_MPFScheme PRIMARY KEY CLUSTERED 
	(
		MPFSchemeID
	)
)

CREATE TABLE ORSOPlan
(
	ORSOPlanID int NOT NULL IDENTITY (1, 1),
	ORSOPlanCode nvarchar(20) NULL,
	ORSOPlanDesc nvarchar(100) NULL,
	ORSOPlanSchemeNo nvarchar(100) NULL,
	ORSOPlanCompanyName nvarchar(100) NULL,
	ORSOPlanPayCenter nvarchar(20) NULL,
	ORSOPlanMaxEmployerVC decimal(15, 2) NULL,
	ORSOPlanMaxEmployeeVC decimal(15, 2) NULL,
	CONSTRAINT PK_ORSOPlan PRIMARY KEY CLUSTERED 
	(
		ORSOPlanID
	) 
)

CREATE TABLE ORSOPlanDetail
(
	ORSOPlanDetailID int NOT NULL IDENTITY (1, 1),
	ORSOPlanID int NULL,
	ORSOPlanDetailYearOfService int NULL,
	ORSOPlanDetailER decimal(15, 2) NULL,
	ORSOPlanDetailERFix decimal(15, 2) NULL,
	ORSOPlanDetailEE decimal(15, 2) NULL,
	ORSOPlanDetailEEFix decimal(15, 2) NULL,
	CONSTRAINT PK_ORSOPlanDetail PRIMARY KEY CLUSTERED 
	(
		ORSOPlanDetailID
	)
)

CREATE TABLE ORSORecord
(
	ORSORecordID int NOT NULL IDENTITY (1, 1),
	EmpPayrollID int NOT NULL,
	ORSOPlanID int NOT NULL,
	ORSORecPeriodFr datetime NOT NULL,
	ORSORecPeriodTo datetime NOT NULL,
	ORSORecType nvarchar(1) NOT NULL,
	ORSORecCalRI decimal(15, 4) NULL,
	ORSORecCalER decimal(15, 4) NULL,
	ORSORecCalEE decimal(15, 4) NULL,
	ORSORecActRI decimal(15, 4) NULL,
	ORSORecActER decimal(15, 4) NULL,
	ORSORecActEE decimal(15, 4) NULL,
	CONSTRAINT PK_ORSORecord PRIMARY KEY CLUSTERED 
	(
		ORSORecordID
	) 
)	

CREATE TABLE PaymentCode
(
	PaymentCodeID int NOT NULL IDENTITY (1, 1),
	PaymentCode nvarchar(20) NULL,
	PaymentCodeDesc nvarchar(100) NULL,
	PaymentTypeID int NOT NULL,
	PaymentCodeIsProrata int NULL,
	PaymentCodeIsMPF int NULL,
	PaymentCodeIsTopUp int NULL,
	PaymentCodeIsWages int NULL,
	PaymentCodeIsORSO int NULL,
	PaymentCodeDecimalPlace int NULL,
	PaymentCodeRoundingRule nvarchar(50) NULL,
	CONSTRAINT PK_PaymentCode PRIMARY KEY CLUSTERED 
	(
		PaymentCodeID
	)
)

CREATE TABLE PaymentRecord
(
	PayRecID int NOT NULL IDENTITY (1, 1),
	EmpPayrollID int NULL,
	PaymentCodeID int NULL,
	PayRecCalAmount decimal(15, 4) NULL,
	PayRecActAmount decimal(15, 4) NULL,
	CurrencyID nvarchar(3) NULL,
	PayRecMethod nvarchar(1) NULL,
	EmpAccID int NULL,
	PayRecType nvarchar(1) NULL,
	PayRecStatus nvarchar(1) NULL,
	PayRecNumOfDayAdj real NULL,
	LeaveAppID int NULL,
	PayRecRemark nvarchar(200) NULL,
	CONSTRAINT PK_PaymentRecord PRIMARY KEY CLUSTERED 
	(
		PayRecID
	) 
)

CREATE TABLE PaymentType
(
	PaymentTypeID int NOT NULL IDENTITY (1, 1),
	PaymentTypeCode nvarchar(20) NULL,
	PaymentTypeDesc nvarchar(100) NULL,
	CONSTRAINT PK_PaymentType PRIMARY KEY CLUSTERED 
	(
		PaymentTypeID
	) 
)	

CREATE TABLE PayrollBatch
(
	PayBatchID int NOT NULL IDENTITY (1, 1),
	PayBatchConfirmDate datetime NULL,
	PayBatchValueDate datetime NULL,
	PayBatchFileGenDate datetime NULL,
	PayBatchFileGenBy int NULL,
	CONSTRAINT PK_PayrollBatch PRIMARY KEY CLUSTERED 
	(
		PayBatchID
	) 
)	

CREATE TABLE PayrollGroup
(
	PayGroupID int NOT NULL IDENTITY (1, 1),
	PayGroupCode nvarchar(20) NULL,
	PayGroupDesc nvarchar(100) NULL,
	PayGroupFreq nvarchar(1) NULL,
	PayGroupDefaultStartDay int NULL,
	PayGroupDefaultEndDay int NULL,
	PayGroupNextStartDate datetime NULL,
	PayGroupNextEndDate datetime NULL,
	CurrentPayPeriodID int NULL,
	PayGroupLeaveDeductFormula int NULL,
	PayGroupLeaveAllowFormula int NULL,
	PayGroupNewJoinFormula int NULL,
	PayGroupTerminatedFormula int NULL,
	PayGroupStatHolDeductFormula int NULL,
	PayGroupStatHolAllowFormula int NULL,
	PayGroupStatHolAllowPaymentCodeID int NULL,
	PayGroupStatHolDeductPaymentCodeID int NULL,
	PayGroupPayAdvance int NULL,
	PayGroupStatHolEligiblePeriod int NULL,
	PayGroupStatHolEligibleUnit nvarchar(1) NULL,
	CONSTRAINT PK_PayrollGroup PRIMARY KEY CLUSTERED 
	(
		PayGroupID
	) 
)	

CREATE TABLE PayrollPeriod
(
	PayPeriodID int NOT NULL IDENTITY (1, 1),
	PayGroupID int NULL,
	PayPeriodFr datetime NULL,
	PayPeriodTo datetime NULL,
	PayPeriodLeaveCutOffDate datetime NULL,
	PayPeriodAttnFr datetime NULL,
	PayPeriodAttnTo datetime NULL,
	PayPeriodStatus nvarchar(2) NULL,
	PayPeriodTrialRunDate datetime NULL,
	PayPeriodTrialRunBy int NULL,
	PayPeriodConfirmDate datetime NULL,
	PayPeriodConfirmBy int NULL,
	PayPeriodProcessEndDate datetime NULL,
	PayPeriodProcessEndBy int NULL,
	PayPeriodRollbackDate datetime NULL,
	PayPeriodRollbackBy int NULL,
	CONSTRAINT PK_PayrollPeriod PRIMARY KEY CLUSTERED 
	(
		PayPeriodID
	)
)	

CREATE TABLE PayrollProrataFormula
(
	PayFormID int NOT NULL IDENTITY (1, 1),
	PayFormCode nvarchar(20) NULL,
	PayFormDesc nvarchar(100) NULL,
	PayFormPaymentType int NULL,
	PayFormMultiplier real NULL,
	PayFormDivider real NULL,
	PayFormIsSys nvarchar(1) NULL,
	CONSTRAINT PK_PayrollProrataFormula PRIMARY KEY CLUSTERED 
	(
		PayFormID
	) 
)

CREATE TABLE Position
(
	PositionID int NOT NULL IDENTITY (1, 1),
	PositionCode nvarchar(20) NULL,
	PositionDesc nvarchar(100) NULL,
	CONSTRAINT PK_Position PRIMARY KEY CLUSTERED 
	(
		PositionID
	) 
)	

CREATE TABLE Qualification
(
	QualificationID int NOT NULL IDENTITY (1, 1),
	QualificationCode nvarchar(20) NULL,
	QualificationDesc nvarchar(100) NULL,
	CONSTRAINT PK_Qualification PRIMARY KEY CLUSTERED 
	(
		QualificationID
	) 
)

CREATE TABLE Rank
(
	RankID int NOT NULL IDENTITY (1, 1),
	RankCode nvarchar(20) NULL,
	RankDesc nvarchar(100) NULL,
	CONSTRAINT PK_Rank PRIMARY KEY CLUSTERED 
	(
		RankID
	)
)

CREATE TABLE RequestEmpPersonalInfo
(
	RequestEmpID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	RequestEmpAlias nvarchar(50) NULL,
	RequestEmpMaritalStatus nvarchar(50) NULL,
	RequestEmpPassportNo nvarchar(50) NULL,
	RequestEmpPassportIssuedCountry nvarchar(50) NULL,
	RequestEmpNationality nvarchar(50) NULL,
	RequestEmpHomePhoneNo nvarchar(50) NULL,
	RequestEmpMobileNo nvarchar(50) NULL,
	RequestEmpOfficePhoneNo nvarchar(50) NULL,
	RequestEmpEmail nvarchar(50) NULL,
	RequestEmpResAddr nvarchar(50) NULL,
	RequestEmpCorAdd nvarchar(50) NULL,
	RequestEmpCreateDate datetime NULL,
	CONSTRAINT PK_RequestEmpPersonalInfo PRIMARY KEY CLUSTERED 
	(
		RequestEmpID
	) 
)	

CREATE TABLE RequestLeaveApplication
(
	RequestLeaveAppID int NOT NULL IDENTITY (1, 1),
	EmpID int NULL,
	RequestLeaveCodeID int NULL,
	RequestLeaveAppUnit nvarchar(50) NULL,
	RequestLeaveAppDateFrom datetime NULL,
	RequestLeaveAppDateTo datetime NULL,
	RequestLeaveAppTimeFrom int NULL,
	RequestLeaveAppTimeTo int NULL,
	RequestLeaveDays decimal(15, 4) NULL,
	RequestLeaveAppRemark nvarchar(50) NULL,
	RequestLeaveAppCreateDate datetime NULL,
	CONSTRAINT PK_RequestLeaveApplication PRIMARY KEY CLUSTERED 
	(
		RequestLeaveAppID
	) 
)	

CREATE TABLE RequestStatus
(
	RequestStatusID int NOT NULL IDENTITY (1, 1),
	RequestStatusCode nvarchar(50) NULL,
	RequestStatusDesc nvarchar(50) NULL,
	RequestStatusPosition nvarchar(50) NULL,
	CONSTRAINT PK_RequestStatus PRIMARY KEY CLUSTERED 
	(
		RequestStatusID
	)
)	

CREATE TABLE Skill
(
	SkillID int NOT NULL IDENTITY (1, 1),
	SkillCode nvarchar(20) NULL,
	SkillDesc nvarchar(100) NULL,
	CONSTRAINT PK_Skill PRIMARY KEY CLUSTERED 
	(
		SkillID
	)
)

CREATE TABLE SkillLevel
(
	SkillLevelID int NOT NULL IDENTITY (1, 1),
	SkillLevelCode nvarchar(20) NULL,
	SkillLevelDesc nvarchar(100) NULL,
	CONSTRAINT PK_SkillLevel PRIMARY KEY CLUSTERED 
	(
		SkillLevelID
	) 
)

CREATE TABLE StaffType
(
	StaffTypeID int NOT NULL IDENTITY (1, 1),
	StaffTypeCode nvarchar(20) NULL,
	StaffTypeDesc nvarchar(100) NULL,
	CONSTRAINT PK_StaffType PRIMARY KEY CLUSTERED 
	(
		StaffTypeID
	) 
)

CREATE TABLE StatutoryHoliday
(
	StatutoryHolidayID int NOT NULL IDENTITY (1, 1),
	StatutoryHolidayDate datetime NULL,
	StatutoryHolidayDesc nvarchar(100) NULL,
	CONSTRAINT PK_StatutoryHoliday PRIMARY KEY CLUSTERED 
	(
		StatutoryHolidayID
	) 
)

CREATE TABLE SystemFunction
(
	FunctionID int NOT NULL IDENTITY (1, 1),
	FunctionCode nvarchar(10) NULL,
	Description nvarchar(100) NULL,
	FunctionCategory nvarchar(100) NULL,
	CONSTRAINT PK_SystemFunction PRIMARY KEY CLUSTERED 
	(
		FunctionID
	)
)
	
CREATE TABLE SystemParameter
	(
	ParameterCode nvarchar(100) NOT NULL,
	ParameterDesc nvarchar(200) NULL,
	ParameterValue nvarchar(200) NULL,
	CONSTRAINT PK_SystemParameter PRIMARY KEY CLUSTERED 
	(
		ParameterCode
	) 
)

CREATE TABLE TaxCompany
(
	TaxCompID int NOT NULL IDENTITY (1, 1),
	TaxCompEmployerName nvarchar(70) NULL,
	TaxCompEmployerAddress nvarchar(90) NULL,
	TaxCompSection nvarchar(3) NULL,
	TaxCompERN nvarchar(8) NULL,
	TaxCompDesignation nvarchar(25) NULL,
	CONSTRAINT PK_TaxCompany PRIMARY KEY CLUSTERED 
	(
		TaxCompID
	)
)

CREATE TABLE TaxCompanyMap
(
	TaxCompMapID int NOT NULL IDENTITY (1, 1),
	TaxCompID int NULL,
	CompanyID int NULL,
	CONSTRAINT PK_TaxCompanyMap PRIMARY KEY CLUSTERED 
	(
		TaxCompMapID
	) 
)

CREATE TABLE TaxEmp
(
	TaxEmpID int NOT NULL IDENTITY (1, 1),
	TaxFormID int NULL,
	EmpID int NULL,
	TaxEmpSheetNo int NULL,
	TaxEmpHKID nvarchar(12) NULL,
	TaxEmpStatus nvarchar(1) NULL,
	TaxEmpSurname nvarchar(20) NULL,
	TaxEmpOtherName nvarchar(55) NULL,
	TaxEmpChineseName nvarchar(50) NULL,
	TaxEmpSex nvarchar(1) NULL,
	TaxEmpMartialStatus nvarchar(1) NULL,
	TaxEmpPassportNo nvarchar(40) NULL,
	TaxEmpIssuedCountry nvarchar(40) NULL,
	TaxEmpSpouseName nvarchar(50) NULL,
	TaxEmpSpouseHKID nvarchar(12) NULL,
	TaxEmpSpousePassportNo nvarchar(40) NULL,
	TaxEmpSpouseIssuedCountry nvarchar(40) NULL,
	TaxEmpResAddr nvarchar(90) NULL,
	TaxEmpResAddrAreaCode nvarchar(1) NULL,
	TaxEmpCorAddr nvarchar(60) NULL,
	TaxEmpCapacity nvarchar(40) NULL,
	TaxEmpPartTimeEmployer nvarchar(30) NULL,
	TaxEmpStartDate datetime NULL,
	TaxEmpEndDate datetime NULL,
	TaxEmpCessationReason nvarchar(100) NULL,
	TaxEmpPlaceOfResidenceIndicator int NULL,
	TaxEmpOvearseasIncomeIndicator int NULL,
	TaxEmpOverseasCompanyAmount nvarchar(20) NULL,
	TaxEmpOverseasCompanyName nvarchar(60) NULL,
	TaxEmpOverseasCompanyAddress nvarchar(60) NULL,
	TaxEmpTaxFileNo nvarchar(13) NULL,
	TaxEmpRemark nvarchar(60) NULL,
	TaxEmpNewEmployerNameddress nvarchar(200) NULL,
	TaxEmpFutureCorAddr nvarchar(200) NULL,
	TaxEmpLeaveHKDate datetime NULL,
	TaxEmpIsERBearTax nvarchar(1) NULL,
	TaxEmpIsMoneyHoldByOrdinance nvarchar(1) NULL,
	TaxEmpHoldAmount real NULL,
	TaxEmpReasonForNotHold nvarchar(200) NULL,
	TaxEmpReasonForDepartureReason nvarchar(200) NULL,
	TaxEmpReasonForDepartureOtherReason nvarchar(200) NULL,
	TaxEmpIsEEReturnHK nvarchar(1) NULL,
	TaxEmpEEReturnHKDate datetime NULL,
	TaxEmpIsShareOptionsGrant nvarchar(1) NULL,
	TaxEmpShareOptionsGrantCount nvarchar(200) NULL,
	TaxEmpShareOptionsGrantDate datetime NULL,
	TaxEmpPreviousEmployerNameddress nvarchar(200) NULL,
	CONSTRAINT PK_TaxEmp PRIMARY KEY CLUSTERED 
	(
		TaxEmpID
	)
)

CREATE TABLE TaxEmpPayment
(
	TaxEmpPayID int NOT NULL IDENTITY (1, 1),
	TaxEmpID int NULL,
	TaxPayID int NULL,
	TaxEmpPayNature nvarchar(35) NULL,
	TaxEmpPayPeriodFr datetime NULL,
	TaxEmpPayPeriodTo datetime NULL,
	TaxEmpPayAmount bigint NULL,
	CONSTRAINT PK_TaxEmpPayment PRIMARY KEY CLUSTERED 
	(
		TaxEmpPayID
	) 
)
CREATE TABLE TaxEmpPlaceOfResidence
(
	TaxEmpPlaceID int NOT NULL IDENTITY (1, 1),
	TaxEmpID int NULL,
	TaxEmpPlaceAddress nvarchar(110) NULL,
	TaxEmpPlaceNature nvarchar(19) NULL,
	TaxEmpPlacePeriodFr datetime NULL,
	TaxEmpPlacePeriodTo datetime NULL,
	TaxEmpPlaceERRent bigint NULL,
	TaxEmpPlaceEERent bigint NULL,
	TaxEmpPlaceEERentRefunded bigint NULL,
	TaxEmpPlaceERRentByEE bigint NULL,
	CONSTRAINT PK_TaxEmpPlaceOfResidence PRIMARY KEY CLUSTERED 
	(
		TaxEmpPlaceID
	)
)

CREATE TABLE TaxForm
(
	TaxFormID int NOT NULL IDENTITY (1, 1),
	TaxCompID int NULL,
	TaxFormSection nvarchar(3) NULL,
	TaxFormERN nvarchar(8) NULL,
	TaxFormYear int NULL,
	TaxFormSubmissionDate datetime NULL,
	TaxFormBatchNo int NULL,
	TaxFormEmployerName nvarchar(70) NULL,
	TaxFormEmployerAddress nvarchar(90) NULL,
	TaxFormDesignation nvarchar(25) NULL,
	TaxFormType nvarchar(1) NULL,
	CONSTRAINT PK_TaxForm PRIMARY KEY CLUSTERED 
	(
		TaxFormID
	)
)

CREATE TABLE TaxPayment
(
	TaxPayID int NOT NULL IDENTITY (1, 1),
	TaxFormType nvarchar(1) NULL,
	TaxPayCode nvarchar(10) NULL,
	TaxPayDesc nvarchar(200) NULL,
	TaxPayNature nvarchar(35) NULL,
	TaxPayIsShowNature nvarchar(1) NULL,
	CONSTRAINT PK_TaxPayment PRIMARY KEY CLUSTERED 
	(
		TaxPayID
	) 
)

CREATE TABLE TaxPaymentMap
(
	TaxPayMapID int NOT NULL IDENTITY (1, 1),
	TaxPayID int NULL,
	PaymentCodeID int NULL,
	CONSTRAINT PK_TaxPaymentMap PRIMARY KEY CLUSTERED 
	(
		TaxPayMapID
	) 
)

CREATE TABLE UploadClaimsAndDeductions
(
	UploadCNDID int NOT NULL IDENTITY (1, 1),
	EmpID int NOT NULL,
	CNDEffDate datetime NOT NULL,
	PayCodeID int NOT NULL,
	CNDAmount decimal(15, 4) NOT NULL,
	CurrencyID nvarchar(3) NOT NULL,
	CNDPayMethod nvarchar(1) NULL,
	EmpAccID int NULL,
	CNDRemark nvarchar(200) NULL,
	CNDNumOfDayAdj real NULL,
	SessionID nvarchar(200) NOT NULL,
	TransactionDate datetime NOT NULL,
	ImportAction nvarchar(100) NULL,
	CONSTRAINT PK_UploadClaimsAndDeductions PRIMARY KEY CLUSTERED 
	(
		UploadCNDID
	) 
)

CREATE TABLE UserGroup
(
	UserGroupID int NOT NULL IDENTITY (1, 1),
	UserGroupName nvarchar(20) NULL,
	UserGroupDesc nvarchar(100) NULL,
	CONSTRAINT PK_UserGroup PRIMARY KEY CLUSTERED 
	(
		UserGroupID
	) 
)

CREATE TABLE UserGroupAccess
(
	UserGroupAccessID int NOT NULL IDENTITY (1, 1),
	UserID int NULL,
	UserGroupID int NULL,
	CONSTRAINT PK_UserGroupAccess PRIMARY KEY CLUSTERED 
	(
		UserGroupAccessID
	) 
)

CREATE TABLE UserGroupFunction
(
	UserGroupFunctionID int NOT NULL IDENTITY (1, 1),
	UserGroupID int NULL,
	FunctionID int NULL,
	FunctionAllowRead int NULL,
	FunctionAllowWrite int NULL,
	CONSTRAINT PK_UserGroupFunction PRIMARY KEY CLUSTERED 
	(
		UserGroupFunctionID
	) 
)

CREATE TABLE UserRank
(
	UserRankID int NOT NULL IDENTITY (1, 1),
	UserID int NULL,
	RankID int NULL,
	CONSTRAINT PK_UserRank PRIMARY KEY CLUSTERED 
	(
		UserRankID
	) 
)

CREATE TABLE Users
(
	UserID int NOT NULL IDENTITY (1, 1),
	LoginID nvarchar(20) NULL,
	UserName nvarchar(100) NULL,
	UserPassword nvarchar(255) NULL,
	UserAccountStatus nvarchar(1) NULL,
	ExpiryDate datetime NULL,
	UserChangePassword int NULL,
	UserChangePasswordUnit nvarchar(1) NULL,
	UserChangePasswordPeriod int NULL,
	UserChangePasswordDate datetime NULL,
	FailCount int NULL,
	CONSTRAINT PK_Users PRIMARY KEY CLUSTERED 
	(
		UserID
	) 
)

