<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="pur01h01.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.PurchaseReq.Asset.pur01h01" %>

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
   <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="500" BackgroundPosition="None" Skin="Material">
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
            <td style="width: 95%; text-align: right">
                <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight:normal; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                    padding-bottom: 0px; font-size: x-large; color:#0099dc;">
                </telerik:RadLabel>
            </td>
            </tr>
        </table>
    </div>    

    <div class="scroller" runat="server" style="overflow-y:scroll; height:620px;" > 

        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" ShowFooter="false" Skin="Silk" CssClass="RadGrid_ModernBrowsers" 
        AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="14" MasterTableView-GridLines="None" 
        OnNeedDataSource="RadGrid1_NeedDataSource" 
        OnItemCommand="RadGrid1_ItemCommand"
        OnDeleteCommand="RadGrid1_DeleteCommand" 
        OnItemCreated="RadGrid1_ItemCreated" 
        OnPreRender="RadGrid1_PreRender"
        OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" >
        <PagerStyle Mode="NumericPages" ForeColor="#0099CC"></PagerStyle>               
        <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px" HorizontalAlign="Center"/>
        <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
        <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
        <SortingSettings EnableSkinSortStyles="false" />
        <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="pr_code" Font-Size="11px" Font-Names="Century Gothic"
        EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
        CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight">
            <Columns>
                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  
                    HeaderStyle-Width="30px" ItemStyle-Width="30px" UpdateText="Update" >
                </telerik:GridEditCommandColumn>
                <telerik:GridBoundColumn UniqueName="pr_code" HeaderText="PR Number" DataField="pr_code" ItemStyle-Width="150px" FilterControlWidth="110px" 
                    ItemStyle-HorizontalAlign="Left" >
                    <HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridDateTimeColumn UniqueName="Pr_date" HeaderText="Date" DataField="Pr_date" ItemStyle-Width="150px"
                    EnableRangeFiltering="false" FilterControlWidth="125px" PickerType="DatePicker"
                    DataFormatString="{0:d}">
                    <HeaderStyle Width="150px"  HorizontalAlign="Center"></HeaderStyle>                    
                </telerik:GridDateTimeColumn>
                <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project" DataField="region_code" ItemStyle-Width="125px" 
                FilterControlWidth="90px">
                <HeaderStyle Width="125px"  HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="reff_no" HeaderText="Reff Number" DataField="reff_no" ItemStyle-Width="150px" FilterControlWidth="120px">
                    <HeaderStyle Width="150px"  HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>   
                <telerik:GridBoundColumn UniqueName="wo_no" HeaderText="WO Number" DataField="wo_no" ItemStyle-Width="150px" FilterControlWidth="120px" >
                    <HeaderStyle Width="150px"  HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>                    
                <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"  
                    ItemStyle-Width="350px" FilterControlWidth="340px">
                    <HeaderStyle Width="350px"  HorizontalAlign="Center"></HeaderStyle>
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
                <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete"
                    ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="25px"
                    ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="Classic" ButtonType="FontIconButton" ItemStyle-ForeColor="#ff0000">
                </telerik:GridButtonColumn>
            </Columns>
            <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                            <div style="padding: 15px 0px 0px 25px;">
                                <table id="Table2" width="Auto" border="0" class="module">
                                    <tr>
                                        <td colspan="4" style="padding: 0px 0px 10px 0px; text-align:left">
                                            <asp:Button ID="btnSave" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" OnClick="btn_save_Click" Height="25px" 
                                                Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" 
                                                CssClass="btn-entryFrm" >
                                            </asp:Button>&nbsp;
                            
                                            <asp:Button ID="btnCancel" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" 
                                                Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                                runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                                        </td>
                                    </tr>  
                                    <tr>
                                        <td style="vertical-align:top; width:auto">
                                            <table>
                                                <tr style="vertical-align: top">                               
                                                    <td  style="vertical-align: top;">
                                                        <telerik:RadLabel runat="server" Text="PR Number" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                                    </td>
                                                    <td>
                                                        <telerik:RadTextBox ID="txt_doc_code" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight"
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.pr_code") %>'   EmptyMessage="Let it blank">
                                                        </telerik:RadTextBox>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td  style="vertical-align: top">
                                                        <telerik:RadLabel runat="server" Text="PR Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadDatePicker ID="dtp_pr" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                            TabIndex="4" Skin="Telerik" DBSelectedDate='<%# DataBinder.Eval(Container, "DataItem.Pr_date") %>'>
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;">
                                                            </Calendar>
                                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                                                            </DateInput>
                                                        </telerik:RadDatePicker>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Priority" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_priority" runat="server" Width="150px"
                                                            AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.prio_desc") %>'  
                                                            OnItemsRequested="cb_priority_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_priority_SelectedIndexChanged" 
                                                            OnPreRender="cb_priority_PreRender">
                                                        </telerik:RadComboBox>
                                                          
                                                    </td>
                                                </tr>                            
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Asset Reg." CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td style="width:300px"> 
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_asset_reg" runat="server" Width="200px" AutoPostBack="true" CausesValidation="false"
                                                            DropDownWidth="500px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" ShowMoreResultsBox="true" 
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.asset_id") %>'
                                                            OnItemsRequested="cb_asset_reg_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_asset_reg_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 500px; font-size: smaller">
                                                                        <tr>
                                                                            <td style="width: 100px; font-variant:small-caps; color: #3399FF;">REQUEST CODE
                                                                            </td>
                                                                            <td style="width: 400px;font-variant:small-caps; color: #3399FF;">ASSET NAME
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 500px; font-size: smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.doc_code")%>
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.part_desc")%>
                                                                            </td>
                                                                        </tr>
                                                                    </table>

                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </telerik:RadComboBox>
                                                            <asp:RequiredFieldValidator runat="server" ID="reffCodeValidator" ControlToValidate="cb_asset_reg" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>
                                                            
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>                            
                                                        <telerik:RadLabel runat="server" Text="Project Area" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td> 
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="200" DropDownWidth="300px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' 
                                                            AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                            OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged" Font-Size="Small"
                                                            OnPreRender="cb_project_PreRender">
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_project" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>                     
                                                           
                                                    </td>
                                                </tr>                                       
                                                <tr>
                                                    <td style="vertical-align: top">
                                                        <telerik:RadLabel runat="server" Text="Cost Center" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td> 
                                                        <telerik:RadComboBox ID="cb_cost_ctr" runat="server" Width="200px"
                                                            DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" 
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>'
                                                            OnItemsRequested="cb_cost_ctr_ItemsRequested" OnSelectedIndexChanged="cb_cost_ctr_SelectedIndexChanged" 
                                                            OnPreRender="cb_cost_ctr_PreRender">
                                                                <HeaderTemplate>
                                                                <table style="width: 450px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 100px;">Code
                                                                        </td>
                                                                        <td style="width: 350px;">Name
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 450px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 100px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.code")%>
                                                                        </td>
                                                                        <td style="width: 350px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="cost_ctr_Validator" ControlToValidate="cb_cost_ctr" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="vertical-align:top">
                                            <table>
                                                <tr><td>
                                                        <telerik:RadLabel runat="server" Text="Storage" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>                          
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="300px" DropDownWidth="300px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.wh_name") %>'  
                                                            ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                                            OnItemsRequested="cb_warehouse_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged"
                                                            OnPreRender="cb_warehouse_PreRender">
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="warehouseValidator" ControlToValidate="cb_warehouse" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="*"></asp:RequiredFieldValidator>
                                                    </td>
                                                    </tr>
                                                <tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Remark" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                                    </td>
                                                    <td> 
                                                        <telerik:RadTextBox ID="txt_remark"
                                                            runat="server" TextMode="MultiLine"  Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'
                                                            Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                                            
                                                <tr>
                                                    <td style="vertical-align: top; text-align: left">
                                                        <telerik:RadLabel runat="server" Text="Order By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_orderBy" runat="server" Width="250px" Text='<%# DataBinder.Eval(Container, "DataItem.NameOrderBy") %>'
                                                                    DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" Height="300px"
                                                                    MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                                    OnItemsRequested="cb_orderBy_ItemsRequested"
                                                                    OnSelectedIndexChanged="cb_orderBy_SelectedIndexChanged"
                                                                    OnPreRender="cb_orderBy_PreRender">
                                                                <HeaderTemplate>
                                                                <table style="width: 450px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 200px;">Name
                                                                        </td>
                                                                        <td style="width: 250px;">Position
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 450px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 200px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                        </td>
                                                                        <td style="width: 250px;">
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
                                                    <td style="vertical-align: top; text-align: left">
                                                        <telerik:RadLabel runat="server" Text="Checked By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_checked" runat="server" Width="250px"
                                                            DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.NameCekBy") %>'  Height="300px"
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                            OnItemsRequested="cb_received_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_received_SelectedIndexChanged"
                                                            OnPreRender="cb_received_PreRender">
                                                            <HeaderTemplate>
                                                                <table style="width: 450px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 200px;">Name
                                                                        </td>
                                                                        <td style="width: 250px;">Position
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 450px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 200px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                        </td>
                                                                        <td style="width: 250px;">
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
                                                    <td style="vertical-align: top; text-align: left; ">
                                                        <telerik:RadLabel CssClass="lbObject" runat="server" Text="Approved By" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td> 
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px"
                                                            DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true"  Height="300px"
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.NameAppBy") %>'
                                                            OnItemsRequested="cb_approved_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                            OnPreRender="cb_approved_PreRender" >
                                                            <HeaderTemplate>
                                                                <table style="width: 450px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 200px;">Name
                                                                        </td>
                                                                        <td style="width: 250px;">Position
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 450px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 200px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                        </td>
                                                                        <td style="width: 250px;">
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
                                                     
                                                    <telerik:RadLabel runat="server" Text="Owner:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="50px" runat="server" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.owner") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td style="padding:0px 10px 0px 10px">
                                                     
                                                    <telerik:RadLabel runat="server" Text="Printed:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_printed" Width="40px" runat="server" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.printed") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td style="padding:0px 10px 0px 10px">
                                                    
                                                    <telerik:RadLabel runat="server" Text="Edited:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" runat="server" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Edited") %>'>
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

                                <div style="padding: 15px 0px 12px 0px; height:288px">    
                                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" Skin="Silk" CssClass="RadGrid_ModernBrowsers"
                                        AllowPaging="false" PageSize="5" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" ShowStatusBar="true" 
                                        OnNeedDataSource="RadGrid2_NeedDataSource">
                                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                        <HeaderStyle Font-Size="10px" Font-Bold="true" />
                                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="Prod_code" Font-Size="11px"
                                        ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item" 
                                        CommandItemSettings-ShowRefreshButton="False" ItemStyle-ForeColor="#006600">
                                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="False" ShowCancelChangesButton="false" />
                                            <Columns>                                                
                                                <telerik:GridTemplateColumn HeaderText="Asset Name" HeaderStyle-Width="200px" ItemStyle-Width="200px" >
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblDescription" Width="200px" Text='<%# DataBinder.Eval(Container, "DataItem.part_desc") %>'></asp:Label>
                                                    </ItemTemplate>                                        
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Part Code" HeaderStyle-Width="150px" ItemStyle-Width="150px"
                                                    HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblProdCode" Width="150px" Text='<%# DataBinder.Eval(Container, "DataItem.Prod_code") %>'></asp:Label>
                                                    </ItemTemplate>                                        
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right" 
                                                    DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="70px"  ReadOnly="true" 
                                                            EnabledStyle-HorizontalAlign="Right"
                                                            NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.qty", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                                            NumberFormat-DecimalDigits="2">
                                                        </telerik:RadTextBox>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="PO Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center"
                                                    HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblQtyPo" Text='<%# DataBinder.Eval(Container, "DataItem.qtypo", "{0:#,###,###0.00}") %>'></asp:Label>
                                                    </ItemTemplate>                                        
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="50px" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center" >
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblUom" Width="50px" Text='<%# DataBinder.Eval(Container, "DataItem.SatQty") %>'></asp:Label>
                                                    </ItemTemplate>                                        
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Delivery Date" HeaderStyle-Width="110px"  ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                    HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>  
                                                        <telerik:RadDatePicker runat="server" ID="dtpDelivDate" Width="100px"
                                                            SelectedDate='<%#DataBinder.Eval(Container, "DataItem.DeliDate")%>' 
                                                            onkeydown="blurTextBox(this, event)" Type="Date">
                                                            <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                                        </telerik:RadDatePicker>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn> 
                            
                                                <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="280px" ItemStyle-Width="280px"
                                                    HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="280px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>'>
                                                        </telerik:RadTextBox>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                                                    ConfirmTitle="Delete" ConfirmDialogType="Classic"
                                                    ButtonType="FontIconButton" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-ForeColor="Red" 
                                                    ItemStyle-HorizontalAlign="Center">
                                                </telerik:GridButtonColumn>

                                            </Columns>
                                        </MasterTableView>
                                        <ClientSettings >
                                            <Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="150px" />  
                                            <Selecting AllowRowSelect="true"></Selecting>                          
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                    <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Text="Data tersimpan" Position="BottomRight"
                                            AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
                                    </telerik:RadNotification>                                         
                                </div>
                            </div>
                        </FormTemplate>
            </EditFormSettings>
            </MasterTableView>
            <ClientSettings>
                <Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="255px" />
                <Selecting AllowRowSelect="true"></Selecting>                    
            </ClientSettings>
            </telerik:RadGrid>
         
    </div>

        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1150px" Height="670px" Modal="true" AutoSize="True">
                </telerik:RadWindow>
                <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1300px" Height="670px" Modal="true" AutoSize="False">
                </telerik:RadWindow>
                
            </Windows>
        </telerik:RadWindowManager>
        
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
    
</asp:Content>
