<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.Reports.Default" %>
<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>
<%@ Register Assembly="Telerik.ReportViewer.Html5.WebForms, Version=12.1.18.516, Culture=neutral, PublicKeyToken=a9d7983dfcc261be" Namespace="Telerik.ReportViewer.Html5.WebForms" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    
    <script type="text/javascript" src="../../../Script/Script.js" ></script>

  <script src="../../../Script/jqueri-1.9.1.min.js"></script>
	 <%--  <script src="../../../Script/kendo.all.min.js"></script>--%>
   <script src="Scripts/themeSwitcher.js"></script>

    <link href="../../../Styles/kendo.common.min.css" rel="stylesheet" id="commonCss" />
    <link href="../../../Styles/kendo.blueopal.min.css" rel="stylesheet" id="skinCss" />

    <style>
        /*body {
            margin: 5px;
            font-family: Verdana, Arial;
        }*/

        #reportViewer1 {

            /*position: absolute;
            left: 5px;
            right: 5px;
            top: 40px;
            bottom: 5px;
            overflow: hidden;
            clear: both;*/

            position:absolute;
			left: 5px;
			right: 5px;
			top: 5px;
			bottom: 5px;
			overflow: hidden;
			font-family: Verdana, Arial;
        }

        #theme-switcher {
            float: right;
            width: 12em;
            height: 30px;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            //Theme switcher
            themeSwitcher(
                '#theme-switcher',
                '#commonCss',
                '#skinCss');
        });
    </script>
    </telerik:RadCodeBlock>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
            <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
        </ContentTemplate>        
    </asp:UpdatePanel> 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="scroller" runat="server">
    <%--<select id="theme-switcher"></select>--%>

        <telerik:ReportViewer ID="ReportViewer1" runat="server"
            Width="1300px"
			    Height="680px"
			    EnableAccessibility="false" >
            <ReportSource
                IdentifierType="TypeReportSource" 
                Identifier="ReportLibrary.Reports.Purchase.ReportCatalog, ReportLibrary, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
            </ReportSource>
             
        </telerik:ReportViewer>
    </div>
</asp:Content>
