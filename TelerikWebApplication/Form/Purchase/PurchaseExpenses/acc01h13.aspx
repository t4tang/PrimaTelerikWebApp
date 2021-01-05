<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h13.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.PurchaseExpenses.acc01h13" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    
    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("reportViewer.aspx?po_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("acc01h13EditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("acc01h13EditForm.aspx?po_code=" + id, "EditDialogWindows");
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
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="Server">
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
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" ></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" ></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2" ></telerik:AjaxUpdatedControl>  
                </UpdatedControls>        
            </telerik:AjaxSetting> 
        </AjaxSettings>
    </telerik:RadAjaxManager>

   <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 170px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
   <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
   </telerik:RadAjaxLoadingPanel>
   <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="2000" BackgroundPosition="Center"></telerik:RadAjaxLoadingPanel>

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
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight" EnableVirtualScrolling="true" Filter="Contains" 
                               MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px" EnableLoadOnDemand="True"  Skin="Telerik" 
                               OnItemsRequested="cb_proj_prm_ItemsRequested"
                               OnSelectedIndexChanged="cb_proj_prm_SelectedIndexChanged" >
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td>
                            <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="120px" Height="25px" 
                                BackColor="#FF6600" ForeColor="White" BorderStyle="None"  />
                        </td>

                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

   <div style="padding-left: 15px;">
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
                <td style="width: 97%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#7cca05; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>    

   <div class="scroller" runat="server">

        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" ShowFooter="false" Skin="Material"
        AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="10" MasterTableView-GridLines="None" 
        OnNeedDataSource="RadGrid1_NeedDataSource" 
        OnDeleteCommand="RadGrid1_DeleteCommand"
        OnItemCreated="RadGrid1_ItemCreated"
        OnPreRender="RadGrid1_PreRender"
        OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" >
        <PagerStyle Mode="NumericPages" ForeColor="#0099CC"></PagerStyle>               
        <HeaderStyle Font-Size="Small" BackColor="WhiteSmoke" ForeColor="#666666" BorderColor="OrangeRed" BorderStyle="Inset" />
        <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
        <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
        <SortingSettings EnableSkinSortStyles="false" />
        <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="NoBuk" Font-Size="11px"
            EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowRefreshButton="False" 
            CommandItemSettings-ShowAddNewRecordButton="False">
            <SortExpressions >
                <telerik:GridSortExpression FieldName="NoBuk" SortOrder="Ascending" />
            </SortExpressions>
            <Columns>
                <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="40px" HeaderStyle-Width="40px"></telerik:GridClientSelectColumn>
                <telerik:GridBoundColumn UniqueName="NoBuk" HeaderText="Reg. No" DataField="NoBuk" ItemStyle-Width="150px" FilterControlWidth="110px" 
                    ItemStyle-HorizontalAlign="Left" >
                    <HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridDateTimeColumn UniqueName="Tgl" HeaderText="Date" DataField="Tgl" ItemStyle-Width="150px"
                    EnableRangeFiltering="false" FilterControlWidth="125px" PickerType="DatePicker"
                    DataFormatString="{0:d}">
                    <HeaderStyle Width="160px"  HorizontalAlign="Center"></HeaderStyle>
                    
                </telerik:GridDateTimeColumn>
                <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project" DataField="region_code" ItemStyle-Width="85px" 
                FilterControlWidth="45px">
                <HeaderStyle Width="80px"  HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="NoFP" HeaderText="Inv. Number" DataField="NoFP" ItemStyle-Width="150px" FilterControlWidth="120px">
                    <HeaderStyle Width="150px"  HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridDateTimeColumn UniqueName="TglFP" HeaderText="Inv. Date" DataField="TglFP" ItemStyle-Width="160px"
                    EnableRangeFiltering="false" FilterControlWidth="125px" PickerType="DatePicker"
                    DataFormatString="{0:d}">
                    <HeaderStyle Width="160px"  HorizontalAlign="Center"></HeaderStyle>                    
                </telerik:GridDateTimeColumn>   
                <telerik:GridBoundColumn UniqueName="InvCode" HeaderText="Tax Inv. Code" DataField="InvCode" ItemStyle-Width="155px" FilterControlWidth="120px" >
                    <HeaderStyle Width="155px"  HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>    
                <telerik:GridBoundColumn UniqueName="NoPO" HeaderText="Ctrl. No" DataField="NoPO" ItemStyle-Width="155px" FilterControlWidth="120px" >
                    <HeaderStyle Width="155px"  HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn> 
                <telerik:GridBoundColumn UniqueName="NamSup" HeaderText="Supplier" DataField="NamSup" ItemStyle-Wrap="true" ItemStyle-Width="250px" FilterControlWidth="230px">
                    <HeaderStyle Width="265px"  HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="Jumlah" HeaderText="Sub Total" DataField="Jumlah" ItemStyle-Width="100px" FilterControlWidth="80px" 
                    ItemStyle-HorizontalAlign="Right" 
                    DataFormatString="{0:#,##0.00}" DataType="System.Double">
                    <HeaderStyle Width="120px" HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="DP" HeaderText="DP" DataField="DP" ItemStyle-Width="100px" FilterControlWidth="80px" ItemStyle-HorizontalAlign="Right" 
                    DataFormatString="{0:#,##0.00}" DataType="System.Double">
                    <HeaderStyle Width="120px" HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="JPPN" HeaderText="Tax 1" DataField="JPPN" ItemStyle-Width="100px" FilterControlWidth="60px" ItemStyle-HorizontalAlign="Right" 
                    DataFormatString="{0:#,##0.00}" DataType="System.Double">
                    <HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn> 
                <telerik:GridBoundColumn UniqueName="JOTax" HeaderText="Tax 2" DataField="JOTax" ItemStyle-Width="100px" FilterControlWidth="60px" ItemStyle-HorizontalAlign="Right" 
                    DataFormatString="{0:#,##0.00}" DataType="System.Double">
                    <HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn> 
                <telerik:GridBoundColumn UniqueName="Jpph" HeaderText="Tax 3" DataField="Jpph" ItemStyle-Width="100px" FilterControlWidth="60px" ItemStyle-HorizontalAlign="Right" 
                    DataFormatString="{0:#,##0.00}" DataType="System.Double">
                    <HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="Net" HeaderText="Total" DataField="Net" ItemStyle-Width="100px" FilterControlWidth="80px" ItemStyle-HorizontalAlign="Right" 
                    DataFormatString="{0:#,##0.00}" DataType="System.Double">
                    <HeaderStyle Width="120px" HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>                    
                <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"  
                    ItemStyle-Width="350px" FilterControlWidth="320px">
                    <HeaderStyle Width="350px"  HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>
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
                    ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="25px"
                    ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton" ItemStyle-ForeColor="#66CCFF">
                </telerik:GridButtonColumn>
            </Columns>

            </MasterTableView>
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="260px" />
                <Selecting AllowRowSelect="true"></Selecting>                    
            </ClientSettings>
            </telerik:RadGrid>
            
        <div runat="server" style="width: 100%; border-top-color:yellowgreen; border-top-width: 1px; border-top-style: inset; padding-top: 8px;height:250px; overflow-y:auto; overflow-x:hidden">   
            <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" Skin="Telerik" PageSize="5"
                AllowPaging="true" AllowSorting="true" runat="server" ShowStatusBar="true"  ClientSettings-Selecting-AllowRowSelect="true"
                OnNeedDataSource="RadGrid2_NeedDataSource"
                OnUpdateCommand="RadGrid2_UpdateCommand"
                OnDeleteCommand="RadGrid2_DeleteCommand" >
                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                <MasterTableView CommandItemDisplay="Top" DataKeyNames="Nobuk, nomor" Font-Size="11px" EditMode="InPlace"
                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >
                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="False" ShowCancelChangesButton="false" />
                    <Columns>
                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                            HeaderText="Edit" HeaderStyle-Width="60px" ItemStyle-Width="65px" UpdateText="Update" 
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        </telerik:GridEditCommandColumn>
                        <telerik:GridTemplateColumn ItemStyle-Width="0px" HeaderStyle-Width="0px" Visible="false"
                             HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblNomor" Text='<%# DataBinder.Eval(Container.DataItem, "nomor") %>' Width="0px"></asp:Label>                                           
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>  
                        <telerik:GridTemplateColumn HeaderText="Code" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center" 
                             HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblCodeBiaya" Text='<%# DataBinder.Eval(Container.DataItem, "code_biaya") %>'></asp:Label>                                           
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>   
                        <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="280px" ItemStyle-Width="280px"
                             HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblRemark" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="280px"
                                    Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                </telerik:RadTextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Amount" HeaderStyle-Width="120px" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right" 
                             HeaderStyle-ForeColor="#009900" DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <telerik:RadLabel RenderMode="Lightweight" runat="server" ID="txtSubPrice" Width="120px"  ReadOnly="false" 
                                    EnabledStyle-HorizontalAlign="Right" BorderStyle="None"
                                    NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "sub_price", "{0:#,###,###0.00}") %>'
                                    onkeydown="blurTextBox(this, event)"
                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                    NumberFormat-DecimalDigits="2">
                                </telerik:RadLabel>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtSubPrice" Width="120px"  ReadOnly="false" 
                                    EnabledStyle-HorizontalAlign="Right" BorderStyle="None"
                                    NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "sub_price", "{0:#,###,###0.00}") %>'
                                    onkeydown="blurTextBox(this, event)"
                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                    NumberFormat-DecimalDigits="2">
                                </telerik:RadTextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Tax 1" HeaderStyle-Width="40px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                             HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:CheckBox ID="chk_tax1" runat="server" Font-Size="10px" ForeColor="#003399" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn> 
                        <telerik:GridTemplateColumn HeaderText="Tax 2" HeaderStyle-Width="40px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                             HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:CheckBox ID="chk_tax2" runat="server" Font-Size="10px" ForeColor="#003399" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn> 
                        <telerik:GridTemplateColumn HeaderText="Tax 3" HeaderStyle-Width="40px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                             HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:CheckBox ID="chk_tax3" runat="server" Font-Size="10px" ForeColor="#003399" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Net" HeaderStyle-Width="120px" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right" 
                             HeaderStyle-ForeColor="#009900" DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <telerik:RadLabel RenderMode="Lightweight" runat="server" ID="lblTotal" Width="120px"  ReadOnly="true" 
                                    EnabledStyle-HorizontalAlign="Right" BorderStyle="None"
                                    NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "pay_tot", "{0:#,###,###0.00}") %>'
                                    onkeydown="blurTextBox(this, event)"
                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                    NumberFormat-DecimalDigits="2">
                                </telerik:RadLabel>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cost Center" HeaderStyle-Width="80px" ItemStyle-Width="80px" 
                             HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblCostCtr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                       
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                             HeaderStyle-ForeColor="#009900" ConfirmTitle="Delete" ConfirmDialogType="RadWindow"
                            ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                        </telerik:GridButtonColumn>

                    </Columns>
                </MasterTableView>
                <ClientSettings>
                    <%--<Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="180px" />--%>
                    <Selecting AllowRowSelect="true"></Selecting>  
                </ClientSettings>
            </telerik:RadGrid>

                <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data tersimpan" Position="BottomRight"
                    AutoCloseDelay="5000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
                </telerik:RadNotification>
            </ContentTemplate>
        </asp:UpdatePanel>    
        </div>

        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1150px" Height="670px" Modal="true" AutoSize="True">
                </telerik:RadWindow>
                <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1500px" Height="720px" Modal="true" AutoSize="False">
                </telerik:RadWindow>
                
            </Windows>
        </telerik:RadWindowManager>
        
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
        
    </div>
</asp:Content>
