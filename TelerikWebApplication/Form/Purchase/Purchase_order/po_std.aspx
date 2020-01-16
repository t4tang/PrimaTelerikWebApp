<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="po_std.aspx.cs" Inherits="TelerikWebApplication.Forms.Purchase.Purchase_order.po_std" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />

    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <style type="text/css">
            .orderText {
                font: normal 12px Arial,Verdana;
                margin-top: 6px;
            }
        </style>
    </telerik:RadCodeBlock>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="Server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="false" />       
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <%--<script type="text/javascript">
            function RowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
                
            }
 
            function onPopUpShowing(sender, args) {
                args.get_popUp().className += " popUpEditForm";
            }
        </script>--%>
        <script type="text/javascript">
            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("edit_form.aspx?po_code=" + id, "UserListDialog");
                return false;
            }
            function ShowInsertForm() {
                window.radopen("edit_form.aspx", "UserListDialog");
                return false;
            }
            function refreshGrid(arg) {
                if (!arg) {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("Rebind");
                }
                else {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("RebindAndNavigate");
                }
            }
            function RowDblClick(sender, eventArgs) {
                window.radopen("edit_form.aspx?EmployeeID=" + eventArgs.getDataKeyValue("EmployeeID"), "UserListDialog");
            }
        </script>
        
    </telerik:RadCodeBlock>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_project_prm">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <%--<telerik:RadFormDecorator RenderMode="Native" ID="RadFormDecorator1" runat="server" DecorationZoneID="demo" DecoratedControls="All" 
        EnableRoundedCorners="false" Visible="false" />--%>
    <%--<div class="pageLayout">--%>
    <div class="scroller">
            <!-- Page Content -->
            <div runat="server" style="padding:10px 10px 10px 10px;" id="searchParam">                
                <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="Date From " Height="26px"></telerik:RadDatePicker>                
                <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="To Date " Height="26px"></telerik:RadDatePicker>
                <telerik:RadComboBox ID="cb_project_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="Project" AutoPostBack="true"
                  EnableLoadOnDemand="True" Skin="Office2010Silver"  OnItemsRequested="cb_project_ItemsRequested" EnableVirtualScrolling="true" 
                    Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"
                  OnSelectedIndexChanged="cb_project_SelectedIndexChanged"></telerik:RadComboBox>
                <%--<telerik:RadButton ID="btnRetrieve" runat="server" RenderMode="Lightweight" Text="Search" Width="90px"
                 ButtonType="LinkButton" CssClass="css3Shadows" Height="28px" OnClick="btnRetrieve_Click"></telerik:RadButton>--%>
            </div>
                 <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="true"
                    AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" OnItemCreated="RadGrid1_ItemCreated"
                    OnNeedDataSource="RadGrid1_NeedDataSource" OnPreRender="RadGrid1_PreRender" 
                     OnUpdateCommand="RadGrid1_SaveCommand" OnInsertCommand="RadGrid1_SaveCommand" 
                     OnDeleteCommand="RadGrid1_DeleteCommand" 
                     BorderStyle="Solid" Font-Names="Calibri" AllowFilteringByColumn="true"
                     CssClass="RadGrid_ModernBrowsers" Skin="Metro">
                    <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                    <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="po_code" Font-Size="12px"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true">
                        <Columns>
                            <%--<telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                            </telerik:GridEditCommandColumn>--%>
                            <telerik:GridBoundColumn UniqueName="po_code" HeaderText="PO Number" DataField="po_code">
                                <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridDateTimeColumn UniqueName="Po_date" HeaderText="Date" DataField="Po_date" 
                                 EnableRangeFiltering="true" FilterControlWidth="110px" PickerType="DatePicker" 
                                DataFormatString="{0:d}" >
                            </telerik:GridDateTimeColumn>
                            <telerik:GridBoundColumn UniqueName="vendor_name" HeaderText="Vendor Name" DataField="vendor_name">
                                <HeaderStyle Width="250px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark">
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete">
                            </telerik:GridButtonColumn>
                            <telerik:GridTemplateColumn UniqueName="TemplateEditColumn">
                                <ItemTemplate>
                                    <asp:HyperLink ID="EditLink" runat="server" Text="Edit"></asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                       <%-- <EditFormSettings UserControlName="po_std_data_entry.ascx" EditFormType="WebUserControl">
                            <EditColumn UniqueName="EditCommandColumn">
                            </EditColumn>
                        </EditFormSettings>--%>

                        <CommandItemTemplate>
                            <a href="#" onclick="return ShowInsertForm();">Add New Record</a>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <ClientSettings>
                        <%--<ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />--%>
                        <Selecting AllowRowSelect="true"></Selecting>
                        <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    </ClientSettings>
            </telerik:RadGrid>
            <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
                <Windows>
                    <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Title="Editing record" Height="380px"
                        Width="393px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false"
                        Modal="true">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
        <%--</div>--%>    
    </div>
</asp:Content>