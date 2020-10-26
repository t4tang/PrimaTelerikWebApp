<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pur01h02srvReportViewer.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.Purchase_service.pur01h02srvReportViewer" %>
<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Preview</title>
    <script type="text/javascript" src="../../../Script/jqueri-1.9.1.min.js"></script>
    <script src="../../../Script/jquery-1.9.1.min.js"></script>

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
    <form runat="server">
        <div runat="server">
            <telerik:ReportViewer
            ID="reportViewer_pur010h02srv" 
			Width="1127px"
			Height="600px"
			EnableAccessibility="false"
            runat="server">
                <ReportSource IdentifierType="TypeReportSource" Identifier="TelerikWebApplication.Form.Purchase.Purchase_service.pur01h02srv_slip, TelerikWebApplication, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
                </ReportSource>
            </telerik:ReportViewer>
        </div>
    </form>
</body>
</html>
