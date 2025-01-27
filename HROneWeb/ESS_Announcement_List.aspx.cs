using System;
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
using HROne.Translation;
using HROne.Lib.Entities;

public partial class ESS_Announcement_List : HROneWebPage
{
    private const string FUNCTION_CODE = "TLS001";

    protected DBManager db = EESSAnnouncement.db;
    protected SearchBinding binding;
    protected ListInfo info;
    protected DataView view;
    

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!WebUtils.CheckAccess(Response, Session, FUNCTION_CODE, WebUtils.AccessLevel.Read))
            return;

        binding = new SearchBinding(dbConn, db);
        binding.add(new LikeSearchBinder(ESSAnnouncementCode, "ESSAnnouncementCode"));
        //binding.add(new DropDownVLSearchBinder(LeaveTypeID, "c.LeaveTypeID", ELeaveType.VLLeaveType));
        //binding.add(new DropDownVLSearchBinder(PaymentCodeID, "PaymentCodeID", EPaymentCode.VLPaymentCode));

        binding.init(DecryptedRequest, null);

        HROne.Common.WebUtility.WebControlsLocalization(this, this.Controls);

        info = ListFooter.ListInfo;

        if (!Page.IsPostBack)
        {
            view = loadData(info, db, Repeater);
        }
        
    }

    public DataView loadData(ListInfo info, DBManager db, Repeater repeater)
    {
        DBFilter filter = binding.createFilter();

        if (info != null && info.orderby != null && !info.orderby.Equals(""))
            filter.add(info.orderby, info.order);

        string select = "c.*";
        string from = "from [" + db.dbclass.tableName + "] c";

        DataTable table = WebUtils.GetDataTableFromSelectQueryWithFilter(dbConn, select, from, filter, info);
        
        view = new DataView(table);

        ListFooter.Refresh();

        if (repeater != null)
        {
            repeater.DataSource = view;
            repeater.DataBind();
        }

        return view;
    }
    protected void Search_Click(object sender, EventArgs e)
    {
        info.page = 0;
        view = loadData(info, db, Repeater);

    }
    protected void Reset_Click(object sender, EventArgs e)
    {
        binding.clear();
       // LeaveTypeID.SelectedIndex = 0;
        info.page = 0;
        view = loadData(info, db, Repeater);

    }
    protected void FirstPage_Click(object sender, EventArgs e)
    {
        view = loadData(info, db, Repeater);
    }

    protected void PrevPage_Click(object sender, EventArgs e)
    {
        view = loadData(info, db, Repeater);
    }

    protected void NextPage_Click(object sender, EventArgs e)
    {
        view = loadData(info, db, Repeater);
    }

    protected void LastPage_Click(object sender, EventArgs e)
    {
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
        WebFormUtils.LoadKeys(db, row, cb);
        e.Item.FindControl("ItemSelect").Visible = toolBar.DeleteButton_Visible;
    }
    protected void Delete_Click(object sender, EventArgs e)
    {
        PageErrors errors = PageErrors.getErrors(db, Page.Master);
        errors.clear();

        ArrayList list = WebUtils.SelectedRepeaterItemToBaseObjectList(db, Repeater, "ItemSelect");
        foreach (EESSAnnouncement obj in list)
        {
            db.select(dbConn, obj);
            DBFilter filter = new DBFilter();
            filter.add(new Match("ESSAnnouncementID", obj.ESSAnnouncementID));
            ArrayList essAnnouncementList = EESSAnnouncement.db.select(dbConn, filter);
            if (essAnnouncementList.Count > 0)
            {
                foreach (EESSAnnouncement eSSAnnouncement in essAnnouncementList)
                {

                    EESSAnnouncement.db.delete(dbConn, eSSAnnouncement);

                } 
            }
            else
            {
                db.delete(dbConn, obj);
                WebUtils.EndFunction(dbConn);
            }

        }
        loadData(info, db, Repeater);
    }

    public void New_Click(object sender, EventArgs e)
    {
        HROne.Common.WebUtility.RedirectURLwithEncryptedQueryString(Response, Session, "ESS_Announcement_Edit.aspx");
    }
}
