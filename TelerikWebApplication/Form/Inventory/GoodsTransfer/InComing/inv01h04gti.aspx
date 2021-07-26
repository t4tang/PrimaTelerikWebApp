<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h04gti.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.GoodsTransfer.InComing.inv01h04gti" %>
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
                window.radopen("inv01h04gtiReportViewer.aspx?lbm_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("inv01h04gtiEditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("inv01h04gtiEditForm.aspx?lbm_code=" + id, "EditDialogWindows");
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
            <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
        </ContentTemplate>        
    </asp:UpdatePanel> 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_ref">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_reff_date" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_project" LoadingPanelID="RadAjaxLoadingPanel1" />
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
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik" DateInput-CausesValidation="false"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                    <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight" AutoPostBack="true"
                                        EnableLoadOnDemand="True"  Skin="Telerik" OnItemsRequested="cb_proj_prm_ItemsRequested"
                                        OnSelectedIndexChanged="cb_proj_prm_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px">
                                    </telerik:RadComboBox>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td colspan="2" style="padding-right:10px">
                            <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="95%" Height="25px" 
                                Skin="Material" ForeColor="DeepSkyBlue"  />
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>                  
                <td style="vertical-align: bottom; margin-left: 0px; padding: 0px 0px 0px 0px;">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter" 
                        Height="29px" Width="30px" ImageUrl="~/Images/search.png">
                    </asp:ImageButton>                        
                </td>
                <td style="vertical-align: bottom; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click" ToolTip="Add New" Visible="true"
                        Height="26px" Width="27px" ImageUrl="~/Images/tambah.png" ImageAlign="Bottom">
                    </asp:ImageButton>
                </td>
                <td style="width: 97%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:yellowgreen; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

        <div  class="scroller" runat="server" style="overflow-y:scroll; height:620px">
            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" PageSize="14" Skin="Silk"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers"
                OnNeedDataSource="RadGrid1_NeedDataSource"
                OnDeleteCommand="RadGrid1_DeleteCommand" 
                OnItemCreated="RadGrid1_ItemCreated" OnItemCommand="RadGrid1_ItemCommand" OnPreRender="RadGrid1_PreRender" 
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" >
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>               
                <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px" />
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <%--<SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />--%>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="lbm_code" Font-Size="11px" Font-Names="Century Gothic"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                    CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" 
                    CommandItemSettings-AddNewRecordText="New" EditFormSettings-EditFormType="Template" InsertItemDisplay="Top">
                    <SortExpressions >
                        <telerik:GridSortExpression FieldName="lbm_code" SortOrder="Ascending" />
                    </SortExpressions>
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                            <HeaderStyle Width="40px"/>
                            <ItemStyle Width="40px" />
                        </telerik:GridEditCommandColumn>  
                        <telerik:GridBoundColumn UniqueName="lbm_code" HeaderText="Reg. No" DataField="lbm_code" ItemStyle-Width="110px" FilterControlWidth="100px" 
                            ItemStyle-HorizontalAlign="Left" >
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="ref_code" HeaderText="Ref. No" DataField="ref_code">
                            <HeaderStyle Width="110px" ></HeaderStyle>
                        </telerik:GridBoundColumn>  
                            <telerik:GridBoundColumn UniqueName="from_region_code" HeaderText="Original" DataField="from_region_code" ItemStyle-Width="80px"
                        FilterControlWidth="80px">
                        <HeaderStyle Width="80px" ></HeaderStyle>
                        </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Destination" DataField="region_code" ItemStyle-Width="80px"
                        FilterControlWidth="80px">
                        <HeaderStyle Width="80px" ></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="lbm_date" HeaderText="Date" DataField="lbm_date" ItemStyle-Width="100px"
                            EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker"
                            DataFormatString="{0:d}">
                            <HeaderStyle Width="100px" ></HeaderStyle>
                        </telerik:GridDateTimeColumn>                        
                        <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                            ItemStyle-Width="300px" AllowFiltering="false">
                            <HeaderStyle Width="300px" ></HeaderStyle>
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
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="Classic" ButtonType="FontIconButton">
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                            <div style="padding: 15px 0px 0px 25px;">
                                <table id="Table1" border="0" style="border-collapse: collapse; padding:15px 0px 5px 0px; font-size:11px;">
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
                                                <tr style="vertical-align: top">                               
                                                    <td  style="vertical-align: top">
                                                        <telerik:RadLabel runat="server" Text="Reg. Number:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />                                   
                                                        <telerik:RadTextBox ID="txt_gr_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                           Skin="Telerik"  EmptyMessage="Let it blank" Text='<%# DataBinder.Eval(Container, "DataItem.lbm_code") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                           
                                                <tr>
                                                   <td >
                                                      <telerik:RadLabel runat="server" Text="Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                                        <telerik:RadDatePicker ID="dtp_gr" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                            TabIndex="4" Skin="Telerik" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.lbm_date") %>'> 
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
                                                        <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_project" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                                        <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>--%>
                                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                                    OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged" Font-Size="Small"
                                                                    OnPreRender="cb_project_PreRender" Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>'>
                                                                </telerik:RadComboBox>                             
                                                            <%--</ContentTemplate>
                                                        </asp:UpdatePanel>--%>
                                                    </td>
                                               </tr>                            
                                                <tr>
                                                    <td >
                                                        <telerik:RadLabel runat="server" Text="Storage Loc.:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                           <asp:RequiredFieldValidator runat="server" ID="warehouseValidator" ControlToValidate="cb_warehouse" ForeColor="Red" 
                                                               Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                                            <%--<asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                                                <ContentTemplate>--%>
                                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="300" DropDownWidth="300px"
                                                                        AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"
                                                                        OnItemsRequested="cb_warehouse_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged" Font-Size="Small"
                                                                        OnPreRender="cb_warehouse_PreRender" Text='<%# DataBinder.Eval(Container, "DataItem.wh_name") %>'>
                                                                    </telerik:RadComboBox>                                    
                                                                <%--</ContentTemplate>
                                                                <Triggers>
                                                                    <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                                                </Triggers>
                                                            </asp:UpdatePanel>--%>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                   <td>
                                                       <telerik:RadLabel runat="server" Text="No. Ref:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                       <asp:RequiredFieldValidator runat="server" ID="reffCodeValidator" ControlToValidate="cb_ref" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                                       <%--<asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                            <ContentTemplate>--%>
                                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ref" runat="server" Width="200px" AutoPostBack="true" CausesValidation="false"
                                                                    DropDownWidth="1100px" EnableLoadOnDemand="true" ShowMoreResultsBox="true" 
                                                                    MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="ref_code" DataValueField="ref_code"
                                                                    OnItemsRequested="cb_ref_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_ref_SelectedIndexChanged" 
                                                                    OnPreRender="cb_ref_PreRender" Text='<%# DataBinder.Eval(Container, "DataItem.ref_code") %>'>
                                                                    <HeaderTemplate>
                                                                        <table style="width: 1000px; font-size: smaller">
                                                                            <tr>
                                                                                <td style="width: 150px; font-variant:small-caps; color: #3399FF;">No. Reg
                                                                                </td>
                                                                                <td style="width: 150px;font-variant:small-caps; color: #3399FF;">Date
                                                                                </td>
                                                                                <td style="width: 150px; font-variant:small-caps; color: #3399FF;">Project Area
                                                                                </td>
                                                                                <td style="width: 200px; font-variant:small-caps; color: #3399FF;">Storage Location
                                                                                </td>
                                                                                <td style="width: 450px;font-variant:small-caps; color: #3399FF;">Remark
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <table style="width: 1000px; font-size: smaller">
                                                                            <tr>
                                                                                <td style="width: 150px;">
                                                                                    <%# DataBinder.Eval(Container, "DataItem.do_code")%>
                                                                                </td>
                                                                                <td style="width: 150px;">
                                                                                    <%# DataBinder.Eval(Container, "DataItem.Tgl")%>
                                                                                </td>
                                                                                <td style="width: 150px;">
                                                                                    <%# DataBinder.Eval(Container, "DataItem.region_name")%>
                                                                                </td>
                                                                                <td style="width: 200px;">
                                                                                    <%# DataBinder.Eval(Container, "DataItem.wh_name")%>
                                                                                </td>
                                                                                <td style="width: 450px;">
                                                                                    <%# DataBinder.Eval(Container, "DataItem.remark")%>
                                                                                </td>
                                                                            </tr>
                                                                        </table>

                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                    </FooterTemplate>
                                                                </telerik:RadComboBox>
                                                            <%--</ContentTemplate>                                  
                                                            <Triggers>
                                                                <asp:AsyncPostBackTrigger ControlID="cb_warehouse" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                                            </Triggers>
                                                        </asp:UpdatePanel>--%>
                                                   </td>
                                                     <td>
                                                         <telerik:RadLabel runat="server" Text="Reff. Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                         <asp:RequiredFieldValidator runat="server" ID="reffDateValidator" ControlToValidate="txt_reff_date" ForeColor="Red" 
                                                             Font-Size="X-Small" Text="Empty not allowed!" ></asp:RequiredFieldValidator><br />
                                                         <telerik:RadTextBox ID="txt_reff_date" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight"
                                                             AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.DateRef") %>'>
                                                         </telerik:RadTextBox>
                                                     </td>
                                               </tr> 
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Project Area Ori:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                                        <%--<asp:UpdatePanel ID="UpdatePanel12" runat="server">
                                                            <ContentTemplate>--%>
                                                                <%--<telerik:RadTextBox ID="txt_project" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight"
                                                                     AutoPostBack="false" Text='<%# DataBinder.Eval(Container, "DataItem.from_region_name") %>'>
                                                                 </telerik:RadTextBox>--%>
                                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project_from" runat="server" Width="150px" DropDownWidth="300px"
                                                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                                    OnItemsRequested="cb_project_from_ItemsRequested" OnSelectedIndexChanged="cb_project_from_SelectedIndexChanged" Font-Size="Small"
                                                                    OnPreRender="cb_project_from_PreRender" Text='<%# DataBinder.Eval(Container, "DataItem.from_region_name") %>'>
                                                                </telerik:RadComboBox> 
                                                            <%--</ContentTemplate>
                                                            <Triggers>
                                                                <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />
                                                            </Triggers>
                                                        </asp:UpdatePanel>--%>
                                                    </td>
                                                </tr>  
                                            </table>
                                        </td>
                                        <td style="vertical-align:top; width:350px">
                                            <table>
                                                <tr>
                                                    <td colspan="2">
                                                       <telerik:RadLabel runat="server" Text="Cost Center:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                       <asp:RequiredFieldValidator runat="server" ID="cost_ctr_Validator" ControlToValidate="cb_costcenter" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                                        <%--<asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                        <ContentTemplate>--%>
                                                            <telerik:RadComboBox ID="cb_costcenter" runat="server" Width="200px" Height="350px" 
                                                                DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" Text='<%# DataBinder.Eval(Container, "DataItem.CostCenterName") %>' 
                                                                OnItemsRequested="cb_costcenter_ItemsRequested" OnSelectedIndexChanged="cb_costcenter_SelectedIndexChanged"
                                                                OnPreRender="cb_costcenter_PreRender">
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
                                                        <%--</ContentTemplate>
                                                            <Triggers>
                                                                <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                                            </Triggers>
                                                        </asp:UpdatePanel>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="vertical-align: top; text-align: left">
                                                        <telerik:RadLabel runat="server" Text="Created By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                                        <%--<asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                                            <ContentTemplate>--%>
                                                                <telerik:RadComboBox ID="cb_createdBy" runat="server" Width="250px"
                                                                     DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" Text='<%# DataBinder.Eval(Container, "DataItem.CreateByName") %>'
                                                                     MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                                     OnItemsRequested="cb_createdBy_ItemsRequested"
                                                                     OnSelectedIndexChanged="cb_createdBy_SelectedIndexChanged"
                                                                     OnPreRender="cb_createdBy_PreRender">
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
                                                            <%--</ContentTemplate>
                                                            <Triggers>
                                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                                            </Triggers>
                                                        </asp:UpdatePanel>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="vertical-align: top; text-align: left">
                                                    <telerik:RadLabel runat="server" Text="Received By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                                    <%--<asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                                    <ContentTemplate>--%>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_received" runat="server" Width="250px"
                                                            DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" Text='<%# DataBinder.Eval(Container, "DataItem.ReceiptByName") %>'
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
                                                    <%--</ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                                    </Triggers>
                                                    </asp:UpdatePanel>--%>
                                                    </td>                                                      
                                                </tr>
                                                <tr>
                                                    <td style="vertical-align: top; text-align: left; ">
                                                    <telerik:RadLabel CssClass="lbObject" runat="server" Text="Approved By:" ForeColor="Black"></telerik:RadLabel><br />
                                                    <%--<asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                    <ContentTemplate>--%>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px"
                                                            DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" Text='<%# DataBinder.Eval(Container, "DataItem.AppByName") %>'
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
                                                    <%--</ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                                    </Triggers>
                                                    </asp:UpdatePanel>--%>
                                                    </td>
                                                </tr>                    
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Remark:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                                        <%--<asp:UpdatePanel ID="UpdatePanel14" runat="server">
                                                            <ContentTemplate>--%>
                                                                <telerik:RadTextBox ID="txt_remark" Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'
                                                                    runat="server" TextMode="MultiLine"
                                                                    Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                                                </telerik:RadTextBox>
                                                            <%--</ContentTemplate>
                                                            <Triggers>
                                                                <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />
                                                            </Triggers>
                                                        </asp:UpdatePanel>--%>
                                                    </td>
                                                </tr>
                                               <tr>
                                                   <td>
                                                       <asp:CheckBox ID="chk_posting" runat="server" Checked="false" Text="Posting" CssClass="lbObject"/>
                                                   </td>
                                               </tr>  
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style ="padding-top:15px; color:cadetblue">
                                            <table>
                                                <tr>   
                                                    <td style ="width: 200px"> 
                                                        User: <telerik:RadLabel runat="server" ID="lbl_userId" CssClass="lbObject" Font-Size="Small"/>
                                                    </td>
                                                    <td style ="width: 200px">
                                                        Last Update: <telerik:RadLabel runat="server" ID="lbl_lastUpdate" CssClass="lbObject" Font-Size="Small"/>
                                                    </td>
                                                    <td style ="width: 200px">
                                                        Owner: <telerik:RadLabel runat="server" ID="lbl_Owner"  CssClass="lbObject" Font-Size="Small"/>
                                                    </td>
                                                    <td style ="width: 200px">
                                                        Edited: <telerik:RadLabel runat="server" ID="lbl_edited"  CssClass="lbObject" Font-Size="Small"/>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="CheckBox1" runat="server" Checked="false" Text="Posting" Enabled="false"/>
                                                    </td>
                                                </tr>               
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <div runat="server" style="width: 100%; border-top-color:yellowgreen; border-top-width: 1px; border-top-style: inset; padding-top: 8px;height:250px; overflow-y:auto; overflow-x:hidden">  
                                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" Skin="Silk" PageSize="5"
                                        AllowPaging="true" AllowSorting="true" runat="server" ShowStatusBar="true"  ClientSettings-Selecting-AllowRowSelect="true"
                                        OnNeedDataSource="RadGrid2_NeedDataSource"
                                        OnUpdateCommand="RadGrid2_UpdateCommand" 
                                        OnInsertCommand="RadGrid2_InsertCommand" 
                                        OnItemCommand="RadGrid2_ItemCommand" 
                                        OnPreRender="RadGrid2_PreRender"
                                        OnDeleteCommand="RadGrid2_DeleteCommand">
                                        <HeaderStyle Font-Size="12px" />
                                        <PagerStyle Mode="NumericPages" ></PagerStyle>
                                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="prod_code" Font-Size="11px" EditMode="InPlace"
                                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" InsertItemDisplay="Bottom" >
                                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                                            <Columns>
                                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                                    HeaderText="Edit" HeaderStyle-Width="30px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px">
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="150px" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center"
                                                     HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblProdCode" Text='<%# DataBinder.Eval(Container.DataItem, "prod_code") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="prod_spec"
                                                            OnItemsRequested="cb_prod_code_ItemsRequested" DataValueField="prod_code" AutoPostBack="true"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>' EmptyMessage="- Search product name here -"
                                                            HighlightTemplatedItems="true" Height="190px" Width="120px" DropDownWidth="800px"
                                                            OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" OnPreRender="cb_prod_code_PreRender">                                                   
                                                            <HeaderTemplate>
                                                            <table style="width: 800px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 180px;">
                                                                       Material Code
                                                                    </td>
                                                                    <td style="width: 250px;">
                                                                        Description
                                                                    </td>     
                                                                    <td style="width: 120px;">
                                                                       Qty
                                                                    </td>
                                                                    <td style="width: 250px;">
                                                                       Storage Location
                                                                    </td>                                                                 
                                                                </tr>
                                                            </table>                                                       
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                            <table style="width: 800px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 180px;">
                                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                                    </td> 
                                                                    <td style="width: 250px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['prod_spec']")%>
                                                                    </td>        
                                                                    <td style="width: 250px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['qty_rem']")%>
                                                                    </td>   
                                                                    <td style="width: 250px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['wh_name']")%>
                                                                    </td>                                                          
                                                                </tr>
                                                            </table>
                                                            </ItemTemplate>
                                                        </telerik:RadComboBox>
                                                    </EditItemTemplate> 
                                                    <InsertItemTemplate>
                                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_Insert" EnableLoadOnDemand="True" DataTextField="spec"
                                                            OnItemsRequested="cb_prod_code_ItemsRequested" DataValueField="prod_code" AutoPostBack="true" 
                                                            EmptyMessage="- Search product name here -" HighlightTemplatedItems="true" Height="190px" Width="120px" DropDownWidth="800px"
                                                            OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" OnPreRender="cb_prod_code_PreRender">                                                   
                                                            <HeaderTemplate>
                                                            <table style="width: 800px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 180px;">
                                                                       Material Code
                                                                    </td>
                                                                    <td style="width: 250px;">
                                                                        Description
                                                                    </td>     
                                                                    <td style="width: 120px;">
                                                                       Qty
                                                                    </td>
                                                                    <td style="width: 250px;">
                                                                       Storage Location
                                                                    </td>                                                                 
                                                                </tr>
                                                            </table>                                                       
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                            <table style="width: 800px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 180px;">
                                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                                    </td> 
                                                                    <td style="width: 250px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['prod_spec']")%>
                                                                    </td>        
                                                                    <td style="width: 250px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['qty_rem']")%>
                                                                    </td>   
                                                                    <td style="width: 250px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['wh_name']")%>
                                                                    </td>                                                          
                                                                </tr>
                                                            </table>
                                                            </ItemTemplate>
                                                        </telerik:RadComboBox>
                                                    </InsertItemTemplate>                                       
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="100px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center"  
                                                     HeaderStyle-ForeColor="#009900" DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center" >
                                                    <ItemTemplate>
                                                        <asp:Label RenderMode="Lightweight" runat="server" ID="lblPartQty" Width="80px"  ReadOnly="false" 
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
                                                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="80px"  ReadOnly="false" 
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
                                                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty_Insert" Width="80px"  ReadOnly="false" 
                                                            EnabledStyle-HorizontalAlign="Right"
                                                            NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                            onkeydown="blurTextBox(this, event)"
                                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                                            NumberFormat-DecimalDigits="2">
                                                        </telerik:RadNumericTextBox>
                                                    </InsertItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center"
                                                     HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>'></asp:Label>
                                                    </ItemTemplate> 
                                                    <EditItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_satQty" Width="70px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.SatQty") %>'>
                                                        </telerik:RadTextBox>
                                                    </EditItemTemplate> 
                                                    <InsertItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_satQty_Insert" Width="70px">
                                                        </telerik:RadTextBox>
                                                    </InsertItemTemplate>                                      
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="From Storage Loc." HeaderStyle-Width="100px" ItemStyle-Width="100px" 
                                                     HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" >
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblFromStorLoc" Text='<%# DataBinder.Eval(Container.DataItem, "from_wh_code") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <%--<telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_from_storage" Width="100px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.wh_name") %>'>
                                                        </telerik:RadTextBox>--%>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_from_storage" runat="server" Width="150px" DropDownWidth="300px" 
                                                            AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                            OnItemsRequested="cb_from_storage_ItemsRequested" OnSelectedIndexChanged="cb_from_storage_SelectedIndexChanged" Font-Size="Small"
                                                            OnPreRender="cb_from_storage_PreRender" Text='<%# DataBinder.Eval(Container, "DataItem.from_wh_code") %>'>
                                                        </telerik:RadComboBox> 
                                                    </EditItemTemplate>  
                                                    <InsertItemTemplate>
                                                        <%--<telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_from_storage_Insert" Width="100px">
                                                        </telerik:RadTextBox>--%>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_from_storage_Insert" runat="server" Width="150px" DropDownWidth="300px" 
                                                            AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                            OnItemsRequested="cb_from_storage_ItemsRequested" OnSelectedIndexChanged="cb_from_storage_SelectedIndexChanged" Font-Size="Small"
                                                            OnPreRender="cb_from_storage_PreRender">
                                                        </telerik:RadComboBox> 
                                                    </InsertItemTemplate>
                                                </telerik:GridTemplateColumn>
                       
                                                <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="250px" ItemStyle-Width="250px"
                                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblremark" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="250px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                                        </telerik:RadTextBox>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d_Insert" Width="250px">
                                                        </telerik:RadTextBox>
                                                    </InsertItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                                                    HeaderStyle-ForeColor="#009900" ConfirmTitle="Delete" ConfirmDialogType="RadWindow"
                                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                                </telerik:GridButtonColumn>
                                            </Columns>
                                        </MasterTableView>
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="180px" />
                                            <ClientEvents OnRowDblClick="rowDblClick"/>  
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </div>
                            </div>
                        </FormTemplate>
                    </EditFormSettings>
                </MasterTableView>
                <ClientSettings>
                    <Selecting AllowRowSelect="true"></Selecting>
                    <Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="255px" />
                    <ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />                    
                </ClientSettings>
            </telerik:RadGrid>
        </div>

        

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

    <telerik:RadNotification RenderMode="Lightweight" ID="notif" Text="Data Telah Disimpan" runat="server" Position="BottomRight" Skin="Silk" AutoCloseDelay="10000" Width="350px" 
        Height="110" Title="Confirmation" EnableRoundedCorners="true">
    </telerik:RadNotification>
        
    
</asp:Content>
