<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h02.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Cash.CashMutation.acc01h02" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/common.css" rel="stylesheet" />    
    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
            function ShowPreview(id) {
                window.radopen("ReportViewer_acc01h02.aspx?NoBuk=" + id, "PreviewDialog");
                return false;
            }
            function ShowJournal(id) {
                window.radopen("acc01h02journal.aspx?NoBuk=" + id, "PreviewDialog");
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
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl"></nav:FolderNavigationControl> 
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
             <telerik:AjaxSetting AjaxControlID="cb_Cash">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_cur_code" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_kurs" ></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_Project">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_Cash" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel1" />
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

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="450px" Height="350px" VisibleStatusbar="False" AutoSize="True">
        <ContentTemplate>
            <div runat="server" style="padding: 20px 10px 10px 10px;" id="Div2">
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
                                <telerik:RadLabel runat="server" Text="Cash :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                <telerik:RadComboBox ID="cb_CashMutation_prm" runat="server" RenderMode="Lightweight" AutoPostBack="true"
                                    EnableLoadOnDemand="True"  Skin="Telerik" 
                                    OnItemsRequested="cb_CashMutation_prm_ItemsRequested"
                                    OnSelectedIndexChanged="cb_CashMutation_prm_SelectedIndexChanged"
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

    <div class="scroller" runat="server" style="overflow-y:scroll; height:620px;" > 

            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" PageSize="14" Skin="Silk"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers" 
                OnNeedDataSource="RadGrid1_NeedDataSource" 
                OnDeleteCommand="RadGrid1_DeleteCommand" 
                OnItemCreated="RadGrid1_ItemCreated" 
                OnItemCommand="RadGrid1_ItemCommand" 
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" 
                OnPreRender="RadGrid1_PreRender">
                <PagerStyle Mode="NumericPages" />
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
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
                            <HeaderStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="Tanggal" HeaderText="Date" DataField="Tgl" ItemStyle-Width="80px" EnableRangeFiltering="false" FilterControlWidth="80px" 
                            PickerType="DatePicker" DataFormatString="{0:d}">
                            <HeaderStyle Width="80px" />
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="NoCtrl" HeaderText="Ctrl. No" DataField="NoCtrl" FilterControlWidth="120px">
                            <HeaderStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="NoRef" HeaderText="Reg. No" DataField="NoRef" FilterControlWidth="90px">
                            <HeaderStyle Width="90px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="KoTrans" HeaderText="Transaction" DataField="KoTrans" FilterControlWidth="120px">
                            <HeaderStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="KoKas" HeaderText="Cash Code" DataField="KoKas" FilterControlWidth="90px">
                            <HeaderStyle Width="90px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="currency" HeaderText="Currency" DataField="cur_code" FilterControlWidth="120px">
                            <HeaderStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="kurs" HeaderText="Kurs" DataField="kurs" FilterControlWidth="90px">
                            <HeaderStyle Width="90px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="amount" HeaderText="Amount" DataField="Total" FilterControlWidth="120px">
                            <HeaderStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="contact" HeaderText="Contact" DataField="Kontak" FilterControlWidth="90px">
                            <HeaderStyle Width="90px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="keterangan" HeaderText="Remark" DataField="Ket" FilterControlWidth="480px" ItemStyle-Width="450px" ItemStyle-Wrap="true">
                            <HeaderStyle Width="500px" />
                        </telerik:GridBoundColumn>
                        <%--<telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete"  ConfirmText="Are You Sure ?" ConfirmTitle="Delete" 
                            ConfirmDialogType="RadWindow" ButtonType="FontIconButton"></telerik:GridButtonColumn>   --%>   
                        <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Right"
                            AllowFiltering="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" ItemStyle-ForeColor="Red"
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
                                                    Reg No:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_NoBuk" runat="server" Width="180px" Enabled="false" RenderMode="Lightweight" Skin="Telerik"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.NoBuk") %>' >
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    Date:
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtp_date"  runat="server" MinDate="1/1/1900" Width="180px" RenderMode="Lightweight"
                                                        TabIndex="4" Skin="Telerik" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.Tgl") %>'> 
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                            <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                                        </DateInput>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    No. Ctrl:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_NoCtrl" runat="server" Width="180px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.NoCtrl") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    No. Ref:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_NoRef" runat="server" Width="180px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.NoRef") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    Transaction:
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_KoTrans" runat="server" Width="180px"
                                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Telerik" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.KoTrans") %>'
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
                                                    Project Area:
                                                </td>
                                                <td style="vertical-align:top; text-align:left">                      
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Project" runat="server" Width="300" DropDownWidth="300px"
                                                        AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select a Project -" Skin="Telerik" 
                                                        EnableLoadOnDemand="true" Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' 
                                                        OnItemsRequested="cb_Project_ItemsRequested" OnSelectedIndexChanged="cb_Project_SelectedIndexChanged" 
                                                        OnPreRender="cb_Project_PreRender" >
                                                    </telerik:RadComboBox>               
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    Cash:
                                                </td>
                                                <td style="vertical-align:top; text-align:left">                  
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Cash" runat="server" Width="300" DropDownWidth="300px"
                                                        AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select a Cash -" Skin="Telerik" CausesValidation="false"  
                                                        EnableLoadOnDemand="true" Text='<%# DataBinder.Eval(Container, "DataItem.NamKas") %>'
                                                        OnItemsRequested="cb_Cash_ItemsRequested"
                                                        OnSelectedIndexChanged="cb_Cash_SelectedIndexChanged" 
                                                        OnPreRender="cb_Cash_PreRender">
                                                    </telerik:RadComboBox>            
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    Currency:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_cur_code" runat="server" Width="80px" ReadOnly="true" RenderMode="Lightweight"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.cur_code") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    Kurs:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_kurs" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.kurs") %>' >
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    From/To:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_fromto" runat="server" Width="250px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                                        AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.Kontak") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    Remark:
                                                </td>
                                                <td style="vertical-align:top; text-align:left">
                                                    <telerik:RadTextBox ID="txt_remark"  Skin="Telerik"
                                                        runat="server" TextMode="MultiLine" Text='<%# DataBinder.Eval(Container, "DataItem.Ket") %>'
                                                        Width="300px" Rows="0" Columns="100" TabIndex="5" Resize="Both">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>                   
                                        </table>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td >
                                                    Prepared By:
                                                </td>
                                                <td style="vertical-align:top; text-align:left">
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Prepared" runat="server" Width="250px" DropDownWidth="500px"
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select -" Skin="Telerik" 
                                                        EnableLoadOnDemand="true"  Text='<%# DataBinder.Eval(Container, "DataItem.freby") %>'
                                                        HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"    
                                                        OnItemsRequested="cb_Prepared_ItemsRequested" OnSelectedIndexChanged="cb_Prepared_SelectedIndexChanged" 
                                                        OnPreRender="cb_Prepared_PreRender"  >
                                                        <HeaderTemplate>
                                                            <table style="width: 550px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 250px;">
                                                                        Name
                                                                    </td>
                                                                    <td style="width: 300px;">
                                                                        Position
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 550px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 250px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                    </td>
                                                                    <td style="width: 300px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Checked By:
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Checked" runat="server" Width="250px" DropDownWidth="500px"
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select -" Skin="Telerik" 
                                                        EnableLoadOnDemand="true" Text='<%# DataBinder.Eval(Container, "DataItem.ordby") %>' 
                                                        HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                        OnItemsRequested="cb_Checked_ItemsRequested" OnSelectedIndexChanged="cb_Checked_SelectedIndexChanged"
                                                        OnPreRender="cb_Checked_PreRender" >
                                                        <HeaderTemplate>
                                                            <table style="width: 550px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 250px;">
                                                                        Name
                                                                    </td>
                                                                    <td style="width: 300px;">
                                                                        Position
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 550px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 250px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                    </td>
                                                                    <td style="width: 300px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Aproval By:
                                                </td>     
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Approval" runat="server" Width="250px" DropDownWidth="500px"
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select -" Skin="Telerik" 
                                                        EnableLoadOnDemand="true" Text='<%# DataBinder.Eval(Container, "DataItem.appby") %>' 
                                                        HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                                        OnItemsRequested="cb_Approval_ItemsRequested" OnSelectedIndexChanged="cb_Approval_SelectedIndexChanged" 
                                                        OnPreRender="cb_Approval_PreRender" >
                                                        <HeaderTemplate>
                                                            <table style="width: 550px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 250px;">
                                                                        Name
                                                                    </td>
                                                                    <td style="width: 300px;">
                                                                        Position
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 550px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 250px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                    </td>
                                                                    <td style="width: 300px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
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
                                                <td style="padding-left:15px"> Last Update : </td>\
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

                            <div style="padding: 15px 0px 5px 0px; height:288px">  
                                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" runat="server" AllowPaging="False" ShowFooter="false" PageSize="5" Skin="Silk"
                                    AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers"  
                                    OnNeedDataSource="RadGrid2_NeedDataSource"
                                    OnInsertCommand="RadGrid2_InsertCommand" 
                                    OnUpdateCommand="RadGrid2_UpdateCommand" 
                                    OnDeleteCommand="RadGrid2_DeleteCommand" OnItemCommand="RadGrid2_ItemCommand" OnPreRender="RadGrid2_PreRender" 
                                    ClientSettings-Selecting-AllowRowSelect="true" >
                                    <HeaderStyle Font-Size="11px" />
                                    <PagerStyle Mode="NumericPages" />
                                    <MasterTableView CommandItemDisplay="Top" DataKeyNames="NoBuk,KoRek" Font-Size="11px" EditMode="InPlace"
                                        ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" InsertItemDisplay="Bottom">
                                        <CommandItemSettings ShowRefreshButton="false" ShowSaveChangesButton="false" />
                                        <Columns>
                                            <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                                HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update" ItemStyle-Width="60px">
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridTemplateColumn UniqueName="KoRek" HeaderText="Account No." ItemStyle-Width="120px" 
                                                SortExpression="KoRek" HeaderStyle-Width="100px" >
                                                    <FooterTemplate>Template footer</FooterTemplate>
                                                    <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                                    <ItemTemplate>  
                                                        <asp:Label ID="lbl_korek" Width="120px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "KoRek")%>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>                                       
                                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_KoRek" EnableLoadOnDemand="True" AutoPostBack="true" 
                                                            OnItemsRequested="cb_KoRek_ItemsRequested" DataValueField="KoRek" DataTextField="accountname"  HeaderStyle-HorizontalAlign="Center"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.KoRek") %>'
                                                            HighlightTemplatedItems="true" Height="190px" Width="120px" DropDownWidth="450px" 
                                                            OnPreRender="cb_KoRek_PreRender" OnSelectedIndexChanged="cb_KoRek_SelectedIndexChanged">
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
                                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_KoRek_insert" EnableLoadOnDemand="True" AutoPostBack="true" 
                                                            OnItemsRequested="cb_KoRek_ItemsRequested" DataValueField="KoRek" DataTextField="accountname"  HeaderStyle-HorizontalAlign="Center"
                                                            HighlightTemplatedItems="true" Height="190px" Width="120px" DropDownWidth="450px" 
                                                            OnPreRender="cb_KoRek_PreRender" OnSelectedIndexChanged="cb_KoRek_SelectedIndexChanged">
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
                                            <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="350px"  HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px">
                                                <ItemTemplate>  
                                                    <asp:Label ID="lbl_KetD" Width="350px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Ket") %>' ></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_KetD" Width="350px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Ket") %>'>
                                                    </telerik:RadTextBox>                                                 
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_KetD_insert" Width="350px"></telerik:RadTextBox> 
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="D/C" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" 
                                                HeaderStyle-Width="50px">
                                                <ItemTemplate>  
                                                    <asp:Label ID="lbl_mutasiD" Width="50px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Mutasi")%>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Mutasi" DropDownWidth="50px" AutoPostBack="false"    
                                                        EnableLoadOnDemand="true" Skin="Telerik" DataValueField="Mutasi" DataTextField="name" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Mutasi") %>' 
                                                        OnItemsRequested="cb_Mutasi_ItemsRequested" OnSelectedIndexChanged="cb_Mutasi_SelectedIndexChanged" OnPreRender="cb_Mutasi_PreRender">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Mutasi_insert" DropDownWidth="50px"   
                                                    EnableLoadOnDemand="true" Skin="Telerik" DataValueField="Mutasi" DataTextField="name" AutoPostBack="false"  
                                                    OnItemsRequested="cb_Mutasi_ItemsRequested" OnSelectedIndexChanged="cb_Mutasi_SelectedIndexChanged" OnPreRender="cb_Mutasi_PreRender">
                                                </telerik:RadComboBox>
                                            </InsertItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Kurs" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right"  HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                            <ItemTemplate>  
                                                <asp:Label ID="lbl_kursD" Width="100px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "kurs","{0:#,###,###0.00000000}")%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox ID="txt_kursD" runat="server" Width="100px" Enabled="true" RenderMode="Lightweight"
                                                    AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.kurs") %>' >
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <telerik:RadTextBox ID="txt_kursD_insert" runat="server" Width="100px" Enabled="true" RenderMode="Lightweight"
                                                    AutoPostBack="false" >
                                                </telerik:RadTextBox>
                                            </InsertItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Amount" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right"  HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                            <ItemTemplate>  
                                                <asp:Label ID="lbl_amount" Width="120px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Jumlah","{0:#,###,###0.00000000}")%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_amount" Width="120px" Text='<%# DataBinder.Eval(Container, "DataItem.Jumlah","{0:#,###,###0.00}") %>'>
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_amount_insert" Width="120px" >
                                                </telerik:RadTextBox>
                                            </InsertItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="region_code" HeaderText="Project" HeaderStyle-Width="100px"  HeaderStyle-HorizontalAlign="Center"
                                            SortExpression="region_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                            <FooterTemplate>Template footer</FooterTemplate>
                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_ProjectD" Width="100px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.region_code") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>   
                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Project_Detail" DropDownWidth="350px" 
                                                    EnableLoadOnDemand="True" Skin="Telerik" DataValueField="region_code" DataTextField="region_name" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.region_code") %>' OnItemsRequested="cb_Project_Detail_ItemsRequested" 
                                                    OnSelectedIndexChanged="cb_Project_Detail_SelectedIndexChanged" OnPreRender="cb_Project_Detail_PreRender" Height="190px" Width="100px" 
                                                    AutoPostBack="True">
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
                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Project_Detail_insert" DropDownWidth="350px" 
                                                    EnableLoadOnDemand="True" Skin="Telerik" DataValueField="region_code" DataTextField="region_name" 
                                                    OnItemsRequested="cb_Project_Detail_ItemsRequested" 
                                                    OnSelectedIndexChanged="cb_Project_Detail_SelectedIndexChanged" OnPreRender="cb_Project_Detail_PreRender" Height="190px" Width="100px" 
                                                    AutoPostBack="True">
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
                                        <telerik:GridTemplateColumn UniqueName="dept_code" HeaderText="Cost Center" HeaderStyle-Width="100px"  HeaderStyle-HorizontalAlign="Center"
                                            SortExpression="dept_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                            <FooterTemplate>Template footer</FooterTemplate>
                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                            <ItemTemplate>  
                                                <asp:Label ID="lbl_CostCntrD" Width="100px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "dept_code")%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Cost_Center" DropDownWidth="350px" AutoPostBack="false"  
                                                    EnableLoadOnDemand="True" Skin="Telerik" DataValueField="code" DataTextField="name" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>' OnItemsRequested="cb_Cost_Center_ItemsRequested"  
                                                    OnSelectedIndexChanged="cb_Cost_Center_SelectedIndexChanged"
                                                    OnPreRender="cb_Cost_Center_PreRender" Height="190px" Width="100px" >
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
                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Cost_Center_insert" DropDownWidth="350px" AutoPostBack="false"  
                                                    EnableLoadOnDemand="True" Skin="Telerik" DataValueField="code" DataTextField="name"  
                                                    OnItemsRequested="cb_Cost_Center_ItemsRequested" 
                                                    OnPreRender="cb_Cost_Center_PreRender" Height="190px" Width="100px" >
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
