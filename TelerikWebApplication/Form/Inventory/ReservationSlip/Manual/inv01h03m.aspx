<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h03m.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.ReservationSlip.Manual.inv01h03m" %>

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
                window.radopen("inv01h03mReportViewer.aspx?doc_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("inv01h03mEditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("inv01h03mEditForm.aspx?doc_code=" + id, "EditDialogWindows");
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
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <%--<telerik:AjaxUpdatedControl ControlID="RadGrid1" ></telerik:AjaxUpdatedControl>  --%>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2" ></telerik:AjaxUpdatedControl>  
                </UpdatedControls>        
            </telerik:AjaxSetting> 
            
        </AjaxSettings>
    </telerik:RadAjaxManager>

     <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="1000" BackgroundPosition="None" BackColor="Transparent" >
        <img alt="Loading..." src="../../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 115px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="700" BackgroundPosition="None" >
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="2000"></telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone"
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
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight"
                               EnableLoadOnDemand="True"  Skin="Telerik" OnItemsRequested="cb_proj_prm_ItemsRequested"
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
    
    <div style="padding-left: 15px; ">
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
                <td style="width: 94%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:bold">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>    

    <div class="scroller" runat="server">

        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="7" MasterTableView-GridLines="None"
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" OnItemCreated="RadGrid1_ItemCreated" OnPreRender="RadGrid1_PreRender"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced" VerticalAlign="NotSet" PageSizeControlType="None"></PagerStyle>                
                <HeaderStyle CssClass="gridHeader" />
                <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                <SortingSettings EnableSkinSortStyles="false" />
            <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="doc_code" Font-Size="11px"
            EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowRefreshButton="False" CommandItemSettings-ShowAddNewRecordButton="False">
            <SortExpressions >
                <telerik:GridSortExpression FieldName="doc_code" SortOrder="Ascending" />
            </SortExpressions>
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="20px" HeaderStyle-Width="20px">
                        </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn UniqueName="doc_code" HeaderText="RS. No." DataField="doc_code" ItemStyle-Width="110px" FilterControlWidth="100px" ItemStyle-HorizontalAlign="Left">
                        <HeaderStyle Width="140px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn UniqueName="doc_date" HeaderText="Date" DataField="doc_date" ItemStyle-Width="100px"
                        EnableRangeFiltering="false" FilterControlWidth="95px" PickerType="DatePicker"
                        DataFormatString="{0:d}">
                        <HeaderStyle Width="135px"></HeaderStyle>
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn UniqueName="sro_code" HeaderText="Ref Code" DataField="sro_code" ItemStyle-Width="110px" FilterControlWidth="100px" >
                        <HeaderStyle Width="140px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="no_wo" HeaderText="WO Number" DataField="no_wo" ItemStyle-Width="110px" FilterControlWidth="100px" >
                        <HeaderStyle Width="140px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="unit_code" HeaderText="Unit" DataField="unit_code" ItemStyle-Width="110px">
                        <HeaderStyle Width="125px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project" DataField="region_code" ItemStyle-Width="40px"
                        FilterControlWidth="40px">
                        <HeaderStyle Width="80px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="dept_code" HeaderText="Dept. Code" DataField="dept_code" ItemStyle-Width="60px"
                        FilterControlWidth="60px">
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="doc_remark" HeaderText="Remark" DataField="doc_remark" ItemStyle-Wrap="true"
                        ItemStyle-Width="320px" FilterControlWidth="280px">
                        <HeaderStyle Width="320px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" AllowFiltering="False">
                        <ItemTemplate>                                
                            <asp:ImageButton ID="EditLink" runat="server" Height="22px" Width="28px" ImageUrl="~/Images/edit.png" ToolTip="Edit" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Right"
                            AllowFiltering="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete"
                        ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                    </telerik:GridButtonColumn>
                </Columns>

            </MasterTableView>
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="273px" />
                <Selecting AllowRowSelect="true"></Selecting>                    
            </ClientSettings>
        </telerik:RadGrid>

        <div runat="server" style="width: 100%; border-top-width: 1px; border-top-style: inset; padding-top: 5px;"> 
            
            <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
                    AllowPaging="true" AllowSorting="true" runat="server" ShowStatusBar="true"
                    ClientSettings-EnableAlternatingItems="True" ItemStyle-Height="15px" MasterTableView-EditMode="InPlace"
                    OnNeedDataSource="RadGrid2_NeedDataSource" 
                    OnDeleteCommand="RadGrid2_DeleteCommand" 
                    OnInsertCommand="RadGrid2_InsertCommand" 
                    OnUpdateCommand="RadGrid2_InsertCommand" >
                    <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                    <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                    <MasterTableView CommandItemDisplay="Top" DataKeyNames="part_code" Font-Size="11px" EditMode="InPlace"
                        ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item" CommandItemSettings-ShowRefreshButton="False">
                    <Columns>
                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                            HeaderText="Edit" HeaderStyle-Width="30px" ItemStyle-Width="30px" UpdateText="Update" >
                        </telerik:GridEditCommandColumn>
                        <telerik:GridTemplateColumn HeaderText="Type" ItemStyle-Width="30px" HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblProdType" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>' Width="30px"></asp:Label>                                           
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="100px" ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <FooterTemplate>Template footer</FooterTemplate>
                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" /> 
                            <ItemTemplate>    
                                <asp:Label runat="server" ID="lbl_prod_code" Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>'></asp:Label>
                                <telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip1" runat="server" TargetControlID="lbl_prod_code" RelativeTo="Element"
                                Position="BottomCenter" RenderInPageRoot="true">
                                <%# DataBinder.Eval(Container, "DataItem.part_desc")%>                                                
                                </telerik:RadToolTip>
                            </ItemTemplate>
                            <EditItemTemplate>                                 
                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="spec"
                                    DataValueField="Prod_code" AutoPostBack="true"
                                    Text='<%# DataBinder.Eval(Container, "DataItem.part_code") %>' EmptyMessage="- Select product -"
                                    HighlightTemplatedItems="true" Width="130px" DropDownWidth="730px" DropDownAutoWidth="Enabled"
                                    OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                    OnItemsRequested="cb_prod_code_ItemsRequested" >                                                   
                                    <HeaderTemplate>
                                    <table style="width: 730px; font-size:smaller">
                                        <tr>
                                            <td style="width: 350px;">
                                                Prod. Name
                                            </td>     
                                            <td style="width: 120px;">
                                                Prod. Code
                                            </td> 
                                            <td style="width: 60px;">
                                                UoM
                                            </td> 
                                            <td style="width: 120px;">
                                                St. Maint.
                                            </td> 
                                                                                                    
                                        </tr>
                                    </table>                                                       
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table style="width: 730px; font-size:smaller">
                                        <tr>
                                            <td style="width: 350px;">
                                                <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                            </td>        
                                            <td style="width: 120px;">
                                                <%# DataBinder.Eval(Container, "Value")%>
                                            </td> 
                                            <td style="width: 60px;">
                                                <%# DataBinder.Eval(Container, "Attributes['unit']")%>
                                            </td>
                                            <td style="width: 120px;">
                                                <%# DataBinder.Eval(Container, "Attributes['stMainNm']")%>
                                            </td>
                                                                                                                                                         
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                </telerik:RadComboBox>
                                <telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip2" runat="server" TargetControlID="cb_prod_code" RelativeTo="Element"
                                Position="BottomCenter" RenderInPageRoot="true" HideDelay="300" ShowEvent="OnMouseOver">
                                <%# DataBinder.Eval(Container, "DataItem.part_desc")%>                                                
                                </telerik:RadToolTip> 
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="MR Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-HorizontalAlign="Right"  HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblMrQty" Text='<%# DataBinder.Eval(Container.DataItem, "mr_qty", "{0:#,###,###0.00}") %>'></asp:Label>
                            </ItemTemplate>                                        
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="OH Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-HorizontalAlign="Right"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblSoh" Text='<%# DataBinder.Eval(Container.DataItem, "OH_qty", "{0:#,###,###0.00}") %>'></asp:Label>
                            </ItemTemplate>                                        
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Qty Order" HeaderStyle-Width="80px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right" 
                            HeaderStyle-HorizontalAlign="Right" DefaultInsertValue="0"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label RenderMode="Lightweight" runat="server" ID="lblPartQty" Width="70px"  ReadOnly="False" EnabledStyle-HorizontalAlign="Right"
                                    NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'
                                    onkeydown="blurTextBox(this, event)"
                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                    NumberFormat-DecimalDigits="2" ForeColor="#006600" Font-Bold="True" Font-Underline="True">
                                </asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="80px"  ReadOnly="false" EnabledStyle-HorizontalAlign="Right"
                                    NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'
                                    onkeydown="blurTextBox(this, event)"
                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                    NumberFormat-DecimalDigits="2">
                                </telerik:RadTextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                            
                        <telerik:GridTemplateColumn HeaderText="PR Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-HorizontalAlign="Right"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblQtyPr" Text='<%# DataBinder.Eval(Container.DataItem, "QtyPR", "{0:#,###,###0.00}") %>'></asp:Label>
                            </ItemTemplate>                                        
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Supply Qty" HeaderStyle-Width="90px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-HorizontalAlign="Right"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblQtyGi" Text='<%# DataBinder.Eval(Container.DataItem, "QtyGi", "{0:#,###,###0.00}") %>'> </asp:Label>
                            </ItemTemplate>                                        
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="70px" ItemStyle-Width="70px" 
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                            </ItemTemplate>                                        
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Ctr." HeaderStyle-Width="90px" ItemStyle-Width="90px" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblCostCtr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Delivery Date" HeaderStyle-Width="100px"  ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>  
                                <telerik:RadDatePicker runat="server" ID="dtpDelivDate" Width="100px"
                                    DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.deliv_date")%>' 
                                    onkeydown="blurTextBox(this, event)" Type="Date">
                                    <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                </telerik:RadDatePicker>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn> 
                            
                        <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="200px" HeaderStyle-Width="190px" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblRemark" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="300px"
                                    Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                </telerik:RadTextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow"
                            ButtonType="FontIconButton" ItemStyle-Width="30px" HeaderStyle-Width="30px" HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                        </telerik:GridButtonColumn>

                    </Columns>
                </MasterTableView>
                <ClientSettings >
                    <Scrolling AllowScroll="false" UseStaticHeaders="True" ScrollHeight="185px" />  
                    <Selecting AllowRowSelect="true"></Selecting>                          
                </ClientSettings>
                </telerik:RadGrid>
                <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data tersimpan" Position="BottomRight"
                    AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
                </telerik:RadNotification>
                </ContentTemplate>
            </asp:UpdatePanel>
                 
        </div>

        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1150px" Height="670px" Modal="true" AutoSize="True">
                </telerik:RadWindow>
                <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="700px" Height="720px" Modal="true" AutoSize="False">
                </telerik:RadWindow>
                
            </Windows>
        </telerik:RadWindowManager>
        
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
        
    </div>
</asp:Content>
