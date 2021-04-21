<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc01h01.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.WorkOrder.mtc01h01" %>
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
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_compGroup" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cb_comp" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cb_diagnosis" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cb_symptom" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_jobDesc" ></telerik:AjaxUpdatedControl>

                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid3" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid4" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid5" ></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>
            <%--<telerik:AjaxSetting AjaxControlID="RadGrid2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" ></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid5">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid5" ></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>--%>
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
                            <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="95%" Height="25px" CausesValidation="false"
                             Skin="Material" ForeColor="DeepSkyBlue"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>                     
                <td style="vertical-align: bottom; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClientClick="ShowInsertForm(); return false;" ToolTip="Add New" Visible="true"
                        Height="26px" Width="27px" ImageUrl="~/Images/tambah.png" ImageAlign="Bottom" ></asp:ImageButton>
                    <%--<telerik:RadButton RenderMode="Lightweight" ID="btn_new" runat="server" Text="New" CssClass="btn-top" AutoPostBack="false"
                       Skin="Silk"  OnClientClicked="ShowInsertForm(); return false;" ></telerik:RadButton>--%>
                </td>                
                <td style="vertical-align: bottom; margin-left: 0px; padding: 0px 0px 0px 0px;">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter" 
                        Height="29px" Width="30px" ImageUrl="~/Images/search.png"></asp:ImageButton>
                    <%--<telerik:RadButton RenderMode="Lightweight" ID="btn_filter" runat="server" Text="Filter" CssClass="btn-top"
                       Skin="Silk" OnClientClick="openWinFiterTemplate(); return false;" ></telerik:RadButton>--%>
                </td> 
                <td style="width: 96%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight:normal; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#0099dc;">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

    <div class="scroller" runat="server" style="overflow-y:scroll; height:620px;" >
        <div style="width:100%; overflow-y:hidden;height:auto; scrollbar-highlight-color:#b6ff00">
            <%--<asp:UpdatePanel runat="server">
                <ContentTemplate>--%>
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" PageSize="14" Skin="Silk"
                        AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers" 
                        OnNeedDataSource="RadGrid1_NeedDataSource"
                        OnDeleteCommand="RadGrid1_DeleteCommand"
                        OnItemCreated="RadGrid1_ItemCreated"
                        OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" >
                        <PagerStyle Mode="NumericPages"></PagerStyle>          
                        <ClientSettings EnablePostBackOnRowClick="true" />
                        <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                        <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px" HorizontalAlign="Center"/>
                        <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="trans_id" Font-Size="11px" Font-Names="Century Gothic"
                            EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                            CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" EditMode="EditForms" 
                            CommandItemSettings-AddNewRecordText="New" EditFormSettings-EditFormType="WebUserControl" InsertItemDisplay="Bottom">
                            <Columns>
                                <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="30px" ></telerik:GridClientSelectColumn> 
                                <%--<telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                                    <HeaderStyle Width="40px"/>
                                    <ItemStyle Width="40px" />
                                </telerik:GridEditCommandColumn>--%>
                                <telerik:GridBoundColumn UniqueName="trans_id" HeaderText="WO. Number" DataField="trans_id">
                                    <HeaderStyle Width="140px"/>
                                    <ItemStyle Width="140px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn UniqueName="unit_code" HeaderText="Unit Code" DataField="unit_code" ItemStyle-HorizontalAlign="Left" >
                                    <HeaderStyle Width="140px"/>
                                    <ItemStyle Width="140px" />
                                </telerik:GridBoundColumn>
                                <%--<telerik:GridBoundColumn UniqueName="model" HeaderText="Model" DataField="model_no" ItemStyle-HorizontalAlign="Left"  
                                        FilterControlWidth="100px" >
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle Width="80px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn UniqueName="time_reading" HeaderText="HM" DataField="time_reading">
                                    <HeaderStyle Width="60px"></HeaderStyle>
                                    <ItemStyle Width="60px" />
                                </telerik:GridBoundColumn>--%>
                                <telerik:GridDateTimeColumn UniqueName="trans_date" HeaderText="Date" DataField="trans_date" 
                                        EnableRangeFiltering="false" PickerType="DatePicker" DataFormatString="{0:d}" FilterControlWidth="103px" >
                                    <HeaderStyle Width="140px"/>
                                    <ItemStyle Width="120px" />                        
                                </telerik:GridDateTimeColumn>
                                <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" ItemStyle-HorizontalAlign="Left"
                                    FilterControlWidth="200px"  >
                                    <HeaderStyle Width="240px"/>
                                    <ItemStyle Width="200px" /> 
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn UniqueName="wo_desc" HeaderText="Status" DataField="wo_desc" ItemStyle-HorizontalAlign="Left" 
                                        FilterControlWidth="65px" >
                                    <HeaderStyle Width="100px"/>
                                    <ItemStyle Width="80px" /> 
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn UniqueName="orderName" HeaderText="Order Type" DataField="orderName" ItemStyle-HorizontalAlign="Left" 
                                        FilterControlWidth="110px" >
                                    <HeaderStyle Width="150px"/>
                                    <ItemStyle Width="150px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="sro_remark" ItemStyle-Wrap="true"
                                     FilterControlWidth="210px">
                                    <HeaderStyle Width="250px"/>
                                    <ItemStyle Width="250px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" AllowFiltering="False" 
                                    ItemStyle-HorizontalAlign="Right">
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
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" ItemStyle-ForeColor="Red"
                                    ConfirmText="Data yang telah dihapus tidak bisa dikembalikan. Yakin akan menghapus?" 
                                    ConfirmTitle="Delete" ConfirmDialogType="Classic" ButtonType="FontIconButton">
                                </telerik:GridButtonColumn>
                            </Columns>

                            <EditFormSettings EditFormType="WebUserControl" UserControlName="entry.ascx">
                                <EditColumn UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <ClientSettings>
                            <Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="375px" />
                            <Selecting AllowRowSelect="true" />
                            <ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />
                        </ClientSettings>
                    </telerik:RadGrid>
                <%--</ContentTemplate>
            </asp:UpdatePanel>--%>
           
        </div>
        <%--<div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 5px; width:auto; height:300px;">
            <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="98.5%" 
            SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Silk" CausesValidation="false">
            <Tabs>                
                <telerik:RadTab Text="DMBD" Height="10px">
                </telerik:RadTab>
                <telerik:RadTab Text="External Service" Height="10px"> 
                </telerik:RadTab>
                <telerik:RadTab Text="Operation" Height="10px">
                </telerik:RadTab>  
                <telerik:RadTab Text="Material Request" Height="10px">
                </telerik:RadTab>               
            </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage runat="server" ID="RadMultiPage1"  SelectedIndex="0" Width="98.5%" >                
                <telerik:RadPageView runat="server" ID="RadPageView2" Height="270px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="3"  Skin="Silk"
                        AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True"  
                        OnNeedDataSource="RadGrid2_NeedDataSource" 
                        OnInsertCommand="RadGrid2_InsertCommand" 
                        OnUpdateCommand="RadGrid2_UpdateCommand"                        
                        OnDeleteCommand="RadGrid2_DeleteCommand" OnItemCommand="RadGrid2_ItemCommand"
                        ShowStatusBar="true">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader" ForeColor="Teal" Font-Size="11px"/>
                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="trans_id,status,down_date,down_time" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New" InsertItemDisplay="Bottom">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowCancelChangesButton="False" />                                    
                            <Columns>
                                <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                                    <HeaderStyle Width="40px"/>
                                    <ItemStyle Width="60px" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-Width="110px"  ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <telerik:RadDatePicker runat="server" ID="trans_date" Width="110px"  Skin="Silk"
                                        DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.down_date")%>' 
                                        onkeydown="blurTextBox(this, event)" Type="Date">
                                        <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                    </telerik:RadDatePicker>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadDatePicker runat="server" ID="trans_date_edt" Width="120px" Skin="Silk"
                                        DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.down_date")%>'                                        
                                        onkeydown="blurTextBox(this, event)" Type="Date">
                                        <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn HeaderText="Down" HeaderStyle-Width="50px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>                                        
                                        <asp:Label runat="server" ID="lbl_down_time" Text='<%# DataBinder.Eval(Container.DataItem, "down_time") %>'></asp:Label>
                                        </ItemTemplate>
                                    <EditItemTemplate>                                       
                                        <telerik:RadTimePicker ID="rtp_breakdownTime" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.down_time") %>' runat="server" 
                                            RenderMode="Lightweight" Width="70px" AutoPostBack="false"></telerik:RadTimePicker> 
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Act" HeaderStyle-Width="50px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                   ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>                                        
                                        <asp:Label runat="server" ID="lbl_down_act" Text='<%# DataBinder.Eval(Container.DataItem, "down_act") %>'></asp:Label>
                                        </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTimePicker ID="rtp_breakdownAct" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.down_act") %>' runat="server" 
                                            RenderMode="Lightweight" Width="70px" AutoPostBack="false"></telerik:RadTimePicker>  
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Up" HeaderStyle-Width="50px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                    ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>                                        
                                        <asp:Label runat="server" ID="lbl_down_up" Text='<%# DataBinder.Eval(Container.DataItem, "down_up") %>'></asp:Label>
                                        </ItemTemplate>
                                    <EditItemTemplate>                                        
                                        <telerik:RadTimePicker ID="rtp_breakdownUp" runat="server" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.down_up") %>' 
                                            RenderMode="Lightweight" Width="70px" AutoPostBack="false"></telerik:RadTimePicker>  
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>                                
                                <telerik:GridTemplateColumn HeaderText="Status" HeaderStyle-Width="80px" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" 
                                  ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>                                        
                                        <asp:Label runat="server" ID="lbl_status" Text='<%# DataBinder.Eval(Container.DataItem, "status") %>'></asp:Label>
                                        </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_bd_status" EnableLoadOnDemand="True" DataTextField="wo_desc"
                                            DataValueField="wo_status" AutoPostBack="false"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.status") %>'
                                            HighlightTemplatedItems="true" Width="80px" DropDownWidth="850px" DropDownAutoWidth="Enabled" 
                                                OnItemsRequested="cb_bd_status_ItemsRequested">                                                   
                                            <HeaderTemplate>
                                            <table style="width: 670px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 50px;">
                                                        Code
                                                    </td>
                                                    <td style="width: 120px;">
                                                        Status B/D
                                                    </td>  
                                                    <td style="width: 550px;">
                                                        Remark
                                                    </td>                                                        
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 670px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 50px;">
                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                    </td>        
                                                    <td style="width: 120px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['wo_desc']")%>
                                                    </td>
                                                    <td style="width: 550px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['remark']")%>
                                                    </td>                                                                                                
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="380px" ItemStyle-Width="500px" HeaderStyle-HorizontalAlign="Center" 
                                    >
                                    <ItemTemplate>                                        
                                        <asp:Label runat="server" ID="lbl_remark" Text='<%# DataBinder.Eval(Container.DataItem, "remark_activity") %>'></asp:Label>
                                        </ItemTemplate>
                                    <EditItemTemplate>                                        
                                        <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_remark" Width="500px" 
                                            Text='<%# DataBinder.Eval(Container.DataItem, "remark_activity") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView3" Height="270px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" AutoGenerateColumns="false" PageSize="3"  Skin="Silk"
                        AllowPaging="true" AllowSorting="true" runat="server" Width="100%" 
                        OnNeedDataSource="RadGrid3_NeedDataSource" 
                        OnInsertCommand="RadGrid3_InsertCommand"
                        OnUpdateCommand="RadGrid3_UpdateCommand"
                        OnDeleteCommand="RadGrid3_DeleteCommand"
                        ShowStatusBar="true">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader"  />
                        <MasterTableView CommandItemDisplay="Bottom" DataKeyNames="sup_code" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New" InsertItemDisplay="Bottom">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                            <Columns>
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                    HeaderText="Edit" HeaderStyle-Width="70px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-Width="100px" ItemStyle-Width="100px" 
                                    HeaderStyle-HorizontalAlign="Center"  HeaderStyle-ForeColor="#009900"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <telerik:RadDatePicker runat="server" ID="dtpDate" Width="100px"
                                            DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.trans_date")%>' 
                                            onkeydown="blurTextBox(this, event)" Type="Date">
                                            <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                        </telerik:RadDatePicker>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Supplier Code" HeaderStyle-Width="120px" ItemStyle-Width="120px" 
                                    HeaderStyle-HorizontalAlign="Center"  HeaderStyle-ForeColor="#009900"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_SupCode" Text='<%# DataBinder.Eval(Container.DataItem, "sup_code") %>'></asp:Label>
                                    </ItemTemplate>                                    
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Supplier" HeaderStyle-Width="320px" ItemStyle-Width="320px" 
                                    HeaderStyle-HorizontalAlign="Center"  HeaderStyle-ForeColor="#009900"
                                    ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_SupName" Text='<%# DataBinder.Eval(Container.DataItem, "supplier_name") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_supplier" EnableLoadOnDemand="True" DataTextField="supplier_name"
                                            DataValueField="supplier_code" AutoPostBack="true" 
                                            Text='<%# DataBinder.Eval(Container, "DataItem.supplier_name") %>'
                                            HighlightTemplatedItems="true" Width="320px" DropDownWidth="550px" DropDownAutoWidth="Enabled" 
                                            OnItemsRequested="cb_supplier_ItemsRequested" 
                                            OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged" >                                                   
                                            <HeaderTemplate>
                                            <table style="width: 550px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 50px;">
                                                        Code
                                                    </td>
                                                    <td style="width: 250px;">
                                                        Supplier
                                                    </td>                                           
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 550px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 50px;">
                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                    </td>        
                                                    <td style="width: 250px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['supplier_name']")%>
                                                    </td>                                                                                  
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-Width="350px" ItemStyle-Width="350px" HeaderStyle-HorizontalAlign="Center" 
                                     HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_description" Text='<%# DataBinder.Eval(Container.DataItem, "description") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_description" Width="350px"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.description") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Cost" HeaderStyle-Width="110px" ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Right" 
                                     HeaderStyle-ForeColor="#009900" DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_rate" Text='<%# DataBinder.Eval(Container.DataItem, "price", "{0:#,###,###0.00}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_rate" Width="110px"
                                            EnabledStyle-HorizontalAlign="Right"
                                            NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            Text='<%# DataBinder.Eval(Container.DataItem, "price", "{0:#,###,###0.00}") %>'                                            
                                            onkeydown="blurTextBox(this, event)"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                    ButtonType="FontIconButton" ItemStyle-Width="70px" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Red">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>                    
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView4" Height="270px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid4" GridLines="None" AutoGenerateColumns="false" PageSize="3"  Skin="Silk"
                        AllowPaging="true" AllowSorting="true" runat="server" Width="550px" 
                        OnNeedDataSource="RadGrid4_NeedDataSource" 
                        OnInsertCommand="RadGrid4_InsertCommand" 
                        OnDeleteCommand="RadGrid4_DeleteCommand"
                        ShowStatusBar="true">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader"  />
                        <MasterTableView CommandItemDisplay="Bottom" DataKeyNames="chart_code" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" EditItemStyle-Height="15px" EditItemStyle-ForeColor="#3366CC" 
                            InsertItemDisplay="Bottom" CommandItemSettings-AddNewRecordText="New" CommandItemStyle-Height="20px">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="true"
                                ShowCancelChangesButton="false" />
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                            
                            <Columns>              
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                    HeaderText="Edit" HeaderStyle-Width="60px" ItemStyle-Width="60px" UpdateText="Update" >
                                </telerik:GridEditCommandColumn>                  
                                <telerik:GridTemplateColumn HeaderText="Opr. Code" HeaderStyle-Width="120px" ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_chart_code" Text='<%# DataBinder.Eval(Container.DataItem, "chart_code") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Maintenance Operation" HeaderStyle-Width="200px" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left" 
                                        HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_OprName" Width="150px" Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>                                 
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation" EnableLoadOnDemand="True" DataTextField="OprCode"
                                            DataValueField="OprCode" AutoPostBack="true" CausesValidation="false"
                                            HighlightTemplatedItems="true" Width="180px" DropDownWidth="400px" DropDownAutoWidth="Enabled" 
                                        Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'
                                                OnItemsRequested="cb_operation_ItemsRequested"
                                            OnSelectedIndexChanged="cb_operation_SelectedIndexChanged">                                                   
                                            <HeaderTemplate>
                                            <table style="width: 550px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 50px;">
                                                        Code
                                                    </td>
                                                    <td style="width: 250px;">
                                                        Operation Maintenance
                                                    </td>                                           
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 550px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 50px;">
                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                    </td>        
                                                    <td style="width: 250px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['OprName']")%>
                                                    </td>                                                                                  
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>                                                              
                                </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView5" Height="270px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid5" GridLines="None" AutoGenerateColumns="false" PageSize="5" Skin="Silk"
                        AllowPaging="true" AllowSorting="true" runat="server" 
                        OnNeedDataSource="RadGrid5_NeedDataSource"
                        OnInsertCommand="RadGrid5_InsertCommand"
                        OnUpdateCommand="RadGrid5_InsertCommand" 
                        OnEditCommand="RadGrid5_EditCommand"
                        OnDeleteCommand="RadGrid5_DeleteCommand" >
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader"  />
                        <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="part_code, sro_code" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New" InsertItemDisplay="Top">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowCancelChangesButton="False" SaveChangesText="Save" 
                                CancelChangesText="Cancel" ShowPrintButton="true" />
                                                   
                            <Columns>
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                    HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update" ItemStyle-Width="60px" >
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn HeaderText="MR. Code" HeaderStyle-Width="120px" ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_trans_id" Width="120px" Text='<%# DataBinder.Eval(Container.DataItem, "sro_code") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:Label runat="server" ID="lbl_trans_id_insert" Width="120px"></asp:Label>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Operation" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Left" 
                                        HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_operation" Width="150px" Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>                                 
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation" EnableLoadOnDemand="True" DataTextField="OprCode"
                                            DataValueField="OprCode" AutoPostBack="true" CausesValidation="false" Enabled="false"
                                            HighlightTemplatedItems="true" Width="150px" DropDownWidth="300px" DropDownAutoWidth="Enabled" 
                                            Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'
                                            OnItemsRequested="cb_MR_operation_ItemsRequested" 
                                            OnPreRender="cb_MR_operation_PreRender"
                                            OnSelectedIndexChanged="cb_MR_operation_SelectedIndexChanged">                                                   
                                            <HeaderTemplate>
                                            <table style="width: 300px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 50px;">
                                                        Code
                                                    </td>
                                                    <td style="width: 250px;">
                                                        Operation Maintenance
                                                    </td>                                           
                                                </tr>
                                            </table>                                                       
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 300px; font-size:smaller">
                                                    <tr>
                                                        <td style="width: 50px;">
                                                            <%# DataBinder.Eval(Container, "Value")%>
                                                        </td>        
                                                        <td style="width: 250px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['OprName']")%>
                                                        </td>                                                                                  
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>                                                              
                                </EditItemTemplate>                                        
                                <InsertItemTemplate>
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation_insertTemp" EnableLoadOnDemand="True" DataTextField="OprCode"
                                        DataValueField="OprCode" AutoPostBack="true" CausesValidation="false"
                                        HighlightTemplatedItems="true" Width="150px" DropDownWidth="300px" DropDownAutoWidth="Enabled" 
                                        OnItemsRequested="cb_MR_operation_ItemsRequested"
                                        OnSelectedIndexChanged="cb_MR_operation_SelectedIndexChanged">                                                   
                                        <HeaderTemplate>
                                        <table style="width: 300px; font-size:smaller">
                                            <tr>
                                                <td style="width: 50px;">
                                                    Code
                                                </td>
                                                <td style="width: 250px;">
                                                    Operation Maintenance
                                                </td>                                           
                                            </tr>
                                        </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 300px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 50px;">
                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                    </td>        
                                                    <td style="width: 250px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['OprName']")%>
                                                    </td>                                                                                  
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>                                                              
                                </InsertItemTemplate>
                                </telerik:GridTemplateColumn>                                       
                                <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_prodType" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                                    </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label runat="server" ID="lbl_prodType_editTemp" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                                </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:Label runat="server" ID="lbl_prodType_insertTemp" Width="50px" ></asp:Label>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="130px" ItemStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_partCode" Width="130px" Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="Prod_code"
                                            DataValueField="Prod_code" AutoPostBack="true" Enabled="false"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.part_code") %>' EmptyMessage="- Select product -"
                                            HighlightTemplatedItems="true" Width="130px" DropDownWidth="450px" DropDownAutoWidth="Enabled" 
                                            OnItemsRequested="cb_prod_code_ItemsRequested"
                                            OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged"  >                                                   
                                            <HeaderTemplate>
                                            <table style="width: 450px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 230px;">
                                                        Prod. Name
                                                    </td>     
                                                    <td style="width: 120px;">
                                                        Prod. Code
                                                    </td>
                                                    <td style="width: 50px;">
                                                        UoM
                                                    </td>                                                        
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 450px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 230px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                    </td>        
                                                    <td style="width: 120px;">
                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                    </td>
                                                    <td style="width: 50px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['unit']")%>
                                                    </td>                                                                                                
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_insertTemp" EnableLoadOnDemand="True" DataTextField="spec"
                                            DataValueField="prod_code" AutoPostBack="true"
                                            EmptyMessage="- Search product name here -"
                                            HighlightTemplatedItems="true" Height="190px" Width="130px" DropDownWidth="450px"
                                            OnItemsRequested="cb_prod_code_ItemsRequested" 
                                            OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged">                                                   
                                            <HeaderTemplate>
                                            <table style="width: 450px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 350px;">
                                                        Prod. Name
                                                    </td>     
                                                    <td style="width: 120px;">
                                                        Prod. Code
                                                    </td>
                                                    <td style="width: 50px;">
                                                        UoM
                                                    </td>                                                        
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 450px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                    </td>        
                                                    <td style="width: 120px;">
                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                    </td>
                                                    <td style="width: 50px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['unit']")%>
                                                    </td>                                                                                                
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblPartQty" Width="70px" Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="70px"  ReadOnly="false" 
                                            EnabledStyle-HorizontalAlign="Right"
                                            NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'
                                            onkeydown="blurTextBox(this, event)"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2">
                                        </telerik:RadNumericTextBox>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty_insertTemp" Width="70px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"                                                
                                            onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2" >
                                        </telerik:RadNumericTextBox>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_UoM" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label runat="server" ID="lbl_UoM_editTemp" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:Label runat="server" ID="lbl_UoM_insertTemp" Width="50px" ></asp:Label>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Waranty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chk_waranty" Text="Warranty" Width="70px"
                                            Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox runat="server" ID="chk_waranty_editTemp" Width="70px" Text="Warranty"  Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="true" />
                                    </EditItemTemplate> 
                                    <InsertItemTemplate>
                                        <asp:CheckBox runat="server" ID="chk_waranty_insertTemp" Width="70px" Text="Warranty" Enabled="true" />
                                    </InsertItemTemplate>                                         
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="310px" ItemStyle-Width="310px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_remark" Width="310px" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_editTemp" Width="310px"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_insertTemp" Width="310px"
                                        ></telerik:RadTextBox>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>                                
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                                     HeaderStyle-ForeColor="#009900" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ItemStyle-ForeColor="Red"
                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                </telerik:GridButtonColumn>

                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </div>--%>
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
 
        
</asp:Content>
