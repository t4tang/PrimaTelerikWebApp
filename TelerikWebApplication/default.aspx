<%@ Page MetaDescription="Telerik WebMail" MetaKeywords="telerik webmail,webmail,outlook inspired app" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="TelerikWebApplication.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Styles/mail.css" rel="stylesheet" />
      <style type="text/css">
        html .RadGrid .rgMasterTable {
            height: auto;
        }

        .subject {
            position: relative;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="Server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    
</asp:Content>
