<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h05fc.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.FluidControl.Fuel.inv01h05fc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
    
    <script type="text/javascript" src="../../../../Script/Script.js"></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("inv01h05fcReportViewer.aspx?do_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("inv01h05fcEditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("inv01h05fcEditForm.aspx?do_code=" + id, "EditDialogWindows");
                return false;
            }

            function openWinFiterTemplate() {
                var filterDialog = $find("<%=FilterDialogWindows.ClientID%>");
                filterDialog.show();
            }

            Sys.Application.add_load(function () {
            $windowContentDemo.contentTemplateID = "<%=FilterDialogWindows.ClientID%>";
            $windowContentDemo.templateWindowID = "<%=FilterDialogWindows.ClientID %>";
            });

            function refreshGrid(arg) {
                if (!arg) {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("Rebind");
                }
                else {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("RebindAndNavigate");
                }

            }
        </script>
    </telerik:RadCodeBlock>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel22" runat="server">
        <ContentTemplate>
            <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
            <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
        </ContentTemplate>        
    </asp:UpdatePanel> 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" ></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lblProject"></telerik:AjaxUpdatedControl>  
                    <telerik:AjaxUpdatedControl ControlID="lblWarehouse"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lblSumQtyDay"></telerik:AjaxUpdatedControl>  
                    <telerik:AjaxUpdatedControl ControlID="lblSumQtyNight"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lblTotQtyPeriod"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
        
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="700" BackgroundPosition="None" BackColor="Transparent" >
        <img alt="Loading..." src="../../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 115px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="700" BackgroundPosition="None" >
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="2000"></telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="450px" Height="350px" VisibleStatusbar="False" AutoSize="True">
        <ContentTemplate>
            <div runat="server" style="padding: 20px 10px 10px 10px;" id="Div2">
                <table>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Date From :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                        <td >
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight" AutoPostBack="true"
                                    EnableLoadOnDemand="True"  Skin="Telerik" OnItemsRequested="cb_project_prm_ItemsRequested"
                                    OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%">
                                </telerik:RadComboBox>                                    
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <telerik:RadLabel runat="server" Text="Storage :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="300" DropDownWidth="300px"
                                AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"
                                OnItemsRequested="cb_warehouse_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged" Font-Size="Small"
                                OnPreRender="cb_warehouse_PreRender">
                            </telerik:RadComboBox> 
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="95%" Height="25px"
                             Skin="Material" ForeColor="DeepSkyBlue"></telerik:RadButton>
                        </td>

                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>                  
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClientClick="ShowInsertForm(); return false;" ToolTip="Add New"
                        Height="26px" Width="27px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="29px" Width="30px" ImageUrl="~/Images/search.png"></asp:ImageButton>
                </td>
                <td style="width: 97%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue;">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>    

    <div  class="scroller" runat="server" style="overflow-y:scroll; height:620px">
        <div runat="server" style="width:100%; overflow-y:hidden; min-height:280px; scrollbar-highlight-color:#b6ff00;border-bottom-style:solid; 
            border-bottom-color:gainsboro; border-bottom-width:thin;">
                <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" PageSize="12" ShowFooter="false" Skin="Silk"
                    AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" MasterTableView-GridLines="None" CssClass="RadGrid_ModernBrowsers"
                    OnNeedDataSource="RadGrid1_NeedDataSource" 
                    OnDeleteCommand="RadGrid1_DeleteCommand" 
                    OnItemCreated="RadGrid1_ItemCreated" 
                    OnItemDataBound="RadGrid1_ItemDataBound">
                    <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                    <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px"/>
                    <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                    <SortingSettings EnableSkinSortStyles="false" />
                    <MasterTableView CommandItemDisplay="Top" DataKeyNames="do_code" Font-Size="11px"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowRefreshButton="False" 
                    CommandItemSettings-ShowAddNewRecordButton="False">
                    <SortExpressions >
                        <telerik:GridSortExpression FieldName="do_code" SortOrder="Ascending" />
                    </SortExpressions>                
                    <Columns>
                        <telerik:GridClientSelectColumn UniqueName="SelectColumn" ></telerik:GridClientSelectColumn> 
                        <telerik:GridBoundColumn UniqueName="do_code" HeaderText="GI Number" DataField="do_code" ItemStyle-Width="100px" FilterControlWidth="90px" 
                            ItemStyle-HorizontalAlign="Left" >
                            <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="Tgl" HeaderText="GI. Date" DataField="Tgl" ItemStyle-Width="80px"
                            EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker"
                            DataFormatString="{0:d}">
                            <HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <%-- <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project" DataField="region_code" ItemStyle-Width="60px" FilterControlWidth="50px" 
                            ItemStyle-HorizontalAlign="Left" >
                            <HeaderStyle Width="80px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                       <telerik:GridBoundColumn UniqueName="wh_name" HeaderText="Storage" DataField="wh_name" ItemStyle-Width="160px" FilterControlWidth="150px" 
                            ItemStyle-HorizontalAlign="Left" >
                            <HeaderStyle Width="180px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="unit_time" HeaderText="Unit Time" DataField="unit_time" ItemStyle-Width="60px" FilterControlWidth="50px" 
                            ItemStyle-HorizontalAlign="Right" >
                            <HeaderStyle Width="80px" HorizontalAlign="Right"></HeaderStyle>
                        </telerik:GridBoundColumn>     --%> 
                        <telerik:GridBoundColumn UniqueName="shift_code" HeaderText="Shift" DataField="shift_code" ItemStyle-Width="60px" FilterControlWidth="50px" 
                            ItemStyle-HorizontalAlign="Left" >
                            <HeaderStyle Width="80px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>          
                        <telerik:GridBoundColumn UniqueName="unit_code" HeaderText="Unit" DataField="unit_code" ItemStyle-Width="60px" FilterControlWidth="50px" 
                            ItemStyle-HorizontalAlign="Left" >
                            <HeaderStyle Width="80px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>                
                        <telerik:GridBoundColumn UniqueName="model_no" HeaderText="Model" DataField="model_no" ItemStyle-Width="60px" FilterControlWidth="50px" 
                            ItemStyle-HorizontalAlign="Left" >
                            <HeaderStyle Width="80px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>                                
                        <telerik:GridBoundColumn UniqueName="unit_reading" HeaderText="HM/KM" DataField="unit_reading" ItemStyle-Width="60px" FilterControlWidth="60px" 
                             DataFormatString="{0:#,###,##0.00}" DataType="System.Decimal">
                            <HeaderStyle Width="80px" HorizontalAlign="Right"></HeaderStyle>
                            <ItemStyle CssClass="gridNumItem"/>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="unit_reading_b" HeaderText="Last HM/KM" DataField="unit_reading_b" ItemStyle-Width="90px" FilterControlWidth="80px" 
                             DataFormatString="{0:#,###,##0.00}" DataType="System.Decimal">
                            <HeaderStyle Width="110px" HorizontalAlign="Right"></HeaderStyle>
                            <ItemStyle CssClass="gridNumItem" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="hm_tot" HeaderText="Wh" DataField="hm_tot" ItemStyle-Width="60px" FilterControlWidth="60px" 
                             DataFormatString="{0:#,###,##0.00}" DataType="System.Decimal">
                            <HeaderStyle Width="80px" HorizontalAlign="Right"></HeaderStyle>
                            <ItemStyle CssClass="gridNumItem" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="Qty_out" HeaderText="Qty" DataField="Qty_out" ItemStyle-Width="60px" FilterControlWidth="60px" 
                             DataFormatString="{0:#,###,##0.00}" DataType="System.Decimal">
                            <HeaderStyle Width="80px" HorizontalAlign="Right"></HeaderStyle>
                            <ItemStyle CssClass="gridNumItem" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="liter_km" HeaderText="Liter/HM(KM)" DataField="liter_km" ItemStyle-Width="60px" FilterControlWidth="60px" 
                             DataFormatString="{0:#,###,##0.00}" DataType="System.Decimal">
                            <HeaderStyle Width="80px" HorizontalAlign="Right"></HeaderStyle>
                            <ItemStyle CssClass="gridNumItem" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="unit_position" HeaderText="Unit Position" DataField="unit_position" ItemStyle-Width="100px" FilterControlWidth="90px" 
                            ItemStyle-HorizontalAlign="Center" >
                            <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                       <%-- <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true" ItemStyle-Width="140px" FilterControlWidth="140px">
                            <HeaderStyle Width="170px" ForeColor="Highlight" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" AllowFiltering="False">
                        <ItemTemplate>                                
                            <asp:ImageButton ID="EditLink" runat="server" Height="22px" Width="25px" ImageUrl="~/Images/edit.png" ToolTip="Edit" />
                        </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Right"
                                AllowFiltering="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" 
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px" HeaderStyle-Width="50px"
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">                                
                            <ItemStyle ForeColor="Red" />
                        </telerik:GridButtonColumn>  
                                              
                    </Columns>
                    </MasterTableView>
                    <ClientSettings>                         
                        <%--<Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="273px" />--%>
                        <Selecting AllowRowSelect="true"></Selecting>    
                    </ClientSettings>
                </telerik:RadGrid>        
        </div>
        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data tersimpan" Position="BottomRight"
            AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
        </telerik:RadNotification>
                
        <div runat="server" style="width: 100%; border-top-width: 1px; border-top-style: inset; padding-top: 10px;">
            <table>
                <tr>
                    <td>
                        <telerik:RadLabel runat="server" Text="Project:" CssClass="lbObject" ></telerik:RadLabel>                        
                    </td>
                     <td>
                        :
                    </td>
                     <td>
                        <telerik:RadLabel runat="server" ID="lblProject" CssClass="lbObject" ></telerik:RadLabel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadLabel runat="server" Text="Storage:" CssClass="lbObject"></telerik:RadLabel>                         
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <telerik:RadLabel runat="server" ID="lblWarehouse" CssClass="lbObject"></telerik:RadLabel>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <telerik:RadLabel runat="server" ID="lblSumQtyDay" CssClass="lbSummary" Width="300px" ForeColor="#ff3300" ></telerik:RadLabel>
                    </td>
                    <td colspan="3">
                        <telerik:RadLabel runat="server" ID="lblSumQtyNight" CssClass="lbSummary" Width="300px" ForeColor="#ff3300"></telerik:RadLabel>
                    </td>
                    <td colspan="3">
                        <telerik:RadLabel runat="server" ID="lblTotQtyPeriod" CssClass="lbSummary"  Width="300px" ForeColor="#ff3300"></telerik:RadLabel>
                    </td>
                </tr>
            </table>
        </div>

       <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1150px" Height="670px" Modal="true" AutoSize="True">
                </telerik:RadWindow>
                <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1100px" Height="720px" Modal="true" AutoSize="False">
                </telerik:RadWindow>
                
            </Windows>
        </telerik:RadWindowManager>
        
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
        
    </div>
</asp:Content>
