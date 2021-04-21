<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc01h01mon.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.WorkOrderMonitoring.mtc01h01mon" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js"></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function ShowPreview(id) {
                window.radopen("reportViewer_mtc01h01.aspx?trans_id=" + id, "PreviewDialog");
                return false;
            }
           
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("mtc01h01EditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("mtc01h01EditForm.aspx?trans_id=" + id, "EditDialogWindows");
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

            function RowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
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
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 170px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="2000" BackgroundPosition="Center"></telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone" Modal="true" Width="450px" Height="350px" 
        VisibleStatusbar="False" AutoSize="True">
        <ContentTemplate>
            <div runat="server" style="padding: 20px 10px 10px 10px;" id="Div2">
                <table>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Date From :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy"></telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                    <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight" AutoPostBack="true" CausesValidation="false" 
                                        EnableLoadOnDemand="True"  Skin="Telerik" 
                                        OnItemsRequested="cb_proj_prm_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_proj_prm_SelectedIndexChanged" 
                                        EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%">
                                    </telerik:RadComboBox>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <%--<tr>
                        <td colspan="2">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <telerik:RadLabel runat="server" Text="Storage :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                    <telerik:RadComboBox ID="cb_storage_prm" runat="server" RenderMode="Lightweight" AutoPostBack="true" CausesValidation="false" 
                                        EnableLoadOnDemand="True"  Skin="Telerik" 
                                        OnItemsRequested="cb_storage_prm_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_storage_prm_SelectedIndexChanged" OnPreRender="cb_storage_prm_PreRender" 
                                        EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%">
                                    </telerik:RadComboBox>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cb_proj_prm" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>--%>
                    <tr style="height:50px">   
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="95%" Height="25px" CausesValidation="false"
                             Skin="Material" ForeColor="DeepSkyBlue"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:orangered; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>                   
                <td style="vertical-align: middle; margin-left: 10px; padding: 5px 0px 0px 13px;">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="25px" Width="28px" ImageUrl="~/Images/filter.png"></asp:ImageButton>
                </td>                 
                <%--<td style="vertical-align: middle; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click" ToolTip="Add New" Visible="true"
                        Height="30px" Width="32px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                </td>--%>  
                <td style="width: 97%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

    <div class="scroller" runat="server" style="overflow-y:scroll; height:620px;">
        <div style="width:100%; overflow-y:hidden;height:auto; scrollbar-highlight-color:#b6ff00">
            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" PageSize="15" Skin="Telerik"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" 
                OnNeedDataSource="RadGrid1_NeedDataSource"
                OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NumericPages" ForeColor="#0099CC"></PagerStyle>               
                <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px" HorizontalAlign="Center"/>
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
                <SortingSettings EnableSkinSortStyles="false" />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="trans_id" Font-Size="12px"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                    CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" EditMode="EditForms" 
                    CommandItemSettings-AddNewRecordText="New" EditFormSettings-EditFormType="WebUserControl" InsertItemDisplay="Bottom">
                    <Columns>
                        <%--<telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="30px"></telerik:GridClientSelectColumn>--%>
                        <telerik:GridBoundColumn UniqueName="trans_id" HeaderText="WO. Number" DataField="trans_id">
                            <HeaderStyle Width="120px"/>
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="trans_date" HeaderText="Date" DataField="trans_date" 
                                EnableRangeFiltering="false" PickerType="DatePicker" DataFormatString="{0:d}" FilterControlWidth="103px" >
                            <HeaderStyle Width="120px"/>
                            <ItemStyle Width="120px" />                        
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="unit_code" HeaderText="Unit Code" DataField="unit_code">
                            <HeaderStyle Width="120px"/>
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="model_no" HeaderText="Model No." DataField="model_no">
                            <HeaderStyle Width="140px"/>
                            <ItemStyle Width="120px" />                        
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="OrderName" HeaderText="Order Type" DataField="OrderName">
                            <HeaderStyle Width="160px"/>
                            <ItemStyle Width="160px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="wo_desc" HeaderText="Status" DataField="wo_desc">
                            <HeaderStyle Width="120px"/>
                            <ItemStyle Width="100px" HorizontalAlign="Center" />                        
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="time_reading" HeaderText="Unit HM" DataField="time_reading">
                            <HeaderStyle Width="140px"/>
                            <ItemStyle Width="140px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="unitstatus" HeaderText="Unit Status" DataField="unitstatus">
                            <HeaderStyle Width="110px"/>
                            <ItemStyle Width="80px" />                        
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="DBDate" HeaderText="B/D Date" DataField="DBDate" AllowFiltering="false">
                            <HeaderStyle Width="120px"/>
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="remark" HeaderText="Job Description" DataField="remark" AllowFiltering="false">
                            <HeaderStyle Width="280px"/>
                            <ItemStyle Width="260px" />                        
                        </telerik:GridDateTimeColumn>
                       <%-- <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" ItemStyle-ForeColor="Red"
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                        </telerik:GridButtonColumn>--%>
                    </Columns>
                </MasterTableView>
                <ClientSettings>
                    <%--<Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="360px" />--%>
                    <Selecting AllowRowSelect="true"></Selecting>  
                </ClientSettings>
            </telerik:RadGrid>

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

        </div>
    </div>
</asp:Content>
