<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TelerikWebApplication.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/mail.css" rel="stylesheet" />
    <link href="Styles/common.css" rel="stylesheet" />
    <link href="Styles/styles.css" rel="stylesheet" />
    <script src="Script/Script.js"></script>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
       
        <script type="text/javascript">            

            function ShowURPreview(id) {
                window.radopen("../Form/Inventory/UserRequest/reportViewer.aspx?doc_code=" + id, "PreviewDialog");
                return false;
            }

            function ShowMRPreview(id) {
                window.radopen("../Form/Preventive_maintenance/MaterialRequest/inv01h02_ReportViewer.aspx?doc_code=" + id, "PreviewDialog");
                return false;
            }

            function ShowRSPreview(id) {
                window.radopen("../Form/Inventory/ReservationSlip/Manual/inv01h03mReportViewer.aspx?doc_code=" + id, "PreviewDialog");
                return false;
            }

            function ShowPRPreview(id) {
                window.radopen("../Form/Purchase/PurchaseReq/TypeA/pur01h01aReportViewer.aspx?pr_code=" + id, "PreviewDialog");
                return false;
            }

            function ShowPOPreview(id) {
                window.radopen("../Form/Purchase/Purchase_order/reportViewer.aspx?po_code=" + id, "PreviewDialog");
                return false;
            }

            function ShowGRPreview(id) {
                window.radopen("../Form/Inventory/GoodReceive/Standard/inv01h04ReportViewer.aspx?lbm_code=" + id, "PreviewDialog");
                return false;
            }

            function ShowGIPreview(id) {
                window.radopen("../Form/Inventory/GoodsIssued/ReportViewer_inv01h05.aspx?do_code=" + id, "PreviewDialog");
                return false;
            }


            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }            
           
        </script>
    </telerik:RadCodeBlock>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%--<telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rbConfigureAnimations">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadTileList1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>--%>

    <div runat="server" class="scroller" style=" overflow:auto; height:665px; padding: 0px 10px 45px 0px;"> 
        <div runat="server" style="padding: 50px 0px 50px 150px; width:83%">
            <div style="background-color:transparent;padding: 0px 0px 40px 0px" >
                <telerik:RadTileList RenderMode="Lightweight" runat="server" ID="RadTileList1" ScrollingMode="None" Width="100%"
                
                    SelectionMode="None" EnableDragAndDrop="true">
                    <Groups>
                        <telerik:TileGroup Title="Prima Modules">
                            <telerik:RadImageTile runat="server" Name="PreventiveMaintenance" ImageUrl="~/Images/preventive.png" Shape="Square"
                                NavigateUrl="~/Form/Preventive_maintenance/Default.aspx" Target="_parent" 
                                ImageWidth="120px" ImageHeight="120px" Skin="Silk" Width="200px" Height="200px" ForeColor="Highlight"  Font-Size="Medium" BackColor="White">
                                <Title Text="Preventive Maintenance"></Title>
                                <PeekTemplateSettings AnimationDuration="900" ShowInterval="4000" CloseDelay="7000"
                                    Animation="Slide" Easing="easeInQuint" ShowPeekTemplateOnMouseOver="true" HidePeekTemplateOnMouseOut="true" />
                            </telerik:RadImageTile>
                            <telerik:RadImageTile runat="server" Name="Inventory" ImageUrl="~/Images/warehouse.jpg" Shape="Square"
                                NavigateUrl="~/Form/Inventory/Default.aspx" Target="_parent" 
                                ImageWidth="120px" ImageHeight="120px" Skin="Silk" Width="200px" Height="200px" ForeColor="Darkorange"  Font-Size="Medium" BackColor="White">
                                <Title Text="Inventory"></Title>
                                <PeekTemplateSettings AnimationDuration="700" ShowInterval="5000" CloseDelay="4000"
                                    Animation="Fade" Easing="easeInQuint" ShowPeekTemplateOnMouseOver="true" HidePeekTemplateOnMouseOut="true" />
                            </telerik:RadImageTile>
                            <telerik:RadImageTile runat="server" Name="Purchase" ImageUrl="~/Images/purchasing.png" Shape="Square"
                                NavigateUrl="~/Form/Purchase/Default.aspx" Target="_parent" 
                                ImageWidth="120px" ImageHeight="120px" Skin="Silk" Width="200px" Height="200px" ForeColor="YellowGreen"  Font-Size="Medium" BackColor="White">
                                <Title Text="Purchase"></Title>
                                <PeekTemplateSettings AnimationDuration="600" ShowInterval="3000" CloseDelay="10000"
                                    Animation="Resize" Easing="easeInExpo" ShowPeekTemplateOnMouseOver="true" HidePeekTemplateOnMouseOut="true" />
                            </telerik:RadImageTile>
                            <telerik:RadImageTile runat="server" Name="Fico" ImageUrl="~/Images/calculator.jpg" Shape="Square"
                                NavigateUrl="~/Form/Fico/Default.aspx" Target="_parent" 
                                ImageWidth="120px" ImageHeight="120px" Skin="Silk" Width="200px" Height="200px" ForeColor="YellowGreen"  Font-Size="Medium" BackColor="White">
                                <Title Text="Fico"></Title>
                                <PeekTemplateSettings AnimationDuration="800" ShowInterval="5000" CloseDelay="6000"
                                    Animation="Slide" Easing="easeInOutBack" ShowPeekTemplateOnMouseOver="true" HidePeekTemplateOnMouseOut="true" />
                            </telerik:RadImageTile>
                            <telerik:RadImageTile runat="server" Name="Production" ImageUrl="~/Images/production.jpg" Shape="Square"
                                NavigateUrl="~/Form/Production/Default.aspx" Target="_parent" 
                                ImageWidth="120px" ImageHeight="120px" Skin="Silk" Width="200px" Height="200px" ForeColor="YellowGreen"  Font-Size="Medium" BackColor="White">
                                <Title Text="Production"></Title>
                                <PeekTemplateSettings AnimationDuration="400" ShowInterval="4000" CloseDelay="6000"
                                    Animation="Fade" Easing="swing" ShowPeekTemplateOnMouseOver="true" HidePeekTemplateOnMouseOut="true" />
                            </telerik:RadImageTile>
                            <telerik:RadImageTile runat="server" Name="Sales" ImageUrl="~/Images/sales.jpg" Shape="Square"
                                NavigateUrl="~/Form/Sales/Default.aspx" Target="_parent" 
                                ImageWidth="120px" ImageHeight="120px" Skin="Silk" Width="200px" Height="200px" ForeColor="YellowGreen"  Font-Size="Medium" BackColor="White">
                                <Title Text="Sales"></Title>
                                <PeekTemplateSettings AnimationDuration="850" ShowInterval="7000" CloseDelay="7000"
                                    Animation="Slide" Easing="easeInQuad" ShowPeekTemplateOnMouseOver="true" HidePeekTemplateOnMouseOut="true" />
                            </telerik:RadImageTile>                        
                            <telerik:RadImageTile runat="server" Name="Reports" ImageUrl="~/Images/reports.png" Shape="Square"
                                NavigateUrl="~/Form/Reports/ReportDashboard.aspx" Target="_parent" 
                                ImageWidth="120px" ImageHeight="120px" Skin="Silk" Width="200px" Height="200px" ForeColor="YellowGreen"  Font-Size="Medium" BackColor="White">
                                <Title Text="Reports"></Title>
                                <PeekTemplateSettings AnimationDuration="530" ShowInterval="7000" CloseDelay="7000"
                                    Animation="Slide" Easing="easeInQuad" ShowPeekTemplateOnMouseOver="true" HidePeekTemplateOnMouseOut="true" />
                            </telerik:RadImageTile>                        
                            <telerik:RadImageTile runat="server" Name="DataStore" ImageUrl="~/Images/data.png" Shape="Square"
                                NavigateUrl="~/Form/DataStore/Default.aspx" Target="_parent" 
                                ImageWidth="120px" ImageHeight="120px" Skin="Silk" Width="200px" Height="200px" ForeColor="YellowGreen"  Font-Size="Medium" BackColor="White">
                                <Title Text="Data Store"></Title>
                                <PeekTemplateSettings AnimationDuration="723" ShowInterval="7000" CloseDelay="7000"
                                    Animation="Slide" Easing="easeInQuad" ShowPeekTemplateOnMouseOver="true" HidePeekTemplateOnMouseOut="true" />
                            </telerik:RadImageTile>
                            <telerik:RadImageTile runat="server" Name="Security" ImageUrl="~/Images/security.png" Shape="Square"
                                NavigateUrl="~/Form/Security/Default.aspx" Target="_parent" 
                                ImageWidth="170px" ImageHeight="120px" Skin="Silk" Width="200px" Height="200px" ForeColor="YellowGreen"  Font-Size="Medium" BackColor="White">
                                <Title Text="Security"></Title>
                                <PeekTemplateSettings AnimationDuration="450" ShowInterval="7000" CloseDelay="7000"
                                    Animation="Resize" Easing="easeInQuad" ShowPeekTemplateOnMouseOver="true" HidePeekTemplateOnMouseOut="true" />
                            </telerik:RadImageTile>
                        </telerik:TileGroup>
                    </Groups>
                </telerik:RadTileList>
            </div>

            <div style="margin-bottom:50px; padding: 0px 0px 50px 0px">
            
                <table>
                    <tr>
                        <td style="width:95%">
                            <telerik:RadLabel ID="RadLabel2" Text="Some documents need your review" runat="server" Skin="Silk" Width="100%" 
                                Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:deepskyblue;" >
                                </telerik:RadLabel>
                        </td>
                        <td>                        
                            <asp:CheckBox runat="server" ID="chk_all" Checked="false" OnCheckedChanged="chk_all_CheckedChanged" Text="View All" 
                            TextAlign="Right" AutoPostBack="true" /> 
                        </td>
                    </tr>
                </table>
              
                <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" ShowFooter="false" Skin="Silk" CssClass="RadGrid_ModernBrowsers" 
                    AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="10" MasterTableView-GridLines="None" BorderStyle="None"
                        OnItemCreated="RadGrid1_ItemCreated" 
                        OnNeedDataSource="RadGrid1_NeedDataSource" >
                        <PagerStyle Mode="NextPrevNumericAndAdvanced" VerticalAlign="NotSet" ></PagerStyle>                
                        <HeaderStyle CssClass="gridHeader" />
                        <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                        <SortingSettings EnableSkinSortStyles="false" />
                        <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="tr_no,kode" Font-Size="12px" 
                            HeaderStyle-Font-Size="11px" HeaderStyle-BorderColor="Teal" HeaderStyle-BorderStyle="None"
                            EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="false" CommandItemSettings-ShowAddNewRecordButton="false"
                            HeaderStyle-ForeColor="Teal" HeaderStyle-Font-Bold="true"  CommandItemSettings-ShowRefreshButton="false" >
                            <ColumnGroups>
                                <telerik:GridColumnGroup HeaderText="Approval" HeaderStyle-BorderColor="Teal" Name="grp_approve" HeaderStyle-HorizontalAlign="Center"></telerik:GridColumnGroup>
                            </ColumnGroups>
                            <Columns>
                                <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="30px" ></telerik:GridClientSelectColumn> 
                                <telerik:GridBoundColumn UniqueName="kode" HeaderText="kode" DataField="kode" Visible="false">
                                    <HeaderStyle Width="30px"></HeaderStyle>
                                    <ItemStyle Width="30px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn UniqueName="tr_no" HeaderText="Doc. Number" DataField="tr_no">
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle Width="100px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridDateTimeColumn UniqueName="tr_date" HeaderText="Date" DataField="tr_date" ItemStyle-Width="80px" 
                                    EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                                    DataFormatString="{0:d}" >
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle Width="80px" />
                                </telerik:GridDateTimeColumn>
                                <telerik:GridBoundColumn UniqueName="remark" HeaderText="Description" DataField="remark">
                                    <HeaderStyle Width="350px"></HeaderStyle>
                                    <ItemStyle Width="350px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project" DataField="region_code" 
                                    FilterControlWidth="40px" >
                                    <HeaderStyle Width="40px"></HeaderStyle>
                                    <ItemStyle Width="40px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn HeaderText="Create" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center" 
                               HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="edt_chkApv1" Checked='<%# DataBinder.Eval(Container.DataItem, "bool_apv1") %>' Enabled="false"/>
                                </ItemTemplate>                                        
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Verify" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center"
                                  HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="edt_chkApv2" Checked='<%# DataBinder.Eval(Container.DataItem, "bool_apv2") %>' Enabled="false"/>
                                </ItemTemplate>
                                                                               
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Approve" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center"
                                 HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="edt_chkApv3" Checked='<%# DataBinder.Eval(Container.DataItem, "bool_apv3") %>'  Enabled="false"/>
                                </ItemTemplate>                                       
                            </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="TemplateViewColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Left"
                                    AllowFiltering="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ViewLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/view-file.png" ToolTip="Print" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                        <ClientSettings>                         
                            <Selecting AllowRowSelect="true" ></Selecting>
                            <ClientEvents OnRowDblClick="RowDblClick" />
                        </ClientSettings>
                    </telerik:RadGrid>
               
            </div>
            
        </div>
        
        <div style="background-color:transparent;padding: 0px 0px 0px 150px; float:left;width:45%" >
            <telerik:RadHtmlChart runat="server" ID="SplineChart" Width="600" Skin="Silk">
                <ChartTitle Text="Spline Chart"></ChartTitle>
            </telerik:RadHtmlChart>
        </div>

    </div>
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                Width="1150px" Height="670px" Modal="false" AutoSize="True">
            </telerik:RadWindow>               
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>
