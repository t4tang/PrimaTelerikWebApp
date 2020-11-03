﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc01h01.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.WorkOrder.mtc01h01" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("reportViewer_mtc01h01.aspx?trans_id=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
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
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik" DateInput-CausesValidation="false"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                        <td >
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"  DateInput-CausesValidation="false"
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
                            <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="95%" Height="25px" CausesValidation="false"
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
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:lighter">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

    <div  class="scroller" runat="server" >
        
        <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Telerik"
            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="5"
            OnNeedDataSource="RadGrid1_NeedDataSource1"
            OnDeleteCommand="RadGrid1_DeleteCommand"
            OnItemCreated="RadGrid1_ItemCreated"
            OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged">
            <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
            <ClientSettings EnablePostBackOnRowClick="true" >
            </ClientSettings>
            <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="trans_id" Font-Size="12px"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false">
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="30px" ></telerik:GridClientSelectColumn> 
                    <telerik:GridBoundColumn UniqueName="trans_id" HeaderText="WO. Number" DataField="trans_id">
                        <HeaderStyle Width="120px"></HeaderStyle>
                        <ItemStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="unit_code" HeaderText="Unit Code" DataField="unit_code" ItemStyle-HorizontalAlign="Left"  
                            FilterControlWidth="100px" >
                        <HeaderStyle Width="80px"></HeaderStyle>
                        <ItemStyle Width="80px" />
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
                    <telerik:GridDateTimeColumn UniqueName="trans_date" HeaderText="Date" DataField="trans_date" ItemStyle-Width="100px" 
                            EnableRangeFiltering="false" FilterControlWidth="90px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                        <HeaderStyle Width="80px"></HeaderStyle>
                        <ItemStyle Width="80px" />
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" ItemStyle-HorizontalAlign="Left" 
                            FilterControlWidth="170px" >
                        <HeaderStyle Width="170px"></HeaderStyle>
                        <ItemStyle Width="170px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="wo_desc" HeaderText="Status" DataField="wo_desc" ItemStyle-HorizontalAlign="Left" 
                            FilterControlWidth="70px" >
                        <HeaderStyle Width="70px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="orderName" HeaderText="Order Type" DataField="orderName" ItemStyle-HorizontalAlign="Left" 
                            FilterControlWidth="150px" >
                        <HeaderStyle Width="150px"></HeaderStyle>
                        <ItemStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="sro_remark" ItemStyle-Wrap="true"
                                ItemStyle-Width="240px" FilterControlWidth="250px">
                        <HeaderStyle Width="240px"></HeaderStyle>
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
                        ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>
            <ClientSettings>
                <Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="200px" />
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
        </telerik:RadGrid>

        <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 10px;">
            <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="97%" 
            SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Telerik" CausesValidation="false">
            <Tabs>
                <telerik:RadTab Text="Component" Height="15px"> 
                </telerik:RadTab>
                <telerik:RadTab Text="DMBD" Height="15px">
                </telerik:RadTab>
                <telerik:RadTab Text="External Service" Height="15px"> 
                </telerik:RadTab>
                <telerik:RadTab Text="Operation" Height="15px">
                </telerik:RadTab>  
                <telerik:RadTab Text="Material Request" Height="15px">
                </telerik:RadTab>               
            </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage runat="server" ID="RadMultiPage1"  SelectedIndex="0" Width="97%" >
                <telerik:RadPageView runat="server" ID="RadPageView1" Height="275px">
                    <table>
                        <tr>
                            <td>
                                <telerik:RadLabel runat="server" Text="Comp. Group:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_compGroup" ForeColor="Red" 
                                Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                            </td>
                            <td>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_compGroup" runat="server" Width="300" DropDownWidth="300px"
                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                    Font-Size="Small" >
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel runat="server" Text="Comp.:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_comp" ForeColor="Red" 
                                Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                            </td>
                            <td>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_comp" runat="server" Width="300" DropDownWidth="300px"
                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                    Font-Size="Small" >
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel runat="server" Text="Diagnosis :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_diagnosis" ForeColor="Red" 
                                Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                            </td>
                            <td>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_diagnosis" runat="server" Width="300" DropDownWidth="300px"
                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                    Font-Size="Small" >
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel runat="server" Text="Symptom :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_symptom" ForeColor="Red" 
                                Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                            </td>
                            <td>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_symptom" runat="server" Width="300" DropDownWidth="300px"
                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                    Font-Size="13px" >
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel runat="server" Text="Job Description :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="txt_jobDesc" ForeColor="Red" 
                                Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txt_jobDesc"
                                    runat="server" TextMode="MultiLine" Font-Size="13px"
                                    Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>                    
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView2" Height="275px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
                        AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"  
                        OnNeedDataSource="RadGrid2_NeedDataSource" 
                        ShowStatusBar="true">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                        <MasterTableView CommandItemDisplay="None" DataKeyNames="trans_id" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                            <GroupByExpressions>
                                <telerik:GridGroupByExpression>
                                    <SelectFields>
                                        <telerik:GridGroupByField FieldAlias="Operation" FieldName="OprName"></telerik:GridGroupByField>
                                    </SelectFields>
                                    <GroupByFields>
                                        <telerik:GridGroupByField FieldName="OprName" ></telerik:GridGroupByField>
                                    </GroupByFields>
                                </telerik:GridGroupByExpression>
                                
                            </GroupByExpressions>
                            <Columns>
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                    HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update" >
                                </telerik:GridEditCommandColumn>
                                <telerik:GridDateTimeColumn UniqueName="trans_date" HeaderText="Date" DataField="trans_date" ItemStyle-Width="100px" 
                                        EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                                        DataFormatString="{0:d}" >
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle Width="80px" />
                                </telerik:GridDateTimeColumn>
                                <telerik:GridTemplateColumn HeaderText="Down" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>                                        
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_down_time" Width="50px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                            DbValue='<%# Convert.ToDouble(Eval("down_time")) %>'
                                            onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2">
                                        </telerik:RadNumericTextBox>
                                    </ItemTemplate>
                                    
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Act" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_down_act" Width="50px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                            DbValue='<%# Convert.ToDouble(Eval("down_act")) %>'
                                            onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2" >
                                        </telerik:RadNumericTextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Up" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%--<asp:Label runat="server" ID="lbl_down_up" Text='<%# DataBinder.Eval(Container.DataItem, "down_up", "{0:#,###,###0.00}") %>'></asp:Label>--%>
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_down_up" Width="50px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                            DbValue='<%# Convert.ToDouble(Eval("down_up")) %>'
                                            onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2">
                                        </telerik:RadNumericTextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Tot. Down Time" HeaderStyle-Width="100px" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <%--<asp:Label runat="server" ID="lbl_tot" Text='<%# DataBinder.Eval(Container.DataItem, "tot_time_down", "{0:#,###,###0.00}") %>'></asp:Label>--%>
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_tot_time_down" Width="100px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                            DbValue='<%# Convert.ToDouble(Eval("tot_time_down")) %>'
                                            onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2">
                                        </telerik:RadNumericTextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Status" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%--<asp:Label runat="server" ID="lbl_status" Text='<%# DataBinder.Eval(Container.DataItem, "status") %>'></asp:Label>--%>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_bd_status" EnableLoadOnDemand="True" DataTextField="Prod_code"
                                            DataValueField="Prod_code" AutoPostBack="true"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.status") %>'
                                            HighlightTemplatedItems="true" Width="130px" DropDownWidth="550px" DropDownAutoWidth="Enabled" 
                                            OnItemsRequested="cb_bd_status_ItemsRequested" >                                                   
                                            <HeaderTemplate>
                                            <table style="width: 550px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 50px;">
                                                        Code
                                                    </td>
                                                    <td style="width: 120px;">
                                                        Status B/D
                                                    </td>     
                                                   <%-- <td style="width: 120px;">
                                                        Type B/D
                                                    </td>--%>
                                                    <td style="width: 250px;">
                                                        Remark
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
                                                    <td style="width: 120px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['wo_desc']")%>
                                                    </td>
                                                   <%-- <td style="width: 120px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['unit']")%>
                                                    </td>--%>
                                                    <td style="width: 250px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['remark']")%>
                                                    </td>                                                                                                
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="250px" ItemStyle-Width="250px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>                                        
                                        <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_remark" Width="250px" 
                                            Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'>
                                        </telerik:RadTextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView3" Height="275px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
                        AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" Width="1100px" 
                        OnNeedDataSource="RadGrid3_NeedDataSource" 
                        ShowStatusBar="true">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                        <MasterTableView CommandItemDisplay="None" DataKeyNames="sup_code" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                            <Columns>
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                    HeaderText="Edit" HeaderStyle-Width="70px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridDateTimeColumn UniqueName="trans_date" HeaderText="Date" DataField="trans_date" ItemStyle-Width="100px" 
                                        EnableRangeFiltering="false" PickerType="DatePicker" 
                                        DataFormatString="{0:d}" >
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle Width="100px" />
                                </telerik:GridDateTimeColumn>
                                <telerik:GridTemplateColumn HeaderText="Supplier" HeaderStyle-Width="320px" ItemStyle-Width="320px" 
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_SupName" Text='<%# DataBinder.Eval(Container.DataItem, "supplier_name") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_supplier" EnableLoadOnDemand="True" DataTextField="supplier_name"
                                            DataValueField="supplier_code" AutoPostBack="true" 
                                            Text='<%# DataBinder.Eval(Container, "DataItem.supplier_name") %>'
                                            HighlightTemplatedItems="true" Width="320px" DropDownWidth="550px" DropDownAutoWidth="Enabled" 
                                            OnItemsRequested="cb_supplier_ItemsRequested" >                                                   
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
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
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
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
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
                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>                    
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView4" Height="275px">
                   <%-- <asp:UpdatePanel runat="server">
                        <ContentTemplate>--%>
                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid4" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
                                AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" Width="550px" 
                                OnNeedDataSource="RadGrid4_NeedDataSource" 
                                OnInsertCommand="RadGrid4_InsertCommand" 
                                OnUpdateCommand="RadGrid4_UpdateCommand" 
                                OnDeleteCommand="RadGrid4_DeleteCommand"
                                ShowStatusBar="true">
                                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="chart_code" Font-Size="11px" EditMode="InPlace"
                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" EditItemStyle-Height="15px" EditItemStyle-ForeColor="#3366CC" 
                                            InsertItemDisplay="Top" CommandItemSettings-AddNewRecordText="New item" CommandItemStyle-Height="20px">
                                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="true" ShowCancelChangesButton="false" />
                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                            
                                    <Columns>              
                                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                            HeaderText="Edit" HeaderStyle-Width="60px" ItemStyle-Width="60px" UpdateText="Update" >
                                        </telerik:GridEditCommandColumn>                  
                                        <telerik:GridTemplateColumn HeaderText="Opr. Code" HeaderStyle-Width="120px" ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lbl_chart_code" Text='<%# DataBinder.Eval(Container.DataItem, "chart_code") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Maintenance Operation" HeaderStyle-Width="200px" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
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
                       <%-- </ContentTemplate>
                    </asp:UpdatePanel>--%>
                    
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView5" Height="245px">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid5" GridLines="None" AutoGenerateColumns="false" PageSize="5" Skin="Telerik"
                                AllowPaging="true" AllowSorting="true" runat="server" ShowStatusBar="true"
                                ClientSettings-EnableAlternatingItems="True" ItemStyle-Height="15px" 
                                AllowAutomaticDeletes="True" AllowAutomaticInserts="True"  
                                OnNeedDataSource="RadGrid5_NeedDataSource" >
                                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                                <MasterTableView CommandItemDisplay="None" DataKeyNames="part_code" Font-Size="11px"
                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="Add" InsertItemDisplay="Bottom">
                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                                                   
                                    <Columns>
                                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                            HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update" >
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lbl_prodType" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lbl_partCode" Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="Prod_code"
                                                    DataValueField="Prod_code" AutoPostBack="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.part_code") %>' EmptyMessage="- Select product -"
                                                    HighlightTemplatedItems="true" Width="130px" DropDownWidth="550px" DropDownAutoWidth="Enabled" 
                                                    OnItemsRequested="cb_prod_code_ItemsRequested"
                                                    OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged"  >                                                   
                                                    <HeaderTemplate>
                                                    <table style="width: 550px; font-size:smaller">
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
                                                    <table style="width: 550px; font-size:smaller">
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
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblPartQty" Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="80px"  ReadOnly="false" 
                                                    EnabledStyle-HorizontalAlign="Right"
                                                    NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'
                                                    onkeydown="blurTextBox(this, event)"
                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                    NumberFormat-DecimalDigits="2">
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                       <%-- <telerik:GridTemplateColumn HeaderText="QRS" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                <ItemTemplate>
                                                <asp:Label runat="server" ID="lblQtyRs" Text='<%# DataBinder.Eval(Container.DataItem, "qty_pr", "{0:#,###,###0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                                           
                                        </telerik:GridTemplateColumn>--%>
                                        <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lbl_UoM" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Waranty" HeaderStyle-Width="50px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" 
                                                HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chk_waranty" Text="Warranty"
                                                    Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox runat="server" ID="chk_warranty" Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                                            </EditItemTemplate>                                        
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="250px" ItemStyle-Width="250px" HeaderStyle-HorizontalAlign="Center" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lbl_remark" Width="250px" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="310px"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                                <ClientSettings>                         
                                    <%-- <Scrolling AllowScroll="true" UseStaticHeaders="false" ScrollHeight="273px" />--%>
                                    </ClientSettings>
                            </telerik:RadGrid>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
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
