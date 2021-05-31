<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h07.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Ledger.GeneralJournal.acc01h07" %>
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
                window.radopen("reportViewer_acc01h07.aspx?voucherno=" + id, "PreviewDialog");
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
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_Project" >
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID ="cb_Cost_Center" LoadingPanelID="RadAjaxLoadingPanel1" />
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
                        <td>
                            <telerik:RadLabel runat="server" Text="Date From :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik" DateInput-CausesValidation="false"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                        <td>
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
                                    <telerik:RadLabel runat="server" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Width="95%" Height="25px" Text="-- Search --" 
                                        Skin="Material" ForeColor="DeepSkyBlue" />
                                    <%--&nbsp
                                    <telerik:RadLabel runat="server" Text="Select & Close :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                    <asp:Button ID="btnOK" runat="server" OnClick="btnOK_Click" Width="95%" Height="25px" 
                                        Skin="Material" ForeColor="DeepSkyBlue" />--%>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>                
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>
                <td  style="vertical-align: bottom; margin-left: 0px; padding: 0px 0px 0px 0px;">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter" 
                        Height="29px" Width="30px" ImageUrl="~/Images/search.png" >                            
                    </asp:ImageButton>                                                 
                </td>
                <td style="vertical-align: bottom; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click" ToolTip="Add New" Visible="true"
                        Height="26px" Width="27px" ImageUrl="~/Images/tambah.png" ImageAlign="Bottom">
                    </asp:ImageButton>
                </td>
                <%--<td style="vertical-align:middle; margin-left:10px;padding-left:13px">
                    <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" OnClick="btnSave_Click"
                        Height="30px" Width="32px" ImageUrl="~/Images/simpan-gray.png">
                    </asp:ImageButton>
                </td>
                <td style="vertical-align:middle; margin-left:10px;padding-left:13px">
                    <asp:ImageButton runat="server" ID="btnPrint" AlternateText="Print"
                        Height="30px" Width="32px" ImageUrl="~/Images/cetak-gray.png">
                    </asp:ImageButton>
                </td>--%>
                <td style="width: 96%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight:normal; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#0099dc;">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

    <div class="scroller" runat="server" style="overflow-y:scroll; height:620px;">
        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" PageSize="14" Skin="Silk"
            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers" 
            OnNeedDataSource="RadGrid1_NeedDataSource" 
            OnDeleteCommand="RadGrid1_DeleteCommand" 
            OnItemCreated="RadGrid1_ItemCreated" 
            OnItemCommand="RadGrid1_ItemCommand" 
            OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" 
            OnPreRender="RadGrid1_PreRender">
            <PagerStyle Mode="NumericPages" />
            <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true"></ClientSettings>
            <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px" />
            <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="ju_code" Font-Size="11px" Font-Names="Century Gothic"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" 
                CommandItemSettings-AddNewRecordText="New" EditFormSettings-EditFormType="Template" InsertItemDisplay="Top">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="40px"/>
                        <ItemStyle Width="40px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn UniqueName="ju_code" HeaderText="JU Number" DataField="ju_code" FilterControlWidth="100px">
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="ref_code" HeaderText="Reference" DataField="ref_code" FilterControlWidth="110px">
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn UniqueName="ju_date" HeaderText="Date" DataField="ju_date" ItemStyle-Width="100px" EnableRangeFiltering="false" FilterControlWidth="100px" 
                        PickerType="DatePicker" DataFormatString="{0:d}">
                        <HeaderStyle Width="100px" />
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn UniqueName="cur_code" HeaderText="Currency" DataField="cur_code" FilterControlWidth="50px" ItemStyle-HorizontalAlign="Center">
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="kurs" HeaderText="Kurs" DataField="kurs" FilterControlWidth="100px" ItemStyle-HorizontalAlign="Right">
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="amount" HeaderText="Amount" DataField="debet" FilterControlWidth="80px">
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="user" HeaderText="User" DataField="userid" FilterControlWidth="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
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
                                <tr style="vertical-align: top">
                                    <td style="vertical-align: top">
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
                                                    JU Number:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_ju_code" runat="server" Width="180px" ReadOnly="true" RenderMode="Lightweight"
                                                        Skin="Telerik" AutoPostBack="false" EmptyMessage="Let it blank" Text='<%# DataBinder.Eval(Container, "DataItem.ju_code") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    Ref. No:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_ref" runat="server" Width="180px" Enabled="true" RenderMode="Lightweight"
                                                        Skin="Telerik" AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.ref_code") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    Ctrl. No:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_ctrl" runat="server" Width="180px" Enabled="true" RenderMode="Lightweight"
                                                        Skin="Telerik" AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.ctrl_no") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>                           
                                        </table>
                                    </td>
                                    <td style="vertical-align: top; padding-left:15px">
                                        <table id="Table3" border="0" class="module">
                                            <tr>
                                                <td class="tdLabel">
                                                    Date:
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtp_bm"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                        TabIndex="4" Skin="Telerik" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.ju_date") %>'> 
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro"></Calendar>
                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
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
                                                    Currency:
                                                </td>
                                                <td style="vertical-align:top; text-align:left">                      
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_currency" runat="server" Width="150px" DropDownWidth="300px" Skin="Telerik" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.cur_code") %>' ShowMoreResultsBox="false" EmptyMessage="- Select a Currency -" 
                                                        EnableLoadOnDemand="true" Enabled="true" OnItemsRequested="cb_currency_ItemsRequested" OnSelectedIndexChanged="cb_currency_SelectedIndexChanged" 
                                                        AutoPostBack="true" OnPreRender="cb_currency_PreRender">
                                                    </telerik:RadComboBox>               
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    Kurs:
                                                </td>
                                                <td>
                                                    <telerik:RadNumericTextBox ID="txt_kurs" runat="server" Width="111px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik" 
                                                        DbValue='<%# DataBinder.Eval(Container, "DataItem.kurs" ) %>' NumberFormat-DecimalDigits="9" NumberFormat-DecimalSeparator="." >
                                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="vertical-align: top; padding-left:15px">
                                        <table id="Table3" border="0" class="module">
                                            <tr>
                                                <td class="tdLabel">
                                                    User:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_user" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight"
                                                        Skin="Telerik" AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.userid") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    Last Update:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_lastupdate" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight"
                                                        Skin="Telerik" AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.lastupdate") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr></tr>
                                            <tr></tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <div style="padding: 7px 0px 12px 0px; height:288px">
                                <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>--%>
                                        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" runat="server" AllowPaging="False" ShowFooter="false" PageSize="5" Skin="Silk"
                                            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers" 
                                            OnNeedDataSource="RadGrid2_NeedDataSource" 
                                            OnDeleteCommand="RadGrid2_DeleteCommand" 
                                            OnInsertCommand="RadGrid2_InsertCommand" 
                                            OnUpdateCommand="RadGrid2_UpdateCommand" 
                                            OnItemCommand="RadGrid2_ItemCommand" 
                                            OnPreRender="RadGrid2_PreRender"> 
                                            <HeaderStyle Font-Size="12px" />
                                            <PagerStyle Mode="NumericPages" />
                                            <MasterTableView CommandItemDisplay="Top" DataKeyNames="voucherno,accountno" Font-Size="11px" EditMode="InPlace"
                                                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" InsertItemDisplay="Bottom">
                                                <CommandItemSettings ShowRefreshButton="false" ShowSaveChangesButton="false" />
                                                <Columns>
                                                    <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                                        HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update" ItemStyle-Width="60px">
                                                    </telerik:GridEditCommandColumn>

                                                    <telerik:GridTemplateColumn UniqueName="accountno" HeaderText="Account No." ItemStyle-Width="120px" HeaderStyle-Width="120px" 
                                                        SortExpression="KoRek" HeaderStyle-HorizontalAlign="Center">
                                                        <FooterTemplate>Template footer</FooterTemplate>
                                                        <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbl_accountno" Width="120px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "accountno")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_account" EnableLoadOnDemand="True" AutoPostBack="true" 
                                                                OnItemsRequested="cb_account_ItemsRequested" DataValueField="accountno" DataTextField="accountname"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.accountno") %>'
                                                                HighlightTemplatedItems="true" Height="190px" Width="120px" DropDownWidth="500px" 
                                                                OnPreRender="cb_account_PreRender" OnSelectedIndexChanged="cb_account_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 400px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Code
                                                                            </td>
                                                                            <td style="width: 300px;">
                                                                                Name
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 400px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 15100px;">
                                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                                            </td>
                                                                            <td style="width: 300px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['accountname']")%>
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
                                                        </EditItemTemplate>
                                                        <InsertItemTemplate>
                                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_account_Insert" EnableLoadOnDemand="True" AutoPostBack="true" 
                                                                OnItemsRequested="cb_account_ItemsRequested" DataValueField="accountno" DataTextField="accountname"
                                                                HighlightTemplatedItems="true" Height="190px" Width="120px" DropDownWidth="500px" 
                                                                OnPreRender="cb_account_PreRender" OnSelectedIndexChanged="cb_account_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 400px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Code
                                                                            </td>
                                                                            <td style="width: 300px;">
                                                                                Name
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 400px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 15100px;">
                                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                                            </td>
                                                                            <td style="width: 300px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['accountname']")%>
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
                                                        </InsertItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="280px" HeaderStyle-Width="280px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>  
                                                            <asp:Label ID="lbl_remark" Width="280px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "remark")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark" Width="280px" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                                            </telerik:RadTextBox>                                                 
                                                        </EditItemTemplate>
                                                        <InsertItemTemplate>
                                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_Insert" Width="280px"></telerik:RadTextBox>
                                                        </InsertItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Currency" ItemStyle-Width="50px" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>  
                                                           <asp:Label ID="lbl_currency" Width="50px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "cur_code")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_currency_d" DropDownWidth="100px" AutoPostBack="false"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.cur_code") %>'   
                                                                EnableLoadOnDemand="true" Skin="MetroTouch" DataValueField="cur_code" DataTextField="cur_name" 
                                                                OnItemsRequested="cb_currency_d_ItemsRequested" OnPreRender="cb_currency_d_PreRender" OnSelectedIndexChanged="cb_currency_d_SelectedIndexChanged">
                                                            </telerik:RadComboBox>                                                                                
                                                        </EditItemTemplate>
                                                        <InsertItemTemplate>
                                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_currency_d_Insert" DropDownWidth="100px" AutoPostBack="false"   
                                                                EnableLoadOnDemand="true" Skin="MetroTouch" DataValueField="cur_code" DataTextField="cur_name" 
                                                                OnItemsRequested="cb_currency_d_ItemsRequested" OnPreRender="cb_currency_d_PreRender" OnSelectedIndexChanged="cb_currency_d_SelectedIndexChanged">
                                                            </telerik:RadComboBox>
                                                        </InsertItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Debet" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>  
                                                            <asp:Label ID="lbl_debet" Width="100px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.debet", "{0:#,###,###0.00}") %>' ></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadNumericTextBox ID="txt_debet" runat="server" Width="100px" Enabled="true" RenderMode="Lightweight"
                                                                AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.debet", "{0:#,###,###0.00}") %>' NumberFormat-AllowRounding="true"  
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                                ReadOnly="false" onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2"
                                                                EnabledStyle-HorizontalAlign="Right" >
                                                            </telerik:RadNumericTextBox>
                                                        </EditItemTemplate>
                                                        <InsertItemTemplate>
                                                            <telerik:RadNumericTextBox ID="txt_debet_Insert" runat="server" Width="100px" Enabled="true" RenderMode="Lightweight" AutoPostBack="false" 
                                                                NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                                ReadOnly="false" onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2"
                                                                EnabledStyle-HorizontalAlign="Right"></telerik:RadNumericTextBox>
                                                        </InsertItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Credit" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>  
                                                           <asp:Label ID="lbl_credit" Width="120px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "credit", "{0:#,###,###0.00}")%>' ></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                           <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_credit" Width="100px" Enabled="true" AutoPostBack="false"  
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.credit", "{0:#,###,###0.00}") %>' NumberFormat-AllowRounding="true"  
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                                ReadOnly="false" onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2"
                                                                EnabledStyle-HorizontalAlign="Right">
                                                           </telerik:RadNumericTextBox>
                                                        </EditItemTemplate>
                                                        <InsertItemTemplate>
                                                           <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_credit_Insert" Width="100px" Enabled="true" AutoPostBack="false"  
                                                                NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                                ReadOnly="false" onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2"
                                                                EnabledStyle-HorizontalAlign="Right">
                                                           </telerik:RadNumericTextBox>
                                                        </InsertItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Debet IDR" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>  
                                                            <asp:Label ID="lbl_debet_idr" Width="100px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.debet_idr", "{0:#,###,###0.00}") %>' ></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_debet_idr" Width="100px" Enabled="true" AutoPostBack="false" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.debet_idr", "{0:#,###,###0.00}") %>' NumberFormat-AllowRounding="true"  
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                                ReadOnly="false" onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2"
                                                                EnabledStyle-HorizontalAlign="Right">
                                                            </telerik:RadNumericTextBox>
                                                        </EditItemTemplate>
                                                        <InsertItemTemplate>
                                                            <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_debet_idr_Insert" Width="100px" Enabled="true" AutoPostBack="false" 
                                                                NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                                ReadOnly="false" onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2"
                                                                EnabledStyle-HorizontalAlign="Right">
                                                            </telerik:RadNumericTextBox>
                                                        </InsertItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Credit IDR" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>  
                                                            <asp:Label ID="lbl_credit_idr" Width="100px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.credit_idr", "{0:#,###,###0.00}") %>' ></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_credit_idr" Width="100px" Enabled="true" AutoPostBack="false" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.credit_idr", "{0:#,###,###0.00}") %>' NumberFormat-AllowRounding="true"  
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                                ReadOnly="false" onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2"
                                                                EnabledStyle-HorizontalAlign="Right">
                                                            </telerik:RadNumericTextBox>
                                                        </EditItemTemplate>
                                                        <InsertItemTemplate>
                                                            <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_credit_idr_Insert" Width="100px" Enabled="true" AutoPostBack="false" 
                                                                NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                                ReadOnly="false" onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2"
                                                                EnabledStyle-HorizontalAlign="Right">
                                                            </telerik:RadNumericTextBox>
                                                        </InsertItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn UniqueName="region_code" HeaderText="Project" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center"
                                                        SortExpression="region_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                                        <FooterTemplate>Template footer</FooterTemplate>
                                                        <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbl_region" Width="100px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.region_code") %>' ></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Project" DropDownWidth="350px" EnableLoadOnDemand="True" Skin="MetroTouch" DataValueField="region_code" 
                                                                DataTextField="region_name" Text='<%# DataBinder.Eval(Container, "DataItem.region_code") %>' OnItemsRequested="cb_Project_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_Project_SelectedIndexChanged" OnPreRender="cb_Project_PreRender" Height="190px" Width="100px" AutoPostBack="True">
                                                                <HeaderTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">

                                                                                Code
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                Name
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['region_name']")%>
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>                                                                
                                                                </ItemTemplate>                                                    
                                                            </telerik:RadComboBox> 
                                                        </EditItemTemplate>
                                                        <InsertItemTemplate>
                                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Project_Insert" DropDownWidth="350px" EnableLoadOnDemand="True" Skin="MetroTouch" 
                                                                DataValueField="region_code" DataTextField="region_name" OnItemsRequested="cb_Project_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_Project_SelectedIndexChanged" OnPreRender="cb_Project_PreRender" Height="190px" Width="100px" AutoPostBack="True">
                                                                <HeaderTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">

                                                                                Code
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                Name
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['region_name']")%>
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>                                                                
                                                                </ItemTemplate>                                                    
                                                            </telerik:RadComboBox>
                                                        </InsertItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn UniqueName="dept_code" HeaderText="Cost Center" HeaderStyle-Width="100px" SortExpression="dept_code" ItemStyle-Width="100px" 
                                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                        <FooterTemplate>Template footer</FooterTemplate>
                                                        <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                                        <ItemTemplate>  
                                                            <asp:Label ID="lbl_dept" Width="100px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>' ></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Cost_Center" DropDownWidth="350px" AutoPostBack="true" EnableLoadOnDemand="True" Skin="Silk" 
                                                                DataValueField="code" DataTextField="name" Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>' 
                                                                OnItemsRequested="cb_Cost_Center_ItemsRequested" HighlightTemplatedItems="true" CausesValidation="false" 
                                                                OnPreRender="cb_Cost_Center_PreRender" OnSelectedIndexChanged="cb_Cost_Center_SelectedIndexChanged" Height="190px" Width="100px">
                                                                <HeaderTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Code
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                Name
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['name']")%>
                                                                            </td> 
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </EditItemTemplate>
                                                        <InsertItemTemplate>
                                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Cost_Center_Insert" DropDownWidth="350px" AutoPostBack="true"  
                                                                EnableLoadOnDemand="True" Skin="MetroTouch" DataValueField="code" DataTextField="name" HighlightTemplatedItems="true" CausesValidation="false"  
                                                                OnItemsRequested="cb_Cost_Center_ItemsRequested" OnPreRender="cb_Cost_Center_PreRender" Height="190px" Width="100px">
                                                                <HeaderTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Code
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                Name
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['name']")%>
                                                                            </td> 
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </InsertItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                                        ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                                    </telerik:GridButtonColumn>
                                                </Columns>
                                            </MasterTableView>
                                            <ClientSettings>
                                                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="199" />
                                                <ClientEvents OnRowDblClick="rowDblClick"/>
                                            </ClientSettings>
                                        </telerik:RadGrid>
                                    <%--</ContentTemplate>
                                </asp:UpdatePanel>--%>
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


        <%--<script type="text/javascript">
    //<![CDATA[
        Sys.Application.add_load(function() {
            $windowContentDemo.contentTemplateID = "<%=RadWindow_ContentTemplate.ClientID%>";
            $windowContentDemo.templateWindowID = "<%=RadWindow_ContentTemplate.ClientID %>";
        });
    //]]>
    </script>--%>

</asp:Content>
        

        
       
