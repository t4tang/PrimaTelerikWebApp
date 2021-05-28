<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h03.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Bank.BankPayment.acc01h03" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />

    <script src="../../../../Script/Script.js"></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
            function ShowPreview(id) {
                window.radopen("ReportVieweracc01h03.aspx?slip_no=" + id, "PreviewDialog");
                return false;
            }
            function ShowJournal(id) {
                window.radopen("acc01h03journal.aspx?slip_no=" + id, "PreviewDialog");
                return false;
            }

            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }

            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                //window.radopen("inv01h01EditForm.aspx?doc_code=" + id, "EditDialogWindows");
                //return false;
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

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow)
                    oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog     
                else if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow;//IE (and Moz as well)     
                return oWindow;
            }

            function Close() {
                GetRadWindow().Close();
            }

            function onPopUpShowing(sender, args) {
                args.get_popUp().className += " popUpEditForm";
            }
        </script>
        <%--<style type="text/css">
            .tdLabel{
                vertical-align:middle; 
                text-align:left;
                width:auto;
                padding-right:10px;
                font-weight:lighter;
                font-family:'Century Gothic';
                font-style:normal;
                color:#555;}

            .trxInfo{
                border-style:none;
                font-style:italic; 
                color:darkgrey
            }
        </style>--%>
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
            <%-- <telerik:AjaxSetting AjaxControlID="cb_project_detail">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_project_detail" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>--%>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_supplier">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_currency" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_kurs" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_bank">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_curr2" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_kurs2" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 170px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="2000" BackgroundPosition="Center"></telerik:RadAjaxLoadingPanel>
    
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone" VisibleOnPageLoad="false"
        Modal="false" Width="450px" Height="350px" VisibleStatusbar="False" AutoSize="True" Skin="Silk" BackColor="Transparent">
        <%--LIST DATA--%>
        <ContentTemplate>
            <div runat="server" style="padding:20px 10px 10px 10px;" id="Div2">
                <table>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Date From :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik" DateInput-CausesValidation="false"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                        <td>
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"  DateInput-CausesValidation="false"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy"></telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <telerik:RadLabel runat="server" Text="Bank :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                    <telerik:RadComboBox ID="cb_bank_prm" runat="server" RenderMode="Lightweight" AutoPostBack="true"
                                        EnableLoadOnDemand="true" Skin="Telerik"  OnItemsRequested="cb_bank_prm_ItemsRequested" EnableVirtualScrolling="true" 
                                        Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" DropDownWidth="350px" Width="100%"
                                        OnSelectedIndexChanged="cb_bank_prm_SelectedIndexChanged"></telerik:RadComboBox>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="height:50px">
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="95%" Height="25px" 
                                Skin="Material" ForeColor="DeepSkyBlue">
                            </telerik:RadButton>
                        </td>
                    </tr>
                </table>                
                                
                
                <%--&nbsp
                &nbsp
                <asp:Button ID="btnFind" runat="server" Text="Search" OnClick="btnFind_Click" />
                 &nbsp
                <asp:Button ID="btnOk" runat="server" Text="Select & Close" OnClick="btnOk_Click"/>--%>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>
                <td style="vertical-align: bottom; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click" ToolTip="Add New" Visible="true"
                        Height="26px" Width="27px" ImageUrl="~/Images/tambah.png" ImageAlign="Bottom" ></asp:ImageButton>
                </td>                
                <td style="vertical-align: bottom; margin-left: 0px; padding: 0px 0px 0px 0px;">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter" 
                        Height="29px" Width="30px" ImageUrl="~/Images/search.png"></asp:ImageButton>
                </td>
                <td style="width: 96%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight:normal; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#0099dc;">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

    <div class="scroller" runat="server" style="overflow-y:scroll; height:620px;">
        <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="True" ShowFooter="false" PageSize="14" Skin="Silk"
            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true"
            OnNeedDataSource="RadGrid1_NeedDataSource" 
            OnDeleteCommand="RadGrid1_DeleteCommand" CssClass="RadGrid_ModernBrowsers" 
            OnItemCreated="RadGrid1_ItemCreated" 
            OnItemCommand="RadGrid1_ItemCommand" 
            OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" 
            OnPreRender="RadGrid1_PreRender">
            <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
            <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true"></ClientSettings>
            <HeaderStyle ForeColor="Highlight" Font-Size="11px" />
            <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="slip_no" Font-Size="12px" ShowHeadersWhenNoRecords="true"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false" CellPadding="-1">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="40px"/>
                        <ItemStyle Width="40px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn UniqueName="slip_no" HeaderText="Reg. No" DataField="slip_no" FilterControlWidth="90px">
                        <HeaderStyle Width="80px" HorizontalAlign="Center" ></HeaderStyle>
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                            <%--<telerik:GridBoundColumn UniqueName="cashbank" HeaderText="Bank Code" DataField="cashbank" FilterControlWidth="50px">
                            <HeaderStyle Width="50px"></HeaderStyle>
                            </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn UniqueName="noctrl" HeaderText="Ctrl. No" DataField="noctrl" FilterControlWidth="70px">
                        <HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn UniqueName="slip_date" HeaderText="Date" DataField="slip_date" FilterControlWidth="80px" 
                        EnableRangeFiltering="false" PickerType="DatePicker" 
                        DataFormatString="{0:d}">
                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridDateTimeColumn>       
                    <telerik:GridBoundColumn UniqueName="cust_code" HeaderText="Supplier" DataField="cust_code" FilterControlWidth="80px" Visible="true" >
                        <HeaderStyle Width="0px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn> 
                    <telerik:GridBoundColumn UniqueName="supplier_name" HeaderText="Supplier" DataField="supplier_name" FilterControlWidth="210px">
                        <HeaderStyle Width="200px" HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>                     
                    <telerik:GridBoundColumn UniqueName="kurs" HeaderText="Kurs" DataField="kurs" FilterControlWidth="80px" DataFormatString='{0:#,###0.000000000}'>
                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="tot_pay" HeaderText="Tot. Amount" DataField="tot_pay" FilterControlWidth="80px" DataFormatString='{0:#,###,###0.00}'
                        ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#009933">
                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="cur_code" HeaderText="Curr" DataField="cur_code" FilterControlWidth="50px" ItemStyle-HorizontalAlign="Center">
                        <HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="Remark" HeaderText="Remark" DataField="Remark" FilterControlWidth="300px">
                        <HeaderStyle Width="200px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <%--<telerik:GridTemplateColumn UniqueName="TemplateJournalColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Right"
                        AllowFiltering="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="JournalLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/journal.png" ToolTip="Journal" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>--%>
                    <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Right"
                        AllowFiltering="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete"  ConfirmText="Are You Sure ?" ConfirmTitle="Delete" 
                        ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                    </telerik:GridButtonColumn>     
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <div style="padding: 15px 0px 0px 25px;">
                            <table id="Table1" border="0" style="border-collapse: collapse; padding:15px 0px 5px 0px; font-size:11px;">
                                <tr style="vertical-align: top;">
                                    <td style="vertical-align: top;">
                                        <table id="Table2" width="Auto" border="0" class="module">
                                            <tr>
                                                <td colspan="2" style="padding: 0px 0px 10px 0px; text-align:left">
                                                    <asp:Button ID="btnUpdate" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" 
                                                        OnClick="btnUpdate_Click" Height="25px" 
                                                        Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" 
                                                        CssClass="btn-entryFrm" >
                                                    </asp:Button>&nbsp;
                            
                                                    <asp:Button ID="btnCancel" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" 
                                                        Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                                        runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Reg No:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>       
                                                <td>
                                                    <telerik:RadTextBox ID="txt_slip_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.slip_no") %>'> 
                                                    </telerik:RadTextBox>
                                                    &nbsp;
                                                    <asp:CheckBox ID="chk_posting" runat="server" Checked="false" Enabled="false" Text="Posting" />
                                                </td>                                           
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Supplier:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td style="vertical-align:top; text-align:left">                      
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="300px" DropDownWidth="300px" Enabled="true" 
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Supplier -" EnableLoadOnDemand="True" Skin="Telerik" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.supplier_name") %>'  
                                                        OnItemsRequested="cb_supplier_ItemsRequested" OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged" 
                                                        OnPreRender="cb_supplier_PreRender">
                                                    </telerik:RadComboBox>                     
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Currency :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_currency" runat="server" Width="80px" ReadOnly="true" RenderMode="Lightweight"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.cur_code") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Kurs :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>    
                                                    <%--<telerik:RadNumericTextBox ID="txt_kurs" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik" 
                                                        DbValue='<%# DataBinder.Eval(Container, "DataItem.kurs" , "{0:0,#########}") %>' >
                                                    </telerik:RadNumericTextBox>--%>
                                                    <telerik:RadNumericTextBox ID="txt_kurs" runat="server" Width="111px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  DbValue='<%# DataBinder.Eval(Container, "DataItem.kurs" ) %>' NumberFormat-DecimalDigits="9" NumberFormat-DecimalSeparator=".">
                                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Reference :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ref" runat="server" Width="300px"
                                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Metro" Enabled="false"                                
                                                        EnableVirtualScrolling="true" >
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Bank :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_bank" runat="server" Width="300px" DropDownWidth="300px"
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Bank -" EnableLoadOnDemand="True" Skin="Telerik" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.NamBank") %>'  
                                                        OnItemsRequested="cb_bank_ItemsRequested" OnSelectedIndexChanged="cb_bank_SelectedIndexChanged" OnPreRender="cb_bank_PreRender">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Currency :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_curr2" runat="server" Width="60px" ReadOnly="true" RenderMode="Lightweight"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.cur_code_acc") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Kurs :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadNumericTextBox ID="txt_kurs2" runat="server" Width="111px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik" 
                                                        DbValue='<%# DataBinder.Eval(Container, "DataItem.kurs_acc" ) %>' NumberFormat-DecimalDigits="9" NumberFormat-DecimalSeparator="." >
                                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Doc Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtp_created"  runat="server" MinDate="1/1/1900" Width="110px" RenderMode="Lightweight"
                                                        TabIndex="4" Skin="Telerik" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.slip_date") %>'>  
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro">
                                                        </Calendar>
                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                            <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>                                                    
                                                        </DateInput>                         
                                                    </telerik:RadDatePicker>
                                                    &nbsp
                                                    <telerik:RadLabel runat="server" Text="Ctrl No :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    <telerik:RadTextBox ID="txt_ctrl" runat="server" Width="130px" RenderMode="Lightweight"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.noctrl") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Cashed Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtp_cashed" runat="server" MinDate="1/1/1900" Width="110px" RenderMode="Lightweight"
                                                        TabIndex="4" Skin="Telerik" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.tgl_cair") %>'>
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro">
                                                        </Calendar>
                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                            <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="vertical-align: top; padding-left:15px">
                                        <table>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Giro No :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_giro" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight"
                                                        AutoPostBack="false" >
                                                    </telerik:RadTextBox>
                                                </td>                                           
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Prepared by :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel> 
                                                </td>
                                                <td >                      
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_pre" runat="server" Width="300" DropDownWidth="300px"
                                                        AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" EnableLoadOnDemand="True" Skin="Telerik" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.RequestBy") %>'
                                                        OnItemsRequested="cb_pre_ItemsRequested" OnSelectedIndexChanged="cb_pre_SelectedIndexChanged" OnPreRender="cb_pre_PreRender">
                                                        <HeaderTemplate>
                                                            <table style="width: 370px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 150px;">
                                                                        Name
                                                                    </td>
                                                                    <td style="width: 300px;">
                                                                        Position
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 350px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 150px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                    </td>
                                                                    <td style="width: 200px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            A total of
                                                            <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                            items
                                                        </FooterTemplate> 
                                                    </telerik:RadComboBox> 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Checked by :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_check" runat="server" Width="300" DropDownWidth="300px"
                                                        AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" EnableLoadOnDemand="True" Skin="Telerik" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Checkby") %>'  
                                                        OnItemsRequested="cb_check_ItemsRequested" OnSelectedIndexChanged="cb_check_SelectedIndexChanged" OnPreRender="cb_check_PreRender">
                                                        <HeaderTemplate>
                                                            <table style="width: 370px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 150px;">
                                                                        Name
                                                                    </td>
                                                                    <td style="width: 300px;">
                                                                        Position
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 350px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 150px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                    </td>
                                                                    <td style="width: 200px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            A total of
                                                            <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                            items
                                                        </FooterTemplate> 
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Approve by :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approve" runat="server" Width="300" DropDownWidth="300px"
                                                        AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" EnableLoadOnDemand="True" Skin="Telerik" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Approveby") %>'  
                                                        OnItemsRequested="cb_approve_ItemsRequested" OnSelectedIndexChanged="cb_approve_SelectedIndexChanged" OnPreRender="cb_approve_PreRender">
                                                        <HeaderTemplate>
                                                            <table style="width: 370px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 150px;">
                                                                        Name
                                                                    </td>
                                                                    <td style="width: 300px;">
                                                                        Position
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 350px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 150px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                    </td>
                                                                    <td style="width: 200px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            A total of
                                                            <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                            items
                                                        </FooterTemplate> 
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Remark :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>                                                
                                                    <telerik:RadTextBox ID="txt_remark" runat="server" Width="300px" Enabled="true" RenderMode="Lightweight"
                                                        AutoPostBack="false" TextMode="MultiLine" Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table class="trxInfo">
                                                        <tr>
                                                            <td>
                                                                <telerik:RadLabel runat="server" Text="User :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>                                                
                                                            </td>
                                                            <td>
                                                                <telerik:RadTextBox ID="txt_user" runat="server" Width="50px" RenderMode="Lightweight" BorderStyle="None" 
                                                                    AutoPostBack="false" ReadOnly="true" Text='<%# DataBinder.Eval(Container, "DataItem.userid") %>'>
                                                                </telerik:RadTextBox>
                                                                &nbsp;&nbsp;&nbsp;
                                                                <telerik:RadLabel runat="server" Text="Last Update :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>   
                                                                <telerik:RadTextBox ID="txt_lastupdate" runat="server" Width="160px" RenderMode="Lightweight" BorderStyle="None"
                                                                    AutoPostBack="false" ReadOnly="true" Text='<%# DataBinder.Eval(Container, "DataItem.lastupdate") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="tdLabel">
                                                                Total Amount :
                                                            </td>
                                                            <td>
                                                                <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_amount" Width="130px"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "tot_pay", "{0:#,###,###0.00}") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                        </tr> 
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                     <td colspan="4" style="vertical-align:middle; text-align:right; padding-right:20px" ></td>
                                </tr>
                            </table>
                            <div style="padding: 7px 0px 12px 0px; height:288px">
                                <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="97%" 
                                    SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Silk" CausesValidation="false">
                                    <Tabs>
                                        <telerik:RadTab Text="Detail" Height="15px"></telerik:RadTab>
                                        <telerik:RadTab Text="Journal" Height="15px"></telerik:RadTab>
                                    </Tabs>
                                </telerik:RadTabStrip>
                                <telerik:RadMultiPage runat="server" ID="RadMultiPage1"  SelectedIndex="0" Width="97%">
                                    <telerik:RadPageView runat="server" ID="RadPageView1" Height="300px">
                                        <div runat="server" style="padding:10px 10px 10px 10px">
                                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" runat="server" AllowPaging="False" ShowFooter="false" PageSize="5" Skin="Silk"
                                                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers"  
                                                OnNeedDataSource="RadGrid2_NeedDataSource" 
                                                OnInsertCommand="RadGrid2_InsertCommand"
                                                OnUpdateCommand="RadGrid2_UpdateCommand"
                                                OnDeleteCommand="RadGrid2_DeleteCommand" 
                                                OnItemCommand="RadGrid2_ItemCommand"
                                                OnPreRender="RadGrid2_PreRender"
                                                ClientSettings-Selecting-AllowRowSelect="true">
                                                <HeaderStyle Font-Size="12px" />
                                                <PagerStyle Mode="NumericPages" /> 
                                                <MasterTableView CommandItemDisplay="Top" Font-Size="12px" EditMode="InPlace"
                                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" DataKeyNames="slip_no,inv_code">
                                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                                                    <Columns>
                                                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                                            HeaderText="Edit" HeaderStyle-Width="80px" UpdateText="Update" ItemStyle-Width="80px">
                                                        </telerik:GridEditCommandColumn>
                                                  
                                                        <telerik:GridTemplateColumn UniqueName="inv_code" HeaderText="Reg. Number" HeaderStyle-Width="120px"
                                                            DataField="inv_code" SortExpression="inv_code" ItemStyle-Width="120px">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lbl_NoBuk" Text='<%#DataBinder.Eval(Container.DataItem, "inv_code")%>' Width="120px"></asp:Label> 
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_NoBuk" EnableLoadOnDemand="True" DataTextField="NoFP"
                                                                    DataValueField="NoBuk" AutoPostBack="true" HighlightTemplatedItems="true" Height="120px" Width="120px" DropDownWidth="380px"
                                                                    EmptyMessage="- Search invoice here -" Text='<%#DataBinder.Eval(Container.DataItem, "inv_code")%>'
                                                                    OnItemsRequested="cb_NoBuk_ItemsRequested" OnSelectedIndexChanged="cb_NoBuk_SelectedIndexChanged" OnPreRender="cb_NoBuk_PreRender" >                                                   
                                                                    <HeaderTemplate>
                                                                        <table style="width: 380px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 100px;">
                                                                                    Reg. Number
                                                                                </td>     
                                                                                <td style="width: 100px;">
                                                                                    Inv. Number
                                                                                </td>       
                                                                                <td style="width: 120px;">
                                                                                    Amount
                                                                                </td>                                                      
                                                                            </tr>
                                                                        </table>                                                       
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <table style="width: 380px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 100px;">
                                                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                                                </td>        
                                                                                <td style="width: 100px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['NoFP']")%>
                                                                                </td> 
                                                                                <td style="width: 120px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['debt_rema']")%>
                                                                                </td>                                                       
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_NoBuk_insert" EnableLoadOnDemand="True" DataTextField="NoFP"
                                                                    DataValueField="NoBuk" AutoPostBack="true" HighlightTemplatedItems="true" Height="120px" Width="120px" DropDownWidth="380px"
                                                                    EmptyMessage="- Search invoice here -" OnItemsRequested="cb_NoBuk_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_NoBuk_SelectedIndexChanged" OnPreRender="cb_NoBuk_PreRender" >                                                   
                                                                    <HeaderTemplate>
                                                                        <table style="width: 380px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 100px;">
                                                                                    Reg. Number
                                                                                </td>     
                                                                                <td style="width: 100px;">
                                                                                    Inv. Number
                                                                                </td>       
                                                                                <td style="width: 120px;">
                                                                                    Amount
                                                                                </td>                                                      
                                                                            </tr>
                                                                        </table>                                                       
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <table style="width: 380px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 100px;">
                                                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                                                </td>        
                                                                                <td style="width: 100px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['NoFP']")%>
                                                                                </td> 
                                                                                <td style="width: 120px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['debt_rema']")%>
                                                                                </td>                                                       
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Inv Number" ItemStyle-Width="100px" HeaderStyle-Width="100px" DataField="inv_code">
                                                            <ItemTemplate>  
                                                                <asp:Label runat="server" ID="lbl_inv_code" Text='<%# DataBinder.Eval(Container, "DataItem.fkno") %>' Width="100px"></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_invCode" Width="100px" ReadOnly="true"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.fkno") %>'>
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_invCode_insert" Width="100px" ReadOnly="true">
                                                                </telerik:RadTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Inv Date" ItemStyle-Width="120px" DataField="slip_date">
                                                            <ItemTemplate>  
                                                                <asp:Label runat="server" ID="lbl_slip_date" Text='<%# DataBinder.Eval(Container, "DataItem.slip_date") %>' Width="120px"></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="dtp_InvDate" Width="100px" ReadOnly="true"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.slip_date") %>'>
                                                                </telerik:RadTextBox>

                                                                <%--<telerik:RadDatePicker ID="dtp_InvDate" runat="server" MinDate="1/1/1900" Width="120px" RenderMode="Lightweight"
                                                                    TabIndex="4" Skin="Telerik" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.slip_date") %>' DateInput-ReadOnly="true">
                                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro">
                                                                    </Calendar>
                                                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                                                    </DateInput>
                                                                </telerik:RadDatePicker>--%>

                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="dtp_InvDate_insert" Width="100px" ReadOnly="true">
                                                                </telerik:RadTextBox>

                                                                <%--<telerik:RadDatePicker ID="dtp_InvDate_insert" runat="server" MinDate="1/1/1900" Width="120px" RenderMode="Lightweight"
                                                                    TabIndex="4" Skin="Telerik" DateInput-ReadOnly="true">
                                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro">
                                                                    </Calendar>
                                                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                                                    </DateInput>
                                                                </telerik:RadDatePicker>--%>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="250px" HeaderStyle-Width="250px" DataField="remark">
                                                            <ItemTemplate>  
                                                                <asp:Label runat="server" ID="lbl_remark" Text='<%# Eval("remark") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" Width="250px" runat="server" ID="txt_remark"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'
                                                                    EnableLoadOnDemand="True" Skin="Telerik" DataTextField="remark" DataValueField="remark" >
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" Width="250px" runat="server" ID="txt_remark_insert"
                                                                    EnableLoadOnDemand="True" Skin="Telerik" DataTextField="remark" DataValueField="remark" >
                                                                </telerik:RadTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Amount" ItemStyle-Width="130px" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Right"
                                                            DataField="pay_amount">
                                                            <ItemTemplate> 
                                                                <asp:Label runat="server" ID="lbl_pay_amount" Text='<%# Eval("pay_amount", "{0:#,###,###0.00}") %>'></asp:Label> 
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_amount" Width="130px"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "pay_amount", "{0:#,###,###0.00}") %>'
                                                                    NumberFormat-AllowRounding="true"  NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                                    ReadOnly="false" onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2"
                                                                    EnabledStyle-HorizontalAlign="Right">
                                                                </telerik:RadNumericTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_amount_insert" Width="130px"
                                                                    NumberFormat-AllowRounding="true"  NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                                    ReadOnly="false" onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2"
                                                                    EnabledStyle-HorizontalAlign="Right">
                                                                </telerik:RadNumericTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Project" ItemStyle-Width="60px" HeaderStyle-Width="60px" DataField="region_code" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>  
                                                                <asp:Label runat="server" ID="lbl_project_detail" Text='<%# Eval("region_code") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox runat="server" RenderMode="Lightweight" ID="txt_projectDetail" Width="60px" 
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.region_code") %>' ReadOnly="true">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadTextBox runat="server" RenderMode="Lightweight" ID="txt_projectDetail_insert" Width="60px" ReadOnly="true"></telerik:RadTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                             
                                                        <telerik:GridTemplateColumn HeaderText="Cost Center" ItemStyle-Width="60px" DataField="dept_code">
                                                            <ItemTemplate>  
                                                                <asp:Label runat="server" ID="lbl_cost_ctr" Text='<%# Eval("dept_code") %>' Width="60px"></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox runat="server" RenderMode="Lightweight" ID="txt_CostCenter" Width="60px" 
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>' ReadOnly="true">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate> 
                                                            <InsertItemTemplate>
                                                                <telerik:RadTextBox runat="server" RenderMode="Lightweight" ID="txt_CostCenter_insert" Width="60px" ReadOnly="true"></telerik:RadTextBox>
                                                            </InsertItemTemplate>                                   
                                                        </telerik:GridTemplateColumn> 
                                             
                                                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                                            ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-ForeColor="Red" >
                                                        </telerik:GridButtonColumn>
                                                    </Columns>
                                                </MasterTableView>
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="199" />
                                                    <ClientEvents OnRowDblClick="rowDblClick"/>
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                        </div>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView runat="server" ID="RadPageView2" Height="300px">
                                        <div runat="server" style="padding:15px 15px 15px 15px">
                                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" AutoGenerateColumns="false" Skin="Silk" CssClass="RadGrid_ModernBrowsers"
                                                AllowPaging="false" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" ShowStatusBar="true"        
                                                OnNeedDataSource="RadGrid3_NeedDataSource" OnPreRender="RadGrid3_PreRender">
                                                <HeaderStyle Font-Size="12px" />
                                                <AlternatingItemStyle Font-Size="10px" Font-Names="Comic Sans MS" />
                                                <MasterTableView DataKeyNames="nomor" HeaderStyle-ForeColor="Highlight" ItemStyle-Font-Size="10px" ItemStyle-Font-Names="Comic Sans MS"
                                                    HorizontalAlign="NotSet" AutoGenerateColumns="False">
                                                    <SortExpressions>
                                                        <telerik:GridSortExpression FieldName="nomor" SortOrder="Descending" />
                                                    </SortExpressions>
                                                    <ColumnGroups>
                                                        <telerik:GridColumnGroup Name="IDR" HeaderText="IDR" HeaderStyle-HorizontalAlign="Center" />
                                                        <telerik:GridColumnGroup Name="Valas" HeaderText="Valas" HeaderStyle-HorizontalAlign="Center" />
                                                    </ColumnGroups>
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="accountcode" HeaderStyle-Width="100px" HeaderText="Account No." SortExpression="accountcode"
                                                            UniqueName="accountcode" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="100px">                                
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="accountname" HeaderStyle-Width="200px" HeaderText="Account Name" SortExpression="accountname"
                                                            UniqueName="accountname" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="200px" >                                
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="cur_code" HeaderStyle-Width="80px" HeaderText="Currency" SortExpression="cur_code"
                                                            UniqueName="accountname" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="80px" >                                
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="kurs" HeaderStyle-Width="100px" HeaderText="Kurs" SortExpression="kurs"
                                                            UniqueName="accountname" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="100px" >                                
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="debet" HeaderStyle-Width="100px" HeaderText="Debet" SortExpression="debet"
                                                            UniqueName="debet" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ColumnGroupName="IDR" ItemStyle-Width="100px" 
                                                            DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#00CC00">                                
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="credit" HeaderStyle-Width="100px" HeaderText="Credit" SortExpression="credit"
                                                            UniqueName="credit" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ColumnGroupName="IDR" ItemStyle-Width="100px" 
                                                            DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#00CC00">                                
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="debet" HeaderStyle-Width="100px" HeaderText="Debet" SortExpression="debet"
                                                            UniqueName="debet" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ColumnGroupName="Valas" ItemStyle-Width="100px" 
                                                            DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#00CC00">                                
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="credit" HeaderStyle-Width="100px" HeaderText="Credit" SortExpression="credit"
                                                            UniqueName="credit" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ColumnGroupName="Valas" ItemStyle-Width="100px" 
                                                            DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#00CC00">                                
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="remark" HeaderStyle-Width="250px" HeaderText="Remark" SortExpression="remark"
                                                            UniqueName="remark" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="250px" >
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
                                                </MasterTableView>
                                                <ClientSettings AllowKeyboardNavigation="true">
                                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="310px" />
                                                    <Selecting AllowRowSelect="true"></Selecting>     
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                        </div>
                                    </telerik:RadPageView>
                                </telerik:RadMultiPage>
                            </div>
                        </div>
                    </FormTemplate>
                </EditFormSettings>
            </MasterTableView>
            <ClientSettings>
                <Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="255px" />
                <Selecting AllowRowSelect="true" />
                <ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />
            </ClientSettings>
        </telerik:RadGrid>
    </div>
    
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server"  ReloadOnShow="true" ShowContentDuringLoad="false"
                Width="1150px" Height="670px" Modal="true">
            </telerik:RadWindow>
            <telerik:RadWindow RenderMode="Auto" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="true"
                Width="1400px" Height="720px" AutoSize="False">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
    </telerik:RadWindowManager>
    <telerik:RadNotification RenderMode="Lightweight" ID="notif" Text="Data telah disimpan" runat="server" Position="BottomRight" Skin="Silk"
        AutoCloseDelay="10000" Width="350" Height="110" Title="Confirmation" EnableRoundedCorners="true">
    </telerik:RadNotification>       
        
        <%--DETAIL--%>
            
             <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConString %>"
                    SelectCommand="SELECT * FROM v_bank_paymentD WHERE slip_no = @slipno"                    
                    DeleteCommand="DELETE FROM acc01d03 WHERE slip_no = @slipno AND inv_code = @inv_code">
                   <SelectParameters>
                        <asp:ControlParameter ControlID="txt_slip_number" PropertyName="Text" Name="slipno" />
                   </SelectParameters>                    
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="txt_slip_number" PropertyName="Text" Name="slipno" />
                        <asp:Parameter Name="inv_code" Type="String"></asp:Parameter>
                    </DeleteParameters>
                 </asp:SqlDataSource>
        </div>--%>
        
    <%--<script type="text/javascript">
    //<![CDATA[
        Sys.Application.add_load(function() {
            $windowContentDemo.contentTemplateID = "<%=RadWindow_ContentTemplate.ClientID%>";
            $windowContentDemo.templateWindowID = "<%=RadWindow_ContentTemplate.ClientID %>";
        });
    //]]>
    </script>--%>  
    
</asp:Content>
