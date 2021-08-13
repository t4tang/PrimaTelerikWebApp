﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h05r.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.PartReturn.inv01h05r" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/common.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js"></script>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("inv01h04ReportViewer.aspx?do_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("inv01h04EditForm.aspx", "EditDialogWindows");
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
    <asp:UpdatePanel ID="UpdatePanel22" runat="server">
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
            
        </AjaxSettings>
    </telerik:RadAjaxManager>
        
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="700" BackgroundPosition="None" BackColor="Transparent" >
        <img alt="Loading..." src="../../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 115px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="700" BackgroundPosition="None" >
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="2000"></telerik:RadAjaxLoadingPanel>

    
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone" Skin="Windows7"
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
                                OnItemsRequested="cb_project_prm_ItemsRequested"
                                OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
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

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>                  
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" ToolTip="Add New"
                       OnClick="btnNew_Click"  Height="26px" Width="27px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="29px" Width="30px" ImageUrl="~/Images/search.png"></asp:ImageButton>
                </td>
                <td style="width: 97%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#0099dc; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>     

    <div  class="scroller" runat="server" style="overflow-y:scroll; height:620px">
        <div style="width:100%; overflow-y:hidden; min-height:280px; scrollbar-highlight-color:#b6ff00;"> 
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Silk" CssClass="RadGrid_ModernBrowsers" 
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="14"
                OnNeedDataSource="RadGrid1_NeedDataSource" 
                OnDeleteCommand="RadGrid1_DeleteCommand" 
                OnItemCreated="RadGrid1_ItemCreated"
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged"
                OnPreRender="RadGrid1_PreRender" 
                OnItemCommand="RadGrid1_ItemCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle>               
                <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px"/>
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
                <MasterTableView Width="100%" CommandItemDisplay="None" DataKeyNames="do_code" Font-Size="11px" Font-Names="Century Gothic" 
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false" >
                <Columns>
                    <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  
                            HeaderStyle-Width="30px" ItemStyle-Width="30px" UpdateText="Update" >
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn UniqueName="do_code" HeaderText="GR Number" DataField="do_code" ItemStyle-Width="100px" FilterControlWidth="100px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="ref_code" HeaderText="Reff. Number" DataField="ref_code" ItemStyle-Width="100px" FilterControlWidth="100px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="120px"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn UniqueName="lbm_date" HeaderText="GR. Date" DataField="lbm_date" ItemStyle-Width="80px"
                        EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker"
                        DataFormatString="{0:d}">
                        <HeaderStyle Width="120px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project" DataField="region_code" ItemStyle-Width="60px" FilterControlWidth="50px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="80px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="warehouse" HeaderText="WH Code" DataField="wh_code" ItemStyle-Width="60px" FilterControlWidth="60px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="80px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="cust_code" HeaderText="Supp Code" DataField="cust_code" ItemStyle-Width="50px" FilterControlWidth="50px" 
                        ItemStyle-HorizontalAlign="Left" Visible="false" >
                        <HeaderStyle Width="50px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="info_code" HeaderText="info_code" DataField="info_code" ItemStyle-Width="50px" FilterControlWidth="50px" 
                        ItemStyle-HorizontalAlign="Left" Visible="false" >
                        <HeaderStyle Width="50px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="cust_name" HeaderText="Suplier" DataField="cust_name" ItemStyle-Width="150px" FilterControlWidth="150px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true" ItemStyle-Width="200px" AllowFiltering="false">
                        <HeaderStyle Width="200px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>                    
                    <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center"
                            AllowFiltering="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" 
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="20px" HeaderStyle-Width="20px"
                        ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="Classic" ButtonType="FontIconButton">                                
                        <ItemStyle ForeColor="Red" />
                    </telerik:GridButtonColumn>  
                                              
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <div style="padding: 15px 0px 0px 25px;">
                             <table id="Table2" width="Auto" border="0" class="module">
                                <tr>
                                    <td style="vertical-align:top; width:auto">
                                        <table>
                                            
                                            <tr>
                                                <td colspan="2" style="padding: 0px 0px 10px 0px; text-align:left">
                                                    <asp:Button ID="btnSave" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px"  Height="25px" 
                                                        Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" 
                                                        OnClick="btnSave_Click"  CssClass="btn-entryFrm" >
                                                    </asp:Button>&nbsp;
                            
                                                    <asp:Button ID="btnCancel" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" 
                                                        Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                                        runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                                                </td>
                                            </tr>
                                            <tr style="vertical-align: top; width:auto">                               
                                                <td  style="vertical-align: top">
                                                    <telerik:RadLabel runat="server" Text="Return Number:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>                                  
                                                    <telerik:RadTextBox ID="txt_return_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                       Skin="Telerik"  EmptyMessage="Let it blank"
                                                       Text='<%# DataBinder.Eval(Container, "DataItem.do_code") %>' >
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                               <td >
                                                  <telerik:RadLabel runat="server" Text="Return Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                               </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtp_return" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                        TabIndex="4" Skin="Telerik"
                                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.Tgl") %>'> 
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="MetroTouch" 
                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                        </DateInput>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                                    </telerik:RadDatePicker>
                                                </td>
                                           </tr>
                                            <tr>
                                                <td>                            
                                                    <telerik:RadLabel runat="server" Text="Project Area:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td >
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="250px" Height="150px" DropDownWidth="250px"
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>'
                                                        OnItemsRequested="cb_project_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                                        OnPreRender="cb_project_PreRender">
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_project" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>                             
                                                        
                                                </td>
                                           </tr>
                                            <tr>
                                                <td >
                                                    <telerik:RadLabel runat="server" Text="Storage:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="250" DropDownWidth="300px" CausesValidation="false"
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" Font-Size="Small"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.wh_name") %>'
                                                        OnItemsRequested="cb_warehouse_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged" 
                                                        OnPreRender="cb_warehouse_PreRender">
                                                    </telerik:RadComboBox>                                             
                                                    <asp:RequiredFieldValidator runat="server" ID="warehouseValidator" ControlToValidate="cb_warehouse" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>
                                                        
                                                </td>
                                            </tr> 
                                            
                                        </table>
                                    </td>
                                    <td style="vertical-align:top; width:auto; margin-top:25px">
                                        <table>
                                            <tr>
                                                <td class="tdLabel">
                                                    <telerik:RadLabel runat="server" Text="Remark" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>                
                                                <td style="vertical-align:top; text-align:left"> 
                                                    <telerik:RadTextBox ID="txt_remark" runat="server" TextMode="MultiLine"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>' 
                                                        Width="350px" Rows="0" TabIndex="5" Resize="Both" Skin="Telerik">
                                                    </telerik:RadTextBox>              
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: top; text-align: left">
                                                    <telerik:RadLabel runat="server" Text="Created By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="cb_createdBy" runat="server" Width="250px"
                                                        DropDownWidth="400px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.issuedby_name") %>'
                                                        OnItemsRequested="cb_orderBy_ItemsRequested"
                                                        OnSelectedIndexChanged="cb_orderBy_SelectedIndexChanged"
                                                        OnPreRender="cb_orderBy_PreRender">
                                                         <HeaderTemplate>
                                                            <table style="width: 400px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 200px;">Name
                                                                    </td>
                                                                    <td style="width: 200px;">Position
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 400px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 200px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                    </td>
                                                                    <td style="width: 200px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                        </FooterTemplate>
                                                    </telerik:RadComboBox>
                                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: top; text-align: left">
                                                    <telerik:RadLabel runat="server" Text="Received By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>  
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_received" runat="server" Width="250px"
                                                        DropDownWidth="400px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.receivedBy_name") %>'
                                                        OnItemsRequested="cb_received_ItemsRequested"
                                                        OnSelectedIndexChanged="cb_received_SelectedIndexChanged"
                                                        OnPreRender="cb_received_PreRender">
                                                        <HeaderTemplate>
                                                            <table style="width: 400px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 200px;">Name
                                                                    </td>
                                                                    <td style="width: 200px;">Position
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 500px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 200px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                    </td>
                                                                    <td style="width: 200px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                        </FooterTemplate>
                                                    </telerik:RadComboBox>
                                                   
                                                </td>                                                    
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: top; text-align: left; ">
                                                    <telerik:RadLabel CssClass="lbObject" runat="server" Text="Approved By:" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px"
                                                        DropDownWidth="400px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.approveBy_name") %>'
                                                        OnItemsRequested="cb_approved_ItemsRequested"
                                                        OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                        OnPreRender="cb_approved_PreRender" >
                                                        <HeaderTemplate>
                                                            <table style="width: 400px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 200px;">Name
                                                                    </td>
                                                                    <td style="width: 200px;">Position
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 400px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 200px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                    </td>
                                                                    <td style="width: 200px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                        </FooterTemplate>
                                                    </telerik:RadComboBox>
                                                   
                                                </td>
                                            </tr> 
                                            <tr>
                                                
                                            </tr>
                                                   
                                        </table>
                                    </td>
                                </tr>                                    
                                <tr>
                                    <td colspan="4" style ="padding-top:15px; color:cadetblue">
                                        <table>
                                            <tr>   
                                                <td style ="width: 200px"> 
                                                    User: <telerik:RadLabel runat="server" ID="lbl_userId" CssClass="lbObject" Font-Size="Small"/>
                                                </td>
                                                <td style ="width: 200px">
                                                    Last Update: <telerik:RadLabel runat="server" ID="lbl_lastUpdate" CssClass="lbObject" Font-Size="Small"/>
                                                </td>
                                                <td style ="width: 200px">
                                                    Owner: <telerik:RadLabel runat="server" ID="lbl_Owner"  CssClass="lbObject" Font-Size="Small"/>
                                                </td>
                                                <td style ="width: 200px">
                                                    Edited: <telerik:RadLabel runat="server" ID="lbl_edited"  CssClass="lbObject" Font-Size="Small"/>
                                                </td>
                                                <td colspan="2" style="vertical-align:central">
                                                    <asp:CheckBox ID="chk_posting" runat="server" Checked="false" Text="Posting" Enabled="false" />
                                                </td>
                                            </tr>               
                                        </table>
                                    </td>
                                </tr>                  
                               </table>
                                <div style="padding: 7px 0px 12px 0px; min-height:275px">
                                    <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="97%" 
                                    SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Silk" CausesValidation="false">
                                        <Tabs>
                                            <telerik:RadTab Text="Detail" Height="15px"> 
                                            </telerik:RadTab>
                                            <telerik:RadTab Text="Journal" Height="15px">
                                            </telerik:RadTab>
                                        </Tabs>
                                    </telerik:RadTabStrip>
                                    <telerik:RadMultiPage runat="server" ID="RadMultiPage1"  SelectedIndex="0" Width="97%" >
                                        <telerik:RadPageView runat="server" ID="RadPageView1" Height="300px">
                                            <div runat="server" style="padding:10px 10px 10px 10px">
                                                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" runat="server" AllowPaging="False" ShowFooter="false" PageSize="5" Skin="Silk"
                                                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers"
                                                OnNeedDataSource="RadGrid2_NeedDataSource"
                                                OnPreRender="RadGrid2_PreRender"
                                                OnInsertCommand="RadGrid2_InsertCommand" 
                                                OnUpdateCommand="RadGrid2_UpdateCommand"
                                                OnItemCommand="RadGrid2_ItemCommand"                                                 
                                                ClientSettings-Selecting-AllowRowSelect="true"> 
                                                <HeaderStyle Font-Size="12px" />
                                                <PagerStyle Mode="NumericPages" />  
                                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="Prod_code" Font-Size="11px" EditMode="InPlace"
                                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" InsertItemDisplay="Bottom" >                                             
                                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                                        
                                                    <Columns>   
                                                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                                            HeaderText="Edit" HeaderStyle-Width="60px" ItemStyle-Width="60px" UpdateText="Update">
                                                        </telerik:GridEditCommandColumn>                  
                                                                                                     
                                                        <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="110px" ItemStyle-Width="110px"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblProdCode" Width="110px" Text='<%# DataBinder.Eval(Container.DataItem, "Prod_code") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cbProdCodeEdit" EnableLoadOnDemand="True" DataTextField="part_desc"
                                                                    DataValueField="prod_code" AutoPostBack="true"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "prod_code") %>'
                                                                    HighlightTemplatedItems="true" Height="190px" Width="110px" DropDownWidth="550px"
                                                                    OnItemsRequested="cb_prod_code_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                                                    OnPreRender="cb_prod_code_PreRender">                                                   
                                                                    <HeaderTemplate>
                                                                    <table style="width: 500px; font-size:smaller; background-color:gainsboro">
                                                                        <tr>    
                                                                            <td style="width: 130px;">
                                                                                Prod. Code
                                                                            </td>  
                                                                            <td style="width: 250px;">
                                                                                Prod. Name
                                                                            </td>  
                                                                            <td style="width: 50px;">
                                                                                UoM
                                                                            </td>    
                                                                            <td style="width: 40px;">
                                                                                Type
                                                                            </td>                                                      
                                                                        </tr>
                                                                    </table>                                                     
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 500px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 130px;">
                                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                                            </td>                               
                                                                            <td style="width: 250px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                                            </td>                                 
                                                                            <td style="width: 50px; padding-right: 7px; text-align:right">
                                                                                <%# DataBinder.Eval(Container, "Attributes['unit']")%>
                                                                            </td>                                
                                                                            <td style="width: 40px; padding-right: 7px; text-align:right">
                                                                                <%# DataBinder.Eval(Container, "Attributes['prod_type']")%>
                                                                            </td>                              
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cbProdCodeInsert" EnableLoadOnDemand="True" DataTextField="part_desc"
                                                                    DataValueField="prod_code" AutoPostBack="true"
                                                                    HighlightTemplatedItems="true" Height="190px" Width="110px" DropDownWidth="550px"
                                                                    OnItemsRequested="cb_prod_code_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                                                    OnPreRender="cb_prod_code_PreRender">                                                   
                                                                    <HeaderTemplate>
                                                                    <table style="width: 500px; font-size:smaller; background-color:gainsboro">
                                                                        <tr>    
                                                                            <td style="width: 130px;">
                                                                                Prod. Code
                                                                            </td>  
                                                                            <td style="width: 250px;">
                                                                                Prod. Name
                                                                            </td>  
                                                                            <td style="width: 50px;">
                                                                                UoM
                                                                            </td>    
                                                                            <td style="width: 40px;">
                                                                                Type
                                                                            </td>                                                      
                                                                        </tr>
                                                                    </table>                                                     
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 500px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 130px;">
                                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                                            </td>                               
                                                                            <td style="width: 250px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                                            </td>                                 
                                                                            <td style="width: 50px; padding-right: 7px; text-align:right">
                                                                                <%# DataBinder.Eval(Container, "Attributes['unit']")%>
                                                                            </td>                                
                                                                            <td style="width: 40px; padding-right: 7px; text-align:right">
                                                                                <%# DataBinder.Eval(Container, "Attributes['prod_type']")%>
                                                                            </td>                              
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>                                        
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Type" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Center" 
                                                            HeaderStyle-HorizontalAlign="Center" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblProdType" Width="40px" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>                                           
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:Label runat="server" ID="lblProdTypEdit" Width="40px" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>                                           
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <asp:Label runat="server" ID="lblProdTypeInsert" Width="40px"></asp:Label>                                           
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="80px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" 
                                                            DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="80px"  ReadOnly="true" 
                                                                    EnabledStyle-HorizontalAlign="Right"
                                                                    NumberFormat-AllowRounding="true"
                                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                                    dbValue='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                                                    onkeydown="blurTextBox(this, event)"
                                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                                    NumberFormat-DecimalDigits="2">
                                                                </telerik:RadNumericTextBox>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQtyEdit" Width="80px"  ReadOnly="false" 
                                                                    EnabledStyle-HorizontalAlign="Right"
                                                                    NumberFormat-AllowRounding="true"
                                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                                    dbValue='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                                                    onkeydown="blurTextBox(this, event)"
                                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                                    NumberFormat-DecimalDigits="2">
                                                                </telerik:RadNumericTextBox>
                                                            </EditItemTemplate>                                            
                                                            <InsertItemTemplate>
                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQtyInsert" Width="80px"  ReadOnly="false" 
                                                                    EnabledStyle-HorizontalAlign="Right"
                                                                    NumberFormat-AllowRounding="true"
                                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                                    onkeydown="blurTextBox(this, event)"
                                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                                    NumberFormat-DecimalDigits="2">
                                                                </telerik:RadNumericTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="hpokok" HeaderStyle-Width="80px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" 
                                                            DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center" Visible="false">
                                                            <ItemTemplate>
                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_hpokok" Width="80px"  ReadOnly="true" 
                                                                    EnabledStyle-HorizontalAlign="Right"
                                                                    NumberFormat-AllowRounding="true"
                                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                                    dbValue='<%# DataBinder.Eval(Container.DataItem, "hpokok") %>'
                                                                    onkeydown="blurTextBox(this, event)"
                                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                                    NumberFormat-DecimalDigits="2">
                                                                </telerik:RadNumericTextBox>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_hpokok_edit" Width="80px"  ReadOnly="false" 
                                                                    EnabledStyle-HorizontalAlign="Right"
                                                                    NumberFormat-AllowRounding="true"
                                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                                    dbValue='<%# DataBinder.Eval(Container.DataItem, "hpokok") %>'
                                                                    onkeydown="blurTextBox(this, event)"
                                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                                    NumberFormat-DecimalDigits="2">
                                                                </telerik:RadNumericTextBox>
                                                            </EditItemTemplate>                                            
                                                            <InsertItemTemplate>
                                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_hpokok_insert" Width="80px"  ReadOnly="false" 
                                                                    EnabledStyle-HorizontalAlign="Right"
                                                                    NumberFormat-AllowRounding="true"
                                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                                    onkeydown="blurTextBox(this, event)"
                                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                                    NumberFormat-DecimalDigits="2">
                                                                </telerik:RadNumericTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Center" >
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblUom" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="110px" runat="server" ID="cb_uom_d"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.SatQty") %>' Width="90px"
                                                                    EnableLoadOnDemand="True" Skin="Silk"  DataTextField="part_unit" DataValueField="part_unit" >
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="110px" Width="90px" runat="server" ID="cb_uom_d_insert"
                                                                    EnableLoadOnDemand="True" Skin="Silk"  DataTextField="part_unit" DataValueField="part_unit" >
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>                                        
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Location" HeaderStyle-Width="75px" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Center"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblKoLok" Width="75px" Text='<%# DataBinder.Eval(Container.DataItem, "KoLok") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cbKolokEdit" Width="75px" Skin="Silk"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "KoLok") %>' DropDownWidth="120px"
                                                                    EnableLoadOnDemand="True" EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"  
                                                                    DataTextField="kolok" DataValueField="kolok" OnItemsRequested="cbKolok_ItemsRequested">
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>                                            
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cbKolokInsert" Width="75px" Skin="Silk" DropDownWidth="120px"
                                                                    EnableLoadOnDemand="True" EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"  
                                                                    DataTextField="kolok" DataValueField="kolok" OnItemsRequested="cbKolok_ItemsRequested">
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="GI Number" HeaderStyle-Width="75px" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Center"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lbl_gi_code" Width="75px" Text='<%# DataBinder.Eval(Container.DataItem, "nocontr") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_gi_code_edit" EnableLoadOnDemand="True" DataTextField="part_desc"
                                                                    DataValueField="prod_code" AutoPostBack="true"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "nocontr") %>'
                                                                    HighlightTemplatedItems="true" Height="190px" Width="75px" DropDownWidth="250px"
                                                                    OnItemsRequested="cb_gi_code_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_gi_code_edit_SelectedIndexChanged"
                                                                    OnPreRender="cb_gi_code_edit_PreRender">                                                   
                                                                    <HeaderTemplate>
                                                                    <table style="width: 200px; font-size:smaller; background-color:gainsboro">
                                                                        <tr>    
                                                                            <td style="width: 130px;">
                                                                                GI Number
                                                                            </td>  
                                                                            <td style="width: 70px;">
                                                                                Cost Center
                                                                            </td>                                                  
                                                                        </tr>
                                                                    </table>                                                     
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 200px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 130px;">
                                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                                            </td>                               
                                                                            <td style="width: 70px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['dept_code']")%>
                                                                            </td>                          
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_gi_code_edit_insert" EnableLoadOnDemand="True" DataTextField="part_desc"
                                                                    DataValueField="prod_code" AutoPostBack="true"
                                                                    HighlightTemplatedItems="true" Height="190px" Width="75px" DropDownWidth="250px"
                                                                    OnItemsRequested="cb_gi_code_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_gi_code_SelectedIndexChanged"
                                                                    OnPreRender="cb_gi_code_PreRender">
                                                                    <HeaderTemplate>
                                                                    <table style="width: 200px; font-size:smaller; background-color:gainsboro">
                                                                        <tr>    
                                                                            <td style="width: 130px;">
                                                                                GI Number
                                                                            </td>  
                                                                            <td style="width: 70px;">
                                                                                Cost Center
                                                                            </td>                                                  
                                                                        </tr>
                                                                    </table>                                                     
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <table style="width: 200px; font-size:smaller">
                                                                            <tr>
                                                                                <td style="width: 130px;">
                                                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                                                </td>                               
                                                                                <td style="width: 70px;">
                                                                                    <%# DataBinder.Eval(Container, "Attributes['dept_code']")%>
                                                                                </td>                          
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate> 
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>                                        
                                                        </telerik:GridTemplateColumn>
                                            
                                                        <telerik:GridTemplateColumn HeaderText="Cost ctr" ItemStyle-Width="80px" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center" 
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lbl_cost_center" Width="60px" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>                                           
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:Label runat="server" ID="lbl_cost_center_edit" Width="60px" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>                                           
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <asp:Label runat="server" ID="lbl_cost_center_insert" Width="60px"></asp:Label>                                           
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Reason" HeaderStyle-Width="230px" ItemStyle-Width="180px"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lbl_reason" Width="180px" Text='<%# DataBinder.Eval(Container.DataItem, "reason") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_reason_edit" EnableLoadOnDemand="True" DataTextField="part_desc"
                                                                    DataValueField="prod_code" AutoPostBack="true"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "reason") %>'
                                                                    HighlightTemplatedItems="true" Height="190px" Width="180px" DropDownWidth="550px"
                                                                    OnItemsRequested="cb_reason_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_reason_SelectedIndexChanged" 
                                                                    OnPreRender="cb_reason_PreRender">                                                   
                                                                    
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_reason_insert" EnableLoadOnDemand="True" DataTextField="part_desc"
                                                                    DataValueField="prod_code" AutoPostBack="true"
                                                                    HighlightTemplatedItems="true" Height="190px" Width="180px" DropDownWidth="350px"
                                                                    OnItemsRequested="cb_reason_ItemsRequested"
                                                                    OnSelectedIndexChanged="cb_reason_SelectedIndexChanged" 
                                                                    OnPreRender="cb_reason_PreRender"> 
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>                                        
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="150px" HeaderStyle-Width="150px" 
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark" Width="150px"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>' ReadOnly="true">
                                                                </telerik:RadTextBox>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemarkEdit" Width="150px"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>' ReadOnly="false">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemarkInsert" Width="150px" ReadOnly="false">
                                                                </telerik:RadTextBox>
                                                            </InsertItemTemplate>      
                                                        </telerik:GridTemplateColumn>
                                        
                                                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                                                            ConfirmTitle="Delete" ConfirmDialogType="Classic"
                                                            ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                                        </telerik:GridButtonColumn>
                             
                                                    </Columns>
                                                </MasterTableView>
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="259" />
                                                    <ClientEvents OnRowDblClick="rowDblClick"/>
                                                </ClientSettings>
                                                </telerik:RadGrid>
                                            </div>                
                                        </telerik:RadPageView>
                                        <telerik:RadPageView runat="server" ID="RadPageView4" Height="300px">
                                            <div runat="server" style="padding:15px 15px 15px 15px">
                                                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" AutoGenerateColumns="false" Skin="Silk" CssClass="RadGrid_ModernBrowsers"
                                                    AllowPaging="false" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" ShowStatusBar="true"        
                                                    OnNeedDataSource="RadGrid3_NeedDataSource" OnPreRender="RadGrid3_PreRender">
                                                    <HeaderStyle Font-Size="12px" />
                                                    <AlternatingItemStyle Font-Size="10px" Font-Names="Comic Sans MS" />
                                                    <MasterTableView DataKeyNames="nomor" HeaderStyle-ForeColor="Highlight" ItemStyle-Font-Size="10px" ItemStyle-Font-Names="Comic Sans MS" CellPadding="5"
                                                            HorizontalAlign="NotSet" AutoGenerateColumns="False">
                                                        <SortExpressions>
                                                            <telerik:GridSortExpression FieldName="nomor" SortOrder="Descending" />
                                                        </SortExpressions>
                                                        <ColumnGroups>
                                                            <telerik:GridColumnGroup Name="IDR" HeaderText="IDR"
                                                                HeaderStyle-HorizontalAlign="Center" />
                                                            <telerik:GridColumnGroup Name="Valas" HeaderText="Valas"
                                                                HeaderStyle-HorizontalAlign="Center" />
                                                        </ColumnGroups>
                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="accountcode" HeaderStyle-Width="100px" HeaderText="Account No." SortExpression="accountcode"
                                                                UniqueName="accountcode" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="70px" 
                                                                >                                
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="accountname" HeaderStyle-Width="250px" HeaderText="Account Name" SortExpression="accountname"
                                                                UniqueName="accountname" ReadOnly="true" HeaderStyle-HorizontalAlign="Center"
                                                                >                                
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="debet" HeaderStyle-Width="100px" HeaderText="Debet" SortExpression="debet"
                                                                UniqueName="debet" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" 
                                                                DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="70px">                                
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="credit" HeaderStyle-Width="100px" HeaderText="Credit" SortExpression="credit"
                                                                UniqueName="credit" ReadOnly="true" HeaderStyle-HorizontalAlign="Center"
                                                                DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="70px">                                
                                                            </telerik:GridBoundColumn>
                                                            <%--<telerik:GridBoundColumn DataField="remark" HeaderStyle-Width="200px" HeaderText="Remark" SortExpression="remark"
                                                                UniqueName="remark" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" >
                                                            </telerik:GridBoundColumn>--%>
                                                            <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="200px" HeaderStyle-Width="200px"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="txtRemark" Width="180px" 
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>' ReadOnly="true">
                                                                </asp:Label>
                                                            </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings AllowKeyboardNavigation="true">
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="310px" />
                                                        <Selecting AllowRowSelect="true"></Selecting>     
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </div>
                                            

                                        </telerik:RadPageView>
                                    </telerik:RadMultiPage>
                                </div>
                        </div>
                    </FormTemplate>
                </EditFormSettings>
                </MasterTableView>
                <ClientSettings>
                    <%--<Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="253px" />--%>
                    <Selecting AllowRowSelect="true"></Selecting>                    
                </ClientSettings>
            </telerik:RadGrid>
        </div>        
       
        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data tersimpan" Position="BottomRight"
            AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
        </telerik:RadNotification>

       <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1150px" Height="670px" Modal="true" AutoSize="True">
                </telerik:RadWindow>
                <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1500px" Height="720px" Modal="true" AutoSize="False">
                </telerik:RadWindow>
                
            </Windows>
        </telerik:RadWindowManager>
        
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
        
    </div>

</asp:Content>