<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h04b.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Bank.Bank_Receipt.acc01h04b" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../../../Script/Script.js"></script>
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />

     <script src="../../../../Script/Script.js"></script>
     <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
            function ShowPreview(id) {
                window.radopen("ReportVieweracc01h04.aspx?slip_no=" + id, "PreviewDialog");
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

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>
    
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="1110px" Height="580px">
        <ContentTemplate>
             <div runat="server" style="padding:20px 10px 10px 10px;" id="searchParam">                
                <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="Date From " Height="26px"></telerik:RadDatePicker>                
                <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="To Date " Height="26px"></telerik:RadDatePicker>
                <telerik:RadComboBox ID="cb_bank_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="Bank" AutoPostBack="false"
                    EnableLoadOnDemand="True" Skin="Telerik"  OnItemsRequested="cb_bank_prm_ItemsRequested" EnableVirtualScrolling="true" 
                    Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"
                    OnSelectedIndexChanged="cb_bank_prm_SelectedIndexChanged"></telerik:RadComboBox>&nbsp
                &nbsp
                <%--<telerik:RadButton ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                Style="clear: both; margin: 0px 0; height:35px">
                </telerik:RadButton>--%>
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                 &nbsp
                <asp:Button ID="btnOk" runat="server" OnClick="btnOk_Click" Text="Select & Close"/>
                
            </div>
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="10"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <ClientSettings EnablePostBackOnRowClick="true" >
                </ClientSettings>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="slip_no" Font-Size="12px"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                     CommandItemSettings-ShowRefreshButton="false" >                    
                    <Columns>
                         <%--<telerik:GridTemplateColumn UniqueName="TemplateEditColumn" AllowFiltering="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>                              
                               <asp:RadioButton ID="rb_get" runat="server" Width="15px"  />                                
                            </ItemTemplate>
                            <HeaderStyle Width="30px"></HeaderStyle>
                        </telerik:GridTemplateColumn>--%>
                        <telerik:GridBoundColumn UniqueName="slip_no" HeaderText="Reg. No" DataField="slip_no">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn UniqueName="cashbank" HeaderText="Bank Code" DataField="cashbank" 
                            FilterControlWidth="70px" >
                            <HeaderStyle Width="70px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="noctrl" HeaderText="Ctrl. No" DataField="noctrl" 
                            FilterControlWidth="120px" >
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="slip_date" HeaderText="Date" DataField="slip_date" ItemStyle-Width="80px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="remark1" HeaderText="Customer" DataField="remark1" 
                            FilterControlWidth="150px" >
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                                   
                        <telerik:GridBoundColumn UniqueName="cur_code" HeaderText="Curr." DataField="cur_code" 
                            FilterControlWidth="50px" >
                            <HeaderStyle Width="50px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="kurs" HeaderText="Kurs" DataField="kurs" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="tot_pay" HeaderText="Tot Amount" DataField="tot_pay" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                       
                        <telerik:GridBoundColumn UniqueName="Remark" HeaderText="Remark" DataField="Remark" ItemStyle-Wrap="true"
                                ItemStyle-Width="450px" FilterControlWidth="480px">
                            <HeaderStyle Width="500px"></HeaderStyle>
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

    <div class="scroller"> 
        
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
                        <asp:ImageButton runat="server" ID="btnJournal" AlternateText="Journal" OnClick="btnJournal_Click"
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
                        <telerik:RadLabel ID="RadLabel1" runat="server" Text="Bank Receipt Voucher" 
                            Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                            padding-bottom: 0px; font-size: x-large; color:#7cca05;">
                        </telerik:RadLabel>
                    </td>
                </tr>
            </table>
        </div>

        <div class="table_trx">                               
            <table id="Table2" width="100%" border="0" class="module">
                <tr style="vertical-align: top">
                    <td style="vertical-align:top;">
                        <table>                
                            <tr>
                                <td class="tdLabel">
                                    Reg No:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_slip_no" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>             
                            <tr>
                                <td class="tdLabel">
                                    Date:
                                </td>
                                <td>
                                <telerik:RadDatePicker ID="dtp_bm"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight" Skin="Telerik"  
                                    TabIndex="4"> 
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
                                    No Ctrl:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_NoCtrl" runat="server" Width="200px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"  
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>             
                             <tr>
                                <td class="tdLabel">
                                    Customer:
                                </td>
                                <td style="vertical-align:top; text-align:left">                      
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Cust" runat="server" Width="300" DropDownWidth="300px" Skin="Telerik"  
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Customer -" EnableLoadOnDemand ="true" 
                                         OnItemsRequested="cb_Cust_ItemsRequested" OnSelectedIndexChanged="cb_Cust_SelectedIndexChanged"
                                         OnPreRender="cb_Cust_PreRender" >
                                    </telerik:RadComboBox>               
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Currency:
                                </td>
                                <td colspan="2" style="width:auto">
                                     <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                        <ContentTemplate>
                                    <telerik:RadTextBox ID="txt_cur_code" runat="server" Width="80px" ReadOnly="true" RenderMode="Lightweight"  Skin="Telerik"  
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                    <%-- </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_Cust" EventName="SelectedIndexChanged" />
                                        </Triggers>                                                                                            
                                    </asp:UpdatePanel> --%>                                                              
                                   &nbsp; Kurs:
                                  <%-- <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                    <ContentTemplate>--%>
                                        <telerik:RadTextBox ID="txt_kurs" runat="server" Width="120px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik"  
                                            AutoPostBack="false">
                                        </telerik:RadTextBox>
                                    </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_Cust" EventName="SelectedIndexChanged" />
                                        </Triggers>                                                                                            
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align: top; padding-left:15px">
                        <table id="Table3" border="0" class="module">
                           
                                       
                            <tr >
                                <td class="tdLabel">
                                    Bank:
                                </td>
                                <td colspan="4" style="vertical-align:top; text-align:left">                                   
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_bank" runat="server" Width="300" DropDownWidth="300px" Skin="Telerik"  
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Bank -" EnableLoadOnDemand ="true"
                                         OnItemsRequested="cb_bank_ItemsRequested" OnSelectedIndexChanged="cb_bank_SelectedIndexChanged"
                                         OnPreRender="cb_bank_PreRender" >
                                    </telerik:RadComboBox>                
                                </td>
                            </tr>
                             <tr>
                                <td class="tdLabel">
                                    Currency:
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadTextBox ID="txt_cur_code_acc" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight" Skin="Telerik"  
                                            AutoPostBack="false">
                                        </telerik:RadTextBox>
                                     </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_bank" EventName="SelectedIndexChanged" />
                                        </Triggers>                                                                                            
                                    </asp:UpdatePanel>
                                </td>
                                <td>
                                    
                               </td>
                                <td> 
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                    <telerik:RadTextBox ID="txt_kurs_acc" runat="server" Width="150px" ReadOnly="true" Visible="false" RenderMode="Lightweight" Skin="Telerik"  
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                     </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_bank" EventName="SelectedIndexChanged" />
                                        </Triggers>                                                                                            
                                    </asp:UpdatePanel>
                                </td>
                            </tr>          
                            <tr>
                                <td class="tdLabel">
                                    Chegue/Giro No:
                                </td>                
                                <td colspan="4">   
                                    <telerik:RadTextBox ID="txt_inf_pay_no" runat="server" Width="300px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"  
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>                                 
                                </td>
                            </tr>
                              <tr>
                                <td class="tdLabel">
                                    Cashed Date:
                                </td>
                                <td colspan="4">
                                <telerik:RadDatePicker ID="dtp_lm"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight" Skin="Telerik"  
                                    TabIndex="4"> 
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
                                    Remark:
                                </td>                
                                <td colspan="4" style="vertical-align:top; text-align:left">                               
                                    <telerik:RadTextBox ID="txt_Remark" 
                                        runat="server" TextMode="MultiLine"
                                        Width="300px" Rows="0" Columns="100" TabIndex="5" Resize="Both">
                                    </telerik:RadTextBox>                                  
                                </td>
                            </tr>
                        </table>           
                    </td>
                    <td colspan="4">
                        <table>
                            <tr>
                                <td>
                                    Prepared By:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Prepared" runat="server" Width="250px" DropDownWidth="650px"
                                                AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select -" Skin="Telerik" EnableLoadOnDemand="true" 
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
                                       
                                </td>
                            </tr>
                            <tr>
                                <td> Checked By:</td>
                               <td>
                                  
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Checked" runat="server" Width="250px" DropDownWidth="650px"
                                                AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select -" Skin="Telerik" EnableLoadOnDemand="true" 
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
                                      
                                   
                               </td>                            
                            </tr>
                            <tr>
                                <td>Approved By:</td>
                                <td>
                                   
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Approval" runat="server" Width="250px" DropDownWidth="650px"
                                                AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select -" Skin="Telerik" EnableLoadOnDemand="true" 
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
                                       
                                   
                               </td>
                            </tr>
                        </table>  
                    </td>
                </tr>
                <tr>                    
                    
                </tr>    
                <tr>
                    <td colspan="3" style="padding-top:20px; padding-bottom:20px;">
                        <table>
                            <tr>
                                <td style="width:15px"> User: </td>
                                <td style="width:50px">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="50px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px"> Last Update: </td>
                                <td style="width:50px">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_LastUpdate" Width="140px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px"> Owner: </td>
                                <td style="width:50px">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="50px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px"> Printed: </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_printed" Width="40px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px"> Edited: </td>
                                 <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" runat="server" >
                                    </telerik:RadTextBox>
                                 </td>                        
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

           <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 20px; overflow:auto">
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                      <ContentTemplate>
                             <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"
                                AllowPaging="true" AllowSorting="true" runat="server" ShowStatusBar="true" OnInsertCommand="RadGrid2_save_handler" 
                                 ClientSettings-Selecting-AllowRowSelect="true"
                                 OnNeedDataSource="RadGrid2_NeedDataSource"
                                 OnUpdateCommand="RadGrid2_save_handler" 
                                 OnDeleteCommand="RadGrid2_DeleteCommand">   
                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="inv_code" Font-Size="12px" EditMode="InPlace"
                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >                                             
                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                                        
                                    <Columns>   
                                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                            HeaderText="Edit" HeaderStyle-Width="60px" ItemStyle-Width="60px" UpdateText="Update">
                                        </telerik:GridEditCommandColumn>  
                                                              
                                        <telerik:GridTemplateColumn UniqueName="inv_code" HeaderText="Invoice No." HeaderStyle-Width="160px"
                                            SortExpression="inv_code" ItemStyle-Width="160px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                            <FooterTemplate>Template footer</FooterTemplate>
                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <%#DataBinder.Eval(Container.DataItem, "inv_code")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_inv_code" EnableLoadOnDemand="True" DataTextField="JmlSisa"
                                                    OnItemsRequested="cb_inv_code_ItemsRequested" DataValueField="inv_code" AutoPostBack="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.inv_code") %>'
                                                    HighlightTemplatedItems="true" Height="290px" Width="160px" DropDownWidth="250px"
                                                    OnSelectedIndexChanged="cb_inv_code_SelectedIndexChanged" OnPreRender="cb_inv_code_PreRender">
                                                    <HeaderTemplate>
                                                        <table style="width:auto; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 50px;">
                                                                Invoice No
                                                            </td>
                                                            <td style="width: 100px;">
                                                                Payment
                                                            </td>                                                                
                                                        </tr>
                                                    </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                         <table style="width: auto; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 50px;">
                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                            </td>                   
                                                            <td style="width: 100px; text-align:right;">
                                                                <%# DataBinder.Eval(Container, "Attributes['JmlSisa']","{0:#,###,###0.00}")%>
                                                            </td>                                             
                                                        </tr>
                                                    </table>
                                                    </ItemTemplate>
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                            
                                        <telerik:GridTemplateColumn HeaderText="Inv Date" ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Center"
                                            HeaderStyle-HorizontalAlign="Center" DefaultInsertValue="0">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "date", "{0:dd-MM-yyyy}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_date" Width="100px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ReadOnly="true"
                                                Text='<%#DataBinder.Eval(Container.DataItem, "date", "{0:dd-MM-yyyy}")%>' 
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Date">
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                        </telerik:GridTemplateColumn> 

                                        <telerik:GridTemplateColumn HeaderText="Payment" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "pay_amount", "{0:#,###,###0.00}")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_payment" Width="150px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "pay_amount") %>'
                                                    onkeydown="blurTextBox(this, event)"
                                                    AutoPostBack="true" MaxLength="11" Type="Money"
                                                    >
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>    

                                       <%-- <telerik:GridTemplateColumn HeaderText="Intrst.(%)" ItemStyle-Width="200px">
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "NoPPH23", "{0:#,###,###0.00}")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_nopph23" Width="150px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "NoPPH23") %>'
                                                    onkeydown="blurTextBox(this, event)"
                                                    AutoPostBack="true" MaxLength="11" Type="Money"
                                                    >
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>    

                                        <telerik:GridTemplateColumn HeaderText="Amount Of Intrst" ItemStyle-Width="200px">
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "PPHAmount", "{0:#,###,###0.00}")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_pphamount" Width="150px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "PPHAmount") %>'
                                                    onkeydown="blurTextBox(this, event)"
                                                    AutoPostBack="true" MaxLength="11" Type="Money"
                                                    >
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>      --%>
                                
                                        <telerik:GridTemplateColumn HeaderText="Kurs" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "kurs", "{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                           <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_kurs" Width="100px"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.kurs") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Kurs Tax" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "kurs_tax", "{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                           <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_kurs_tax" Width="100px"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.kurs_tax") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Project" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "region_code")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_project" Width="100px"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.region_code") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                        </telerik:GridTemplateColumn> 

                                        <telerik:GridTemplateColumn HeaderText="Cost Center" HeaderStyle-Width="100px" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                            HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "dept_code")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_cost_ctr" Width="100px"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                        </telerik:GridTemplateColumn> 

                                        <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="400px" HeaderStyle-Width="400px" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "remark")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_Ket" Width="400px"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                        </telerik:GridTemplateColumn> 

                                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                            ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-ForeColor="Red">
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
</asp:Content>
