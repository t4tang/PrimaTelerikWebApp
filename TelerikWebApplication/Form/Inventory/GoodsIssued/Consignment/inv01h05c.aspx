<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h05c.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.GoodsIssued.Consignment.inv01h05c" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("reportViewer_inv01h05c.aspx?do_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("inv01h05cEditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("inv01h05cEditForm.aspx?do_code=" + id, "EditDialogWindows");
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
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
            <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
        </ContentTemplate>        
    </asp:UpdatePanel> 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 170px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" MinDisplayTime="500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="500" BackgroundPosition="Center"></telerik:RadAjaxLoadingPanel>

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
                                    EnableLoadOnDemand="True"  Skin="Telerik" 
                                    OnItemsRequested="cb_Project_prm_ItemsRequested"
                                    OnSelectedIndexChanged="cb_Project_prm_SelectedIndexChanged"
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%">
                                </telerik:RadComboBox>                                    
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <%--<tr>
                        <td colspan="2">
                            <telerik:RadLabel runat="server" Text="Storage :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="300" DropDownWidth="300px"
                                AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"
                                OnItemsRequested="cb_loc_ItemsRequested" OnSelectedIndexChanged="cb_loc_SelectedIndexChanged" Font-Size="Small"
                            OnPreRender="cb_loc_PreRender">
                            </telerik:RadComboBox> 
                        </td>
                    </tr>--%>
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

    <div style="padding-left: 15px; ">
        <table id="tbl_control">
            <tr>                  
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClientClick="ShowInsertForm(); return false;" ToolTip="Add New"
                        Height="25px" Width="27px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="20px" Width="23px" ImageUrl="~/Images/filter.png"></asp:ImageButton>
                </td>
                <td style="width: 96%; text-align: right; padding-right:17px">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#7cca05; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>    
    
    <div  class="scroller" runat="server" style="overflow-y:scroll; height:620px">
        <div runat="server" style="height:465px;">
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" PageSize="10" ShowFooter="false" Skin="Telerik"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" MasterTableView-GridLines="None"
                OnNeedDataSource="RadGrid1_NeedDataSource" 
                OnDeleteCommand="RadGrid1_DeleteCommand" 
                OnItemCreated="RadGrid1_ItemCreated" 
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged">
                <PagerStyle Mode="NextPrevAndNumeric" VerticalAlign="NotSet" PageSizeControlType="RadComboBox"></PagerStyle>                
                <HeaderStyle CssClass="gridHeader" />
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
                <SortingSettings EnableSkinSortStyles="false" />
                <ClientSettings EnablePostBackOnRowClick="true" >
                </ClientSettings>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="do_code" Font-Size="11px"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false">
                <Columns> 
                    <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="25px" >
                        <HeaderStyle Width="25px"></HeaderStyle>
                    </telerik:GridClientSelectColumn>  
                    <telerik:GridBoundColumn UniqueName="do_code" HeaderText="GI Number" DataField="do_code" 
                        FilterControlWidth="90px" >
                        <HeaderStyle Width="120px" />
                        <ItemStyle Width="125px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn UniqueName="Tgl" HeaderText="Date" DataField="Tgl" 
                            EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker" 
                        DataFormatString="{0:d}" >
                        <HeaderStyle Width="135px" />
                        <ItemStyle Width="135px" />
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn UniqueName="ref_code" HeaderText="Reference" DataField="ref_code"
                        FilterControlWidth="100px" >
                        <HeaderStyle Width="135px" />
                        <ItemStyle Width="135px" />
                    </telerik:GridBoundColumn>                       
                    <telerik:GridBoundColumn UniqueName="supp_code" HeaderText="Supplier" DataField="supplier_name" 
                        FilterControlWidth="190px" >
                        <HeaderStyle Width="220px" />
                        <ItemStyle Width="220px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" 
                        FilterControlWidth="170px" >
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <%--<telerik:GridBoundColumn UniqueName="type_do" HeaderText="From" DataField="do_type" 
                        FilterControlWidth="90px" >
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                            FilterControlWidth="240px">
                        <HeaderStyle Width="280px" />
                        <ItemStyle Width="280px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="30px" ItemStyle-Width="30px" AllowFiltering="False">
                        <ItemTemplate>                                
                            <asp:ImageButton ID="EditLink" runat="server" Height="22px" Width="25px" ImageUrl="~/Images/edit.png" ToolTip="Edit" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="30px" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center"
                            AllowFiltering="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" ItemStyle-ForeColor="Red" ItemStyle-HorizontalAlign="Center"
                        ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                        <HeaderStyle Width="30px" />
                        <ItemStyle Width="30px" />
                    </telerik:GridButtonColumn>
                </Columns>
                </MasterTableView>
                <ClientSettings>
                    <Selecting AllowRowSelect="true"></Selecting>
                    <ClientEvents OnRowDblClick="RowDblClick" />
                    <%--<Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="290" />--%>
                </ClientSettings>
            </telerik:RadGrid>
        </div>

        <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 20px;">               
             <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
                AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" 
                 OnNeedDataSource="RadGrid2_NeedDataSource" 
                 OnDeleteCommand="RadGrid2_DeleteCommand" ShowStatusBar="true" >
                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                <MasterTableView CommandItemDisplay="None" DataKeyNames="prod_code" Font-Size="11px" EditMode="InPlace"
                 ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item">
                <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" /> 
                     <Columns>
                         <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                            HeaderText="Edit" HeaderStyle-Width="30px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                        </telerik:GridEditCommandColumn>
                        <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_ProdCode" Text='<%# DataBinder.Eval(Container.DataItem, "prod_code") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Info Record" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblProdCodeOri" Text='<%# DataBinder.Eval(Container.DataItem, "info_code") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                                    
                        <telerik:GridTemplateColumn HeaderText="Superior" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblSuperior" ></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                                    
                        <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                            HeaderStyle-HorizontalAlign="Center" DefaultInsertValue="0"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_Part_Qty" Text='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_Part_Qty" Width="85px" EnabledStyle-HorizontalAlign="Right"
                                    NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                    onkeydown="blurTextBox(this, event)"
                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                    NumberFormat-DecimalDigits="2">
                                </telerik:RadTextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Uom" HeaderStyle-Width="80px" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" 
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "unit_code") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                                    
                        <telerik:GridTemplateColumn HeaderText="Cost Center" HeaderStyle-Width="120px" ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" 
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblCostCntr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                                    
                       
                        <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="300px" ItemStyle-Width="300px" HeaderStyle-HorizontalAlign="Center" 
                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblremark" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>                                 
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox runat="server" ID="txtRemark" Width="350px" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></telerik:RadTextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                            ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-ForeColor="Red">
                        </telerik:GridButtonColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>                   
             <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Text="Data tersimpan" Position="BottomRight"
                AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
            </telerik:RadNotification>    
        </div>  
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1150px" Height="670px" Modal="true" AutoSize="True">
                </telerik:RadWindow>
                <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1400px" Height="720px" Modal="true" AutoSize="False">
                </telerik:RadWindow>
                
            </Windows>
        </telerik:RadWindowManager>
        
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
       
    </div>
</asp:Content>


