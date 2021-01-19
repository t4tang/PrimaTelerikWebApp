<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h01.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Bank.BankMutation.acc01h01" %>
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
                window.radopen("ReportVieweracc01h01.aspx?NoBuk=" + id, "PreviewDialog");
                return false;
            }
            function ShowJournal(id) {
                window.radopen("acc01h01journal.aspx?doc_code=" + id, "PreviewDialog");
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
     <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>            
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
          <%-- <telerik:AjaxSetting AjaxControlID="cb_bank">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_cur_code"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_kurs"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>--%>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None">
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="1310px" Height="650px">
        <ContentTemplate>
             <div runat="server" style="padding:20px 10px 10px 10px;" id="searchParam">                
                <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="Date From " Height="26px"></telerik:RadDatePicker>                
                <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="To Date " Height="26px"></telerik:RadDatePicker>
                <telerik:RadComboBox ID="cb_bank_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="Bank" AutoPostBack="false"
                    EnableLoadOnDemand="True" Skin="Telerik"  OnItemsRequested="cb_bank_prm_ItemsRequested" EnableVirtualScrolling="true" 
                    Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"
                    OnSelectedIndexChanged="cb_bank_prm_SelectedIndexChanged"></telerik:RadComboBox>
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
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="NoBuk" Font-Size="12px"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                     CommandItemSettings-ShowRefreshButton="false" >                    
                    <Columns>
                            <telerik:GridClientSelectColumn UniqueName="SelectColumn" ></telerik:GridClientSelectColumn> 
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
        
        <div style=" padding-left:15px; width:100%; border-bottom-color: #FF6600; background-color:#e2e6e6; border-bottom-width: 1px; border-bottom-style: inset;">
            <table id="tbl_control">
                <tr>                    
                    <td  style="text-align:right;">
                        <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                            Height="25px" Width="30px" ImageUrl="~/Images/daftar.png">
                        </asp:ImageButton>                        
                    </td>
                    <td style="vertical-align:middle; margin-left:10px">
                        <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click"
                            Height="27px" Width="30px" ImageUrl="~/Images/tambah.png">
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
                    <td style="width: 85%; text-align: right">
                    <telerik:RadLabel ID="RadLabel1" runat="server" Text="Bank Mutation" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#7cca05;">
                    </telerik:RadLabel>
                </td>
                </tr>
            </table>            
        </div>

        <div class="table_trx">                               
            <table id="Table1" border="0" >    
                <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module">                
                            <tr>
                                <td class="tdLabel">
                                    Reg No:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_NoBuk" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight" Skin="Telerik"
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
                                    TabIndex="4" Skin="Telerik"> 
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
                                    No Ref:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_NoRef" runat="server" Width="200px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>             
                            <tr>
                                <td class="tdLabel">
                                    Transaction:
                                </td>
                                <td>
                                     <telerik:RadComboBox RenderMode="Lightweight" ID="cb_KoTrans" runat="server" Width="200"
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
                                    Project:
                                </td>
                                <td style="vertical-align:top; text-align:left">                      
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" Skin="Telerik" EnableLoadOnDemand ="true" 
                                         OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                         OnPreRender="cb_project_PreRender" >
                                    </telerik:RadComboBox>               
                                </td>
                            </tr>
                            <tr >
                                <td class="tdLabel">
                                    Bank:
                                </td>
                                <td style="vertical-align:top; text-align:left">  
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>                               
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_bank" runat="server" Width="300" DropDownWidth="300px"
                                                AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select a Bank -" Skin="Telerik" EnableLoadOnDemand ="true"
                                                 OnItemsRequested="cb_bank_ItemsRequested" OnSelectedIndexChanged="cb_bank_SelectedIndexChanged"
                                                 OnPreRender="cb_bank_PreRender" >
                                            </telerik:RadComboBox>                                             
                                        </ContentTemplate>
                                    </asp:UpdatePanel>                 
                                </td>
                            </tr>
                             <tr>
                                <td class="tdLabel">
                                    Currency:
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate> 
                                            <telerik:RadTextBox ID="txt_cur_code" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight" Skin="Telerik"
                                                AutoPostBack="false">
                                            </telerik:RadTextBox>&nbsp
                                            Kurs:&nbsp
                                            <telerik:RadTextBox ID="txt_kurs" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                                AutoPostBack="false">
                                            </telerik:RadTextBox>                                            
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_bank" />
                                        </Triggers>
                                     </asp:UpdatePanel>  
                                </td>
                            </tr>          
                            <tr>
                                <td class="tdLabel">
                                    From / To:
                                </td>                
                                <td>   <telerik:RadTextBox ID="txt_Kontak" runat="server" Width="345px" Enabled="true" RenderMode="Lightweight" Skin="Telerik"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>                                 
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Remark:
                                </td>                
                                <td style="vertical-align:top; text-align:left">                               
                                    <telerik:RadTextBox ID="txt_Ket" 
                                        runat="server" TextMode="MultiLine"
                                        Width="345px" Rows="0" Columns="100" TabIndex="5" Resize="Both">
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
                                <td>
                                     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_prepared" runat="server" Width="250px" 
                                            DropDownWidth="370px" AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select -" Skin="Telerik" 
                                                EnableLoadOnDemand ="true" OnItemsRequested="cb_prepared_ItemsRequested" OnSelectedIndexChanged="cb_prepared_SelectedIndexChanged"
                                                OnPreRender="cb_prepared_PreRender">
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
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td> Checked By:</td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_checked" runat="server" Width="250px" 
                                            DropDownWidth="370px" AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select -" Skin="Telerik" 
                                                EnableLoadOnDemand ="true" EnableVirtualScrolling="true" OnItemsRequested="cb_checked_ItemsRequested" OnSelectedIndexChanged="cb_checked_SelectedIndexChanged"
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
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>Approved By:</td>
                                <td>
                                     <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px" 
                                            DropDownWidth="370px" EmptyMessage="- Select -" AutoPostBack="true" ShowMoreResultsBox="false" Skin="Telerik" 
                                                EnableLoadOnDemand ="true"
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
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
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
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="50px" runat="server" BorderStyle="None">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px"> Last Update : </td>
                                <td style="width:50px">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_LastUpdate" Width="140px" runat="server" BorderStyle="None">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px"> Owner : </td>
                                <td style="width:50px">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="50px" runat="server" BorderStyle="None">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px"> Printed : </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_printed" Width="40px" runat="server" BorderStyle="None">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px"> Edited : </td>
                                 <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" runat="server" BorderStyle="None">
                                    </telerik:RadTextBox>
                                 </td>                        
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

           <div style=" width:100%; border-top-color: #009900; border-top-width: 1px; border-top-style: solid; padding-top: 20px;">
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                      <ContentTemplate>
                             <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"
                                AllowPaging="true" AllowSorting="true" runat="server"  OnNeedDataSource="RadGrid2_NeedDataSource"  Skin="Telerik"
                               ShowStatusBar="true" 
                                 OnInsertCommand="RadGrid2_insert"
                                 OnUpdateCommand="RadGrid2_update" 
                                 OnDeleteCommand="RadGrid2_DeleteCommand" 
                                 ClientSettings-Selecting-AllowRowSelect="true">   
                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="KoRek" Font-Size="12px" EditMode="InPlace" InsertItemDisplay="Bottom"
                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemStyle-BorderColor="#009933" CommandItemStyle-ForeColor="#009933" CommandItemSettings-AddNewRecordText="Add Item">                                             
                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                                        
                                    <Columns>   
                                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                            HeaderText="Edit" HeaderStyle-Width="60px" ItemStyle-Width="60px" UpdateText="Update">
                                        </telerik:GridEditCommandColumn> 

                                        <telerik:GridTemplateColumn UniqueName="Nomor" HeaderText="No." HeaderStyle-Width="30px" Visible="true"
                                            SortExpression="Nomor" ItemStyle-Width="30px">
                                            <ItemTemplate>
                                               <asp:Label ID="lbl_nomor" Width="30px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Nomor")%>'></asp:Label>                                             
                                            </ItemTemplate>                                                                                
                                        </telerik:GridTemplateColumn> 
                                                               
                                        <telerik:GridTemplateColumn UniqueName="KoRek" HeaderText="Account No." HeaderStyle-Width="110px"
                                            SortExpression="KoRek" ItemStyle-Width="110px">
                                            <FooterTemplate>Template footer</FooterTemplate>
                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_korek" Width="110px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "KoRek")%>'></asp:Label>                                                
                                            </ItemTemplate>
                                            <InsertItemTemplate>
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
                                            </InsertItemTemplate>
                                        </telerik:GridTemplateColumn>                            
                                   
                                        <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="380px" HeaderStyle-Width="380px" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "Ket")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_Ket" Width="380px"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.Ket") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                        </telerik:GridTemplateColumn> 

                                        <telerik:GridTemplateColumn HeaderText="D/K" ItemStyle-Width="80px"  HeaderStyle-Width="80px"  ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "Mutasi")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" Width="80px" DropDownWidth="80px" runat="server" ID="cb_mutasi" AutoPostBack="false"
                                                EnableLoadOnDemand="true" Skin="Telerik" DataTextField="name" DataValueField="Mutasi"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.Mutasi") %>'
                                                OnItemsRequested="cb_mutasi_ItemsRequested" OnPreRender="cb_mutasi_PreRender"
                                                 OnSelectedIndexChanged="cb_mutasi_SelectedIndexChanged" >
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                      </telerik:GridTemplateColumn> 
                                           
                                        <telerik:GridTemplateColumn HeaderText="Kurs" ItemStyle-Width="100px" HeaderStyle-Width="100px"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "kurs")%>
                                        </ItemTemplate>
                                            <EditItemTemplate>
                                               <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_kurs" Width="100px"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.kurs") %>'>
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Ammount" ItemStyle-Width="150px" HeaderStyle-Width="150px" 
                                         ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "Jumlah","{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                           <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_Jumlah" Width="150px"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.Jumlah","{0:#,###,###0.00}") %>'>
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
                                                </telerik:GridTemplateColumn>    
                         
                                        <telerik:GridTemplateColumn UniqueName="dept_code" HeaderText="Cost Center" HeaderStyle-Width="100px"
                                                    SortExpression="dept_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                                    <FooterTemplate>Template footer</FooterTemplate>
                                                    <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <%#DataBinder.Eval(Container.DataItem, "dept_code")%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_cost_center" EnableLoadOnDemand="True" DataTextField="name"
                                                            OnItemsRequested="cb_cost_center_ItemsRequested" DataValueField="code" AutoPostBack="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>'
                                                            HighlightTemplatedItems="true" Height="190px" Width="100px" DropDownWidth="300px"
                                                             OnPreRender="cb_cost_center_PreRender">
                                                           <HeaderTemplate>
                                                             <table style="width: 300px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 80px;">
                                                                        Code
                                                                    </td>
                                                                    <td style="width: 200px;">
                                                                        Cost Center
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

                             
                             
                           