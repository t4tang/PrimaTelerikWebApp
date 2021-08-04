<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc00h22tr.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.AssetTransfer.acc00h22tr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <script src="../../../Script/Script.js"></script>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
       
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("pur01h01aReportViewer.aspx?doc_code=" + id, "PreviewDialog");
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

            <%--function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("pur01h01aEditForm.aspx?pr_code=" + id, "EditDialogWindows");
                return false;
            }--%>

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
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
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
                               EnableLoadOnDemand="True"  Skin="Silk" OnItemsRequested="cb_proj_prm_ItemsRequested"
                                OnSelectedIndexChanged="cb_proj_prm_SelectedIndexChanged"
                                EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px">

                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td>
                            <asp:Button ID="btnSearch" runat="server" Text="Filter" Width="120px" Height="25px" 
                                BackColor="#FF6600" ForeColor="White" BorderStyle="None" OnClick="btnSearch_Click"  />
                        </td>

                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:thin">
        <table id="tbl_control">
            <tr>                  
                <td style="vertical-align: bottom; margin-left: 10px; padding-left: 8px">
                <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" ToolTip="Add New" Visible="true"
                    Height="26px" Width="27px" ImageUrl="~/Images/tambah.png" ImageAlign="Bottom" OnClick="btnNew_Click" ></asp:ImageButton>
            </td>                
            <td style="vertical-align: bottom; margin-left: 10px; padding: 0px 0px 0px 10px;">
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
                OnDeleteCommand="RadGrid1_DeleteCommand" >
                <PagerStyle ForeColor="#0099CC" VerticalAlign="Middle" Mode="NextPrevAndNumeric"></PagerStyle>               
                <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px"/>
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
                <SortingSettings EnableSkinSortStyles="false" />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="tr_code" Font-Size="11px"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowRefreshButton="False" CommandItemSettings-ShowAddNewRecordButton="False">
                    
                    <Columns>
                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  
                            HeaderStyle-Width="30px" ItemStyle-Width="30px" UpdateText="Update" >
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="tr_code" HeaderText="Transfer Code" DataField="tr_code" ItemStyle-Width="108px" >
                            <HeaderStyle Width="118px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="asset_id" HeaderText="Asset Code" DataField="asset_id" ItemStyle-Width="108px" >
                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="tr_date" HeaderText="Date" DataField="tr_date" ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Left"
                            EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker"
                            DataFormatString="{0:d}">
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridDateTimeColumn UniqueName="start_date" HeaderText="Start Date" DataField="start_date" ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Left"
                            EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker"
                            DataFormatString="{0:d}">
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="prev_location" HeaderText="Previous" DataField="prev_location" ItemStyle-HorizontalAlign="Left"
                            ItemStyle-Width="80px" FilterControlWidth="60px">
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="dest_location" HeaderText="Destination " DataField="dest_location" ItemStyle-HorizontalAlign="Left"
                            ItemStyle-Width="80px" FilterControlWidth="60px">
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="cost_ctr" HeaderText="Cost Center" DataField="cost_ctr" ItemStyle-HorizontalAlign="Left"
                            ItemStyle-Width="95px" FilterControlWidth="80px">
                            <HeaderStyle Width="95px"></HeaderStyle>
                        </telerik:GridBoundColumn>           
                        <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                            ItemStyle-Width="250px" AllowFiltering="false">
                            <HeaderStyle Width="250px"></HeaderStyle>
                        </telerik:GridBoundColumn>
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
                                                    <td colspan="4" style="padding: 0px 0px 10px 0px; text-align:left">
                                                        <asp:Button ID="btnSave" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px"  Height="25px" 
                                                            Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" 
                                                            OnClick="btnSave_Click"  CssClass="btn-entryFrm" >
                                                        </asp:Button>&nbsp;
                            
                                                        <asp:Button ID="btnCancel" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" 
                                                            Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                                            runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                                                    </td>
                                                </tr>  
                                                <tr>                              
                                                    <td  style="vertical-align: top; width:120px">
                                                        <telerik:RadLabel runat="server" Text="Transfer Code :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    <td/>
                                                    <td>
                                                        <telerik:RadTextBox ID="txt_doc_code" runat="server" Width="300px" ReadOnly="true"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.tr_code") %>' 
                                                            RenderMode="Lightweight" Font-Size="Small">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td >
                                                        <telerik:RadLabel runat="server" Text="Asset Code :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    <td/>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_asset_code" runat="server" Width="300" DropDownWidth="500px"
                                                            AutoPostBack="True" CausesValidation="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.asset_id") %>'  
                                                            OnItemsRequested="cb_asset_code_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_asset_code_SelectedIndexChanged"
                                                            OnPreRender="cb_asset_code_PreRender" >
                                                            <HeaderTemplate>
                                                                    <table style="width: 500px; font-size: smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">Code
                                                                            </td>
                                                                            <td style="width: 400px;">Name
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 500px; font-size: smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.code")%>
                                                                            </td>
                                                                            <td style="width: 500px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.spec")%>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                        </telerik:RadComboBox>  
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td >
                                                        <telerik:RadLabel runat="server" Text="Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    <td/>
                                                    <td>                          
                                                        <telerik:RadDatePicker ID="dtp_tr" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                            Skin="Telerik" 
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.tr_date") %>'>
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" >
                                                            </Calendar>
                                                            <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" >
                                                            </DateInput>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                                        </telerik:RadDatePicker>                       
                                                    </td>
                                                </tr> 
                                            </table>
                                        </td>
                                        <td>
                                            <table style="padding:35px 10px 10px 45px">
                                                <tr>
                                                    <td>

                                                    </td>
                                                </tr>
                                                <tr>                                                        
                                                    <td style="vertical-align:top">
                                                        <telerik:RadLabel runat="server" Text="Remark :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadTextBox ID="txt_remark" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'  
                                                            runat="server" TextMode="MultiLine" Skin="Telerik"
                                                            Width="400px" Rows="0" Resize="None">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>                                                
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Asset Status :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>

                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_asset_status" runat="server" Width="300px" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.Status_name") %>'  
                                                            DropDownWidth="250px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                            OnItemsRequested="cb_asset_status_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_asset_status_SelectedIndexChanged"
                                                            OnPreRender="cb_asset_status_PreRender">
                                                        </telerik:RadComboBox>
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
                                            <telerik:RadTab Text="Transaction Data" Height="15px"> 
                                            </telerik:RadTab>
                                            <telerik:RadTab Text="Accounting Info" Height="15px">
                                            </telerik:RadTab>
                                            <telerik:RadTab Text="Additional Detail" Height="15px">
                                            </telerik:RadTab>
                                            <telerik:RadTab Text="Approval" Height="15px">
                                            </telerik:RadTab>
                                        </Tabs>
                                    </telerik:RadTabStrip>
                                    <telerik:RadMultiPage runat="server" ID="RadMultiPage1"  SelectedIndex="0" Width="97%" >
                                        <telerik:RadPageView runat="server" ID="RadPageView1" Height="300px">
                                            <div runat="server" style="padding:15px 15px 15px 15px">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" Text="Post Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        <td/>
                                                        <td  colspan="5" >                          
                                                            <telerik:RadDatePicker ID="dtp_post_date" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                                Skin="Telerik" 
                                                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.start_date") %>'>
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
                                                            <telerik:RadLabel runat="server" Text="Original Location :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel> 
                                                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_prev_loc" ForeColor="Red" 
                                                                Font-Size="X-Small"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                                                        <td/>
                                                        <td>                          
                                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_prev_loc" runat="server" Width="300"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.prev_loc_name") %>'  
                                                                EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Telerik" EnableVirtualScrolling="true"
                                                                OnItemsRequested="cb_project_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_project_SelectedIndexChanged" 
                                                                OnPreRender="cb_project_PreRender">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>                                                
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" Text="Destination Location :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                            <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_dest_loc" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="*"></asp:RequiredFieldValidator>
                                                        <td/>
                                                        <td>   
                                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_dest_loc" runat="server" Width="300" DropDownWidth="300px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.dest_loc_name") %>'  
                                                                AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                                OnItemsRequested="cb_project_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_project_SelectedIndexChanged" 
                                                                OnPreRender="cb_project_PreRender">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>                                                               
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" Text="Cost Center :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_cost_ctr" ForeColor="Red" 
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
                                            </div>                
                                        </telerik:RadPageView>
                                        <telerik:RadPageView runat="server" ID="RadPageView2" Height="300px">
                                            <div runat="server" style="padding:15px 15px 15px 15px">
                                                <table>
                                                    <tr >
                                                        <td >
                                                            <telerik:RadLabel runat="server" Text="Useful Life (Year):" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_use_life_year" Width="70px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" ReadOnly="true"
                                                                DbValue='<%# DataBinder.Eval(Container, "DataItem.exp_life_year") %>'
                                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                                NumberFormat-DecimalDigits="2" >
                                                            </telerik:RadNumericTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            <telerik:RadLabel runat="server" Text="Depreciation Method :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                            
                                                        </td>
                                                        <td>
                                                            <telerik:RadTextBox ReadOnly="true" ID="txt_dep_method" Width="150px" runat="server" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.Method") %>' >
                                                                </telerik:RadTextBox> 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" Text="Acquisition Value :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_acquisition_value" Width="150px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                                                DbValue='<%# DataBinder.Eval(Container, "DataItem.acq_value") %>'
                                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                                NumberFormat-DecimalDigits="2" >
                                                            </telerik:RadNumericTextBox>
                                                        </td>
                                                    </tr>
                                                </table>   
                                            </div>                 
                                        </telerik:RadPageView>
                                        <telerik:RadPageView runat="server" ID="RadPageView3" Height="300px">
                                            <div runat="server" style="padding:15px 15px 15px 15px">

                                                </div>
                                        </telerik:RadPageView>
                                        <telerik:RadPageView runat="server" ID="RadPageView4" Height="300px">
                                            <div runat="server" style="padding:15px 15px 15px 15px">
                                                <table>                                                
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" Text="Prepared By :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_prepare_by" runat="server" Width="300px" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.pre_by_name") %>'  
                                                                DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                                OnItemsRequested="cb_approval_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_approval_SelectedIndexChanged"
                                                                OnPreRender="cb_approval_PreRender">
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
                                                            <telerik:RadLabel runat="server" Text="Verified By :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_verified" runat="server" Width="300px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.ver_by_name") %>'  
                                                                DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                                OnItemsRequested="cb_approval_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_approval_SelectedIndexChanged"
                                                                OnPreRender="cb_approval_PreRender">
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
                                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="300px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.app_by_name") %>'  
                                                                DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true"
                                                                OnItemsRequested="cb_approval_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_approval_SelectedIndexChanged"
                                                                OnPreRender="cb_approval_PreRender" >
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
                                            </div>
                                            

                                        </telerik:RadPageView>
                                    </telerik:RadMultiPage>
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
    </telerik:RadWindowManager>

    </div>
</asp:Content>
