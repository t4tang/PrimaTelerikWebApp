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


 <telerik:RadPanelBar RenderMode="Lightweight" runat="server" CssClass="RadMenu" ID="RadPanelBar1" AutoPostBack="false"
    Height="550px" Width="240px" ExpandMode="FullExpandedItem" Font-Names="Calibri" Font-Size="Medium" OnItemClick="RadPanelBar1_ItemClick">
</telerik:RadPanelBar>