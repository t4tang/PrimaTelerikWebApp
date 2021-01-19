<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h02.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Cash.CashMutation.acc01h02" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../../Script/Script.js"></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server" >
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
            function ShowPreview(id) {
                window.radopen("ReportViewer_acc01h02.aspx?NoBuk=" + id, "PreviewDialog");
                return false;
            }
            function ShowJournal(id) {
                window.radopen("acc01h02journal.aspx?doc_code=" + id, "PreviewDialog");
                return false;
            }
        </script>
        <style type="text/css">
            .tdLabel{
                vertical-align:top; 
                text-align:left;
                width:auto;
                padding-right:10px;
                font-weight:lighter;
                /*font-family:'Century Gothic';*/
                font-style:normal;
                color:#282727;
                font-size:12px
            }

            .trxInfo{
                border-style:none;
                font-style:italic; 
                color:darkgrey
            }
        </style>
    </telerik:RadCodeBlock>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
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
             <telerik:AjaxSetting AjaxControlID="cb_Cash">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_cur_code" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_kurs" ></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

     <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="500" BackgroundPosition="None">
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone" Modal="true" Width="1110px" Height="580px">
        <ContentTemplate>
            <div runat="server" style="padding:20px 10px 10px 10px;" id="searchParam">
                <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="Date From" Height="26px"></telerik:RadDatePicker>
                <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="To Date" Height="26px"></telerik:RadDatePicker>
                <telerik:RadComboBox ID="cb_CashMutation_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="Cash" AutoPostBack="false" 
                    EnableLoadOnDemand="true" Skin="Telerik" Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" 
                    EnableVirtualScrolling="true" OnItemsRequested="cb_CashMutation_prm_ItemsRequested" OnSelectedIndexChanged="cb_CashMutation_prm_SelectedIndexChanged">
                </telerik:RadComboBox>
                &nbsp
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                <asp:Button ID="btnOK" runat="server" Text="Select & Close" OnClick="btnOK_Click" />
            </div>

            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik" AllowSorting="true" AutoGenerateColumns="false" 
                ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="10" OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="NoBuk" Font-Size="12px" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" 
                    CommandItemSettings-ShowAddNewRecordButton="false" CommandItemSettings-ShowRefreshButton="false">
                    <Columns>
                        <telerik:GridClientSelectColumn UniqueName="SelectColumn" ></telerik:GridClientSelectColumn>
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
        
    <div id="div1" class="scroller" runat="server">
        <div style="padding-left:15px;width:100%;border-bottom-color:#FF6600;border-bottom-width:1px;border-bottom-style:inset;background-color:#e2e6e6;">
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
                    <td style="vertical-align:middle; margin-left:10px;padding-left:13px">
                        <asp:ImageButton runat="server" ID="btnJournal" AlternateText="Journal" OnClick="btnJournal_Click"
                        Height="30px" Width="32px" ImageUrl="~/Images/ledger-gray.png">
                        </asp:ImageButton>  
                    </td>
                    <td style="width:82%; text-align:right">
                        <telerik:RadLabel ID="lbl_form_name" Text="Cash Mutation" runat="server" style="font-weight:lighter; 
                            font-size:10px; font-variant: small-caps; padding-left:10px; 
                        padding-bottom:0px; font-size:x-large; color:#7cca05"></telerik:RadLabel>
                    </td>
                </tr>
            </table>
        </div>
        <div class="table_trx">

            <table id="Table1" border="0" >   
                <tr style="vertical-align: top">
                    <td style="vertical-align:top; width:25%">
                            <table id="Table2" width="Auto" border="0" class="module"> 
                                <tr>
                                    <td class="tdLabel">
                                        Reg No:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txt_NoBuk" runat="server" Width="180px" Enabled="false" RenderMode="Lightweight" Skin="Telerik"
                                            AutoPostBack="false">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        Date:
                                    </td>
                                    <td>
                                    <telerik:RadDatePicker ID="dtp_bm"  runat="server" MinDate="1/1/1900" Width="180px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Telerik"> 
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
                                            AutoPostBack="false">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        No. Ref:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txt_NoRef" runat="server" Width="180px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                            AutoPostBack="false">
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
                                            AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select a Project -" Skin="Telerik" EnableLoadOnDemand="true"  
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
                                        <%--<asp:UpdatePanel runat="server">
                                            <ContentTemplate>  --%>                    
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Cash" runat="server" Width="300" DropDownWidth="300px"
                                                AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Cash -" Skin="Telerik" EnableLoadOnDemand="true"  
                                                OnItemsRequested="cb_Cash_ItemsRequested" 
                                                OnSelectedIndexChanged="cb_Cash_SelectedIndexChanged" 
                                                OnPreRender="cb_Cash_PreRender">
                                            </telerik:RadComboBox>
                                            <%--</ContentTemplate>
                                        </asp:UpdatePanel> --%>              
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        Currency:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txt_cur_code" runat="server" Width="80px" ReadOnly="true" RenderMode="Lightweight"
                                            AutoPostBack="false">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        Kurs:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txt_kurs" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik"
                                            AutoPostBack="false">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        From/To:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txt_fromto" runat="server" Width="250px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                            AutoPostBack="false">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        Remark:
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <telerik:RadTextBox ID="txt_remark"  Skin="Telerik"
                                            runat="server" TextMode="MultiLine"
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
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Prepared" runat="server" Width="250px" DropDownWidth="500px"
                                                    AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select -" Skin="Telerik" EnableLoadOnDemand="true" 
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
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged" />
                                            </Triggers>                                                                                            
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                               <tr>
                                   <td>
                                       Checked By:
                                   </td>
                                   <td>
                                       <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                           <ContentTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Checked" runat="server" Width="250px" DropDownWidth="500px"
                                                    AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select -" Skin="Telerik" EnableLoadOnDemand="true" 
                                                    HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                    OnItemsRequested="cb_Checked_ItemsRequested" OnSelectedIndexChanged="cb_Checked_SelectedIndexChanged" 
                                                    OnPreRender="cb_Checked_PreRender" 
                                                    >
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
                                           </ContentTemplate>
                                           <Triggers>
                                               <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged" />
                                           </Triggers>
                                       
                                       </asp:UpdatePanel>
                                   
                                   </td>
                                </tr>
                               <tr>
                                   <td>
                                       Aproval By:
                                   </td>     
                                   <td>
                                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Approval" runat="server" Width="250px" DropDownWidth="500px"
                                                    AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select -" Skin="Telerik" EnableLoadOnDemand="true" 
                                                    HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                                    OnItemsRequested="cb_Approval_ItemsRequested" OnSelectedIndexChanged="cb_Approval_SelectedIndexChanged" 
                                                    OnPreRender="cb_Approval_PreRender" 
                                                    >
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
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                   
                                   </td>
                               </tr>
                           </table>
                       </td>
                    </tr>
                    <tr>
                       
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-top:20px; padding-bottom:20px;">
                            <table class="trxInfo" style="color:#f07f2e;">
                                <tr>
                                    <td style="width:15px;"> User: </td>
                                    <td style="width:50px;">
                                        <telerik:RadTextBox ReadOnly="true" ID="txt_UId" Width="60px" runat="server" BorderStyle="None" >
                                        </telerik:RadTextBox>
                                    </td>
                                    <td style="padding-left:15px"> Last Update: </td>
                                    <td style="width:50px">
                                        <telerik:RadTextBox ReadOnly="true" ID="txt_lastupdate" Width="150px" runat="server"  BorderStyle="None" >
                                        </telerik:RadTextBox>
                                    </td>
                                    <td style="padding-left:15px"> Owner: </td>
                                    <td style="width:50px">
                                        <telerik:RadTextBox ReadOnly="true" ID="txt_Owner" Width="60px" runat="server"  BorderStyle="None" >
                                        </telerik:RadTextBox>
                                    </td>
                                    <td style="padding-left:15px"> Printed: </td>
                                    <td>
                                        <telerik:RadTextBox ReadOnly="true" ID="txt_Printed" Width="40px" runat="server"  BorderStyle="None" >
                                        </telerik:RadTextBox>
                                    </td>
                                    <td style="padding-left:15px"> Edited: </td>
                                     <td>
                                        <telerik:RadTextBox ReadOnly="true" ID="txt_Edited" Width="40px" runat="server"  BorderStyle="None" >
                                        </telerik:RadTextBox>
                                     </td>                        
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>

            <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 20px;">
                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                    <ContentTemplate>
                        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"
                            AllowPaging="true" AllowSorting="true" runat="server"  OnNeedDataSource="RadGrid2_NeedDataSource" 
                            ShowStatusBar="true" OnInsertCommand="RadGrid2_Save_Handler" OnUpdateCommand="RadGrid2_Save_Handler" 
                            OnDeleteCommand="RadGrid2_DeleteCommand" ClientSettings-Selecting-AllowRowSelect="true"  
                            >
                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="KoRek" Font-Size="12px" EditMode="InPlace"
                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False">
                                    <CommandItemSettings ShowRefreshButton="false" ShowSaveChangesButton="false" />
                                    <Columns>
                                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                            HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update">
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridTemplateColumn UniqueName="KoRek" HeaderText="Account No." ItemStyle-Width="120px" 
                                            SortExpression="KoRek" >
                                            <FooterTemplate>Template footer</FooterTemplate>
                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "KoRek")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>                                       
                                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_KoRek" EnableLoadOnDemand="True" AutoPostBack="true" 
                                                            OnItemsRequested="cb_KoRek_ItemsRequested" DataValueField="KoRek" DataTextField="accountname"  HeaderStyle-HorizontalAlign="Center"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.KoRek") %>'
                                                            HighlightTemplatedItems="true" Height="190px" Width="120px" DropDownWidth="500px" 
                                                            OnPreRender="cb_KoRek_PreRender" OnSelectedIndexChanged="cb_KoRek_SelectedIndexChanged">
                                                    
                                                            <HeaderTemplate>
                                                                <table style="width: 500px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            Code
                                                                        </td>
                                                                        <td style="width: 350px;">
                                                                            Name
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
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="350px"  HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "Ket")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark" Width="350px" Text='<%# DataBinder.Eval(Container, "DataItem.Ket") %>'>
                                                </telerik:RadTextBox>                                                 
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="D/C" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "Mutasi")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Mutasi" DropDownWidth="50px"   
                                                    EnableLoadOnDemand="true" Skin="Telerik" DataValueField="Mutasi" DataTextField="name" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Mutasi") %>' 
                                                    OnItemsRequested="cb_Mutasi_ItemsRequested" OnSelectedIndexChanged="cb_Mutasi_SelectedIndexChanged" OnPreRender="cb_Mutasi_PreRender">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Kurs" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right"  HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "kurs","{0:#,###,###0.00000000}")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox ID="txt_kurs" runat="server" Width="100px" Enabled="true" RenderMode="Lightweight"
                                                    AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.kurs") %>' >
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Amount" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right"  HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "Jumlah","{0:#,###,###0.00}")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_amount" Width="120px" Text='<%# DataBinder.Eval(Container, "DataItem.Jumlah","{0:#,###,###0.00}") %>'>
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn UniqueName="region_code" HeaderText="Project" HeaderStyle-Width="100px"  HeaderStyle-HorizontalAlign="Center"
                                            SortExpression="region_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                            <FooterTemplate>Template footer</FooterTemplate>
                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <%#DataBinder.Eval(Container.DataItem, "region_code")%>
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
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="dept_code" HeaderText="Cost Center" HeaderStyle-Width="100px"  HeaderStyle-HorizontalAlign="Center"
                                            SortExpression="dept_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                            <FooterTemplate>Template footer</FooterTemplate>
                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "dept_code")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                
                                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Cost_Center" DropDownWidth="350px" AutoPostBack="false"  
                                                            EnableLoadOnDemand="True" Skin="Telerik" DataValueField="code" DataTextField="name" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>' OnItemsRequested="cb_Cost_Center_ItemsRequested" 
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
</asp:Content>
