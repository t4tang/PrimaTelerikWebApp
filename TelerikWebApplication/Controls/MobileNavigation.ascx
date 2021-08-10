<%@ Control Language="C#" AutoEventWireup="true"  CodeBehind="MobileNavigation.ascx.cs" Inherits="TelerikWebApplication.Controls.MobileNavigation" %> %>
<div class="breadcrumb">
    <div class="item menu">
        <telerik:RadMenu runat="server" ID="popupMenu" RenderMode="Mobile" />
        <asp:Label runat="server" ID="navText" CssClass="label" Text="Inbox (0)"></asp:Label>
    </div>
</div>