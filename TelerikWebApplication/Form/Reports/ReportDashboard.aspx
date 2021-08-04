<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="ReportDashboard.aspx.cs" Inherits="TelerikWebApplication.Form.Reports.ReportDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/common.css" rel="stylesheet" />
    <link href="Styles/custom-cs.css" rel="stylesheet" />
    <script src="Script/Script.js"></script>
    <link href="../../Styles/mail.css" rel="stylesheet" />

    <script src="jquery-1.3.2.min.js"></script>  
    <script src="jquery.dimensions.js"></script>  
    
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
            top: 32px;  
            /*width: 100%;*/
            margin-left: 25px;  
            height: 50px;  
            background-color:transparent;
            opacity:0.7;
            padding:25px 15px 15px 105px;
            /*fill-opacity:inherit;*/
        }  
	</style>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
       
        <script type="text/javascript">
            
            //function ShowInventoryReportForm() {
            //    window.radopen("../Inventory/Reports/dashboard.aspx", "PreviewDialog");
            //    return false;
            //}
            function ShowInventoryReportForm() {
                window.radopen("../Inventory/Reports/dashboard.aspx");
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

    <div runat="server" class="scroller" style=" overflow:auto; height:665px; padding: 0px 10px 45px 0px;"> 
        <div id="floatDiv" >
           <%--<asp:ImageButton ID="btn_home" runat="server" ImageUrl="~/Images/home.png" Height="45px" Width="45px" 
                OnClick="btn_home_Click" /><br />
            <telerik:RadLabel ID="RadLabel11" Text="" ToolTip="Back to Home" runat="server" Skin="Silk" Width="100%" 
            Style="font-weight: lighter; font-size: 12px; font-variant: small-caps;padding-bottom: 0px; color:orangered;" >
            </telerik:RadLabel>--%>
            <telerik:RadLinkButton runat="server" NavigateUrl="~/Home.aspx" Height="45px" Width="45px" BorderStyle="None" >
                <ContentTemplate>
                    <asp:Image ImageUrl="~/Images/home.png" runat="server" Width="45px" Height="45px" />
                </ContentTemplate>
            </telerik:RadLinkButton> 
                           
        </div>

        <div runat="server" style="padding: 30px 0px 50px 100px; ">
            <div style="background-color:transparent;padding: 0px 0px 40px 0px; float:left;width:55%" >
                <table>
                    <tr>
                        <td style="vertical-align:middle;  text-align:center; width:100%; padding: 0px 0px 25px 220px; font-variant:small-caps; font-size:26px">
                            <telerik:RadLabel runat="server" Text="Prima Reports" ForeColor="#0099ff"></telerik:RadLabel>
                        </td>
                    </tr>
                </table>
                <telerik:RadTileList RenderMode="Lightweight" runat="server" ID="RadTileList1" ScrollingMode="None" Width="100%"                
                    SelectionMode="none" EnableDragAndDrop="true">
                    <Groups>
                        <telerik:TileGroup Title="">
                            <telerik:RadImageTile runat="server" Name="PreventiveMaintenance" ImageUrl="~/Images/PreventiveMtcRpt.png" Shape="Wide" Selected="true"
                                NavigateUrl="~/Form/Preventive_maintenance/Reports/dashboard.aspx" Target="_blank" 
                                ImageWidth="120px" ImageHeight="120px" Skin="Silk" Width="240px" Height="180px" ForeColor="Highlight"  Font-Size="Medium" BackColor="White">
                                <Title Text="Maintenance Report"></Title>
                                <PeekTemplateSettings Animation="Slide" AnimationDuration="800" Easing="easeInOutBack"
                                ShowInterval="5000" CloseDelay="5000" ShowPeekTemplateOnMouseOver="true" HidePeekTemplateOnMouseOut="true" />
                            </telerik:RadImageTile>
                            <telerik:RadImageTile runat="server" Name="Inventory" ImageUrl="~/Images/inventoryRpt.png" Shape="Wide" Selected="true"
                                NavigateUrl="~/Form/Inventory/Reports/dashboard.aspx" Target="_blank" 
                                ImageWidth="120px" ImageHeight="120px" Skin="Silk" Width="240px" Height="180px" ForeColor="Darkorange"  Font-Size="Medium" BackColor="White">
                                <Title Text="Inventory Report"></Title>
                                <PeekTemplateSettings Animation="Slide" ShowInterval="4000" CloseDelay="3000" AnimationDuration="800"
                                    ShowPeekTemplateOnMouseOver="true" HidePeekTemplateOnMouseOut="true" Easing="easeOutExpo" />
                            </telerik:RadImageTile>
                            <telerik:RadImageTile runat="server" Name="Purchase" ImageUrl="~/Images/purchaseRpt.png" Shape="Wide"
                                NavigateUrl="~/Form/Purchase/Reports/dashboard.aspx" Target="_blank" 
                                ImageWidth="100px" ImageHeight="120px" Skin="Silk" Width="240px" Height="180px" ForeColor="YellowGreen"  Font-Size="Medium" BackColor="White">
                                <Title Text="Purchase Report"></Title>
                                <PeekTemplateSettings Animation="Fade" ShowPeekTemplateOnMouseOver="true" HidePeekTemplateOnMouseOut="true" />
                                <PeekTemplateSettings />
                            </telerik:RadImageTile>
                            <telerik:RadImageTile runat="server" Name="Fico" ImageUrl="~/Images/ficoRpt.png" Shape="Wide"
                                NavigateUrl="~/Form/Fico/Reports/dashboard.aspx" Target="_blank" 
                                ImageWidth="120px" ImageHeight="120px" Skin="Silk" Width="240px" Height="180px" ForeColor="#6600cc"  Font-Size="Medium" BackColor="White">
                                <Title Text="Fico Report"></Title>
                                <PeekTemplateSettings Animation="Slide" ShowInterval="2000" CloseDelay="5000" ShowPeekTemplateOnMouseOver="true"
                                    HidePeekTemplateOnMouseOut="true" />
                            </telerik:RadImageTile>
                            <telerik:RadImageTile runat="server" Name="Production" ImageUrl="~/Images/productionRpt.png" Shape="Wide"
                                NavigateUrl="~/Form/Production/Reports/dashboard.aspx" Target="_blank" 
                                ImageWidth="120px" ImageHeight="120px" Skin="Silk" Width="240px" Height="180px" ForeColor="#663300" Font-Size="Medium" BackColor="White">
                                <Title Text="Production Report"></Title>
                                <PeekTemplateSettings Animation="Fade" ShowInterval="4000" ShowPeekTemplateOnMouseOver="true"
                                    HidePeekTemplateOnMouseOut="true" />
                            </telerik:RadImageTile>
                            <telerik:RadImageTile runat="server" Name="Sales" ImageUrl="~/Images/salesRpt.png" Shape="Wide"
                                NavigateUrl="~/Form/Sales/Reports/dashboard.aspx" Target="_blank" 
                                ImageWidth="140px" ImageHeight="120px" Skin="Silk" Width="240px" Height="180px" ForeColor="#9900cc"  Font-Size="Medium" BackColor="White">
                                <Title Text="Sales Report"></Title>
                                <PeekTemplateSettings AnimationDuration="850" ShowInterval="7000" CloseDelay="7000"
                                    Animation="Slide" Easing="easeInQuad" ShowPeekTemplateOnMouseOver="true" HidePeekTemplateOnMouseOut="true" />
                            </telerik:RadImageTile>                        
                           
                        </telerik:TileGroup>
                    </Groups>
                </telerik:RadTileList>
            </div>
            
            <div style="background-color:transparent;padding: 0px 0px 40px 0px; float:left;width:45%" >
                <telerik:RadHtmlChart runat="server" ID="PieChart1" Width="500" Height="300" Transitions="true" Skin="Silk">
                    <ChartTitle Text="">
                        <Appearance Align="Center" Position="Top">
                        </Appearance>
                    </ChartTitle>
                    <Legend>
                        <Appearance Position="Right" Visible="false">
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <Series>
                            <telerik:PieSeries StartAngle="90">
                                <LabelsAppearance Position="OutsideEnd" DataFormatString="{0} %">
                                </LabelsAppearance>
                                <TooltipsAppearance Color="White" DataFormatString="{0} %"></TooltipsAppearance>
                                <SeriesItems>
                                    <telerik:PieSeriesItem BackgroundColor="#ff9900" Exploded="true" Name="Internet Explorer"
                                        Y="18.3"></telerik:PieSeriesItem>
                                    <telerik:PieSeriesItem BackgroundColor="#cccccc" Exploded="false" Name="Firefox"
                                        Y="35.8"></telerik:PieSeriesItem>
                                    <telerik:PieSeriesItem BackgroundColor="#999999" Exploded="false" Name="Chrome" Y="38.3"></telerik:PieSeriesItem>
                                    <telerik:PieSeriesItem BackgroundColor="#666666" Exploded="false" Name="Safari" Y="4.5"></telerik:PieSeriesItem>
                                    <telerik:PieSeriesItem BackgroundColor="#333333" Exploded="false" Name="Opera" Y="2.3"></telerik:PieSeriesItem>
                                </SeriesItems>
                            </telerik:PieSeries>
                        </Series>
                    </PlotArea>
                </telerik:RadHtmlChart>
            </div>
        </div>
    </div>

    <%--<div runat="server" class="scroller" style=" overflow:auto; height:700px; padding-bottom:45px"> 

        <div id="floatDiv" >
           <table>
                    <tr>
                        <td style="width:170px;text-align:center">
                            <asp:ImageButton ID="btn_prev_mtc" runat="server" ImageUrl="~/Images/PreventiveMtcRpt.png" Height="75px" Width="75px" 
                               OnClick="btn_prev_mtc_Click" /><br />
                            <telerik:RadLabel ID="RadLabel11" Text="Maintenance Report" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:orangered;" >
                            </telerik:RadLabel>
                        </td>
                        <td style="width:170px;text-align:center">
                            <asp:ImageButton ID="btn_inventory" runat="server" ImageUrl="~/Images/inventoryRpt.png" Height="75px" Width="75px"
                              OnClick="btn_inventory_Click" /><br />
                            <telerik:RadLabel ID="RadLabel10" Text="Inventory Report" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:teal;" >
                            </telerik:RadLabel>
                        </td>
                        <td style="width:170px;text-align:center">
                            <asp:ImageButton ID="btn_purchase" runat="server" ImageUrl="~/Images/purchaseRpt.png" Height="75px" Width="75px"
                             OnClick="btn_purchase_Click" /><br />
                            <telerik:RadLabel ID="RadLabel5" Text="Purchase Report" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:orangered;" >
                            </telerik:RadLabel>
                        </td>
                        <td style="width:170px; text-align:center">
                            <asp:ImageButton ID="btn_fico" runat="server" ImageUrl="~/Images/ficoRpt.png" Height="75px" Width="75px"
                             OnClick="btn_fico_Click" /><br />
                            <telerik:RadLabel ID="RadLabel9" Text="Fico Report" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:darkslateblue;" >
                            </telerik:RadLabel>
                        </td>
                        <td style="width:170px; text-align:center">
                            <asp:ImageButton ID="btn_production" runat="server" ImageUrl="~/Images/productionRpt.png" Height="75px" Width="75px"
                             OnClick="btn_production_Click" /><br />
                            <telerik:RadLabel ID="RadLabel7" Text="Production Report" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:saddlebrown;" >
                            </telerik:RadLabel>
                        </td>
                        <td style="width:170px; text-align:center">
                            <asp:ImageButton ID="btn_sales" runat="server" ImageUrl="~/Images/salesRpt.png" Height="75px" Width="75px"
                            OnClick="btn_sales_Click" /><br />
                            <telerik:RadLabel ID="RadLabel8" Text="Sales Report" runat="server" Skin="Silk" Width="100%" 
                            Style="font-weight: lighter; font-size: 19px; font-variant: small-caps;padding-bottom: 0px; color:orangered;" >
                            </telerik:RadLabel>
                        </td>
                    </tr>
                </table>                     
        </div>
    </div>--%>

    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                Width="1150px" Height="670px" Modal="false" AutoSize="True">
            </telerik:RadWindow>               
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>
