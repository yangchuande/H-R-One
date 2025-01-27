using System;
using System.Text;
using System.Globalization;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using HROne.DataAccess;
//using perspectivemind.validation;

using HROne.Lib.Entities;

public partial class Report_Payroll_FinalPaymentStatement_List : HROneWebPage
{
    private const string FUNCTION_CODE = "RPT211";
    protected DBManager db = EEmpPersonalInfo.db;
    protected SearchBinding binding;
    protected ListInfo info;
    protected DataView view;

    private const string SYSTEMPARAMETER_PREPAREDBY = "REPORT_PAYROLL_FINALPAYMENTSTATEMENT_PREPAREDBY";
    private const string SYSTEMPARAMETER_REVIEWEDBY = "REPORT_PAYROLL_FINALPAYMENTSTATEMENT_REVIEWEDBY";
    

    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!WebUtils.CheckAccess(Response, Session, FUNCTION_CODE, WebUtils.AccessLevel.Read))
            return;

        

        binding = new SearchBinding(dbConn, db);
        //binding.add(new LikeSearchBinder(EmpNo, "EmpNo"));
        //binding.add(new LikeSearchBinder(EmpEngSurname, "EmpEngSurname"));
        //binding.add(new LikeSearchBinder(EmpEngOtherName, "EmpEngOtherName"));
        //binding.add(new LikeSearchBinder(EmpChiFullName, "EmpChiFullName"));
        //binding.add(new LikeSearchBinder(EmpAlias, "EmpAlias"));
        //binding.add(new DropDownVLSearchBinder(EmpGender, "EmpGender", EPayrollGroup.VLPayrollGroup).setLocale(ci));

        //binding.add(new FieldDateRangeSearchBinder(JoinDateFrom, JoinDateTo, "EmpDateOfJoin").setUseCurDate(false));
        //binding.add(new FieldDateRangeSearchBinder((HtmlInputText)EmployeeSearchControl1.AdditionElementControl.FindControl("LastEmploymentDateFrom"), (HtmlInputText)EmployeeSearchControl1.AdditionElementControl.FindControl("LastEmploymentDateTo"), "et.EmpTermLastDate").setUseCurDate(false));
       
        binding.init(DecryptedRequest, null);
        info = ListFooter.ListInfo;

        HROne.Common.WebUtility.WebControlsLocalization(this, this.Controls);

    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtPreparedBy.Text = ESystemParameter.getParameter(dbConn, SYSTEMPARAMETER_PREPAREDBY);
            txtReviewedBy.Text = ESystemParameter.getParameter(dbConn, SYSTEMPARAMETER_REVIEWEDBY);
            //---------------------------------------
            // Show terminated employee 
            this.EmployeeSearchControl1.EmpStatusValue = "T";
            //---------------------------------------
            view = loadData(info, db, Repeater);
        }


    }

    public DataView loadData(ListInfo info, DBManager db, Repeater repeater)
    {
        DBFilter filter = binding.createFilter();

        if (info != null && info.orderby != null && !info.orderby.Equals(""))
            filter.add(info.orderby, info.order);


        string select = "et.EmpTermID, e.*";
        string from = "from [" + db.dbclass.tableName + "] e ";//LEFT JOIN " + EEmpPositionInfo.db.dbclass.tableName + " p ON c.EmpID=p.EmpID AND p.EmpPosEffTo IS NULL";
        from += " inner join " + EEmpTermination.db.dbclass.tableName + " et on et.empid = e.empid ";
        filter.add(WebUtils.AddRankFilter(Session, "e.EmpID", true));

        //DateTime dtLastEmploymentDateFrom, dtLastEmploymentDateTo;
        //if (DateTime.TryParse(((WebDatePicker)EmployeeSearchControl1.AdditionElementControl.FindControl("LastEmploymentDateFrom")).Value, out dtLastEmploymentDateFrom))
        //    filter.add(new Match("et.EmpTermLastDate", ">=", dtLastEmploymentDateFrom));
        //if (DateTime.TryParse(((WebDatePicker)EmployeeSearchControl1.AdditionElementControl.FindControl("LastEmploymentDateTo")).Value, out dtLastEmploymentDateTo))
        //    filter.add(new Match("et.EmpTermLastDate", "<=", dtLastEmploymentDateTo));

        DBFilter empPayrollFilter = new DBFilter();
        empPayrollFilter.add(Payroll_PeriodSelectionList1.GetEmpPayrollDBTerm());
        DBFilter lastEmploymentDateFilter= new DBFilter();
        lastEmploymentDateFilter.add(new MatchField("et.EmpTermLastDate","<=","tmpPP.PayPeriodTo"));
        empPayrollFilter.add(new IN("ep.PayPeriodID", "SELECT tmpPP.PayPeriodID FROM " + EPayrollPeriod.db.dbclass.tableName + " tmpPP", lastEmploymentDateFilter));
        filter.add(new IN("e.EmpID", "SELECT DISTINCT ep.EmpID FROM " + EEmpPayroll.db.dbclass.tableName + " ep", empPayrollFilter));

        DBFilter empInfoFilter = EmployeeSearchControl1.GetEmpInfoFilter(AppUtils.ServerDateTime(), AppUtils.ServerDateTime());
        empInfoFilter.add(new MatchField("e.EmpID", "ee.EmpID"));
        filter.add(new Exists(EEmpPersonalInfo.db.dbclass.tableName + " ee", empInfoFilter));

        DataTable table = filter.loadData(dbConn, null, select, from);
        table = EmployeeSearchControl1.FilterEncryptedEmpInfoField(table, info);

        view = new DataView(table);
        if (repeater != null)
        {
            repeater.DataSource = view;
            repeater.DataBind();
        }

        return view;
    }
    protected void Search_Click(object sender, EventArgs e)
    {
        view = loadData(info, db, Repeater);

    }
    protected void Reset_Click(object sender, EventArgs e)
    {
        binding.clear();
        EmployeeSearchControl1.Reset();
        this.EmployeeSearchControl1.EmpStatusValue = "T";

        //foreach (RepeaterItem item in HierarchyLevel.Items)
        //{
        //    DropDownList c = (DropDownList)item.FindControl("HElementID");
        //    c.SelectedIndex = 0;
        //}
        view = loadData(info, db, Repeater);


    }

    protected void ChangeOrder_Click(object sender, EventArgs e)
    {
        LinkButton l = (LinkButton)sender;
        String id = l.ID.Substring(1);
        if (info.orderby == null)
            info.order = true;
        else if (info.orderby.Equals(id))
            info.order = !info.order;
        else
            info.order = true;
        info.orderby = id;

        view = loadData(info, db, Repeater);

    }

    protected void Repeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        DataRowView row = (DataRowView)e.Item.DataItem;
        CheckBox cb = (CheckBox)e.Item.FindControl("ItemSelect");
        WebFormUtils.LoadKeys(EEmpTermination.db, row, cb);
    }


    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        PageErrors errors = PageErrors.getErrors(db, Page.Master);
        errors.clear();

        ArrayList empTermList = new ArrayList();
        foreach (RepeaterItem item in Repeater.Items)
        {
            CheckBox cb = (CheckBox)item.FindControl("ItemSelect");
            if (cb.Checked)
            {
                EEmpTermination et = new EEmpTermination();
                WebFormUtils.GetKeys(EEmpTermination.db, et, cb);
                empTermList.Add(et);
            }
        }

        string strTermEmpList = string.Empty;
        if (empTermList.Count > 0)
        {

            //foreach (EEmpTermination o in empTermList)
            //{
            //    if (strTermEmpList == string.Empty)
            //        strTermEmpList = o.EmpTermID.ToString();
            //    else
            //        strTermEmpList += "_" + o.EmpTermID.ToString();

            //}
        }
        else
            errors.addError("Employee not selected");

        if (errors.isEmpty())
        {
            ESystemParameter.setParameter(dbConn, SYSTEMPARAMETER_PREPAREDBY, txtPreparedBy.Text);
            ESystemParameter.setParameter(dbConn, SYSTEMPARAMETER_REVIEWEDBY, txtReviewedBy.Text);

            HROne.Reports.Payroll.FinalPaymentStatementProcess rpt = null;
            if (Payroll_PeriodSelectionList1.SelectedPayrollStatus.Equals("C"))
            {
                ArrayList payBatchList = this.Payroll_PeriodSelectionList1.GetPayBatchList();
                rpt = new HROne.Reports.Payroll.FinalPaymentStatementProcess(dbConn, empTermList, null, payBatchList, HROne.Reports.Payroll.FinalPaymentStatementProcess.ReportType.History, txtPreparedBy.Text, txtReviewedBy.Text);
            }
            else if (Payroll_PeriodSelectionList1.SelectedPayrollStatus.Equals("T"))
            {
                ArrayList payPeriodList = this.Payroll_PeriodSelectionList1.GetTrialRunPayPeriodList();
                rpt = new HROne.Reports.Payroll.FinalPaymentStatementProcess(dbConn, empTermList, payPeriodList, null, HROne.Reports.Payroll.FinalPaymentStatementProcess.ReportType.TrialRun, txtPreparedBy.Text, txtReviewedBy.Text);
            }

            string reportFileName = WebUtils.GetLocalizedReportFile(Server.MapPath("~/Report_Payroll_FinalPaymentStatement.rpt"));

            WebUtils.ReportExport(dbConn, user, errors, lblReportHeader.Text, Response, rpt, reportFileName, ((Button)sender).CommandArgument, "FinalPaymentStatement", true);



            //TerminationFormProcess rpt = new TerminationFormProcess(empTermList, Server.MapPath("Customize_Report_Employee_TerminationForm.xsd"), txtPreparedBy.Text, txtReviewedBy.Text, txtApprovedBy.Text);
            //string reportFileName = WebUtils.GetLocalizedReportFile(Server.MapPath("Customize_Report_Employee_TerminationForm.rpt"));
            //WebUtils.ReportExport(dbConn, user, errors, lblReportHeader.Text, Response, rpt, reportFileName, ((Button)sender).CommandArgument, "TerminationForm");

        }
        //else
        //        emploadData(empInfo, EEmpPayroll.db, empRepeater);
    }

    protected void Payroll_PeriodSelectionList1_PayrollBatchChecked(object sender, EventArgs e)
    {
        info.page = 0;
        view = loadData(info, db, Repeater);
    }

}
