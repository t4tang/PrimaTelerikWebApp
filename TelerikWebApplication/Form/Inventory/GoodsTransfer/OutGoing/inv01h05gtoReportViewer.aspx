<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h05gtoReportViewer.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.GoodsTransfer.OutGoing.inv01h05gtoReportViewer" %>
<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Preview</title>
    <script src="../../../../Script/jqueri-1.9.1.min.js"></script>
	<style>
		#reportViewer_inv01h05 {
			position: absolute;
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
    <telerik:ReportViewer
            ID="reportViewer_inv01h05gto" 
			Width="1300px"
			Height="900px"
			EnableAccessibility="false"
            runat="server">
            <ReportSource IdentifierType="TypeReportSource" Identifier="TelerikWebApplication.Form.Inventory.GoodsTransfer.OutGoing.inv01h05gto_slip, TelerikWebApplication, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
            </ReportSource>
        </telerik:ReportViewer>
    </form>
</body>
</html>
