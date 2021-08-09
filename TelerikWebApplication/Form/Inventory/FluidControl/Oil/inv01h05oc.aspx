<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h05oc.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.FluidControl.Oil.inv01h05oc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
    
    <script type="text/javascript" src="../../../../Script/Script.js"></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            
            function ShowPreview(id) {
                window.radopen("inv01h05ocReportViewer.aspx?do_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("inv01h05ocEditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("inv01h05ocEditForm.aspx?do_code=" + id, "EditDialogWindows");
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
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" ></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 170px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" MinDisplayTime="500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="500" BackgroundPosition="Center"></telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone" Skin="Silk"
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
                        <td >
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
                    <tr>
                        <td colspan="2">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <telerik:RadLabel runat="server" Text="Storage :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="300" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" OnPreRender="cb_warehouse_PreRender"
                                        OnItemsRequested="cb_warehouse_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged" Font-Size="Small">
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

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>                  
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" ToolTip="Add New" OnClick="btnNew_Click"
                        Height="26px" Width="27px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="29px" Width="30px" ImageUrl="~/Images/search.png"></asp:ImageButton>
                </td>
                <td style="width: 97%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#0099dc; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>
    
    <div  class="scroller" runat="server" style="overflow-y:scroll; height:620px">
        <div runat="server" style="width:100%; overflow-y:hidden; min-height:280px; scrollbar-highlight-color:#b6ff00;">
            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" PageSize="14" Skin="Silk"
            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers"
            OnNeedDataSource="RadGrid1_NeedDataSource" 
            OnDeleteCommand="RadGrid1_DeleteCommand" 
            OnItemCreated="RadGrid1_ItemCreated"
            OnItemCommand="RadGrid1_ItemCommand"
            OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged"
            OnPreRender="RadGrid1_PreRender"
            OnItemDataBound="RadGrid1_ItemDataBound">
            <PagerStyle Mode="NumericPages"></PagerStyle>  
            <ClientSettings EnablePostBackOnRowClick="false" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
            <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px"/>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="do_code" Font-Size="11px" Font-Names="Century Gothic"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" 
                CommandItemSettings-AddNewRecordText="New" EditFormSettings-EditFormType="Template" InsertItemDisplay="Top">
                <Columns> 
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="40px"/>
                        <ItemStyle Width="40px" />
                    </telerik:GridEditCommandColumn>  
                    <telerik:GridBoundColumn UniqueName="do_code" HeaderText="FC Number" DataField="do_code" 
                        FilterControlWidth="90px" >
                        <HeaderStyle Width="120px" />
                        <ItemStyle Width="125px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn UniqueName="Tgl" HeaderText="Date" DataField="Tgl" 
                            EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker" 
                        DataFormatString="{0:d}" >
                        <HeaderStyle Width="135px" />
                        <ItemStyle Width="135px" />
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn UniqueName="unit_code" HeaderText="Unit" DataField="unit_code"
                        FilterControlWidth="100px" >
                        <HeaderStyle Width="135px" />
                        <ItemStyle Width="135px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project Code" DataField="region_code"
                        FilterControlWidth="80px" >
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <%--<telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" 
                        FilterControlWidth="170px" >
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn> --%>
                    <telerik:GridBoundColumn UniqueName="wh_code" HeaderText="wh Code" DataField="wh_code"
                        FilterControlWidth="100px" >
                        <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>                      
                    <telerik:GridTemplateColumn HeaderText="Qty Out" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                        HeaderStyle-HorizontalAlign="Right" DefaultInsertValue="0"  >
                        <ItemTemplate>                                                                    
                            <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="lbl_Part_Qty" Width="85px" EnabledStyle-HorizontalAlign="Right"
                                BorderStyle="None" 
                                NumberFormat-AllowRounding="true"
                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                DbValue='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                onkeydown="blurTextBox(this, event)"
                                AutoPostBack="true" MaxLength="11" Type="Number"
                                NumberFormat-DecimalDigits="2">
                            </telerik:RadNumericTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <%--<telerik:GridBoundColumn UniqueName="Qty_out" HeaderText="Qty" DataField="Qty_out" 
                        FilterControlWidth="80px" >
                        <HeaderStyle Width="80px" HorizontalAlign="Center"/>
                        <ItemStyle Width="80px" HorizontalAlign="Right" CssClass="gridNumItem"/>
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                            FilterControlWidth="300px">
                        <HeaderStyle Width="300px" />
                        <ItemStyle Width="300px" />
                    </telerik:GridBoundColumn>
                    <%--<telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="30px" ItemStyle-Width="30px" AllowFiltering="False">
                        <ItemTemplate>                                
                            <asp:ImageButton ID="EditLink" runat="server" Height="22px" Width="25px" ImageUrl="~/Images/edit.png" ToolTip="Edit" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>--%>
                    <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="30px" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center"
                            AllowFiltering="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" ItemStyle-ForeColor="Red" ItemStyle-HorizontalAlign="Center"
                        ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                        <HeaderStyle Width="30px" />
                        <ItemStyle Width="30px" />
                    </telerik:GridButtonColumn>
                </Columns>
                    <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                            <div style="padding: 15px 0px 0px 25px;">
                                <table>
                                    <tr style="vertical-align: top">
                                        <td style="vertical-align: top">
                                            <table id="Table2" width="Auto" border="0" class="module">
                                                <tr>
                                                    <td colspan="2" style="padding: 0px 0px 10px 0px; text-align:left">
                                                        <asp:Button ID="btnSave" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px"  Height="25px" 
                                                            Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" OnClick="btnSave_Click"
                                                            CssClass="btn-entryFrm" >
                                                        </asp:Button>&nbsp;
                            
                                                        <asp:Button ID="btnCancel" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" 
                                                            Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                                            runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                                                    </td>
                                                </tr>
                                                <%--<tr>
                                                    <td colspan="2" style="padding: 0px 0px 10px 0px ; ">
                                                        <asp:ImageButton runat="server" ID="btnSave" AlternateText="New" OnClick="btn_save_Click" ToolTip="Save" Visible="true"
                                                        Height="30px" Width="32px" ImageUrl="~/Images/simpan.png"></asp:ImageButton>
                                                                                    
                                                    </td>
                                                </tr>--%>
                                                <tr>
                                                    <td >
                                                        <telerik:RadLabel runat="server" Text="FC Number" CssClass="lbObject"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadTextBox ID="txt_gi_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                           Skin="Telerik"  EmptyMessage="Let it blank" Text='<%# DataBinder.Eval(Container, "DataItem.do_code") %>' >
                                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td >
                                                        <telerik:RadLabel runat="server" Text="Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadDatePicker ID="dtp_date" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="Telerik"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.Tgl") %>'>
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                                                FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik" ></Calendar>
                                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                                                            </DateInput>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                                        </telerik:RadDatePicker>
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ControlToValidate="dtp_date" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Project Area" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_Project" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
                                                            EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="200" DropDownWidth="270px" Enabled="true" 
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>'
                                                            OnItemsRequested="cb_Project_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_Project_SelectedIndexChanged"
                                                            OnPreRender="cb_Project_PreRender">
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_Project" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Storage Loc." CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>                                                    
                                                        <telerik:RadComboBox ID="cb_warehouseH" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true" CausesValidation="false"
                                                            EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="false" Width="200" DropDownWidth="300px" AutoPostBack="true" 
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.wh_name") %>'
                                                            OnItemsRequested="cb_warehouseH_ItemsRequested" 
                                                            OnPreRender="cb_warehouseH_PreRender" 
                                                            OnSelectedIndexChanged="cb_warehouseH_SelectedIndexChanged"  
                                                            >
                                                        </telerik:RadComboBox>
                                                        <%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="cb_warehouse" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>  --%>                                                                                   
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Componen" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="3">
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_componen" runat="server" Width="250" CausesValidation="false" 
                                                                EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk" AutoPostBack="true"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.compart_remark") %>' 
                                                                OnItemsRequested="cb_componen_ItemsRequested"
                                                                OnPreRender="cb_componen_PreRender"
                                                                OnSelectedIndexChanged="cb_componen_SelectedIndexChanged"
                                                                EnableVirtualScrolling="true">
                                                            </telerik:RadComboBox>  
                                                            <%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_componen" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>--%>   
                                                        </ContentTemplate>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">                                        
                                                        <telerik:RadLabel runat="server" Text="Type Of Out" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_type_out" runat="server" RenderMode="Lightweight" Skin="Silk" EnableLoadOnDemand="true"  HighlightTemplatedItems="true"
                                                            EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" Enabled="true" Width="200" DropDownWidth="270px" CausesValidation="false"  
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.type_of_out") %>'
                                                            OnItemsRequested="cb_type_out_ItemsRequested"
                                                            OnPreRender="cb_type_out_PreRender"
                                                            OnSelectedIndexChanged="cb_type_out_SelectedIndexChanged">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                
                                            </table>
                                        </td>
                                        <td style="vertical-align: top;">
                                            <table id="Table3" border="0" class="module">                                                    
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Unit Code" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadComboBox ID="cb_unit_code" runat="server" RenderMode="Lightweight" Width="200px" EnableLoadOnDemand="true" EnableVirtualScrolling="true" 
                                                            MarkFirstMatch="true" ShowMoreResultsBox="true" Skin="Telerik" CausesValidation="false" Height="350px"
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.unit_code") %>'
                                                            OnItemsRequested="cb_unit_code_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_unit_code_SelectedIndexChanged" OnPreRender="cb_unit_code_PreRender"
                                                            DropDownWidth="650px" AutoPostBack="true"                          
                                                            >
                                                            <HeaderTemplate>
                                                                <table style="width: 650px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            Unit Code
                                                                        </td>
                                                                        <td style="width: 250px;">
                                                                            Unit Name
                                                                        </td> 
                                                                        <td style="width: 250px;">
                                                                            Model
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 650px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            <%# DataBinder.Eval(Container, "value")%>
                                                                        </td>
                                                                        <td style="width: 250px;">
                                                                            <%# DataBinder.Eval(Container, "Attributes['unit_name']")%>
                                                                        </td> 
                                                                        <td style="width: 250px;">
                                                                            <%# DataBinder.Eval(Container, "Attributes['model_no']")%>
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </telerik:RadComboBox>&nbsp&nbsp
                                                        &nbsp
                                                        <telerik:RadLabel runat="server" Text="Model No" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        <telerik:RadTextBox runat="server" RenderMode="Lightweight" AutoPostBack="false" ID="txt_model" ReadOnly="true" Width="100px" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.model_no") %>'></telerik:RadTextBox>
                                                        <%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="cb_ref" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>--%>
                                                    </td>                                    
                                                </tr>
                                                <tr>                                    
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="HM/KM" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="txt_hm" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="*" CssClass="required_validator"></asp:RequiredFieldValidator>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_hm" Width="85px" EnabledStyle-HorizontalAlign="Right"
                                                            NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                            Text='<%# DataBinder.Eval(Container.DataItem, "unit_reading", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                                            NumberFormat-DecimalDigits="2">
                                                        </telerik:RadNumericTextBox>
                                                                                                                                                      
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Cost Center" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_CostCenter" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true" AutoPostBack="true"
                                                            EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" Width="150" DropDownWidth="350px" CausesValidation="false" 
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>'
                                                            OnItemsRequested="cb_CostCenter_ItemsRequested" 
                                                            OnPreRender="cb_CostCenter_PreRender" 
                                                            OnSelectedIndexChanged="cb_CostCenter_SelectedIndexChanged"                         
                                                            >
                                                            <HeaderTemplate>
                                                                <table style="width: 350px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 100px;">Code
                                                                        </td>
                                                                        <td style="width: 250px;">Name
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 350px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 100px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.code")%>
                                                                        </td>
                                                                        <td style="width: 250px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </telerik:RadComboBox>
                                                        <%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="cb_CostCenter" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>--%>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>                                    
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Cost Name" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadTextBox ID="txt_CostCenterName" runat="server" Width="150px" ReadOnly="true" AutoPostBack="false" RenderMode="Lightweight" 
                                                          Text='<%# DataBinder.Eval(Container, "DataItem.CostCenterName") %>'>
                                                        </telerik:RadTextBox>
                                                                                                                                                      
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Remark" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>                
                                                    <td style="vertical-align:top; text-align:left">
                                                        <telerik:RadTextBox ID="txt_remark" runat="server" TextMode="MultiLine"
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'
                                                            Width="350px" Rows="0" TabIndex="5" Resize="Both" Skin="Telerik">
                                                        </telerik:RadTextBox>                                                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        
                                    </tr>   
                                    <tr>
                                        <td colspan="3" style="padding-top:10px; padding-bottom:10px;">
                                            <table class="trxInfo">
                                                <tr>
                                                    <td style="width:auto"> User : </td>
                                                    <td style="width:50px">
                                                        <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="50px" runat="server" BorderStyle="None" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.userid") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="padding-left:15px"> Last Update : </td>
                                                    <td style="width:50px">
                                                        <telerik:RadTextBox ReadOnly="true" ID="txt_LastUpdate" Width="140px" runat="server" BorderStyle="None" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.LastUpdate") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="padding-left:15px"> Owner : </td>
                                                    <td style="width:50px">
                                                        <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="50px" runat="server" BorderStyle="None" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.Owner") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="padding-left:15px"> Printed : </td>
                                                    <td>
                                                        <telerik:RadTextBox ReadOnly="true" ID="txt_printed" Width="40px" runat="server" BorderStyle="None" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.Printed") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="padding-left:15px"> Edited : </td>
                                                    <td>
                                                        <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" runat="server" BorderStyle="None" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.Edited") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>                        
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>

                                <div style="padding: 7px 0px 12px 0px; min-height:275px">
                                    <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="97%" 
                                    SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Silk" CausesValidation="false">
                                        <Tabs>
                                            <telerik:RadTab Text="Detail" Height="15px"> 
                                            </telerik:RadTab>
                                            <telerik:RadTab Text="Journal" Height="15px">
                                            </telerik:RadTab>
                                        </Tabs>
                                    </telerik:RadTabStrip>
                                    <telerik:RadMultiPage runat="server" ID="RadMultiPage1"  SelectedIndex="0" Width="97%" >
                                        <telerik:RadPageView runat="server" ID="RadPageView1" Height="300px">
                                            <div runat="server" style="padding:10px 10px 10px 10px">
                                                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" Skin="Silk" CssClass="RadGrid_ModernBrowsers"
                                                    AllowPaging="false" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="false" ShowStatusBar="true" PageSize="5"
                                                    OnNeedDataSource="RadGrid2_NeedDataSource"
                                                    OnInsertCommand="RadGrid2_InsertCommand"
                                                    OnUpdateCommand="RadGrid2_UpdateCommand"
                                                    OnDeleteCommand="RadGrid2_DeleteCommand"
                                                    OnItemCommand="RadGrid2_ItemCommand"
                                                    OnPreRender="RadGrid2_PreRender">
                                                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                                <HeaderStyle Font-Size="12px" ForeColor="Highlight" />
                                                <MasterTableView CommandItemDisplay="Top"  DataKeyNames="part_code" Font-Size="11px" EditMode="PopUp" 
                                                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item" 
                                                CommandItemSettings-ShowRefreshButton="False" ItemStyle-ForeColor="#006600">
                                                    <EditFormSettings >
                                                        <FormStyle ForeColor="#006666" Width="500px" Height="250px"  />
                                                        <PopUpSettings KeepInScreenBounds="true" Modal="true" />
                                                    </EditFormSettings>
                                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="true" ShowCancelChangesButton="False" />
                                                    <Columns>
                                                            <telerik:GridTemplateColumn HeaderText="Oil Code" HeaderStyle-Width="220px" ItemStyle-Width="220px" HeaderStyle-HorizontalAlign="Left">
                                                                <FooterTemplate>Template footer</FooterTemplate>
                                                                <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" /> 
                                                                <ItemTemplate>    
                                                                    <asp:Label runat="server" ID="lbl_prod_code" Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>'></asp:Label>
                                                                    <telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip1" runat="server" TargetControlID="lbl_prod_code" RelativeTo="Element"
                                                                    Position="BottomCenter" RenderInPageRoot="true">
                                                                    <%--<%# DataBinder.Eval(Container, "DataItem.part_desc")%>  --%>                                              
                                                                    </telerik:RadToolTip>
                                                                </ItemTemplate>
                                                                <%--<EditItemTemplate>                                 
                                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_editTemp" EnableLoadOnDemand="True" DataTextField="spec"
                                                                        DataValueField="Prod_code" AutoPostBack="true" Height="180px"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.part_code") %>' EmptyMessage="- Select product -"
                                                                        HighlightTemplatedItems="true" Width="120px" DropDownWidth="730px" DropDownAutoWidth="Enabled"
                                                                        OnSelectedIndexChanged="cb_prod_code_editTemp_SelectedIndexChanged" 
                                                                        OnItemsRequested="cb_prod_code_editTemp_ItemsRequested" OnPreRender="cb_prod_code_editTemp_PreRender" >                                                   
                                                                        <HeaderTemplate>
                                                                        <table style="width: 730px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 350px;">
                                                                                    Material Code
                                                                                </td>     
                                                                                <td style="width: 120px;">
                                                                                    Specification 
                                                                                </td> 
                                                                                <td style="width: 60px;">
                                                                                    Brand
                                                                                </td> 
                                                                                <td style="width: 120px;">
                                                                                    UoM
                                                                                </td> 
                                                                                <td style="width: 120px;">
                                                                                    SOH
                                                                                </td>                    
                                                                            </tr>
                                                                        </table>                                                       
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <table style="width: 730px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 120px;">
                                                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                                                </td> 
                                                                                <td style="width: 350px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                                                </td>
                                                                                <td style="width: 60px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['brand_name']")%>
                                                                                </td>
                                                                                <td style="width: 120px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['unit']")%>
                                                                                </td>
                                                                                <td style="width: 120px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['QACT']")%>
                                                                                </td>                                                                         
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                    </telerik:RadComboBox>
                                                                    <telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip2" runat="server" TargetControlID="cb_prod_code" RelativeTo="Element"
                                                                    Position="BottomCenter" RenderInPageRoot="true" HideDelay="300" ShowEvent="OnMouseOver">
                                                                    <%# DataBinder.Eval(Container, "DataItem.part_desc")%>                                                
                                                                    </telerik:RadToolTip> 
                                                                </EditItemTemplate>--%>
                                                                <InsertItemTemplate>
                                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_insertTemp" EnableLoadOnDemand="True" DataTextField="spec"
                                                                        DataValueField="Prod_code" AutoPostBack="true" EmptyMessage="- Select product -" Height="350px" CausesValidation="false"
                                                                        HighlightTemplatedItems="true" Width="220px" DropDownWidth="730px" DropDownAutoWidth="Enabled"
                                                                        OnSelectedIndexChanged="cb_prod_code_editTemp_SelectedIndexChanged" OnPreRender="cb_prod_code_editTemp_PreRender" 
                                                                        OnItemsRequested="cb_prod_code_editTemp_ItemsRequested" >                                                   
                                                                        <HeaderTemplate>
                                                                        <table style="width: 730px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 350px;">
                                                                                    Material Code
                                                                                </td>     
                                                                                <td style="width: 120px;">
                                                                                    Specification 
                                                                                </td> 
                                                                                <td style="width: 60px;">
                                                                                    Brand
                                                                                </td> 
                                                                                <td style="width: 120px;">
                                                                                    UoM
                                                                                </td> 
                                                                                <td style="width: 120px;">
                                                                                    SOH
                                                                                </td>                    
                                                                            </tr>
                                                                        </table>                                                       
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <table style="width: 730px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 120px;">
                                                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                                                </td> 
                                                                                <td style="width: 350px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                                                </td>
                                                                                <td style="width: 60px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['brand_name']")%>
                                                                                </td>
                                                                                <td style="width: 120px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['unit']")%>
                                                                                </td>
                                                                                <td style="width: 120px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['QACT']")%>
                                                                                </td>                                                                         
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                    </telerik:RadComboBox>
                                                                </InsertItemTemplate>
                                                            </telerik:GridTemplateColumn>

                                                            <telerik:GridTemplateColumn HeaderText="Specification" HeaderStyle-Width="270px" ItemStyle-Width="270px" HeaderStyle-HorizontalAlign="Left" 
                                                                ItemStyle-HorizontalAlign="Left" >
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblSpec" Text='<%# DataBinder.Eval(Container.DataItem, "part_desc") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:Label runat="server" ID="lblSpec_edit" Text='<%# DataBinder.Eval(Container.DataItem, "part_desc") %>'></asp:Label>
                                                                </EditItemTemplate>
                                                                <InsertItemTemplate>
                                                                    <%--<asp:Label runat="server" ID="lblSpec_insert" ></asp:Label>--%>
                                                                    <telerik:RadTextBox runat="server" ID="txt_spec_insert" Skin="Telerik" Width="350px" ReadOnly="true"></telerik:RadTextBox>
                                                                </InsertItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                    
                                                            <telerik:GridTemplateColumn HeaderText="Qty Out" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                                                                HeaderStyle-HorizontalAlign="Right" DefaultInsertValue="0"  >
                                                                <ItemTemplate>                                                                    
                                                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_Part_Qty" Width="85px" EnabledStyle-HorizontalAlign="Right"
                                                                        BorderStyle="solid" 
                                                                        NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                                        Text='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                                                        onkeydown="blurTextBox(this, event)"
                                                                        AutoPostBack="false" MaxLength="11" Type="Number"
                                                                        NumberFormat-DecimalDigits="2">
                                                                    </telerik:RadNumericTextBox>
                                                                </ItemTemplate>
                                                                <%--<EditItemTemplate>
                                                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_Part_Qty_edit" Width="85px" EnabledStyle-HorizontalAlign="Right"
                                                                        NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                                        Text='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                                                        onkeydown="blurTextBox(this, event)"
                                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                                        NumberFormat-DecimalDigits="2">
                                                                    </telerik:RadNumericTextBox>
                                                                </EditItemTemplate>--%>
                                                                <InsertItemTemplate>
                                                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_Part_Qty_insert" Width="85px" EnabledStyle-HorizontalAlign="Right"
                                                                        NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                                        onkeydown="blurTextBox(this, event)"
                                                                        AutoPostBack="false" MaxLength="11" Type="Number"
                                                                        NumberFormat-DecimalDigits="2">
                                                                    </telerik:RadNumericTextBox>
                                                                </InsertItemTemplate>
                                                            </telerik:GridTemplateColumn>

                                                            <telerik:GridTemplateColumn HeaderText="Uom" HeaderStyle-Width="80px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center"
                                                                HeaderStyle-HorizontalAlign="Center" 
                                                                >
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblUom" Width="80px" Text='<%# DataBinder.Eval(Container.DataItem, "uom") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:Label runat="server" ID="lblUom_edit" Width="80px" Text='<%# DataBinder.Eval(Container.DataItem, "uom") %>'></asp:Label>
                                                                </EditItemTemplate>
                                                                <InsertItemTemplate>
                                                                    <%--<asp:Label runat="server" ID="lblUom_insert" Width="80px" ></asp:Label>--%>
                                                                    <telerik:RadTextBox runat="server" ID="txt_uom_insert" Skin="Telerik" ReadOnly="true"></telerik:RadTextBox>
                                                                </InsertItemTemplate>
                                                            </telerik:GridTemplateColumn>

                                                            <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" 
                                                                ConfirmDialogType="Classic" ButtonType="FontIconButton" ItemStyle-Width="25px" HeaderStyle-Width="25px">
                                                            </telerik:GridButtonColumn>
                                                        </Columns>
                                                </MasterTableView>
                                                <ClientSettings>
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="198px" />
                                                        <Selecting AllowRowSelect="true"></Selecting> 
                                                </ClientSettings>
                                                </telerik:RadGrid> 
                                            </div>                
                                        </telerik:RadPageView>
                                        <telerik:RadPageView runat="server" ID="RadPageView2" Height="300px">
                                            <div runat="server" style="padding:15px 15px 15px 15px">
                                                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" AutoGenerateColumns="false" Skin="Silk" CssClass="RadGrid_ModernBrowsers"
                                                    AllowPaging="false" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" ShowStatusBar="true"  >
                                                    <HeaderStyle Font-Size="12px" />
                                                    <AlternatingItemStyle Font-Size="10px" Font-Names="Comic Sans MS" />
                                                    <MasterTableView DataKeyNames="nomor" HeaderStyle-ForeColor="Highlight" ItemStyle-Font-Size="10px" ItemStyle-Font-Names="Comic Sans MS"
                                                            HorizontalAlign="NotSet" AutoGenerateColumns="False">
                                                        <SortExpressions>
                                                            <telerik:GridSortExpression FieldName="nomor" SortOrder="Descending" />
                                                        </SortExpressions>
                                                        <ColumnGroups>
                                                            <telerik:GridColumnGroup Name="IDR" HeaderText="IDR"
                                                                HeaderStyle-HorizontalAlign="Center" />
                                                            <telerik:GridColumnGroup Name="Valas" HeaderText="Valas"
                                                                HeaderStyle-HorizontalAlign="Center" />
                                                        </ColumnGroups>
                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="accountcode" HeaderStyle-Width="100px" HeaderText="Account No." SortExpression="accountcode"
                                                                UniqueName="accountcode" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="70px" 
                                                                >                                
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="accountname" HeaderStyle-Width="250px" HeaderText="Account Name" SortExpression="accountname"
                                                                UniqueName="accountname" ReadOnly="true" HeaderStyle-HorizontalAlign="Center"
                                                                >                                
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="debet" HeaderStyle-Width="100px" HeaderText="Debet" SortExpression="debet"
                                                                UniqueName="debet" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" 
                                                                DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#00CC00">                                
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="credit" HeaderStyle-Width="100px" HeaderText="Credit" SortExpression="credit"
                                                                UniqueName="credit" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" 
                                                                DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#00CC00">                                
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="remark" HeaderStyle-Width="200px" HeaderText="Remark" SortExpression="remark"
                                                                UniqueName="remark" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" >
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings AllowKeyboardNavigation="true">
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="310px" />
                                                        <Selecting AllowRowSelect="true"></Selecting>     
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </div>
                                        </telerik:RadPageView>

                                          
                                    </telerik:RadMultiPage>
                                </div>
                            </div>
                        </FormTemplate>
                    </EditFormSettings>
                </MasterTableView>
                <ClientSettings>
                    <Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="255px" />
                    <Selecting AllowRowSelect="true" />
                    <ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />
            </ClientSettings>
            </telerik:RadGrid>
        </div>

        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data tersimpan" Position="BottomRight"
            AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
        </telerik:RadNotification>

        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1150px" Height="670px" Modal="true" AutoSize="True">
                </telerik:RadWindow>
                <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1400px" Height="720px" Modal="true" AutoSize="False">
                </telerik:RadWindow>                
            </Windows>
        </telerik:RadWindowManager>
        
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
       
    </div>     
</asp:Content>
