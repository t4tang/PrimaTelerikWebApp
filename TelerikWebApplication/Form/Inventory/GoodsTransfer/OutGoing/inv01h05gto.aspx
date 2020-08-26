<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h05gto.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.GoodsTransfer.OutGoing.inv01h05gto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server" >
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("inv01h05gtoReportViewer.aspx?do_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("inv01h05gtoEditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("inv01h05gtoEditForm.aspx?do_code=" + id, "EditDialogWindows");
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
     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
         <ContentTemplate>
             <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
             <nav:MobileNavigation runat="server" ID="MobileNavigation" />
         </ContentTemplate>
     </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest" >
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2" />
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

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone" Modal="true" VisibleStatusbar="false" AutoSize="true" 
        Width="450px" Height="350px" >
        <ContentTemplate>
            <div id="Div2" runat="server" style="padding: 20px 10px 10px 10px;" >
                <table>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Date From" CssClass="lbObject" ForeColor="Black" ></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Skin="Telerik" DateInput-ReadOnly="false" 
                                DateInput-DateFormat="dd/MM/yyyy" Width="200px" ></telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Date To" CssClass="lbObject" ForeColor="Black" ></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Skin="Telerik" DateInput-ReadOnly="false" 
                                DateInput-DateFormat="dd/MM/yyyy" Width="200px" ></telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000" ></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true" 
                                EnableVirtualScrolling="true" ChangeTextOnKeyBoardNavigation="false" Filter="Contains" MarkFirstMatch="true" Width="320px" 
                                OnItemsRequested="cb_proj_prm_ItemsRequested" OnSelectedIndexChanged="cb_proj_prm_SelectedIndexChanged" ></telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr style="height:50px">
                        <td>
                            <asp:Button ID="btnSearch" runat="server" Text="Filter" BackColor="#FF6600" ForeColor="White" BorderStyle="None" Width="120px" 
                                Height="25px" OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div style="padding-left: 15px; width: 100%; ">
        <table id="tbl_control">
            <tr>                  
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClientClick="ShowInsertForm(); return false;" ToolTip="Add New"
                        Height="30px" Width="32px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 13px">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="28px" Width="28px" ImageUrl="~/Images/filter1.png"></asp:ImageButton>
                </td>
                <td style="width: 93%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:bold">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik" AllowSorting="True" 
            AutoGenerateColumns="False" ShowStatusBar="true" PageSize="5" MasterTableView-GridLines="None" OnNeedDataSource="RadGrid1_NeedDataSource" 
            OnDeleteCommand="RadGrid1_DeleteCommand" OnItemCreated="RadGrid1_ItemCreated" OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" >
            <PagerStyle Mode="Slider" VerticalAlign="NotSet" PageSizeControlType="RadComboBox" />
            <HeaderStyle CssClass="gridHeader" BorderStyle="Solid" Width="1px" />
            <ClientSettings EnablePostBackOnRowClick="true" ></ClientSettings>
            <SortingSettings EnableSkinSortStyles="false" />
            <MasterTableView Width="100%" Height="90%" CommandItemDisplay="Top" DataKeyNames="do_code" Font-Size="11px" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" 
                AllowFilteringByColumn="true" CommandItemSettings-ShowRefreshButton="False" CommandItemSettings-ShowAddNewRecordButton="False" >
                <SortExpressions>
                    <telerik:GridSortExpression FieldName="do_code" SortOrder="Ascending" />
                </SortExpressions>
                <ColumnGroups>
                    <telerik:GridColumnGroup HeaderText="Project" Name="ProjectGroup" HeaderStyle-HorizontalAlign="Center" ></telerik:GridColumnGroup>
                    <telerik:GridColumnGroup HeaderText="Storage" Name="StorageGroup" HeaderStyle-HorizontalAlign="Center" ></telerik:GridColumnGroup>
                </ColumnGroups>
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="50px" HeaderStyle-Width="50px"></telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn UniqueName="do_code" HeaderText="Reg. No." DataField="do_code" ItemStyle-Width="100px" FilterControlWidth="90px" 
                        ItemStyle-HorizontalAlign="Left" HeaderStyle-ForeColor="Highlight">
                        <HeaderStyle Width="120px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn UniqueName="Tgl" HeaderText="Date" DataField="Tgl" ItemStyle-Width="80px"
                        EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker"
                        DataFormatString="{0:d}">
                        <HeaderStyle Width="80px" ForeColor="Highlight"></HeaderStyle>
                    </telerik:GridDateTimeColumn>
                    <%--<telerik:GridBoundColumn UniqueName="ref_code" HeaderText="Reference" DataField="ref_code" ItemStyle-Width="40px"
                        FilterControlWidth="40px">
                        <HeaderStyle Width="80px" ForeColor="Highlight"></HeaderStyle>
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn UniqueName="region_code" HeaderText="From" DataField="region_code" ColumnGroupName="ProjectGroup" 
                         FilterControlWidth="80px">
                        <HeaderStyle Width="60px" ForeColor="Highlight"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="to_region_code" HeaderText="To" DataField="to_region_code" ColumnGroupName="ProjectGroup" FilterControlWidth="80px">
                        <HeaderStyle Width="60px" ForeColor="Highlight"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="dept_code" HeaderText="Cost Ctr" DataField="dept_code" FilterControlWidth="80px">
                        <HeaderStyle Width="60px" ForeColor="Highlight"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="wh_code" HeaderText="From" DataField="wh_code" ColumnGroupName="StorageGroup" FilterControlWidth="80px">
                        <HeaderStyle Width="60px" ForeColor="Highlight"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="to_wh_code" HeaderText="To" DataField="to_wh_code" ColumnGroupName="StorageGroup" FilterControlWidth="80px">
                        <HeaderStyle Width="60px" ForeColor="Highlight"></HeaderStyle>
                    </telerik:GridBoundColumn>                       
                    <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                        ItemStyle-Width="420px" FilterControlWidth="400px">
                        <HeaderStyle Width="450px" ForeColor="Highlight"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" AllowFiltering="False">
                        <ItemTemplate>                                
                            <asp:ImageButton ID="EditLink" runat="server" Height="22px" Width="25px" ImageUrl="~/Images/edit.png" ToolTip="Edit" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Right"
                            AllowFiltering="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" 
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px" HeaderStyle-Width="50px"
                        ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="200px" />
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
        </telerik:RadGrid>

        <div runat="server" style="width: 100%; border-top-color:yellowgreen; border-top-width: 1px; border-top-style: inset; padding-top: 8px;height:250px; overflow-y:auto; overflow-x:hidden">
            <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Conditional" >
                <ContentTemplate>
                    <telerik:RadGrid ID="RadGrid2" runat="server" RenderMode="Lightweight" AllowSorting="true" AllowPaging="true" AutoGenerateColumns="false" 
                        ClientSettings-Selecting-AllowRowSelect="true" 
                        GridLines="None" PageSize="5" Skin="Telerik" ShowStatusBar="true" OnNeedDataSource="RadGrid2_NeedDataSource" OnDeleteCommand="RadGrid2_DeleteCommand" 
                        OnInsertCommand="RadGrid2_InsertCommand" OnUpdateCommand="RadGrid2_InsertCommand"
                        >
                        <PagerStyle Mode="NumericPages" PageButtonCount="4" />
                        <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                        <MasterTableView Width="100%" Height="80%" AutoGenerateColumns="false" CommandItemDisplay="Top" DataKeyNames="prod_code" EditMode="InPlace" Font-Size="11px" ShowHeadersWhenNoRecords="true" 
                            CommandItemSettings-AddNewRecordText="New Item" CommandItemSettings-ShowRefreshButton="false" >
                            <ColumnGroups >
                                <telerik:GridColumnGroup HeaderText="Qty" Name="QtyGroup" HeaderStyle-HorizontalAlign="Center"></telerik:GridColumnGroup>
                            </ColumnGroups>
                            <Columns>
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                    HeaderText="Edit" HeaderStyle-Width="30px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn HeaderText="Material Code" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center" 
                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center" ItemStyle-Height="50px">
                                    <ItemTemplate>    
                                        <asp:Label runat="server" ID="lbl_prod_code" Text='<%# DataBinder.Eval(Container.DataItem, "prod_code") %>'></asp:Label>
                                        <telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip1" runat="server" TargetControlID="lbl_prod_code" RelativeTo="Element"
                                             Position="BottomCenter" RenderInPageRoot="true">                                                
                                        </telerik:RadToolTip>
                                    </ItemTemplate>
                                    <EditItemTemplate>                                 
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="spec"
                                            DataValueField="Prod_code" AutoPostBack="true"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>' EmptyMessage="- Select product -"
                                            HighlightTemplatedItems="true" Width="130px" DropDownWidth="800px" DropDownAutoWidth="Enabled"
                                            OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                            OnItemsRequested="cb_prod_code_ItemsRequested" >                                                   
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
                                        <telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip2" runat="server" TargetControlID="cb_prod_code" RelativeTo="Element"
                                            Position="BottomCenter" RenderInPageRoot="true" HideDelay="300" ShowEvent="OnMouseOver">                                                
                                        </telerik:RadToolTip> 
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Superior" HeaderStyle-Width="150px" ItemStyle-Width="150px"
                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblSuperior"></asp:Label>
                                    </ItemTemplate>                                        
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Send" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center" ColumnGroupName="QtyGroup" 
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
                                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_QtyOut" Width="80px"  ReadOnly="false" EnabledStyle-HorizontalAlign="Right"
                                            NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            Text='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                            onkeydown="blurTextBox(this, event)"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2">
                                        </telerik:RadNumericTextBox>
                                    </EditItemTemplate>                                        
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Receipt" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center" ColumnGroupName="QtyGroup"
                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <telerik:RadTextBox ID="txt_QtyRec" runat="server" RenderMode="Lightweight" Width="70px"  ReadOnly="false" EnabledStyle-HorizontalAlign="Right" 
                                            NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                            onkeydown="blurTextBox(this, event)" AutoPostBack="true" MaxLength="11" 
                                            Type="Number" NumberFormat-DecimalDigits="2" >
                                        </telerik:RadTextBox>
                                    </ItemTemplate>                                        
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" Width="70px" ID="txt_uom" Text='<%# DataBinder.Eval(Container.DataItem, "unit_code") %>'>
                                        </telerik:RadTextBox>
                                        <%--<asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "unit_code") %>'></asp:Label>--%>
                                    </ItemTemplate>                                        
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="250px" ItemStyle-Width="250px"
                                    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="250px"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                        </telerik:RadTextBox>
                                    </ItemTemplate>
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
                    <telerik:RadNotification ID="notif" runat="server" RenderMode="Lightweight" Text="Data Tersimpan" Position="BottomRight" 
                        AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
                    </telerik:RadNotification>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server" RenderMode="Lightweight" EnableShadow="true" >
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1150px" Height="670px" Modal="true" AutoSize="True">
                </telerik:RadWindow>
                <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="700px" Height="720px" Modal="true" AutoSize="False">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>

        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true"></telerik:RadWindowManager>
    </div>   
</asp:Content>
