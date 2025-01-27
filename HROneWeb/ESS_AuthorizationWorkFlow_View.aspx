<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ESS_AuthorizationWorkFlow_View.aspx.cs" Inherits="ESS_AuthorizationWorkFlow_View" MasterPageFile="~/MainMasterPage.master" %>

<%@ Register Src="~/controls/RecordListFooter.ascx" TagName="RecordListFooter" TagPrefix="tb" %>
<%@ Register Src="controls/DetailToolBar.ascx" TagName="DetailToolBar" TagPrefix="tb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <input type="hidden" id="AuthorizationWorkFlowID" runat="server" name="ID" />
	<table border="0" cellpadding="0" cellspacing="0" width="100%" class="pm_page_title">
            <tr>
                <td>
                    <asp:Label runat="server" Text="Authorization Workflow Setup" />
                </td>
            </tr>
        </table>
     <table border="0" cellpadding="0" cellspacing="0" width="100%" class="pm_section_title">
        <tr>
            <td>
                <asp:Label ID="Label2" runat="server" Text="View" />
                <asp:Label runat="server" Text="Authorization Workflow" />
            </td>
        </tr>
    </table>
    
        
            
    
        <table width="100%" cellpadding="0" cellspacing="0" class="pm_button_section">
            <tr>
                <td>
                    <tb:DetailToolBar ID="toolBar" runat="server" 
                        NewButton_Visible="false" 
                        SaveButton_Visible="false"
                        OnBackButton_Click="Back_Click" 
                        OnEditButton_Click="Edit_Click" 
                        OnDeleteButton_Click="Delete_Click" 
                    />
                </td>
                <td align="right">
                    <asp:Button ID="btnHelp" runat="server" CssClass="button" Text=" Help" Visible="false" UseSubmitBehavior="false" OnClientClick="openHelp(); return false;" />
                </td>
            </tr>
        </table>
        <table width="100%" class="pm_section">
                <col width="30%" />
                <col width="70%" />
            <tr>
                <td class="pm_field_header" >
                    <asp:Label ID="Label1" runat="server" Text="Code" />:
                </td>
                <td class="pm_field">
                    <asp:Label ID="AuthorizationWorkFlowCode" runat="server"/>

                </td>
            </tr>
            <tr>
                <td class="pm_field_header" >
                    <asp:Label ID="Label6" runat="server" Text="Description" />:
                </td>
                <td class="pm_field">
                    <asp:Label ID="AuthorizationWorkFlowDescription" runat="server"/>
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" >
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="toolbar"/>
        </Triggers>
        <ContentTemplate>
        <table border="0" width="100%" class="pm_list_section" cellspacing="0" cellpadding="1">
            <col width="50px" /> 
            <col width="50px" /> 
            <col width="750px" /> 
            <tr>
                <td class="pm_list_header">
                </td>
                <td class="pm_list_header">
                </td>
                <td align="left" class="pm_list_header">
                    <asp:Label runat="server" Text="Authorization Group" />
                </td>
            </tr>
            <asp:Repeater ID="AuthorizationWorkFlowRepeater" runat="server" OnItemDataBound="AuthorizationWorkFlowRepeater_ItemDataBound">
                <ItemTemplate>
                    <tr>
                        <td class="pm_list" align="center">
                        </td>
                        <td class="pm_list" align="center">
                            <%#AuthorizationWorkFlowDetailSearchBinding.getValue(Container.DataItem, "AuthorizationWorkFlowIndex")%>
                        </td>
                        <td class="pm_list">
                            <%#AuthorizationWorkFlowDetailSearchBinding.getValue(Container.DataItem, "AuthorizationGroupID")%>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
        <tb:RecordListFooter ID="ListFooter" runat="server" ShowAllRecords="true" Visible="true" 
        ListOrder="true" 
        ListOrderBy="AuthorizationWorkFlowIndex" />
        </ContentTemplate>
        </asp:UpdatePanel> 
</asp:Content> 