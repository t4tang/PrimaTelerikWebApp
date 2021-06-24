<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="stockCard.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.StockCard.stockCard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />    
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
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
        </script>

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
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position:center; top: 100px;" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" MinDisplayTime="500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 170px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" MinDisplayTime="500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="450px" Height="350px" VisibleStatusbar="False" AutoSize="True">
        <ContentTemplate>
            
        </ContentTemplate>
    </telerik:RadWindow>
    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:orangered; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>                   
                <td style="vertical-align: middle; margin-left: 10px; padding: 5px 0px 0px 13px;">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter" Visible="true" 
                        Height="29px" Width="30px" ImageUrl="~/Images/search.png"></asp:ImageButton>
                </td>                 
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" ToolTip="Add New" Visible="false" 
                        Height="30px" Width="32px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                </td>  
                <td style="width: 96%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight:normal; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue;" Text="Daily Breakdown Condition Monitoring">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>
    <div  class="scroller" runat="server" style="overflow-y:scroll; min-height:620px">
        <div runat="server" style="overflow-x:auto; float:left;">
           <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" PageSize="13" Skin="Silk"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers" Width="800px"
                  OnNeedDataSource="RadGrid1_NeedDataSource" >
                <PagerStyle Mode="NumericPages"></PagerStyle>          
                <ClientSettings EnablePostBackOnRowClick="true" />
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px"/>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="NO_REFF" Font-Size="11px"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                    CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" EditMode="EditForms"
                    CommandItemSettings-AddNewRecordText="New" InsertItemDisplay="Bottom">                    
                    <Columns>
                        
                        <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-Width="70px" ItemStyle-Width="70px" AllowFiltering="false" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_date" Width="70px" Text='<%# DataBinder.Eval(Container.DataItem, "DATE","{0:d MMM yyyy}") %>'></asp:label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Reff Code" HeaderStyle-Width="100px" ItemStyle-Width="120px" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_no_reff" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "NO_REFF") %>'></asp:label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <%--<telerik:GridTemplateColumn HeaderText="Customer" HeaderStyle-Width="120px" ItemStyle-Width="120px" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_customer" Width="120px" Text='<%# DataBinder.Eval(Container.DataItem, "CUSTOMER") %>'></asp:label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>--%>
                        <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="150px" ItemStyle-Width="150px" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_remark" Width="150px" Text='<%# DataBinder.Eval(Container.DataItem, "REMARK") %>'></asp:label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Debet" HeaderStyle-Width="70px" ItemStyle-Width="70px" AllowFiltering="false" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_debet" Width="70px" Text='<%# DataBinder.Eval(Container.DataItem, "DEBET") %>'></asp:label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Credit" HeaderStyle-Width="70px" ItemStyle-Width="70px" AllowFiltering="false" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_credit" Width="70px" Text='<%# DataBinder.Eval(Container.DataItem, "CREDIT") %>'></asp:label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Saldo" HeaderStyle-Width="90px" ItemStyle-Width="100px" AllowFiltering="false" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_saldo" Width="90px" Text='<%# DataBinder.Eval(Container.DataItem, "SALDO") %>'></asp:label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                        
                    </Columns>

                </MasterTableView>
                <ClientSettings>
                    <Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="375px" />
                    <Selecting AllowRowSelect="true" />                    
                </ClientSettings>
            </telerik:RadGrid>
        </div>
        <div runat="server" style="padding: 20px 10px 10px 10px; float:left" id="Div2">
                <table>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Date From :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Silk" DateInput-CausesValidation="false"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                        <td >
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Silk"  DateInput-CausesValidation="false"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                <telerik:RadLabel runat="server" Text="Material Code :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                <telerik:RadComboBox ID="cb_prd_code" runat="server" RenderMode="Lightweight" AutoPostBack="false" CausesValidation="false"
                                    EnableLoadOnDemand="True"  Skin="Silk" DropDownWidth="650px" Height="400px"
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%" 
                                    OnItemsRequested="cb_prd_code_ItemsRequested"
                                    OnSelectedIndexChanged="cb_prd_code_SelectedIndexChanged" >
                                    <HeaderTemplate>
                                        <table style="width: 650px; font-size:11px">
                                            <tr>
                                                <td style="width: 100px;">
                                                    Code
                                                </td>
                                                <td style="width: 450px;">
                                                    Description
                                                </td>                                                  
                                                <td style="width: 50px; text-align:left">
                                                    UoM
                                                </td>                                                                
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 650px; font-size:11px">
                                            <tr>
                                                <td style="width: 100px;">
                                                    <%# DataBinder.Eval(Container, "DataItem.prod_code")%>
                                                </td>
                                                <td style="width: 450px;">
                                                    <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "spec") %>'></asp:label> 
                                                </td>
                                                <td style="width: 70px;">
                                                    <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "unit") %>'></asp:label> 
                                                </td>                                                                
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>                                    
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight" AutoPostBack="true"
                                    EnableLoadOnDemand="True"  Skin="Silk"  Height="300px"
                                    OnItemsRequested="cb_Project_prm_ItemsRequested"
                                    OnSelectedIndexChanged="cb_Project_prm_SelectedIndexChanged"
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%">
                                </telerik:RadComboBox>                                    
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                <telerik:RadLabel runat="server" Text="Warehouse :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                <telerik:RadComboBox ID="cb_warehouse" runat="server" RenderMode="Lightweight" AutoPostBack="true" CausesValidation="false"
                                    EnableLoadOnDemand="True"  Skin="Silk"  Height="300px"
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%" 
                                    OnItemsRequested="cb_loc_ItemsRequested" 
                                    OnSelectedIndexChanged="cb_loc_SelectedIndexChanged" >
                                </telerik:RadComboBox>                                    
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cb_proj_prm" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="95%" Height="25px" CausesValidation="false"
                             Skin="Material" ForeColor="DeepSkyBlue"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
    </div>
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow RenderMode="Lightweight" ID="DialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                Width="1400px" Height="720px" Modal="true" AutoSize="False">
            </telerik:RadWindow>        
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>
