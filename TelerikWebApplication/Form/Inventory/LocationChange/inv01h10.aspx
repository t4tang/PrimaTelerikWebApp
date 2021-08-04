<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h10.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.LocationChange.inv01h10" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />    
    <script type="text/javascript" src="../../../Script/Script.js" ></script>
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
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting><telerik:AjaxSetting AjaxControlID="cb_project">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_cost_center" ></telerik:AjaxUpdatedControl>
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
                                    EnableLoadOnDemand="True"  Skin="Silk" 
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%"
                                    OnItemsRequested="cb_proj_prm_ItemsRequested"
                                    OnSelectedIndexChanged="cb_proj_prm_SelectedIndexChanged">
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
                        padding-bottom: 0px; font-size: x-large; color:yellowgreen;">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

    <div class="scroller" runat="server" style="overflow-y:scroll; height:620px;" > 

        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" PageSize="14" ShowFooter="false" Skin="Silk"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" MasterTableView-GridLines="None" CssClass="RadGrid_ModernBrowsers"
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
                        <telerik:GridDateTimeColumn UniqueName="tr_date" HeaderText="Date" DataField="tr_date" ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Left"
                            EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker"
                            DataFormatString="{0:d}">
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>                        
                        <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project" DataField="region_name" ItemStyle-HorizontalAlign="Left"
                            ItemStyle-Width="250px" FilterControlWidth="230px">
                            <HeaderStyle Width="250px"></HeaderStyle>
                        </telerik:GridBoundColumn>    
                        <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                            ItemStyle-Width="550px" AllowFiltering="false">
                            <HeaderStyle Width="550px"></HeaderStyle>
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
                                                        <telerik:RadTextBox ID="txt_tr_code" runat="server" Width="300px" ReadOnly="true"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.tr_code") %>' 
                                                            RenderMode="Lightweight" Font-Size="Small">
                                                        </telerik:RadTextBox>
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
                                                <tr>
                                                    <td >
                                                        <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel> 
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_project" ForeColor="Red" 
                                                            Font-Size="X-Small"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <td/>
                                                    <td>                          
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" AutoPostBack="true"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>'  
                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk" EnableVirtualScrolling="true"
                                                            OnItemsRequested="cb_project_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_project_SelectedIndexChanged" 
                                                            OnPreRender="cb_project_PreRender">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td >
                                                        <telerik:RadLabel runat="server" Text="Warehouse :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel> 
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="cb_project" ForeColor="Red" 
                                                            Font-Size="X-Small"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <td/>
                                                    <td>                          
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="300"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.wh_name") %>'  
                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk" EnableVirtualScrolling="true"
                                                            OnItemsRequested="cb_warehouse_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged"
                                                            OnPreRender="cb_warehouse_PreRender" >
                                                        </telerik:RadComboBox>
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
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Prepared By :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox ID="cb_prepare_by" runat="server" Width="300px" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.crtByName") %>'  
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
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.chkByName") %>'  
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
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.appByName") %>'  
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
                                        </td>
                                    </tr>                                             
                                </table>
                                <div style="padding: 7px 0px 12px 0px; min-height:275px">
                                    <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="97%" 
                                    SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Silk" CausesValidation="false">
                                        <Tabs>
                                            <telerik:RadTab Text="Transaction Data" Height="15px"> 
                                            </telerik:RadTab>
                                            <telerik:RadTab Text="Text" Height="15px" Width="130px">
                                            </telerik:RadTab>
                                        </Tabs>
                                    </telerik:RadTabStrip>
                                    <telerik:RadMultiPage runat="server" ID="RadMultiPage1"  SelectedIndex="0" Width="97%" >
                                        <telerik:RadPageView runat="server" ID="RadPageView1" Height="300px">
                                            <div runat="server" style="padding:10px 10px 10px 10px">
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
                                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="tr_code,prod_code" Font-Size="11px" EditMode="InPlace"
                                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" InsertItemDisplay="Bottom" >                                             
                                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                                        
                                                    <Columns>   
                                                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                                            HeaderText="Edit" HeaderStyle-Width="60px" ItemStyle-Width="60px" UpdateText="Update">
                                                        </telerik:GridEditCommandColumn>                   
                                             
                                                        <telerik:GridTemplateColumn UniqueName="prod_code" HeaderText="Product Code" HeaderStyle-Width="120px"
                                                            SortExpression="prod_code" ItemStyle-Width="120px">
                                                            <FooterTemplate>Template footer</FooterTemplate>
                                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                                            <ItemTemplate> 
                                                                <asp:Label ID="lbl_prod_code" Width="120px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="spec"
                                                                    OnItemsRequested="cb_prod_code_ItemsRequested" DataValueField="prod_code" AutoPostBack="true"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>'
                                                                    HighlightTemplatedItems="true" Height="190px" Width="120px" DropDownWidth="430px"
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
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_insert" EnableLoadOnDemand="True" DataTextField="spec"
                                                                    OnItemsRequested="cb_prod_code_ItemsRequested" DataValueField="prod_code" AutoPostBack="true"
                                                                    HighlightTemplatedItems="true" Height="190px" Width="120px" DropDownWidth="430px"
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
                            
                                                        <telerik:GridTemplateColumn HeaderText="Original Loc"  HeaderStyle-Width="100px" ItemStyle-Width="100px">
                                                            <ItemTemplate> 
                                                                <asp:Label ID="lbl_ori_loc" Width="100px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ori_loc") %>' ></asp:Label> 
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:Label ID="lbl_ori_loc_edit" Width="100px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ori_loc") %>' ></asp:Label> 
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <asp:Label ID="lbl_ori_loc_insert" Width="100px" runat="server" ></asp:Label> 
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn> 

                                                        <telerik:GridTemplateColumn HeaderText="Destination Loc"  HeaderStyle-Width="100px" ItemStyle-Width="100px">
                                                            <ItemTemplate> 
                                                                <asp:Label ID="lbl_dest_loc" Width="100px" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dest_loc") %>' ></asp:Label> 
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cb_dest_loc" Width="100px" Skin="Telerik"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "dest_loc") %>'
                                                                    EnableLoadOnDemand="True" EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"  
                                                                    DataTextField="kolok" DataValueField="kolok" OnItemsRequested="cb_des_loc_ItemsRequested">
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cb_dest_loc_insert" Width="100px" Skin="Telerik"
                                                                    EnableLoadOnDemand="True" EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"  
                                                                    DataTextField="kolok" DataValueField="kolok" OnItemsRequested="cb_des_loc_ItemsRequested">
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn> 

                                                        <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="100px" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right" 
                                                            HeaderStyle-HorizontalAlign="Center" DefaultInsertValue="0">
                                                            <ItemTemplate> 
                                                                <asp:Label ID="lbl_qty" Width="100px" runat="server" CssClass="detailItem" Text='<%# DataBinder.Eval(Container, "DataItem.qty", "{0:#,###,###0.00}") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty" Width="100px" NumberFormat-AllowRounding="true"
                                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "qty", "{0:#,###,###0.00}") %>'
                                                                    onkeydown="blurTextBox(this, event)"
                                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                                    NumberFormat-DecimalDigits="2" >
                                                                </telerik:RadNumericTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty_insert" Width="100px" NumberFormat-AllowRounding="true"
                                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                    onkeydown="blurTextBox(this, event)"
                                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                                    NumberFormat-DecimalDigits="2" >
                                                                </telerik:RadNumericTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn> 

                                                        <telerik:GridTemplateColumn HeaderText="UoM"  HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" >
                                                            <ItemTemplate>   
                                                                <asp:Label ID="lbl_uom_d" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.uom") %>' ></asp:Label> 
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="70px" runat="server" ID="cb_uom_d"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.uom") %>'
                                                                    EnableLoadOnDemand="True" Skin="Silk"  DataTextField="part_unit" DataValueField="part_unit" >
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="70px" runat="server" ID="cb_uom_d_insert"
                                                                    EnableLoadOnDemand="True" Skin="Silk"  DataTextField="part_unit" DataValueField="part_unit" >
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="SOH" HeaderStyle-Width="100px" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right" 
                                                            HeaderStyle-HorizontalAlign="Center" DefaultInsertValue="0">
                                                            <ItemTemplate> 
                                                                <asp:Label ID="lbl_soh" Width="100px" runat="server" CssClass="detailItem" Text='<%# DataBinder.Eval(Container, "DataItem.soh", "{0:#,###,###0.00}") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_soh" Width="100px" NumberFormat-AllowRounding="true"
                                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "soh", "{0:#,###,###0.00}") %>' ReadOnly="true"
                                                                    onkeydown="blurTextBox(this, event)"
                                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                                    NumberFormat-DecimalDigits="2" >
                                                                </telerik:RadNumericTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_soh_insert" Width="100px" NumberFormat-AllowRounding="true"
                                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                    ReadOnly="true"
                                                                    onkeydown="blurTextBox(this, event)"
                                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                                    NumberFormat-DecimalDigits="2" >
                                                                </telerik:RadNumericTextBox>
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
                                        </telerik:RadPageView>
                                        <telerik:RadPageView runat="server" ID="RadPageView4" Height="300px">
                                            <div runat="server" style="padding:15px 15px 15px 15px">
                                                <table>
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
