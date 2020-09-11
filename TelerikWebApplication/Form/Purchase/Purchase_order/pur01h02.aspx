<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="pur01h02.aspx.cs" Inherits="TelerikWebApplication.Forms.Purchase.Purchase_order.pur01h02" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                window.radopen("pur01h02ReportViewer.aspx?po_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("pur01h02EditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("pur01h02EditForm.aspx?po_code=" + id, "EditDialogWindows");
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
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
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
                    <%--<telerik:AjaxUpdatedControl ControlID="RadGrid1" ></telerik:AjaxUpdatedControl>  --%>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2" ></telerik:AjaxUpdatedControl>  
                </UpdatedControls>        
            </telerik:AjaxSetting> 
        </AjaxSettings>
    </telerik:RadAjaxManager>
        
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 170px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
   <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
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
                            <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight"
                               EnableLoadOnDemand="True"  Skin="Telerik" OnItemsRequested="cb_project_prm_ItemsRequested"
                                OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px">

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
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClientClick="ShowInsertForm(); return false;" ToolTip="Add New"
                        Height="30px" Width="32px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 13px">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="28px" Width="28px" ImageUrl="~/Images/filter1.png"></asp:ImageButton>
                </td>
                <td style="width: 94%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>   

    <div class="scroller" runat="server">        
        <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik"
            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="7"
            OnNeedDataSource="RadGrid1_NeedDataSource" 
            OnPreRender="RadGrid1_PreRender" 
            OnDeleteCommand="RadGrid1_DeleteCommand"
            OnItemCreated="RadGrid1_ItemCreated"
            OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged">
                <PagerStyle Mode="Slider" VerticalAlign="NotSet" PageSizeControlType="RadComboBox"></PagerStyle>                
                <HeaderStyle CssClass="gridHeader" />
                <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                <SortingSettings EnableSkinSortStyles="false" />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="po_code" Font-Size="12px" 
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                     CommandItemSettings-ShowRefreshButton="false" >
                    <Columns>
                        <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="40px" HeaderStyle-Width="40px"></telerik:GridClientSelectColumn>
                        <telerik:GridBoundColumn UniqueName="po_code" HeaderText="PO Number" DataField="po_code" ItemStyle-Width="70px" FilterControlWidth="70px">
                            <HeaderStyle Width="70px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="Po_date" HeaderText="Date" DataField="Po_date" ItemStyle-Width="60px" 
                                EnableRangeFiltering="false" FilterControlWidth="90px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="refNo" HeaderText="Reff. Number" DataField="refNo" ItemStyle-Width="70px" FilterControlWidth="70px">
                            <HeaderStyle Width="70px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="vendor_name" HeaderText="Vendor Name" DataField="vendor_name" 
                            FilterControlWidth="220px" >
                            <HeaderStyle Width="220px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="project" HeaderText="Project" DataField="plantCode" ItemStyle-Width="40px" FilterControlWidth="40px">
                            <HeaderStyle Width="40px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="tax1" HeaderText="Tax 1" DataField="tax1" ItemStyle-Width="70px" FilterControlWidth="70px">
                            <HeaderStyle Width="70px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="tax2" HeaderText="Tax 2" DataField="tax2" ItemStyle-Width="70px" FilterControlWidth="70px">
                            <HeaderStyle Width="70px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="tax3" HeaderText="Tax 3" DataField="tax3" ItemStyle-Width="70px" FilterControlWidth="70px">
                            <HeaderStyle Width="70px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="amount" HeaderText="Amount" DataField="tot_amount" ItemStyle-Width="90px" FilterControlWidth="90px" 
                            ItemStyle-HorizontalAlign="Right" Visible="False"
                            DataFormatString="{0:#,##0.00}" DataType="System.Double">
                            <HeaderStyle Width="90px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn> 
                        <telerik:GridBoundColumn UniqueName="net" HeaderText="Net" DataField="Net" ItemStyle-Width="80px" FilterControlWidth="80px" ItemStyle-HorizontalAlign="Right" 
                            DataFormatString="{0:#,##0.00}" DataType="System.Double">
                            <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>   
                        <%--<telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                                ItemStyle-Width="240px" FilterControlWidth="170px">
                            <HeaderStyle Width="240px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Center" 
                            AllowFiltering="False">
                        <ItemTemplate>                                
                            <asp:ImageButton ID="EditLink" runat="server" Height="22px" Width="25px" ImageUrl="~/Images/edit.png" ToolTip="Edit" />
                        </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Center"
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
                    <Selecting AllowRowSelect="true"></Selecting>
                    <ClientEvents OnRowDblClick="RowDblClick" />
                </ClientSettings>
            </telerik:RadGrid>

        <div runat="server" style="width: 100%; border-top-width: 1px; border-top-style: inset; padding-top: 5px;">   
            <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" runat="server" PageSize="5" AllowPaging="true" Font-Names="Calibri" 
                    AllowAutomaticUpdates="True" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" ShowFooter="false" 
                    AutoGenerateColumns="False" Skin="Telerik" 
                    OnNeedDataSource="RadGrid2_NeedDataSource"
                    OnUpdateCommand="RadGrid2_UpdateCommand"
                    OnDeleteCommand="RadGrid2_DeleteCommand">   
                    <MasterTableView CommandItemDisplay="Top" DataKeyNames="Prod_code" Font-Size="11px" EditMode="InPlace"
                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item">
                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="false" />                                                 
                        <Columns>
                            <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                HeaderText="Edit" HeaderStyle-Width="30px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Left" UpdateText="Update" HeaderStyle-HorizontalAlign="Left">
                            </telerik:GridEditCommandColumn>
                            <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Left"  ItemStyle-Width="40px" 
                                HeaderStyle-ForeColor="#009900">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "prod_type")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label runat="server" ID="lblProdType" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>   
                            <telerik:GridTemplateColumn UniqueName="prod_code" HeaderText="Prod. Code" HeaderStyle-Width="150px" HeaderStyle-ForeColor="#009900"
                                    SortExpression="prod_code" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Left">
                                    <FooterTemplate>Template footer</FooterTemplate>
                                    <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "Prod_code")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="spec"
                                            OnItemsRequested="cb_prod_code_ItemsRequested" DataValueField="prod_code" AutoPostBack="true" Font-Size="12px"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.Prod_code") %>' EmptyMessage="- Search product name here -"
                                            HighlightTemplatedItems="true" Height="190px" Width="150px" DropDownWidth="430px"
                                            OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" OnPreRender="cb_prod_code_PreRender">                                                   
                                            <HeaderTemplate>
                                            <table style="width: 430px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 250px;">
                                                        Prod. Name
                                                    </td>     
                                                    <td style="width: 180px;">
                                                        Prod. Code
                                                    </td>                                                           
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 430px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 250px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                    </td>        
                                                    <td style="width: 180px;">
                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                    </td>                                                        
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <%-- <telerik:GridTemplateColumn HeaderText="Part Name" ItemStyle-Width="160px" HeaderStyle-Width="160px" ItemStyle-HorizontalAlign="Left" HeaderStyle-ForeColor="#009900">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "spec")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_prod_name" Width="160px" ReadOnly="true"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.spec") %>'>
                                    </telerik:RadTextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>  --%>                                  
                            <telerik:GridTemplateColumn HeaderText="Qty" ItemStyle-Width="80px" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0" 
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
                            <telerik:GridTemplateColumn HeaderText="UoM" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "SatQty")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>'></asp:Label>
                                </EditItemTemplate>
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
                            <telerik:GridTemplateColumn HeaderText="Factor" ItemStyle-Width="60px" HeaderStyle-Width="60px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0"
                                HeaderStyle-ForeColor="#009900" >
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "factor", "{0:#,###,###0.00}")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_factor" Width="60px" NumberFormat-AllowRounding="true"
                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right"
                                        Text='<%# DataBinder.Eval(Container.DataItem, "factor", "{0:#,###,###0.00}") %>'
                                        onkeydown="blurTextBox(this, event)"
                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2" >
                                    </telerik:RadTextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Sub Price" ItemStyle-Width="90px" HeaderStyle-Width="90px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0"
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900" >
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "jumlah", "{0:#,###,###0.00}")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label runat="server" ID="lblsub_price" Text='<%# DataBinder.Eval(Container.DataItem, "jumlah", "{0:#,###,###0.00}") %>'>
                                    </asp:Label>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Tax 1" HeaderStyle-Width="50px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" 
                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chkTax1" Enabled="false" Checked='<%# DataBinder.Eval(Container.DataItem, "tTax") %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox runat="server" ID="edt_chkTax1" OnCheckedChanged="edt_chkTax1_CheckedChanged" OnPreRender="edt_chkTax1_PreRender"
                                        Checked='<%# DataBinder.Eval(Container.DataItem, "tTax") %>' />
                                </EditItemTemplate>                                        
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Tax 2" HeaderStyle-Width="50px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chkOTax" Enabled="false" Checked='<%# DataBinder.Eval(Container.DataItem, "tOTax") %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox runat="server" ID="edt_chkOTax" OnCheckedChanged="edt_chkOTax_CheckedChanged" OnPreRender="edt_chkOTax_PreRender"
                                        Checked='<%# DataBinder.Eval(Container.DataItem, "tOTax") %>' />
                                </EditItemTemplate>                                        
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Tax 3" HeaderStyle-Width="50px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chkTpph" Enabled="false" Checked='<%# DataBinder.Eval(Container.DataItem, "tpph") %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox runat="server" ID="edt_chkTpph" OnCheckedChanged="edt_chkTpph_CheckedChanged" OnPreRender="edt_chkTpph_PreRender"
                                        Checked='<%# DataBinder.Eval(Container.DataItem, "tpph") %>' />
                                </EditItemTemplate>                                        
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="dept_code" HeaderText="Cost Ctr" HeaderStyle-Width="75px" ItemStyle-Width="75px" SortExpression="dept_code" UniqueName="dept_code"
                                ItemStyle-HorizontalAlign="Left" HeaderStyle-ForeColor="#009900" >
                                <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "dept_code")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>                                                
                                        <asp:Label runat="server" ID="lbl_cost_ctr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'>
                                        </asp:Label>
                                    </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Prod_code_ori" HeaderText="Ori. Prod" HeaderStyle-Width="100px" ItemStyle-Width="100px" SortExpression="Prod_code_ori" UniqueName="Prod_code_ori"
                            ItemStyle-HorizontalAlign="left" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "Prod_code_ori")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label runat="server" ID="lbl_Prod_code_ori" Text='<%# DataBinder.Eval(Container, "DataItem.Prod_code_ori") %>'>
                                    </asp:Label>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete this product?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                            </telerik:GridButtonColumn>
                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                    <ClientSettings AllowKeyboardNavigation="true"></ClientSettings>
                    <ItemStyle HorizontalAlign="Right" />
                    <FilterMenu RenderMode="Lightweight">
                    </FilterMenu>
                    <HeaderContextMenu RenderMode="Lightweight">
                    </HeaderContextMenu>
                </telerik:RadGrid>  
                
                <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data tersimpan" Position="BottomRight"
                    AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
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