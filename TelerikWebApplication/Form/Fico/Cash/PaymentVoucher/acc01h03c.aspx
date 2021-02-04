<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h03c.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Cash.PaymentVoucher.acc01h03c" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server" >
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
            function ShowPreview(id) {
                window.radopen("ReportViewer_acc01h03c.aspx?slip_no=" + id, "PreviewDialog");
                return false;
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
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
             
        </AjaxSettings>
    </telerik:RadAjaxManager>

     <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None">
        <img alt="Loading..." src="../../../../Images/loading.gif" style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>
   
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone" Modal="true" Width="1110px" Height="580px">
        <ContentTemplate>
            <div runat="server" style="padding:20px 10px 10px 10px;" id="searchParam">
                <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="Date From" Height="26px"></telerik:RadDatePicker>
                <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="To Date" Height="26px"></telerik:RadDatePicker>
                <telerik:RadComboBox ID="cb_Cash_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="Cash" AutoPostBack="false" 
                    EnableLoadOnDemand="true" Skin="Telerik" Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" 
                    EnableVirtualScrolling="true" OnItemsRequested="cb_Cash_prm_ItemsRequested" OnSelectedIndexChanged="cb_Cash_prm_SelectedIndexChanged">
                </telerik:RadComboBox>
                &nbsp
                <asp:Button ID="btnSearch" runat="server" Text="Retrieve" OnClick="btnSearch_Click" />
                <asp:Button ID="btnOK" runat="server" Text="Select & Close" OnClick="btnOK_Click" />
            </div>

            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik" AllowSorting="true" AutoGenerateColumns="false" 
                ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="10" OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="slip_no" Font-Size="12px" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" 
                    CommandItemSettings-ShowAddNewRecordButton="false" CommandItemSettings-ShowRefreshButton="false">
                    <Columns>
                        <telerik:GridBoundColumn UniqueName="slip_no" HeaderText="Reg. No" DataField="slip_no">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="cashbank" HeaderText="Cash Code" DataField="cashbank">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="noctrl" HeaderText="Ctrl. No" DataField="noctrl">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="slip_date" HeaderText="Date" DataField="slip_date" ItemStyle-Width="80px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="cust_code" HeaderText="Supplier" DataField="cust_code">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="currency" HeaderText="Currency" DataField="cur_code" FilterControlWidth="120px">
                            <HeaderStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="kurs" HeaderText="Kurs" DataField="kurs" FilterControlWidth="90px">
                            <HeaderStyle Width="90px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="tot_pay" HeaderText="Total Amount" DataField="tot_pay" FilterControlWidth="120px">
                            <HeaderStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="remark1" HeaderText="Remark" DataField="remark1" ItemStyle-Wrap="true"
                                ItemStyle-Width="650px" FilterControlWidth="480px">
                            <HeaderStyle Width="650px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" HeaderText="Delete"
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                        </telerik:GridButtonColumn>
                    </Columns>
                </MasterTableView>
                <ClientSettings>
                    <Selecting AllowRowSelect="true"></Selecting>
                </ClientSettings>
            </telerik:RadGrid>
        </ContentTemplate>
    </telerik:RadWindow>

    <div id="div1" class="scroller" runat="server">
       <%-- <div style="padding-left:15px;width:100%;border-bottom-color:#FF6600;border-bottom-width:1px;border-bottom-style:inset;">
            <table id="tbl_control">
                <tr>
                    <td  style="text-align:right;vertical-align:middle;">
                        <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                            Height="30px" Width="35px" ImageUrl="~/Images/daftar.png" >                            
                        </asp:ImageButton>                                                 
                    </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:8px">
                        <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/tambah.png">
                        </asp:ImageButton>
                    </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:13px">
                        <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" OnClick="btnSave_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/simpan-gray.png">
                        </asp:ImageButton>
                    </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:13px">
                        <asp:ImageButton runat="server" ID="btnPrint" AlternateText="Print" OnClick="btnPrint_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/cetak-gray.png">
                        </asp:ImageButton>
                    </td>
                    <td style="width:89%; text-align:right">
                        <telerik:RadLabel ID="lbl_form_name" Text="Cash Payment" runat="server" style="font-weight:lighter; 
                            font-size:10px; font-variant: small-caps; padding-left:10px; 
                        padding-bottom:0px; font-size:x-large; color:Highlight"></telerik:RadLabel>
                    </td>
                </tr>
            </table>
        </div>--%>
        <div style=" padding-left:15px; width:100%; border-bottom-color: #FF6600; border-bottom-width: 1px; border-bottom-style: inset;background-color:#e2e6e6;">
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
                    <td style="width: 89%; text-align: right">
                        <telerik:RadLabel ID="RadLabel1" runat="server" Text="Cash Payment Voucher" 
                            Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                            padding-bottom: 0px; font-size: x-large; color:#7cca05;">
                        </telerik:RadLabel>
                    </td>
                </tr>
            </table>
        </div>
        <div class="table_trx">
            <table id="Table1" border="0">
                <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module">
                            <tr>
                                <td class="tdLabel">
                                    Reg No:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_slip_no" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_bm"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Metro"> 
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
                                    &nbsp
                                    <telerik:RadTextBox ID="txt_NoCtrl" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false" Label="Ctrl. No">
                                    </telerik:RadTextBox>
                                </td>                               
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Supplier:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="308px" Enabled="true" AutoPostBack="true"
                                        OnItemsRequested="cb_supplier_ItemsRequested" OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged" OnPreRender="cb_supplier_PreRender"
                                        Skin="Telerik" EnableLoadOnDemand="true" EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Currency:
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_CurCode" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight"
                                                AutoPostBack="false">
                                            </telerik:RadTextBox>
                                            &nbsp
                                            <telerik:RadTextBox ID="txt_kurs" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight"
                                                AutoPostBack="false" Label="Kurs:">
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_cash" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>                                    
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Reference:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ref" runat="server" Width="308px" Enabled="false" 
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" Skin="Telerik" EnableVirtualScrolling="true" 
                                        OnItemsRequested="cb_ref_ItemsRequested" OnSelectedIndexChanged="cb_ref_SelectedIndexChanged" OnPreRender="cb_ref_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Cash:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cash" runat="server" Width="308px" Enabled="true" AutoPostBack="true" 
                                        OnItemsRequested="cb_cash_ItemsRequested" OnSelectedIndexChanged="cb_cash_SelectedIndexChanged" OnPreRender="cb_cash_PreRender"
                                        Skin="Telerik" EnableLoadOnDemand="true" EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true"  >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Currency:
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_CurCode2" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight"
                                                AutoPostBack="false">
                                            </telerik:RadTextBox>
                                             &nbsp
                                            <telerik:RadTextBox ID="txt_kurs2" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight"
                                                AutoPostBack="false" Label="Kurs:">
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_cash" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>                                    
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align: top; padding-left:15px">
                        <table id="Table3" border="0" class="module">
                            <tr>
                                <td class="tdLabel">
                                    Remark:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadTextBox ID="txt_remark" runat="server" TextMode="MultiLine" Width="370px" Rows="0" Columns="100" TabIndex="5" Resize="Both"> 
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Prepared By:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Prepared" runat="server" Width="250px" DropDownWidth="650px"
                                                AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" Skin="Telerik" EnableLoadOnDemand="true" 
                                                HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"    
                                                OnItemsRequested="cb_Prepared_ItemsRequested" OnSelectedIndexChanged="cb_Prepared_SelectedIndexChanged" 
                                                OnPreRender="cb_Prepared_PreRender"  >
                                                <HeaderTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                Name
                                                            </td>
                                                            <td style="width: 350px;">
                                                                Position
                                                            </td>                                                                
                                                        </tr>
                                                    </table>                                                       
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                            </td>
                                                            <td style="width: 350px;">
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
                                        </ContentTemplate>                                                                                                                                   
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                               <td style="padding-left=15px">
                                   Checked By:
                               </td>
                               <td>
                                   <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                       <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Checked" runat="server" Width="250px" DropDownWidth="650px"
                                                AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" Skin="Telerik" EnableLoadOnDemand="true" 
                                                HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                OnItemsRequested="cb_Checked_ItemsRequested" OnSelectedIndexChanged="cb_Checked_SelectedIndexChanged" 
                                                OnPreRender="cb_Checked_PreRender" 
                                                >
                                                <HeaderTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                Name
                                                            </td>
                                                            <td style="width: 350px;">
                                                                Position
                                                            </td>                                                                
                                                        </tr>
                                                    </table>                                                       
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                            </td>
                                                            <td style="width: 350px;">
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
                                       </ContentTemplate>
                                   </asp:UpdatePanel>
                                   
                               </td>
                            </tr>
                            <tr>
                               <td style="padding-left=15px">
                                   Aproval By:
                               </td>     
                               <td>
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Approval" runat="server" Width="250px" DropDownWidth="650px"
                                                AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" Skin="Telerik" EnableLoadOnDemand="true" 
                                                HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                OnItemsRequested="cb_Approval_ItemsRequested" OnSelectedIndexChanged="cb_Approval_SelectedIndexChanged" 
                                                OnPreRender="cb_Approval_PreRender" 
                                                >
                                                <HeaderTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                Name
                                                            </td>
                                                            <td style="width: 350px;">
                                                                Position
                                                            </td>                                                                
                                                        </tr>
                                                    </table>                                                       
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                            </td>
                                                            <td style="width: 350px;">
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
                                        </ContentTemplate>
                                        <%--<Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged" />
                                        </Triggers>--%>
                                    </asp:UpdatePanel>
                                   
                               </td>
                           </tr>
                           <tr>
                                <td class="tdLabel">
                                    User:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_UId" runat="server" Width="180px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                    &nbsp
                                    <telerik:RadTextBox ID="txt_lastupdate" runat="server" Width="180px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false" Label="Last Update">
                                    </telerik:RadTextBox>
                                </td>
                            </tr> 
                            <tr>
                                <td>
                                    Posting :
                                </td>
                                <td>
                                    <asp:CheckBox ID="chk_posting" runat="server" Checked="false"  />
                                </td>
                            </tr>              
                        </table>
                    </td>
                </tr>
            </table>
            <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 20px;">
                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                    <ContentTemplate>
                        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" runat="server" GridLines="None" AllowPaging="true" AllowSorting="true" 
                            AutoGenerateColumns="false" PageSize="5" ClientSettings-Selecting-AllowRowSelect="true" ShowStatusBar="true" OnNeedDataSource="RadGrid2_NeedDataSource" 
                            OnDeleteCommand="RadGrid2_DeleteCommand" OnInsertCommand="RadGrid2_SaveHandler" OnUpdateCommand="RadGrid2_SaveHandler">
                            <MasterTableView CommandItemDisplay="Top" Font-Size="12px" EditMode="InPlace" ShowHeadersWhenNoRecords="true" AutoGenerateColumns="false" DataKeyNames="inv_code">
                                <CommandItemSettings ShowRefreshButton="false" ShowSaveChangesButton="false" />
                                <Columns>
                                    <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                            HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update">
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridTemplateColumn UniqueName="inv_code" HeaderText="Reg. Number" ItemStyle-Width="120px" 
                                            SortExpression="inv_code">
                                        <FooterTemplate>Template footer</FooterTemplate>
                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "inv_code")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_inv_code" EnableLoadOnDemand="true" AutoPostBack="true" 
                                                OnItemsRequested="cb_inv_code_ItemsRequested" DataTextField="NoFP" DataValueField="NoBuk"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.inv_code") %>' 
                                                HighlightTemplatedItems="true" Height="190px" Width="120px" DropDownWidth="500px" 
                                                OnPreRender="cb_inv_code_PreRender" OnSelectedIndexChanged="cb_inv_code_SelectedIndexChanged"
                                                >
                                                <HeaderTemplate>
                                                    <table style="width: 500px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                Reg. Number
                                                            </td>
                                                            <td style="width: 350px;">
                                                                Invoice Number
                                                            </td>                                                                
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 500px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                            </td>
                                                            <td style="width: 350px;">
                                                                <%# DataBinder.Eval(Container, "Attributes['NoFP']")%>
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
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Invoice Date" ItemStyle-Width="150px">
                                        <EditItemTemplate>
                                            <telerik:RadDatePicker ID="dtp_date" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                TabIndex="4" Skin="Metro">
                                                 <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro"></Calendar>
                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput> 
                                            </telerik:RadDatePicker>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="350px">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "remark")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark" Width="350px" Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                            </telerik:RadTextBox>                                                 
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Amount" ItemStyle-Width="130px" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "pay_amount", "{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox rendermode="Lightweight" runat="server" ID="txt_pay_amount" Width="130px" Text ='<%# DataBinder.Eval(Container.DataItem, "pay_amount", "{0:#,###,###0.00}") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn UniqueName="region_code" HeaderText="Project" HeaderStyle-Width="100px"
                                        SortExpression="region_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                        <FooterTemplate>Template footer</FooterTemplate>
                                        <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%#DataBinder.Eval(Container.DataItem, "region_code")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Project" DropDownWidth="350px" 
                                                   EnableLoadOnDemand="True" Skin="Telerik" DataValueField="region_code" DataTextField="region_name" 
                                                   Text='<%# DataBinder.Eval(Container, "DataItem.region_code") %>' OnItemsRequested="cb_Project_ItemsRequested"
                                                   OnSelectedIndexChanged="cb_Project_SelectedIndexChanged" OnPreRender="cb_Project_PreRender" Height="190px" Width="100px" 
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
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn UniqueName="dept_code" HeaderText="Cost Center" HeaderStyle-Width="100px"
                                        SortExpression="dept_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                        <FooterTemplate>Template footer</FooterTemplate>
                                        <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%#DataBinder.Eval(Container.DataItem, "dept_code")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Cost_Center" DropDownWidth="350px" 
                                                   EnableLoadOnDemand="True" Skin="Telerik" DataValueField="code" DataTextField="name" 
                                                   Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>' OnItemsRequested="cb_Cost_Center_ItemsRequested" 
                                                   OnPreRender="cb_Cost_Center_PreRender" Height="190px" Width="100px" 
                                                   AutoPostBack="false">
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
                                    </telerik:GridTemplateColumn> 
                                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                        ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings>
                                <ClientEvents OnRowDblClick="rowDblClick"/>
                            </ClientSettings>
                        </telerik:RadGrid>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="RadGrid2" EventName="UpdateCommand">
                        </asp:AsyncPostBackTrigger>
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>

        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server"  ReloadOnShow="true" ShowContentDuringLoad="false"
                  Width="1170px" Height="670px" Modal="true">
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
