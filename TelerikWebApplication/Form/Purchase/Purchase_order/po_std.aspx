<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="po_std.aspx.cs" Inherits="TelerikWebApplication.Forms.Purchase.Purchase_order.po_std" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="Server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">       
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function RowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
 
            function onPopUpShowing(sender, args) {
                args.get_popUp().className += " popUpEditForm";
            }
        </script>
    </telerik:RadCodeBlock>

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

    <telerik:RadFormDecorator RenderMode="Native" ID="RadFormDecorator1" runat="server" DecorationZoneID="demo" DecoratedControls="All" 
        EnableRoundedCorners="false" Visible="false" />

    <div class="scroller">
        <!-- Page Content -->
             <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="true"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" OnPreRender="RadGrid1_PreRender"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnUpdateCommand="RadGrid1_SaveCommand" AllowFilteringByColumn="false"
                OnInsertCommand="RadGrid1_SaveCommand" OnDeleteCommand="RadGrid1_DeleteCommand" BorderStyle="Solid" Font-Names="Calibri"
                 CssClass="RadGrid_ModernBrowsers">
                 <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                    <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="po_code" Font-Size="12px"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true">
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="po_code" HeaderText="PO Number" DataField="po_code">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="Po_date" HeaderText=" Date" DataField="Po_date"
                            DataFormatString="{0:d}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="vendor_name" HeaderText="Vendor Name" DataField="vendor_name">
                            <HeaderStyle Width="250px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark">
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete">
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings UserControlName="po_std_data_entry.ascx" EditFormType="WebUserControl">
                        <EditColumn UniqueName="EditCommandColumn1">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
                <ClientSettings>
                    <ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />
                </ClientSettings>
        </telerik:RadGrid>

    </div>
</asp:Content>