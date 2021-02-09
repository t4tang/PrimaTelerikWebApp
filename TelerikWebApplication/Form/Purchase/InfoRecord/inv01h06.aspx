<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h06.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.InfoRecord.inv01h06" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript">
                function rowDblClick(sender, eventArgs) {
                    sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
                }

                function ShowPreview(id) {
                    window.radopen("inv01h06ReportViewer.aspx?info_code=" + id, "PreviewDialog");
                    return false;
                }
                function RowDblClick(sender, eventArgs) {
                    Row = eventArgs.get_itemIndexHierarchical();
                }
                function callBackFn(arg) {
                    //alert("this is the client-side callback function. The RadAlert returned: " + arg);
                }
                function ShowInsertForm() {                
                    window.radopen("inv01h06EditForm.aspx", "EditDialogWindows");
                    return false;
                }

                function ShowEditForm(id, rowIndex) {
                    var grid = $find("<%= RadGrid1.ClientID %>");
 
                    var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                    grid.get_masterTableView().selectItem(rowControl, true);
 
                    window.radopen("inv01h06EditForm.aspx?info_code=" + id, "EditDialogWindows");
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
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
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
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2" ></telerik:AjaxUpdatedControl>  
                </UpdatedControls>        
            </telerik:AjaxSetting> 
            
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="700" BackgroundPosition="None" BackColor="Transparent" >
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
                        <td >
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight"
                               EnableLoadOnDemand="True"  Skin="Telerik" 
                                OnItemsRequested="cb_proj_prm_ItemsRequested"
                                OnSelectedIndexChanged="cb_proj_prm_SelectedIndexChanged"
                                EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="95%" Height="25px"
                             Skin="Material"></telerik:RadButton>
                        </td>

                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:orangered; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>                  
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClientClick="ShowInsertForm(); return false;" ToolTip="Add New"
                        Height="25px" Width="27px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="20px" Width="23px" ImageUrl="~/Images/filter.png"></asp:ImageButton>
                </td>
                <td style="width: 97%; text-align: right; padding-right:17px"">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#7cca05; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>  

    <div class="scroller" runat="server" style="overflow-y:scroll; height:620px">
        <div runat="server" style="height:465px;">
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="10" MasterTableView-GridLines="None" 
                
                >
                <PagerStyle Mode="NextPrevAndNumeric" VerticalAlign="NotSet" PageSizeControlType="RadComboBox"></PagerStyle>                
                <HeaderStyle CssClass="gridHeader" />
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
                <SortingSettings EnableSkinSortStyles="false" />
                <ClientSettings EnablePostBackOnRowClick="true" />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="" Font-Size="11px"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false">
                <Columns>
                    
                                              
                </Columns>
                </MasterTableView>
                <ClientSettings>                         
                    <%--<Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="273px" />--%>
                    <Selecting AllowRowSelect="true"></Selecting>    
                </ClientSettings>
            </telerik:RadGrid>
        </div>

        <div runat="server" style="width: 100%; border-top-width: 1px; border-top-style: inset; padding-top: 5px;">  
            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
            AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" 
            
                >
            <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
            <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
            <MasterTableView CommandItemDisplay="None" DataKeyNames="" Font-Size="11px" EditMode="InPlace"
                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item">
            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                                        
            <Columns>
                
            </Columns>
            </MasterTableView>
            <ClientSettings >
                <Selecting AllowRowSelect="true"></Selecting>                          
            </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>

    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                Width="1150px" Height="670px" Modal="true" AutoSize="True">
            </telerik:RadWindow>
            <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                Width="1300px" Height="720px" Modal="true" AutoSize="False">
            </telerik:RadWindow>
                
        </Windows>
    </telerik:RadWindowManager>
        
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
    </telerik:RadWindowManager>
</asp:Content>
