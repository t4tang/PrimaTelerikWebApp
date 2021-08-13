<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="pur01h01a.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.PurchaseReq.pur01h01a" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
    <script type="text/javascript" src="../../../Script/Script.js"></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
       
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("pur01h01aReportViewer.aspx?pr_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            
            function ShowInsertForm() {                
                window.radopen("pur01h01aEditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("pur01h01aEditForm.aspx?pr_code=" + id, "EditDialogWindows");
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
            
           <%-- <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2" ></telerik:AjaxUpdatedControl>  
                </UpdatedControls>        
            </telerik:AjaxSetting> 
                  
            <telerik:AjaxSetting AjaxControlID="btn_save">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>  
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2"></telerik:AjaxUpdatedControl>                    
                </UpdatedControls>                
            </telerik:AjaxSetting>--%>
        </AjaxSettings>
    </telerik:RadAjaxManager>

   <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None" BackColor="Transparent" >
        <img alt="Loading..." src="../../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 115px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="1000" BackgroundPosition="None" >
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="2000"></telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="450px" Height="350px" VisibleStatusbar="False" AutoSize="True" Behaviors="Close">
        <ContentTemplate>
            <div runat="server" style="padding: 20px 10px 10px 10px;" id="Div1">
                <table>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Date From :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Silk"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Silk"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight"
                               EnableLoadOnDemand="True"  Skin="Silk" OnItemsRequested="cb_project_prm_ItemsRequested" 
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
                
    <div  class="scroller" runat="server" style="overflow-y:scroll; height:620px">
        <div runat="server" style="width:100%; overflow-y:hidden; min-height:620px; scrollbar-highlight-color:#b6ff00;">

            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" PageSize="14" ShowFooter="false" Skin="Silk"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" MasterTableView-GridLines="None" CssClass="RadGrid_ModernBrowsers"
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" 
                OnItemCreated="RadGrid1_ItemCreated" 
                OnItemCommand="RadGrid1_ItemCommand"
                OnPreRender="RadGrid1_PreRender"
                OnNeedDataSource="RadGrid1_NeedDataSource"
                OnDeleteCommand="RadGrid1_DeleteCommand"  
                OnItemDataBound="RadGrid1_ItemDataBound">
                <PagerStyle ForeColor="#0099CC" VerticalAlign="Middle" Mode="NextPrevAndNumeric"></PagerStyle>               
                <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px" HorizontalAlign="Center"/>
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
                <SortingSettings EnableSkinSortStyles="false" />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="pr_code" Font-Size="11px"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowRefreshButton="False" CommandItemSettings-ShowAddNewRecordButton="False">
                    <SortExpressions >
                        <telerik:GridSortExpression FieldName="pr_code" SortOrder="Ascending" />
                    </SortExpressions>
                    <Columns>
                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  
                            HeaderStyle-Width="30px" ItemStyle-Width="30px" UpdateText="Update" >
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="pr_code" HeaderText="PR Number" DataField="pr_code" ItemStyle-Width="108px" >
                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="Pr_date" HeaderText="Date" DataField="Pr_date" ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Left"
                            EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker"
                            DataFormatString="{0:d}">
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project " DataField="region_code" ItemStyle-HorizontalAlign="Left"
                            ItemStyle-Width="80px" FilterControlWidth="60px">
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="dept_code" HeaderText="Cost Center" DataField="dept_code" ItemStyle-HorizontalAlign="Left"
                            ItemStyle-Width="95px" FilterControlWidth="80px">
                            <HeaderStyle Width="95px"></HeaderStyle>
                        </telerik:GridBoundColumn>           
                        <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                            ItemStyle-Width="400px" FilterControlWidth="400px">
                            <HeaderStyle Width="400px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <%--<telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" AllowFiltering="False">
                            <ItemTemplate>                                
                                <asp:ImageButton ID="EditLink" runat="server" Height="22px" Width="28px" ImageUrl="~/Images/edit.png" ToolTip="Edit" />
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
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton" ItemStyle-ForeColor="#66CCFF">
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
                                                    <td colspan="3" style="padding: 0px 0px 10px 0px; text-align:left">
                                                        <asp:Button ID="btnUpdate" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px"  Height="25px" 
                                                            Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" 
                                                            OnClick="btnUpdate_Click"  CssClass="btn-entryFrm" >
                                                        </asp:Button>&nbsp;
                            
                                                        <asp:Button ID="btnCancel" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" 
                                                            Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                                            runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                                                    </td>
                                                </tr>  
                                                <tr>                              
                                                    <td  style="vertical-align: top; width:120px">
                                                        <telerik:RadLabel runat="server" Text="PR Number :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    <td/>
                                                    <td>
                                                        <telerik:RadTextBox ID="txt_doc_code" runat="server" Width="300px" ReadOnly="true"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.pr_code") %>' 
                                                            RenderMode="Lightweight" Font-Size="Small">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td >
                                                        <telerik:RadLabel runat="server" Text="Priority :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    <td/>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="300" DropDownWidth="300px"
                                                            AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.prio_desc") %>'  
                                                            OnItemsRequested="cb_priority_ItemsRequested" OnSelectedIndexChanged="cb_priority_SelectedIndexChanged" OnPreRender="cb_priority_PreRender">
                                                        </telerik:RadComboBox>  
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td >
                                                        <telerik:RadLabel runat="server" Text="PR Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    <td/>
                                                    <td>                          
                                                        <telerik:RadDatePicker ID="dtp_pr" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                            Skin="Telerik" 
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.Pr_date") %>'>
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" >
                                                            </Calendar>
                                                            <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" >
                                                            </DateInput>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                                        </telerik:RadDatePicker>                       
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td >
                                                        <telerik:RadLabel runat="server" Text="PR Source :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel> 
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_type_ref" ForeColor="Red" 
                                                            Font-Size="X-Small"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <td/>
                                                    <td>                          
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_type_ref" runat="server" Width="300"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.type_source") %>'  
                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Telerik" EnableVirtualScrolling="true"
                                                            OnItemsRequested="cb_type_ref_ItemsRequested" OnPreRender="cb_type_ref_PreRender">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Project Area :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_project" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="*"></asp:RequiredFieldValidator>
                                                    <td/>
                                                    <td>   
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>'  
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                        OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged" OnPreRender="cb_project_PreRender">
                                                        </telerik:RadComboBox>          
                                    
                                                    </td>
                                                </tr>                                                               
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Storage :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        <asp:RequiredFieldValidator runat="server" ID="warehouseValidator" ControlToValidate="cb_warehouse" ForeColor="Red" 
                                                                    Font-Size="X-Small" Text="*"></asp:RequiredFieldValidator>
                                                    <td/>
                                                    <td>                          
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="300px" DropDownWidth="300px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.wh_name") %>'  
                                                            ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                                            OnItemsRequested="cb_warehouse_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged"
                                                            OnPreRender="cb_warehouse_PreRender">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Cost Center :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_cost_ctr" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="*"></asp:RequiredFieldValidator>
                                                    <td/>
                                                    <td>                          
                                                        <telerik:RadComboBox ID="cb_cost_ctr" runat="server" Width="300px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.CostCenterName") %>'  
                                                            DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" 
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
                                                    </td>
                                                </tr>
                                            </table>
                                        <td style="vertical-align:top; padding-left:20px">
                                            <table>                            
                                                <tr>                                                        
                                                    <td style="vertical-align: top; width:130px">
                                                        <telerik:RadLabel runat="server" Text="Remark :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadTextBox ID="txt_remark" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'  
                                                            runat="server" TextMode="MultiLine" Skin="Telerik"
                                                            Width="600px" Rows="0" Resize="None">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Prepare By :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_prepare_by" runat="server" Width="300px" Height="300px" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.NameOrderBy") %>'  
                                                            DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                                OnItemsRequested="cb_prepare_by_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_prepare_by_SelectedIndexChanged" OnPreRender="cb_prepare_by_PreRender">
                                                                <HeaderTemplate>
                                                                <table style="width: 550px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 200px;">Name
                                                                        </td>
                                                                        <td style="width: 350px;">Position
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 550px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 200px;">
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
                                                    <td >
                                                        <telerik:RadLabel runat="server" Text="Order By :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_orderBy" runat="server" Width="300px" Height="300px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.NameOrderBy") %>'  
                                                            DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                            MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" 
                                                            OnItemsRequested="cb_orderBy_ItemsRequested" OnSelectedIndexChanged="cb_orderBy_SelectedIndexChanged"
                                                            OnPreRender="cb_orderBy_PreRender">
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
                                                    <td >
                                                        <telerik:RadLabel runat="server" Text="Checked By :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_checked" runat="server" Width="300px" Height="300px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.NameCekBy") %>'  
                                                            DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                            OnItemsRequested="cb_received_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_received_SelectedIndexChanged"
                                                            OnPreRender="cb_received_PreRender">
                                                            <HeaderTemplate>
                                                                <table style="width: 550px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 200px;">Name
                                                                        </td>
                                                                        <td style="width: 350px;">Position
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 550px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 200px;">
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
                                                    <td  style="vertical-align: top; text-align: left; ">
                                                        <telerik:RadLabel CssClass="lbObject" runat="server" Text="Approved By :" Skin="Silk"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="300px" Height="300px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.NameAppBy") %>'  
                                                            DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true"
                                                            OnItemsRequested="cb_approved_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                            OnPreRender="cb_approved_PreRender" >
                                                            <HeaderTemplate>
                                                                <table style="width: 550px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 200px;">Name
                                                                        </td>
                                                                        <td style="width: 350px;">Position
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 550px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 200px;">
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
                                    </table>
                                <div style="padding: 7px 0px 12px 0px; min-height:275px">           
                                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="4"  Skin="Silk"
                                        AllowPaging="false" AllowSorting="true" runat="server" CssClass="RadGrid_Silk"
                                        OnNeedDataSource="RadGrid2_NeedDataSource" 
                                        OnInsertCommand="RadGrid2_InsertCommand"  
                                        OnDeleteCommand="RadGrid2_DeleteCommand" 
                                        OnUpdateCommand="RadGrid2_UpdateCommand"
                                        OnItemCommand="RadGrid2_ItemCommand">
                                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                        <HeaderStyle Font-Size="11px" BackColor="#999999" ForeColor="White" />
                                        <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="prod_code" Font-Size="11px" EditMode="PopUp" BorderStyle="Solid" 
                                            BorderColor="Silver" BorderWidth="1px" ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >
                                            <EditFormSettings >
                                                <FormStyle ForeColor="#006666" Width="500px" Height="250px"  />
                                                <PopUpSettings KeepInScreenBounds="true" Modal="true" />
                                            </EditFormSettings>
                                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="true" ShowCancelChangesButton="false" />
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="RS Number" HeaderStyle-Width="100px" ItemStyle-Width="100px" >
                                                    <ItemTemplate>
                                                        <%--<asp:Label runat="server" ID="lblRS" Text='<%# DataBinder.Eval(Container.DataItem, "no_ref") %>'></asp:Label>--%>
                                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_reff_code" EnableLoadOnDemand="True" DataTextField="doc_code"
                                                            DataValueField="doc_code" AutoPostBack="true" CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.no_ref") %>' 
                                                            HighlightTemplatedItems="true" Width="130px" DropDownWidth="1030px" DropDownAutoWidth="Enabled"
                                                            OnItemsRequested="cb_reff_code_ItemsRequested" >                                                   
                                                            <HeaderTemplate>
                                                            <table style="width: 1030px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 30px;background-color:#23afad">
                                                                        Type
                                                                    </td> 
                                                                    <td style="width: 150px;background-color:#23afad">
                                                                        Prod. Code
                                                                    </td>     
                                                                    <td style="width: 320px;background-color:#23afad">
                                                                        Prod. Name
                                                                    </td> 
                                                                    <td style="width: 120px;background-color:#23afad">
                                                                        Doc. Number
                                                                    </td> 
                                                                    <td style="width: 100px;background-color:#23afad">
                                                                        Doc. Date
                                                                    </td> 
                                                                    <td style="width: 120px;background-color:#23afad">
                                                                        Req. Number
                                                                    </td> 
                                                                    <td style="width: 60px;background-color:#23afad">
                                                                        Qty
                                                                    </td> 
                                                                    <td style="width: 50px;background-color:#23afad">
                                                                        UoM
                                                                    </td>  
                                                                    <td style="width: 70px;background-color:#23afad">
                                                                        Cost Cntr
                                                                    </td>                                                           
                                                                </tr>
                                                            </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 1030px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 30px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['prod_type']")%>
                                                                    </td>
                                                                    <td style="width: 150px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['Prod_code']")%>
                                                                    </td>
                                                                    <td style="width: 320px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['part_desc']")%>
                                                                    </td>        
                                                                    <td style="width: 120px;">
                                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                                    </td> 
                                                                    <td style="width: 100px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['doc_date']")%>
                                                                    </td>
                                                                    <td style="width: 120px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['sro_code']")%>
                                                                    </td>
                                                                    <td style="width: 60px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['qtyRema']")%>
                                                                    </td>
                                                                    <td style="width: 50px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['part_unit']")%>
                                                                    </td>     
                                                                    <td style="width: 70px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['dept_code']")%>
                                                                    </td>                                                                                                                           
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                        </telerik:RadComboBox>
                                                    </ItemTemplate>
                                                    <InsertItemTemplate>
                                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_reff_code_insert" EnableLoadOnDemand="True" DataTextField="doc_code"
                                                            DataValueField="doc_code" AutoPostBack="true"  CausesValidation="false"
                                                            HighlightTemplatedItems="true" Width="130px" DropDownWidth="1030px" DropDownAutoWidth="Enabled"
                                                            OnItemsRequested="cb_reff_code_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_reff_code_insert_SelectedIndexChanged" >                                                   
                                                            <HeaderTemplate>
                                                            <table style="width: 1030px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 30px;background-color:#23afad">
                                                                        Type
                                                                    </td> 
                                                                    <td style="width: 150px;background-color:#23afad">
                                                                        Prod. Code
                                                                    </td>     
                                                                    <td style="width: 320px;background-color:#23afad">
                                                                        Prod. Name
                                                                    </td> 
                                                                    <td style="width: 120px;background-color:#23afad">
                                                                        Doc. Number
                                                                    </td> 
                                                                    <td style="width: 100px;background-color:#23afad">
                                                                        Doc. Date
                                                                    </td> 
                                                                    <td style="width: 120px;background-color:#23afad">
                                                                        Req. Number
                                                                    </td> 
                                                                    <td style="width: 60px;background-color:#23afad">
                                                                        Qty
                                                                    </td> 
                                                                    <td style="width: 50px;background-color:#23afad">
                                                                        UoM
                                                                    </td>  
                                                                    <td style="width: 70px;background-color:#23afad">
                                                                        Cost Cntr
                                                                    </td>                                                           
                                                                </tr>
                                                            </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 1030px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 30px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['prod_type']")%>
                                                                    </td>
                                                                    <td style="width: 150px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['Prod_code']")%>
                                                                    </td>
                                                                    <td style="width: 320px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['part_desc']")%>
                                                                    </td>        
                                                                    <td style="width: 120px;">
                                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                                    </td> 
                                                                    <td style="width: 100px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['doc_date']")%>
                                                                    </td>
                                                                    <td style="width: 120px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['sro_code']")%>
                                                                    </td>
                                                                    <td style="width: 60px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['qtyRema']")%>
                                                                    </td>
                                                                    <td style="width: 50px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['part_unit']")%>
                                                                    </td>     
                                                                    <td style="width: 70px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['dept_code']")%>
                                                                    </td>                                                                                                                           
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                        </telerik:RadComboBox>
                                                    </InsertItemTemplate>                                        
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn UniqueName="prod_code" HeaderText="Product Code" HeaderStyle-Width="130px"
                                                    SortExpression="prod_code" ItemStyle-Width="130px" >
                                                    <FooterTemplate>Template footer</FooterTemplate>
                                                    <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />                                            
                                                    <ItemTemplate>
                                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="spec"
                                                            DataValueField="Prod_code" AutoPostBack="true" CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.Prod_code") %>' 
                                                            HighlightTemplatedItems="true" Width="130px" DropDownWidth="1030px" DropDownAutoWidth="Enabled"
                                                             >                                                   
                                                            <HeaderTemplate>
                                                            <table style="width: 1030px; font-size:smaller">
                                                                <tr >
                                                                    <td style="width: 30px; background-color:#23afad">
                                                                        Type
                                                                    </td> 
                                                                    <td style="width: 150px;background-color:#23afad">
                                                                        Prod. Code
                                                                    </td>     
                                                                    <td style="width: 320px;background-color:#23afad">
                                                                        Prod. Name
                                                                    </td> 
                                                                    <td style="width: 120px;background-color:#23afad">
                                                                        Doc. Number
                                                                    </td> 
                                                                    <td style="width: 100px;background-color:#23afad">
                                                                        Doc. Date
                                                                    </td> 
                                                                    <td style="width: 120px;background-color:#23afad">
                                                                        Req. Number
                                                                    </td> 
                                                                    <td style="width: 60px;background-color:#23afad">
                                                                        Qty
                                                                    </td> 
                                                                    <td style="width: 50px;background-color:#23afad">
                                                                        UoM
                                                                    </td>  
                                                                    <td style="width: 70px;background-color:#23afad">
                                                                        Cost Cntr
                                                                    </td>                                                           
                                                                </tr>
                                                            </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 1030px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 30px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['prod_type']")%>
                                                                    </td>
                                                                    <td style="width: 150px;">
                                                                         <%# DataBinder.Eval(Container, "Value")%>
                                                                    </td>
                                                                    <td style="width: 320px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['part_desc']")%>
                                                                    </td>        
                                                                    <td style="width: 120px;">
                                                                        <%# DataBinder.Eval(Container, "Text")%>
                                                                    </td> 
                                                                    <td style="width: 100px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['doc_date']")%>
                                                                    </td>
                                                                    <td style="width: 120px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['sro_code']")%>
                                                                    </td>
                                                                    <td style="width: 60px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['qtyRema']")%>
                                                                    </td>
                                                                    <td style="width: 50px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['part_unit']")%>
                                                                    </td>     
                                                                    <td style="width: 70px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['dept_code']")%>
                                                                    </td>                                                                                                                           
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                        </telerik:RadComboBox>
                                                        <telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip1" runat="server" TargetControlID="cb_prod_code" RelativeTo="Element"
                                                        Position="BottomCenter" RenderInPageRoot="true">
                                                        <%# DataBinder.Eval(Container, "DataItem.part_desc")%>                                                
                                                        </telerik:RadToolTip>
                                                    </ItemTemplate>
                                                    <InsertItemTemplate>
                                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_insert" EnableLoadOnDemand="True" DataTextField="spec"
                                                            DataValueField="Prod_code" AutoPostBack="true" CausesValidation="false"
                                                            HighlightTemplatedItems="true" Width="130px" DropDownWidth="1030px" DropDownAutoWidth="Enabled"
                                                             >                                                   
                                                            <HeaderTemplate>
                                                            <table style="width: 1030px; font-size:smaller">
                                                                <tr >
                                                                    <td style="width: 30px; background-color:#23afad">
                                                                        Type
                                                                    </td> 
                                                                    <td style="width: 150px;background-color:#23afad">
                                                                        Prod. Code
                                                                    </td>     
                                                                    <td style="width: 320px;background-color:#23afad">
                                                                        Prod. Name
                                                                    </td> 
                                                                    <td style="width: 120px;background-color:#23afad">
                                                                        Doc. Number
                                                                    </td> 
                                                                    <td style="width: 100px;background-color:#23afad">
                                                                        Doc. Date
                                                                    </td> 
                                                                    <td style="width: 120px;background-color:#23afad">
                                                                        Req. Number
                                                                    </td> 
                                                                    <td style="width: 60px;background-color:#23afad">
                                                                        Qty
                                                                    </td> 
                                                                    <td style="width: 50px;background-color:#23afad">
                                                                        UoM
                                                                    </td>  
                                                                    <td style="width: 70px;background-color:#23afad">
                                                                        Cost Cntr
                                                                    </td>                                                           
                                                                </tr>
                                                            </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 1030px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 30px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['prod_type']")%>
                                                                    </td>
                                                                    <td style="width: 150px;">
                                                                         <%# DataBinder.Eval(Container, "Value")%>
                                                                    </td>
                                                                    <td style="width: 320px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['part_desc']")%>
                                                                    </td>        
                                                                    <td style="width: 120px;">
                                                                        <%# DataBinder.Eval(Container, "Text")%>
                                                                    </td> 
                                                                    <td style="width: 100px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['doc_date']")%>
                                                                    </td>
                                                                    <td style="width: 120px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['sro_code']")%>
                                                                    </td>
                                                                    <td style="width: 60px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['qtyRema']")%>
                                                                    </td>
                                                                    <td style="width: 50px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['part_unit']")%>
                                                                    </td>     
                                                                    <td style="width: 70px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['dept_code']")%>
                                                                    </td>                                                                                                                           
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                        </telerik:RadComboBox>
                                                    </InsertItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="OH Qty" HeaderStyle-Width="70px" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblSoh" Text='<%# DataBinder.Eval(Container.DataItem, "stock_hand", "{0:#,###,###0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<EditItemTemplate>
                                                        <asp:Label runat="server" ID="lblSoh_edit" Text='<%# DataBinder.Eval(Container.DataItem, "stock_hand", "{0:#,###,###0.00}") %>'></asp:Label>
                                                    </EditItemTemplate>--%>
                                                    <InsertItemTemplate>
                                                        <%--<asp:Label runat="server" ID="lblSoh_insert" ></asp:Label>--%>
                                                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtSoh_insert" Width="70px" 
                                                            EnabledStyle-HorizontalAlign="Right"
                                                            NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" 
                                                            AllowOutOfRangeAutoCorrect="false"
                                                            onkeydown="blurTextBox(this, event)"
                                                            MaxLength="11" Type="Number"
                                                            NumberFormat-DecimalDigits="2" ReadOnly="true">
                                                        </telerik:RadNumericTextBox>
                                                    </InsertItemTemplate>                                        
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Order Qty" HeaderStyle-Width="100px" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center"
                                                    DefaultInsertValue="0">
                                                    <ItemTemplate>
                                                        <%--<asp:Label runat="server" ID="lblPartQty" Text='<%# DataBinder.Eval(Container.DataItem, "qty", "{0:#,###,###0.00}") %>'></asp:Label>--%>
                                                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="80px" 
                                                            EnabledStyle-HorizontalAlign="Right"
                                                            NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "qty") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                                            NumberFormat-DecimalDigits="2">
                                                        </telerik:RadNumericTextBox>
                                                    </ItemTemplate>
                                                    <%--<EditItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty_edit" Width="80px" 
                                                            EnabledStyle-HorizontalAlign="Right"
                                                            NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                            Text='<%# DataBinder.Eval(Container.DataItem, "qty", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                                            NumberFormat-DecimalDigits="2">
                                                        </telerik:RadTextBox>
                                                    </EditItemTemplate>--%>
                                                    <InsertItemTemplate>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txtPartQty_insert" Width="70px" NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                        onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>
                                                    </InsertItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="PO Qty" HeaderStyle-Width="70px" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblQtyPo" Text='<%# DataBinder.Eval(Container.DataItem, "qtypo", "{0:#,###,###0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<EditItemTemplate>
                                                        <asp:Label runat="server" ID="lblQtyPo_edit" Text='<%# DataBinder.Eval(Container.DataItem, "qtypo", "{0:#,###,###0.00}") %>'></asp:Label>
                                                    </EditItemTemplate>--%>
                                                    <InsertItemTemplate>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txtQtyPo_insert" Width="70px" 
                                                            NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" 
                                                            AllowOutOfRangeAutoCorrect="false" 
                                                            EnabledStyle-HorizontalAlign="Right"
                                                            onkeydown="blurTextBox(this, event)" 
                                                            ReadOnly="true"
                                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                                            NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>
                                                    </InsertItemTemplate>                                        
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" >
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>'></asp:Label>
                                                    </ItemTemplate>  
                                                    <EditItemTemplate>
                                                        <asp:Label runat="server" ID="lblUom_edit" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>'></asp:Label>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <asp:Label runat="server" ID="lblUom_insert" ></asp:Label>
                                                    </InsertItemTemplate>                                       
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Cost Center" HeaderStyle-Width="100px" ItemStyle-Width="100px" >
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblCostCtr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                                    </ItemTemplate>  
                                                    <EditItemTemplate>
                                                        <asp:Label runat="server" ID="lblCostCtr_edit" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <asp:Label runat="server" ID="lblCostCtr_insert" ></asp:Label>
                                                    </InsertItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Delivery Date" HeaderStyle-Width="110px"  ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>  
                                                        <telerik:RadDatePicker runat="server" ID="dtpDelivDate" Width="110px"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.DeliDate") %>' 
                                                            onkeydown="blurTextBox(this, event)" Type="Date">
                                                            <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                                        </telerik:RadDatePicker>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadDatePicker runat="server" ID="dtpDelivDate_edit" Width="110px"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.DeliDate") %>' 
                                                            onkeydown="blurTextBox(this, event)" Type="Date">
                                                            <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                                        </telerik:RadDatePicker>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <telerik:RadDatePicker runat="server" ID="dtpDelivDate_insert" Width="110px"
                                                            onkeydown="blurTextBox(this, event)" Type="Date">
                                                            <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                                        </telerik:RadDatePicker>
                                                    </InsertItemTemplate>
                                                </telerik:GridTemplateColumn> 
                            
                                                <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="200px" ItemStyle-Width="200px">
                                                    <ItemTemplate>
                                                        <%--<asp:Label runat="server" ID="lblRemark_d" Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>'></asp:Label>--%>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="200px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>'></telerik:RadTextBox>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d_edit" Width="200px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>'>
                                                        </telerik:RadTextBox>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d_insert" Width="200px">
                                                        </telerik:RadTextBox>
                                                    </InsertItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" 
                                                    ConfirmDialogType="Classic" ButtonType="FontIconButton" ItemStyle-Width="30px" HeaderStyle-Width="30px">
                                                </telerik:GridButtonColumn>

                                            </Columns>
                                            <%--<CommandItemTemplate>
                                                <a href="#" onclick="return openRadWindow();">Add New Record</a>
                                            </CommandItemTemplate>--%>
                                        </MasterTableView>
                                        <ClientSettings >
                                            <%-- <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="185px" />  --%>
                                            <Selecting AllowRowSelect="true"></Selecting>                          
                                        </ClientSettings>
                                    </telerik:RadGrid>               
                                </div>
                            </div>
                        </FormTemplate>
                    </EditFormSettings>
                </MasterTableView>
                <ClientSettings>
                    <Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="253px" />
                    <Selecting AllowRowSelect="true"></Selecting>
                    
                </ClientSettings>
            </telerik:RadGrid>

        </div>       

    <div runat="server" style="width: 100%; border-top-width: 1px; border-top-style: inset; padding-top: 5px;">   
        <table>                    
            <tr>
                <td>
                    <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                            
                        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data tersimpan" Position="BottomRight"
                            AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
                        </telerik:RadNotification>
                    </ContentTemplate>
                </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>

    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                Width="1150px" Height="670px" Modal="true" AutoSize="True">
            </telerik:RadWindow>
            <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                Width="675px" Height="720px" Modal="true" AutoSize="False">
            </telerik:RadWindow>
                
        </Windows>
    </telerik:RadWindowManager>
        
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
    </telerik:RadWindowManager>
        

</div>
</asp:Content>

