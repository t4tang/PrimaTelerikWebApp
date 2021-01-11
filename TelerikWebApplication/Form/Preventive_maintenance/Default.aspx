<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TelerikWebApplication.Forms.Preventive_maintenance.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">  
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>  
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <%--<div  class="scroller" runat="server" style="border: thin inset #C0C0C0; height:600px">
        
    </div>--%>
</asp:Content>
