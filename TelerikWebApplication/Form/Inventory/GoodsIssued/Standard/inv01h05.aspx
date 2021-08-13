<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h05.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.GoodsIssued.Standard.inv01h05" %>

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
                window.radopen("reportViewer_inv01h05.aspx?do_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("inv01h05EditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("inv01h05EditForm.aspx?do_code=" + id, "EditDialogWindows");
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
                                    OnItemsRequested="cb_Project_prm_ItemsRequested"
                                    OnSelectedIndexChanged="cb_Project_prm_SelectedIndexChanged"
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%">
                                </telerik:RadComboBox>                                    
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <%--<tr>
                        <td colspan="2">
                            <telerik:RadLabel runat="server" Text="Storage :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="300" DropDownWidth="300px"
                                AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"
                                OnItemsRequested="cb_loc_ItemsRequested" OnSelectedIndexChanged="cb_loc_SelectedIndexChanged" Font-Size="Small"
                            OnPreRender="cb_loc_PreRender">
                            </telerik:RadComboBox> 
                        </td>
                    </tr>--%>
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
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Silk"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="14"
                OnNeedDataSource="RadGrid1_NeedDataSource" 
                OnDeleteCommand="RadGrid1_DeleteCommand" 
                OnItemCreated="RadGrid1_ItemCreated"
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged"
                OnPreRender="RadGrid1_PreRender" 
                OnItemCommand="RadGrid1_ItemCommand" 
                OnItemDataBound="RadGrid1_ItemDataBound" >
                <PagerStyle Mode="NextPrevNumericAndAdvanced" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle>               
                <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px"/>
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="do_code" Font-Size="11px"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false">
                <Columns> 
                    <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                        HeaderText="Edit" HeaderStyle-Width="60px" ItemStyle-Width="60px" UpdateText="Update">
                    </telerik:GridEditCommandColumn>  
                    <telerik:GridBoundColumn UniqueName="do_code" HeaderText="GI Number" DataField="do_code" 
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
                    <telerik:GridBoundColumn UniqueName="ref_code" HeaderText="Reference" DataField="ref_code"
                        FilterControlWidth="100px" >
                        <HeaderStyle Width="135px" />
                        <ItemStyle Width="135px" />
                    </telerik:GridBoundColumn>                       
                    <telerik:GridBoundColumn UniqueName="supp_code" HeaderText="Supplier" DataField="supplier_name" 
                        FilterControlWidth="190px" >
                        <HeaderStyle Width="220px" />
                        <ItemStyle Width="220px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project Code" DataField="region_code" Visible="false" 
                        FilterControlWidth="80px" >
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" 
                        FilterControlWidth="170px" >
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <%--<telerik:GridBoundColumn UniqueName="type_do" HeaderText="From" DataField="do_type" 
                        FilterControlWidth="90px" >
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                            FilterControlWidth="240px">
                        <HeaderStyle Width="280px" />
                        <ItemStyle Width="280px" />
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
                                                        <telerik:RadLabel runat="server" Text="GI Number" CssClass="lbObject"></telerik:RadLabel>
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
                                                        <telerik:RadLabel runat="server" Text="Type" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="3">
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_type_ref" runat="server" Width="150" CausesValidation="false" 
                                                                EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk" AutoPostBack="true"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.type_do_desc") %>' 
                                                                OnItemsRequested="cb_type_ref_ItemsRequested" 
                                                                OnPreRender="cb_type_ref_PreRender"
                                                                OnSelectedIndexChanged="cb_type_ref_SelectedIndexChanged"
                                                                EnableVirtualScrolling="true">
                                                            </telerik:RadComboBox>  
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_type_ref" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>   
                                                        </ContentTemplate>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">                                        
                                                        <telerik:RadLabel runat="server" Text="Cust/Supp" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_CustSupp" runat="server" RenderMode="Lightweight" Skin="Silk" EnableLoadOnDemand="true"  HighlightTemplatedItems="true"
                                                            EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" Enabled="true" Width="250" DropDownWidth="270px" CausesValidation="false"  
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.cust_name") %>'
                                                            OnItemsRequested="cb_CustSupp_ItemsRequested" 
                                                            OnPreRender="cb_CustSupp_PreRender" 
                                                            OnSelectedIndexChanged="cb_CustSupp_SelectedIndexChanged">
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_CustSupp" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Project Area" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_Project" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
                                                            EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="250" DropDownWidth="270px" Enabled="true" 
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>'
                                                            OnItemsRequested="cb_Project_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_Project_SelectedIndexChanged"
                                                            OnPreRender="cb_Project_PreRender">
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_Project" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="vertical-align: top;">
                                            <table id="Table3" border="0" class="module">                                                    
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Ref. No." CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadComboBox ID="cb_ref" runat="server" RenderMode="Lightweight" Width="200px" Height="350px" DataTextField="ref_code" DataValueField="ref_code" 
                                                            EnableLoadOnDemand="true" EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" Skin="Telerik" CausesValidation="false"
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.ref_code") %>'
                                                            OnItemsRequested="cb_ref_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_ref_SelectedIndexChanged" 
                                                            DropDownWidth="650px" AutoPostBack="true"                          
                                                            >
                                                            <HeaderTemplate>
                                                                <table style="width: 650px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            RS No.
                                                                        </td>
                                                                        <td style="width: 250px;">
                                                                            Remark
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 650px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.doc_code")%>
                                                                        </td>
                                                                        <td style="width: 250px;">
                                                                            <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "doc_remark") %>'></asp:label> 
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                    A total of
                                                                <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                                    items
                                                            </FooterTemplate>
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="cb_ref" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                                    </td>                                    
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Unit Code" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadTextBox ID="txt_unit" runat="server" RenderMode="Lightweight" Skin="Telerik" Width="150px" 
                                                            ReadOnly="true" AutoPostBack="false"  Text='<%# DataBinder.Eval(Container, "DataItem.unit_code") %>'>
                                                        </telerik:RadTextBox>
                                                        <%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="txt_unit" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator> --%>                                         
                                                                                          
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Storage Loc." CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>                                                    
                                                        <telerik:RadComboBox ID="cb_warehouse" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true" CausesValidation="false"
                                                            EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="false" Width="300" DropDownWidth="300px" AutoPostBack="false" 
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.wh_name") %>'
                                                            OnItemsRequested="cb_warehouse_ItemsRequested" 
                                                            OnPreRender="cb_warehouse_PreRender" 
                                                            OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged"  
                                                            >
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="cb_warehouse" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>                                                                                     
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
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="cb_CostCenter" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>                                    
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Cost Name" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadTextBox ID="txt_CostCenterName" runat="server" Width="150px" ReadOnly="true" AutoPostBack="false" RenderMode="Lightweight" 
                                                          Text='<%# DataBinder.Eval(Container, "DataItem.costCenterName") %>'>
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
                                        <td style="padding-left:15px ; width:auto">
                                            <table>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel runat="server" Text="Received By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td style="vertical-align:top; text-align:left">
                                                        <telerik:RadComboBox ID="cb_receipt" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px" Height="300px"
                                                            AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                                            HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.receivedBy_name") %>'
                                                            OnItemsRequested="cb_receipt_ItemsRequested" 
                                                            OnPreRender="cb_receipt_PreRender" 
                                                            OnSelectedIndexChanged="cb_receipt_SelectedIndexChanged" 
                                                            OnDataBound="cb_receipt_DataBound"                                                  
                                                            >
                                                            <HeaderTemplate>
                                                                <table style="width: 650px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 300px;">
                                                                            Name
                                                                        </td>
                                                                        <td style="width: 350px;">
                                                                            Position
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 650px; font-size:smaller">
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
                                                                A total of
                                                                <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                                items
                                                            </FooterTemplate>
                                                        </telerik:RadComboBox>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-left=15px">
                                                        <telerik:RadLabel runat="server" Text="Issued By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_issued" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px" Height="300px"
                                                            AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                                            HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.issuedby_name") %>'
                                                            OnItemsRequested="cb_issued_ItemsRequested" 
                                                            OnPreRender="cb_issued_PreRender" 
                                                            OnSelectedIndexChanged="cb_issued_SelectedIndexChanged" 
                                                            OnDataBound="cb_issued_DataBound"                                                   
                                                            >
                                                            <HeaderTemplate>
                                                                <table style="width: 650px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 300px;">
                                                                            Name
                                                                        </td>
                                                                        <td style="width: 350px;">
                                                                            Position
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 650px; font-size:smaller">
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
                                                                A total of
                                                                <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                                items
                                                            </FooterTemplate>
                                                        </telerik:RadComboBox>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-left=15px">
                                                        <telerik:RadLabel runat="server" Text="Approved By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_approval" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px" Height="300px"
                                                            AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                                            HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                                             Text='<%# DataBinder.Eval(Container, "DataItem.approveBy_name") %>' 
                                                            OnItemsRequested="cb_approval_ItemsRequested" 
                                                            OnPreRender="cb_approval_PreRender" 
                                                            OnSelectedIndexChanged="cb_approval_SelectedIndexChanged" 
                                                            OnDataBound="cb_approval_DataBound"                                                    
                                                            >
                                                            <HeaderTemplate>
                                                                <table style="width: 650px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 300px;">
                                                                            Name
                                                                        </td>
                                                                        <td style="width: 350px;">
                                                                            Position
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 650px; font-size:smaller">
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
                                                                A total of
                                                                <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                                items
                                                            </FooterTemplate>
                                                        </telerik:RadComboBox>                                                           
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                        
                                                    </td>
                                                    
                                                </tr>
                                            </table>                                            
                                        </td>
                                    </tr>   
                                    <%--<tr>
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
                                                    
                                                </tr>               
                                            </table>
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td colspan="4" style="padding-top:15px; padding-bottom:10px;color:cadetblue"">
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
                                                        <telerik:RadTextBox ReadOnly="true" ID="txt_lastUpdate" Width="100px" runat="server" Skin="Silk" ReadOnlyStyle-HorizontalAlign="Center"
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
                                                    <td style="padding-left:20px">
                                                        <asp:CheckBox ID="chk_posting" runat="server" Checked="false" Text="Posting" Enabled="false"/>
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
                                                    AllowPaging="false" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" ShowStatusBar="true" 
                                                    OnNeedDataSource="RadGrid2_NeedDataSource"
                                                    OnDeleteCommand="RadGrid2_DeleteCommand"
                                                    OnPreRender="RadGrid2_PreRender" 
                                                    OnUpdateCommand="RadGrid2_UpdateCommand"
                                                    OnInsertCommand="RadGrid2_InsertCommand"
                                                    OnItemCommand="RadGrid2_ItemCommand">
                                                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                                <HeaderStyle Font-Size="12px" ForeColor="Highlight" />
                                                <MasterTableView CommandItemDisplay="None"  DataKeyNames="prod_code" Font-Size="11px" EditMode="InPlace"
                                                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item" 
                                                CommandItemSettings-ShowRefreshButton="False" ItemStyle-ForeColor="#006600">
                                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="False" ShowCancelChangesButton="false" />
                                                    <Columns>
                                                            <%--<telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  
                                                                HeaderText="Edit" HeaderStyle-Width="60px" ItemStyle-Width="60px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                                            </telerik:GridEditCommandColumn>--%>
                                                            <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="120px" ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" 
                                                                 ItemStyle-HorizontalAlign="Center" >
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lbl_ProdCode" ReadOnly="true" BorderStyle="None" Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>'>
                                                                    </asp:Label>
                                                                </ItemTemplate>
                                                                
                                                            </telerik:GridTemplateColumn>

                                                            <telerik:GridTemplateColumn HeaderText="SOH" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Right" 
                                                                ItemStyle-HorizontalAlign="Right" >
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblSOH" Text='<%# DataBinder.Eval(Container.DataItem, "SOH", "{0:#,###,###0.00}") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                
                                                            </telerik:GridTemplateColumn>
                                    
                                                            <telerik:GridTemplateColumn HeaderText="Qty Out" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                                                                HeaderStyle-HorizontalAlign="Right" DefaultInsertValue="0"  >
                                                                <ItemTemplate>
                                                                    <%--<telerik:RadLabel RenderMode="Lightweight" runat="server" ID="lbl_Part_Qty" Width="85px" EnabledStyle-HorizontalAlign="Right"
                                                                        NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                                        Text='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                                                        onkeydown="blurTextBox(this, event)"
                                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                                        NumberFormat-DecimalDigits="2">
                                                                    </telerik:RadLabel>--%>
                                                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_Part_Qty_edit" Width="85px" EnabledStyle-HorizontalAlign="Right"
                                                                        NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                                        Text='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                                                        onkeydown="blurTextBox(this, event)"
                                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                                        NumberFormat-DecimalDigits="2">
                                                                    </telerik:RadNumericTextBox>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>

                                                            <telerik:GridTemplateColumn HeaderText="Uom" HeaderStyle-Width="80px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center"
                                                                HeaderStyle-HorizontalAlign="Center" >
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblUom" Width="80px" Text='<%# DataBinder.Eval(Container.DataItem, "uom") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                    
                                                            <telerik:GridTemplateColumn HeaderText="Cost ctr" HeaderStyle-Width="75px" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Center" 
                                                                HeaderStyle-HorizontalAlign="Center" >
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblCostCntr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                    
                                                            <telerik:GridTemplateColumn HeaderText="Storage" HeaderStyle-Width="80px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" 
                                                                HeaderStyle-HorizontalAlign="Center" >
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblstorage" Text='<%# DataBinder.Eval(Container.DataItem, "wh_code") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                    
                                                            <telerik:GridTemplateColumn HeaderText="Warranty" HeaderStyle-Width="50px" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center"
                                                                HeaderStyle-HorizontalAlign="Center" >
                                                                <ItemTemplate>
                                                                    <%--<asp:Label runat="server" ID="lblWarranty" Text='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>'></asp:Label>--%>
                                                                    <asp:CheckBox runat="server" ID="chkWarranty" Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Original Material" HeaderStyle-Width="120px" ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" 
                                                                ItemStyle-HorizontalAlign="Center" >
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblProdCodeOri" Text='<%# DataBinder.Eval(Container, "DataItem.prod_code_ori") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="200px" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <%--<asp:Label runat="server" ID="lblRemark" Width="200px" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>--%>
                                                                    <telerik:RadTextBox runat="server" ID="txtRemark" Width="200px" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'>
                                                                    </telerik:RadTextBox>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>

                                                            <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" 
                                                                ConfirmDialogType="Classic" ButtonType="FontIconButton" ItemStyle-Width="25px" HeaderStyle-Width="25px">
                                                            </telerik:GridButtonColumn>
                                                        </Columns>
                                                </MasterTableView>
                                                <ClientSettings>
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="192px" />
                                                        <Selecting AllowRowSelect="true"></Selecting> 
                                                </ClientSettings>
                                                </telerik:RadGrid> 
                                            </div>                
                                        </telerik:RadPageView>
                                        <telerik:RadPageView runat="server" ID="RadPageView2" Height="300px">
                                            <div runat="server" style="padding:15px 15px 15px 15px">
                                                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" AutoGenerateColumns="false" Skin="Silk" CssClass="RadGrid_ModernBrowsers"
                                                    AllowPaging="false" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" ShowStatusBar="true"        
                                                    OnNeedDataSource="RadGrid3_NeedDataSource" OnPreRender="RadGrid3_PreRender">
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
                                                            <telerik:GridBoundColumn DataField="cur_code" HeaderStyle-Width="70px" HeaderText="Currency" SortExpression="cur_code"
                                                                UniqueName="cur_code" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" 
                                                                ItemStyle-Width="70px">                                
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
                    <Selecting AllowRowSelect="true"></Selecting>
                    <ClientEvents OnRowDblClick="RowDblClick" />
                    <%--<Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="290" />--%>
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


