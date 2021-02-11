<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h06.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.InfoRecord.inv01h06" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript">
                function rowDblClick(sender, eventArgs) {
                    sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
                }

                function ShowPreview(id) {
                    window.radopen("inv01h06ReportViewer.aspx?info_code=" + id, "PreviewDialog");
                    return false;
                }
                function RowDblClick(sender, eventArgs) {
                    Row = eventArgs.get_itemIndexHierarchical();
                }
                function callBackFn(arg) {
                    //alert("this is the client-side callback function. The RadAlert returned: " + arg);
                }
                function ShowInsertForm() {                
                    window.radopen("inv01h06EditForm.aspx", "EditDialogWindows");
                    return false;
                }

                function ShowEditForm(id, rowIndex) {
                    var grid = $find("<%= RadGrid1.ClientID %>");
 
                    var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                    grid.get_masterTableView().selectItem(rowControl, true);
 
                    window.radopen("inv01h06EditForm.aspx?info_code=" + id, "EditDialogWindows");
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
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
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
                            <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight"
                               EnableLoadOnDemand="True"  Skin="Telerik" 
                                OnItemsRequested="cb_proj_prm_ItemsRequested"
                                OnSelectedIndexChanged="cb_proj_prm_SelectedIndexChanged"
                                EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="95%" Height="25px"
                             Skin="Material"></telerik:RadButton>
                        </td>

                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:orangered; border-bottom-width:thin ">
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
                <td style="width: 97%; text-align: right; padding-right:17px"">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#7cca05; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>  

    <div class="scroller" runat="server" style="overflow-y:scroll; height:620px">
        <div runat="server" style="height:465px;">
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="10" MasterTableView-GridLines="None" 
                OnNeedDataSource="RadGrid1_NeedDataSource"
                OnDeleteCommand="RadGrid1_DeleteCommand"
                OnItemCreated="RadGrid1_ItemCreated"
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged"
                OnPreRender="RadGrid1_PreRender">
                
                <PagerStyle Mode="NextPrevAndNumeric" VerticalAlign="NotSet" PageSizeControlType="RadComboBox"></PagerStyle>                
                <HeaderStyle CssClass="gridHeader" />
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
                <SortingSettings EnableSkinSortStyles="false" />
                <ClientSettings EnablePostBackOnRowClick="true" />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="" Font-Size="11px"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false">
                <Columns>
                     <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="20px" ></telerik:GridClientSelectColumn> 
                    <telerik:GridBoundColumn UniqueName="info_code" HeaderText="Info Number" DataField="info_code" ItemStyle-Width="100px" FilterControlWidth="90px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="supplier_name" HeaderText="Suplier" DataField="supplier_name" ItemStyle-Width="150px" FilterControlWidth="150px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="type_infoname" HeaderText="Type" DataField="type_infoname" ItemStyle-Width="150px" FilterControlWidth="150px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="cur_code" HeaderText="Curr" DataField="cur_code" ItemStyle-Width="50px" FilterControlWidth="50px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="50px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true" ItemStyle-Width="300px" FilterControlWidth="300px">
                        <HeaderStyle Width="300px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="25px" ItemStyle-Width="20px" AllowFiltering="False" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>                                
                        <asp:ImageButton ID="EditLink" runat="server" Height="22px" Width="20px" ImageUrl="~/Images/edit.png" ToolTip="Edit" />
                    </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center"
                            AllowFiltering="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" 
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="20px" HeaderStyle-Width="20px"
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

        <div runat="server" style="width: 100%; border-top-width: 1px; border-top-style: inset; padding-top: 5px;">  
            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
            AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" 
            
            OnNeedDataSource="RadGrid2_NeedDataSource"
            OnDeleteCommand="RadGrid2_DeleteCommand"
            OnInsertCommand="RadGrid2_InsertCommand" 
           >
            <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
            <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
            <MasterTableView CommandItemDisplay="None" DataKeyNames="" Font-Size="11px" EditMode="InPlace"
                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item">
            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                                        
            <Columns>
                 <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                    HeaderText="Edit" HeaderStyle-Width="30px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                </telerik:GridEditCommandColumn>
                 <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="120px" ItemStyle-Width="120px"
                        HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblProdCode" Text='<%# DataBinder.Eval(Container.DataItem, "Prod_code") %>'></asp:Label>
                        <telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip1" runat="server" TargetControlID="lblProdCode" RelativeTo="Element"
                        Position="BottomCenter" RenderInPageRoot="true" HideDelay="300" ShowEvent="OnMouseOver">
                        <%# DataBinder.Eval(Container, "DataItem.Spec")%>                                                
                        </telerik:RadToolTip>
                    </ItemTemplate>                                        
                </telerik:GridTemplateColumn>
                                        
               <telerik:GridTemplateColumn HeaderText="Qty Std" ItemStyle-Width="80px" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0" 
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "qty", "{0:#,###,###0.00}")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty" Width="80px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="true"
                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "qty", "{0:#,###,###0.00}") %>'
                                            onkeydown="blurTextBox(this, event)"
                                            AutoPostBack="true" MaxLength="11" Type="Number"    
                                            NumberFormat-DecimalDigits="2" >
                                        </telerik:RadNumericTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn> 
                <telerik:GridTemplateColumn HeaderText="Qty Min" ItemStyle-Width="80px" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0" 
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "min_qty", "{0:#,###,###0.00}")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty_min" Width="80px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="true"
                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "min_qty", "{0:#,###,###0.00}") %>'
                                            onkeydown="blurTextBox(this, event)"
                                            AutoPostBack="true" MaxLength="11" Type="Number"    
                                            NumberFormat-DecimalDigits="2" >
                                        </telerik:RadNumericTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn> 
               <telerik:GridTemplateColumn HeaderText="Qty Max" ItemStyle-Width="80px" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0" 
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "max_qty", "{0:#,###,###0.00}")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty_max" Width="80px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="true"
                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "max_qty", "{0:#,###,###0.00}") %>'
                                            onkeydown="blurTextBox(this, event)"
                                            AutoPostBack="true" MaxLength="11" Type="Number"    
                                            NumberFormat-DecimalDigits="2" >
                                        </telerik:RadNumericTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn> 
                 <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center"
                        HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>'></asp:Label>
                    </ItemTemplate>                                        
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="harga" HeaderText="Harga" HeaderStyle-Width="120px" ItemStyle-Width="120px"  SortExpression="harga" UniqueName="harga"
                                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblHarga" Text='<%# Eval("harga", "{0:#,###0.00;-#,###0.00;0}") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <span>                                                
                                        <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_harga" Width="120px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right"
                                            Text='<%# DataBinder.Eval(Container.DataItem, "harga", "{0:#,###,###0.00}") %>'
                                            onkeydown="blurTextBox(this, event)"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2" >
                                        </telerik:RadTextBox>
                                        <span style="color: Red">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                                ControlToValidate="txt_harga" ErrorMessage="*Required" runat="server" Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </span>
                                    </span>
                                </EditItemTemplate>
                                <HeaderStyle Width="55px" />
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>
                 <telerik:GridTemplateColumn HeaderText="Disc. %" ItemStyle-Width="70px" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0"
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "Disc", "{0:#,###,###0.00}")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_disc" Width="70px" NumberFormat-AllowRounding="true"
                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right"
                                        Text='<%# DataBinder.Eval(Container.DataItem, "Disc", "{0:#,###,###0.00}") %>'
                                        onkeydown="blurTextBox(this, event)"
                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2" >
                                    </telerik:RadTextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn> 
                 <telerik:GridTemplateColumn HeaderText="Valid Date" HeaderStyle-Width="110px"  ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>  
                                                <asp:Label runat="server" ID="lblValidDate" Text='<%# DataBinder.Eval(Container, "DataItem.ValidDate", "{0:dd-MM-yyyy}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadDatePicker runat="server" ID="dtpDelivDate" Width="110px"
                                                    DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.ValidDate") %>' 
                                                    onkeydown="blurTextBox(this, event)" Type="Date">
                                                    <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                                </telerik:RadDatePicker>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn> 
                 <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="250px" ItemStyle-Width="250px"
                        HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblRemark_d" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="250px"
                            Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                        </telerik:RadTextBox>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>

            </Columns>
            </MasterTableView>
            <ClientSettings >
                <Selecting AllowRowSelect="true"></Selecting>                          
            </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>

    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                Width="1150px" Height="670px" Modal="true" AutoSize="True">
            </telerik:RadWindow>
            <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                Width="1300px" Height="720px" Modal="true" AutoSize="False">
            </telerik:RadWindow>
                
        </Windows>
    </telerik:RadWindowManager>

    <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data berhasil dihapus" Position="Center" Skin="Windows7"
        AutoCloseDelay="7000" Width="350" Height="110" Title="Congrotulation" EnableRoundedCorners="true">
    </telerik:RadNotification>
        
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
    </telerik:RadWindowManager>
</asp:Content>
