<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h05gto.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.GoodsTransfer.OutGoing.inv01h05gto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />    
    <script type="text/javascript" src="../../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

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
                window.radopen("inv01h01EditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("inv01h01EditForm.aspx?doc_code=" + id, "EditDialogWindows");
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
            <%--<telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>--%>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_proj_from">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_CostCtr" ></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
        </AjaxSettings>

    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 170px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
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
                             Skin="Material" ForeColor="DeepSkyBlue" ></telerik:RadButton>
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
                        padding-bottom: 0px; font-size: x-large; color:yellowgreen;">
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
            OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged">
            <PagerStyle Mode="NumericPages"></PagerStyle>  
            <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="false" />
            <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px"/>
            <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="do_code" Font-Size="11px" Font-Names="Century Gothic"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight"
                   >
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="40px"/>
                        <ItemStyle Width="40px" />
                    </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="do_code" HeaderText="Reg. No." DataField="do_code" ItemStyle-Width="100px" FilterControlWidth="90px" 
                            ItemStyle-HorizontalAlign="Left" >
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="Tgl" HeaderText="Date" DataField="Tgl" ItemStyle-Width="100px"
                            EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker"
                            DataFormatString="{0:d}">
                            <HeaderStyle Width="120px" ></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Ori. Site" DataField="region_code" FilterControlWidth="80px">
                            <HeaderStyle Width="100px" ></HeaderStyle>
                            <ItemStyle Width="100px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="to_region_code" HeaderText="Dest. Site" DataField="to_region_code" FilterControlWidth="80px">
                            <HeaderStyle Width="100px" ></HeaderStyle>
                            <ItemStyle Width="100px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="dept_code" HeaderText="Cost Ctr" DataField="dept_code" FilterControlWidth="80px">
                            <HeaderStyle Width="100px" ></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="wh_code" HeaderText="Ori. WH" DataField="wh_code" FilterControlWidth="80px">
                            <HeaderStyle Width="100px" ></HeaderStyle>
                            <ItemStyle Width="100px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="to_wh_code" HeaderText="Dest. WH" DataField="to_wh_code" FilterControlWidth="80px">
                            <HeaderStyle Width="100px" ></HeaderStyle>
                            <ItemStyle Width="100px" />
                        </telerik:GridBoundColumn>                       
                        <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                            ItemStyle-Width="290px"  AllowFiltering="false">
                            <HeaderStyle Width="290px" ></HeaderStyle>
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
                                <tr style="vertical-align: top;">
                                    <td style="vertical-align: top;">
                                        <table id="Table2" width="Auto" border="0" class="module">
                                            <tr>
                                                <td colspan="3" style="padding: 0px 0px 10px 0px; text-align:left">
                                                    <asp:Button ID="btnUpdate" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" 
                                                        OnClick="btnUpdate_Click" Height="25px" 
                                                        Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" 
                                                        CssClass="btn-entryFrm" >
                                                    </asp:Button>&nbsp;
                            
                                                    <asp:Button ID="btnCancel" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" 
                                                        Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                                        runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                                                </td>
                                            </tr>                   
                                                <tr style="vertical-align: top">
                                                    <td style="vertical-align: top">
                                                        <telerik:RadLabel runat="server" Text="Reg. No. :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadTextBox ID="txt_do_code" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                            EmptyMessage="Let it blank" Text='<%# DataBinder.Eval(Container, "DataItem.do_code") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Date* :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadDatePicker ID="dtp_do" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                            TabIndex="4" Skin="Telerik" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.Tgl") %>'>
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <br />
                                                        <telerik:RadLabel Text="Original" runat="server" Font-Bold="true"></telerik:RadLabel><br /> 
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Project Area:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_proj_from" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="*"></asp:RequiredFieldValidator>

                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_proj_from" runat="server" Width="200" Height="300px"
                                                            DropDownWidth="300px"
                                                            AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                            OnItemsRequested="cb_proj_from_ItemsRequested" OnSelectedIndexChanged="cb_proj_from_SelectedIndexChanged"
                                                            OnPreRender="cb_proj_from_PreRender" Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>'>
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Cost Center:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        <asp:RequiredFieldValidator runat="server" ID="CostCenterValidator1" ControlToValidate="cb_CostCtr" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="*"></asp:RequiredFieldValidator>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_CostCtr" runat="server" Width="250px" Height="300px" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.CostCenterName") %>'
                                                            DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" 
                                                            OnItemsRequested="cb_CostCtr_ItemsRequested" OnSelectedIndexChanged="cb_CostCtr_SelectedIndexChanged" 
                                                            OnPreRender="cb_CostCtr_PreRender">
                                                            <HeaderTemplate>
                                                                <table style="width: 450px; font-size: smaller">
                                                                    <tr>
                                                                        <td style="width: 100px;">Code</td>
                                                                        <td style="width: 350px;">Name</td>
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
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Storage:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        <asp:RequiredFieldValidator runat="server" ID="warehouseValidator" ControlToValidate="cb_warehouse" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="*"></asp:RequiredFieldValidator><br />
                                                   </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="200" DropDownWidth="300px"
                                                            AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.ori_wh_name") %>' 
                                                            OnItemsRequested="cb_warehouse_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged"                                                             
                                                            OnPreRender="cb_warehouse_PreRender" CausesValidation="false">
                                                        </telerik:RadComboBox>                                                  
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Reference:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        <%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_ref" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />--%>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ref" runat="server" Width="200px" AutoPostBack="true" CausesValidation="false"
                                                            DropDownWidth="1100px" EnableLoadOnDemand="true" ShowMoreResultsBox="true" 
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="lbm_code" DataValueField="lbm_code"
                                                            OnItemsRequested="cb_ref_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_ref_SelectedIndexChanged"
                                                            OnPreRender="cb_ref_PreRender" Text='<%# DataBinder.Eval(Container, "DataItem.ref_code") %>'>
                                                                <HeaderTemplate>
                                                                    <table style="width: 1000px; font-size: smaller">
                                                                            <tr>
                                                                                <td style="width: 150px; font-variant:small-caps; color: #3399FF;">GR. Number
                                                                                </td>
                                                                                <td style="width: 150px;font-variant:small-caps; color: #3399FF;">Reff. No.
                                                                                </td>
                                                                                <td style="width: 150px; font-variant:small-caps; color: #3399FF;">Date
                                                                                </td>
                                                                                <td style="width: 400px; font-variant:small-caps; color: #3399FF;">Supplier
                                                                                </td>
                                                                                <td style="width: 150px;font-variant:small-caps; color: #3399FF;">Transaction
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <table style="width: 1000px; font-size: smaller">
                                                                            <tr>
                                                                                <td style="width: 150px;">
                                                                                    <%# DataBinder.Eval(Container, "DataItem.lbm_code")%>
                                                                                </td>
                                                                                <td style="width: 150px;">
                                                                                    <%# DataBinder.Eval(Container, "DataItem.ref_code")%>
                                                                                </td>
                                                                                <td style="width: 150px;">
                                                                                    <%# DataBinder.Eval(Container, "DataItem.lbm_date")%>
                                                                                </td>
                                                                                <td style="width: 200px;">
                                                                                    <%# DataBinder.Eval(Container, "DataItem.cust_name")%>
                                                                                </td>
                                                                                <td style="width: 450px;">
                                                                                    <%# DataBinder.Eval(Container, "DataItem.nmmasuk")%>
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
                                    <td style="vertical-align:top; padding-left:30px;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Expedition:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_expedition" runat="server" Width="200px" AutoPostBack="true" CausesValidation="false"
                                                        DropDownWidth="300px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" Text='<%# DataBinder.Eval(Container, "DataItem.EXP_NAME") %>' 
                                                        OnItemsRequested="cb_expedition_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_expedition_SelectedIndexChanged" 
                                                        OnPreRender="cb_expedition_PreRender"
                                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Ship Mode:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>   
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ship" runat="server" Width="200px"  Height="300px" 
                                                        AutoPostBack="false" CausesValidation="false"
                                                        DropDownWidth="200px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ShipModeEtd") %>'
                                                        OnItemsRequested="cb_ship_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_ship_SelectedIndexChanged" 
                                                        OnPreRender="cb_ship_PreRender">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" >
                                                    <br />
                                                    <telerik:RadLabel Text="Destination" runat="server" Font-Bold="true"></telerik:RadLabel><br /> 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td >
                                                    <telerik:RadLabel runat="server" Text="Project:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    <asp:RequiredFieldValidator runat="server" ID="ProjectDestiValidator" ControlToValidate="cb_proj_to" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_proj_to" runat="server" Width="300" DropDownWidth="300px"
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                        OnItemsRequested="cb_proj_to_ItemsRequested" OnSelectedIndexChanged="cb_proj_to_SelectedIndexChanged"
                                                        OnPreRender="cb_proj_to_PreRender" Text='<%# DataBinder.Eval(Container, "DataItem.to_region_name") %>'>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td >
                                                    <telerik:RadLabel runat="server" Text="Storage:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    <asp:RequiredFieldValidator runat="server" ID="WarehouseToValidator" ControlToValidate="cb_warehouse_to" ForeColor="Red" 
                                                      Text="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse_to" runat="server" 
                                                        Width="300" DropDownWidth="300px"  Height="300px"
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                        OnItemsRequested="cb_warehouse_to_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_warehouse_to_SelectedIndexChanged"
                                                        OnPreRender="cb_warehouse_to_PreRender" Text='<%# DataBinder.Eval(Container, "DataItem.dest_wh_name") %>'>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td >
                                                    <telerik:RadLabel runat="server" Text="Remark:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_remark" Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'
                                                        runat="server" TextMode="MultiLine"
                                                        Width="300px" Rows="0" TabIndex="5" Resize="Both">
                                                    </telerik:RadTextBox>                                                            
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chk_posting" runat="server" Checked="false" Text="Posting" CssClass="lbObject"/>
                                                </td>
                                            </tr>   
                                        </table>
                                    </td>
                                    <td style="vertical-align:top; padding-left:30px;">
                                        <table>
                                            <tr>
                                                <td style="vertical-align: top; text-align: left; ">
                                                    <telerik:RadLabel CssClass="lbObject" runat="server" Text="Prepared By:" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="cb_prepare_by" runat="server" Width="250px" CausesValidation="false" 
                                                                DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                                OnItemsRequested="cb_prepare_by_ItemsRequested" Text='<%# DataBinder.Eval(Container, "DataItem.FreByName") %>'
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
                                                <td style="vertical-align: top; text-align: left; ">
                                                    <telerik:RadLabel CssClass="lbObject" runat="server" Text="Send By:" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="cb_send_by" runat="server" Width="250px" CausesValidation="false" 
                                                        DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                        OnItemsRequested="cb_send_by_ItemsRequested" Text='<%# DataBinder.Eval(Container, "DataItem.OrdByName") %>'
                                                        OnSelectedIndexChanged="cb_send_by_SelectedIndexChanged" OnPreRender="cb_send_by_PreRender">
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
                                                <td style="vertical-align: top; text-align: left; ">
                                                    <telerik:RadLabel CssClass="lbObject" runat="server" Text="Ack. By:" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="cb_ack_by" runat="server" Width="250px" CausesValidation="false" 
                                                        DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                        OnItemsRequested="cb_ack_by_ItemsRequested" Text='<%# DataBinder.Eval(Container, "DataItem.AppByName") %>'
                                                        OnSelectedIndexChanged="cb_ack_by_SelectedIndexChanged" OnPreRender="cb_ack_by_PreRender">
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
                                <tr>
                                    <td colspan="6" style="padding-top:10px; padding-bottom:10px;">
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
                                <div style="padding: 7px 0px 12px 0px; height:288px">                               
                                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" runat="server" AllowPaging="False" ShowFooter="false" PageSize="5" Skin="Silk"
                                        AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers"
                                        OnNeedDataSource="RadGrid2_NeedDataSource"                                                
                                        OnInsertCommand="RadGrid2_InsertCommand"
                                        OnUpdateCommand="RadGrid2_UpdateCommand"
                                        OnDeleteCommand="RadGrid2_DeleteCommand"
                                        OnItemCommand="RadGrid2_ItemCommand"
                                         OnPreRender="RadGrid2_PreRender"
                                        ClientSettings-Selecting-AllowRowSelect="true"> 
                                        <HeaderStyle Font-Size="12px" />
                                        <PagerStyle Mode="NumericPages" />  
                                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="do_code, prod_code" Font-Size="11px" EditMode="InPlace"
                                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" InsertItemDisplay="Bottom">
                                            <ItemStyle Height="10px" />
                                            <HeaderStyle Font-Size="11px" />
                                        <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" /> 
                                            <%-- <ColumnGroups >
                                                <telerik:GridColumnGroup HeaderText="Qty" Name="QtyGroup" HeaderStyle-HorizontalAlign="Center"></telerik:GridColumnGroup>
                                            </ColumnGroups>--%>
                                            <Columns>
                                                <%--<telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                                    HeaderText="Edit" HeaderStyle-Width="30px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                                </telerik:GridEditCommandColumn>--%>
                                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                                    HeaderText="Edit" HeaderStyle-Width="60px" ItemStyle-Width="60px" UpdateText="Update">
                                                </telerik:GridEditCommandColumn> 
                                                 
                                                <telerik:GridTemplateColumn HeaderText="Material Code" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center" 
                                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center" ItemStyle-Height="50px">
                                                    <ItemTemplate>    
                                                        <asp:Label runat="server" ID="lbl_prod_code" Text='<%# DataBinder.Eval(Container.DataItem, "prod_code") %>'></asp:Label>
                                                        <%--<telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip1" runat="server" TargetControlID="lbl_prod_code" RelativeTo="Element"
                                                                Position="BottomCenter" RenderInPageRoot="true">                                                
                                                        </telerik:RadToolTip>--%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>                                 
                                                         <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="spec"
                                                        OnItemsRequested="cb_prod_code_ItemsRequested" DataValueField="prod_code" AutoPostBack="true" CausesValidation="false" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>' EmptyMessage="- Search product name here -"
                                                        HighlightTemplatedItems="true" Height="190px" Width="120px" DropDownWidth="430px"
                                                        OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" OnPreRender="cb_prod_code_PreRender">                            
                                                            <HeaderTemplate>
                                                                <table style="width: 800px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            Prod Code
                                                                        </td>
                                                                        <td style="width: 350px;">
                                                                            Prod Spec
                                                                        </td>
                                                                        <td style="width: 150px;">
                                                                            Brand
                                                                        </td> 
                                                                        <td style="width: 70px;">
                                                                            UoM
                                                                        </td> 
                                                                        <td style="width: 80px;">
                                                                            SOH
                                                                        </td>                                            
                                                                    </tr>
                                                                </table>                                                       
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 800px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            <%# DataBinder.Eval(Container, "Value")%>
                                                                        </td>
                                                                        <td style="width: 350px;">
                                                                            <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                                        </td>  
                                                                        <td style="width: 150px;">
                                                                            <%# DataBinder.Eval(Container, "Attributes['brand_name']")%>
                                                                        </td>
                                                                        <td style="width: 70px;">
                                                                            <%# DataBinder.Eval(Container, "Attributes['unit_code']")%>
                                                                        </td>
                                                                        <td style="width: 80px;">
                                                                            <%# DataBinder.Eval(Container, "Attributes['QACT']")%>
                                                                        </td>                                                                                                                                                        
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </telerik:RadComboBox>
                                                        <%--<telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip2" runat="server" TargetControlID="cb_prod_code" RelativeTo="Element"
                                                            Position="BottomCenter" RenderInPageRoot="true" HideDelay="300" ShowEvent="OnMouseOver">                                                
                                                        </telerik:RadToolTip> --%>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_insert" EnableLoadOnDemand="True" DataTextField="spec"
                                                            OnItemsRequested="cb_prod_code_ItemsRequested" DataValueField="prod_code" AutoPostBack="true" CausesValidation="false"  
                                                             EmptyMessage="- Search product name here -" HighlightTemplatedItems="true" Height="190px" Width="120px" DropDownWidth="430px"
                                                            OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" OnPreRender="cb_prod_code_PreRender">                            
                                                            <HeaderTemplate>
                                                                <table style="width: 800px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            Prod Code
                                                                        </td>
                                                                        <td style="width: 350px;">
                                                                            Prod Spec
                                                                        </td>
                                                                        <td style="width: 150px;">
                                                                            Brand
                                                                        </td> 
                                                                        <td style="width: 70px;">
                                                                            UoM
                                                                        </td> 
                                                                        <td style="width: 80px;">
                                                                            SOH
                                                                        </td>                                            
                                                                    </tr>
                                                                </table>                                                       
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 800px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            <%# DataBinder.Eval(Container, "Value")%>
                                                                        </td>
                                                                        <td style="width: 350px;">
                                                                            <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                                        </td>  
                                                                        <td style="width: 150px;">
                                                                            <%# DataBinder.Eval(Container, "Attributes['brand_name']")%>
                                                                        </td>
                                                                        <td style="width: 70px;">
                                                                            <%# DataBinder.Eval(Container, "Attributes['unit_code']")%>
                                                                        </td>
                                                                        <td style="width: 80px;">
                                                                            <%# DataBinder.Eval(Container, "Attributes['QACT']")%>
                                                                        </td>                                                                                                                                                        
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </telerik:RadComboBox>
                                                    </InsertItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <%--<telerik:GridTemplateColumn HeaderText="Superior" HeaderStyle-Width="150px" ItemStyle-Width="150px"
                                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblSuperior"></asp:Label>
                                                    </ItemTemplate> 
                                                    <EditItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_Superior" Width="150px" BorderStyle="None"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.") %>'>
                                                        </telerik:RadTextBox>
                                                    </EditItemTemplate>     
                                                    <InsertItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_Superior_insert" Width="150px" BorderStyle="None">
                                                        </telerik:RadTextBox>
                                                    </InsertItemTemplate>                                  
                                                </telerik:GridTemplateColumn>--%>

                                                <telerik:GridTemplateColumn HeaderText="Send" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center"
                                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label RenderMode="Lightweight" runat="server" ID="lblSend" Width="70px"  ReadOnly="False" EnabledStyle-HorizontalAlign="Right"
                                                            NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                            Text='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                                            NumberFormat-DecimalDigits="2" ForeColor="#006600" Font-Bold="True" Font-Underline="True">
                                                        </asp:Label>
                                                    </ItemTemplate> 
                                                    <EditItemTemplate>
                                                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_QtyOut" Width="85px" EnabledStyle-HorizontalAlign="Right"
                                                            NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                            Text='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                                            NumberFormat-DecimalDigits="2">
                                                        </telerik:RadNumericTextBox>
                                                    </EditItemTemplate>   
                                                    <InsertItemTemplate>
                                                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_QtyOut_insert" Width="85px" EnabledStyle-HorizontalAlign="Right"
                                                            NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                            onkeydown="blurTextBox(this, event)"
                                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                                            NumberFormat-DecimalDigits="2">
                                                        </telerik:RadNumericTextBox>
                                                    </InsertItemTemplate>                               
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Receipt" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center"
                                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <telerik:RadTextBox ID="txt_QtyRec" runat="server" RenderMode="Lightweight" Width="70px"  ReadOnly="true" EnabledStyle-HorizontalAlign="Right" 
                                                            NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" BorderStyle="None"
                                                            onkeydown="blurTextBox(this, event)" AutoPostBack="true" MaxLength="11" 
                                                            Type="Number" NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadTextBox>
                                                    </ItemTemplate>                                        
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center"
                                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <%--<telerik:RadTextBox RenderMode="Lightweight" runat="server" Width="70px" ID="txt_uom" Text='<%# DataBinder.Eval(Container.DataItem, "unit_code") %>'>
                                                        </telerik:RadTextBox>--%>
                                                        <asp:Label runat="server" ID="lbl_uom" Text='<%# DataBinder.Eval(Container.DataItem, "unit_code") %>'></asp:Label>
                                                    </ItemTemplate>  
                                                    <EditItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_UoM" Width="70px" BorderStyle="None"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.unit_code") %>'>
                                                        </telerik:RadTextBox>
                                                    </EditItemTemplate>  
                                                    <InsertItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_UoM_insert" Width="70px" BorderStyle="None">
                                                        </telerik:RadTextBox>
                                                    </InsertItemTemplate>                                    
                                                </telerik:GridTemplateColumn>
                                
                                                <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="350px" ItemStyle-Width="350px"
                                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbl_remark" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="350px" BorderStyle="None"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                                        </telerik:RadTextBox>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d_insert" Width="350px" BorderStyle="None">
                                                        </telerik:RadTextBox>
                                                    </InsertItemTemplate>
                                                </telerik:GridTemplateColumn>
                                
                                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                                                    HeaderStyle-ForeColor="#009900" ConfirmTitle="Delete" ConfirmDialogType="RadWindow"
                                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                                </telerik:GridButtonColumn>
                                            </Columns>
                                        </MasterTableView>
                                        <ClientSettings >
                                            <Scrolling AllowScroll="false" UseStaticHeaders="True" ScrollHeight="185px" /> 
                                            <Selecting AllowRowSelect="true"></Selecting>
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

        <telerik:RadWindowManager ID="RadWindowManager1" runat="server" RenderMode="Lightweight" EnableShadow="true" >
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1150px" Height="670px" Modal="true" AutoSize="True">
                </telerik:RadWindow>
                <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="850px" Height="720px" Modal="true" AutoSize="False">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>

        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true"></telerik:RadWindowManager>
        
        <telerik:RadNotification ID="notif" runat="server" RenderMode="Lightweight" Text="Data berhasil disimpan" Position="BottomRight" 
            AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
        </telerik:RadNotification>
     
</asp:Content>
