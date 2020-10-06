<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc01h02.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.MechanicActivity.mtc01h02" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="styleshSeet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("reportViewer.aspx?jobno=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("mtc01h02EditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("mtc01h02EditForm.aspx?jobno=" + id, "EditDialogWindows");
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
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
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
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight" AutoPostBack="true"
                                    EnableLoadOnDemand="True"  Skin="Telerik" 
                                    OnItemsRequested="cb_proj_prm_ItemsRequested"
                                    OnSelectedIndexChanged="cb_proj_prm_SelectedIndexChanged"
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%">
                                </telerik:RadComboBox>                                    
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btnSearch" runat="server" Text="Filter" Width="95%" Height="25px" OnClick="btnSearch_Click"
                             Skin="Material" ForeColor="DeepSkyBlue"></telerik:RadButton>
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
                <td style="vertical-align: middle; margin-left: 10px; padding: 5px 0px 0px 13px;">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="25px" Width="28px" ImageUrl="~/Images/filter.png"></asp:ImageButton>
                </td>
                <td style="width: 93%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:bold">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

     <div  class="scroller" runat="server">
         <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik"
             AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="7"
             OnNeedDataSource="RadGrid1_NeedDataSource" 
             OnDeleteCommand="RadGrid1_DeleteCommand" 
             OnItemCreated="RadGrid1_ItemCreated" 
             OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" OnPreRender="RadGrid1_PreRender">
             <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
             <ClientSettings EnablePostBackOnRowClick="true" >
             </ClientSettings>
             <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="jobno" Font-Size="12px"
                 EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                 CommandItemSettings-ShowRefreshButton="false">
                 <Columns>
                     <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="30px" ></telerik:GridClientSelectColumn> 
                     <telerik:GridBoundColumn UniqueName="jobno" HeaderText="Reg. Number" DataField="jobno">
                         <HeaderStyle Width="120px"></HeaderStyle>
                         <ItemStyle Width="120px" />
                     </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn UniqueName="Employee_code" HeaderText="Emp. ID" DataField="Employee_code">
                         <HeaderStyle Width="120px"></HeaderStyle>
                         <ItemStyle Width="120px" />
                     </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn UniqueName="Employee_name" HeaderText="Name" DataField="Employee_name" 
                         FilterControlWidth="120px" >
                         <HeaderStyle Width="120px"></HeaderStyle>
                         <ItemStyle Width="120px" />
                     </telerik:GridBoundColumn>
                     <telerik:GridDateTimeColumn UniqueName="serv_date" HeaderText="Date" DataField="serv_date" ItemStyle-Width="80px" 
                            EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                         DataFormatString="{0:d}" >
                         <HeaderStyle Width="80px"></HeaderStyle>
                         <ItemStyle Width="80px" />
                     </telerik:GridDateTimeColumn>
                     <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" 
                         FilterControlWidth="120px" >
                         <HeaderStyle Width="120px"></HeaderStyle>
                     </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                         ItemStyle-Width="450px" FilterControlWidth="440px">
                         <HeaderStyle Width="450px"></HeaderStyle>
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
                         ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                     </telerik:GridButtonColumn>
                 </Columns>
             </MasterTableView>
             <ClientSettings>
                 <Selecting AllowRowSelect="true"></Selecting>
                 <ClientEvents OnRowDblClick="RowDblClick" />
             </ClientSettings>
         </telerik:RadGrid>

         <div runat="server" style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 20px;">
             <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Conditional">
                 <ContentTemplate>
                     <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
                        AllowPaging="true" AllowSorting="true" runat="server" ShowStatusBar="true"
                        ClientSettings-EnableAlternatingItems="True" ItemStyle-Height="15px" MasterTableView-EditMode="InPlace"
                        OnNeedDataSource="RadGrid2_NeedDataSource" 
                        OnDeleteCommand="RadGrid2_DeleteCommand"
                        OnInsertCommand="RadGrid2_InsertCommand" 
                        OnUpdateCommand="RadGrid2_InsertCommand">
                         <PagerStyle Mode="NumericPages" PageButtonCount="4" />
                         <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                         <MasterTableView CommandItemDisplay="Top" DataKeyNames="jobtype" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item" CommandItemSettings-ShowRefreshButton="False">
                             <Columns>
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                    HeaderText="Edit" HeaderStyle-Width="30px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridEditCommandColumn>

                                <telerik:GridTemplateColumn UniqueName="jobtype" HeaderText="Manpower Activity" HeaderStyle-Width="120px"
                                    SortExpression="jobno" ItemStyle-Width="120px">
                                    <FooterTemplate>Template footer</FooterTemplate>
                                    <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_job_code" Text='<%#DataBinder.Eval(Container.DataItem, "jobtype")%>'></asp:Label>                                
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_job_code" EnableLoadOnDemand="True" DataTextField="job_name"
                                            DataValueField="job_code" AutoPostBack="true"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.jobtype") %>' EmptyMessage="- Select job -"
                                            HighlightTemplatedItems="true" Width="150px" DropDownWidth="400px" DropDownAutoWidth="Enabled"
                                            OnSelectedIndexChanged="cb_job_code_SelectedIndexChanged" 
                                            OnItemsRequested="cb_job_code_ItemsRequested">
                                                <HeaderTemplate>
                                                    <table style="width: 400px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                Code 
                                                            </td>     
                                                            <td style="width: 250px;">
                                                                Name
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 400px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                            </td>
                                                            <td style="width: 250px;">
                                                                <%# DataBinder.Eval(Container, "Attributes['job_name']")%>
                                                            </td>                                                                   
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Duration Hour" HeaderStyle-Width="150px" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center"  
                                        HeaderStyle-HorizontalAlign="Center" DefaultInsertValue="0"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lbl_time_tot" Text='<%# DataBinder.Eval(Container.DataItem, "time_tot", "{0:#,###,###0.00}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_time_tot" Width="150px" EnabledStyle-HorizontalAlign="Center"  
                                                NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "time_tot", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2">
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Adj Tot" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                                        HeaderStyle-HorizontalAlign="Center" DefaultInsertValue="0"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                        <ItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_adj" Width="85px"  ReadOnly="false" EnabledStyle-HorizontalAlign="Right"
                                                NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "adj_tot", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2">
                                            </telerik:RadTextBox>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-Width="300px" ItemStyle-Width="300px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblactivity" Text='<%# DataBinder.Eval(Container.DataItem, "activity") %>'></asp:Label>                                 
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox runat="server" ID="txtactivity" EnabledStyle-HorizontalAlign="NotSet" Width="300px" Text='<%# DataBinder.Eval(Container.DataItem, "activity") %>'></telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                        ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
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
                    Width="1400px" Height="720px" Modal="true" AutoSize="False">
                </telerik:RadWindow>                
            </Windows>
         </telerik:RadWindowManager>

         <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
     </div>
</asp:Content>
