<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h02.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Cash.CashMutation.acc01h02" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl"/>
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
    
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ConfiguratorPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="scroller">
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" ShowFooter="true" 
            AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" 
            MasterTableView-CommandItemDisplay="Top" MasterTableView-AllowFilteringByColumn="true"
            OnNeedDataSource="RadGrid1_NeedDataSource" OnItemCreated="RadGrid1_ItemCreated" OnDeleteCommand="RadGrid1_DeleteCommand" 
             OnUpdateCommand="RadGrid1_UpdateCommand" OnInsertCommand="RadGrid1_InsertCommand" 
            >
            <MasterTableView Font-Size="13px" Font-Names="Calibri">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Reg. No" DataField="prod_code">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Date" DataField="spec">
                        <HeaderStyle Width="580px" />
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Ctrl No" DataField="prod_code">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Specification" DataField="spec">
                        <HeaderStyle Width="580px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Material Code" DataField="prod_code">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Specification" DataField="spec">
                        <HeaderStyle Width="580px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Material Code" DataField="prod_code">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Specification" DataField="spec">
                        <HeaderStyle Width="580px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Material Code" DataField="prod_code">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Specification" DataField="spec">
                        <HeaderStyle Width="580px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Material Code" DataField="prod_code">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
</asp:Content>
