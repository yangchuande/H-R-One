<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Emp_Spouse_Edit.aspx.cs"    Inherits="Emp_Spouse_Edit" MasterPageFile="~/MainMasterPage.master"  %>
<%@ Register Src="~/controls/DetailToolBar.ascx" TagName="DetailToolBar" TagPrefix="tb" %>
<%@ Register Src="~/controls/Emp_Common.ascx" TagName="Emp_Common" TagPrefix="uc1" %>
<%@ Register Src="~/controls/WebDatePicker.ascx" TagName="WebDatePicker" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
        <input type="hidden" id="EmpSpouseID" runat="server" name="ID" />
        <input type="hidden" id="EmpID" runat="server" name="ID" />
		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="pm_page_title">
            <tr>
                <td>
                    <asp:Label Text="Employee Information" runat="server" />
                </td>
            </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="pm_section_title">
            <tr>
                <td>
                    <%=CurID<=0?HROne.Common.WebUtility.GetLocalizedString("Add"):HROne.Common.WebUtility.GetLocalizedString("Edit") %>
                    <asp:Label runat="server" Text="Spouse" />:
                    <%=EmpSpouseSurname.Text %>
                </td>
            </tr>
        </table>
        
            
                
        
        <uc1:Emp_Common id="Emp_Common1" runat="server"></uc1:Emp_Common><br /> 
        <table width="100%" cellpadding="0" cellspacing="0" class="pm_button_section">
            <tr>
                <td>
                    <tb:DetailToolBar id="toolBar" runat="server"
                     NewButton_Visible="false" 
                     EditButton_Visible="false" 
                     OnBackButton_Click="Back_Click"
                     OnSaveButton_Click ="Save_Click"
                     OnDeleteButton_Click="Delete_Click"
                      />
                </td>
                <td align="right">
                    <asp:Button ID="btnHelp" runat="server" CSSClass="button" Text=" Help" Visible="false" UseSubmitBehavior="false" OnClientClick="openHelp(); return false;"/>
                </td>
            </tr>
        </table>
        <table border="0" width="100%" cellpadding="0" cellspacing="0" class="pm_field_section">
            <col width="15%" />
            <col width="35%" />
            <col width="15%" />
            <col width="35%" />
            <tr>
                <td class="pm_field_header" >
                    <asp:Label runat="server" Text="Surname" />:</td>
                <td class="pm_field" >
                    <asp:TextBox ID="EmpSpouseSurname" runat="Server" /></td>
                <td class="pm_field_header" >
                    <asp:Label runat="server" Text="Other Name" />:</td>
                <td class="pm_field" >
                    <asp:TextBox ID="EmpSpouseOtherName" runat="Server" /></td>
            </tr>
            <tr>
                <td class="pm_field_header">
                    <asp:Label runat="server" Text="Chinese Name" />:</td>
                <td class="pm_field">
                    <asp:TextBox ID="EmpSpouseChineseName" runat="Server" /></td>
                <td class="pm_field_header">
                    <asp:Label ID="Label3" runat="server" Text="Date of Birth" />:</td>
                <td class="pm_field">
                    <uc1:WebDatePicker id="EmpSpouseDateOfBirth" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="pm_field_header">
                    <asp:Label ID="Label1" runat="server" Text="HKID" />:</td>
                <td class="pm_field">
                    <asp:TextBox ID="EmpSpouseHKID" runat="Server" />
                    (<asp:TextBox ID="EmpSpouseHKID_Digit" runat="Server" />)</td>
            <%-- Start 0000142, KuangWei, 2014-12-20 --%>
                <td class="pm_field_header">
                    <asp:Label runat="server" EnableViewState="false" Text="Sex" />:</td>
                <td class="pm_field">
                    <asp:DropDownList ID="EmpGender" runat="Server" /></td> 
            <%-- End 0000142, KuangWei, 2014-12-20 --%>                     
            </tr>
            <tr>
                <td class="pm_field_header">
                    <asp:Label runat="server" Text="Passport No." />:</td>
                <td class="pm_field">
                    <asp:TextBox ID="EmpSpousePassportNo" runat="Server" /></td>
                <td class="pm_field_header">
                    <asp:Label runat="server" Text="Country of Issue" />:</td>
                <td class="pm_field">
                    <asp:TextBox ID="EmpSpousePassportIssuedCountry" runat="Server" /></td>
            </tr>
            <%-- Start 0000142, KuangWei, 2014-12-20 --%>
            <tr>
                <td class="pm_field_header">
                    <asp:Label ID="Label27" EnableViewState="false" Text="Medical Scheme Insured" runat="server"  />?</td>
                <td class="pm_field" >
                    <asp:CheckBox ID="EmpIsMedicalSchemaInsured" runat="server" Checked="True" OnCheckedChanged="IsMedicalInsured_OnCheckedChanged" AutoPostBack="true"/>	</td>
                <td class="pm_field_header">
                    <asp:Label ID="Label28" EnableViewState="false" Text="Medical Effective Date" runat="server"  />:</td>
                <td class="pm_field" >
                    <uc1:WebDatePicker id="EmpMedicalEffectiveDate" runat="server" /></td>
            </tr>      
            <tr>
                <td class="pm_field_header">
                    <asp:Label ID="Label4" EnableViewState="false" Text="Expiry Date" runat="server"  />:</td>
                <td class="pm_field" >
                    <uc1:WebDatePicker id="EmpMedicalExpiryDate" runat="server" /></td>
            </tr>  
            <%-- End 0000142, KuangWei, 2014-12-20 --%>
        </table>
</asp:Content> 