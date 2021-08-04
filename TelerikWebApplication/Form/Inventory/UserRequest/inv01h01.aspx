<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h01.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.UserRequest.inv01h01" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    
    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">

            function ShowPreview(id) {
                window.radopen("reportViewer.aspx?doc_code=" + id, "PreviewDialog");
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
 
                window.radopen("inv01h02EditForm.aspx?doc_code=" + id, "EditDialogWindows");
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
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
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
                        padding-bottom: 0px; font-size: x-large; color:white" BackColor="#33cccc">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

    <div class="scroller" runat="server" style="overflow-y:scroll; height:620px;" > 

        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" PageSize="14" Skin="Silk"
            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers"
            OnNeedDataSource="RadGrid1_NeedDataSource" 
            OnDeleteCommand="RadGrid1_DeleteCommand" 
            OnItemCreated="RadGrid1_ItemCreated"
            OnItemCommand="RadGrid1_ItemCommand"
            OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged"
            OnPreRender="RadGrid1_PreRender">
            <PagerStyle Mode="NumericPages"></PagerStyle>  
            <ClientSettings EnablePostBackOnRowClick="false" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
            <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px"/>
            <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="doc_code" Font-Size="11px" Font-Names="Century Gothic"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" 
                CommandItemSettings-AddNewRecordText="New" EditFormSettings-EditFormType="Template" InsertItemDisplay="Top">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="40px"/>
                        <ItemStyle Width="40px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn UniqueName="doc_code" HeaderText="UR Number" DataField="doc_code">
                        <HeaderStyle Width="120px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn UniqueName="doc_date" HeaderText="Date" DataField="doc_date" ItemStyle-Width="80px" 
                            EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                        DataFormatString="{0:d}" >
                        <HeaderStyle Width="80px"></HeaderStyle>
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" 
                        FilterControlWidth="120px" >
                        <HeaderStyle Width="120px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="wo_desc" HeaderText="Status" DataField="wo_desc" 
                        FilterControlWidth="90px" >
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="doc_remark" HeaderText="Remark" DataField="doc_remark" ItemStyle-Wrap="true"
                            ItemStyle-Width="650px" FilterControlWidth="480px">
                        <HeaderStyle Width="650px"></HeaderStyle>
                    </telerik:GridBoundColumn>
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
                <%--<EditFormSettings EditFormType="WebUserControl" UserControlName="entry.ascx">--%>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <div style="padding: 15px 0px 0px 25px;">
                            <table id="Table1" border="0" style="border-collapse: collapse; padding:15px 0px 5px 0px; font-size:11px;">    
                                <tr style="vertical-align: top;">
                                    <td style="vertical-align: top;">
                                        <table id="Table2" width="Auto" border="0" class="module">
                                            <tr>
                                                <td colspan="2" style="padding: 0px 0px 10px 0px; text-align:left">
                                                    <asp:Button ID="btnSave" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" OnClick="btnSave_Click" Height="25px" 
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
                                                    <telerik:RadLabel runat="server" Text="UR Number" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_ur_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight"
                                                      Text='<%# DataBinder.Eval(Container, "DataItem.doc_code") %>'  AutoPostBack="false">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>             
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>               
                                                    <telerik:RadDatePicker ID="dtp_ur" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" 
                                                        TabIndex="4" Skin="Telerik" AutoPostBack="false"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.doc_date") %>'>
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
                                                    
                                                    <telerik:RadLabel runat="server" Text="Excute Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                <telerik:RadDatePicker ID="dtp_exe" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                     DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.date_exec") %>' TabIndex="4" Skin="Silk" >
                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                                        FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk" ></Calendar>
                                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                    </DateInput>
                                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                                </telerik:RadDatePicker>
                                            </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    
                                                    <telerik:RadLabel runat="server" Text="UR Status:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ur_status" runat="server" Width="150"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.wo_desc") %>' Height="250px"
                                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk"
                                                        OnItemsRequested="cb_ur_status_ItemsRequested" OnPreRender="cb_ur_status_PreRender"
                                                        OnSelectedIndexChanged="cb_ur_status_SelectedIndexChanged"
                                                        EnableVirtualScrolling="true" >
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    
                                                    <telerik:RadLabel runat="server" Text="Priority:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="150"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.prio_desc") %>' 
                                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk"
                                                     OnPreRender="cb_priority_PreRender" OnItemsRequested="cb_priority_ItemsRequested"
                                                        OnSelectedIndexChanged="cb_priority_SelectedIndexChanged"
                                                        EnableVirtualScrolling="true" >
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    
                                                    <telerik:RadLabel runat="server" Text="Tipe:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ur_type" runat="server" Width="150"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.tAsset") %>' 
                                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk" EnableVirtualScrolling="true"
                                                        OnPreRender="cb_ur_type_PreRender" OnItemsRequested="cb_ur_type_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_ur_type_SelectedIndexChanged" >
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="vertical-align: top; padding-left:15px">
                                        <table id="Table3" border="0" class="module">
                                            <tr>
                                                <td class="tdLabel">
                                                    
                                                    <telerik:RadLabel runat="server" Text="Project Area:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td style="vertical-align:top; text-align:left">                      
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>'
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Silk"   
                                                         OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                                         OnPreRender="cb_project_PreRender" >
                                                    </telerik:RadComboBox>          
                                                </td>
                                            </tr>
                                            <tr >
                                                <td class="tdLabel">
                                                    
                                                    <telerik:RadLabel runat="server" Text="Cost Ctr:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td style="vertical-align:top; text-align:left">                                   
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cost_center" runat="server" Width="250px" DropDownWidth="300px"
                                                      Text='<%# DataBinder.Eval(Container, "DataItem.CostCenterName") %>'
                                                        EnableLoadOnDemand="True" Skin="Silk" ShowMoreResultsBox="true"
                                                       OnItemsRequested="cb_cost_center_ItemsRequested" OnSelectedIndexChanged="cb_cost_center_SelectedIndexChanged"
                                                         OnPreRender="cb_cost_center_PreRender" >
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                              <tr>
                                                <td class="tdLabel">
                                                    
                                                    <telerik:RadLabel runat="server" Text="Request By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td style="vertical-align:top; text-align:left">
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_request" runat="server" Width="250px" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.RequestBy") %>'
                                                        DropDownWidth="450px" EmptyMessage="- Select -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                        MarkFirstMatch="true" Skin="Silk"  EnableVirtualScrolling="true" 
                                                            OnItemsRequested="cb_request_ItemsRequested" OnSelectedIndexChanged="cb_request_SelectedIndexChanged"
                                                        OnPreRender="cb_request_PreRender" >
                                                        <HeaderTemplate>
                                                            <table style="width: 450px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 200px;">
                                                                        Name
                                                                    </td>
                                                                    <td style="width: 250px;">
                                                                        Position
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 450px; font-size:smaller">
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
                                                <td class="tdLabel">
                                                    
                                                    <telerik:RadLabel runat="server" Text="Approved By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td style="vertical-align:top; text-align:left">
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.ApproveBy") %>'
                                                        DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                        MarkFirstMatch="true" Skin="Silk"  EnableVirtualScrolling="true" 
                                                        OnItemsRequested="cb_approved_ItemsRequested" OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                        OnPreRender="cb_approved_PreRender" >  
                                                        <HeaderTemplate>
                                                            <table style="width: 450px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 200px;">
                                                                        Name
                                                                    </td>
                                                                    <td style="width: 250px;">
                                                                        Position
                                                                    </td>                                                                
                                                                </tr>
                                                            </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 450px; font-size:smaller">
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
                                                <td class="tdLabel">
                                                    
                                                    <telerik:RadLabel runat="server" Text="Remark:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>                
                                                <td style="vertical-align:top; text-align:left">                               
                                                    <telerik:RadTextBox ID="txt_remark" Text='<%# DataBinder.Eval(Container, "DataItem.doc_remark") %>'
                                                        runat="server" TextMode="MultiLine"
                                                        Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                                    </telerik:RadTextBox>                                  
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

                            <div style=" width:100%; border-top-width:thin; border-top-style: inset; border-top-color:gainsboro; padding:0px 0px 20px 0px;">                                
                                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"
                                    AllowPaging="true" AllowSorting="true" runat="server" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers" Skin="Silk"
                                    OnNeedDataSource="RadGrid2_NeedDataSource"                                                
                                    OnInsertCommand="RadGrid2_InsertCommand"
                                        OnUpdateCommand="RadGrid2_UpdateCommand"
                                    OnDeleteCommand="RadGrid2_DeleteCommand" 
                                    ClientSettings-Selecting-AllowRowSelect="true"> 
                                    <HeaderStyle Font-Size="12px" />  
                                    <MasterTableView CommandItemDisplay="Top" DataKeyNames="part_code" Font-Size="11px" EditMode="InPlace"
                                        ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >                                             
                                        <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                                        
                                        <Columns>   
                                            <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                                HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update">
                                            </telerik:GridEditCommandColumn>                   
                                             
                                            <telerik:GridTemplateColumn UniqueName="prod_code" HeaderText="Item Code" HeaderStyle-Width="120px"
                                                SortExpression="prod_code" ItemStyle-Width="120px">
                                                <FooterTemplate>Template footer</FooterTemplate>
                                                <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <%#DataBinder.Eval(Container.DataItem, "part_code")%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="spec"
                                                        OnItemsRequested="cb_prod_code_ItemsRequested" DataValueField="prod_code" AutoPostBack="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.part_code") %>' EmptyMessage="- Search product name here -"
                                                        HighlightTemplatedItems="true" Height="190px" Width="220px" DropDownWidth="430px"
                                                        OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" OnPreRender="cb_prod_code_PreRender">                                                   
                                                        <HeaderTemplate>
                                                        <table style="width: 430px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 250px;">
                                                                    Description
                                                                </td>     
                                                                <td style="width: 180px;">
                                                                    Item Code
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
                                            </telerik:GridTemplateColumn>
                            
                                            <telerik:GridTemplateColumn HeaderText="Description" ItemStyle-Width="380px">
                                                <ItemTemplate>  
                                                    <%#DataBinder.Eval(Container.DataItem, "spec")%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_prod_name" Width="380px" ReadOnly="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.spec") %>'>
                                                    </telerik:RadTextBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn> 

                                            <telerik:GridTemplateColumn HeaderText="Qty" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                                                <ItemTemplate>  
                                                    <%#DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}")%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty" Width="80px" NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2" >
                                                    </telerik:RadTextBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn> 

                                            <telerik:GridTemplateColumn HeaderText="UoM" ItemStyle-Width="100px">
                                                <ItemTemplate>  
                                                    <%#DataBinder.Eval(Container.DataItem, "part_unit")%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="100px" runat="server" ID="cb_uom_d"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.part_unit") %>'
                                                        EnableLoadOnDemand="True" Skin="Silk"  DataTextField="part_unit" DataValueField="part_unit" >
                                                    </telerik:RadComboBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Cost Center" ItemStyle-Width="150px">
                                                <ItemTemplate>  
                                                    <%#DataBinder.Eval(Container.DataItem, "dept_code")%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="150px" runat="server" ID="cb_dept_d"
                                                        EnableLoadOnDemand="True" Skin="Silk"  DataTextField="name" DataValueField="CostCenter"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>'
                                                        OnItemsRequested="cb_cost_center_ItemsRequested" OnPreRender="cb_dept_d_PreRender"
                                                            OnSelectedIndexChanged="cb_cost_center_SelectedIndexChanged" >
                                                    </telerik:RadComboBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>   
                                         
                                            <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="400px">
                                                <ItemTemplate>  
                                                    <%#DataBinder.Eval(Container.DataItem, "remark")%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_d" Width="400px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                                    </telerik:RadTextBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn> 

                                            <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                                ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                            </telerik:GridButtonColumn>
                             
                                        </Columns>
                                    </MasterTableView>
                                    <ClientSettings>
                                        <ClientEvents OnRowDblClick="rowDblClick"/>
                                    </ClientSettings>
                                    </telerik:RadGrid>
                                      
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
    <telerik:RadNotification RenderMode="Lightweight" ID="notif" Text="Data telah disimpan" runat="server" Position="BottomRight" Skin="Silk"
                AutoCloseDelay="10000" Width="350" Height="110" Title="Confirmation" EnableRoundedCorners="true">
    </telerik:RadNotification>
    
</asp:Content>
