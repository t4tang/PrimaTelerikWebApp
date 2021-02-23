<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc01h06.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.ReadingRecording.mtc01h06" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    
    <script type="text/javascript" src="../../../Script/Script.js" ></script>

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

            function openWinSingleEntryTemplate() {
                var singleEntryDialog = $find("<%=SingleEntryDialogWindows.ClientID%>");
                singleEntryDialog.show();
            }

            function openWinMultiEntryTemplate() {
                var multiEntryDialog = $find("<%=MultiEntryDialogWindows.ClientID%>");
                multiEntryDialog.show();
            }

            function openWinBreakdownEntryTemplate() {
                var breakdownEntryDialog = $find("<%=BreakdownEntryDialogWindows.ClientID%>");
                breakdownEntryDialog.show();
            }
           
            Sys.Application.add_load(function () {
            $windowContentDemo.contentTemplateID = "<%=SingleEntryDialogWindows.ClientID%>";
            $windowContentDemo.templateWindowID = "<%=SingleEntryDialogWindows.ClientID %>";
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
                   <%-- <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel2" ></telerik:AjaxUpdatedControl>  --%>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2" ></telerik:AjaxUpdatedControl>
                </UpdatedControls>        
            </telerik:AjaxSetting> 
            <%--<telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_unit"></telerik:AjaxUpdatedControl>
                </UpdatedControls>        
            </telerik:AjaxSetting> --%>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
    <img alt="Loading..." src="../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 170px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
   <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
   <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="2000" BackgroundPosition="Center"></telerik:RadAjaxLoadingPanel>
   
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="MultiEntryDialogWindows" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="750px" Height="450px" VisibleStatusbar="False" AutoSize="True">
        <ContentTemplate>
            <div runat="server" style="padding: 20px 10px 10px 10px;">

            </div>
        </ContentTemplate>
    </telerik:RadWindow>
    
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="SingleEntryDialogWindows" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="600px" Height="400px" VisibleStatusbar="False" AutoSize="False">
        <ContentTemplate>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div runat="server" style="padding: 20px 10px 10px 10px;">
                    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:2px ">
                         <table style="padding: 0px 0px 2px 0px">
                            <tr>
                                <td style="width:82%">
                                    <telerik:RadLabel ID="RadLabel1" runat="server" Style="font-weight: lighter; font-size: 20px; font-variant: small-caps; padding-left: 10px; 
                                    padding-bottom: 0px; color:white;" BackColor="DeepSkyBlue" Text="Reading Recording Single Entry"></telerik:RadLabel>
                                </td>
                                <td style="text-align:right">
                            
                                    <asp:ImageButton runat="server" ID="btnNew_single" AlternateText="New" ToolTip="Add New" Height="25px" OnClick="btnNew_Click" 
                                        Width="27px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                                    &nbsp;
                                    <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" Height="25px" Width="27px" OnClick="btnSave_Click"
                                        ImageUrl="~/Images/simpan.png">
                                    </asp:ImageButton>
                                </td> 
                            </tr>
                        </table> 
                    </div>
                    <div style="border-bottom-style:outset; border-bottom-color:deeppink; border-bottom-width:thin">      
                         <table>
                             <tr>
                                 <td>
                                     <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                 </td>
                                 <td>
                                     <asp:UpdatePanel runat="server">
                                         <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_project" runat="server" RenderMode="Lightweight" AutoPostBack="true" CausesValidation="false"
                                                EnableLoadOnDemand="True"  Skin="Silk" OnItemsRequested="cb_Project_ItemsRequested" OnSelectedIndexChanged="cb_Project_SelectedIndexChanged"
                                                EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="280px">
                                            </telerik:RadComboBox>                                             
                                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_project" ForeColor="Red" Font-Size="X-Small" 
                                            Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>  
                                 </td>
                             </tr>
                             <tr>
                                 <td>
                                     <telerik:RadLabel runat="server" Text="Equipment Code :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                 </td>
                                 <td>
                                 <asp:UpdatePanel runat="server">
                                     <ContentTemplate>
                                        <telerik:RadComboBox ID="cb_unit" runat="server" RenderMode="Lightweight" AutoPostBack="true" CausesValidation="false"
                                            EnableLoadOnDemand="True"  Skin="Silk" 
                                            OnItemsRequested="cb_unit_ItemsRequested" OnSelectedIndexChanged="cb_unit_SelectedIndexChanged"
                                            EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="200px">
                                        </telerik:RadComboBox>
                                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_unit" ForeColor="Red" Font-Size="X-Small" 
                                            Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                     </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cb_project" />
                                    </Triggers>
                                 </asp:UpdatePanel>                                     
                                 </td>
                             </tr>
                             <tr>
                                 <td>
                                     <telerik:RadLabel runat="server" Text="Type :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                 </td>
                                 <td>
                                     <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_type" Width="100px" Skin="Silk" ReadOnly="true">
                                    </telerik:RadTextBox>
                                     &nbsp;&nbsp; <asp:CheckBox ID="chk_breakdown" runat="server" Text="Breakdown" />
                                 </td>
                             </tr>
                         </table>
                         <table>
                             <tr>
                                 <td style="vertical-align:top">
                                     <table>
                                         <tr>
                                             <td colspan="2">
                                                 <br />
                                                 <telerik:RadLabel runat="server" Text="Last Reading" CssClass="lbObject" ForeColor="Highlight"></telerik:RadLabel>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <telerik:RadLabel runat="server" Text="Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                             </td>
                                             <td>
                                                 <%--<telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_last_reading_date" Width="100px" ReadOnly="true">
                                                    </telerik:RadTextBox>--%>
                                                 <telerik:RadDatePicker ID="dtp_last_reading_date" runat="server" MinDate="1/1/1900" Width="120px" RenderMode="Lightweight"
                                                    Font-Size="11px" TabIndex="4" Skin="Silk"> 
                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="MetroTouch" 
                                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                    </DateInput>                        
                                                </telerik:RadDatePicker>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <telerik:RadLabel runat="server" Text="HM / KM :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                             </td>
                                             <td>
                                                <%-- <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_last_HM_KM" Width="100px" ReadOnly="true">
                                                    </telerik:RadTextBox>--%>
                                                 <telerik:RadNumericTextBox ID="txt_last_HM_KM" runat="server" Width="120px" ReadOnly="true" RenderMode="Lightweight" 
                                                    Font-Size="11px" Skin="Silk" CausesValidation="false"  NumberFormat-KeepNotRoundedValue="true" 
                                                     AllowOutOfRangeAutoCorrect="false" Value="0" 
                                                    onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" AutoPostBack="true">
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox" HorizontalAlign="Right"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadNumericTextBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <telerik:RadLabel runat="server" Text="Accum HM / KM :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                             </td>
                                             <td>
                                                 <%--<telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_last_HM_KM_accum" Width="100px" ReadOnly="true">
                                                    </telerik:RadTextBox>--%>
                                                 <telerik:RadNumericTextBox ID="txt_last_HM_KM_accum" runat="server" Width="120px" ReadOnly="true" RenderMode="Lightweight" 
                                                    Font-Size="11px" Skin="Silk" CausesValidation="false"  NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" Value="0" 
                                                    onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" AutoPostBack="true">
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox" HorizontalAlign="Right"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadNumericTextBox>
                                             </td>
                                         </tr>
                                     </table>
                                 </td>
                                 <td style="vertical-align:top">
                                     <table>
                                         <tr>
                                             <td colspan="2">
                                                 <br />
                                                 <telerik:RadLabel runat="server" Text="Current Reading" CssClass="lbObject" ForeColor="Highlight"></telerik:RadLabel>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <telerik:RadLabel runat="server" Text="Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                             </td>
                                             <td>
                                                 <telerik:RadDatePicker ID="dtp_current_date" runat="server" MinDate="1/1/1900" Width="120px" RenderMode="Lightweight"
                                                    TabIndex="4" Skin="Silk" Font-Size="11px"> 
                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="MetroTouch" 
                                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                    </DateInput>                        
                                                </telerik:RadDatePicker>
                                                 <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="dtp_current_date" ForeColor="Red" 
                                                     Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>
                                                 <telerik:RadLabel runat="server" Text="Reading :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                             </td>
                                             <td>
                                                 <telerik:RadNumericTextBox ID="txt_HM" runat="server" Width="120px" ReadOnly="false" RenderMode="Lightweight" 
                                                    Skin="Silk" CausesValidation="false"  NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" Value="0" 
                                                    onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" AutoPostBack="true">
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox" HorizontalAlign="Right"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadNumericTextBox>
                                                 <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="txt_HM" ForeColor="Red" 
                                                     Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                             </td>
                                         </tr>
                                     </table>
                                 </td>
                             </tr>
                         </table>
                    </div>
                </div>               
            </ContentTemplate>
        </asp:UpdatePanel>
        </ContentTemplate>
    </telerik:RadWindow>
        
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="BreakdownEntryDialogWindows" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="750px" Height="450px" VisibleStatusbar="False" AutoSize="True">
        <ContentTemplate>
            <div runat="server" style="padding: 20px 10px 10px 10px;">

            </div>
        </ContentTemplate>
    </telerik:RadWindow>


    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:2px ">
        <table id="tbl_control">
            <tr>                     
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="btnSingleEntry" AlternateText="New" OnClick="btnNew_Click" OnClientClick="openWinSingleEntryTemplate(); return false;" 
                        ToolTip="Single Entry" Height="30px" Width="32px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                </td>                 
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="btnMultiEntry" AlternateText="New" OnClientClick="openWinMultiEntryTemplate(); return false;" ToolTip="Multi Entry"
                        Height="31px" Width="30px" ImageUrl="~/Images/multi_entry.png"></asp:ImageButton>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="btnBreakdownEntry" AlternateText="New Breakdown" OnClientClick="openWinBreakdownEntryTemplate(); return false;" ToolTip="Breakdown"
                        Height="29px" Width="34px" ImageUrl="~/Images/damaged.png"></asp:ImageButton>
                </td>
                <td style="width: 90%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>   

    <div  class="scroller" runat="server" style="overflow-y:scroll; height:620px;">
        <div style="float:left; width:37%" runat="server"> 

            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Silk" Width="425px"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="14"
                OnNeedDataSource="RadGrid1_NeedDataSource"
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" >
                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>                
                <HeaderStyle CssClass="gridHeader" Font-Size="Small" ForeColor="Highlight" />
                <ClientSettings EnablePostBackOnRowClick="True"></ClientSettings>
                <SortingSettings EnableSkinSortStyles="false" />
                <MasterTableView CommandItemDisplay="Top" DataKeyNames="unit_code" Font-Size="12px" 
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="True" CommandItemSettings-ShowAddNewRecordButton="false"
                        CommandItemSettings-ShowRefreshButton="false" FilterItemStyle-Height="10px" >
                    <Columns>
                        <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="20px"></telerik:GridClientSelectColumn>
                        <telerik:GridBoundColumn UniqueName="unit_code" HeaderText="Unit Code" DataField="unit_code" ItemStyle-Width="100px"  
                            ItemStyle-HorizontalAlign="Center">
                            <HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn> 
                        <telerik:GridBoundColumn UniqueName="model_no" HeaderText="Model" DataField="model_no" >
                            <HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle Width="150px" HorizontalAlign="Left" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="key_no" HeaderText="Key No" DataField="key_no" >
                            <HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle Width="150px" HorizontalAlign="Left" />
                        </telerik:GridBoundColumn>
                        
                    </Columns>
                </MasterTableView>
                <ClientSettings>                         
                    <Selecting AllowRowSelect="true"></Selecting>
                    <ClientEvents OnRowDblClick="RowDblClick" />
                </ClientSettings>
            </telerik:RadGrid>               
        </div>

        <div style="float:left; width:35%; padding-top:10px">       
            <table style="padding: 0px 0px 5px 0px">                
                <tr >
                    <td >
                        <telerik:RadLabel runat="server" Text="Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                        <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="100px"  Skin="Silk" DateInput-CausesValidation="false"
                            DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                        </telerik:RadDatePicker>
                    </td>
                    <td >
                        <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                        <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="100px"  Skin="Silk"  DateInput-CausesValidation="false"
                            DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                        </telerik:RadDatePicker>
                    </td>
                     <td >
                        <telerik:RadButton ID="btnSearch" runat="server" Text="Retrieve" Width="100px" Height="23px" CausesValidation="false" CssClass="btn-filter"
                            Skin="Silk" ForeColor="Orange" OnClick="btnSearch_Click"></telerik:RadButton>
                    </td>
                </tr>
            </table>         
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid2"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Silk" Width="100%"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="12"
                OnNeedDataSource="RadGrid2_NeedDataSource" >
                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>                
                <HeaderStyle CssClass="gridHeader" />
                <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                <SortingSettings EnableSkinSortStyles="false" />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="unit_code, reading_date" Font-Size="12px" 
                    HeaderStyle-Font-Size="11px" HeaderStyle-BorderColor="Teal" HeaderStyle-BorderStyle="None"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="false" CommandItemSettings-ShowAddNewRecordButton="false"
                    HeaderStyle-ForeColor="Teal" HeaderStyle-Font-Bold="true"  CommandItemSettings-ShowRefreshButton="false" >
                    
                    <Columns>
                        <telerik:GridDateTimeColumn UniqueName="reading_date" HeaderText="Date" DataField="reading_date" 
                            EnableRangeFiltering="false" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="40px"></HeaderStyle>
                            <ItemStyle Width="40px" />
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="reading_amount1" HeaderText="Entered Reading" DataField="reading_amount1" 
                            ItemStyle-HorizontalAlign="Right" ItemStyle-Width="60px">
                            <HeaderStyle Width="80px" HorizontalAlign="Right"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="reading_amount3" HeaderText="Accum. Reading" DataField="reading_amount3" 
                            ItemStyle-HorizontalAlign="Right" ItemStyle-Width="60px">
                            <HeaderStyle Width="70px" HorizontalAlign="Right"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="wh" HeaderText="WH" DataField="wh"  ItemStyle-HorizontalAlign="center"
                            ItemStyle-Width="35px" >
                            <HeaderStyle Width="40px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
                <ClientSettings>                         
                    <Selecting AllowRowSelect="true" ></Selecting>
                    <ClientEvents OnRowDblClick="RowDblClick" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>

         <div style="float:right;width:32%; padding-top:10px">
            
            
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
