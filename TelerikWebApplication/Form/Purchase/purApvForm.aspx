<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="purApvForm.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.purApvForm" %>
<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../Styles/common.css" rel="stylesheet" />
    <link href="../../Styles/custom-cs.css" rel="stylesheet" />
    <script src="../../Script/jqueri-1.9.1.min.js"></script>
    <style>
		#reportViewer1 {
			position:absolute;
			left: 5px;
			right: 5px;
			top: 5px;
			bottom: 5px;
			overflow: hidden;
			font-family: Verdana, Arial;
            text-align:center;
		}
	</style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
        <div>
            <telerik:ReportViewer
                ID="reportViewer1" 
			    Width="1000px"
			    Height="600px"                
			    EnableAccessibility="false"
                runat="server">
                <ReportSource IdentifierType="TypeReportSource" Identifier="TelerikWebApplication.Forms.Purchase.Purchase_order.pur01h02_slip, TelerikWebApplication, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
                </ReportSource>                
            </telerik:ReportViewer>
        </div>
        <div style="position:absolute; padding: 15px 5px 25px 15px; text-align:right; width:950px" >
            <%--<telerik:RadRadioButtonList ID="RadRadioButtonList1" runat="server">
                <Items>
                    <telerik:ButtonListItem Text="Approve" Value="1" />
                </Items>
            </telerik:RadRadioButtonList>
            <asp:Button ID="Button1" runat="server" Text="Button" />--%>
            <asp:ImageButton ID="btnOk" runat="server" ImageUrl="~/Images/ok-hand-gray.png" Enabled="false" Height="20px" Width="22px" ToolTip="OK to Sign" OnClick="btnOk_Click" />
        </div>
        <div style="clear:both; font-size:1px;"></div>
    </form>
</body>
</html>
