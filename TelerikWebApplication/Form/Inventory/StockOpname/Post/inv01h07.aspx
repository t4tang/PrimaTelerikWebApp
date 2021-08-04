<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h07.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.StockOpname.Post.inv01h07" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
    
    <script type="text/javascript" src="../../../../Script/Script.js"></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("inv01h04ReportViewer.aspx?lbm_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("inv01h04EditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("inv01h04EditForm.aspx?lbm_code=" + id, "EditDialogWindows");
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
    <asp:UpdatePanel ID="UpdatePanel22" runat="server">
        <ContentTemplate>
            <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
            <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
        </ContentTemplate>        
    </asp:UpdatePanel> 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
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
            <%--<telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2" ></telerik:AjaxUpdatedControl>  
                </UpdatedControls>        
            </telerik:AjaxSetting> --%>
            
        </AjaxSettings>
    </telerik:RadAjaxManager>
        
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="700" BackgroundPosition="None" BackColor="Transparent" >
        <img alt="Loading..." src="../../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 115px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="700" BackgroundPosition="None" >
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="2000"></telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone" Skin="Vista"
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
                            <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight"
                               EnableLoadOnDemand="True"  Skin="Telerik" 
                                OnItemsRequested="cb_project_prm_ItemsRequested"
                                OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="95%" Height="25px"
                             Skin="Material"></telerik:RadButton>
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
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" ToolTip="Add New"
                       OnClick="btnNew_Click"  Height="26px" Width="27px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
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
        <div style="width:100%; overflow-y:hidden; min-height:280px; scrollbar-highlight-color:#b6ff00;border-bottom-style:none; border-bottom-color:gainsboro; border-bottom-width:thin;"> 
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Silk" CssClass="RadGrid_ModernBrowsers" 
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="14"
                OnNeedDataSource="RadGrid1_NeedDataSource" 
                OnDeleteCommand="RadGrid1_DeleteCommand" 
                OnItemCreated="RadGrid1_ItemCreated"
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged"
                OnPreRender="RadGrid1_PreRender" 
                OnItemCommand="RadGrid1_ItemCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle>               
                <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px"/>
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
                <MasterTableView Width="100%" CommandItemDisplay="None" DataKeyNames="rv_code" Font-Size="11px" Font-Names="Century Gothic" 
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false" >
                <Columns>
                    <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  
                            HeaderStyle-Width="30px" ItemStyle-Width="30px" UpdateText="Update" >
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn UniqueName="rv_code" HeaderText="Revision Number" DataField="rv_code" ItemStyle-Width="100px" FilterControlWidth="100px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn UniqueName="rv_date" HeaderText="Date" DataField="rv_date" ItemStyle-Width="80px"
                        EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker"
                        DataFormatString="{0:d}">
                        <HeaderStyle Width="120px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="region_code" HeaderText="region_code" DataField="region_code" ItemStyle-Width="60px" FilterControlWidth="60px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="80px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="ref_code" HeaderText="Reff. Number" DataField="ref_code" ItemStyle-Width="100px" FilterControlWidth="100px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="wh_code" HeaderText="WH Code" DataField="wh_code" ItemStyle-Width="60px" FilterControlWidth="60px" 
                        ItemStyle-HorizontalAlign="Left" Visible="true" >
                        <HeaderStyle Width="80px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="dept_code" HeaderText="Cost Center" DataField="dept_code" ItemStyle-Width="60px" FilterControlWidth="60px" 
                        ItemStyle-HorizontalAlign="Left">
                        <HeaderStyle Width="80px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true" ItemStyle-Width="200px" AllowFiltering="false">
                        <HeaderStyle Width="200px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center"
                            AllowFiltering="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" 
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="20px" HeaderStyle-Width="20px"
                        ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="Classic" ButtonType="FontIconButton">                                
                        <ItemStyle ForeColor="Red" />
                    </telerik:GridButtonColumn>  
                                              
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <div style="padding: 15px 0px 0px 25px;">
                             <table id="Table2" width="Auto" border="0" class="module">
                                <tr>
                                    <td style="vertical-align:top; width:auto">
                                        <table>
                                            
                                            <tr>
                                                <td colspan="2" style="padding: 0px 0px 10px 0px; text-align:left">
                                                    <asp:Button ID="btnSave" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px"  Height="25px" 
                                                        Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" 
                                                        OnClick="btnSave_Click"  CssClass="btn-entryFrm" >
                                                    </asp:Button>&nbsp;
                            
                                                    <asp:Button ID="btnCancel" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" 
                                                        Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                                        runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                                                </td>
                                            </tr>
                                            <tr style="vertical-align: top; width:auto">                               
                                                <td  style="vertical-align: top">
                                                    <telerik:RadLabel runat="server" Text="Revision Number:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>                                  
                                                    <telerik:RadTextBox ID="txt_so_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                       Skin="Telerik"  EmptyMessage="Let it blank"
                                                       Text='<%# DataBinder.Eval(Container, "DataItem.rv_code") %>' >
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                               <td >
                                                  <telerik:RadLabel runat="server" Text="Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                               </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtp_so" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                        TabIndex="4" Skin="Telerik"
                                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.rv_date") %>'> 
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="MetroTouch" 
                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                        </DateInput>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                                    </telerik:RadDatePicker>
                                                </td>
                                           </tr>
                                            <tr>
                                                <td>                            
                                                    <telerik:RadLabel runat="server" Text="Project Area:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td >
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="250px" DropDownWidth="250px"
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' Height="300px"
                                                        OnItemsRequested="cb_project_ItemsRequested"
                                                        OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                                        OnPreRender="cb_project_PreRender" >
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_project" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>                             
                                                        
                                                </td>
                                           </tr>
                                        </table>
                                    </td>
                                    <td style="vertical-align:top; width:auto">
                                        <table>     
                                           <tr>
                                                <td>                            
                                                    <telerik:RadLabel runat="server" Text="Reff. No" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td >
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_reff" runat="server" Width="150px" DropDownWidth="250px"
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ref_code") %>'
                                                        OnItemsRequested="cb_reff_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_reff_SelectedIndexChanged"
                                                        >
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_reff" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>                             
                                                        
                                                </td>
                                           </tr>                            
                                           <tr>
                                                <td >
                                                    <telerik:RadLabel runat="server" Text="Reff. Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtp_reff_date" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                        TabIndex="4" Skin="Telerik"
                                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.ref_date") %>'> 
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="MetroTouch" 
                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                        </DateInput>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                                    </telerik:RadDatePicker>    
                                                </td>
                                            </tr>                                                                     
                                           <tr>
                                                <td >
                                                    <telerik:RadLabel runat="server" Text="Storage:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="250px" DropDownWidth="300px" CausesValidation="false"
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" Font-Size="Small"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.wh_name") %>' Height="300px"
                                                        OnItemsRequested="cb_warehouse_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged"
                                                        OnPreRender="cb_warehouse_PreRender" >
                                                    </telerik:RadComboBox>                                             
                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_warehouse" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>
                                                        
                                                </td>
                                            </tr> 
                                            <tr>
                                                <td>
                                                   <telerik:RadLabel runat="server" Text="Cost Center:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="cb_costcenter" runat="server" Width="250px"
                                                        DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.CostCenterName") %>'  Height="300px"
                                                        OnItemsRequested="cb_cost_center_ItemsRequested"
                                                        OnSelectedIndexChanged="cb_cost_center_SelectedIndexChanged"
                                                        OnPreRender="cb_cost_center_PreRender">
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
                                                    <asp:RequiredFieldValidator runat="server" ID="cost_ctr_Validator" ControlToValidate="cb_costcenter" ForeColor="Red" 
                                                    Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>
                                                    
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="vertical-align:top; width:auto">
                                        <table>                                                                        
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Remark:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td style="width:350px">
                                                    <telerik:RadTextBox ID="txt_remark"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'
                                                        runat="server" TextMode="MultiLine" Skin="Telerik" 
                                                        Width="300px" Rows="0" TabIndex="5" Resize="Both">
                                                    </telerik:RadTextBox>
                                                        
                                                </td>
                                            </tr>    
                                            <tr>
                                                <td colspan="2" style="vertical-align:central; padding-top:20px">
                                                    <asp:CheckBox ID="CheckBox1" runat="server" Skin="Telerik" Checked="false" Text="Posting" Enabled="false" />
                                                </td>
                                            </tr>                        
                                        </table>
                                    </td>                                    
                                </tr>
                                <tr>
                                    <td colspan="6" style="padding:18px 0px 3px 0px">
                                        <table>
                                            <tr>
                                                <td colspan="2" style="padding-top:15px"> 
                                                    <telerik:RadLabel runat="server" ID="RadLabel1" Text="User : " Skin="Telerik" CssClass="lblEditInfo" />
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_uid" runat="server" Skin="Telerik" BorderStyle="None" >
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <telerik:RadLabel runat="server" ID="RadLabel2" Text="Last Update : " Skin="Telerik" CssClass="lblEditInfo"/>
                                                </td>                                                
                                                <td>
                                                    <telerik:RadTextBox ID="txt_last_update" runat="server" Skin="Telerik" BorderStyle="None" >
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td colspan="2"> 
                                                    <telerik:RadLabel runat="server" ID="RadLabel3" Text="Owner : " Skin="Telerik"  CssClass="lblEditInfo"/>
                                                </td>                                                
                                                <td>
                                                    <telerik:RadTextBox ID="txt_owner" runat="server" Skin="Telerik" BorderStyle="None" >
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td colspan="2">
                                                    <telerik:RadLabel runat="server" ID="RadLabel4" Text="Edited : " Skin="Telerik" CssClass="lblEditInfo"/>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_edited" runat="server" Skin="Telerik" BorderStyle="None" >
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>   
                                </tr>                  
                               </table>
                                <div style="padding: 7px 0px 12px 0px; min-height:275px">
                                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" runat="server" AllowPaging="True" ShowFooter="false" PageSize="5" Skin="Silk"
                                    AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers"
                                    OnNeedDataSource="RadGrid2_NeedDataSource"
                                    OnPreRender="RadGrid2_PreRender"
                                        OnInsertCommand="RadGrid2_InsertCommand" 
                                        OnUpdateCommand="RadGrid2_UpdateCommand"
                                        OnItemCommand="RadGrid2_ItemCommand"                                                 
                                    ClientSettings-Selecting-AllowRowSelect="true"> 
                                    <HeaderStyle Font-Size="12px" />
                                    <PagerStyle Mode="NumericPages" />  
                                    <MasterTableView CommandItemDisplay="None" DataKeyNames="Prod_code" Font-Size="11px" EditMode="InPlace"
                                        ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" InsertItemDisplay="Bottom" >                                             
                                        <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                                        
                                        <Columns>   
                                            <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                                HeaderText="Edit" HeaderStyle-Width="60px" ItemStyle-Width="60px" UpdateText="Update">
                                            </telerik:GridEditCommandColumn>    

                                            <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="125px" ItemStyle-Width="125px"
                                                HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblProdCode" Width="125px" Text='<%# DataBinder.Eval(Container.DataItem, "Prod_code") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cbProdCodeEdit" EnableLoadOnDemand="True" DataTextField="spec"
                                                        DataValueField="prod_code" AutoPostBack="true"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "prod_code") %>'
                                                        HighlightTemplatedItems="true" Height="140px" Width="125px" DropDownWidth="430px"
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
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cbProdCodeInsert" EnableLoadOnDemand="True" DataTextField="spec"
                                                        OnItemsRequested="cb_prod_code_ItemsRequested" DataValueField="prod_code" AutoPostBack="true"
                                                        HighlightTemplatedItems="true" Height="190px" Width="125px" DropDownWidth="430px"
                                                        OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" OnPreRender="cb_prod_code_PreRender">                                                   
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
                                            
                                            <telerik:GridTemplateColumn HeaderText="Specification" HeaderStyle-Width="155px" ItemStyle-Width="155px" ItemStyle-HorizontalAlign="Left"
                                                HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblSpec" Text='<%# DataBinder.Eval(Container.DataItem, "Spec") %>' Width="155px"></asp:Label>
                                                </ItemTemplate>     
                                                <EditItemTemplate>
                                                    <asp:Label runat="server" ID="lblSpecEdit" Text='<%# DataBinder.Eval(Container.DataItem, "Spec") %>' Width="155px"></asp:Label>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:Label runat="server" ID="lblSpecInsert" Width="155px"></asp:Label>
                                                </InsertItemTemplate>                                         
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Qty Act." HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right" 
                                                DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label RenderMode="Lightweight" runat="server" ID="lblPartQtyAct" Width="70px"  ReadOnly="true" 
                                                        EnabledStyle-HorizontalAlign="Right"
                                                        NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "qty_receive", "{0:#,###,###0.00}") %>'
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2">
                                                    </asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQtyActEdit" Width="70px"  ReadOnly="true" 
                                                        EnabledStyle-HorizontalAlign="Right"
                                                        NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "qty_receive", "{0:#,###,###0.00}") %>'
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2">
                                                    </telerik:RadNumericTextBox>
                                                </EditItemTemplate>                                            
                                                <InsertItemTemplate>
                                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQtyActInsert" Width="70px"  ReadOnly="true" 
                                                        EnabledStyle-HorizontalAlign="Right"
                                                        NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2">
                                                    </telerik:RadNumericTextBox>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Qty Sys." HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right" 
                                                DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label RenderMode="Lightweight" runat="server" ID="lblPartQtySys" Width="70px"  ReadOnly="true" 
                                                        EnabledStyle-HorizontalAlign="Right"
                                                        NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "qty_sis", "{0:#,###,###0.00}") %>'
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2">
                                                    </asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQtySysEdit" Width="70px"  ReadOnly="true" 
                                                        EnabledStyle-HorizontalAlign="Right"
                                                        NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "qty_sis", "{0:#,###,###0.00}") %>'
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2">
                                                    </telerik:RadNumericTextBox>
                                                </EditItemTemplate>                                            
                                                <InsertItemTemplate>
                                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQtySysInsert" Width="70px"  ReadOnly="true" 
                                                        EnabledStyle-HorizontalAlign="Right"
                                                        NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2">
                                                    </telerik:RadNumericTextBox>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Qty Dev." HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right" 
                                                DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label RenderMode="Lightweight" runat="server" ID="lblPartQtyDev" Width="70px"  ReadOnly="true" 
                                                        EnabledStyle-HorizontalAlign="Right"
                                                        NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "qty_deviasi", "{0:#,###,###0.00}") %>'
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2">
                                                    </asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQtyDevEdit" Width="70px"  ReadOnly="true" 
                                                        EnabledStyle-HorizontalAlign="Right"
                                                        NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "qty_deviasi", "{0:#,###,###0.00}") %>'
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2">
                                                    </telerik:RadNumericTextBox>
                                                </EditItemTemplate>                                            
                                                <InsertItemTemplate>
                                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQtyDevInsert" Width="70px"  ReadOnly="true" 
                                                        EnabledStyle-HorizontalAlign="Right"
                                                        NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2">
                                                    </telerik:RadNumericTextBox>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="75px" ItemStyle-Width="75px" 
                                                ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" >
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblUom" Width="75px" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>' ></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="75px" runat="server" ID="cb_uom_d"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.SatQty") %>' Width="75px"
                                                        EnableLoadOnDemand="True" Skin="Silk"  DataTextField="part_unit" DataValueField="part_unit" >
                                                    </telerik:RadComboBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="75px" Width="75px" runat="server" ID="cb_uom_d_insert"
                                                        EnableLoadOnDemand="True" Skin="Silk"  DataTextField="part_unit" DataValueField="part_unit" >
                                                    </telerik:RadComboBox>
                                                </InsertItemTemplate>                                        
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="MAP" HeaderStyle-Width="100px" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-HorizontalAlign="Center" Visible="true">
                                                <ItemTemplate>
                                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtHpokok" Width="70px"  ReadOnly="true" 
                                                        EnabledStyle-HorizontalAlign="Right" BorderStyle="None"
                                                        NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "hpokok", "{0:#,###,###0.00}") %>'
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2">
                                                    </telerik:RadNumericTextBox>
                                                </ItemTemplate>  
                                                <EditItemTemplate>
                                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtHpokokEdit" Width="70px"  ReadOnly="true" 
                                                        EnabledStyle-HorizontalAlign="Right"  BorderStyle="None"
                                                        NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "hpokok", "{0:#,###,###0.00}") %>'
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2">
                                                    </telerik:RadNumericTextBox>
                                                </EditItemTemplate>                                            
                                                <InsertItemTemplate>
                                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtHpokokInsert" Width="70px"  ReadOnly="true" 
                                                        EnabledStyle-HorizontalAlign="Right"  BorderStyle="None"
                                                        NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2">
                                                    </telerik:RadNumericTextBox>
                                                </InsertItemTemplate>                                   
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Cost Ctr." HeaderStyle-Width="75px" ItemStyle-Width="75px" 
                                                HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblCostCtr" Width="75px" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="150px" runat="server" ID="cb_dept_d"
                                                        EnableLoadOnDemand="True" Skin="Silk"  DataTextField="name" DataValueField="CostCenter" Width="75px" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>'
                                                        OnItemsRequested="cb_dept_d_ItemsRequested"
                                                        OnPreRender="cb_dept_d_PreRender"
                                                            OnSelectedIndexChanged="cb_dept_d_SelectedIndexChanged" >
                                                    </telerik:RadComboBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="150px" runat="server" ID="cb_dept_d_insert"
                                                        EnableLoadOnDemand="True" Skin="Silk"  DataTextField="name" DataValueField="CostCenter" Width="75px" 
                                                        OnItemsRequested="cb_dept_d_ItemsRequested"
                                                        OnPreRender="cb_dept_d_PreRender"
                                                        OnSelectedIndexChanged="cb_dept_d_SelectedIndexChanged"  >
                                                    </telerik:RadComboBox>
                                                </InsertItemTemplate>      
                                            </telerik:GridTemplateColumn>
                                            
                                            <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="200px" HeaderStyle-Width="200px" 
                                                HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label RenderMode="Lightweight" runat="server" ID="lblRemark" Width="200px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>' ReadOnly="true">
                                                    </asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemarkEdit" Width="200px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>' ReadOnly="false">
                                                    </telerik:RadTextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemarkInsert" Width="200px" ReadOnly="false">
                                                    </telerik:RadTextBox>
                                                </InsertItemTemplate>      
                                            </telerik:GridTemplateColumn>
                                        
                                            
                                            <telerik:GridTemplateColumn HeaderText="nomor" HeaderStyle-Width="15px" ItemStyle-Width="15px" ItemStyle-HorizontalAlign="Center"
                                                HeaderStyle-HorizontalAlign="Center" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblNomor" Text='<%# DataBinder.Eval(Container.DataItem, "nomor") %>' Width="175px"></asp:Label>
                                                </ItemTemplate>     
                                                <EditItemTemplate>
                                                    <asp:Label runat="server" ID="lblNomorEdit" Text='<%# DataBinder.Eval(Container.DataItem, "nomor") %>' Width="175px"></asp:Label>
                                                </EditItemTemplate>     
                                                <InsertItemTemplate>
                                                    <asp:Label runat="server" ID="lblNomorInsert" Width="175px"></asp:Label>
                                                </InsertItemTemplate>                                      
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                                                ConfirmTitle="Delete" ConfirmDialogType="Classic"
                                                ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                            </telerik:GridButtonColumn>
                             
                                        </Columns>
                                    </MasterTableView>
                                    <ClientSettings>
                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="199" />
                                        <ClientEvents OnRowDblClick="rowDblClick"/>
                                    </ClientSettings>
                                    </telerik:RadGrid>
                                </div>
                        </div>
                    </FormTemplate>
                </EditFormSettings>
                </MasterTableView>
                <ClientSettings>
                    <%--<Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="253px" />--%>
                    <Selecting AllowRowSelect="true"></Selecting>                    
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
                    Width="1500px" Height="720px" Modal="true" AutoSize="False">
                </telerik:RadWindow>
                
            </Windows>
        </telerik:RadWindowManager>
        
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
        
    </div>
</asp:Content>
