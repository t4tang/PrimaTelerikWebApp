﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pur01h01aReportViewer.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.PurchaseReq.pur01h01aReportViewer" %>
<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Preview</title>
    <script type="text/javascript" src="../../../Script/jqueri-1.9.1.min.js" ></script>

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
        <telerik:ReportViewer
            ID="reportViewer1" 
			Width="1127px"
			Height="600px"
			EnableAccessibility="false"
            runat="server">
            <ReportSource IdentifierType="TypeReportSource" Identifier="TelerikWebApplication.Form.Purchase.PurchaseReq.pur01h01typeA_slip, TelerikWebApplication, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
            </ReportSource>
        </telerik:ReportViewer>
    </form>
</body>
</html>