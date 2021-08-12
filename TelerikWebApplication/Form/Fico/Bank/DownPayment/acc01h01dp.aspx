<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h01dp.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Bank.DownPayment.acc01h01dp" %>
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

            function CloseAndRebind(args) {
                GetRadWindow().BrowserWindow.refreshGrid(args);
                GetRadWindow().close();
            }

            function Close() {
                GetRadWindow().Close();
            }

            function onPopUpShowing(sender, args) {
                args.get_popUp().className += " popUpEditForm";
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
            <%--<telerik:AjaxSetting AjaxControlID="btnSearch1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"  LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>--%>
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
                                <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight"
                                   EnableLoadOnDemand="True"  Skin="Telerik" 
                                    OnItemsRequested="cb_project_prm_ItemsRequested"
                                    OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%">
                                </telerik:RadComboBox>                                   
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btnSearch1" runat="server" OnClick="btnSearch1_Click" Text="Filter" Width="95%" Height="25px" 
                             Skin="Material" ForeColor="DeepSkyBlue">
                            </telerik:RadButton>
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
        <div style="width:100%; overflow-y:hidden; min-height:620px; scrollbar-highlight-color:#b6ff00;border-bottom-style:none; border-bottom-color:gainsboro; border-bottom-width:thin;"> 
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="True" ShowFooter="false" PageSize="12" Skin="Silk"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true"
                OnNeedDataSource="RadGrid1_NeedDataSource" 
                OnDeleteCommand="RadGrid1_DeleteCommand" CssClass="RadGrid_ModernBrowsers" 
                OnItemCreated="RadGrid1_ItemCreated"
                OnItemCommand="RadGrid1_ItemCommand" 
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged"
                OnPreRender="RadGrid1_PreRender" 
                OnItemDataBound="RadGrid1_ItemDataBound">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" ></ClientSettings>
                <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px"/>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="NoBuk" Font-Size="12px" Font-Names="Century Gothic"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                    CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" 
                    CommandItemSettings-AddNewRecordText="New" EditFormSettings-EditFormType="Template" InsertItemDisplay="Top">
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                            <HeaderStyle Width="40px"/>
                            <ItemStyle Width="40px" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridDateTimeColumn UniqueName="Tgl" HeaderText="Date" DataField="Tgl" ItemStyle-Width="80px" 
                            EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" ItemStyle-HorizontalAlign="Center"
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="NoBuk" HeaderText="Reg. No" DataField="NoBuk">
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project" DataField="region_code" 
                            FilterControlWidth="60px" >
                            <HeaderStyle Width="60px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <%--<telerik:GridBoundColumn UniqueName="NoCtrl" HeaderText="Ctrl. No" DataField="NoCtrl" 
                            FilterControlWidth="100px" >
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="NoRef" HeaderText="No. Ref" DataField="NoRef" 
                            FilterControlWidth="100px" >
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn UniqueName="KoTrans" HeaderText="Transaction" DataField="KoTransName" 
                            FilterControlWidth="120px" >
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn><telerik:GridBoundColumn UniqueName="Total" HeaderText="Amount" DataField="Total" 
                            FilterControlWidth="85px" DataFormatString="{0:#,###,##0.00}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-ForeColor="#009933">
                            <HeaderStyle Width="85px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="KoBank" HeaderText="Bank Code" DataField="KoBank" ItemStyle-HorizontalAlign="Center" 
                            FilterControlWidth="60px" >
                            <HeaderStyle Width="60px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <%--<telerik:GridBoundColumn UniqueName="cur_code" HeaderText="Curr" DataField="cur_code" 
                            FilterControlWidth="60px" >
                            <HeaderStyle Width="60px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="Kurs" HeaderText="kurs" DataField="Kurs" 
                            FilterControlWidth="70px" DataFormatString="{0:#,###,##0.00}" ItemStyle-HorizontalAlign="Right" 
                            ItemStyle-ForeColor="#009933">
                            <HeaderStyle Width="70px"></HeaderStyle>
                        </telerik:GridBoundColumn>--%>
                        
                        <telerik:GridBoundColumn UniqueName="Kontak" HeaderText="Contact" DataField="Kontak" 
                            FilterControlWidth="190px" >
                            <HeaderStyle Width="190px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="Ket" HeaderText="Remark" DataField="Ket" ItemStyle-Wrap="true"
                            ItemStyle-Width="200px" FilterControlWidth="200px">
                            <HeaderStyle Width="200px"></HeaderStyle>
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
                                                    <td colspan="6" style="padding: 0px 0px 10px 0px; text-align:left">
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
                                                    <td colspan="5">
                                                        <telerik:RadTextBox ID="txt_NoBuk" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight" Skin="Telerik"
                                                            AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.NoBuk") %>' ReadOnly="true">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="5">
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
                                                        <telerik:RadLabel runat="server" Text="Transaction:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="5">
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_KoTrans" runat="server" Width="200"
                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Telerik" AutoPostBack="true" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.KoTransName") %>'
                                                            OnItemsRequested="cb_KoTrans_ItemsRequested" OnPreRender="cb_KoTrans_PreRender"
                                                            OnSelectedIndexChanged="cb_KoTrans_SelectedIndexChanged"
                                                            EnableVirtualScrolling="true" >
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr >
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Bank:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td style="vertical-align:top; text-align:left" colspan="5">                               
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_bank" runat="server" Width="300" DropDownWidth="300px"
                                                            AutoPostBack="true" ShowMoreResultsBox="false" Skin="Telerik" 
                                                            EnableLoadOnDemand ="true" Text='<%# DataBinder.Eval(Container, "DataItem.NamBank") %>'
                                                            OnItemsRequested="cb_bank_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_bank_SelectedIndexChanged" CausesValidation="false"
                                                            OnPreRender="cb_bank_PreRender" >
                                                        </telerik:RadComboBox>                
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Relation:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>                
                                                    <td colspan="5">   
                                                       <%-- <telerik:RadTextBox ID="txt_Kontak" runat="server" Width="345px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                                            AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.Kontak") %>'>
                                                        </telerik:RadTextBox>   --%> 
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Kontak" runat="server" Width="300" DropDownWidth="300px"
                                                            AutoPostBack="true" ShowMoreResultsBox="false" Skin="Telerik" 
                                                            EnableLoadOnDemand ="true" Text='<%# DataBinder.Eval(Container, "DataItem.Kontak") %>'
                                                            OnItemsRequested="cb_Kontak_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_Kontak_SelectedIndexChanged"
                                                            OnPreRender="cb_Kontak_PreRender" >
                                                            <HeaderTemplate>
                                                                <table style="width: 300px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;background-color:#23afad">
                                                                            Vendor / Custumer
                                                                        </td>     
                                                                        <td style="width: 60px;background-color:#23afad">
                                                                            Code
                                                                        </td> 
                                                                        <td style="width: 50px;background-color:#23afad">
                                                                            Currency
                                                                        </td>                                                       
                                                                    </tr>
                                                                </table>                                                       
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                            <table style="width: 300px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 150px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['']")%>
                                                                    </td>
                                                                    <td style="width: 60px;">
                                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                                    </td>
                                                                    <td style="width: 50px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['']")%>
                                                                    </td>                                                                                                                        
                                                                </tr>
                                                            </table>
                                                            </ItemTemplate>
                                                        </telerik:RadComboBox>                              
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="No. Reff:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="5">
                                                        <telerik:RadTextBox ID="txt_NoRef" runat="server" Width="200px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                                            AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.NoRef") %>' ReadOnly="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Currency:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadTextBox ID="txt_cur_code" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight" Skin="Telerik"
                                                            AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.cur_code") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                     <td style="text-align:right; width:60px">
                                                        <telerik:RadLabel runat="server" Text="Kurs:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadNumericTextBox ID="txt_kurs" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                                            AutoPostBack="false" DbValue='<%# DataBinder.Eval(Container, "DataItem.kurs") %>'>
                                                        </telerik:RadNumericTextBox>  
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Tax:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td >                                                 
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax_code" runat="server" Width="200px" DropDownWidth="300px"
                                                            AutoPostBack="true" ShowMoreResultsBox="false" Skin="Telerik" 
                                                            EnableLoadOnDemand ="true" Text='<%# DataBinder.Eval(Container, "DataItem.ppn") %>'
                                                            OnItemsRequested="cb_tax_code_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_tax_code_SelectedIndexChanged" CausesValidation="false"
                                                            OnPreRender="cb_tax_code_PreRender" >
                                                        </telerik:RadComboBox>  
                                                     <td style="text-align:right; width:60px">
                                                        <telerik:RadLabel runat="server" Text="Tax Kurs:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadNumericTextBox ID="txt_tax_kurs" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                                            AutoPostBack="false" DbValue='<%# DataBinder.Eval(Container, "DataItem.kurs") %>'>
                                                        </telerik:RadNumericTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Project:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td style="vertical-align:top; text-align:left" colspan="5">                      
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                                            AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" Skin="Telerik" 
                                                            EnableLoadOnDemand ="true" Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' 
                                                            OnItemsRequested="cb_project_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                                            OnPreRender="cb_project_PreRender" >
                                                        </telerik:RadComboBox>               
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Cost Center:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td style="vertical-align:top; text-align:left" colspan="5">                      
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cost_center" runat="server" Width="300" DropDownWidth="300px"
                                                            AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" Skin="Telerik" 
                                                            EnableLoadOnDemand ="true" Text='<%# DataBinder.Eval(Container, "DataItem.CostCenterName") %>' 
                                                            OnItemsRequested="cb_cost_center_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_cost_center_SelectedIndexChanged"
                                                            OnPreRender="cb_cost_center_PreRender" >
                                                        </telerik:RadComboBox>               
                                                    </td>
                                                </tr>
                                                
                                                
                                            </table>
                                        </td>
                                        <td style="vertical-align: top; padding-left:25px">
                                            <table id="Table3" border="0" class="module">
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
                                                        <telerik:RadLabel runat="server" Text="Remark:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>                
                                                    <td style="vertical-align:top; text-align:left" colspan="5">                               
                                                        <telerik:RadTextBox ID="txt_Ket" 
                                                            runat="server" TextMode="MultiLine" Text='<%# DataBinder.Eval(Container, "DataItem.Ket") %>'
                                                            Width="345px" Rows="0" Columns="100" TabIndex="5" Resize="Both">
                                                        </telerik:RadTextBox>                                  
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td  class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Prepared By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_prepared" runat="server" Width="250px" Height="250px" 
                                                            DropDownWidth="370px" AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select -" Skin="Telerik" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.PreparedBy") %>' 
                                                            EnableLoadOnDemand ="true" 
                                                            OnItemsRequested="cb_prepared_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_prepared_SelectedIndexChanged"
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
                                                </tr>
                                                <tr>
                                                    <td  class="tdLabel"> 
                                                        <telerik:RadLabel runat="server" Text="Checked By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_checked" runat="server" Width="250px" Height="250px" 
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
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Approved By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px" Height="250px" 
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
                                        <td>
                                            <table>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Amount:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox ID="txt_amount" RenderMode="Lightweight" runat="server" Width="120px" ItemStyle-HorizontalAlign="Right" 
                                                        NumberFormat-AllowRounding="true" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" 
                                                        AllowOutOfRangeAutoCorrect="false" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" Skin="Telerik" 
                                                            DbValue='<%# DataBinder.Eval(Container, "DataItem.Dp") %>'
                                                            OnTextChanged="calculate_total">
                                                        </telerik:RadNumericTextBox>  
                                                    </td>
                                                    <td style="text-align:right; width:50px">
                                                        <telerik:RadLabel runat="server" Text="Tax:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox ID="txt_tax_amount" RenderMode="Lightweight" runat="server" Width="80px" ItemStyle-HorizontalAlign="Right" 
                                                        NumberFormat-AllowRounding="true" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" 
                                                        AllowOutOfRangeAutoCorrect="false" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" Skin="Telerik" 
                                                            DbValue='<%# DataBinder.Eval(Container, "DataItem.JPPN") %>'>
                                                        </telerik:RadNumericTextBox>  
                                                    </td>
                                                    <td style="text-align:right; width:70px">
                                                        <telerik:RadLabel runat="server" Text="Total:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox ID="txt_total" RenderMode="Lightweight" runat="server" Width="120px" ItemStyle-HorizontalAlign="Right" 
                                                        NumberFormat-AllowRounding="true" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" 
                                                        AllowOutOfRangeAutoCorrect="false" AutoPostBack="false" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" Skin="Telerik" 
                                                            DbValue='<%# DataBinder.Eval(Container, "DataItem.Total") %>'>
                                                        </telerik:RadNumericTextBox>  
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" style="padding-top:10px; padding-bottom:10px;">
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
    </div>
</asp:Content>
