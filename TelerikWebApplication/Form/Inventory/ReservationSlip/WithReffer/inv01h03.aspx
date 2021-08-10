<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h03.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.ReservationSlip.WithReffer.inv01h03" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../../Script/Script.js"></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("inv01h03mReportViewer.aspx?doc_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("inv01h03mEditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("inv01h03mEditForm.aspx?doc_code=" + id, "EditDialogWindows");
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
            
        </AjaxSettings>
    </telerik:RadAjaxManager>

     <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="1000" BackgroundPosition="None" BackColor="Transparent" >
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
                            <telerik:RadLabel runat="server" Text="Date From :" CssClass="lbObject" Skin="Silk"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Silk"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" Skin="Silk"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Silk"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight" AutoPostBack="FALSE"
                               EnableLoadOnDemand="True"  Skin="Silk" OnItemsRequested="cb_proj_prm_ItemsRequested"
                                OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td>
                            <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="120px" Height="25px" 
                                BackColor="#FF6600" ForeColor="White" BorderStyle="None"  />
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
                    <%--<asp:ImageButton runat="server" ID="btnNew" AlternateText="New"  OnClientClick="ShowInsertForm(); return false;" ToolTip="Add New" Visible="true"
                        Height="26px" Width="27px" ImageUrl="~/Images/tambah.png" ImageAlign="Bottom" ></asp:ImageButton>--%>
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click" ToolTip="Add New" Visible="true"
                        Height="26px" Width="27px" ImageUrl="~/Images/tambah.png" ImageAlign="Bottom" ></asp:ImageButton>
                </td>                
                <td style="vertical-align: bottom; margin-left: 0px; padding: 0px 0px 0px 0px;">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter" 
                        Height="29px" Width="30px" ImageUrl="~/Images/search.png"></asp:ImageButton>
                </td>
                <td style="width: 96%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight:normal; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#0099dc;">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

    <div  class="scroller" runat="server" style="overflow-y:scroll; height:620px">
        <div runat="server" style="width:100%; overflow-y:hidden; min-height:620px; scrollbar-highlight-color:#b6ff00;border-bottom-style:solid; 
        border-bottom-color:gainsboro; border-bottom-width:thin;">

        <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" PageSize="14" ShowFooter="false" Skin="Silk"
            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" MasterTableView-GridLines="None" CssClass="RadGrid_ModernBrowsers"
            OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" 
            OnItemCreated="RadGrid1_ItemCreated" 
            OnPreRender="RadGrid1_PreRender"
            OnNeedDataSource="RadGrid1_NeedDataSource" 
            OnDeleteCommand="RadGrid1_DeleteCommand" 
            OnItemCommand="RadGrid1_ItemCommand" 
            OnItemDataBound="RadGrid1_ItemDataBound">
            <PagerStyle ForeColor="#0099CC" VerticalAlign="Middle" Mode="NextPrevAndNumeric"></PagerStyle>               
            <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px"/>
            <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
            <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
            <SortingSettings EnableSkinSortStyles="false" />
            <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="doc_code" Font-Size="11px" Font-Names="Century Gothic"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" 
                CommandItemSettings-AddNewRecordText="New" EditFormSettings-EditFormType="WebUserControl" InsertItemDisplay="Top">
            <Columns>
                <%--<telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="20px" HeaderStyle-Width="20px">
                    </telerik:GridClientSelectColumn>--%>
                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  
                    HeaderStyle-Width="30px" ItemStyle-Width="30px" UpdateText="Update" >
                </telerik:GridEditCommandColumn>
                <telerik:GridBoundColumn UniqueName="doc_code" HeaderText="RS. No." DataField="doc_code" ItemStyle-Width="110px" FilterControlWidth="100px" ItemStyle-HorizontalAlign="Left">
                    <HeaderStyle Width="140px"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridDateTimeColumn UniqueName="doc_date" HeaderText="Date" DataField="doc_date" ItemStyle-Width="100px"
                    EnableRangeFiltering="false" FilterControlWidth="95px" PickerType="DatePicker"
                    DataFormatString="{0:d}">
                    <HeaderStyle Width="135px"></HeaderStyle>
                </telerik:GridDateTimeColumn>
                <telerik:GridBoundColumn UniqueName="sro_code" HeaderText="Ref Code" DataField="sro_code" ItemStyle-Width="110px" FilterControlWidth="100px" >
                    <HeaderStyle Width="140px"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="no_wo" HeaderText="WO Number" DataField="no_wo" ItemStyle-Width="110px" FilterControlWidth="100px" >
                    <HeaderStyle Width="140px"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="unit_code" HeaderText="Unit" DataField="unit_code" ItemStyle-Width="110px">
                    <HeaderStyle Width="125px"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project" DataField="region_code" ItemStyle-Width="40px"
                    FilterControlWidth="40px">
                    <HeaderStyle Width="80px"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="dept_code" HeaderText="Dept. Code" DataField="dept_code" ItemStyle-Width="60px"
                    FilterControlWidth="60px">
                    <HeaderStyle Width="100px"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="doc_remark" HeaderText="Remark" DataField="doc_remark" ItemStyle-Wrap="true"
                    ItemStyle-Width="320px" FilterControlWidth="280px">
                    <HeaderStyle Width="320px"></HeaderStyle>
                </telerik:GridBoundColumn>
                <%--<telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" AllowFiltering="False">
                    <ItemTemplate>                                
                        <asp:ImageButton ID="EditLink" runat="server" Height="22px" Width="28px" ImageUrl="~/Images/edit.png" ToolTip="Edit" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>--%>
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
            <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <div style="padding: 15px 0px 0px 25px;">
                            
                            <table id="Table1" border="0" style="border-collapse: collapse; padding:15px 0px 5px 0px; font-size:11px;">    
                                <tr style="vertical-align: top;">
                                    <td style="vertical-align: top;">
                                        <table id="Table2" width="Auto" border="0" class="module">
                                            <tr>
                                                <td colspan="4" style="padding: 0px 0px 10px 0px; text-align:left">
                                                    <asp:Button ID="btnUpdate" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px"  Height="25px" 
                                                        Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" 
                                                        OnClick="btnUpdate_Click"  CssClass="btn-entryFrm" >
                                                    </asp:Button>&nbsp;
                            
                                                    <asp:Button ID="btnCancel" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" 
                                                        Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                                        runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                                                </td>
                                            </tr>  
                                            <tr>                              
                                                <td  style="vertical-align: top; width:90px">
                                                    <telerik:RadLabel runat="server" Text="RS Number" CssClass="lbObject" Skin="Silk" ></telerik:RadLabel>
                                                <td/>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_doc_code" runat="server" Width="300px" ReadOnly="true" RenderMode="Lightweight" CssClass="lbObject"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.doc_code") %>' 
                                                        AutoPostBack="false"  EmptyMessage="- Leave it Blank - ">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: top; width:90px">
                                                    <telerik:RadLabel runat="server" Text="RS Date" CssClass="lbObject" Skin="Silk"></telerik:RadLabel>
                                                <td/>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtp_rs" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                    Skin="Silk"  
                                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.doc_date") %>'>
                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Silk"
                                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" >
                                                    </Calendar>
                                                    <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" >
                                                    </DateInput>
                                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: top; width:90px">
                                                    <telerik:RadLabel runat="server" Text="Excute Date" CssClass="lbObject" Skin="Silk"></telerik:RadLabel>
                                                <td/>
                                                <td>                          
                                                    <telerik:RadDatePicker ID="dtp_exe" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                        TabIndex="4" Skin="Silk"
                                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.date_exec") %>'>
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"
                                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk">
                                                        </Calendar>
                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" >
                                                        </DateInput>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                                    </telerik:RadDatePicker>                          
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: top; width:90px">
                                                    <telerik:RadLabel runat="server" Text="Type Ref" CssClass="lbObject" Skin="Silk"></telerik:RadLabel> 
                                                    <asp:RequiredFieldValidator runat="server" ID="reffTypeValidator" ControlToValidate="cb_type_ref" ForeColor="Red" 
                                                        Font-Size="X-Small"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                                                <td/>
                                                <td>                          
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_type_ref" runat="server" Width="300px" AutoPostBack="true" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.tAsset") %>' 
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk" EnableVirtualScrolling="true"
                                                    OnItemsRequested="cb_type_ref_ItemsRequested" OnPreRender="cb_type_ref_PreRender" OnSelectedIndexChanged="cb_type_ref_SelectedIndexChanged" >
                                                </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: top; width:90px">                            
                                                    <telerik:RadLabel runat="server" Text="Project Area" CssClass="lbObject" Skin="Silk"></telerik:RadLabel>
                                                    <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_project" ForeColor="Red" 
                                                    Font-Size="X-Small" Text="*"></asp:RequiredFieldValidator>
                                                <td/>
                                                <td> 
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300px" DropDownWidth="300px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' Height="250px"
                                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Silk" CausesValidation="false"
                                                        OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged" 
                                                        OnPreRender="cb_project_PreRender">
                                                    </telerik:RadComboBox> 
                                                </td>
                                            </tr>                                             
                                            <tr>
                                                <td style="vertical-align: top; width:90px">
                                                    <telerik:RadLabel runat="server" Text="Storage" CssClass="lbObject" Skin="Silk"></telerik:RadLabel>
                                                    <asp:RequiredFieldValidator runat="server" ID="warehouseValidator" ControlToValidate="cb_warehouse" ForeColor="Red" 
                                                                Font-Size="X-Small" Text="*"></asp:RequiredFieldValidator>
                                                <td/>
                                                <td style="vertical-align: top;">   
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="300px" DropDownWidth="300px"
                                                        AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Silk"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.wh_name") %>' 
                                                        OnItemsRequested="cb_warehouse_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged" 
                                                        OnPreRender="cb_warehouse_PreRender">
                                                    </telerik:RadComboBox> 
                                    
                                                </td>
                                            </tr>                                           
                                       </table>
                                    </td>
                                    <td style="vertical-align:top; padding-left:20px">
                                        <table>        
                                            
                                            <tr>
                                               <td style="vertical-align: top; width:90px"> 
                                                   <telerik:RadLabel runat="server" Text="Refference" CssClass="lbObject" ForeColor="Black" Skin="Silk"></telerik:RadLabel>
                                                    <asp:RequiredFieldValidator runat="server" ID="reffCodeValidator" ControlToValidate="cb_ref" ForeColor="Red" 
                                                    Font-Size="X-Small" Text="*"></asp:RequiredFieldValidator> 
                                               </td>
                                                <td>                                                                                                                                                                  
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ref" runat="server" Width="150px" DropDownWidth="550px" Height="250px"
                                                        AutoPostBack="true" ShowMoreResultsBox="false" EnableLoadOnDemand="True" Skin="Silk" CausesValidation="false"
                                                        DataTextField="sro_code" DataValueField="sro_code"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.sro_code ") %>'
                                                        OnItemsRequested="cb_ref_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_ref_SelectedIndexChanged"
                                                        OnPreRender="cb_ref_PreRender">
                                                            <HeaderTemplate>
                                                            <table style="width: 620px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 120px;">Reff. No.
                                                                    </td>
                                                                    <td style="width: 500px;">Remark
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 620px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 120px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.doc_code")%>
                                                                    </td>
                                                                    <td style="width: 500px; text-align:left">
                                                                        <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:label>                                                                    
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>                                                       
                                                </td>
                                           </tr>                                                                     
                                            <tr>                                                        
                                               <td style="vertical-align: top; width:90px">
                                                   <telerik:RadLabel runat="server" Text="Unit Code" CssClass="lbObject" Skin="Silk"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="cb_unit" runat="server" Width="150px" AutoPostBack="false" CausesValidation="false"
                                                        DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"  Height="250px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.unit_code ") %>'
                                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" 
                                                        OnItemsRequested="cb_unit_ItemsRequested" OnSelectedIndexChanged="cb_unit_SelectedIndexChanged"
                                                        OnPreRender="cb_unit_PreRender">
                                                            <HeaderTemplate>
                                                                    <table style="width: 450px; font-size: smaller">
                                                                        <tr>
                                                                            <td style="width: 200px;">Unit Code
                                                                            </td>
                                                                            <td style="width: 250px;">Model No.
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 450px; font-size: smaller">
                                                                        <tr>
                                                                            <td style="width: 200px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.model_no")%>
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
                                               <td style="vertical-align: top; width:90px">
                                                   <telerik:RadLabel runat="server" Text="Model No." CssClass="lbObject" Skin="Silk"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_unit_name" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.model_no ") %>' Skin="Silk">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: top; width:90px">
                                                   <telerik:RadLabel runat="server" Text="HM" CssClass="lbObject" Skin="Silk"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_hm" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.time_reading","{0:#,###,##0.00}") %>' Skin="Silk">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>                     
                                            <tr>
                                               <td style="vertical-align: top; width:90px">
                                                   <telerik:RadLabel runat="server" Text="Cost Center" CssClass="lbObject" Skin="Silk"></telerik:RadLabel>
                                                   <asp:RequiredFieldValidator runat="server" ID="costCtrValidator" ControlToValidate="cb_cost_ctr" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="*" ></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="cb_cost_ctr" runat="server" Width="300px"  Height="250px"
                                                        DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true"  
                                                        OnItemsRequested="cb_cost_ctr_ItemsRequested" OnSelectedIndexChanged="cb_cost_ctr_SelectedIndexChanged" 
                                                        OnPreRender="cb_cost_ctr_PreRender" Text='<%# DataBinder.Eval(Container, "DataItem.CostCenterName ") %>'>
                                                            <HeaderTemplate>
                                                            <table style="width: 450px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 100px;">Code
                                                                    </td>
                                                                    <td style="width: 350px;">Name
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 450px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 100px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.code")%>
                                                                    </td>
                                                                    <td style="width: 350px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                
                                                    </telerik:RadComboBox>                                    
                                               </td>                       
                                           </tr> 
                                            <tr>
                                                <td style="vertical-align: top; width:90px">
                                                    <telerik:RadLabel runat="server" Text="Remark" CssClass="lbObject" Skin="Silk"></telerik:RadLabel>
                                                </td>
                                                <td>    
                                                    <telerik:RadTextBox ID="txt_remark"   Text='<%# DataBinder.Eval(Container, "DataItem.doc_remark") %>'
                                                        runat="server" TextMode="MultiLine" Skin="Silk"
                                                        Width="300px" Rows="0" Resize="None">
                                                    </telerik:RadTextBox>
                                                </td>
                                            </tr>                              
                                        </table>
                                    </td>
                                    <td style="vertical-align:top; padding-left:20px">
                                        <table>
                                                                                                 
                                            <tr>
                                                <td style="vertical-align: top; width:90px">
                                                    <telerik:RadLabel runat="server" Text="Order By" CssClass="lbObject" Skin="Silk"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox ID="cb_orderBy" runat="server" Width="300px" Height="250px"
                                                        DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" 
                                                        OnItemsRequested="cb_orderBy_ItemsRequested" OnSelectedIndexChanged="cb_orderBy_SelectedIndexChanged"
                                                        OnPreRender="cb_orderBy_PreRender" Text='<%# DataBinder.Eval(Container, "DataItem.RequestBy") %>'>
                                                            <HeaderTemplate>
                                                                    <table style="width: 450px; font-size: smaller">
                                                                        <tr>
                                                                            <td style="width: 200px;">Name
                                                                            </td>
                                                                            <td style="width: 250px;">Position
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 450px; font-size: smaller">
                                                                        <tr>
                                                                            <td style="width: 200px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                            </td>
                                                                            <td style="width: 250px;">
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
                                                <td style="vertical-align: top; width:90px">
                                                    <telerik:RadLabel CssClass="lbObject" runat="server" Text="Approved By" Skin="Silk"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="300px" Height="250px"
                                                    DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                    MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" 
                                                    OnItemsRequested="cb_approved_ItemsRequested"
                                                    OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                    OnPreRender="cb_approved_PreRender" Text='<%# DataBinder.Eval(Container, "DataItem.ReceiveBy") %>'>
                                                    <HeaderTemplate>
                                                        <table style="width: 550px; font-size: smaller">
                                                            <tr>
                                                                <td style="width: 200px;">Name
                                                                </td>
                                                                <td style="width: 250px;">Position
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 450px; font-size: smaller">
                                                            <tr>
                                                                <td style="width: 200px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                </td>
                                                                <td style="width: 250px;">
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
                                                <td  style="vertical-align: top; text-align: left">
                                                    <telerik:RadLabel runat="server" Text="Received By" CssClass="lbObject" Skin="Silk"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_received" runat="server" Width="300px" Height="250px"
                                                        DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" 
                                                        OnItemsRequested="cb_received_ItemsRequested" OnSelectedIndexChanged="cb_received_SelectedIndexChanged"
                                                        OnPreRender="cb_received_PreRender" Text='<%# DataBinder.Eval(Container, "DataItem.ApproveBy") %>'>
                                                        <HeaderTemplate>
                                                            <table style="width: 450px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 200px;">Name
                                                                    </td>
                                                                    <td style="width: 250px;">Position
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 450px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 200px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                    </td>
                                                                    <td style="width: 250px;">
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
                                        </table>
                                    </td>
                                </tr>                                             
                               </table>
                            <div style="padding: 7px 0px 12px 0px; min-height:275px">           
                                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="4"  Skin="Silk"
                                    AllowPaging="false" AllowSorting="true" runat="server" CssClass="RadGrid_Silk"
                                        OnNeedDataSource="RadGrid2_NeedDataSource" 
                                        OnDeleteCommand="RadGrid2_DeleteCommand" 
                                        OnInsertCommand="RadGrid2_InsertCommand" 
                                        OnUpdateCommand="RadGrid2_UpdateCommand" 
                                        OnItemCommand="RadGrid2_ItemCommand" 
                                        OnPreRender="RadGrid2_PreRender" >
                                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                        <HeaderStyle Font-Size="11px" BackColor="#999999" ForeColor="White" />
                                        <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                                        <MasterTableView CommandItemDisplay="None" DataKeyNames="part_code" Font-Size="11px" EditMode="InPlace" BorderStyle="Solid" 
                                        BorderColor="Silver" BorderWidth="1px" ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >
                                        <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="true" AddNewRecordText="New Item" />
                                        <Columns>
                                            <%--<telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  
                                               HeaderStyle-Width="60px" ItemStyle-Width="60px" UpdateText="Update" >
                                            </telerik:GridEditCommandColumn>--%>
                                            <telerik:GridTemplateColumn HeaderText="Type" ItemStyle-Width="30px" HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center"
                                                HeaderStyle-HorizontalAlign="Center"  >
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblProdType" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>' Width="30px"></asp:Label>                                           
                                                </ItemTemplate>                                                
                                                <%--<EditItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_prodType_editTemp" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                                                </EditItemTemplate>--%>
                                                <InsertItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_prodType_insertTemp"></asp:Label>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="120px" ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="Left"
                                                     >
                                                <FooterTemplate>Template footer</FooterTemplate>
                                                <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" /> 
                                                <ItemTemplate>    
                                                    <%--<asp:Label runat="server" ID="lbl_prod_code" Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>'></asp:Label>
                                                    <telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip1" runat="server" TargetControlID="lbl_prod_code" RelativeTo="Element"
                                                    Position="BottomCenter" RenderInPageRoot="true">
                                                    <%# DataBinder.Eval(Container, "DataItem.part_desc")%>                                                
                                                    </telerik:RadToolTip>--%>

                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="spec"
                                                        DataValueField="Prod_code" AutoPostBack="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.part_code") %>' EmptyMessage="- Select product -"
                                                        HighlightTemplatedItems="true" Width="120px" DropDownWidth="730px" DropDownAutoWidth="Enabled"
                                                        OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                                        OnItemsRequested="cb_prod_code_ItemsRequested" >                                                   
                                                        <HeaderTemplate>
                                                        <table style="width: 730px; font-size:smaller">
                                                            <tr>    
                                                                <td style="width: 120px;">
                                                                    Prod. Code
                                                                </td> 
                                                                <td style="width: 350px;">
                                                                    Prod. Name
                                                                </td> 
                                                                <td style="width: 60px;">
                                                                    UoM
                                                                </td> 
                                                                <td style="width: 120px;">
                                                                    St. Maint.
                                                                </td> 
                                                                                                    
                                                            </tr>
                                                        </table>                                                       
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 730px; font-size:smaller">
                                                            <tr>        
                                                                <td style="width: 120px;">
                                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                                </td> 
                                                                <td style="width: 350px;">
                                                                    <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                                </td>
                                                                <td style="width: 60px;">
                                                                    <%# DataBinder.Eval(Container, "Attributes['unit']")%>
                                                                </td>
                                                                <td style="width: 120px;">
                                                                    <%# DataBinder.Eval(Container, "Attributes['stMainNm']")%>
                                                                </td>
                                                                                                                                                         
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                    <telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip2" runat="server" TargetControlID="cb_prod_code" RelativeTo="Element"
                                                    Position="BottomCenter" RenderInPageRoot="true" HideDelay="300" ShowEvent="OnMouseOver">
                                                    <%# DataBinder.Eval(Container, "DataItem.part_desc")%>                                                
                                                    </telerik:RadToolTip> 

                                                </ItemTemplate>

                                                <InsertItemTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_insertTemp" EnableLoadOnDemand="True" DataTextField="spec"
                                                        DataValueField="Prod_code" AutoPostBack="true" EmptyMessage="- Select product -"
                                                        HighlightTemplatedItems="true" Width="120px" DropDownWidth="730px" DropDownAutoWidth="Enabled"
                                                        OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                                        OnItemsRequested="cb_prod_code_ItemsRequested" >                                                   
                                                        <HeaderTemplate>
                                                        <table style="width: 730px; font-size:smaller">
                                                            <tr>
                                                                
                                                                <td style="width: 120px;">
                                                                    Prod. Code
                                                                </td> 
                                                                <td style="width: 350px;">
                                                                    Prod. Name
                                                                </td>     
                                                                <td style="width: 60px;">
                                                                    UoM
                                                                </td> 
                                                                <td style="width: 120px;">
                                                                    St. Maint.
                                                                </td> 
                                                                                                    
                                                            </tr>
                                                        </table>                                                       
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 730px; font-size:smaller">
                                                            <tr>        
                                                                <td style="width: 120px;">
                                                                    <%# DataBinder.Eval(Container, "Value")%>
                                                                </td> 
                                                                <td style="width: 350px;">
                                                                    <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                                </td>
                                                                <td style="width: 60px;">
                                                                    <%# DataBinder.Eval(Container, "Attributes['unit']")%>
                                                                </td>
                                                                <td style="width: 120px;">
                                                                    <%# DataBinder.Eval(Container, "Attributes['stMainNm']")%>
                                                                </td>
                                                                                                                                                         
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <%--<telerik:GridTemplateColumn HeaderText="MR Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right" Visible="false"
                                                HeaderStyle-HorizontalAlign="Right"  >
                                                <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbl_mr_qty" Text='<%# DataBinder.Eval(Container.DataItem, "mr_qty", "{0:#,###,###0.00}") %>'></asp:Label>
                                                </ItemTemplate>                                               
                                                <EditItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_mr_qty_editTemp" Text='<%# DataBinder.Eval(Container.DataItem, "mr_qty", "{0:#,###,###0.00}") %>'></asp:Label>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_mr_qty_insertTemp"></asp:Label>
                                                </InsertItemTemplate>                                        
                                            </telerik:GridTemplateColumn>--%>

                                            <telerik:GridTemplateColumn HeaderText="OH Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-HorizontalAlign="Right"   >
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_soh" Text='<%# DataBinder.Eval(Container.DataItem, "OH_qty", "{0:#,###,###0.00}") %>'></asp:Label>
                                                </ItemTemplate>                                                   
                                                <%--<EditItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_soh_editTemp" Text='<%# DataBinder.Eval(Container.DataItem, "OH_qty", "{0:#,###,###0.00}") %>'></asp:Label>
                                                </EditItemTemplate>--%>
                                                <InsertItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_soh_insertTemp"></asp:Label>
                                                </InsertItemTemplate>                                      
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Qty Order" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right" 
                                                HeaderStyle-HorizontalAlign="Right" DefaultInsertValue="0"   >
                                                <ItemTemplate>
                                                    <%--<asp:Label RenderMode="Lightweight" runat="server" ID="lbl_part_qty" Width="70px"  ReadOnly="False" EnabledStyle-HorizontalAlign="Right"
                                                        NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'
                                                        onkeydown="blurTextBox(this, event)"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2" ForeColor="#006600" Font-Bold="True" Font-Underline="True">
                                                    </asp:Label>--%>

                                                    <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_part_qty" Width="70px" NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                        DbValue='<%# Convert.ToDouble(Eval("part_qty")) %>'
                                                        onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2" >
                                                    </telerik:RadNumericTextBox>

                                                </ItemTemplate>
                                                
                                                 <InsertItemTemplate>
                                                    <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_part_qty_insertTemp" Width="70px" NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                        onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2" >
                                                    </telerik:RadNumericTextBox>
                                                </InsertItemTemplate>    
                                            </telerik:GridTemplateColumn>
                            
                                            <telerik:GridTemplateColumn HeaderText="PR Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-HorizontalAlign="Right"   >
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_qty_pr" Text='<%# DataBinder.Eval(Container.DataItem, "QtyPR", "{0:#,###,###0.00}") %>'></asp:Label>
                                                </ItemTemplate>                                                   
                                                <EditItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_qty_pr_editTemp" Text='<%# DataBinder.Eval(Container.DataItem, "QtyPR", "{0:#,###,###0.00}") %>'></asp:Label>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_qty_pr_insertTemp"></asp:Label>
                                                </InsertItemTemplate>                                        
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Supply Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-HorizontalAlign="Right"   >
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_qty_gi" Text='<%# DataBinder.Eval(Container.DataItem, "QtyGi", "{0:#,###,###0.00}") %>'> </asp:Label>
                                                </ItemTemplate>                                                       
                                                <%--<EditItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_qty_gi_editTemp" Text='<%# DataBinder.Eval(Container.DataItem, "QtyGi", "{0:#,###,###0.00}") %>'></asp:Label>
                                                </EditItemTemplate>--%>
                                                <InsertItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_qty_gi_insertTemp"></asp:Label>
                                                </InsertItemTemplate>                                      
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="70px" ItemStyle-Width="70px" 
                                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"   >
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_uom" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                                                </ItemTemplate>                                                          
                                                <%--<EditItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_uom_editTemp" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                                                </EditItemTemplate>--%>
                                                <InsertItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_uom_insertTemp"></asp:Label>
                                                </InsertItemTemplate>                                     
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Cost Ctr." HeaderStyle-Width="80px" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Left"
                                                     >
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_cost_ctr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                                </ItemTemplate>                                                          
                                                <%--<EditItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_cost_ctr_editTemp" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                                </EditItemTemplate>--%>
                                                <InsertItemTemplate>
                                                    <asp:Label runat="server" ID="lbl_cost_ctr_insertTemp"></asp:Label>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <%--<telerik:GridTemplateColumn HeaderText="Waranty" HeaderStyle-Width="50px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" 
                                                    HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chk_waranty" 
                                                        Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chk_waranty_editTemp" Text="Warranty"
                                                        Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="true" />
                                                </EditItemTemplate>  
                                                <InsertItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chk_waranty_insertTemp" Enabled="true" />
                                                </InsertItemTemplate>                                      
                                            </telerik:GridTemplateColumn>--%>
                                            <telerik:GridTemplateColumn HeaderText="Delivery Date" HeaderStyle-Width="100px"  ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                HeaderStyle-HorizontalAlign="Center"   >
                                                <ItemTemplate>  
                                                    <telerik:RadDatePicker runat="server" ID="dtp_deliv_date" Width="100px"
                                                        DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.deliv_date")%>' 
                                                        onkeydown="blurTextBox(this, event)" Type="Date">
                                                        <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                                    </telerik:RadDatePicker>
                                                </ItemTemplate>                                                          
                                                <%--<EditItemTemplate>
                                                    <telerik:RadDatePicker runat="server" ID="dtp_deliv_date_editTemp" Width="100px"
                                                        DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.deliv_date")%>' 
                                                        onkeydown="blurTextBox(this, event)" Type="Date">
                                                        <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                                    </telerik:RadDatePicker>
                                                </EditItemTemplate>--%>
                                                <InsertItemTemplate>
                                                    <telerik:RadDatePicker runat="server" ID="dtp_deliv_date_insertTemp" Width="100px" 
                                                        onkeydown="blurTextBox(this, event)" Type="Date">
                                                        <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                                    </telerik:RadDatePicker>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn> 
                            
                                            <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="200px" HeaderStyle-Width="190px" HeaderStyle-HorizontalAlign="Center"
                                                     >
                                                <ItemTemplate>
                                                    <%--<asp:Label runat="server" ID="lbl_remark" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>--%>
                                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_d" Width="200px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                                    </telerik:RadTextBox>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    
                                                </EditItemTemplate>
                                                <InsertItemTemplate>                                                    
                                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_insertTemp" Width="200px">
                                                    </telerik:RadTextBox>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <%--<telerik:GridTemplateColumn HeaderText="Run" HeaderStyle-Width="20px" ItemStyle-Width="20px" Visible="false">
                                                <ItemTemplate>                                        
                                                    <asp:Label runat="server" ID="lbl_runItem" Text='<%# DataBinder.Eval(Container.DataItem, "nomor") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>                                        
                                                    <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="lbl_runEdit" Width="30px"  ReadOnly="true"
                                                        Text='<%# DataBinder.Eval(Container.DataItem, "nomor") %>'>
                                                    </telerik:RadTextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>                                        
                                                    <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="lbl_runInsert" Width="30px" ReadOnly="true"
                                                        Text="0">
                                                    </telerik:RadTextBox>
                                                </InsertItemTemplate>
                                            </telerik:GridTemplateColumn>--%>
                                            <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow"
                                                ButtonType="FontIconButton" ItemStyle-Width="30px" HeaderStyle-Width="30px"  >
                                            </telerik:GridButtonColumn>

                                        </Columns>
                                    </MasterTableView>
                                    <ClientSettings >
                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="185px" />
                                        <Selecting AllowRowSelect="true" />
                                        <ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />                       
                                    </ClientSettings>
                                    </telerik:RadGrid>               
                            </div>
                        </div>
                    </FormTemplate>
                </EditFormSettings>
            </MasterTableView>
            <ClientSettings>
                <Selecting AllowRowSelect="true"></Selecting>
                <ClientEvents OnRowDblClick="RowDblClick" />
                <Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="290" />
            </ClientSettings>
        </telerik:RadGrid>
        
        </div>

        <div runat="server" style="width: 100%; border-top-width: 1px; border-top-style: inset; padding-top: 5px;"> 
            
            <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                
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
                    Width="700px" Height="720px" Modal="true" AutoSize="False">
                </telerik:RadWindow>
                
            </Windows>
        </telerik:RadWindowManager>
        
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
        
    </div>
</asp:Content>
