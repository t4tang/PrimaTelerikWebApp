<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="pur01h02.aspx.cs" Inherits="TelerikWebApplication.Forms.Purchase.Purchase_order.po_std" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />

    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <style type="text/css">
            .orderText {
                font: normal 12px Arial,Verdana;
                margin-top: 6px;
            }
        </style>
    </telerik:RadCodeBlock>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="Server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="false" />       
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <%--<script type="text/javascript">
            function RowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
                
            }
 
            function onPopUpShowing(sender, args) {
                args.get_popUp().className += " popUpEditForm";
            }
        </script>--%>
        <script type="text/javascript">            
            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("edit_form.aspx?po_code=" + id, "UserListDialog");
                return false;
            }
            function ShowInsertForm() {
                window.radopen("edit_form.aspx", "UserListDialog");
                return false;
            }
            function refreshGrid(arg) {
                if (!arg) {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("Rebind");
                }
                else {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("RebindAndNavigate");
                }
            }
            function RowDblClick(sender, eventArgs) {
                window.radopen("edit_form.aspx?po_code=" + eventArgs.getDataKeyValue("po_code"), "UserListDialog");
            }
        </script>
        
    </telerik:RadCodeBlock>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <%--<telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>--%>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>
    
    <div class="scroller">        
           <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>--%>
                    <div runat="server" style="padding:10px 10px 10px 10px;" id="searchParam">                
                        <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="Date From " Height="26px"></telerik:RadDatePicker>                
                        <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="To Date " Height="26px"></telerik:RadDatePicker>
                        <telerik:RadComboBox ID="cb_project_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="Project" AutoPostBack="true"
                            EnableLoadOnDemand="True" Skin="Office2010Silver"  OnItemsRequested="cb_project_ItemsRequested" EnableVirtualScrolling="true" 
                            Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"
                            OnSelectedIndexChanged="cb_project_SelectedIndexChanged"></telerik:RadComboBox>&nbsp
                        &nbsp
                        <telerik:RadButton ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                        Style="clear: both; margin: 0px 0; height:28px">
                        </telerik:RadButton>    
                    </div>
                        <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
                        AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="10"
                        OnNeedDataSource="RadGrid1_NeedDataSource" OnPreRender="RadGrid1_PreRender" OnItemCreated="RadGrid1_ItemCreated"
                        OnDeleteCommand="RadGrid1_DeleteCommand">
                        <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                        <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="po_code" Font-Size="12px" 
                        EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true">
                            <Columns>
                               <%--<telerik:GridEditCommandColumn UniqueName="EditLink1"><HeaderStyle Width="20px"></HeaderStyle>
                                </telerik:GridEditCommandColumn>   --%>
                                <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" AllowFiltering="False" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="EditLink" runat="server" Text="Edit" ImageUrl="~/Images/modify.png" 
                                            Width="15px" Height="15px" ImageAlign="Middle" />
                                    </ItemTemplate>
                                    <HeaderStyle Width="30px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn UniqueName="po_code" HeaderText="PO Number" DataField="po_code">
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridDateTimeColumn UniqueName="Po_date" HeaderText="Date" DataField="Po_date" ItemStyle-Width="80px" 
                                        EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                                    DataFormatString="{0:d}" >
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                </telerik:GridDateTimeColumn>
                                <telerik:GridBoundColumn UniqueName="vendor_name" HeaderText="Vendor Name" DataField="vendor_name" 
                                    FilterControlWidth="220px" >
                                    <HeaderStyle Width="250px"></HeaderStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                                     ItemStyle-Width="250px" FilterControlWidth="480px">
                                    <HeaderStyle Width="500px"></HeaderStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete">
                                </telerik:GridButtonColumn>
                            
                            </Columns>
                           
                            <CommandItemTemplate>
                                <a href="#" onclick="return ShowInsertForm();">Add New</a>
                               <%-- <telerik:RadLinkButton runat="server" ID="btnNew" Text="New Record" Height="25px" Width="100px"
                                    BorderStyle="None"  onClick="return ShowInsertForm();"></telerik:RadLinkButton>--%>
                            
                            </CommandItemTemplate>
                        
                        </MasterTableView>
                        <ClientSettings>
                            <%--<ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />--%>
                            <Selecting AllowRowSelect="true"></Selecting>
                            <%--<ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>--%>
                        </ClientSettings>
                    </telerik:RadGrid>
                <%--</ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click">
                    </asp:AsyncPostBackTrigger>
                </Triggers>                
            </asp:UpdatePanel>--%>
               
            <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
                <Windows>
                    <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Title="Editing record" Height="650px"
                        Width="1150px" Left="150px" ReloadOnShow="false" ShowContentDuringLoad="false"
                        Modal="false">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>         
    </div>
</asp:Content>