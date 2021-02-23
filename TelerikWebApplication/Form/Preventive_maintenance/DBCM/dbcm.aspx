<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="dbcm.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.DBCM.dbcm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            
            function ShowPreview(id) {
                window.radopen("reportViewer_mtc01h01.aspx?trans_id=" + id, "PreviewDialog");
                return false;
            }
           
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("mtc01h01EditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("mtc01h01EditForm.aspx?trans_id=" + id, "EditDialogWindows");
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

            function RowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function onPopUpShowing(sender, args) {
                args.get_popUp().className += " popUpEditForm";
            }

            function ShowWoForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("../WorkOrder/mtc01h01EditForm.aspx?trans_id=" + id, "DialogWindows");
                return false;
            }

        </script>
        <style type="text/css">
            .Header_grid {
                font-size:medium;
                font-weight:bold;
                color:white;
                background-color:#FF9933;
            }
        </style>

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
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
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
                                <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight" AutoPostBack="true" CausesValidation="false"
                                    EnableLoadOnDemand="True"  Skin="Silk" 
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="100%" 
                                    OnItemsRequested="cb_proj_prm_ItemsRequested" OnSelectedIndexChanged="cb_proj_prm_SelectedIndexChanged">
                                </telerik:RadComboBox>                                    
                                </ContentTemplate>
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
        </ContentTemplate>
    </telerik:RadWindow>
    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:orangered; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>                   
                <td style="vertical-align: middle; margin-left: 10px; padding: 5px 0px 0px 13px;">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="25px" Width="28px" ImageUrl="~/Images/filter.png"></asp:ImageButton>
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
    <div  class="scroller" runat="server" style="overflow-y:scroll; height:620px">
        <div runat="server" style="overflow-x:auto;">
           <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" PageSize="13" Skin="Silk"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" Width="1800px"
                  OnNeedDataSource="RadGrid1_NeedDataSource" OnUpdateCommand="RadGrid1_UpdateCommand" OnItemCreated="RadGrid1_ItemCreated">
                <PagerStyle Mode="NumericPages"></PagerStyle>          
                <ClientSettings EnablePostBackOnRowClick="true" />
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <HeaderStyle ForeColor="White" BackColor="#0099cc" Font-Size="11px"  />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="trans_id" Font-Size="11px"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                    CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" EditMode="EditForms"
                    CommandItemSettings-AddNewRecordText="New" InsertItemDisplay="Bottom">
                    <ColumnGroups >
                        <telerik:GridColumnGroup HeaderStyle-HorizontalAlign="Center" Name="BDStart" HeaderText="BD Start" ></telerik:GridColumnGroup>
                        <telerik:GridColumnGroup HeaderStyle-HorizontalAlign="Center" Name="EstimateRFU" HeaderText="Estimate RFU"></telerik:GridColumnGroup>
                        <telerik:GridColumnGroup HeaderStyle-HorizontalAlign="Center" Name="MaterialProcessStatus" HeaderText="Material Process Status"></telerik:GridColumnGroup>
                    </ColumnGroups>
                    <Columns>
                        <%--<telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="30px" ></telerik:GridClientSelectColumn>--%>
                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn" ItemStyle-Width="30px"  
                            HeaderStyle-Width="30px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                        </telerik:GridEditCommandColumn>
                        <telerik:GridTemplateColumn UniqueName="TemplateBtnAccountColumn" HeaderStyle-Width="70px" ItemStyle-Width="70px" AllowFiltering="False">
                        <ItemTemplate>
                            <asp:HyperLink runat="server" ID="link_wo" Height="20px" Width="80px" Text="View WO"  />
                        </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="WO. Number" HeaderStyle-Width="120px" ItemStyle-Width="120px" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_WO" Width="120px" Text='<%# DataBinder.Eval(Container.DataItem, "trans_id") %>'></asp:label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:label runat="server" ID="lbl_WO2" Width="120px" Text='<%# DataBinder.Eval(Container.DataItem, "trans_id") %>'></asp:label>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Unit Code" HeaderStyle-Width="120px" ItemStyle-Width="120px" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_Unit" Width="120px" Text='<%# DataBinder.Eval(Container.DataItem, "unit_code") %>'></asp:label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="HM BD." HeaderStyle-Width="80px" ItemStyle-Width="80px" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_HM" Width="60px" Text='<%# DataBinder.Eval(Container.DataItem, "time_reading") %>'></asp:label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Status" HeaderStyle-Width="60px" ItemStyle-Width="60px" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_status" Width="60px" Text='<%# DataBinder.Eval(Container.DataItem, "status") %>'></asp:label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-Width="110px" ItemStyle-Width="110px" ColumnGroupName="BDStart" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_Date" Width="110px" Text='<%# DataBinder.Eval(Container.DataItem, "down_date") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Time" HeaderStyle-Width="60px" ItemStyle-Width="60px" AllowFiltering="false" ColumnGroupName="BDStart">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_time" Width="60px" Text='<%# DataBinder.Eval(Container.DataItem, "down_time") %>'></asp:label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Trouble Description" HeaderStyle-Width="250px" ItemStyle-Width="250px" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_troubleDesc" Width="250px" Text='<%# DataBinder.Eval(Container.DataItem, "trouble_des") %>'></asp:label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Activity Today" HeaderStyle-Width="200px" ItemStyle-Width="200px" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:label runat="server" ID="lbl_activ" Width="200px" Text='<%# DataBinder.Eval(Container.DataItem, "remark_activity") %>'></asp:label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox runat="server" ID="txt_activ" RenderMode="Lightweight" Width="400px" TextMode="MultiLine"   
                                    Text='<%# DataBinder.Eval(Container.DataItem, "remark_activity") %>'></telerik:RadTextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-Width="110px" ItemStyle-Width="110px" ColumnGroupName="EstimateRFU" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_estiRFUDate" Text='<%# DataBinder.Eval(Container.DataItem, "esti_date") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>                                
                                <telerik:RadDatePicker ID="dtp_estiRFUDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                    DbSelectedDate='<%# DataBinder.Eval(Container.DataItem, "esti_date") %>'
                                    TabIndex="4" Skin="Telerik" > 
                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"> 
                                    </DateInput>                         
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Time" HeaderStyle-Width="110px" ItemStyle-Width="110px" ColumnGroupName="EstimateRFU" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_estiRFUTime" Text='<%# DataBinder.Eval(Container.DataItem, "esti_time") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTimePicker runat="server" ID="dp_estiRFUTime" RenderMode="Lightweight" Width="110px" 
                                    DbSelectedDate='<%# DataBinder.Eval(Container.DataItem, "esti_time") %>'></telerik:RadTimePicker>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Pro No" HeaderStyle-Width="120px" ItemStyle-Width="120px" ColumnGroupName="MaterialProcessStatus" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_proNo" Text='<%# DataBinder.Eval(Container.DataItem, "no_part") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox runat="server" ID="txt_proNo" RenderMode="Lightweight" Width="110px" ReadOnly="false" 
                                    Text='<%# DataBinder.Eval(Container.DataItem, "no_part") %>'></telerik:RadTextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-Width="110px" ItemStyle-Width="110px" ColumnGroupName="MaterialProcessStatus" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_matProDateEta" Text='<%# DataBinder.Eval(Container.DataItem, "part_date") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>                                
                                <telerik:RadDatePicker ID="dtp_matProDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                    DbSelectedDate='<%# DataBinder.Eval(Container.DataItem, "part_date") %>'
                                    TabIndex="4" Skin="Telerik" > 
                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"> 
                                    </DateInput>                         
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="ETA" HeaderStyle-Width="110px" ItemStyle-Width="110px" ColumnGroupName="MaterialProcessStatus" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbl_matProTimeEta" Text='<%# DataBinder.Eval(Container.DataItem, "part_eta") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>                                
                                 <telerik:RadDatePicker ID="dtp_matProEta"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                    DbSelectedDate='<%# DataBinder.Eval(Container.DataItem, "part_eta") %>'
                                    TabIndex="4" Skin="Telerik" > 
                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"> 
                                    </DateInput>                         
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>                        
                        <telerik:GridTemplateColumn HeaderText="Run" HeaderStyle-Width="30px" ItemStyle-Width="30px" Visible="false">
                            <ItemTemplate>                                        
                                <asp:Label runat="server" ID="lbl_run" Text='<%# DataBinder.Eval(Container.DataItem, "run") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lbl_run2" Text='<%# DataBinder.Eval(Container.DataItem, "run") %>'></asp:Label>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>

                </MasterTableView>
                <ClientSettings>
                    <Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="375px" />
                    <Selecting AllowRowSelect="true" />                    
                </ClientSettings>
            </telerik:RadGrid>
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
