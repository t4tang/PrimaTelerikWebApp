<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h13.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.InvoiceIncoming.acc01h13" %>

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
                window.radopen("acc01h13EditForm.aspx?NoBuk=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("acc01h13EditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("acc01h13EditForm.aspx?NoBuk=" + id, "EditDialogWindows");
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
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight"
                               EnableLoadOnDemand="True"  Skin="Telerik" OnItemsRequested="cb_proj_prm_ItemsRequested"
                                OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px">

                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td>
                            <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="95%" Height="25px"
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
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClientClick="ShowInsertForm(); return false;" ToolTip="Add New"
                        Height="26px" Width="27px" ImageUrl="~/Images/tambah.png" ImageAlign="Bottom"></asp:ImageButton>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="29px" Width="30px" ImageUrl="~/Images/search.png"></asp:ImageButton>
                </td>
                <td style="width: 96%; text-align: right; padding-right:17px">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:#09a4f9; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>    

    <div  class="scroller" runat="server" style="overflow-y:scroll; height:620px">
            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" PageSize="14" Skin="Silk"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" CssClass="RadGrid_ModernBrowsers"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnPreRender="RadGrid1_PreRender"
                OnDeleteCommand="RadGrid1_DeleteCommand"
                OnItemCreated="RadGrid1_ItemCreated"
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged">
                <PagerStyle Mode="NextPrevAndNumeric" ></PagerStyle>          
                <ClientSettings EnablePostBackOnRowClick="false" />
                <ClientSettings EnablePostBackOnRowClick="false" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <HeaderStyle ForeColor="Highlight" Font-Size="12px" />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="NoBuk" Font-Size="11px" Font-Names="Century Gothic"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                    CommandItemSettings-ShowRefreshButton="false" CommandItemStyle-ForeColor="Highlight" 
                    CommandItemSettings-AddNewRecordText="New" EditFormSettings-EditFormType="WebUserControl" InsertItemDisplay="Bottom">
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="20px" HeaderStyle-Width="20px" ></telerik:GridClientSelectColumn> 
                    <telerik:GridBoundColumn UniqueName="NoBuk" HeaderText="Reg No." DataField="NoBuk" ItemStyle-Width="100px" FilterControlWidth="90px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn UniqueName="lbm_date" HeaderText="Date" DataField="Tgl" ItemStyle-Width="80px" 
                        EnableRangeFiltering="false" FilterControlWidth="100px" PickerType="DatePicker"
                        DataFormatString="{0:d}">
                        <HeaderStyle Width="100px"  HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project" DataField="region_code" ItemStyle-Width="60px" FilterControlWidth="50px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="NoFP" HeaderText="Invoice No." DataField="NoFP" ItemStyle-Width="70px" FilterControlWidth="70px"  
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="90px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="NoPO" HeaderText="PO No." DataField="NoPO" ItemStyle-Width="70px" FilterControlWidth="80px" 
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="90px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="NamSup" HeaderText="Suplier" DataField="NamSup" ItemStyle-Width="200px" FilterControlWidth="190px"  
                        ItemStyle-HorizontalAlign="Left" >
                        <HeaderStyle Width="220px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="Jumlah" HeaderText="Sub Total" DataField="Jumlah" ItemStyle-Width="120px" AllowFiltering="false" 
                        ItemStyle-HorizontalAlign="Right"  DataFormatString="{0:#,##0.00}" Visible="false" >
                        <HeaderStyle Width="120px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="DP" HeaderText="DP" DataField="DP" ItemStyle-Width="60px" AllowFiltering="false"
                        ItemStyle-HorizontalAlign="Right"  DataFormatString="{0:#,##0.00}" Visible="false">
                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="Tax1" HeaderText="Tax1" DataField="JPPN" ItemStyle-Width="60px" AllowFiltering="false"
                        ItemStyle-HorizontalAlign="Right"  DataFormatString="{0:#,##0.00}" Visible="false">
                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="Tax2" HeaderText="Tax2" DataField="JOTax" ItemStyle-Width="60px" AllowFiltering="false"
                        ItemStyle-HorizontalAlign="Right"  DataFormatString="{0:#,##0.00}" Visible="false">
                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn UniqueName="Tax3" HeaderText="Tax3" DataField="JPPH" ItemStyle-Width="60px" AllowFiltering="false"
                        ItemStyle-HorizontalAlign="Right"  DataFormatString="{0:#,##0.00}" Visible="false">
                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>     
                    <telerik:GridBoundColumn UniqueName="Total" HeaderText="Total" DataField="NET" ItemStyle-Width="120px" AllowFiltering="false"
                        ItemStyle-HorizontalAlign="Right"  DataFormatString="{0:#,##0.00}">
                        <HeaderStyle Width="120px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>                        
                    <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true" ItemStyle-Width="300px" 
                        AllowFiltering="false" Visible="false" >
                        <HeaderStyle Width="300px" HorizontalAlign="Center"></HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" AllowFiltering="False" ItemStyle-HorizontalAlign="Right" >
                    <ItemTemplate>                                
                        <asp:ImageButton ID="EditLink" runat="server" Height="22px" Width="25px" ImageUrl="~/Images/edit.png" ToolTip="Edit" />
                    </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px"  ItemStyle-HorizontalAlign="Right"
                            AllowFiltering="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/Images/cetak.png" ToolTip="Print" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" CommandName="Delete" 
                        ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="25px" HeaderStyle-Width="25px"
                        ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">                                
                        <ItemStyle ForeColor="Red" />
                    </telerik:GridButtonColumn>  
                                              
                </Columns>
                </MasterTableView>
                <ClientSettings>
                <Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="255px" />
                <Selecting AllowRowSelect="true" />
                <ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />
            </ClientSettings>
            </telerik:RadGrid>

       <%-- <div runat="server" style="width: 100%; padding-top: 8px;height:250px; overflow-y:auto; overflow-x:hidden">   
            <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                    <telerik:RadGrid runat="server" RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" Skin="Silk" PageSize="10" 
                        AllowPaging="true" AllowSorting="true" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="true" Width="1700px" 
                        OnNeedDataSource="RadGrid2_NeedDataSource" 
                        OnUpdateCommand="RadGrid2_UpdateCommand"
                        OnDeleteCommand="RadGrid2_DeleteCommand">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle ForeColor="Highlight" Font-Size="11px" Font-Names="Century Gothic" />
                        <MasterTableView CommandItemDisplay="None" DataKeyNames="prod_code" Font-Size="10px" EditMode="InPlace" 
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="false" />
                            <Columns>
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn" Visible="false"  
                                    HeaderText="Edit" HeaderStyle-Width="30px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn HeaderText="Reff. No" HeaderStyle-Width="120px" ItemStyle-Width="120px"
                                     HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblRefCode" Text='<%# DataBinder.Eval(Container.DataItem, "noref") %>' Width="120px"></asp:Label>                        
                                    </ItemTemplate>                                        
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Type" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center" 
                                     HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblProdType" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>                                           
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="KoBar" HeaderText="Material Code" HeaderStyle-Width="150px"  
                                    SortExpression="KoBar" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Left">
                                    <FooterTemplate>Template footer</FooterTemplate>
                                    <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "prod_code")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="Spec"
                                            DataValueField="prod_code" AutoPostBack="true" Font-Size="12px" Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>' 
                                            EmptyMessage="- Search product name here -" HighlightTemplatedItems="true" Height="190px" Width="150px" DropDownWidth="430px" 
                                            OnItemsRequested="cb_prod_code_ItemsRequested" 
                                            OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                            OnPreRender="cb_prod_code_PreRender">                                                   
                                            <HeaderTemplate>
                                            <table style="width: 430px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 250px;">
                                                        Prod. Name
                                                    </td>     
                                                    <td style="width: 180px;">
                                                        Prod. Code
                                                    </td>                                                           
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 430px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 250px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['Spec']")%>
                                                    </td>        
                                                    <td style="width: 180px;">
                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                    </td>                                                        
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="70px" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Right" 
                                     DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblPartQty" Text='<%# DataBinder.Eval(Container.DataItem, "Qty", "{0:#,###,###0.00}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="50px"  ReadOnly="false" 
                                            EnabledStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" 
                                            AllowOutOfRangeAutoCorrect="false" Text='<%# DataBinder.Eval(Container.DataItem, "Qty", "{0:#,###,###0.00}") %>'
                                            onkeydown="blurTextBox(this, event)" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center"
                                     HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>'></asp:Label>
                                    </ItemTemplate>                                        
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Price" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                                     DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblPrice" Text='<%# DataBinder.Eval(Container.DataItem, "Harga", "{0:#,###,###0.00}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtPrice" Width="90px"  ReadOnly="false" 
                                            EnabledStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" 
                                            AllowOutOfRangeAutoCorrect="false" Text='<%# DataBinder.Eval(Container.DataItem, "Harga", "{0:#,###,###0.00}") %>'
                                            onkeydown="blurTextBox(this, event)" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Disc.(%)" HeaderStyle-Width="80px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" 
                                     DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblDisc" Width="80px" Text='<%# DataBinder.Eval(Container.DataItem, "Disc", "{0:#,###,###0.00}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtDisc" Width="80px"  ReadOnly="false" EnabledStyle-HorizontalAlign="Right" 
                                            NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            Text='<%# DataBinder.Eval(Container.DataItem, "Disc", "{0:#,###,###0.00}") %>' onkeydown="blurTextBox(this, event)"
                                            AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Sub Price" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                                     DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblSubPrice" Text='<%# DataBinder.Eval(Container.DataItem, "harga2", "{0:#,###,###0.00}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtSubPrice" Width="90px"  ReadOnly="false" 
                                            EnabledStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" 
                                            AllowOutOfRangeAutoCorrect="false" Text='<%# DataBinder.Eval(Container.DataItem, "harga2", "{0:#,###,###0.00}") %>'
                                            onkeydown="blurTextBox(this, event)" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Other Cost" HeaderStyle-Width="100px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                                     DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblOtherCost" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "AssCost", "{0:#,###,###0.00}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtOtherCost" Width="90px"  ReadOnly="false" 
                                            EnabledStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" 
                                            AllowOutOfRangeAutoCorrect="false" Text='<%# DataBinder.Eval(Container.DataItem, "AssCost", "{0:#,###,###0.00}") %>'
                                            onkeydown="blurTextBox(this, event)" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Tax 1" HeaderStyle-Width="60px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" 
                                     HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkTax1" Enabled="false" Width="60px" Checked='<%# DataBinder.Eval(Container.DataItem, "tTax") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox runat="server" ID="edt_chkTax1" OnCheckedChanged="edt_chkTax1_CheckedChanged" OnPreRender="edt_chkTax1_PreRender"
                                            Checked='<%# DataBinder.Eval(Container.DataItem, "tTax") %>' />
                                    </EditItemTemplate>                                        
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Tax 2" HeaderStyle-Width="60px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                                     HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkOTax" Enabled="false" Width="60px" Checked='<%# DataBinder.Eval(Container.DataItem, "tOTax") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox runat="server" ID="edt_chkOTax" OnCheckedChanged="edt_chkOTax_CheckedChanged" OnPreRender="edt_chkOTax_PreRender"
                                            Checked='<%# DataBinder.Eval(Container.DataItem, "tOTax") %>' />
                                    </EditItemTemplate>                                        
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Tax 3" HeaderStyle-Width="60px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                                     HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkTpph" Enabled="false" Width="60px" Checked='<%# DataBinder.Eval(Container.DataItem, "tpph") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox runat="server" ID="edt_chkTpph" OnCheckedChanged="edt_chkTpph_CheckedChanged" OnPreRender="edt_chkTpph_PreRender"
                                            Checked='<%# DataBinder.Eval(Container.DataItem, "tpph") %>' />
                                    </EditItemTemplate>                                        
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Cost Ctr." HeaderStyle-Width="100px" ItemStyle-Width="100px" 
                                     HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblCostCtr" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="250px" ItemStyle-Width="250px"
                                     HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblRemark_d"></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="250px"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Reff. Date" HeaderStyle-Width="110px"  ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-HorizontalAlign="Center" >
                                    <ItemTemplate>  
                                        <telerik:RadDatePicker runat="server" ID="dtp_ReffDate" Width="110px"
                                            DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.ref_date")%>' 
                                            onkeydown="blurTextBox(this, event)" Type="Date">
                                            <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                        </telerik:RadDatePicker>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Ctrl. No" HeaderStyle-Width="100px" ItemStyle-Width="100px" 
                                     HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblRS" Text='<%# DataBinder.Eval(Container.DataItem, "nocontr") %>'></asp:Label>
                                    </ItemTemplate>                                        
                                </telerik:GridTemplateColumn>                
                                <telerik:GridTemplateColumn HeaderText="Ori. Material" HeaderStyle-Width="120px" ItemStyle-Width="120px" 
                                     HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblProdOri" Enabled="false"></asp:Label>
                                    </ItemTemplate>                                      
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                                     ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton" 
                                    ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                    <ItemStyle ForeColor="Red" />
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView> 
                        <ClientSettings>
                            <Selecting AllowRowSelect="true"></Selecting>                          
                        </ClientSettings>
                    </telerik:RadGrid>
                    <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data tersimpan" Position="BottomRight"
                        AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
                    </telerik:RadNotification>
                </ContentTemplate>
            </asp:UpdatePanel>           
        </div>--%>
     
    </div>  
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                Width="1150px" Height="670px" Modal="true" AutoSize="True">
            </telerik:RadWindow>
            <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="false" ShowContentDuringLoad="false"
                Width="1510px" Height="740px" Modal="true" AutoSize="False" >
            </telerik:RadWindow>
                
        </Windows>
    </telerik:RadWindowManager>
        
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
    </telerik:RadWindowManager>
        
</asp:Content>
