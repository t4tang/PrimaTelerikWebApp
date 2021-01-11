<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h03.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.ReservationSlip.inv01h03" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js"></script>
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
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
        </script>
    </telerik:RadCodeBlock>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel22" runat="server">
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
            <telerik:AjaxSetting AjaxControlID="RadGrid2">
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
        Modal="true" Width="1400px" Height="700px">
        <ContentTemplate>
            <div runat="server" style="padding: 20px 10px 10px 10px;" id="searchParam">
                <table>
                    <tr>
                        <td style="width: 200px">
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px" DateInput-Label="Date From "
                                DateInput-ReadOnly="true" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                        <td style="width: 250px">
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px" DateInput-Label="To Date "
                                DateInput-ReadOnly="true" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                        <td style="width: 320px">
                            <telerik:RadComboBox ID="cb_project_prm" runat="server" RenderMode="Lightweight" Label="Project" AutoPostBack="false"
                                EnableLoadOnDemand="True" Skin="MetroTouch" OnItemsRequested="cb_project_prm_ItemsRequested" EnableVirtualScrolling="true"
                                Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px"
                                OnSelectedIndexChanged="cb_project_SelectedIndexChanged">
                            </telerik:RadComboBox>
                        </td>
                        <td>
                            <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Retrieve" Width="120px" Height="25px" />
                        </td>

                        <td>
                            <asp:Button ID="btnOk" runat="server" OnClick="btnOk_Click" Text="Select & Close" Width="120px" Height="25px" />
                        </td>
                    </tr>
                </table>
            </div>
            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="12"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <ClientSettings EnablePostBackOnRowClick="true">
                </ClientSettings>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="doc_code" Font-Size="12px"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                    CommandItemSettings-ShowRefreshButton="false">
                    <Columns>
                        <telerik:GridClientSelectColumn UniqueName="SelectColumn"></telerik:GridClientSelectColumn>
                        <telerik:GridBoundColumn UniqueName="doc_code" HeaderText="Reservation Slip" DataField="doc_code" ItemStyle-Width="110px">
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="doc_date" HeaderText="Date" DataField="doc_date" ItemStyle-Width="80px"
                            EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker"
                            DataFormatString="{0:d}">
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="sro_code" HeaderText="Ref Code" DataField="sro_code">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="no_wo" HeaderText="WO Number" DataField="no_wo">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="unit_code" HeaderText="Unit" DataField="unit_code" ItemStyle-Width="110px">
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" ItemStyle-Width="120px"
                            FilterControlWidth="120px">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn UniqueName="doc_remark" HeaderText="Remark" DataField="doc_remark" ItemStyle-Wrap="true"
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
                    <ClientEvents OnRowDblClick="RowDblClick" />
                </ClientSettings>
            </telerik:RadGrid>

        </ContentTemplate>
    </telerik:RadWindow>

    <div class="scroller" runat="server">

        <div style="padding-left: 15px; width: 100%; border-bottom-color: #FF9933; border-bottom-width: 1px; border-bottom-style: inset;">
            <table id="tbl_control">
                <tr>

                    <td style="text-align: right; vertical-align: middle;">
                        <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                            Height="30px" Width="35px" ImageUrl="~/Images/daftar.png"></asp:ImageButton>
                    </td>
                    <td style="vertical-align: middle; margin-left: 10px; padding-left: 8px">
                        <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                    </td>
                    <td style="vertical-align: middle; margin-left: 10px; padding-left: 13px">
                        <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" OnClick="btnSave_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/simpan-gray.png"></asp:ImageButton>
                    </td>
                    <td style="vertical-align: middle; margin-left: 10px; padding-left: 13px">
                        <asp:ImageButton runat="server" ID="btnPrint" AlternateText="Print" OnClick="btnPrint_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/cetak-gray.png"></asp:ImageButton>
                    </td>
                    <td style="width: 85%; text-align: right">
                        <telerik:RadLabel ID="lbl_form_name" Text="Reservation Slip" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; padding-bottom: 0px; font-size: x-large; color: Highlight">
                        </telerik:RadLabel>
                    </td>
                </tr>
            </table>
        </div>

        <div runat="server" class="table_trx" id="div1">
            <table id="Table1" border="0">
                <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module">
                            <tr>
                                <td class="tdLabel">RS No:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_doc_code" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">Doc Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_rs" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="MetroTouch">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="MetroTouch"
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;">
                                        </Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">Excute Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_exe" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="MetroTouch">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"
                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="MetroTouch">
                                        </Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">Type Ref:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_type_ref" runat="server" Width="150"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Metro" AutoPostBack="true"
                                        OnItemsRequested="cb_type_ref_ItemsRequested" OnPreRender="cb_type_ref_PreRender"
                                        OnSelectedIndexChanged="cb_type_ref_SelectedIndexChanged"
                                        EnableVirtualScrolling="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">Project Area:
                                </td>
                                <td style="vertical-align: top; text-align: left">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" EnableLoadOnDemand="True" Skin="MetroTouch"
                                        OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                        OnPreRender="cb_project_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">Warehouse:
                                </td>
                                <td style="vertical-align: top; text-align: left">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="300" DropDownWidth="300px"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EmptyMessage="- Select a Warehouse -" EnableLoadOnDemand="True" Skin="MetroTouch"
                                        OnItemsRequested="cb_warehouse_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged"
                                        OnPreRender="cb_warehouse_PreRender">
                                    </telerik:RadComboBox>                                        
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">Remark:
                                </td>
                                <td style="vertical-align: top; text-align: left">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_remark" runat="server" TextMode="MultiLine"
                                                Width="350px" Rows="0" TabIndex="5" Resize="Both">
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                                   
                        </table>
                    </td>
                    <td style="vertical-align: top; padding-left: 15px; width:500px">
                            <table id="Table3" border="0">                          
                                 <tr>
                                    <td class="tdLabel">Reference:
                                    </td>
                                    <td style="vertical-align: top; text-align: left; width:300px;padding-left:4px" > 
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>                                       
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ref" runat="server" Width="250px" DropDownWidth="620px" 
                                            AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select Reff. Number -" EnableLoadOnDemand="True" Skin="MetroTouch" 
                                            DataTextField="doc_code" DataValueField="doc_code"
                                            OnItemsRequested="cb_ref_ItemsRequested" OnSelectedIndexChanged="cb_ref_SelectedIndexChanged"
                                            OnPreRender="cb_ref_PreRender">
                                            <HeaderTemplate>
                                            <table style="width: 620px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 120px;">Reff. No.
                                                    </td>
                                                    <td style="width: 500px;">Remark
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 620px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 120px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.doc_code")%>
                                                    </td>
                                                    <td style="width: 500px; text-align:left">
                                                        <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:label>                                                                    
                                                    </td>
                                                </tr>
                                            </table>

                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>     
                                    </td>

                                </tr>
                                <tr>
                                    <td class="tdLabel">Unit:
                                    </td>                                    
                                    <td >
                                        <table>
                                            <tr>
                                                                                   
                                                <td>
                                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                    <ContentTemplate>
                                                    <telerik:RadTextBox ID="txt_unit_code" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight"
                                                        AutoPostBack="false">
                                                    </telerik:RadTextBox>
                                                     </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </td>
                                                
                                                <td>
                                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadTextBox ID="txt_unit_name" runat="server" Width="220px" ReadOnly="true" RenderMode="Lightweight"
                                                            AutoPostBack="false" Label="Unit Name">
                                                        </telerik:RadTextBox>
                                                    </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </td>
                                            </tr>
                                        </table>
                                           
                                   </td>
                                    
                                </tr>
                                <tr>
                                    <td class="tdLabel">HM:
                                    </td>
                                    <td style="padding-left:4px">
                                        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_hm" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight"
                                                AutoPostBack="false">
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">Cost Center:
                                    </td>
                                    <td>
                                        <table>
                                            <tr>                                                
                                                <td>
                                                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadTextBox ID="txt_cost_center" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight"
                                                            AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                    </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </td>
                                                 
                                                <td>
                                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadTextBox ID="txt_cost_name" runat="server" Width="250px" ReadOnly="true" RenderMode="Lightweight"
                                                            AutoPostBack="false" Label="Cost Ctr. Name">
                                                        </telerik:RadTextBox>
                                                    </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">Order By:
                                    </td>
                                    <td style="vertical-align: top; text-align: left; padding-left:4px">
                                        <telerik:RadComboBox ID="cb_orderBy" runat="server" Width="250px"
                                            DropDownWidth="650px" EmptyMessage="- Select -" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                            MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true" OnItemsRequested="cb_order_ItemsRequested"
                                            OnSelectedIndexChanged="cb_order_SelectedIndexChanged"
                                                    OnPreRender="cb_order_PreRender">
                                             <HeaderTemplate>
                                                        <table style="width: 650px; font-size: smaller">
                                                            <tr>
                                                                <td style="width: 300px;">Name
                                                                </td>
                                                                <td style="width: 350px;">Position
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 650px; font-size: smaller">
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
                                                    </FooterTemplate>
                                        </telerik:RadComboBox>
                                    </td>
                                

                                </tr>
                                <tr>
                                    <td class="tdLabel">Received By:
                                    </td>
                                    <td colspan="2" style="vertical-align: top; text-align: left; padding-left:4px">
                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_received" runat="server" Width="250px"
                                            DropDownWidth="650px" EmptyMessage="- Select -" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                            MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true"
                                            OnItemsRequested="cb_received_ItemsRequested" OnSelectedIndexChanged="cb_received_SelectedIndexChanged"
                                            OnPreRender="cb_received_PreRender">
                                            <HeaderTemplate>
                                                <table style="width: 650px; font-size: smaller">
                                                    <tr>
                                                        <td style="width: 300px;">Name
                                                        </td>
                                                        <td style="width: 350px;">Position
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 650px; font-size: smaller">
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
                                            </FooterTemplate>
                                        </telerik:RadComboBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="tdLabel">Approved By:
                                    </td>
                                    <td colspan="2" style="vertical-align: top; text-align: left; padding-left:4px">
                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px"
                                            DropDownWidth="650px" EmptyMessage="- Select -" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                            MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true"
                                            OnItemsRequested="cb_approved_ItemsRequested" OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                            OnPreRender="cb_approved_PreRender">
                                            <HeaderTemplate>
                                                <table style="width: 650px; font-size: smaller">
                                                    <tr>
                                                        <td style="width: 300px;">Name
                                                        </td>
                                                        <td style="width: 350px;">Position
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 650px; font-size: smaller">
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
                                            </FooterTemplate>
                                        </telerik:RadComboBox>
                                    </td>

                                </tr>

                            </table>
                    </td>

                </tr>
                <tr>
                    <td colspan="3" style="padding-top: 20px; padding-bottom: 20px;">
                        <table>
                            <tr>
                                <td style="padding: 0px 10px 0px 10px"> 
                                    <telerik:RadLabel runat="server" ID="lbl_userId" Width="100px" Text="User: "/>
                                </td>
                                <td style="width: 240px; padding-left: 5px">
                                    <telerik:RadLabel runat="server" ID="lbl_lastUpdate" Width="240px" Text="Last Update: " />
                                </td>
                                <td style="padding: 0px 10px 0px 10px"> 
                                    <telerik:RadLabel runat="server" ID="lbl_Owner" Width="100px" Text="Owner: " />
                                </td>
                                <td style="padding: 0px 10px 0px 10px">
                                    <telerik:RadLabel runat="server" ID="lbl_edited" Width="100px" Text="Edited: " />
                                </td>
                                <td style="padding: 0px 10px 0px 10px">
                                    <telerik:RadLabel runat="server" ID="lbl_printed" Width="100px" Text="Printed: " Visible="false" /> 
                                </td>
                                <td style="padding: 0px 10px 0px 10px">
                                   <asp:CheckBox ID="chk_to_pr" runat="server" Text="Proceed to the next process (PR)" ForeColor="Blue" />
                                </td>
                            </tr>
                           <%-- <tr>
                                <td colspan="5">
                                    <asp:Label ID="lbl_result" runat="server"></asp:Label>
                                </td>
                            </tr>--%>
                        </table>
                    </td>
                </tr>
            </table>

            <div runat="server" style="width: 100%; border-top-color:yellowgreen; border-top-width: 1px; border-top-style: inset; padding-top: 20px;height:250px;overflow-y:auto">  
                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" 
                    AllowPaging="false" AllowSorting="true" runat="server" OnNeedDataSource="RadGrid2_NeedDataSource"
                    ShowStatusBar="true" OnDeleteCommand="RadGrid2_DeleteCommand" ClientSettings-Selecting-AllowRowSelect="true">
                    <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                    <MasterTableView CommandItemDisplay="None" DataKeyNames="part_code" Font-Size="12px" EditMode="Batch"
                        ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >
                        <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="False" ShowCancelChangesButton="false"/>
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Type" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblProdType" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>                                           
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center"
                                 HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblProdCode" Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>'></asp:Label>
                                </ItemTemplate>                                        
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="OH Qty" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right"
                                HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblSoh" Text='<%# DataBinder.Eval(Container.DataItem, "OH_qty", "{0:#,###,###0.00}") %>'></asp:Label>
                                </ItemTemplate>                                        
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Qty Order" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                               HeaderStyle-HorizontalAlign="Center" DefaultInsertValue="0"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                <ItemTemplate>
                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="85px"  ReadOnly="true" EnabledStyle-HorizontalAlign="Right"
                                        NumberFormat-AllowRounding="true"
                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                        Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'
                                        onkeydown="blurTextBox(this, event)"
                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2">
                                    </telerik:RadTextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            
                            <telerik:GridTemplateColumn HeaderText="PR Qty" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right"
                                HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblQtyPr" Text='<%# DataBinder.Eval(Container.DataItem, "QtyPR", "{0:#,###,###0.00}") %>'></asp:Label>
                                </ItemTemplate>                                        
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Supply Qty" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right"
                                HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblQtyGi" Text='<%# DataBinder.Eval(Container.DataItem, "QtyGi", "{0:#,###,###0.00}") %>'> </asp:Label>
                                </ItemTemplate>                                        
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="80px" ItemStyle-Width="80px" 
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                                </ItemTemplate>                                        
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Cost Center" HeaderStyle-Width="110px" ItemStyle-Width="110px" HeaderStyle-HorizontalAlign="Center"
                                 HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCostCtr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Delivery Date" HeaderStyle-Width="110px"  ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                <ItemTemplate>  
                                    <telerik:RadDatePicker runat="server" ID="dtpDelivDate" Width="110px"
                                        SelectedDate='<%#DataBinder.Eval(Container, "DataItem.deliv_date")%>' 
                                        onkeydown="blurTextBox(this, event)" Type="Date">
                                        <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                    </telerik:RadDatePicker>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn> 
                            
                            <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="300px" HeaderStyle-Width="300px" HeaderStyle-HorizontalAlign="Center"
                                 HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                                <ItemTemplate>
                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="300px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                    </telerik:RadTextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow"
                                ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px" HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="White">
                            </telerik:GridButtonColumn>

                        </Columns>
                    </MasterTableView>
                    <ClientSettings>
                        <ClientEvents OnRowDblClick="rowDblClick" />
                    </ClientSettings>
                </telerik:RadGrid>
                    
            </div>
        </div>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1150px" Height="670px" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Initial text" Position="BottomRight"
                    AutoCloseDelay="10000" Width="350" Height="110" Title="Current time" EnableRoundedCorners="true">
        </telerik:RadNotification>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
        <script type="text/javascript">
            //<![CDATA[
            Sys.Application.add_load(function () {
                $windowContentDemo.contentTemplateID = "<%=RadWindow_ContentTemplate.ClientID%>";
                $windowContentDemo.templateWindowID = "<%=RadWindow_ContentTemplate.ClientID %>";
            });
            //]]>
        </script>

    </div>
</asp:Content>
