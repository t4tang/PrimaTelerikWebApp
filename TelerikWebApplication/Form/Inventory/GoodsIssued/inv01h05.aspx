<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h05.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.GoodsIssued.inv01h05" %>
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
                window.radopen("reportViewer_inv01h05.aspx?do_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            //function callBackFn(arg) {
            //    //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            //}
            //<![CDATA[
                Sys.Application.add_load(function() {
                $windowContentDemo.contentTemplateID = "<%=RadWindow_ContentTemplate.ClientID%>";
                $windowContentDemo.templateWindowID = "<%=RadWindow_ContentTemplate.ClientID %>";
                });
            //]]>
            function openWinContentTemplate() {
                var winDialog = $find("<%=RadWindow_ContentTemplate.ClientID%>");
                winDialog.show();
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
            <telerik:AjaxSetting AjaxControlID="cb_ref">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
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

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="1250px" Height="670px">
        <ContentTemplate>
            <div runat="server" style="padding:20px 10px 10px 10px;" id="searchParam">
                <table>
                    <tr>
                        <td style="width:200px">
                             <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  DateInput-Label="Date From "
                                DateInput-ReadOnly="true"></telerik:RadDatePicker> 
                        </td>
                        <td style="width:250px">
                             <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px" DateInput-Label="To Date " 
                                DateInput-ReadOnly="true"></telerik:RadDatePicker>
                        </td>
                        <td style="width:320px">
                              <telerik:RadComboBox ID="cb_Project_prm" runat="server" RenderMode="Lightweight" Label="Project" AutoPostBack="false"
                                EnableLoadOnDemand="True" Skin="MetroTouch"  OnItemsRequested="cb_Project_prm_ItemsRequested" EnableVirtualScrolling="true" 
                                Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px"
                                OnSelectedIndexChanged="cb_Project_prm_SelectedIndexChanged">
                              </telerik:RadComboBox>
                        </td>
                        <td>
                            <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Retrieve" BorderStyle="Solid" BackColor="Transparent"
                                  Width="120px" Height="25px" />
                        </td>
                        <td>
                            <asp:Button ID="btnOk" runat="server" OnClick="btnOk_Click" Text="Select & Close" BorderStyle="Solid" BackColor="Transparent"
                                  Width="120px" Height="25px" />
                        </td>
                    </tr>
                </table>
            </div>
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="12"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <ClientSettings EnablePostBackOnRowClick="true" >
                </ClientSettings>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="do_code" Font-Size="12px"
                                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                                CommandItemSettings-ShowRefreshButton="false">
                    <Columns> 
                        <telerik:GridClientSelectColumn UniqueName="SelectColumn" ></telerik:GridClientSelectColumn> 
                        <telerik:GridBoundColumn UniqueName="do_code" HeaderText="GI Number" DataField="do_code">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="ref_code" HeaderText="Reference" DataField="ref_code">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" 
                            FilterControlWidth="120px" >
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="Tgl" HeaderText="Date" DataField="Tgl" ItemStyle-Width="80px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="cust_code" HeaderText="Customer" DataField="cust_code" 
                            FilterControlWidth="120px" >
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="type_do" HeaderText="From" DataField="do_type" 
                            FilterControlWidth="120px" >
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
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

    <div  class="scroller" runat="server">
        <div style=" padding-left:15px; width:100%; border-bottom-color: #FF9933; border-bottom-width: 1px; border-bottom-style: inset;">
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
                    <td style="width:85%; text-align:right">
                        <telerik:RadLabel ID="lbl_form_name" Text="Good Issued" runat="server" style="font-weight:lighter; 
                            font-size:10px; font-variant: small-caps; padding-left:10px; 
                        padding-bottom:0px; font-size:x-large; color:Highlight"></telerik:RadLabel>
                    </td>
                </tr>
            </table>
        </div>

        <div class="table_trx" id="div1">
            <table id="Table1" border="0">
                <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module">
                            <tr>
                                <td class="tdLabel">
                                    GI Number:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_gi_number" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight" 
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Type*:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_type_ref" runat="server" Width="150"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Metro" AutoPostBack="true"
                                        OnItemsRequested="cb_type_ref_ItemsRequested" OnPreRender="cb_type_ref_PreRender"
                                        OnSelectedIndexChanged="cb_type_ref_SelectedIndexChanged" EmptyMessage="- Select a Type -"
                                        EnableVirtualScrolling="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Cust/Supp* :
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_CustSupp" runat="server" RenderMode="Lightweight" Skin="MetroTouch" EnableLoadOnDemand="true" EmptyMessage="-Select a Cust/Supp -" 
                                        EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" Enabled="true" Width="250" DropDownWidth="270px"  
                                        OnItemsRequested="cb_CustSupp_ItemsRequested" OnPreRender="cb_CustSupp_PreRender" OnSelectedIndexChanged="cb_CustSupp_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Project* :
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_Project" runat="server" RenderMode="Lightweight" Skin="MetroTouch" EnableLoadOnDemand="true" EmptyMessage="- Select a Project -" 
                                        EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="250" DropDownWidth="270px" 
                                        OnItemsRequested="cb_Project_ItemsRequested" OnPreRender="cb_Project_PreRender" OnSelectedIndexChanged="cb_Project_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Cost Center* :
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox ID="cb_CostCenter" runat="server" RenderMode="Lightweight" Skin="MetroTouch" EnableLoadOnDemand="true" AutoPostBack="false"
                                                            EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" Width="250" DropDownWidth="300px" EmptyMessage="- Select a Cost Center -"  
                                                            OnItemsRequested="cb_CostCenter_ItemsRequested" OnPreRender="cb_CostCenter_PreRender" OnSelectedIndexChanged="cb_CostCenter_SelectedIndexChanged">
                                                        </telerik:RadComboBox>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged" />  
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </td>
                                            <td>
                                                <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadTextBox ID="txt_CostCenterName" runat="server" Width="200px" ReadOnly="true" AutoPostBack="false" RenderMode="Lightweight" 
                                                            Label="Cost Name">
                                                        </telerik:RadTextBox>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>                                                                                                         
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Storage Loc* :
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_loc" runat="server" RenderMode="Lightweight" Skin="MetroTouch" EnableLoadOnDemand="true" EmptyMessage="- Select a Storage Loc -" 
                                                EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="false" Width="200" DropDownWidth="200px" AutoPostBack="false"  
                                                OnItemsRequested="cb_loc_ItemsRequested" OnPreRender="cb_loc_PreRender" OnSelectedIndexChanged="cb_loc_SelectedIndexChanged">
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
                    <td style="vertical-align: top; padding-left:15px">
                        <table id="Table3" border="0" class="module">
                            <tr>
                                <td class="tdLabel">
                                    Ref No.* :
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_ref" runat="server" RenderMode="Lightweight" Width="200px" DataTextField="doc_code" DataValueField="doc_code" 
                                                EnableLoadOnDemand="true" EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" Skin="MetroTouch" 
                                                OnItemsRequested="cb_ref_ItemsRequested" OnPreRender="cb_ref_PreRender" OnSelectedIndexChanged="cb_ref_SelectedIndexChanged" 
                                                DropDownWidth="650px" EmptyMessage="- Select a Reff -" AutoPostBack="true">
                                                <HeaderTemplate>
                                                    <table style="width: 450px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                Reff. No.
                                                            </td>
                                                            <td style="width: 300px;">
                                                                Remark
                                                            </td>                                                                
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 450px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.doc_code")%>
                                                            </td>
                                                            <td style="width: 300px;">
                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "doc_remark") %>'></asp:label> 
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
                                            <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>                                   
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Unit Code :
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_unit" runat="server" RenderMode="Lightweight" Skin="MetroTouch" Width="150px" 
                                                ReadOnly="true" AutoPostBack="false">
                                            </telerik:RadTextBox>                                          
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>                                   
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Date :
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_date" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="MetroTouch">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="MetroTouch"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                    </telerik:RadDatePicker>
                                    &nbsp
                                    Limit
                                    <telerik:RadTextBox ID="txt_limit" runat="server" Width="100px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false" >
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Receipt By :
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_receipt" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                                AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" Skin="MetroTouch" EnableLoadOnDemand="true" 
                                                HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" OnItemsRequested="cb_receipt_ItemsRequested" 
                                                OnPreRender="cb_receipt_PreRender" OnSelectedIndexChanged="cb_receipt_SelectedIndexChanged">
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
                                    Issued By :
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_issued" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                                AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" Skin="MetroTouch" EnableLoadOnDemand="true" 
                                                HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" OnItemsRequested="cb_issued_ItemsRequested" 
                                                OnPreRender="cb_issued_PreRender" OnSelectedIndexChanged="cb_issued_SelectedIndexChanged">
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
                                    Approval By :
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_approval" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                                AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select -" Skin="MetroTouch" EnableLoadOnDemand="true" 
                                                HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" OnItemsRequested="cb_approval_ItemsRequested" 
                                                OnPreRender="cb_approval_PreRender" OnSelectedIndexChanged="cb_approval_SelectedIndexChanged">
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
                                            &nbsp
                                            Posting
                                            <asp:CheckBox ID="chk_posting" runat="server" Checked="true"/>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Remark:
                                </td>                
                                <td style="vertical-align:top; text-align:left">                               
                                    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_remark" runat="server" TextMode="MultiLine"
                                                Width="350px" Rows="0" TabIndex="5" Resize="Both">
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>                                  
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
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="70px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding:0px 10px 0px 10px">
                                    Owner 
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="70px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width:135px;">
                                </td> 
                                <td style="width:80px; padding-left:15px">
                                    Last Update 
                                </td>
                                <td style="width:70px;">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_lastUpdate" Width="160px" runat="server" Skin="MetroTouch">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding:0px 10px 0px 10px">
                                    Printed 
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_printed" Width="70px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding:0px 10px 0px 10px">
                                    Edited
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="70px" runat="server" >
                                    </telerik:RadTextBox>
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
            <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 20px;">               
                 <telerik:RadGrid RenderMode="Lightweight" runat="server" ID="RadGrid2" AllowPaging="false" AllowSorting="true" AutoGenerateColumns="false"  
                            ClientSettings-Selecting-AllowRowSelect="true" GridLines="None" PageSize="5" OnNeedDataSource="RadGrid2_NeedDataSource" 
                            OnDeleteCommand="RadGrid2_DeleteCommand" ShowStatusBar="true" >
                    <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                    <MasterTableView CommandItemDisplay="Top" DataKeyNames="prod_code" Font-Size="12px" EditMode="Batch" 
                                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >
                        <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" /> 
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                        <ItemTemplate>
                                            <telerik:RadTextBox runat="server" ID="txt_ProdCode" Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>'></telerik:RadTextBox>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Original Material" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblProdCodeOri" Text='<%# DataBinder.Eval(Container.DataItem, "prod_code_ori") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridTemplateColumn HeaderText="Superior" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblSuperior" ></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                                        HeaderStyle-HorizontalAlign="Center" DefaultInsertValue="0"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                        <ItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_Part_Qty" Width="85px"  ReadOnly="true" EnabledStyle-HorizontalAlign="Right"
                                                NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2">
                                            </telerik:RadTextBox>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Uom" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "unit_code") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridTemplateColumn HeaderText="Cost Center" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblCostCntr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridTemplateColumn HeaderText="Storage Loc." HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblstorage" Text='<%# DataBinder.Eval(Container.DataItem, "wh_code") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridTemplateColumn HeaderText="Warranty" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblWarranty" Text='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblremark" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                        ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
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
        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Initial text" Position="BottomRight"
                    AutoCloseDelay="10000" Width="350" Height="110" Title="Current time" EnableRoundedCorners="true">
        </telerik:RadNotification>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
       
    </div>
</asp:Content>
