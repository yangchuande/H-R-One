﻿<%@ page language="C#" autoeventwireup="true" inherits="Emp_View, HROneWeb.deploy" masterpagefile="~/MainMasterPage.master" viewStateEncryptionMode="Always" %>
<%@ Register Src="~/controls/DetailToolBar.ascx" TagName="DetailToolBar" TagPrefix="tb" %>
<%@ Register Src="~/controls/Emp_PersonalInfo.ascx" TagName="Emp_PersonalInfo" TagPrefix="uc2" %>
<%@ Register Src="~/controls/Emp_Common.ascx" TagName="Emp_Common" TagPrefix="uc1" %>
<%@ Register Src="~/controls/Emp_LeftMenu.ascx" TagName="Emp_LeftMenu" TagPrefix="uc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
        <input type="hidden" id="EmpID" runat="server" name="ID" />
		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="pm_page_title">
            <tr>
                <td>
                    <asp:Label EnableViewState="false" Text="Employee Information" runat="server" />
                </td>
            </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="pm_section_title">
            <tr>
                <td>
                    <asp:Label EnableViewState="false" Text="View Employee Profile" runat="server" />: <%=Emp_Common1.obj.EmpEngSurname %> <%=Emp_Common1.obj.EmpEngOtherName%> 
                </td>
            </tr>
        </table>
        <table width="100%" class="pm_section" cellpadding="0" cellspacing="0">
            <col width="10%" />
            <tr>
                <td valign="top" align="left" >
                    <uc1:Emp_LeftMenu ID="Emp_LeftMenu2" runat="server" />
                </td>
                <td valign="top">
        <table width="100%" cellpadding="0" cellspacing="0" class="pm_button_section">
            <tr>
                <td>
                    <tb:DetailToolBar id="toolBar" runat="server"
                     NewButton_Visible="false" 
                     SaveButton_Visible="false" 
                     OnBackButton_Click="Back_Click"
                     OnEditButton_Click ="Edit_Click"
                     DeleteButton_Visible="false"
                     CustomButton1_Name="Rejoin with new Emp No."
                     OnCustomButton1_Click="Edit_Click"
                     CustomButton1_Visible="true" 
                     CustomButton2_Name="Reset Password"
                     OnCustomButton2_Click="btnResetPassword_Click"
                     CustomButton2_Visible="true" 
                     CustomButton3_Name="Add Role"
                     OnCustomButton3_Click="Edit_Click"
                     CustomButton3_Visible="false" 
                      />
                </td>
                <td align="right">
                    <asp:Button ID="btnHelp" runat="server" CSSClass="button" EnableViewState="false" Text=" Help" Visible="false" UseSubmitBehavior="false" OnClientClick="openHelp(); return false;"/>
                </td>
                <!-- Start 0000173, Miranda, 2015-04-26 -->
                <td class="pm_search" align="right">
                    <asp:TextBox runat="server" ID="EmpNo" />
                    <asp:Button ID="Jump" runat="server" Text="Jump" CssClass="button" OnClick="Jump_Click" />
                </td>
                <!-- End 0000173, Miranda, 2015-04-26 -->
            </tr>
        </table>

                    <uc1:Emp_Common ID="Emp_Common1" runat="server"/>
                    <br />
                    <uc2:Emp_PersonalInfo ID="Emp_PersonalInfo1" runat="server" />
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" >
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="toolbar"/>
        </Triggers>
        </asp:UpdatePanel> 

</asp:Content> 