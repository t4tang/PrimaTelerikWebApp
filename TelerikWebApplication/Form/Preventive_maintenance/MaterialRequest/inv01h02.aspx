<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h02.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.MaterialRequest.inv01h02" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            
            function ShowPreview(id) {
                window.radopen("inv01h02_ReportViewer.aspx?sro_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("inv01h02EditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("inv01h02EditForm.aspx?sro_code=" + id, "EditDialogWindows");
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
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid3"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>
            <%--<telerik:AjaxSetting AjaxControlID="RadGrid3">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid3"></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>--%>
            <telerik:AjaxSetting AjaxControlID="btnInsertItem">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid3"></telerik:AjaxUpdatedControl>
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

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="450px" Height="350px" VisibleStatusbar="False" AutoSize="True">
        <ContentTemplate>
            <div runat="server" style="padding: 20px 10px 10px 10px;" id="Div2">
                <table>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Date From :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik" DateInput-CausesValidation="false"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                        <td >
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
                                <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
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
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click" ToolTip="Add New"
                        Height="30px" Width="32px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                </td>
                <td style="width: 94%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight:normal; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue;">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

    <div  class="scroller" runat="server">
        <div style="width:100%; overflow-y:hidden;height:375px; ">
            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" PageSize="10" Skin="Telerik"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true"
                OnNeedDataSource="RadGrid1_NeedDataSource" 
                OnDeleteCommand="RadGrid1_DeleteCommand" 
                OnItemCreated="RadGrid1_ItemCreated"
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged"
                OnPreRender="RadGrid1_PreRender">
                <PagerStyle Mode="NumericPages"></PagerStyle>          
                <ClientSettings EnablePostBackOnRowClick="true" />
                <HeaderStyle Font-Size="12px" />
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="sro_code" Font-Size="12px"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                    CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" 
                    CommandItemSettings-AddNewRecordText="New" EditFormSettings-EditFormType="WebUserControl" InsertItemDisplay="Bottom">
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                            <HeaderStyle Width="40px"/>
                            <ItemStyle Width="40px" />
                        </telerik:GridEditCommandColumn>
                        <%--<telerik:GridClientSelectColumn UniqueName="SelectColumn" >
                            <HeaderStyle Width="30px" />
                            <ItemStyle Width="30px" />
                        </telerik:GridClientSelectColumn> --%>
                        <telerik:GridBoundColumn UniqueName="sro_code" HeaderText="MR. Number" DataField="sro_code" FilterControlWidth="110px" >
                            <HeaderStyle Width="150px" />
                            <ItemStyle Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="trans_id" HeaderText="WO. Number" DataField="trans_id" FilterControlWidth="110px" >
                            <HeaderStyle Width="150px" />
                            <ItemStyle Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" FilterControlWidth="180px" >
                            <HeaderStyle Width="220px" />
                            <ItemStyle Width="220px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="unit_code" HeaderText="Unit" DataField="unit_code" FilterControlWidth="80px" >
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="sro_date" HeaderText="Date" DataField="sro_date" FilterControlWidth="80px" 
                                EnableRangeFiltering="false" PickerType="DatePicker" 
                                DataFormatString="{0:d}" >
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="status" HeaderText="Status" DataField="status" FilterControlWidth="60px" >
                            <HeaderStyle Width="95px"/>
                            <ItemStyle Width="95px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="sro_remark" FilterControlWidth="270px">
                            <HeaderStyle Width="310px" />
                            <ItemStyle Width="310px" />
                        </telerik:GridBoundColumn>
                        <%--<telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" AllowFiltering="False">
                            <ItemTemplate>                                
                                <asp:ImageButton ID="EditLink" runat="server" Height="22px" Width="25px" ImageUrl="~/Images/edit.png" ToolTip="Edit" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>--%>
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
                    <EditFormSettings EditFormType="WebUserControl" UserControlName="entry.ascx">
                        <EditColumn UniqueName="EditCommandColumn1">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
                <ClientSettings>
                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="255px" />
                    <Selecting AllowRowSelect="true" />
                    <ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />
                </ClientSettings>
            </telerik:RadGrid>                
        </div>
        
        <div style=" width:100%; border-top-style:solid; border-top-width:thin; padding-top:5px">
            <%--<div runat="server" style="position:absolute; padding: 4px 0px 0px 5px; float:right;">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <asp:LinkButton runat="server" ID="btnInsertItem" BorderStyle="Outset" Text="Insert Item" Width="80px" Font-Size="Small"
                        ForeColor="White" BackColor="DeepSkyBlue" OnClick="btnInsertItem_Click" ></asp:LinkButton>
                    </ContentTemplate>
                </asp:UpdatePanel>            
            </div>            --%>
            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" AutoGenerateColumns="false" PageSize="4"  Skin="Telerik"
                AllowPaging="true" AllowSorting="true" runat="server" 
                OnNeedDataSource="RadGrid3_NeedDataSource"
                OnInsertCommand="RadGrid3_InsertCommand" 
                OnUpdateCommand="RadGrid3_InsertCommand" 
                OnEditCommand="RadGrid3_EditCommand" 
                OnDeleteCommand="RadGrid3_DeleteCommand"
                ShowStatusBar="true">
                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                <HeaderStyle CssClass="gridHeader"/>
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <MasterTableView CommandItemDisplay="Top" DataKeyNames="sro_code,part_code" Font-Size="12px" EditMode="InPlace" BorderStyle="Solid" 
                    BorderColor="Silver" BorderWidth="1px" ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" 
                    HeaderStyle-BorderStyle="Solid" HeaderStyle-BorderColor="Teal">
                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="true" AddNewRecordText="New" />
                    <%--<GroupByExpressions>
                        <telerik:GridGroupByExpression>
                            <SelectFields>
                                <telerik:GridGroupByField FieldAlias="Operation" FieldName="OprName"></telerik:GridGroupByField>
                            </SelectFields>
                            <GroupByFields>
                                <telerik:GridGroupByField FieldName="OprName" ></telerik:GridGroupByField>
                            </GroupByFields>
                        </telerik:GridGroupByExpression>
                                
                    </GroupByExpressions>--%>
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                            <HeaderStyle Width="40px"/>
                            <ItemStyle Width="60px" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridTemplateColumn HeaderText="Operation" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_operation" Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'></asp:Label>
                            </ItemTemplate>                                        
                            <EditItemTemplate>
                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation_editTemp" EnableLoadOnDemand="True" DataTextField="OprName"
                                    DataValueField="chart_code" AutoPostBack="true"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'
                                    HighlightTemplatedItems="true" Height="70px" Width="120px" DropDownWidth="130px"
                                    OnItemsRequested="cb_operation_inserttTemp_ItemsRequested"
                                    OnSelectedIndexChanged="cb_operation_SelectedIndexChanged">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation_insertTemp" EnableLoadOnDemand="True" AutoPostBack="true"
                                    HighlightTemplatedItems="true" Height="70px" Width="120px" DropDownWidth="130px"
                                    OnItemsRequested="cb_operation_inserttTemp_ItemsRequested"
                                    OnSelectedIndexChanged="cb_operation_SelectedIndexChanged">
                                </telerik:RadComboBox>
                            </InsertItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_prodType" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lbl_prodType_editTemp" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:Label runat="server" ID="lbl_prodType_insertTemp"></asp:Label>
                            </InsertItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="120px" ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" >
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_partCode" Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_editTemp" EnableLoadOnDemand="True" DataTextField="spec"
                                    DataValueField="prod_code" AutoPostBack="true"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>' EmptyMessage="- Search product name here -"
                                    HighlightTemplatedItems="true" Height="190px" Width="220px" DropDownWidth="430px"
                                    OnItemsRequested="cb_prod_code_ItemsRequested" 
                                    OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                    OnPreRender="cb_prod_code_PreRender">                                                  
                                    <HeaderTemplate>
                                    <table style="width: 430px; font-size:smaller">
                                        <tr>
                                            <td style="width: 250px;">
                                                Prod. Name
                                            </td>     
                                            <td style="width: 180px;">
                                                Prod. Code
                                            </td>                                                           
                                        </tr>
                                    </table>                                                       
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 430px; font-size:smaller">
                                            <tr>
                                                <td style="width: 250px;">
                                                    <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                </td>        
                                                <td style="width: 180px;">
                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                </td>                                                        
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_insertTemp" EnableLoadOnDemand="True" DataTextField="spec"
                                    DataValueField="prod_code" AutoPostBack="true"
                                    EmptyMessage="- Search product name here -"
                                    HighlightTemplatedItems="true" Height="190px" Width="220px" DropDownWidth="430px"
                                    OnItemsRequested="cb_prod_code_ItemsRequested" 
                                    OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                    OnPreRender="cb_prod_code_PreRender">                                                   
                                    <HeaderTemplate>
                                    <table style="width: 430px; font-size:smaller">
                                        <tr>
                                            <td style="width: 250px;">
                                                Prod. Name
                                            </td>     
                                            <td style="width: 180px;">
                                                Prod. Code
                                            </td>                                                           
                                        </tr>
                                    </table>                                                       
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 430px; font-size:smaller">
                                            <tr>
                                                <td style="width: 250px;">
                                                    <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                </td>        
                                                <td style="width: 180px;">
                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                </td>                                                        
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </InsertItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_qty" Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'>
                                </asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty_editTemp" Width="70px" NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                    DbValue='<%# Convert.ToDouble(Eval("part_qty")) %>'
                                    onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                    NumberFormat-DecimalDigits="2" >
                                </telerik:RadNumericTextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty_insertTemp" Width="70px" NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"                                                
                                    onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                    NumberFormat-DecimalDigits="2" >
                                </telerik:RadNumericTextBox>
                            </InsertItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="QRS" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_qtyRs" Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'>
                                </asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>                                        
                                <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qtyRs_editTemp" Width="70px" NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                    DbValue='<%# Convert.ToDouble(Eval("qty_pr")) %>'
                                    onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                    NumberFormat-DecimalDigits="2" >
                                </telerik:RadNumericTextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qtyRs_insertTemp" Width="70px" NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"                                                
                                    onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                    NumberFormat-DecimalDigits="2" >
                                </telerik:RadNumericTextBox>
                            </InsertItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_UoM" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lbl_UoM_editTemp" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:Label runat="server" ID="lbl_UoM_insertTemp" ></asp:Label>
                            </InsertItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Waranty" HeaderStyle-Width="50px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" 
                                HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chk_waranty" Text="Warranty"
                                    Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox runat="server" ID="chk_waranty_editTemp" Text="Warranty"
                                    Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                            </EditItemTemplate>  
                            <InsertItemTemplate>
                                <asp:CheckBox runat="server" ID="chk_waranty_insertTemp" Text="Warranty" Enabled="true" />
                            </InsertItemTemplate>                                      
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="250px" ItemStyle-Width="250px" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_remark" Width="250px" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_editTemp" Width="250px" 
                                Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></telerik:RadTextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_insertTemp" Width="250px"
                                ></telerik:RadTextBox>
                            </InsertItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                            ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-ForeColor="Red">
                        </telerik:GridButtonColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>               
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

        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>

    </div>

</asp:Content>
