<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="True" CodeBehind="mtc01h36.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.Notification.mtc01h36" %>
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
                window.radopen("mtc01h36_ReportViewer.aspx?PM_id=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("mtc01h36EditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("mtc01h36EditForm.aspx?PM_id=" + id, "EditDialogWindows");
                return false;
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
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
            <nav:MobileNavigation runat="server" ID="MobileNavigation" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <%--<telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>--%>
            <telerik:AjaxSetting AjaxControlID="cb_project">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_unit" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_unit">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_model" />
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

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone" VisibleOnPageLoad="false"
        Modal="false" Width="450px" Height="350px" VisibleStatusbar="False" AutoSize="True" Skin="Silk" BackColor="Transparent">
        <ContentTemplate>
            <div runat="server" style="padding: 20px 10px 10px 10px;" id="Div2">
                <table>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Date From :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik" DateInput-CausesValidation="false"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                        <td>
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
                                    <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="000000"></telerik:RadLabel><br />
                                    <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight" AutoPostBack="true"
                                        EnableLoadOnDemand="True"  Skin="Telerik" 
                                        OnItemsRequested="cb_proj_prm_ItemsRequested"
                                        OnSelectedIndexChanged="cb_proj_prm_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%">
                                    </telerik:RadComboBox>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="height:50px">
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="95%" Height="25px"
                                Skin="Material" ForeColor="DeepSkyBlue">
                            </telerik:RadButton>
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

    <div  class="scroller" runat="server" style="overflow-y:scroll; height:620px;">

        <%--<div style="width:100%; overflow-y:hidden;height:auto; scrollbar-highlight-color:#b6ff00">--%>
        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" PageSize="14" Skin="Silk"
            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers"
            OnNeedDataSource="RadGrid1_NeedDataSource" 
            OnDeleteCommand="RadGrid1_DeleteCommand" 
            OnItemCreated="RadGrid1_ItemCreated"
            OnItemCommand="RadGrid1_ItemCommand"
            OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged"
            OnPreRender="RadGrid1_PreRender">
            <PagerStyle Mode="NumericPages"></PagerStyle> 
            <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
            <HeaderStyle ForeColor="Highlight" Font-Size="11px"  />
            <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="PM_id" Font-Size="11px" Font-Names="Century Gothic"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" 
                CommandItemSettings-AddNewRecordText="New" EditFormSettings-EditFormType="Template" InsertItemDisplay="Top">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="40px"/>
                        <ItemStyle Width="40px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn UniqueName="PM_id" HeaderText="Notif. No" DataField="PM_id">
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridBoundColumn>
                  <telerik:GridBoundColumn UniqueName="trans_id" HeaderText="WO. Number" DataField="trans_id">
                        <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                     <%-- <telerik:GridBoundColumn UniqueName="wo_desc" HeaderText="Status" DataField="wo_desc" ItemStyle-HorizontalAlign="Left" 
                        FilterControlWidth="50px">
                        <HeaderStyle Width="50px" />
                        <ItemStyle Width="50px" />
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn UniqueName="unit_code" HeaderText="Unit Code" DataField="unit_code" ItemStyle-HorizontalAlign="Left" 
                        FilterControlWidth="80px">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <%--<telerik:GridBoundColumn UniqueName="model_no" HeaderText="Model" DataField="model_no" ItemStyle-HorizontalAlign="Left" 
                        FilterControlWidth="120px">
                        <HeaderStyle Width="120px" />
                        <ItemStyle Width="120px" />
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn UniqueName="time_reading" AllowFiltering="false" HeaderText="HM" DataField="time_reading" ItemStyle-HorizontalAlign="Left">
                        <HeaderStyle Width="50px" />
                        <ItemStyle Width="50px" HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn UniqueName="Req_date" HeaderText="Date Req" DataField="Req_date" ItemStyle-Width="100px" 
                        EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker" DataFormatString="{0:d}">
                        <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px"  HorizontalAlign="Center" />
                    </telerik:GridDateTimeColumn>
                    <telerik:GridDateTimeColumn UniqueName="trans_date" HeaderText="Date Exec" DataField="trans_date" ItemStyle-Width="100px" 
                        EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker" DataFormatString="{0:d}">
                        <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                    </telerik:GridDateTimeColumn>
                    <%--<telerik:GridBoundColumn UniqueName="Notif_type_name" HeaderText="Type" DataField="Notif_type_name" ItemStyle-HorizontalAlign="Left" 
                        FilterControlWidth="120px" >
                        <HeaderStyle Width="120px" />
                        <ItemStyle Width="120px" />
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project" DataField="region_code" ItemStyle-HorizontalAlign="Left" 
                        FilterControlWidth="70px">
                        <HeaderStyle Width="70px" />
                        <ItemStyle Width="70px" HorizontalAlign="Center"  />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" AllowFiltering="false" DataField="remark" ItemStyle-Wrap="true" FilterControlWidth="200px">
                        <HeaderStyle Width="320px" />
                        <ItemStyle Width="320px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Right"
                        AllowFiltering="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" ItemStyle-ForeColor="Red"
                        ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
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
                                                        Height="25px" OnClick="btnSave_Click" 
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
                                                    <telerik:RadLabel runat="server" CssClass="lbObject" Text="Notif. Number :" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_notif" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight"
                                                      Text='<%# DataBinder.Eval(Container, "DataItem.PM_id") %>'  AutoPostBack="false">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">                                                    
                                                    <telerik:RadLabel runat="server" CssClass="lbObject" Text="WO. Number :" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_WO" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight"
                                                      Text='<%# DataBinder.Eval(Container, "DataItem.wono") %>'  AutoPostBack="false">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr> 
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Req. Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>               
                                                    <telerik:RadDatePicker ID="dtp_req" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" 
                                                        TabIndex="4" Skin="Telerik" AutoPostBack="false"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.Req_date") %>'>
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"
                                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                                                        </DateInput>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Notif. Type :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_notif" runat="server" Width="150"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Notif_type_name") %>' 
                                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk"
                                                        OnItemsRequested="cb_notif_ItemsRequested" OnPreRender="cb_notif_PreRender"
                                                        OnSelectedIndexChanged="cb_notif_SelectedIndexChanged"
                                                        EnableVirtualScrolling="true" >
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Status :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_status" runat="server" Width="150"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.wo_desc") %>' 
                                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk"
                                                        OnItemsRequested="cb_status_ItemsRequested" OnPreRender="cb_status_PreRender"
                                                        OnSelectedIndexChanged="cb_status_SelectedIndexChanged"
                                                        EnableVirtualScrolling="true" >
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">                                                    
                                                    <telerik:RadLabel runat="server" CssClass="lbObject" Text="Report By :" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_report" runat="server" Width="150px" RenderMode="Lightweight"
                                                      Text='<%# DataBinder.Eval(Container, "DataItem.reportby") %>'  AutoPostBack="false">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">                                                    
                                                    <telerik:RadLabel runat="server" CssClass="lbObject" Text="Problem :" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_problem" runat="server" Width="350px" RenderMode="Lightweight" TextMode="MultiLine"
                                                      Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'  AutoPostBack="false" Resize="Both" TabIndex="5">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="vertical-align: top; padding-left:15px">
                                        <table id="Table3" border="0" class="module">
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Comp.Group :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    
                                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_group" runat="server" Width="150"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.com_group_name") %>' 
                                                                EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk" DropDownWidth="350px" AutoPostBack="true"
                                                                OnItemsRequested="cb_group_ItemsRequested" OnPreRender="cb_group_PreRender"
                                                                OnSelectedIndexChanged="cb_group_SelectedIndexChanged"
                                                                EnableVirtualScrolling="true" >
                                                                <HeaderTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Code
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                Group Name
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.com_group")%>
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.com_group_name")%>
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
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Component :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    
                                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_component" runat="server" Width="150"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.com_name") %>' 
                                                                EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk" DropDownWidth="350px" AutoPostBack="true" 
                                                                OnItemsRequested="cb_component_ItemsRequested" OnPreRender="cb_component_PreRender"
                                                                OnSelectedIndexChanged="cb_component_SelectedIndexChanged"
                                                                EnableVirtualScrolling="true" >
                                                                <HeaderTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Code
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                Component Name
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.com_code")%>
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.com_name")%>
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
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_Project" runat="server" Width="150"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' 
                                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk"
                                                        OnItemsRequested="cb_Project_ItemsRequested" OnPreRender="cb_Project_PreRender"
                                                        OnSelectedIndexChanged="cb_Project_SelectedIndexChanged"
                                                        EnableVirtualScrolling="true" >
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_Project" ForeColor="Red"  
                                                        Text="*" CssClass="required_validator">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Unit :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    
                                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_unit" runat="server" Width="150"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.unit_name") %>' 
                                                                EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk" DropDownWidth="450px" AutoPostBack="true" CausesValidation="false" 
                                                                OnItemsRequested="cb_unit_ItemsRequested" OnPreRender="cb_unit_PreRender" DataTextField="unit_code" DataValueField="unit_code"
                                                                OnSelectedIndexChanged="cb_unit_SelectedIndexChanged"
                                                                EnableVirtualScrolling="true" >
                                                                <HeaderTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 150px; font-variant:small-caps; color: #3399FF;">Unit Code
                                                                            </td>
                                                                            <td style="width: 200px; font-variant:small-caps; color: #3399FF;"">Unit Name
                                                                            </td>
                                                                            <td style="width: 150px; font-variant:small-caps; color: #3399FF;"">Model No
                                                                            </td>
                                                                            <td style="width: 100px; font-variant:small-caps; color: #3399FF;"">Project
                                                                            </td>
                                                                            <td style="width: 100px; font-variant:small-caps; color: #3399FF;"">Cost Center
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 150px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                                            </td>
                                                                            <td style="width: 200px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.unit_name")%>
                                                                            </td>
                                                                            <td style="width: 150px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.model_no")%>
                                                                            </td>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.region_code")%>
                                                                            </td>
                                                                            <td style="width: 150px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.CostCenterName")%>
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
                                                <td class="tdLabel">                                                    
                                                    <telerik:RadLabel runat="server" CssClass="lbObject" Text="Model No :" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_model" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.model_no") %>' AutoPostBack="false">
                                                    </telerik:RadTextBox> 
                                                    &nbsp
                                                    <telerik:RadLabel runat="server" CssClass="lbObject" Text="Reading :" ForeColor="Black"></telerik:RadLabel>
                                                    <telerik:RadNumericTextBox ID="txt_reading" runat="server" Width="150px" RenderMode="Lightweight"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.time_reading") %>'  AutoPostBack="false">
                                                    </telerik:RadNumericTextBox>             
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">                                                    
                                                    <telerik:RadLabel runat="server" CssClass="lbObject" Text="Unit Status :" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <asp:CheckBox runat="server" ID="chk_breakdown" Text="Breakdown" />
                                                    &nbsp
                                                    <telerik:RadLabel runat="server" CssClass="lbObject" Text="B/D Time :" ForeColor="Black"></telerik:RadLabel>
                                                    <telerik:RadDatePicker ID="dtp_time" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" 
                                                        TabIndex="4" Skin="Telerik" AutoPostBack="false"
                                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.trans_date") %>'>
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"
                                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                                                        </DateInput>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                                    </telerik:RadDatePicker>
                                                    <%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="dtp_req" ForeColor="Red" 
                                                         Text="*" CssClass="required_validator"></asp:RequiredFieldValidator>--%>
                                                    &nbsp
                                                    <telerik:RadNumericTextBox ID="txt_breakdown" runat="server" Width="150px" RenderMode="Lightweight" 
                                                      Text='<%# DataBinder.Eval(Container, "DataItem.status_time") %>'  AutoPostBack="false">
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="padding-top:10px; padding-bottom:10px;">
                                        <table>
                                            <tr>
                                                <td style="padding:0px 10px 0px 10px">
                                                     
                                                    <telerik:RadLabel runat="server" Text="User:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td style="width:50px">
                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="50px" runat="server" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.userid") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td style="width:80px; padding-left:15px">
                                                    
                                                    <telerik:RadLabel runat="server" Text="Last Update:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td style="width:70px;">
                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_lastUpdate" Width="160px" runat="server" Skin="Silk" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.lastupdate") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td style="padding:0px 10px 0px 10px">
                                                    
                                                    <telerik:RadLabel runat="server" Text="Date Release:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="RadDatePicker1" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" 
                                                        TabIndex="4" Skin="Telerik" AutoPostBack="false"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.ReleaseDate") %>'>
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"
                                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                                                        </DateInput>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                                    </telerik:RadDatePicker>
                                                </td>
                                                <td style="padding:0px 10px 0px 10px">
                                                    
                                                    <telerik:RadLabel runat="server" Text="Date Closed:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="RadDatePicker2" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" 
                                                        TabIndex="4" Skin="Telerik" AutoPostBack="false"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.ClosedDate") %>'>
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"
                                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                                                        </DateInput>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                                    </telerik:RadDatePicker>
                                                </td>
                                                <%--<td style="padding:0px 10px 0px 10px">
                                                    
                                                    <telerik:RadLabel runat="server" Text="Edited:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" runat="server" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Edited") %>'>
                                                    </telerik:RadTextBox>
                                                </td>  --%>                              
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
                        </div>
                    </FormTemplate>
                </EditFormSettings>

            </MasterTableView>
            <ClientSettings>
                <Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="200px" />
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
        </telerik:RadGrid>
        <%--</div>--%>
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

    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true"></telerik:RadWindowManager>

    <telerik:RadNotification RenderMode="Lightweight" ID="notif" Text="Data telah disimpan" runat="server" Position="BottomRight" Skin="Silk"
                AutoCloseDelay="10000" Width="350" Height="110" Title="Confirmation" EnableRoundedCorners="true">
    </telerik:RadNotification>

</asp:Content>
