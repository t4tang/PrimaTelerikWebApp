<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h07.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Ledger.GeneralJournal.acc01h07" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../../../../Script/Script.js"></script>
    <link href="../../../../../Styles/custom-cs.css" rel="stylesheet" />
    <link href="../../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../../Styles/mail.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../../Script/Script.js"></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("reportViewer.aspx?doc_no=" + id, "PreviewDialog");
                return false;
            }
            
        </script>
    </telerik:RadCodeBlock>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>            
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
             
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone" Modal="true" Width="1110px" Height="580px">
        <ContentTemplate>
            <div runat="server" style="padding:20px 10px 10px 10px;" id="searchParam">
                <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="Date From" Height="26px"></telerik:RadDatePicker>
                <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="To Date" Height="26px"></telerik:RadDatePicker>
                <telerik:RadComboBox ID="cb_GeneralJournal_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="General" AutoPostBack="false" 
                    EnableLoadOnDemand="true" Skin="MetroTouch" Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" 
                    EnableVirtualScrolling="true" OnItemsRequested="cb_GeneralJournal_prm_ItemsRequested" OnSelectedIndexChanged="cb_GeneralJournal_prm_SelectedIndexChanged">
                </telerik:RadComboBox>
                &nbsp
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                <asp:Button ID="btnOK" runat="server" Text="Select & Close" OnClick="btnOK_Click" />
            </div>

            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch" AllowSorting="true" AutoGenerateColumns="false" 
                ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="10" OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="voucherno" Font-Size="12px" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" 
                    CommandItemSettings-ShowAddNewRecordButton="false" CommandItemSettings-ShowRefreshButton="false">
                    <Columns>
                        <telerik:GridBoundColumn UniqueName="voucherno" HeaderText="JU Number" DataField="voucherno">
                            <HeaderStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="ref_code" HeaderText="Reference" DataField="ref_code" FilterControlWidth="90px">
                            <HeaderStyle Width="90px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="date" HeaderText="Date" DataField="date" ItemStyle-Width="80px" EnableRangeFiltering="false" FilterControlWidth="80px" 
                            PickerType="DatePicker" DataFormatString="{0:d}">
                            <HeaderStyle Width="80px" />
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="cur_code" HeaderText="Currency" DataField="cur_code" FilterControlWidth="120px">
                            <HeaderStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="kurs" HeaderText="Kurs" DataField="kurs" FilterControlWidth="90px">
                            <HeaderStyle Width="90px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="amount" HeaderText="Amount" DataField="debet" FilterControlWidth="120px">
                            <HeaderStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="user" HeaderText="User" DataField="userid" FilterControlWidth="90px">
                            <HeaderStyle Width="90px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete"  ConfirmText="Are You Sure ?" ConfirmTitle="Delete" 
                            ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
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
        <div style="padding-left:15px;width:100%;border-bottom-color:#FF6600;border-bottom-width:1px;border-bottom-style:inset;">
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
                        <telerik:RadLabel ID="lbl_form_name" Text="Cash Mutation" runat="server" style="font-weight:lighter; 
                            font-size:10px; font-variant: small-caps; padding-left:10px; 
                        padding-bottom:0px; font-size:x-large; color:Highlight"></telerik:RadLabel>
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
                                    JU Number:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_voucherno" runat="server" Width="180px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Ref. No:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_ref" runat="server" Width="180px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Ctrl. No:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_ctrl" runat="server" Width="180px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
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
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Currency:
                                </td>
                                <td style="vertical-align:top; text-align:left">                      
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_currency" runat="server" Width="150px" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="false" EmptyMessage="- Select a Currency -" Skin="MetroTouch" EnableLoadOnDemand="true"  
                                        OnItemsRequested="cb_Cash_ItemsRequested" OnSelectedIndexChanged="cb_Cash_SelectedIndexChanged" 
                                        OnPreRender="cb_Cash_PreRender">
                                    </telerik:RadComboBox>               
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Kurs:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_kurs" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
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
                                    <telerik:RadTextBox ID="txt_user" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    User:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_lastupdate" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
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
                            OnDeleteCommand="RadGrid2_DeleteCommand" ClientSettings-Selecting-AllowRowSelect="true">
                            <MasterTableView CommandItemDisplay="Top" DataKeyNames="KoRek" Font-Size="12px" EditMode="InPlace"
                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False">
                                <CommandItemSettings ShowRefreshButton="false" ShowSaveChangesButton="false" />
                                <Columns>
                                    <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                            HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update">
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridTemplateColumn UniqueName="KoRek" HeaderText="Account No." ItemStyle-Width="120px" 
                                            SortExpression="KoRek">
                                        <FooterTemplate>Template footer</FooterTemplate>
                                        <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>                                       
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_KoRek" EnableLoadOnDemand="True" AutoPostBack="true" 
                                                        OnItemsRequested="cb_KoRek_ItemsRequested" DataValueField="KoRek" DataTextField="accountname"
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
                                    <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="350px">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "Ket")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark" Width="350px" Text='<%# DataBinder.Eval(Container, "DataItem.Ket") %>'>
                                            </telerik:RadTextBox>                                                 
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Kurs" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "kurs","{0:#,###,###0.00000000}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox ID="txt_kurs" runat="server" Width="100px" Enabled="true" RenderMode="Lightweight"
                                                AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.kurs") %>' >
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Amount" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "Jumlah","{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_amount" Width="120px" Text='<%# DataBinder.Eval(Container, "DataItem.Jumlah","{0:#,###,###0.00}") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Amount" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "Jumlah","{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_amount" Width="120px" Text='<%# DataBinder.Eval(Container, "DataItem.Jumlah","{0:#,###,###0.00}") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Amount" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "Jumlah","{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_amount" Width="120px" Text='<%# DataBinder.Eval(Container, "DataItem.Jumlah","{0:#,###,###0.00}") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Amount" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "Jumlah","{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_amount" Width="120px" Text='<%# DataBinder.Eval(Container, "DataItem.Jumlah","{0:#,###,###0.00}") %>'>
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
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Project_Detail" DropDownWidth="350px" 
                                                        EnableLoadOnDemand="True" Skin="MetroTouch" DataValueField="region_code" DataTextField="region_name" 
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
                                        <telerik:GridTemplateColumn UniqueName="dept_code" HeaderText="Cost Center" HeaderStyle-Width="100px"
                                            SortExpression="dept_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                            <FooterTemplate>Template footer</FooterTemplate>
                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "dept_code")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>                                               
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_Cost_Center" DropDownWidth="350px" AutoPostBack="false"  
                                                        EnableLoadOnDemand="True" Skin="MetroTouch" DataValueField="code" DataTextField="name" 
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
