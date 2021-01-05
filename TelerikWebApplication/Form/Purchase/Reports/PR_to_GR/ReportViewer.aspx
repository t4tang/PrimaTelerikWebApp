<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ReportViewer.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.Reports.PR_to_GR.ReportViewer" %>
<%@ Register Assembly="Telerik.ReportViewer.Html5.WebForms, Version=12.1.18.516, Culture=neutral, PublicKeyToken=a9d7983dfcc261be" Namespace="Telerik.ReportViewer.Html5.WebForms" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("reportViewer.aspx?doc_no=" + id, "PreviewDialog");
                return false;
            }

        </script>

        

        <style>
		#reportViewer1 {
			position: absolute;
			left: 5px;
			right: 5px;
			top: 5px;
			bottom: 5px;
			overflow: hidden;
			font-family: Verdana, Arial;
		}
	</style>
    </telerik:RadCodeBlock>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <div  class="scroller" runat="server">
        <telerik:ReportViewer ID="ReportViewer1" runat="server"
            Width="1300px"
			    Height="680px"
			    EnableAccessibility="false" >
                <ReportSource IdentifierType="TypeReportSource" Identifier="ReportLibrary.Reports.rpt_pr_to_gr, ReportLibrary, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
                </ReportSource>      
        </telerik:ReportViewer>
    </div>
</asp:Content>
