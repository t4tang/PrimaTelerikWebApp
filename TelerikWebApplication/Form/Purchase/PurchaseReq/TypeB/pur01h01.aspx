﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="pur01h01.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.PurchaseReq.pur01h01" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("pur01h01ReportViewer.aspx?pr_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("pur01h01EditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("pur01h01EditForm.aspx?pr_code=" + id, "EditDialogWindows");
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
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" ></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" ></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <%--<telerik:AjaxUpdatedControl ControlID="RadGrid1" ></telerik:AjaxUpdatedControl>  --%>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2" ></telerik:AjaxUpdatedControl>  
                </UpdatedControls>        
            </telerik:AjaxSetting> 
        </AjaxSettings>
    </telerik:RadAjaxManager>

   <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 170px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="2000" BackgroundPosition="Center"></telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="450px" Height="350px" VisibleStatusbar="False" AutoSize="True">
        <ContentTemplate>
            <div runat="server" style="padding: 20px 10px 10px 10px;" id="Div2">
                <table>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Date From :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight"
                               EnableLoadOnDemand="True"  Skin="Telerik" OnItemsRequested="cb_project_prm_ItemsRequested"
                                OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px">

                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td>
                            <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="120px" Height="25px" 
                                BackColor="#FF6600" ForeColor="White" BorderStyle="None"  />
                        </td>

                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div style="padding-left: 15px; width: 100%; ">
        <table id="tbl_control">
            <tr>                  
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClientClick="ShowInsertForm(); return false;" ToolTip="Add New"
                        Height="30px" Width="32px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 13px">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="28px" Width="28px" ImageUrl="~/Images/filter1.png"></asp:ImageButton>
                </td>
                <td style="width: 93%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:bold">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>    

    <div class="scroller" runat="server">

        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="7" MasterTableView-GridLines="None" 
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand" OnItemCreated="RadGrid1_ItemCreated" >
                <PagerStyle Mode="Slider" VerticalAlign="NotSet" PageSizeControlType="RadComboBox"></PagerStyle>                
                <HeaderStyle CssClass="gridHeader" />
                <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                <SortingSettings EnableSkinSortStyles="false" />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="pr_code" Font-Size="11px"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowRefreshButton="False" 
                    CommandItemSettings-ShowAddNewRecordButton="False">
                    <SortExpressions >
                        <telerik:GridSortExpression FieldName="pr_code" SortOrder="Ascending" />
                    </SortExpressions>
                    <Columns>
                        <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="50px" HeaderStyle-Width="50px"></telerik:GridClientSelectColumn>
                        <telerik:GridBoundColumn UniqueName="pr_code" HeaderText="PR Number" DataField="pr_code" ItemStyle-Width="110px" FilterControlWidth="100px" ItemStyle-HorizontalAlign="Left">
                            <HeaderStyle Width="130px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="Pr_date" HeaderText="Date" DataField="Pr_date" ItemStyle-Width="80px"
                            EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker"
                            DataFormatString="{0:d}">
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="wo_no" HeaderText="WO Number" DataField="wo_no">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="reff_no" HeaderText="Reff Number" DataField="reff_no">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>                       
                        <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                            ItemStyle-Width="600px" FilterControlWidth="600px">
                            <HeaderStyle Width="600px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" AllowFiltering="False">
                        <ItemTemplate>                                
                            <asp:ImageButton ID="EditLink" runat="server" Height="22px" Width="28px" ImageUrl="~/Images/edit.png" ToolTip="Edit" />
                        </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Right"
                                AllowFiltering="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" 
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px" HeaderStyle-Width="50px"
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                        </telerik:GridButtonColumn>
                    </Columns>

                </MasterTableView>
                <ClientSettings>
                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="273px" />
                    <Selecting AllowRowSelect="true"></Selecting>                    
                </ClientSettings>
            </telerik:RadGrid>
            
        <div runat="server" style="width: 100%; border-top-color:yellowgreen; border-top-width: 1px; border-top-style: inset; padding-top: 20px;height:250px;overflow-y:auto">   
            <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" Skin="Telerik"
                AllowPaging="false" AllowSorting="true" runat="server" ShowStatusBar="true"  ClientSettings-Selecting-AllowRowSelect="true"
                OnNeedDataSource="RadGrid2_NeedDataSource"
                OnInsertCommand="RadGrid2_InsertCommand"
                OnUpdateCommand="RadGrid2_UpdateCommand"
                OnDeleteCommand="RadGrid2_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <MasterTableView CommandItemDisplay="Top" DataKeyNames="Prod_code" Font-Size="12px" EditMode="Batch"
                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >
                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="False" ShowCancelChangesButton="false" />
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Type" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center" 
                             HeaderStyle-ForeColor="Highlight">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblProdType" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>                                           
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="150px" ItemStyle-Width="150px"
                             HeaderStyle-ForeColor="Highlight">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblProdCode" Text='<%# DataBinder.Eval(Container.DataItem, "Prod_code") %>'></asp:Label>
                            </ItemTemplate>                                        
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="RS Number" HeaderStyle-Width="100px" ItemStyle-Width="100px" 
                             HeaderStyle-ForeColor="Highlight">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblRS" Text='<%# DataBinder.Eval(Container.DataItem, "no_ref") %>'></asp:Label>
                            </ItemTemplate>                                        
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="OH Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right"
                             HeaderStyle-ForeColor="Highlight">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblSoh" Text='<%# DataBinder.Eval(Container.DataItem, "stock_hand", "{0:#,###,###0.00}") %>'></asp:Label>
                            </ItemTemplate>                                        
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Order Qty" HeaderStyle-Width="100px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" 
                             HeaderStyle-ForeColor="Highlight" DefaultInsertValue="0">
                            <ItemTemplate>
                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="80px"  ReadOnly="false" 
                                    EnabledStyle-HorizontalAlign="Right"
                                    NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "qty", "{0:#,###,###0.00}") %>'
                                    onkeydown="blurTextBox(this, event)"
                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                    NumberFormat-DecimalDigits="2">
                                </telerik:RadTextBox>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="PO Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right"
                             HeaderStyle-ForeColor="Highlight">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblQtyPo" Text='<%# DataBinder.Eval(Container.DataItem, "qtypo", "{0:#,###,###0.00}") %>'></asp:Label>
                            </ItemTemplate>                                        
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="70px" ItemStyle-Width="70px" 
                             HeaderStyle-ForeColor="Highlight">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>'></asp:Label>
                            </ItemTemplate>                                        
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Center" HeaderStyle-Width="100px" ItemStyle-Width="100px" 
                             HeaderStyle-ForeColor="Highlight">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblCostCtr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Delivery Date" HeaderStyle-Width="110px"  ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                             HeaderStyle-ForeColor="Highlight">
                            <ItemTemplate>  
                                <telerik:RadDatePicker runat="server" ID="dtpDelivDate" Width="110px"
                                    SelectedDate='<%#DataBinder.Eval(Container, "DataItem.DeliDate")%>' 
                                    onkeydown="blurTextBox(this, event)" Type="Date">
                                    <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                </telerik:RadDatePicker>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn> 
                            
                        <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="250px" ItemStyle-Width="250px"
                             HeaderStyle-ForeColor="Highlight">
                            <ItemTemplate>
                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="250px"
                                    Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>'>
                                </telerik:RadTextBox>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                             HeaderStyle-ForeColor="Highlight" ConfirmTitle="Delete" ConfirmDialogType="RadWindow"
                            ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                        </telerik:GridButtonColumn>

                    </Columns>
                </MasterTableView>
                <ClientSettings>
                    <ClientEvents OnRowDblClick="rowDblClick" />
                </ClientSettings>
            </telerik:RadGrid>

                <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data tersimpan" Position="BottomRight"
                    AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
                </telerik:RadNotification>
            </ContentTemplate>
        </asp:UpdatePanel>    
        </div>

        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1150px" Height="670px" Modal="true" AutoSize="True">
                </telerik:RadWindow>
                <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1500px" Height="720px" Modal="true" AutoSize="False">
                </telerik:RadWindow>
                
            </Windows>
        </telerik:RadWindowManager>
        
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
        
    </div>
</asp:Content>