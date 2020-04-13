<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc00h22.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Asset.acc00h22" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <script src="../../../Script/Script.js"></script>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("reportViewer.aspx?doc_no=" + id, "PreviewDialog");
                return false;
            }

        </script>
    </telerik:RadCodeBlock>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
     <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
        <AjaxSettings>            
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="1250px" Height="670px">
        <ContentTemplate>
             <div runat="server" style="padding:20px 10px 10px 10px;" id="searchParam">
                 <table>
                     <tr>                         
                         <td style="width:320px">
                              <telerik:RadComboBox ID="cb_project_prm" runat="server" RenderMode="Lightweight" Label="Project" AutoPostBack="false"
                                EnableLoadOnDemand="True" Skin="MetroTouch"  OnItemsRequested="cb_project_prm_ItemsRequested" EnableVirtualScrolling="true" 
                                Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px"
                                OnSelectedIndexChanged="cb_project_prm_SelectedIndexChanged"></telerik:RadComboBox>
                         </td>
                         <td style="width:320px">
                              <telerik:RadComboBox ID="cb_status_prm" runat="server" RenderMode="Lightweight" Label="Status" AutoPostBack="false"
                                EnableLoadOnDemand="True" Skin="MetroTouch"  OnItemsRequested="cb_status_prm_ItemsRequested" EnableVirtualScrolling="true" 
                                Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px"
                                OnSelectedIndexChanged="cb_status_prm_SelectedIndexChanged"></telerik:RadComboBox>
                         </td>
                         <td >
                              <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Retrieve" BorderStyle="Solid" BackColor="Transparent"
                                  Width="120px" Height="25px" />
                         </td>
                         <td >
                             <asp:Button ID="btnOk" runat="server" Text="Select & Close" BorderStyle="Solid" BackColor="Transparent"
                                  Width="120px" Height="25px" />
                         </td>
                     </tr>
                 </table>  
            </div>
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="10"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <ClientSettings EnablePostBackOnRowClick="true" >
                </ClientSettings>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="asset_id" Font-Size="12px"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                     CommandItemSettings-ShowRefreshButton="false" >  
                    <ColumnGroups>
                        <telerik:GridColumnGroup HeaderText="Book Depreciation" Name="BookDepreciation" HeaderStyle-HorizontalAlign="Center">
                        </telerik:GridColumnGroup>
                    </ColumnGroups>                  
                    <Columns>
                        <telerik:GridClientSelectColumn UniqueName="SelectColumn" ></telerik:GridClientSelectColumn> 
                        <telerik:GridBoundColumn UniqueName="asset_id" HeaderText="Asset Number" DataField="asset_id">
                            <HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="AssetName" HeaderText="Asset Name" DataField="AssetName" 
                                ItemStyle-Width="250px" FilterControlWidth="250px">
                            <HeaderStyle Width="250px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="AssetSpec" HeaderText="Specification" DataField="AssetSpec" 
                                ItemStyle-Width="250px" FilterControlWidth="250px">
                            <HeaderStyle Width="250px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="tgl_beli" HeaderText="Order Date" DataField="tgl_beli" ItemStyle-Width="70px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="70px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="curr_code" HeaderText="Curr" DataField="curr_code" ItemStyle-HorizontalAlign="Left"
                                ItemStyle-Width="50px" FilterControlWidth="50px">
                            <HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project Area" DataField="region_code" 
                            FilterControlWidth="50px" >
                            <HeaderStyle Width="50px"></HeaderStyle>
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn ColumnGroupName="BookDepreciation" UniqueName="exp_life_year" HeaderText="Ulife" DataField="exp_life_year" 
                            FilterControlWidth="30px" ItemStyle-HorizontalAlign="Center" >
                            <HeaderStyle Width="30px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn ColumnGroupName="BookDepreciation" UniqueName="mtd_per" HeaderText="%" DataField="mtd_per" 
                            FilterControlWidth="50px" ItemStyle-HorizontalAlign="Center">
                            <HeaderStyle Width="50px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn ColumnGroupName="BookDepreciation" UniqueName="Methode" HeaderText="Methode" DataField="Methode" 
                            FilterControlWidth="150px" >
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn ColumnGroupName="BookDepreciation" HeaderText="PreDrepre" ItemStyle-Width="180px" 
                            ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                            <ItemTemplate>  
                                <%#DataBinder.Eval(Container.DataItem, "Susut", "{0:#,###,###0.00}")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn> 
                        <telerik:GridTemplateColumn ColumnGroupName="BookDepreciation" HeaderText="Acquistion Value" ItemStyle-Width="180px" 
                            ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                            <ItemTemplate>  
                                <%#DataBinder.Eval(Container.DataItem, "aquis_value", "{0:#,###,###0.00}")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>  
                        <telerik:GridTemplateColumn ColumnGroupName="BookDepreciation" HeaderText="Acquistion Value" ItemStyle-Width="180px" 
                            ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                            <ItemTemplate>  
                                <%#DataBinder.Eval(Container.DataItem, "harga_min", "{0:#,###,###0.00}")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn> 
                         <telerik:GridBoundColumn ColumnGroupName="BookDepreciation" UniqueName="Depstart" HeaderText="Depre Start" DataField="Depstart" 
                            FilterControlWidth="150px" >
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridBoundColumn>                       
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" HeaderText="Delete"
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                        </telerik:GridButtonColumn>                            
                    </Columns>
                   
                </MasterTableView>
                <ClientSettings>                         
                    <Selecting AllowRowSelect="true"></Selecting>
                </ClientSettings>
            </telerik:RadGrid>
           
        </ContentTemplate>
    </telerik:RadWindow>

    <div class="scroller" runat="server">
        <div style=" padding-left:15px; width:100%; border-bottom-color: #FF9933; border-bottom-width: 1px; border-bottom-style: inset;">
            <table id="tbl_control">
                <tr>
                                        
                    <td  style="text-align:right;vertical-align:middle;">
                        <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                            Height="30px" Width="35px" ImageUrl="~/Images/daftar.png" >                            
                        </asp:ImageButton>                                                 
                    </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:8px">
                        <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" 
                            Height="30px" Width="32px" ImageUrl="~/Images/tambah.png">
                        </asp:ImageButton>
                    </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:13px">
                        <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" 
                            Height="30px" Width="32px" ImageUrl="~/Images/simpan-gray.png">
                        </asp:ImageButton>
                    </td>
                                       
                    <td style="width:89%; text-align:right">
                        <telerik:RadLabel ID="lbl_form_name" Text="Asset Register" runat="server" style="font-weight:lighter; 
                            font-size:10px; font-variant: small-caps; padding-left:10px; 
                        padding-bottom:0px; font-size:x-large; color:Highlight"></telerik:RadLabel>
                    </td>
                </tr>
            </table>            
        </div>

        <div class="table_trx" id="div1">                               
            <table id="Table1" border="0" >    
                <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module">                
                            <tr>
                                <td class="tdLabel">
                                    Asset Number:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_doc_number" runat="server" Width="250px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                       
                                </td>
                            </tr> 
                            <tr>
                                <td class="tdLabel">
                                    UR Number:
                                </td>
                                <td>
                                   <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ur_number" runat="server" Width="350px" 
                                    DropDownWidth="650px" EmptyMessage="- Select Document Number -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                        MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true" AutoPostBack="true"  >
                                        <HeaderTemplate>
                                            <table style="width: 700px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 350px;">
                                                        UR Number
                                                    </td>
                                                    <td style="width: 350px;">
                                                        Description
                                                    </td>                                                                
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 700px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.doc_no")%>
                                                    </td>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.description")%>
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
                                <td class="tdLabel">
                                    Asset Name :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_asset_name" runat="server" Width="450px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Material Code :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="RadTextBox1" runat="server" Width="120px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                                <td class="tdLabel">
                                    Qty :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="RadTextBox2" runat="server" Width="50px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                                <td class="tdLabel">
                                    UoM :
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_uom" runat="server" Width="120px" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                          >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>            
                            <tr>
                                <td class="tdLabel">
                                    Date :
                                </td>
                                <td>
                                <telerik:RadDatePicker ID="dtp_doc"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                    TabIndex="4" Skin="MetroTouch"> 
                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="MetroTouch" 
                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                    </DateInput>
                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                </telerik:RadDatePicker>
                            </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Due Date :
                                </td>
                                <td>
                                <telerik:RadDatePicker ID="dtp_due_date" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                    TabIndex="4" Skin="MetroTouch">
                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                        FastNavigationNextText="&amp;lt;&amp;lt;" Skin="MetroTouch"></Calendar>
                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                    </DateInput>
                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                </telerik:RadDatePicker>
                            </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Object :
                                </td>                
                                <td style="vertical-align:top; text-align:left">                               
                                    <telerik:RadTextBox ID="txt_object" 
                                        runat="server" TextMode="MultiLine"
                                        Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                    </telerik:RadTextBox>                                  
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Total Amount :
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_amount" Width="150px" NumberFormat-AllowRounding="true"
                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" >
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Project :
                                </td>
                                <td>                    
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="250px" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                         OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                         OnPreRender="cb_project_PreRender" >
                                    </telerik:RadComboBox>   
                                </td>
                            </tr>
                            <tr >
                                <td class="tdLabel">
                                    Departement:
                                </td>
                                <td style="vertical-align:top; text-align:left">                                   
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cost_center" runat="server" Width="250px" DropDownWidth="300px"
                                      EnableLoadOnDemand="True" Skin="MetroTouch" ShowMoreResultsBox="false" EnableVirtualScrolling="false" 
                                       EmptyMessage="- Select a department -" OnItemsRequested="cb_cost_center_ItemsRequested" OnSelectedIndexChanged="cb_cost_center_SelectedIndexChanged"
                                         OnPreRender="cb_cost_center_PreRender" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Payment to :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_pay_to" runat="server" Width="450px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Remark:
                                </td>                
                                <td style="vertical-align:top; text-align:left">                               
                                    <telerik:RadTextBox ID="txt_remark" runat="server" TextMode="MultiLine" Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                    </telerik:RadTextBox>                                  
                                </td>
                            </tr>
                            <tr>
                                <td style="width:120px;vertical-align:top">
                                    Payment Method :
                                </td>                
                                <td style="vertical-align:top; text-align:left">                               
                                    <telerik:RadTextBox ID="txt_pay_methode" runat="server" TextMode="MultiLine" Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                    </telerik:RadTextBox>                                  
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align: top; padding-left:15px">
                        <table id="Table3" border="0" class="module">
                            <tr>
                                <td class="tdLabel">
                                    Request By:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_request" runat="server" Width="250px" 
                                            DropDownWidth="650px" EmptyMessage="- Select -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                             MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true" 
                                                 OnItemsRequested="cb_approved_ItemsRequested" OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                OnPreRender="cb_approved_PreRender" >
                                                <HeaderTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                Name
                                                            </td>
                                                            <td style="width: 350px;">
                                                                Position
                                                            </td>                                                                
                                                        </tr>
                                                    </table>                                                       
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                            </td>
                                                            <td style="width: 350px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                            </td>                                                                
                                                        </tr>
                                                    </table>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <%--A total of
                                                    <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                    items--%>
                                                </FooterTemplate>                                                        
                                            </telerik:RadComboBox>
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">                                    
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_request2" runat="server" Width="250px" 
                                            DropDownWidth="650px" EmptyMessage="- Select -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                             MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true" 
                                                 OnItemsRequested="cb_approved_ItemsRequested" OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                OnPreRender="cb_approved_PreRender" >
                                                <HeaderTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                Name
                                                            </td>
                                                            <td style="width: 350px;">
                                                                Position
                                                            </td>                                                                
                                                        </tr>
                                                    </table>                                                       
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                            </td>
                                                            <td style="width: 350px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                            </td>                                                                
                                                        </tr>
                                                    </table>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <%--A total of
                                                    <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                    items--%>
                                                </FooterTemplate>                                                        
                                            </telerik:RadComboBox>
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Approved By:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                  <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px" 
                                            DropDownWidth="650px" EmptyMessage="- Select -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                             MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true" 
                                               OnItemsRequested="cb_approved_ItemsRequested" OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                OnPreRender="cb_approved_PreRender" >  
                                                <HeaderTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                Name
                                                            </td>
                                                            <td style="width: 350px;">
                                                                Position
                                                            </td>                                                                
                                                        </tr>
                                                    </table>                                                       
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                            </td>
                                                            <td style="width: 350px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                            </td>                                                                
                                                        </tr>
                                                    </table>

                                                </ItemTemplate>
                                               <FooterTemplate>
                                                    <%--A total of
                                                    <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                    items--%>
                                                </FooterTemplate>                                                        
                                            </telerik:RadComboBox>
                                       </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                  <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved2" runat="server" Width="250px" 
                                            DropDownWidth="650px" EmptyMessage="- Select -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                             MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true" 
                                               OnItemsRequested="cb_approved_ItemsRequested" OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                OnPreRender="cb_approved_PreRender" >  
                                                <HeaderTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                Name
                                                            </td>
                                                            <td style="width: 350px;">
                                                                Position
                                                            </td>                                                                
                                                        </tr>
                                                    </table>                                                       
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                            </td>
                                                            <td style="width: 350px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                            </td>                                                                
                                                        </tr>
                                                    </table>

                                                </ItemTemplate>
                                               <FooterTemplate>
                                                    <%--A total of
                                                    <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                    items--%>
                                                </FooterTemplate>                                                        
                                            </telerik:RadComboBox>
                                       </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>

                            <tr>
                                <td style="vertical-align:top;padding-top:17px">Status :</td>
                                <td style="vertical-align:top;padding-top:17px">
                                    <asp:RadioButtonList ID="rbl_status" runat="server" OnSelectedIndexChanged="rbl_status_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Selected="False" Value="0">Open</asp:ListItem>
                                        <asp:ListItem Selected="False" Value="1">Approve</asp:ListItem>
                                        <asp:ListItem Selected="False" Value="2">Close</asp:ListItem>
                                        <asp:ListItem Selected="False" Value="3">Unapprove</asp:ListItem>
                                        <asp:ListItem Selected="False" Value="4">Cancel</asp:ListItem>
                                        <asp:ListItem Selected="False" Value="5">Hold</asp:ListItem>
                                    </asp:RadioButtonList>
                               </td>                                
                            </tr>
                            <tr>
                                <td></td>
                                <td >
                                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadDatePicker ID="dtp_approved_date" runat="server" MinDate="1/1/1900" DateInput-Width="130px"
                                                Width="150px" RenderMode="Lightweight" Enabled="false" TabIndex="4" Skin="MetroTouch" DateInput-Label="Approved Date : "> 
                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="MetroTouch" 
                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                            </DateInput>                          
                                            </telerik:RadDatePicker>
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="rbl_status" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>           
                    </td>
                    
                </tr>    
                <tr>
                    <td colspan="3" style="padding-top:40px; padding-bottom:20px;">
                        <table>
                            <tr>
                                <td style="padding:0px 10px 0px 10px">
                                    User 
                                </td>
                                <td style="width:50px">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="50px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width:80px; padding-left:15px">
                                    Last Update 
                                </td>
                                <td style="width:70px;">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_lastUpdate" Width="160px" runat="server" Skin="MetroTouch">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding:0px 10px 0px 10px">
                                    Owner 
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="50px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <%--<td style="padding:0px 10px 0px 10px">
                                    Printed 
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_printed" Width="40px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>--%>
                                <td style="padding:0px 10px 0px 10px">
                                    Edited
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>                                
                            </tr>
                           
                            
                        </table>
                    </td>
                </tr>   
            </table>
        </div>

        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server"  ReloadOnShow="false" ShowContentDuringLoad="false"
                  Width="1150px" Height="670px" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
            
         <script type="text/javascript">
        //<![CDATA[
            Sys.Application.add_load(function() {
                $windowContentDemo.contentTemplateID = "<%=RadWindow_ContentTemplate.ClientID%>";
                $windowContentDemo.templateWindowID = "<%=RadWindow_ContentTemplate.ClientID %>";
            });
        //]]>
        </script>  
    </div>
</asp:Content>
