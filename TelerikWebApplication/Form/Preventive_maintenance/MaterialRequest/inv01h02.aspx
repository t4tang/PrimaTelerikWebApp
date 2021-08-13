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
            <%--<telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid3"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
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

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone" Skin="Silk"
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
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click" ToolTip="Add New" Visible="true"
                        Height="26px" Width="27px" ImageUrl="~/Images/tambah.png" ImageAlign="Bottom" ></asp:ImageButton>
                </td>                
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter" 
                        Height="29px" Width="30px" ImageUrl="~/Images/search.png"></asp:ImageButton>
                </td>
                <td style="width: 96%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight:normal; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#0099dc;">
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
            OnPreRender="RadGrid1_PreRender" 
            OnItemDataBound="RadGrid1_ItemDataBound">
            <PagerStyle Mode="NumericPages"></PagerStyle> 
            <ClientSettings EnablePostBackOnRowClick="false" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
            <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px" HorizontalAlign="Center"/>
            <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="sro_code" Font-Size="11px" Font-Names="Century Gothic"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" 
                CommandItemSettings-AddNewRecordText="New" EditFormSettings-EditFormType="WebUserControl" InsertItemDisplay="Top">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="40px"/>
                        <ItemStyle Width="40px" />
                    </telerik:GridEditCommandColumn>
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
                                                    <asp:Button ID="btnUpdate" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" 
                                                        OnClick="btn_save_Click" Height="25px" 
                                                        Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" 
                                                        CssClass="btn-entryFrm" >
                                                    </asp:Button>&nbsp;
                            
                                                    <asp:Button ID="btnCancel" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" 
                                                        Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                                        runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                                                </td>
                                            </tr>   
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="MR Number" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_mr_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.sro_code") %>' 
                                                        Skin="Telerik"  EmptyMessage="Let it blank" >
                                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Project Area" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <%--<asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                        <ContentTemplate>--%>
                                                            <telerik:RadComboBox ID="cb_Project" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' 
                                                                EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="250" DropDownWidth="270px" 
                                                                OnItemsRequested="cb_Project_ItemsRequested" 
                                                                OnPreRender="cb_Project_PreRender" 
                                                                OnSelectedIndexChanged="cb_Project_SelectedIndexChanged">
                                                            </telerik:RadComboBox>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_Project" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="*" CssClass="required_validator"></asp:RequiredFieldValidator>
                                                        <%--</ContentTemplate>
                                                    </asp:UpdatePanel>--%>
                                                

                                                </td>
                                            </tr>                                           
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtp_date" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="Telerik" 
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.sro_date") %>'>
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
                                                    <telerik:RadLabel runat="server" Text="Delivery Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtp_deliv" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="Telerik" 
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.deliv_date") %>'>
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
                                                    <telerik:RadLabel runat="server" Text="WO. Number" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_wo" runat="server" Width="200px" AutoPostBack="true" CausesValidation="false"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.trans_id") %>' Height="350px"
                                                        DropDownWidth="900px" EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="trans_id" DataValueField="trans_id"
                                                        OnItemsRequested="cb_wo_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_wo_SelectedIndexChanged" 
                                                        OnPreRender="cb_wo_PreRender">
                                                        <HeaderTemplate>
                                                            <table style="width: 900px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 80px; font-variant:small-caps; color: #3399FF;">Wo Number
                                                                    </td>
                                                                    <td style="width: 80px; font-variant:small-caps; color: #3399FF;">Date
                                                                    </td>
                                                                    <td style="width: 80px; font-variant:small-caps; color: #3399FF;">Unit Code 
                                                                    </td>                                                    
                                                                    <td style="width: 550px; font-variant:small-caps; color: #3399FF;">Problem
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 900px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 80px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.trans_id")%>
                                                                    </td>
                                                                    <td style="width: 80px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.trans_date","{0:dd-MM-yyyy}")%>
                                                                    </td>
                                                                    <td style="width: 80px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                                    </td>
                                                                    <td style="width: 550px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.remark")%>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                        </FooterTemplate>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_wo" ForeColor="Red" 
                                                    Font-Size="X-Small" Text="*" CssClass="required_validator"></asp:RequiredFieldValidator>                                                        
                                                </td>            
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Unit Code" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_unit" runat="server" RenderMode="Lightweight" Width="150px" Skin="Telerik"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.unit_code") %>' ></telerik:RadTextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="vertical-align: top;">
                                        <table id="Table3" width="Auto" border="0" class="module" style="padding: 0px 0px 0px 7px"> 
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Priority" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="cb_priority" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.prio_desc") %>' 
                                                        EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="false" Width="150" DropDownWidth="150px" 
                                                        OnItemsRequested="cb_priority_ItemsRequested" 
                                                        OnPreRender="cb_priority_PreRender" 
                                                        OnSelectedIndexChanged="cb_priority_SelectedIndexChanged">
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_priority" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="*" CssClass="required_validator"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Order Type" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="cb_Order" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.OrderName") %>' 
                                                        EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="false" Width="180" DropDownWidth="180px" 
                                                        OnItemsRequested="cb_Order_ItemsRequested" 
                                                        OnPreRender="cb_Order_PreRender" 
                                                        OnSelectedIndexChanged="cb_Order_SelectedIndexChanged">
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="cb_Order" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="*" CssClass="required_validator"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Job Type" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="cb_job" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true" CausesValidation="false" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.PMAct_Name") %>' 
                                                        EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="180" DropDownWidth="180px" 
                                                        OnItemsRequested="cb_job_ItemsRequested" 
                                                        OnPreRender="cb_job_PreRender" 
                                                        OnSelectedIndexChanged="cb_job_SelectedIndexChanged">
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="cb_job" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="*" CssClass="required_validator"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Ordered By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td style="vertical-align:top; text-align:left">
                                                    <%-- <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                        <ContentTemplate>--%>
                                                            <telerik:RadComboBox ID="cb_ordered" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.OrdByName") %>' Height="350px"
                                                                AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                                                HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                                OnItemsRequested="cb_ordered_ItemsRequested" 
                                                                OnPreRender="cb_ordered_PreRender" 
                                                                OnSelectedIndexChanged="cb_ordered_SelectedIndexChanged">
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
                                                        <%-- </ContentTemplate>
                                                    </asp:UpdatePanel>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left=15px">
                                                    <telerik:RadLabel runat="server" Text="Checked By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <%-- <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                        <ContentTemplate>--%>
                                                            <telerik:RadComboBox ID="cb_checked" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.CheckedByName") %>'  Height="330px"
                                                                AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                                                HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                                OnItemsRequested="cb_checked_ItemsRequested" 
                                                                OnPreRender="cb_checked_PreRender" 
                                                                OnSelectedIndexChanged="cb_checked_SelectedIndexChanged">
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
                                                        <%--</ContentTemplate>
                                                    </asp:UpdatePanel>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Acknowledged By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <%--<asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                        <ContentTemplate>--%>
                                                            <telerik:RadComboBox ID="cb_ack" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.AckByName") %>'  Height="310px"
                                                                AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                                                HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                                OnItemsRequested="cb_ack_ItemsRequested" 
                                                                OnPreRender="cb_ack_PreRender" 
                                                                OnSelectedIndexChanged="cb_ack_SelectedIndexChanged">
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
                                                        <%-- </ContentTemplate>
                                                    </asp:UpdatePanel>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Remark" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>                
                                                <td style="vertical-align:top; text-align:left">                               
                                                    <%--<asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                                        <ContentTemplate>--%>
                                                            <telerik:RadTextBox ID="txt_remark" runat="server" TextMode="MultiLine"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.sro_remark") %>' 
                                                                Width="350px" Rows="0" TabIndex="5" Resize="Both" Skin="Telerik">
                                                            </telerik:RadTextBox>
                                    
                                                            <asp:CheckBox runat="server" Checked="false" ID="chk_close" Visible="false" />
                                                        <%--</ContentTemplate>
                                                    </asp:UpdatePanel> --%>                                 
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
        
                            </table>
                            <div style="padding: 7px 0px 12px 0px; height:235px">           
                                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" AutoGenerateColumns="false" PageSize="4"  Skin="Silk"
                                    AllowPaging="false" AllowSorting="true" runat="server" CssClass="RadGrid_Silk"
                                    OnNeedDataSource="RadGrid3_NeedDataSource"
                                    OnInsertCommand="RadGrid3_InsertCommand" 
                                    OnUpdateCommand="RadGrid3_UpdateCommand" 
                                    OnEditCommand="RadGrid3_EditCommand" 
                                    OnDeleteCommand="RadGrid3_DeleteCommand"
                                    OnPreRender="RadGrid3_PreRender" 
                                    OnItemCommand="RadGrid3_ItemCommand" 
                                    ShowStatusBar="true">
                                    <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                    <HeaderStyle Font-Size="11px" BackColor="#999999" ForeColor="White" />
                                    <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                                    <MasterTableView CommandItemDisplay="Top" DataKeyNames="sro_code,part_code" Font-Size="11px" EditMode="PopUp" BorderStyle="Solid" 
                                        BorderColor="Silver" BorderWidth="1px" ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >
                                        <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="true" AddNewRecordText="New Item" />
                                        <EditFormSettings >
                                            <FormStyle ForeColor="#006666" Width="500px" Height="250px"  />
                                            <PopUpSettings KeepInScreenBounds="true" Modal="true" Width="400px" />
                                        </EditFormSettings>
                                        <Columns>
                                            <%--<telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                                                <HeaderStyle Width="60px"/>
                                                <ItemStyle Width="60px" />
                                            </telerik:GridEditCommandColumn>--%>
                                            <telerik:GridTemplateColumn HeaderText="Operation" HeaderStyle-Width="100px" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" 
                                                    ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <%--<asp:Label runat="server" ID="lbl_operation" Width="70px" Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'></asp:Label>--%>
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation" EnableLoadOnDemand="True" DataTextField="OprName"
                                                        DataValueField="chart_code" AutoPostBack="true"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'
                                                        HighlightTemplatedItems="true" Height="70px" Width="100px" DropDownWidth="130px"
                                                        OnItemsRequested="cb_operation_inserttTemp_ItemsRequested"
                                                        OnSelectedIndexChanged="cb_operation_SelectedIndexChanged">
                                                    </telerik:RadComboBox>

                                                </ItemTemplate>                                        
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation_editTemp" EnableLoadOnDemand="True" DataTextField="OprName"
                                                        DataValueField="chart_code" AutoPostBack="true"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'
                                                        HighlightTemplatedItems="true" Height="70px" Width="100px" DropDownWidth="130px"
                                                        OnItemsRequested="cb_operation_inserttTemp_ItemsRequested"
                                                        OnSelectedIndexChanged="cb_operation_SelectedIndexChanged">
                                                    </telerik:RadComboBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation_insertTemp" EnableLoadOnDemand="True" AutoPostBack="true"
                                                        HighlightTemplatedItems="true" Height="70px" Width="100px" DropDownWidth="130px"
                                                        OnItemsRequested="cb_operation_inserttTemp_ItemsRequested"
                                                        OnSelectedIndexChanged="cb_operation_SelectedIndexChanged">
                                                    </telerik:RadComboBox>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Opr. Code" HeaderStyle-Width="80px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                                 Visible="true"  ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_operation_code" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "chart_code") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_operation_code_editTemp" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "chart_code") %>'></asp:Label>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_operation_code_insertTemp" Width="50px" ></asp:Label>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                                    ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_prodType" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_prodType_editTemp" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_prodType_insertTemp" Width="50px" ></asp:Label>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Left" >
                                                <ItemTemplate>
                                                    <%--<asp:Label runat="server" ID="lbl_partCode" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>'></asp:Label>--%>
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="spec"
                                                        DataValueField="prod_code" AutoPostBack="true" 
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>' EmptyMessage="- Search product name here -"
                                                        HighlightTemplatedItems="true" Height="190px" Width="150px" DropDownWidth="430px"
                                                        OnItemsRequested="cb_prod_code_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                                        OnPreRender="cb_prod_code_PreRender">                                                  
                                                        <HeaderTemplate>
                                                        <table style="width: 430px; font-size:smaller">
                                                            <tr>     
                                                                <td style="width: 120px;">
                                                                    Prod. Code
                                                                </td> 
                                                                <td style="width: 300px;">
                                                                    Prod. Name
                                                                </td>                                                          
                                                            </tr>
                                                        </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 430px; font-size:smaller">
                                                                <tr>      
                                                                    <td style="width: 120px;">
                                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                                    </td>  
                                                                    <td style="width: 300px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                                    </td>                                                        
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_editTemp" EnableLoadOnDemand="True" DataTextField="spec"
                                                        DataValueField="prod_code" AutoPostBack="true" 
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>' EmptyMessage="- Search product name here -"
                                                        HighlightTemplatedItems="true" Height="150px" Width="100px" DropDownWidth="430px"
                                                        OnItemsRequested="cb_prod_code_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                                        OnPreRender="cb_prod_code_PreRender">                                                  
                                                        <HeaderTemplate>
                                                        <table style="width: 430px; font-size:smaller">
                                                            <tr>     
                                                                <td style="width: 120px;">
                                                                    Prod. Code
                                                                </td> 
                                                                <td style="width: 300px;">
                                                                    Prod. Name
                                                                </td>                                                          
                                                            </tr>
                                                        </table>                                                       
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 430px; font-size:smaller">
                                                                <tr>      
                                                                    <td style="width: 120px;">
                                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                                    </td>  
                                                                    <td style="width: 300px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['spec']")%>
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
                                                        HighlightTemplatedItems="true" Height="190px" Width="150px" DropDownWidth="430px"
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
                                                    <%--<asp:Label runat="server" ID="lbl_qty" Width="70px" Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'>
                                                    </asp:Label>--%>
                                                    <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty" Width="70px" NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                        DbValue='<%# Convert.ToDouble(Eval("part_qty")) %>'
                                                        onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2" >
                                                    </telerik:RadNumericTextBox>
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
                                            <telerik:GridTemplateColumn HeaderText="QRS" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" >
                                                <ItemTemplate>
                                                    <%--<asp:Label runat="server" ID="lbl_qtyRs" Width="70px" Text='<%# DataBinder.Eval(Container.DataItem, "qty_pr", "{0:#,###,###0.00}") %>'>
                                                    </asp:Label>--%>
                                                    <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qtyRs" Width="70px" NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ReadOnlyStyle-HorizontalAlign="Right"
                                                        DbValue='<%# Convert.ToDouble(Eval("qty_pr")) %>'
                                                        onkeydown="blurTextBox(this, event)" ReadOnly="true"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2" >
                                                    </telerik:RadNumericTextBox>
                                                </ItemTemplate>
                                                <EditItemTemplate>                                        
                                                    <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qtyRs_editTemp" Width="70px" NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ReadOnlyStyle-HorizontalAlign="Right"
                                                        DbValue='<%# Convert.ToDouble(Eval("qty_pr")) %>'
                                                        onkeydown="blurTextBox(this, event)" ReadOnly="true"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2" >
                                                    </telerik:RadNumericTextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qtyRs_insertTemp" Width="70px" NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"      ReadOnlyStyle-HorizontalAlign="Right"                                        
                                                        onkeydown="blurTextBox(this, event)" ReadOnly="true"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2" >
                                                    </telerik:RadNumericTextBox>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                                    ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_UoM" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_UoM_editTemp" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_UoM_insertTemp" Width="50px" ></asp:Label>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Waranty" HeaderStyle-Width="50px" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center" 
                                                    HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chk_waranty" Width="50px" 
                                                        Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chk_waranty_editTemp" Width="50px" 
                                                        Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                                                </EditItemTemplate>  
                                                <InsertItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chk_waranty_insertTemp" Enabled="false" Width="50px" />
                                                </InsertItemTemplate>                                      
                                            </telerik:GridTemplateColumn>
                                            <%--<telerik:GridTemplateColumn HeaderText="Delivery Date" HeaderStyle-Width="110px"  ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Center"
                                                HeaderStyle-HorizontalAlign="Center"  >
                                                <ItemTemplate>
                                                    <asp:RequiredFieldValidator runat="server" ID="unitNameValidator" ControlToValidate="dtpDelivDate" ForeColor="Red" 
                                                       Text="*"></asp:RequiredFieldValidator>  
                                                    <telerik:RadDatePicker runat="server" ID="dtpDelivDate" Width="100px"
                                                        DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.deliv_date")%>' 
                                                        onkeydown="blurTextBox(this, event)" Type="Date">
                                                        <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                                    </telerik:RadDatePicker>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>--%> 
                                            <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="180px" ItemStyle-Width="180px" HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <%--<asp:Label runat="server" ID="lbl_remark" Width="220px" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>--%>
                                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark" Width="180px" 
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></telerik:RadTextBox>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_editTemp" Width="180px" 
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></telerik:RadTextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_insertTemp" Width="180px"
                                                    ></telerik:RadTextBox>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>
                                           <%-- <telerik:GridTemplateColumn HeaderText="Run" HeaderStyle-Width="1px" ItemStyle-Width="1px" Visible="false">
                                            <ItemTemplate>                                        
                                                <asp:Label runat="server" ID="lbl_runItem" Width="30px" Text='<%# DataBinder.Eval(Container.DataItem, "run") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>                                        
                                                <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="lbl_runEdit" Width="1px"  ReadOnly="true"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "run") %>'>
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>                                        
                                                <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="lbl_runInsert" Width="1px" ReadOnly="true"
                                                    Text="0">
                                                </telerik:RadTextBox>
                                            </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>--%>
                                            <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                                ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-ForeColor="Red">
                                            </telerik:GridButtonColumn>
                                        </Columns>
                                    </MasterTableView>
                                    <ClientSettings>
                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="154px" />
                                        <Selecting AllowRowSelect="true" />
                                        <ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />
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
