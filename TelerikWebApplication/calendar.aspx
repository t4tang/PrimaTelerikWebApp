<%@ Page Title="Calendar" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="calendar.aspx.cs" Inherits="TelerikWebApplication.Calendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Styles/calendar.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="Server">
    <telerik:RadCalendar runat="server" ID="RadCalendar1" Skin="Metro" EnableMultiSelect="false" DayNameFormat="FirstTwoLetters" 
        SelectedDate="09/01/2015"  ShowRowHeaders="false" Width="220px"></telerik:RadCalendar>
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <telerik:RadNavigation runat="server" ID="calendarNavigation" Skin="BlackMetroTouch" CssClass="secondaryMenu">
        <Nodes>
            <telerik:NavigationNode Text="New" SpriteCssClass="icon icon-Add-Circle">
            </telerik:NavigationNode>
            <telerik:NavigationNode Text="Export">
                <Nodes>
                    <telerik:NavigationNode Text="Export to PDF"></telerik:NavigationNode>
                    <telerik:NavigationNode Text="Export to iCalendar"></telerik:NavigationNode>
                    <telerik:NavigationNode Text="Export to Image"></telerik:NavigationNode>
                </Nodes>
            </telerik:NavigationNode>
            <telerik:NavigationNode Text="Import"></telerik:NavigationNode>
            <telerik:NavigationNode CssClass="rightScndNav">
                <NodeTemplate>
                    <telerik:RadSearchBox runat="server" Skin="BlackMetroTouch" Width="340px" ID="mainSearch" CssClass="hidden" ShowLoadingIcon="false">
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