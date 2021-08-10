 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h05fcReportViewer.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.FluidControl.Fuel.inv01h05fcReportViewer" %>

<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Telerik HTML5 Web Forms Report Viewer Form</title>
    <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>

	<style>
		#reportViewer1 {
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
    <form runat="server">
    <div>
        <telerik:ReportViewer
            ID="reportViewer_inv01h05fc" 
			Width="1127px"
			Height="600px"
			EnableAccessibility="false"
            runat="server">
            <ReportSource IdentifierType="TypeReportSource" Identifier="TelerikWebApplication.Form.Inventory.FluidControl.Fuel.inv01h05fc_slip, ReportLibrary, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
            </ReportSource>
        </telerik:ReportViewer>
    
    </div>
    </form>
</body>
</html>
