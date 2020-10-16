<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TelerikWebApplication.Forms.Purchase.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">  
    <link href="../../Styles/common.css" rel="stylesheet" />
    <link href="../../Styles/mail.css" rel="stylesheet" />
    <link href="../../Styles/custom-cs.css" rel="stylesheet" />

    <script src="../../Script/Script.js"></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("purApvForm.aspx?po_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("purApvForm.aspx", "EditDialogWindows");
                return false;
            }

            <%--function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("purApvForm.aspx?TRANSAKSI=" + id, "EditDialogWindows");
                return false;
            }--%>

            <%--function openWinFiterTemplate() {
                var filterDialog = $find("<%=FilterDialogWindows.ClientID%>");
                filterDialog.show();
            }

            Sys.Application.add_load(function () {
            $windowContentDemo.contentTemplateID = "<%=FilterDialogWindows.ClientID%>";
            $windowContentDemo.templateWindowID = "<%=FilterDialogWindows.ClientID %>";
            });--%>

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
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" ></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadListBox1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2" ></telerik:AjaxUpdatedControl>  
                </UpdatedControls>        
            </telerik:AjaxSetting> 
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>

     <div style="padding-left: 15px;">
        <table id="tbl_control">
            <tr>                  
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 8px">
                    <%--<asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClientClick="ShowInsertForm(); return false;" ToolTip="Add New"
                        Height="30px" Width="32px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>--%>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 13px">
                    <%--<asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="28px" Width="28px" ImageUrl="~/Images/filter1.png"></asp:ImageButton>--%>
                </td>
                <td style="width: 98%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>   
    <div class="scroller" runat="server"> 
        <div style="float:left; width:28%" runat="server">        
            <%--<telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik" Width="275px"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="10"
                OnNeedDataSource="RadGrid1_NeedDataSource" 
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged">
                    <PagerStyle Mode="Slider" VerticalAlign="NotSet" PageSizeControlType="RadComboBox"></PagerStyle>                
                    <HeaderStyle CssClass="gridHeader" />
                    <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                    <SortingSettings EnableSkinSortStyles="false" />
                    <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="TRANSAKSI" Font-Size="12px" 
                        EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="false" CommandItemSettings-ShowAddNewRecordButton="false"
                         CommandItemSettings-ShowRefreshButton="false" >
                        <Columns>
                            <telerik:GridBoundColumn UniqueName="TRANSAKSI" HeaderText="Transaction" DataField="TRANSAKSI" >
                                <HeaderStyle Width="200px" HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle Width="200px" HorizontalAlign="Left" />
                            </telerik:GridBoundColumn>
                        
                            <telerik:GridBoundColumn UniqueName="JUMLAH" HeaderText="Count" DataField="JUMLAH" ItemStyle-Width="50px"  
                                ItemStyle-HorizontalAlign="Center"
                                DataType="System.Int32">
                                <HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
                            </telerik:GridBoundColumn> 
                            <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Center" 
                                AllowFiltering="False">
                            <ItemTemplate>                                
                                <asp:ImageButton ID="EditLink" runat="server" Height="22px" Width="25px" ImageUrl="~/Images/search1.png" ToolTip="Edit" />
                            </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings>                         
                        <Selecting AllowRowSelect="true"></Selecting>
                        <ClientEvents OnRowDblClick="RowDblClick" />
                    </ClientSettings>
                </telerik:RadGrid> --%>   
            
            <telerik:RadListBox RenderMode="Lightweight" ID="RadListBox1" runat="server" Width="256px" Height="320" Skin="Telerik" BorderStyle="None" BorderWidth="0px"
                AutoPostBack="true" DataKeyField="tr_name" DataValueField="cnt" OnSelectedIndexChanged="RadListBox1_SelectedIndexChanged"
                DataTextField="tr_name">
                <ItemTemplate>
                    <span>
                        <%# Container.Text %> &nbsp <%# Container.Value %>
                    </span>
                </ItemTemplate>
            </telerik:RadListBox>                
        </div>
    
        <div style="float:right;width:72%;">                
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid2"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="12"
                OnItemCreated="RadGrid2_ItemCreated" 
                OnNeedDataSource="RadGrid2_NeedDataSource" >
                <PagerStyle Mode="Slider" VerticalAlign="NotSet" PageSizeControlType="RadComboBox"></PagerStyle>                
                <HeaderStyle CssClass="gridHeader" />
                <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                <SortingSettings EnableSkinSortStyles="false" />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="tr_no" Font-Size="12px" 
                    HeaderStyle-Font-Size="11px" HeaderStyle-BorderColor="Teal" HeaderStyle-BorderStyle="None"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="false" CommandItemSettings-ShowAddNewRecordButton="false"
                    HeaderStyle-ForeColor="Teal" HeaderStyle-Font-Bold="true"  CommandItemSettings-ShowRefreshButton="false" >
                    <ColumnGroups>
                        <telerik:GridColumnGroup HeaderText="Approval" HeaderStyle-BorderColor="Teal" Name="grp_approve" HeaderStyle-HorizontalAlign="Center"></telerik:GridColumnGroup>
                    </ColumnGroups>
                    <Columns>
                        <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="30px" ></telerik:GridClientSelectColumn> 
                        <telerik:GridBoundColumn UniqueName="tr_no" HeaderText="Doc. Number" DataField="tr_no">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="tr_date" HeaderText="Date" DataField="tr_date" ItemStyle-Width="80px" 
                            EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle Width="80px" />
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project" DataField="region_code" 
                            FilterControlWidth="40px" >
                            <HeaderStyle Width="40px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="1" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center" 
                         ColumnGroupName="grp_approve"    HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="edt_chkApv1" OnCheckedChanged="edt_chkApv1_CheckedChanged" OnPreRender="edt_chkApv1_PreRender"
                                Checked='<%# DataBinder.Eval(Container.DataItem, "bool_apv1") %>' Enabled="false"/>
                        </ItemTemplate>                                        
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="2" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center"
                      ColumnGroupName="grp_approve"  HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="edt_chkApv2"  OnCheckedChanged="edt_chkApv2_CheckedChanged" OnPreRender="edt_chkApv2_PreRender"
                                Checked='<%# DataBinder.Eval(Container.DataItem, "bool_apv2") %>' Enabled="false"/>
                        </ItemTemplate>
                                                                               
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="3" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center"
                         ColumnGroupName="grp_approve"  HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center" ReadOnly="true">
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="edt_chkApv3" OnCheckedChanged="edt_chkApv3_CheckedChanged" OnPreRender="edt_chkApv3_PreRender"
                                Checked='<%# DataBinder.Eval(Container.DataItem, "bool_apv3") %>'  Enabled="false"/>
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
