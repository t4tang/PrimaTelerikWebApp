<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h01.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Bank.BankMutation.acc01h01" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />

    <script src="../../../../Script/Script.js"></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
            function ShowPreview(id) {
                window.radopen("ReportVieweracc01h01.aspx?NoBuk=" + id, "PreviewDialog");
                return false;
            }
            function ShowJournal(id) {
                window.radopen("acc01h01journal.aspx?NoBuk=" + id, "PreviewDialog");
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
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_project">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_bank" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
           <telerik:AjaxSetting AjaxControlID="cb_bank">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_cur_code" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_kurs" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
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
        <ContentTemplate>
             <div runat="server" style="padding:20px 10px 10px 10px;" id="Div2">                
                <table>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Date From :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik" DateInput-CausesValidation="false"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                        <td >
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"  DateInput-CausesValidation="false"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                <telerik:RadLabel runat="server" Text="Bank :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                <telerik:RadComboBox ID="cb_bank_prm" runat="server" RenderMode="Lightweight" AutoPostBack="true"
                                    EnableLoadOnDemand="True"  Skin="Telerik" 
                                    OnItemsRequested="cb_bank_prm_ItemsRequested"
                                    OnSelectedIndexChanged="cb_bank_prm_SelectedIndexChanged"
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%">
                                </telerik:RadComboBox>                                    
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btnSearch1" runat="server" OnClick="btnSearch1_Click" Text="Filter" Width="95%" Height="25px" 
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
            <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" ></ClientSettings>
            <HeaderStyle ForeColor="Highlight" Font-Size="11px" />
            <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="NoBuk" Font-Size="11px" Font-Names="Century Gothic"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" 
                CommandItemSettings-AddNewRecordText="New" EditFormSettings-EditFormType="Template" InsertItemDisplay="Top">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="40px"/>
                        <ItemStyle Width="40px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn UniqueName="NoBuk" HeaderText="Reg. No" DataField="NoBuk">
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="NoCtrl" HeaderText="Ctrl. No" DataField="NoCtrl" 
                        FilterControlWidth="100px" >
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="Total" HeaderText="Amount" DataField="Total" 
                        FilterControlWidth="90px" DataFormatString="{0:#,###,##0.00}" ItemStyle-HorizontalAlign="Right" 
                        ItemStyle-ForeColor="#009933">
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn UniqueName="Tgl" HeaderText="Date" DataField="Tgl" ItemStyle-Width="80px" 
                        EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" ItemStyle-HorizontalAlign="Center"
                        DataFormatString="{0:d}" >
                        <HeaderStyle Width="80px"></HeaderStyle>
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn UniqueName="Kontak" HeaderText="Contact" DataField="Kontak" 
                        FilterControlWidth="200px" >
                        <HeaderStyle Width="200px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="Ket" HeaderText="Remark" DataField="Ket" ItemStyle-Wrap="true"
                        ItemStyle-Width="400px" FilterControlWidth="400px">
                        <HeaderStyle Width="400px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Right"
                        AllowFiltering="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" ItemStyle-ForeColor="Red"
                        ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="Classic" ButtonType="FontIconButton">
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
                                                        OnClick="btnSave_Click" Height="25px" 
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
                                                    <telerik:RadTextBox ID="txt_NoBuk" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight" Skin="Telerik"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.NoBuk") %>' ReadOnly="true">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtp_bm"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                        TabIndex="4" Skin="Telerik" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.Tgl") %>'> 
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro"></Calendar>
                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" >                            
                                                            <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                                            <ReadOnlyStyle Resize="None"></ReadOnlyStyle>
                                                            <FocusedStyle Resize="None"></FocusedStyle>
                                                            <DisabledStyle Resize="None"></DisabledStyle>
                                                            <InvalidStyle Resize="None"></InvalidStyle>
                                                            <HoveredStyle Resize="None"></HoveredStyle>
                                                            <EnabledStyle Resize="None"></EnabledStyle>
                                                        </DateInput>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="No. Ctrl:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_NoCtrl" runat="server" Width="200px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.NoCtrl") %>' ReadOnly="false">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="No. Reff:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_NoRef" runat="server" Width="200px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.NoRef") %>' ReadOnly="false">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Transaction:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_KoTrans" runat="server" Width="200"
                                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Telerik" AutoPostBack="true" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.KoTransName") %>'
                                                        OnItemsRequested="cb_KoTrans_ItemsRequested" OnPreRender="cb_KoTrans_PreRender"
                                                        OnSelectedIndexChanged="cb_KoTrans_SelectedIndexChanged"
                                                        EnableVirtualScrolling="true" >
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="vertical-align: top; padding-left:15px">
                                        <table id="Table3" border="0" class="module">
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Project:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td style="vertical-align:top; text-align:left">                      
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" Skin="Telerik" 
                                                        EnableLoadOnDemand ="true" Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' 
                                                        OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                                        OnPreRender="cb_project_PreRender" >
                                                    </telerik:RadComboBox>               
                                                </td>
                                            </tr>
                                            <tr >
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Bank:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td style="vertical-align:top; text-align:left">                               
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_bank" runat="server" Width="300" DropDownWidth="300px"
                                                        AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select a Bank -" Skin="Telerik" 
                                                        EnableLoadOnDemand ="true" Text='<%# DataBinder.Eval(Container, "DataItem.NamBank") %>'
                                                        OnItemsRequested="cb_bank_ItemsRequested" OnSelectedIndexChanged="cb_bank_SelectedIndexChanged" CausesValidation="false"
                                                        OnPreRender="cb_bank_PreRender" >
                                                    </telerik:RadComboBox>                
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Currency:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_cur_code" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight" Skin="Telerik"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.cur_code") %>'>
                                                    </telerik:RadTextBox>
                                                    &nbsp
                                                    <telerik:RadLabel runat="server" Text="Kurs:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    <telerik:RadTextBox ID="txt_kurs" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.kurs") %>'>
                                                    </telerik:RadTextBox>  
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="From / To:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>                
                                                <td>   
                                                    <telerik:RadTextBox ID="txt_Kontak" runat="server" Width="345px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.Kontak") %>'>
                                                    </telerik:RadTextBox>                                 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Remark:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>                
                                                <td style="vertical-align:top; text-align:left">                               
                                                    <telerik:RadTextBox ID="txt_Ket" 
                                                        runat="server" TextMode="MultiLine" Text='<%# DataBinder.Eval(Container, "DataItem.Ket") %>'
                                                        Width="345px" Rows="0" Columns="100" TabIndex="5" Resize="Both">
                                                    </telerik:RadTextBox>                                  
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="padding-top:10px; padding-bottom:10px;">
                                        <table>
                                            <tr>
                                                <td style="padding:0px 10px 0px 10px">
                                                    <telerik:RadLabel runat="server" Text="Prepared By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_prepared" runat="server" Width="250px" 
                                                        DropDownWidth="370px" AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select -" Skin="Telerik" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.PreparedBy") %>' 
                                                        EnableLoadOnDemand ="true" OnItemsRequested="cb_prepared_ItemsRequested" OnSelectedIndexChanged="cb_prepared_SelectedIndexChanged"
                                                        OnPreRender="cb_prepared_PreRender" >
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
                                                            <table style="width: 370px; font-size:smaller">
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
                                                <td style="padding:0px 10px 0px 10px"> 
                                                    <telerik:RadLabel runat="server" Text="Checked By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_checked" runat="server" Width="250px" 
                                                        DropDownWidth="370px" AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select -" Skin="Telerik" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.CheckedBy") %>' 
                                                        EnableLoadOnDemand ="true" EnableVirtualScrolling="true" OnItemsRequested="cb_checked_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_checked_SelectedIndexChanged"
                                                        OnPreRender="cb_checked_PreRender" >
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
                                                <td style="padding:0px 10px 0px 10px">
                                                    <telerik:RadLabel runat="server" Text="Approved By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px" 
                                                        DropDownWidth="370px" EmptyMessage="- Select -" AutoPostBack="true" ShowMoreResultsBox="false" Skin="Telerik" 
                                                        EnableLoadOnDemand ="true" Text='<%# DataBinder.Eval(Container, "DataItem.ApprovalBy") %>'
                                                        OnItemsRequested="cb_approved_ItemsRequested" OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                        OnPreRender="cb_approved_PreRender">  
                                                        <HeaderTemplate>
                                                            <table style="width: 370px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 150px;">
                                                                        Name
                                                                    </td>
                                                                    <td style="width: 290px;">
                                                                        Position
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 370px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 150px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                    </td>
                                                                    <td style="width: 290px;">
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
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="padding-top:20px; padding-bottom:20px;">
                                        <table class="trxInfo">
                                            <tr>
                                                <td style="width:auto"> User : </td>
                                                <td style="width:50px">
                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="50px" runat="server" BorderStyle="None" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Usr") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td style="padding-left:15px"> Last Update : </td>
                                                <td style="width:50px">
                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_LastUpdate" Width="140px" runat="server" BorderStyle="None" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.LastUpdate") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td style="padding-left:15px"> Owner : </td>
                                                <td style="width:50px">
                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="50px" runat="server" BorderStyle="None" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Owner") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td style="padding-left:15px"> Printed : </td>
                                                <td>
                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_printed" Width="40px" runat="server" BorderStyle="None" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Printed") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td style="padding-left:15px"> Edited : </td>
                                                <td>
                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" runat="server" BorderStyle="None" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Edited") %>'>
                                                    </telerik:RadTextBox>
                                                </td>                        
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <div style="padding: 7px 0px 12px 0px; height:288px">
                                <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1" Orientation="HorizontalTop" Width="97%" 
                                    SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="silk" CausesValidation="false">
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
                                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="NoBuk, KoRek" Font-Size="11px" EditMode="InPlace"
                                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" InsertItemDisplay="Bottom">
                                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" /> 
                                                    <Columns>
                                                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                                            HeaderText="Edit" HeaderStyle-Width="60px" ItemStyle-Width="60px" UpdateText="Update">
                                                        </telerik:GridEditCommandColumn>
                                                        <%--<telerik:GridTemplateColumn UniqueName="Nomor" HeaderText="No." HeaderStyle-Width="30px" Visible="true"
                                                            SortExpression="Nomor" ItemStyle-Width="30px">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_nomor" Width="30px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Nomor")%>'></asp:Label>                                             
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_nomor" Width="30px" ReadOnly="true" 
                                                                    Text='<%#DataBinder.Eval(Container.DataItem, "Nomor")%>'>
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_nomor" Width="30px" ReadOnly="true">
                                                                </telerik:RadTextBox> 
                                                            </InsertItemTemplate>                                                                                
                                                        </telerik:GridTemplateColumn> --%>
                                                               
                                                        <telerik:GridTemplateColumn UniqueName="KoRek" HeaderText="Account No." HeaderStyle-Width="110px"
                                                            SortExpression="KoRek" ItemStyle-Width="110px">
                                                            <FooterTemplate>Template footer</FooterTemplate>
                                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_korek" Width="110px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "KoRek")%>'></asp:Label>                                                
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_korek" EnableLoadOnDemand="True" DataTextField="accountname"
                                                                    OnItemsRequested="cb_korek_ItemsRequested" DataValueField="KoRek" AutoPostBack="true"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.KoRek") %>'
                                                                    HighlightTemplatedItems="true" Height="190px" Width="110px" DropDownWidth="450px"
                                                                    OnSelectedIndexChanged="cb_korek_SelectedIndexChanged" OnPreRender="cb_korek_PreRender">
                                                                    <HeaderTemplate>
                                                                        <table style="width: 300px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 80px;">
                                                                                    Account No
                                                                                </td>
                                                                                <td style="width: 200px;">
                                                                                    Account Name
                                                                                </td>                                                                
                                                                            </tr>
                                                                        </table>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <table style="width: 300px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 80px;">
                                                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                                                </td>                   
                                                                                <td style="width: 200px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['accountname']")%>
                                                                                </td>                                             
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_korek_insert" EnableLoadOnDemand="True" DataTextField="accountname"
                                                                    OnItemsRequested="cb_korek_ItemsRequested" DataValueField="KoRek" AutoPostBack="true"
                                                                    HighlightTemplatedItems="true" Height="190px" Width="110px" DropDownWidth="450px"
                                                                    OnSelectedIndexChanged="cb_korek_SelectedIndexChanged" OnPreRender="cb_korek_PreRender">
                                                                    <HeaderTemplate>
                                                                        <table style="width: 300px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 80px;">
                                                                                    Account No
                                                                                </td>
                                                                                <td style="width: 200px;">
                                                                                    Account Name
                                                                                </td>                                                                
                                                                            </tr>
                                                                        </table>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <table style="width: 300px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 80px;">
                                                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                                                </td>                   
                                                                                <td style="width: 200px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['accountname']")%>
                                                                                </td>                                             
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>                            
                                   
                                                        <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="380px" HeaderStyle-Width="380px" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_KetD" Width="380px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Ket") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_KetD" Width="380px"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Ket") %>'>
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_KetD_insert" Width="380px"></telerik:RadTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn> 

                                                        <telerik:GridTemplateColumn HeaderText="D/K" ItemStyle-Width="80px"  HeaderStyle-Width="80px"  ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate> 
                                                                <asp:Label ID="lbl_MutasiD" Width="80px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Mutasi") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" Width="80px" DropDownWidth="80px" runat="server" ID="cb_mutasi" AutoPostBack="false"
                                                                    EnableLoadOnDemand="true" Skin="Telerik" DataTextField="name" DataValueField="Mutasi"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Mutasi") %>'
                                                                    OnItemsRequested="cb_mutasi_ItemsRequested" OnPreRender="cb_mutasi_PreRender"
                                                                    OnSelectedIndexChanged="cb_mutasi_SelectedIndexChanged" >
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" Width="80px" DropDownWidth="80px" runat="server" ID="cb_mutasi_insert" AutoPostBack="false"
                                                                    EnableLoadOnDemand="true" Skin="Telerik" DataTextField="name" DataValueField="Mutasi"
                                                                    OnItemsRequested="cb_mutasi_ItemsRequested" OnPreRender="cb_mutasi_PreRender"
                                                                    OnSelectedIndexChanged="cb_mutasi_SelectedIndexChanged" >
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn> 
                                           
                                                        <telerik:GridTemplateColumn HeaderText="Kurs" ItemStyle-Width="100px" HeaderStyle-Width="100px"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>  
                                                                <asp:Label ID="lbl_KursD" Width="100px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.kurs") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_kursD" Width="100px" ItemStyle-HorizontalAlign="Right" 
                                                                    NumberFormat-AllowRounding="true" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" 
                                                                    AllowOutOfRangeAutoCorrect="false" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="9" Skin="Telerik"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.kurs") %>'>
                                                                </telerik:RadNumericTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_kursD_insert" Width="100px" ItemStyle-HorizontalAlign="Right" 
                                                                    NumberFormat-AllowRounding="true" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" 
                                                                    AllowOutOfRangeAutoCorrect="false" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="9" Skin="Telerik"></telerik:RadNumericTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Ammount" ItemStyle-Width="150px" HeaderStyle-Width="150px" 
                                                            ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>  
                                                                <asp:Label ID="lbl_Jumlah" Width="150px" runat="server" 
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Jumlah","{0:#,###,###0.00}") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_Jumlah" Width="150px" ItemStyle-HorizontalAlign="Right" 
                                                                    NumberFormat-AllowRounding="true" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" 
                                                                    AllowOutOfRangeAutoCorrect="false" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="9" Skin="Telerik"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Jumlah","{0:#,###,###0.00}") %>'>
                                                                </telerik:RadNumericTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_Jumlah_insert" Width="150px" ItemStyle-HorizontalAlign="Right" 
                                                                    NumberFormat-AllowRounding="true" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" 
                                                                    AllowOutOfRangeAutoCorrect="false" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="9" Skin="Telerik"></telerik:RadNumericTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                           
                                                        <telerik:GridTemplateColumn UniqueName="region_code" HeaderText="Project" HeaderStyle-Width="100px"
                                                            SortExpression="region_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                                            <FooterTemplate>Template footer</FooterTemplate>
                                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_ProjectDetail" Width="100px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.region_code") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_project_detail" EnableLoadOnDemand="True" DataTextField="region_name"
                                                                    OnItemsRequested="cb_project_detail_ItemsRequested" DataValueField="region_code" AutoPostBack="true"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.region_code") %>'
                                                                    HighlightTemplatedItems="true" Height="190px" Width="100px" DropDownWidth="300px"
                                                                    OnSelectedIndexChanged="cb_project_detail_SelectedIndexChanged" OnPreRender="cb_project_detail_PreRender">
                                                                    <HeaderTemplate>
                                                                         <table style="width: 300px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 80px;">
                                                                                    Code
                                                                                </td>
                                                                                <td style="width: 200px;">
                                                                                    Project
                                                                                </td>                                                                
                                                                            </tr>
                                                                        </table>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <table style="width: 300px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 80px;">
                                                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                                                </td>                   
                                                                                <td style="width: 200px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['region_name']")%>
                                                                                </td>                                             
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_project_detail_insert" EnableLoadOnDemand="True" DataTextField="region_name"
                                                                    OnItemsRequested="cb_project_detail_ItemsRequested" DataValueField="region_code" AutoPostBack="true"
                                                                    HighlightTemplatedItems="true" Height="190px" Width="100px" DropDownWidth="300px"
                                                                    OnSelectedIndexChanged="cb_project_detail_SelectedIndexChanged" OnPreRender="cb_project_detail_PreRender">
                                                                    <HeaderTemplate>
                                                                         <table style="width: 300px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 80px;">
                                                                                    Code
                                                                                </td>
                                                                                <td style="width: 200px;">
                                                                                    Project
                                                                                </td>                                                                
                                                                            </tr>
                                                                        </table>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <table style="width: 300px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 80px;">
                                                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                                                </td>                   
                                                                                <td style="width: 200px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['region_name']")%>
                                                                                </td>                                             
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>    
                         
                                                        <telerik:GridTemplateColumn UniqueName="dept_code" HeaderText="Cost Center" HeaderStyle-Width="100px"
                                                            SortExpression="dept_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                                            <FooterTemplate>Template footer</FooterTemplate>
                                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_cost_center" Width="100px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_cost_center" EnableLoadOnDemand="True" DataTextField="name"
                                                                    OnItemsRequested="cb_cost_center_ItemsRequested" DataValueField="code" AutoPostBack="false" CausesValidation="false" 
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>'
                                                                    HighlightTemplatedItems="true" Height="190px" Width="100px" DropDownWidth="300px"
                                                                    OnPreRender="cb_cost_center_PreRender" OnSelectedIndexChanged="cb_cost_center_SelectedIndexChanged">
                                                                    <HeaderTemplate>
                                                                         <table style="width: 300px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 80px;">
                                                                                    Code
                                                                                </td>
                                                                                <td style="width: 200px;">
                                                                                    Name
                                                                                </td>                                                                
                                                                            </tr>
                                                                        </table>
                                                                    </HeaderTemplate>    
                                                                    <ItemTemplate>
                                                                        <table style="width: 300px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 80px;">
                                                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                                                </td>                   
                                                                                <td style="width: 200px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['name']")%>
                                                                                </td>                                             
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_cost_center_insert" EnableLoadOnDemand="True" DataTextField="name"
                                                                    OnItemsRequested="cb_cost_center_ItemsRequested" DataValueField="code" AutoPostBack="false" CausesValidation="false" 
                                                                    HighlightTemplatedItems="true" Height="190px" Width="100px" DropDownWidth="300px"
                                                                    OnPreRender="cb_cost_center_PreRender" OnSelectedIndexChanged="cb_cost_center_SelectedIndexChanged">
                                                                    <HeaderTemplate>
                                                                         <table style="width: 300px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 80px;">
                                                                                    Code
                                                                                </td>
                                                                                <td style="width: 200px;">
                                                                                    Name
                                                                                </td>                                                                
                                                                            </tr>
                                                                        </table>
                                                                    </HeaderTemplate>    
                                                                    <ItemTemplate>
                                                                        <table style="width: 300px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 80px;">
                                                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                                                </td>                   
                                                                                <td style="width: 200px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['name']")%>
                                                                                </td>                                             
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                                                            ConfirmTitle="Delete" ConfirmDialogType="Classic"
                                                            ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
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
                                                AllowPaging="false" AllowSorting="true" runat="server" AllowAutomaticDeletes="true" AllowAutomaticInserts="true" ShowStatusBar="true" 
                                                OnNeedDataSource="RadGrid3_NeedDataSource" OnPreRender="RadGrid3_PreRender">
                                                <HeaderStyle Font-Size="12px" />
                                                <AlternatingItemStyle Font-Size="10px" Font-Names="Comic Sans MS" />
                                                <MasterTableView DataKeyNames="nomor" HeaderStyle-ForeColor="Highlight" ItemStyle-Font-Size="10px" ItemStyle-Font-Names="Comic Sans MS" 
                                                    HorizontalAlign="NotSet" AutoGenerateColumns="false">
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
                                <table>
                                    <tr>
                                        <td class="tdLabel" colspan="2">
                                            <telerik:RadLabel runat="server" Text="Total:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txt_total" runat="server" Width="120px" RenderMode="Lightweight" ItemStyle-HorizontalAlign="Right" 
                                                NumberFormat-AllowRounding="true" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" 
                                                AllowOutOfRangeAutoCorrect="false" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="9" Skin="Telerik">
                                            </telerik:RadTextBox>                  
                                        </td>
                                    </tr>
                                </table>
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
            <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                Width="1150px" Height="670px" Modal="true" AutoSize="True">
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
    
</asp:Content>

                             
                             
                           