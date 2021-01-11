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
                window.radopen("acc01h03journal.aspx?doc_code=" + id, "PreviewDialog");
                return false;
            }
        </script>
        <style type="text/css">
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
        </style>
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
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="cb_project_detail">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_project_detail" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    
     <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="500" BackgroundPosition="None">
        <img alt="Loading..." src="../../../../Images/load.gif" style="top: 40px" />
    </telerik:RadAjaxLoadingPanel>
    
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="1300px" Height="670px">
        <%--LIST DATA--%>
        <ContentTemplate>
            <div runat="server" style="padding:20px 10px 10px 10px;" id="searchParam">                
                <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="Date From " Height="26px"></telerik:RadDatePicker>                
                <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="To Date " Height="26px"></telerik:RadDatePicker>
                <telerik:RadComboBox ID="cb_bank_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="Bank" AutoPostBack="false"
                    EnableLoadOnDemand="true" Skin="Telerik"  OnItemsRequested="cb_bank_prm_ItemsRequested" EnableVirtualScrolling="false" 
                    Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" DropDownWidth="350px"
                    OnSelectedIndexChanged="cb_bank_prm_SelectedIndexChanged"></telerik:RadComboBox>&nbsp
                &nbsp
                <asp:Button ID="btnFind" runat="server" Text="Search" OnClick="btnFind_Click" />
                 &nbsp
                <asp:Button ID="btnOk" runat="server" Text="Select & Close" OnClick="btnOk_Click"/>
            </div>
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="10"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                    <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                    <ClientSettings EnablePostBackOnRowClick="true" >
                    </ClientSettings>
                    <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="slip_no" Font-Size="12px" ShowHeadersWhenNoRecords="true"
                     EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                     CommandItemSettings-ShowRefreshButton="false" CellPadding="-1">
                        <Columns>
                            <telerik:GridClientSelectColumn UniqueName="SelectColumn" ></telerik:GridClientSelectColumn> 
                            <telerik:GridBoundColumn UniqueName="slip_no" HeaderText="Reg. No" DataField="slip_no" FilterControlWidth="80px">
                            <HeaderStyle Width="80px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <%--<telerik:GridBoundColumn UniqueName="cashbank" HeaderText="Bank Code" DataField="cashbank" FilterControlWidth="50px">
                            <HeaderStyle Width="50px"></HeaderStyle>
                            </telerik:GridBoundColumn>--%>
                            <telerik:GridBoundColumn UniqueName="noctrl" HeaderText="Ctrl. No" DataField="noctrl" FilterControlWidth="80px">
                            <HeaderStyle Width="80px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridDateTimeColumn UniqueName="slip_date" HeaderText="Date" DataField="slip_date" FilterControlWidth="80px" 
                                EnableRangeFiltering="false" PickerType="DatePicker" 
                                DataFormatString="{0:d}">
                            <HeaderStyle Width="80px"></HeaderStyle>
                            </telerik:GridDateTimeColumn>
                            <telerik:GridBoundColumn UniqueName="supplier_name" HeaderText="Supplier" DataField="supplier_name" FilterControlWidth="180px">
                            <HeaderStyle Width="180px"></HeaderStyle>
                            </telerik:GridBoundColumn>                            
                            <telerik:GridBoundColumn UniqueName="kurs" HeaderText="Kurs" DataField="kurs" FilterControlWidth="50px" DataFormatString='{0:#,###0.00000}'>
                                <HeaderStyle Width="50px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="tot_pay" HeaderText="Tot. Amount" DataField="tot_pay" FilterControlWidth="100px" DataFormatString='{0:#,###,###0.00}'
                                ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#009933">
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="cur_code" HeaderText="Curr" DataField="cur_code" FilterControlWidth="50px" ItemStyle-HorizontalAlign="Center">
                            <HeaderStyle Width="50px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="Remark" HeaderText="Remark" DataField="Remark" FilterControlWidth="300px">
                            <HeaderStyle Width="200px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete"  ConfirmText="Are You Sure ?" ConfirmTitle="Delete" 
                            ConfirmDialogType="RadWindow" ButtonType="FontIconButton"></telerik:GridButtonColumn>     
                        </Columns>
                    </MasterTableView>
                    <ClientSettings>
                    <Selecting AllowRowSelect="true"></Selecting>
                    </ClientSettings>
                </telerik:RadGrid>
            </ContentTemplate>
    </telerik:RadWindow>
    <div class="scroller"> 
    <%--ICONS--%>
   <div style=" padding-left:15px; width:100%; border-bottom-color: #FF6600; border-bottom-width: 1px; border-bottom-style: inset;">
        <table id="tbl_control">
            <tr>
                <td  style="text-align:right;">
                    <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                        Height="25px" Width="30px" ImageUrl="~/Images/daftar.png">
                    </asp:ImageButton>                        
                </td>
                <td style="vertical-align:middle; margin-left:10px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click"
                        Height="25px" Width="30px" ImageUrl="~/Images/tambah.png">
                    </asp:ImageButton>
                </td>
               
                <td style="vertical-align:middle; margin-left:10px;padding-left:0px">
                    <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" OnClick="btnSave_Click"
                        Height="25px" Width="27px" ImageUrl="~/Images/simpan-gray.png">
                    </asp:ImageButton>
                </td>
                <td style="vertical-align:middle; margin-left:10px;padding-left:13px">
                    <asp:ImageButton runat="server" ID="btnPrint" AlternateText="Print" OnClick="btnPrint_Click"
                        Height="25px" Width="27px" ImageUrl="~/Images/cetak-gray.png">
                    </asp:ImageButton>
                </td>
                <td style="vertical-align:middle; margin-left:10px;padding-left:13px">
                    <asp:ImageButton runat="server" ID="btnJournal" AlternateText="Journal" OnClick="btn_journal_Click"
                        Height="25px" Width="27px" ImageUrl="~/Images/ledger-gray.png">
                    </asp:ImageButton>  
                </td>
                <%--<td style="width:83%; text-align:right">
                    <telerik:RadLabel ID="lbl_form_name" Text="Bank Payment Voucher" runat="server" style="font-weight:lighter; 
                        font-size:10px; font-variant: small-caps; padding-left:10px; 
                    padding-bottom:0px; font-size:x-large; color:Highlight">
                    </telerik:RadLabel>
                </td>--%>
                <td style="width: 86%; text-align: right">
                    <telerik:RadLabel ID="RadLabel1" runat="server" Text="Bank Payment Voucher" 
                        Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#7cca05;">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>
    <%--HEADER--%>
    <div class="table_trx">       
        <table id="Table2" width="100%" border="0" class="module">
            <tr style="vertical-align: top">
                <td style="vertical-align:top; width:35%">
                        <table>
                            <tr>
                                <td class="tdLabel">
                                    Reg No :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_slip_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                        &nbsp;
                                    <asp:CheckBox ID="chk_posting" runat="server" Checked="false" Enabled="false" Text="Posting"/>
                                </td>                                           
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Supplier:
                                </td>
                                <td style="vertical-align:top; text-align:left">                      
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="300px" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Supplier -" EnableLoadOnDemand="True" Skin="Telerik"  
                                        OnItemsRequested="cb_supplier_ItemsRequested" OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged" 
                                        OnPreRender="cb_supplier_PreRender">
                                    </telerik:RadComboBox>
                                                        
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Currency :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_currency" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                    Kurs :
                                    <telerik:RadTextBox ID="txt_kurs" runat="server" Width="108px" ReadOnly="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Reference:
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
                                    Bank :
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_bank" runat="server" Width="300px" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Bank -" EnableLoadOnDemand="True" Skin="Telerik"  
                                        OnItemsRequested="cb_bank_ItemsRequested" OnSelectedIndexChanged="cb_bank_SelectedIndexChanged" OnPreRender="cb_bank_PreRender">
                                    </telerik:RadComboBox>
                                    &nbsp;
                                   
                                    
                                </td>
                            </tr>
                             <tr>
                                <td class="tdLabel">
                                     Curr :
                                </td>
                                 <td>
                                     <telerik:RadTextBox ID="txt_curr2" runat="server" Width="60px" ReadOnly="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                     &nbsp;&nbsp;&nbsp;Kurs :
                                    <telerik:RadTextBox ID="txt_kurs2" runat="server" Width="95px" ReadOnly="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                 </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Doc Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_created"  runat="server" MinDate="1/1/1900" Width="110px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Metro"> 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>                                                    
                                        </DateInput>                         
                                    </telerik:RadDatePicker>
                                    &nbsp;&nbsp;&nbsp;Ctrl No :
                                    <telerik:RadTextBox ID="txt_ctrl" runat="server" Width="130px" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Cashed Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_cashed" runat="server" MinDate="1/1/1900" Width="110px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Metro">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            
                        </table>
                </td>
                <td>
                        <table>
                            <tr>
                                <td class="tdLabel">
                                    Giro No :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_giro" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>                                           
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Prepared by : 
                                </td>
                                <td >                      
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_pre" runat="server" Width="300" DropDownWidth="300px"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" EnableLoadOnDemand="True" Skin="Telerik"
                                        OnItemsRequested="txt_pre_ItemsRequested" OnSelectedIndexChanged="txt_pre_SelectedIndexChanged" OnPreRender="txt_pre_PreRender">
                                    </telerik:RadComboBox> 
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Checked by :
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_check" runat="server" Width="300" DropDownWidth="300px"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" EnableLoadOnDemand="True" Skin="Telerik"  
                                        OnItemsRequested="txt_pre_ItemsRequested" OnSelectedIndexChanged="txt_pre_SelectedIndexChanged" OnPreRender="txt_pre_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Approve by :
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approve" runat="server" Width="300" DropDownWidth="300px"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" EnableLoadOnDemand="True" Skin="Telerik"  
                                        OnItemsRequested="txt_pre_ItemsRequested" OnSelectedIndexChanged="txt_pre_SelectedIndexChanged" OnPreRender="txt_pre_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Remark :
                                </td>
                                <td>                                                
                                    <telerik:RadTextBox ID="txt_remark" runat="server" Width="300px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false" TextMode="MultiLine">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table class="trxInfo">
                                        <tr>
                                            <td>
                                                User :                                                
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_user" runat="server" Width="50px" RenderMode="Lightweight" BorderStyle="None" 
                                                    AutoPostBack="false" ReadOnly="true">
                                                </telerik:RadTextBox>
                                                &nbsp;&nbsp;&nbsp;Last Update :  
                                                <telerik:RadTextBox ID="txt_lastupdate" runat="server" Width="160px" RenderMode="Lightweight" BorderStyle="None"
                                                    AutoPostBack="false" ReadOnly="true">
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
                <td colspan="4" style="vertical-align:middle; text-align:right; padding-right:20px" >
                    
                </td>
            </tr>
        </table>
        <%--DETAIL--%>
            <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 20px;">
                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"
                    AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticUpdates="true" AllowAutomaticInserts="True" AllowAutomaticDeletes="true"
                    ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" 
                    OnNeedDataSource="RadGrid2_NeedDataSource" OnInsertCommand="RadGrid2_save_handler" OnUpdateCommand="RadGrid2_save_handler">   
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
                                        <asp:Label runat="server" ID="lbl_NoBuk" Text='<%# Eval("inv_code") %>' Width="120px"></asp:Label> 
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_NoBuk" EnableLoadOnDemand="True" DataTextField="NoBuk"
                                        DataValueField="NoBuk" AutoPostBack="true" HighlightTemplatedItems="true" Height="120px" Width="120px" DropDownWidth="380px"
                                        EmptyMessage="- Search invoice here -" Text='<%# Eval("inv_code") %>'
                                        OnItemsRequested="cb_NoBuk_ItemsRequested" OnSelectedIndexChanged="cb_NoBuk_SelectedIndexChanged" >                                                   
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
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Inv Number" ItemStyle-Width="100px" HeaderStyle-Width="100px" DataField="inv_code">
                                    <ItemTemplate>  
                                        <asp:Label runat="server" ID="lbl_inv_code" Text='<%# Eval("inv_code") %>' Width="100px"></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Inv Date" ItemStyle-Width="120px" DataField="slip_date">
                                    <ItemTemplate>  
                                        <asp:Label runat="server" ID="lbl_slip_date" Text='<%# Eval("slip_date","{0:dd-MM-yyyy}") %>' Width="120px"></asp:Label>
                                    </ItemTemplate>
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
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Amount" ItemStyle-Width="130px" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Right"
                                    DataField="pay_amount">
                                    <ItemTemplate> 
                                        <asp:Label runat="server" ID="lbl_pay_amount" Text='<%# Eval("pay_amount", "{0:#,###,###0.00}") %>'></asp:Label> 
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_amount" Width="130px"
                                            Text='<%# DataBinder.Eval(Container.DataItem, "pay_amount", "{0:#,###,###0.00}") %>'
                                            NumberFormat-AllowRounding="true"  NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                            ReadOnly="false" onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2"
                                            EnabledStyle-HorizontalAlign="Right">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_amount" Width="130px"
                                            Text='<%# DataBinder.Eval(Container.DataItem, "pay_amount", "{0:#,###,###0.00}") %>'
                                            NumberFormat-AllowRounding="true"  NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                            ReadOnly="false" onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2"
                                            EnabledStyle-HorizontalAlign="Right">
                                        </telerik:RadTextBox>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Project" ItemStyle-Width="60px" HeaderStyle-Width="60px" DataField="region_code" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>  
                                        <asp:Label runat="server" ID="lbl_project_detail" Text='<%# Eval("region_code") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn> 
                                 <telerik:GridTemplateColumn HeaderText="Cost Center" ItemStyle-Width="60px" DataField="dept_code">
                                    <ItemTemplate>  
                                        <asp:Label runat="server" ID="lbl_cost_ctr" Text='<%# Eval("dept_code") %>' Width="60px"></asp:Label>
                                    </ItemTemplate>                                    
                                </telerik:GridTemplateColumn>  
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-ForeColor="Red" >
                                </telerik:GridButtonColumn>
                             
                            </Columns>
                        </MasterTableView>
                    <ClientSettings>
                        <ClientEvents OnRowDblClick="rowDblClick"/>
                    </ClientSettings>
                 </telerik:RadGrid>
                 
            </div>
             <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConString %>"
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
        </div>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server"  ReloadOnShow="true" ShowContentDuringLoad="false"
                  Width="1150px" Height="670px" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    <script type="text/javascript">
    //<![CDATA[
        Sys.Application.add_load(function() {
            $windowContentDemo.contentTemplateID = "<%=RadWindow_ContentTemplate.ClientID%>";
            $windowContentDemo.templateWindowID = "<%=RadWindow_ContentTemplate.ClientID %>";
        });
    //]]>
    </script>  
    </div>
    


</asp:Content>
