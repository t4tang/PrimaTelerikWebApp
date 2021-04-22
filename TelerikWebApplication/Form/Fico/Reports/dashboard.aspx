<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Reports.dashboard" %>
<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>
<%@ Register Assembly="Telerik.ReportViewer.Html5.WebForms, Version=12.1.18.516, Culture=neutral, PublicKeyToken=a9d7983dfcc261be" Namespace="Telerik.ReportViewer.Html5.WebForms" TagPrefix="telerik" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../../../Script/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../../../Script/Script.js"></script>
    <script src="Scripts/themeSwitcher.js"></script>

    <script src="jquery-1.3.2.min.js"></script>  
    <script src="jquery.dimensions.js"></script>  

    <style>
        body {
            margin: 5px;
            font-family: Verdana, Arial;
        }

        #reportViewer1 {
            position: absolute;
            left: 15px;
            right: 20px;
            top: 20px;
            bottom: 5px;
            overflow: hidden;
            clear: both;
        }

    </style>

</head>
<body>
    <form runat="server">		
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
        <div style="padding-top:20px">
            <telerik:ReportViewer 
                Width="98%"
			    Height="680px"
			    EnableAccessibility="false"
                ID="reportViewer1"
                runat="server">
                <ReportSource
                    IdentifierType="TypeReportSource" 
                    Identifier="ReportLibrary.Reports.Fico.ReportCatalog, ReportLibrary, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
                </ReportSource>
            </telerik:ReportViewer>
        </div>

    </form>
</body>
</html>