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
            //function ShowPreview(id) {
            //    window.radopen("ReportVieweracc01h01.aspx?NoBuk=" + id, "PreviewDialog");
            //    return false;
            //}
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
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>            
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="cb_project_prm">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="1110px" Height="580px">
        <%--LIST DATA--%>
        <ContentTemplate>
            <div runat="server" style="padding:20px 10px 10px 10px;" id="searchParam">                
                <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="Date From " Height="26px"></telerik:RadDatePicker>                
                <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="To Date " Height="26px"></telerik:RadDatePicker>
                <telerik:RadComboBox ID="cb_bank_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="Bank" AutoPostBack="false"
                    EnableLoadOnDemand="true" Skin="MetroTouch"  OnItemsRequested="cb_bank_prm_ItemsRequested" EnableVirtualScrolling="false" 
                    Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"
                    OnSelectedIndexChanged="cb_bank_prm_SelectedIndexChanged"></telerik:RadComboBox>&nbsp
                &nbsp
                <asp:Button ID="btnFind" runat="server" Text="Search" OnClick="btnFind_Click" />
                 &nbsp
                <asp:Button ID="btnOk" runat="server" Text="Select & Close" OnClick="btnOk_Click"/>
            </div>
                <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="10"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                    <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                    <ClientSettings EnablePostBackOnRowClick="true" >
                    </ClientSettings>
                    <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="slip_no" Font-Size="12px" ShowHeadersWhenNoRecords="true"
                     EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                     CommandItemSettings-ShowRefreshButton="false">
                        <Columns>
                            <telerik:GridBoundColumn UniqueName="slip_no" HeaderText="Reg. No" DataField="slip_no">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="cashbank" HeaderText="Bank Code" DataField="cashbank">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="noctrl" HeaderText="Ctrl. No" DataField="noctrl">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridDateTimeColumn UniqueName="doc_date" HeaderText="Date" DataField="doc_date" ItemStyle-Width="80px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                                DataFormatString="{0:d}" >
                            <HeaderStyle Width="80px"></HeaderStyle>
                            </telerik:GridDateTimeColumn>
                            <telerik:GridBoundColumn UniqueName="supplier_name" HeaderText="Supplier" DataField="supplier_name">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="cur_code" HeaderText="Curr" DataField="cur_code">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="kurs" HeaderText="Kurs" DataField="kurs">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="tot_pay" HeaderText="Tot. Amount" DataField="tot_pay">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="Remark" HeaderText="Remark" DataField="Remark">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
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
    <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 20px;">
        <table id="tbl_control">
            <tr>
                <td style="text-align:right;">
                        <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                            Height="30px" Width="35px" ImageUrl="~/Images/list.png" >                            
                        </asp:ImageButton>
                </td>
                <td style="vertical-align:middle; margin-left:10px">
                        <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click"
                            Height="37px" Width="49px" ImageUrl="~/Images/add.png">
                        </asp:ImageButton>
                </td>
                <td style="vertical-align:middle; margin-left:20px">
                    <asp:ImageButton runat="server" ID="btnEdit" AlternateText="Edit" OnClick="btnEdit_Click"
                        Height="25px" Width="30px" ImageUrl="~/Images/edit.png">
                    </asp:ImageButton>
                </td>
                <td style="vertical-align:top; margin-left:20px;padding-left:7px">
                    <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" OnClick="btnSave_Click"
                        Height="37px" Width="38px" ImageUrl="~/Images/save.png">
                    </asp:ImageButton>
                </td>
                <td style="vertical-align:middle; margin-left:10px;padding-left:3px">
                    <asp:ImageButton runat="server" ID="btnPrint" AlternateText="Print" 
                        Height="35px" Width="35px" ImageUrl="~/Images/printer.png">
                    </asp:ImageButton>
                </td>
                <td style="width:89%; text-align:right">
                        <telerik:RadLabel ID="lbl_form_name" Text="Bank Payment Voucher" runat="server" style="font-weight:lighter; 
                            font-size:10px; font-variant: small-caps; padding-left:10px; 
                        padding-bottom:0px; font-size:x-large; color:Highlight"></telerik:RadLabel>
                    </td>
            </tr>
        </table>
    </div>
    <%--HEADER--%>
    <div class="table_trx">       
        <table id="Table2" width="Auto" border="0" class="module">
            <tr style="vertical-align: top">
                <td style="vertical-align:top">
                        <table>
                            <tr>
                                <td class="tdLabel">
                                    Reg No :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_slip_number" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                        &nbsp;
                                        Posting :
                                    <asp:CheckBox ID="chk_posting" runat="server" Checked="true"/>
                                </td>                                           
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Supplier:
                                </td>
                                <td style="vertical-align:top; text-align:left">                      
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="200" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged" OnPreRender="cb_project_PreRender">
                                    </telerik:RadComboBox>
                                                        
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Currency :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_currency" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                    Kurs :
                                    <telerik:RadTextBox ID="txt_kurs" runat="server" Width="108px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Reference:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ref" runat="server" Width="150"
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
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_bank" runat="server" Width="200" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Bank -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        OnItemsRequested="cb_bank_ItemsRequested" OnSelectedIndexChanged="cb_bank_SelectedIndexChanged" OnPreRender="cb_bank_PreRender">
                                    </telerik:RadComboBox>
                                    &nbsp;
                                    Curr :
                                    <telerik:RadTextBox ID="txt_curr2" runat="server" Width="60px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Doc Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_bpv"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Metro"> 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>                                                    
                                        </DateInput>                         
                                    </telerik:RadDatePicker>
                                    &nbsp;
                                    Kurs :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <telerik:RadTextBox ID="txt_kurs2" runat="server" Width="95px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Cashed Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_cashed" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Silk">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        </DateInput>
                                        
                                    </telerik:RadDatePicker>
                                    &nbsp;
                                    Ctrl No :
                                    <telerik:RadTextBox ID="txt_ctrl" runat="server" Width="95px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
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
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select -" EnableLoadOnDemand="True" Skin="MetroTouch"
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
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select -" EnableLoadOnDemand="True" Skin="MetroTouch"  
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
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        OnItemsRequested="txt_pre_ItemsRequested" OnSelectedIndexChanged="txt_pre_SelectedIndexChanged" OnPreRender="txt_pre_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    User :                                                
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_user" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Last Update :                          
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_lastupdate" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Remark :
                                </td>
                                <td>                                                
                                    <telerik:RadTextBox ID="txt_remark" runat="server" Width="250px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false" TextMode="MultiLine">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                </td>
            </tr>
        </table>
        <%--DETAIL--%>
            <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 20px;">
                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"
                    AllowPaging="true" AllowSorting="true" runat="server"  OnNeedDataSource="RadGrid2_NeedDataSource"
                    AllowAutomaticUpdates="true" AllowAutomaticInserts="True" ShowStatusBar="true" 
                    ClientSettings-Selecting-AllowRowSelect="true">   
                        <MasterTableView CommandItemDisplay="Top" Font-Size="12px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" DataKeyNames="inv_code">                                             
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                                        
                            <Columns>
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                    HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update">
                                </telerik:GridEditCommandColumn>                        
                                <telerik:GridTemplateColumn UniqueName="inv_code" HeaderText="Reg. Number" HeaderStyle-Width="170px"
                                    SortExpression="inv_code" ItemStyle-Width="120px">
                                    <FooterTemplate>Template footer</FooterTemplate>
                                    <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "inv_code")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="cb_inv_code" DataTextField="Reg. Number"
                                            OnItemsRequested="cb_inv_code_ItemsRequested" DataValueField="inv_code" Text='<%# DataBinder.Eval(Container, "DataItem.inv_code") %>'
                                            HighlightTemplatedItems="true" Width="130px">
                                            <%--<HeaderTemplate>
                                                <ul>
                                                    <li class="col1">Prod. Code</li>
                                                    <li class="col2">Prod. Name</li>
                                                </ul>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <ul>
                                                    <li class="col1" >
                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                    </li>
                                                    <li class="col2">
                                                        <%# DataBinder.Eval(Container, "Attributes['spec']")%></li>
                                                </ul>
                                            </ItemTemplate>--%>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                            
                                <telerik:GridTemplateColumn HeaderText="Invoice Number" ItemStyle-Width="200px">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "fkno")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_inv_number" Width="180px" ReadOnly="true"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.fkno") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn> 
                                <telerik:GridTemplateColumn HeaderText="Inv Date" ItemStyle-Width="250px" ItemStyle-HorizontalAlign="Center" DefaultInsertValue="0">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "slip_date", "{0:dd-MM-yyyy}")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_date" Width="100px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            Text='<%# DataBinder.Eval(Container.DataItem, "slip_date", "{0:dd-MM-yyyy}") %>'
                                            onkeydown="blurTextBox(this, event)"
                                            AutoPostBack="true" MaxLength="11" Type="Date" 
                                            >
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn> 
                                <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="180px">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "remark")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" Width="150px" runat="server" ID="txt_remark"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'
                                            EnableLoadOnDemand="True" Skin="MetroTouch" DataTextField="remark" DataValueField="remark" >
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Amount" ItemStyle-Width="130px" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "pay_amount", "{0:#,###,###0.00}")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_amount" Width="150px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            Text='<%# DataBinder.Eval(Container.DataItem, "pay_amount", "{0:#,###,###0.00}") %>'
                                            onkeydown="blurTextBox(this, event)" EnabledStyle-HorizontalAlign="Right"
                                            AutoPostBack="true" MaxLength="11" Type="Money"
                                            >
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
                                                    HighlightTemplatedItems="true" Height="190px" Width="100px"
                                                    OnSelectedIndexChanged="cb_project_detail_SelectedIndexChanged" OnPreRender="cb_project_detail_PreRender">
                                                    <HeaderTemplate>
                                                       <%-- <ul>
                                                            <li class="col1">Code</li>
                                                            <li class="col2">Project</li>
                                                        </ul>--%>
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
                                                       <%-- <ul>
                                                            <li class="col1" >
                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                            </li>
                                                            <li class="col2">
                                                                <%# DataBinder.Eval(Container, "Attributes['region_name']")%></li>
                                                        </ul>--%>
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
                                                    <%--     <ul>
                                                            <li class="col1">Code</li>
                                                            <li class="col2">Cost Center</li>
                                                        </ul/
                                                    --%>
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
                                                       <%-- <ul>
                                                            <li class="col1" >
                                                                <%# DataBinder.Eval(Container, "Attributes['code']")%>
                                                            </li>
                                                            <li class="col2">
                                                                <%# DataBinder.Eval(Container, "Attributes['name']")%></li>
                                                        </ul>--%>

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
                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                </telerik:GridButtonColumn>
                             
                            </Columns>
                        </MasterTableView>
                    <ClientSettings>
                        <ClientEvents OnRowDblClick="rowDblClick"/>
                    </ClientSettings>
                 </telerik:RadGrid>
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
    </div>



</asp:Content>
