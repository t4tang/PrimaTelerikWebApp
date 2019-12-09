<%@ Page Title="Contacts" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="contacts.aspx.cs" Inherits="TelerikWebApplication.Contacts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" type="text/css" href="Styles/contacts.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="Server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <telerik:RadNavigation runat="server" ID="contactsNavigation" Skin="BlackMetroTouch" CssClass="secondaryMenu">
        <Nodes>
            <telerik:NavigationNode Text="New" SpriteCssClass="icon icon-Add-Circle" />
            <telerik:NavigationNode Text="Export">
                <Nodes>
                    <telerik:NavigationNode Text="Export to Word" />
                    <telerik:NavigationNode Text="Export to CSV" />
                    <telerik:NavigationNode Text="Export to Excel" />
                    <telerik:NavigationNode Text="Export to PDF" />
                </Nodes>
            </telerik:NavigationNode>
            <telerik:NavigationNode CssClass="rightScndNav">
                <NodeTemplate>
                    <span class="button listViewBtn selected">
                        <span class="icon icon icon-View-ListView"></span>
                    </span>
                    <telerik:RadSearchBox ID="RadSearchBox1" runat="server" Skin="BlackMetroTouch" Width="340px" CssClass="hidden">
                    </telerik:RadSearchBox>
                    <span class="button searchBtn">
                        <span class="icon icon-Search"></span>
                    </span>
                </NodeTemplate>
            </telerik:NavigationNode>
        </Nodes>
    </telerik:RadNavigation>
    <div class="scroller">
        <!-- Page Content -->
    </div>
</asp:Content>

