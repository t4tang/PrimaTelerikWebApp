<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FolderNavigationControl.ascx.cs" Inherits="TelerikWebApplication.Controls.FolderNavigationControl" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%--<telerik:RadTreeView runat="server" Skin="MetroTouch" ID="rtvFolders" EnableDragAndDrop="true" EnableDragAndDropBetweenNodes="true" ShowLineImages="false">
    <ContextMenus>
        <telerik:RadTreeViewContextMenu>
            <Items>
                <telerik:RadMenuItem Text="Add New Folder"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Rename"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Delete"></telerik:RadMenuItem>
            </Items>
        </telerik:RadTreeViewContextMenu>
       
    </ContextMenus>
</telerik:RadTreeView>

<div id="newFolderContainer">
    <telerik:RadTextBox runat="server" ID="rtbFolder" />
</div>
<div class="btn-new-node">Add New</div>--%>

<telerik:RadLabel ID="lbl_modul_name" runat="server" style="font-weight: bold; font-variant: small-caps; padding-left:10px; 
padding-bottom:13px; font-size:x-large; color:yellowgreen"></telerik:RadLabel>

<telerik:RadPanelBar RenderMode="Lightweight" runat="server" ID="RadPanelBar1" AutoPostBack="false" BackColor="White" BorderWidth="0" ForeColor="Teal"
Height="100%" Width="237px" ExpandMode="SingleExpandedItem" Font-Names="Calibri" Font-Size="14px" OnItemClick="RadPanelBar1_ItemClick" 
    Skin="Telerik" CollapseDelay="30" CollapseAnimation-Type="InBounce">
</telerik:RadPanelBar>


<%--<telerik:RadMenu RenderMode="Lightweight" runat="server" ID="RadMenu1" DataFieldID="menu_id" Height="550px"
    DataFieldParentID="Parent_menu_id" DataTextField="menu_description" DataNavigateUrlField="menu_url" 
    Style="z-index: 5" EnableRoundedCorners="true" Flow="Vertical" EnableShadows="true" EnableTextHTMLEncoding="true">
</telerik:RadMenu>--%>

<%--<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DbConString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="sp_get_user_menu_by_modul" SelectCommandType="StoredProcedure">
    
</asp:SqlDataSource>--%>