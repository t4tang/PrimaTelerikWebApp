<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h04.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.GoodReceive.inv01h04" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    
    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("reportViewer.aspx?doc_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
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
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>            
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <%--<telerik:AjaxSetting AjaxControlID="btnOk">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>--%>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="1250px" Height="670px">
            <%--LIST DATA--%>
        <ContentTemplate>
            <div runat="server" style="padding:20px 10px 10px 10px;" id="searchParam">
               <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  DateInput-Label="Date From "
                                      DateInput-ReadOnly="true"></telerik:RadDatePicker> 
                 <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px" DateInput-Label="To Date " 
                                        DateInput-ReadOnly="true"></telerik:RadDatePicker>
                 <telerik:RadComboBox ID="cb_project_prm" runat="server" RenderMode="Lightweight" Label="Project" AutoPostBack="false"
                                      EnableLoadOnDemand="True" Skin="MetroTouch" EnableVirtualScrolling="true" OnItemsRequested="cb_project_prm_ItemsRequested" ShowMoreResultsBox="true" 
                                      Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px" OnSelectedIndexChanged="cb_project_prm_SelectedIndexChanged">
                 </telerik:RadComboBox>
                         &nbsp
                         <asp:Button ID="btnSearch" runat="server" Text="Retrieve" BorderStyle="Solid" BackColor="Transparent"
                                  Width="120px" Height="25px" OnClick="btnSearch_Click" />
                         &nbsp
                         <asp:Button ID="btnOk" runat="server" Text="Select & Close" BorderStyle="Solid" BackColor="Transparent"
                                  Width="120px" Height="25px" OnClick="btnOk_Click" />
            </div>
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="12"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <ClientSettings EnablePostBackOnRowClick="true" >
                </ClientSettings>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="doc_code" Font-Size="12px"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                     CommandItemSettings-ShowRefreshButton="false" >                    
                    <Columns>
                        <telerik:GridClientSelectColumn UniqueName="SelectColumn" ></telerik:GridClientSelectColumn> 
                        <telerik:GridBoundColumn UniqueName="doc_code" HeaderText="UR Number" DataField="doc_code">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="doc_date" HeaderText="Date" DataField="doc_date" ItemStyle-Width="80px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" 
                            FilterControlWidth="120px" >
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="wo_desc" HeaderText="Status" DataField="wo_desc" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="doc_remark" HeaderText="Remark" DataField="doc_remark" ItemStyle-Wrap="true"
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
                    <ClientEvents OnRowDblClick="RowDblClick" />
                </ClientSettings>
            </telerik:RadGrid>
        </ContentTemplate>
    </telerik:RadWindow>
    <%--ICONS--%>
     <div style=" padding-left:15px; width:100%; border-bottom-color: #FF6600; border-bottom-width: 1px; border-bottom-style: inset;">
        <table id="tbl_control">
            <tr>
                <td  style="text-align:right;">
                    <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                        Height="30px" Width="35px" ImageUrl="~/Images/daftar.png">
                    </asp:ImageButton>                        
                </td>
                <td style="vertical-align:middle; margin-left:10px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click"
                        Height="30px" Width="35px" ImageUrl="~/Images/tambah.png">
                    </asp:ImageButton>
                </td>
               
                <td style="vertical-align:middle; margin-left:10px;padding-left:0px">
                    <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" OnClick="btnSave_Click"
                        Height="30px" Width="32px" ImageUrl="~/Images/simpan-gray.png">
                    </asp:ImageButton>
                </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:13px">
                    <asp:ImageButton runat="server" ID="btnPrint" AlternateText="Print"
                        Height="30px" Width="32px" ImageUrl="~/Images/cetak-gray.png">
                    </asp:ImageButton>
                </td>   
                <td style="width:87%; text-align:right">
                    <telerik:RadLabel ID="lbl_form_name" Text="Good Receive" runat="server" style="font-weight:lighter; 
                        font-size:10px; font-variant: small-caps; padding-left:10px; 
                    padding-bottom:0px; font-size:x-large; color:Highlight">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>
        <%--HEADER--%>
        <div class="table_trx" id="div1">
            <table id="Table1" border="0">
                <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module">
                            <tr>
                                <td class="tdLabel">
                                    GR No :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_gr_number" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    From :
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_from" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"
                                        EnableVirtualScrolling="true" Skin="MetroTouch" OnItemsRequested="rb_from_ItemsRequested"
                                        OnSelectedIndexChanged="rb_from_SelectedIndexChanged" OnPreRender="rb_from_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_gr" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="MetroTouch"> 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="MetroTouch" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Project Area:
                                </td>
                                <td style="vertical-align:top; text-align:left">                      
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="200" DropDownWidth="300px"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged" OnPreRender="cb_project_PreRender">
                                    </telerik:RadComboBox>          
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Supplier:
                                </td>
                                <td style="vertical-align:top; text-align:left">                      
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="200" DropDownWidth="300px"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select a Supplier -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        OnItemsRequested="cb_supplier_ItemsRequested" OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged" OnPreRender="cb_supplier_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table id="Table3" width="Auto" border="0" class="module">
                            <tr>
                                <td class="tdLabel">
                                    Ref. No:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ref" runat="server" Width="200px" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Ref. Date :
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_ref" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Metro" Enabled="false">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Cost Center:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_costcenter" runat="server" Width="200" DropDownWidth="300px"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        OnItemsRequested="cb_costcenter_ItemsRequested" OnSelectedIndexChanged="cb_costcenter_SelectedIndexChanged" OnPreRender="cb_costcenter_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Delivery Note:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_delivery_note" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    storage Location:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_storage" runat="server" Width="200" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        OnItemsRequested="cb_storage_ItemsRequested" OnSelectedIndexChanged="cb_storage_SelectedIndexChanged" OnPreRender="cb_storage_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>   
                        </table>
                        </td>
                        <td>
                        <table id="Table4" width="Auto" border="0" class="module">
                            <tr>
                                <td class="tdLabel">
                                    Created by :
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_created" runat="server" Width="250" DropDownWidth="300px"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        OnItemsRequested="cb_created_ItemsRequested" OnSelectedIndexChanged="cb_created_SelectedIndexChanged" OnPreRender="cb_created_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Received by :
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_received" runat="server" Width="250" DropDownWidth="300px"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        OnItemsRequested="cb_received_ItemsRequested" OnSelectedIndexChanged="cb_received_SelectedIndexChanged" OnPreRender="cb_received_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Approved by :
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250" DropDownWidth="300px"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        OnItemsRequested="cb_approved_ItemsRequested" OnSelectedIndexChanged="cb_approved_SelectedIndexChanged" OnPreRender="cb_approved_PreRender">
                                    </telerik:RadComboBox>
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
                <tr>
                    <td colspan="3" style="padding-top:40px; padding-bottom:20px;">
                        <table>
                            <tr>
                                <td style="padding:0px 10px 0px 10px">
                                    User 
                                </td>
                                <td style="width:50px">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="50px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width:80px; padding-left:15px">
                                    Last Update 
                                </td>
                                <td style="width:70px;">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_lastUpdate" Width="160px" runat="server" Skin="MetroTouch">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding:0px 10px 0px 10px">
                                    Owner 
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="50px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding:0px 10px 0px 10px">
                                    Printed 
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_printed" Width="40px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding:0px 10px 0px 10px">
                                    Edited
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding:0px 10px 0px 10px">
                                    Posting
                                </td>
                                <td>
                                    <telerik:RadCheckBox ID="chk_posting" runat="server" Checked="true">
                                    </telerik:RadCheckBox>
                                </td>                                 
                            </tr>
                            <tr>
                                <td colspan="5">
                                    <asp:Label ID="lbl_result" runat="server"></asp:Label>
                                </td>
                            </tr>
                            
                        </table>
                    </td>
                </tr>
            </table>
             <%--DETAIL--%>
            <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 20px;">
                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"
                    AllowPaging="true" AllowSorting="true" runat="server" OnNeedDataSource="RadGrid2_NeedDataSource"
                    AllowAutomaticUpdates="true" AllowAutomaticInserts="True" ShowStatusBar="true" 
                    ClientSettings-Selecting-AllowRowSelect="true" OnDeleteCommand="RadGrid2_DeleteCommand">
                        <MasterTableView CommandItemDisplay="Top" Font-Size="12px" EditMode="InPlace"
                                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" DataKeyNames="lbm_code">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                                        
                            <Columns>
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                    HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn HeaderText="Invoice Number" ItemStyle-Width="130px">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "inv_code")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_inv_number" Width="180px" ReadOnly="false"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.inv_code") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn> 
                                <telerik:GridTemplateColumn HeaderText="Invoice Number" ItemStyle-Width="130px">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "inv_code")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_inv_number" Width="180px" ReadOnly="false"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.inv_code") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn> 
                                <telerik:GridTemplateColumn HeaderText="Invoice Number" ItemStyle-Width="130px">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "inv_code")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_inv_number" Width="180px" ReadOnly="false"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.inv_code") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn> 
                                <telerik:GridTemplateColumn HeaderText="Invoice Number" ItemStyle-Width="130px">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "inv_code")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_inv_number" Width="180px" ReadOnly="false"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.inv_code") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Invoice Number" ItemStyle-Width="130px">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "inv_code")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_inv_number" Width="180px" ReadOnly="false"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.inv_code") %>'>
                                        </telerik:RadTextBox>
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
                                                    DataValueField="code" AutoPostBack="false"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>'
                                                    HighlightTemplatedItems="true" Height="190px" Width="100px" DropDownWidth="300px"
                                                    >
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
                                <telerik:GridTemplateColumn HeaderText="Invoice Number" ItemStyle-Width="130px">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "inv_code")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_inv_number" Width="180px" ReadOnly="false"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.inv_code") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn> 
                                <telerik:GridTemplateColumn HeaderText="Invoice Number" ItemStyle-Width="130px">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "inv_code")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_inv_number" Width="180px" ReadOnly="false"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.inv_code") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn> 
                                <telerik:GridTemplateColumn HeaderText="Invoice Number" ItemStyle-Width="130px">
                                    <ItemTemplate>  
                                        <%#DataBinder.Eval(Container.DataItem, "inv_code")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_inv_number" Width="180px" ReadOnly="false"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.inv_code") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn> 
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
