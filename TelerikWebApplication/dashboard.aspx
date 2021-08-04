<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="TelerikWebApplication.dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/common.css" rel="stylesheet" />
    <link href="Styles/mail.css" rel="stylesheet" />

    <script src="Script/Script.js"></script>
    <link href="Styles/mail.css" rel="stylesheet" />

    <script>  
    var name = "#floatDiv";  
    var menuYloc = null;  
    $(document).ready(function () {  
        menuYloc = parseInt($(name).css("top").substring(0, $(name).css("top").indexOf("px")))  
        $(window).scroll(function () {  
            offset = menuYloc + $(document).scrollTop() + "px";  
            $(name).animate({ top: offset }, { duration: 500, queue: false });  
        });  
    });  
    </script> 
    
    <style>		
        #floatDiv {  
            position: absolute;  
            top: 45px;  
            /*margin-left: 285px;*/
            /*margin: 15px 45px 15px 45px;*/
            /*width: 100%;*/  
            height: 70px;  
            /*border: 1px solid black;      
            float:right;
            border-style:inset;
            border-width:1px; 
            border-color:Highlight;*/
            background-color:transparent;
        }  
	</style>

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
    
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" ></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chk_all">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <div runat="server" class="scroller" style=" overflow:auto; height:700px; padding-bottom:45px">        
       
        <div id="floatDiv" >
                            
        </div>

        <div style="background-color:transparent;padding:75px 75px 0px 200px;" >
             <table>
                    <tr>
                        <td style="width:120px;text-align:center">
                            <asp:ImageButton ID="btn_prev_mtc" runat="server" ImageUrl="~/Images/preventive.png" Height="75px" Width="75px" 
                                OnClick="btn_prev_mtc_Click" /><br />
                            <telerik:RadLabel ID="RadLabel11" Text="Maintenance" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:orangered;" >
                            </telerik:RadLabel>
                        </td>
                        <td style="width:120px;text-align:center">
                            <asp:ImageButton ID="btn_inventory" runat="server" ImageUrl="~/Images/warehouse.jpg" Height="75px" Width="75px"
                                OnClick="btn_inventory_Click" /><br />
                            <telerik:RadLabel ID="RadLabel10" Text="Inventory" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:teal;" >
                            </telerik:RadLabel>
                        </td>
                        <td style="width:120px;text-align:center">
                            <asp:ImageButton ID="btn_purchase" runat="server" ImageUrl="~/Images/purchasing.png" Height="75px" Width="75px"
                                 OnClick="btn_purchase_Click" /><br />
                            <telerik:RadLabel ID="RadLabel5" Text="Purchase" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:orangered;" >
                            </telerik:RadLabel>
                        </td>
                        <td style="width:120px; text-align:center">
                            <asp:ImageButton ID="btn_fico" runat="server" ImageUrl="~/Images/calculator.jpg" Height="75px" Width="75px"
                                 OnClick="btn_fico_Click" /><br />
                            <telerik:RadLabel ID="RadLabel9" Text="Fico" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:darkslateblue;" >
                            </telerik:RadLabel>
                        </td>
                        <td style="width:120px; text-align:center">
                            <asp:ImageButton ID="btn_production" runat="server" ImageUrl="~/Images/production.jpg" Height="75px" Width="75px"
                                OnClick="btn_production_Click" /><br />
                            <telerik:RadLabel ID="RadLabel7" Text="Production" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:saddlebrown;" >
                            </telerik:RadLabel>
                        </td>
                        <td style="width:120px; text-align:center">
                            <asp:ImageButton ID="btn_sales" runat="server" ImageUrl="~/Images/sales.jpg" Height="75px" Width="75px"
                                OnClick="btn_sales_Click" /><br />
                            <telerik:RadLabel ID="RadLabel8" Text="Sales" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:orangered;" >
                            </telerik:RadLabel>
                        </td>
                        <td style="width:120px; text-align:center">
                            <asp:ImageButton ID="btn_report" runat="server" ImageUrl="~/Images/reports.png" Height="75px" Width="75px"
                                OnClick="btn_report_Click" /><br />
                            <telerik:RadLabel ID="RadLabel3" Text="Reports" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:darkslateblue;" >
                            </telerik:RadLabel>
                        </td >
                        <td style="width:120px; text-align:center">
                            <asp:ImageButton ID="btn_datastore" runat="server" ImageUrl="~/Images/data.png" Height="75px" Width="75px"
                                OnClick="btn_datastore_Click" /><br />
                            <telerik:RadLabel ID="RadLabel1" Text="Data Store" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:darkslateblue;" >
                            </telerik:RadLabel>
                        </td >
                        <td style="width:120px;text-align:center">
                            <asp:ImageButton ID="btn_security" runat="server" ImageUrl="~/Images/security.png" Height="75px" Width="105px"
                                 OnClick="btn_security_Click" /><br />
                            <telerik:RadLabel ID="RadLabel6" Text="Security" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:deepskyblue;" >
                            </telerik:RadLabel>
                        </td>
                    </tr>
                </table>               
        </div>

        <div style="padding:20px 50px 20px 80px;">
            
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

        <div style="clear:both; font-size:1px;"></div> 
    </div>
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                Width="1150px" Height="670px" Modal="false" AutoSize="True">
            </telerik:RadWindow>               
        </Windows>
    </telerik:RadWindowManager>

</asp:Content>
