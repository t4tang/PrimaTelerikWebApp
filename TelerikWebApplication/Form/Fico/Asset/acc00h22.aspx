<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc00h22.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Asset.acc00h22" %>

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
                window.radopen("acc00d22.aspx?asset_id=" + id, "PreviewDialog");
                return false;
            }

        </script>
    </telerik:RadCodeBlock>
    <style type="text/css">      
       div.RadGrid .rgPager .rgAdvPart     
       {     
        display:none;        
       }      
    </style> 
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
             <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_retrive_depre">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_depre_by_prm">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_years_depre_prm" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_new">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="1250px" Height="670px">
        <ContentTemplate>
             <div runat="server" style="padding:10px 10px 10px 10px;" id="searchParam">
                 <table>
                     <tr>                         
                         <td style="width:320px">
                              <telerik:RadComboBox ID="cb_project_prm" runat="server" RenderMode="Lightweight" Label="Project" AutoPostBack="false"
                                EnableLoadOnDemand="True" Skin="Silk"  EnableVirtualScrolling="true"  ShowMoreResultsBox="true"
                                Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px" 
                                OnItemsRequested="cb_project_prm_ItemsRequested" OnSelectedIndexChanged="cb_project_prm_SelectedIndexChanged" 
                                OnPreRender="cb_project_prm_PreRender" BorderStyle="NotSet"></telerik:RadComboBox>
                         </td>
                         <td style="width:320px">
                              <telerik:RadComboBox ID="cb_status_prm" runat="server" RenderMode="Lightweight" Label="Status" AutoPostBack="false"
                                EnableLoadOnDemand="True" Skin="Silk"  OnItemsRequested="cb_status_prm_ItemsRequested" EnableVirtualScrolling="true" 
                                Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px"
                                OnSelectedIndexChanged="cb_status_prm_SelectedIndexChanged" BorderStyle="NotSet"></telerik:RadComboBox>
                         </td>
                         <td >
                              <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Retrieve" BorderStyle="Solid" BackColor="Transparent"
                                  Width="120px" Height="25px" BorderColor="#FF6600" BorderWidth="1px" />
                         </td>
                         <td >
                             <asp:Button ID="btnOk" runat="server" Text="Select & Close" BorderStyle="Solid" BackColor="Transparent" OnClick="btnOk_Click"
                                  Width="120px" Height="25px" BorderColor="#FF6600" BorderWidth="1px" />
                         </td>
                     </tr>
                 </table>  
            </div>
            <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:thin ">
                <table id="tbl_control2">
                    <tr>       
                        <td style="vertical-align: middle; margin-left: 10px; padding:0px 0px 0px 0px">
                            <telerik:RadButton ID="btn_new" runat="server" ForeColor="OrangeRed" BackColor="#33ccff" Text="New" Width="80px" Height="30px"
                                Skin="Telerik" OnClick="btn_new_Click" ></telerik:RadButton>
                        </td>                    
                        <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                     
                        </td>                           
                        <td style="width: 98%; text-align: right; padding-right:17px">
                                <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <telerik:RadLabel ID="RadLabel1" Text="Asset" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                                    </telerik:RadLabel>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </div> 
            <div runat="server" style="margin-right:10px" id="Div2">
                <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Silk"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="12" CssClass="RadGrid_ModernBrowsers"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
                <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic" DataKeyNames="asset_id"
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
                                ItemStyle-Width="330px" FilterControlWidth="330px">
                            <HeaderStyle Width="330px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="AssetSpec" HeaderText="Specification" DataField="AssetSpec" 
                                ItemStyle-Width="330px" FilterControlWidth="330px">
                            <HeaderStyle Width="330px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="tgl_beli" HeaderText="Order Date" DataField="tgl_beli" ItemStyle-Width="70px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="70px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project Area" DataField="region_code" 
                            FilterControlWidth="80px" >
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                       <%--
                        <telerik:GridBoundColumn UniqueName="curr_code" HeaderText="Curr" DataField="curr_code" ItemStyle-HorizontalAlign="Left"
                                ItemStyle-Width="50px" FilterControlWidth="50px">
                            <HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
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
                        </telerik:GridBoundColumn>           --%>                   
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" HeaderText="Delete"
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                        </telerik:GridButtonColumn>                     
                    </Columns>
                   
                </MasterTableView>
                <ClientSettings>                         
                    <Selecting AllowRowSelect="true"></Selecting>
                </ClientSettings>
            </telerik:RadGrid>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>
    
    <div class="scroller" style="overflow-y:scroll; height:620px" runat="server"> 

        <div style=" padding-left:15px; width:100%; border-bottom-color: #FF9933; border-bottom-width: 1px; border-bottom-style: inset;">
            <table id="tbl_control">
                <tr>
                                        
                    <td  style="text-align:right;vertical-align:middle;">
                        <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                            Height="30px" Width="35px" ImageUrl="~/Images/daftar.png" >                            
                        </asp:ImageButton>                                                 
                    </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:8px">
                        <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/tambah.png">
                        </asp:ImageButton>
                    </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:13px">
                        <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save"
                            Height="30px" Width="32px" ImageUrl="~/Images/simpan-gray.png"
                            OnClick="btnSave_Click">
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

        <div class="table_trx" id="div1" style="padding-bottom:5px">                               
            <table id="Table1" border="0" >    
                <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module">                
                            <tr>
                                <td class="tdLabel">
                                    Asset Number:
                                </td>
                                <td colspan="5">
                                    <telerik:RadTextBox ID="txt_doc_number" runat="server" Width="250px" ReadOnly="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                       
                                </td>
                            </tr> 
                            <tr>
                                <td class="tdLabel">
                                    UR Number:
                                </td>
                                <td colspan="5">
                                   <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ur_number" runat="server" Width="250px"  ReadOnly="true"
                                    DropDownWidth="900px" EmptyMessage="- Select Document Number -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" AutoPostBack="true" 
                                       OnItemsRequested="cb_ur_number_ItemsRequested" OnSelectedIndexChanged="cb_ur_number_SelectedIndexChanged" >
                                        <HeaderTemplate>
                                            <table style="width: 900px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 150px; text-align:left">
                                                        UR Number
                                                    </td>
                                                    <td style="width: 150px; text-align:left">
                                                        Part Code
                                                    </td>
                                                    <td style="width: 350px; text-align:left">
                                                        Description
                                                    </td>
                                                    <td style="width: 50px; text-align:left">
                                                        Qty
                                                    </td>                                                                
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 900px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 150px; text-align:left">
                                                        <%# DataBinder.Eval(Container, "DataItem.doc_code")%>
                                                    </td>
                                                    <td style="width: 150px; text-align:left">
                                                        <%# DataBinder.Eval(Container, "DataItem.part_code")%>
                                                    </td>
                                                    <td style="width: 350px; text-align:left">
                                                        <%# DataBinder.Eval(Container, "DataItem.part_desc")%>
                                                    </td>
                                                    <td style="width: 50px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.qty_Sisa")%>
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
                                <td colspan="5">
                                    <telerik:RadTextBox ID="txt_asset_name" runat="server" Width="330px" Enabled="true" RenderMode="Lightweight"
                                        ReadOnly="false" AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Material Code :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_material_code" ReadOnly="true" runat="server" Width="180px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:10px">
                                    Qty :
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty" Width="70px" NumberFormat-AllowRounding="true"
                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ReadOnly="true" 
                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" >
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td style="padding-left:10px">
                                    UoM :
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_uom" runat="server" Width="100px" ReadOnly="true" 
                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Silk"
                                         OnItemsRequested="cb_uom_ItemsRequested" OnSelectedIndexChanged="cb_uom_SelectedIndexChanged" OnPreRender="cb_uom_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr> 
                            <tr>
                                <td class="tdLabel">
                                    Specification :
                                </td>
                                <td colspan="5">
                                    <telerik:RadTextBox ID="txt_spec" runat="server" Width="430px" Enabled="true" RenderMode="Lightweight" ReadOnly="false" 
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Asset Class :
                                </td>
                                <td colspan="5">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_asset_class" runat="server" Width="250px"  ReadOnly="true"
                                    DropDownWidth="700px" EmptyMessage="- Select Asset Class -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" AutoPostBack="true"
                                        OnItemsRequested="cb_asset_class_ItemsRequested" OnSelectedIndexChanged="cb_asset_class_SelectedIndexChanged"
                                        OnPreRender="cb_asset_class_PreRender">
                                        <HeaderTemplate>
                                            <table style="width: 700px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 120px; text-align:left">
                                                        Code
                                                    </td>
                                                    <td style="width: 250px; text-align:left">
                                                        Asset Class
                                                    </td>
                                                    <td style="width: 70px; text-align:center">
                                                        Useful Life
                                                    </td>
                                                    <td style="width: 250px; text-align:left">
                                                        Methode
                                                    </td>                                                                
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 700px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 120px; text-align:left">
                                                        <%# DataBinder.Eval(Container, "DataItem.AK_CODE")%>
                                                    </td>
                                                    <td style="width: 250px; text-align:left">
                                                        <%# DataBinder.Eval(Container, "DataItem.AK_NAME")%>
                                                    </td>
                                                    <td style="width: 70px; text-align:center">
                                                        <%# DataBinder.Eval(Container, "DataItem.exp_life_year")%>
                                                    </td>
                                                    <td style="width: 250px; text-align:left">
                                                        <%# DataBinder.Eval(Container, "DataItem.Method")%>
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
                                    Asset Type :
                                </td>
                                <td colspan="5">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_asset_type" runat="server" Width="250px"  ReadOnly="true"
                                    EmptyMessage="- Select Asset Type -" ShowMoreResultsBox="true"  EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" AutoPostBack="false"
                                        OnItemsRequested="cb_asset_type_ItemsRequested" OnSelectedIndexChanged="cb_asset_type_SelectedIndexChanged"
                                         OnPreRender="cb_asset_type_PreRender">
                                    </telerik:RadComboBox>
                                    
                                </td>
                            </tr>                            
                                             
                        </table>
                    </td>
                    <td style="vertical-align: top; padding-left:15px">
                        <table id="Table3" border="0" class="module">
                            <tr>
                                <td class="tdLabel">
                                    Asset Status :
                                </td>
                                <td colspan="5">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_asset_status" runat="server" Width="250px"  ReadOnly="true"
                                    DropDownWidth="300px" EmptyMessage="- Select Asset Status -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" AutoPostBack="False"
                                        OnItemsRequested="cb_asset_status_ItemsRequested" OnSelectedIndexChanged="cb_asset_status_SelectedIndexChanged"
                                        OnPreRender="cb_asset_status_PreRender"></telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Tax Group :
                                </td>
                                <td colspan="5">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_taxx_group" runat="server" Width="250px"  ReadOnly="true"
                                    DropDownWidth="300px" EmptyMessage="- Select Tax Group -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" AutoPostBack="False"
                                        OnItemsRequested="cb_taxx_group_ItemsRequested" OnSelectedIndexChanged="cb_taxx_group_SelectedIndexChanged"
                                        OnPreRender="cb_taxx_group_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>           
                            <tr>
                                <td class="tdLabel">
                                    Serial Number :
                                </td>
                                <td colspan="5">
                                    <telerik:RadTextBox ID="txt_serial_number" runat="server" Width="250px" RenderMode="Lightweight"
                                        ReadOnly="false" AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Project :
                                </td>
                                <td>   
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="350px" ReadOnly="true"
                                    DropDownWidth="650px" EmptyMessage="- Select a Project -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" AutoPostBack="true"
                                        OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                        OnPreRender="cb_project_PreRender">
                                        <HeaderTemplate>
                                            <table style="width: 400px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 150px;">
                                                        Project Code
                                                    </td>
                                                    <td style="width: 250px;">
                                                        Project Name
                                                    </td>                                                                
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 400px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 150px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.region_code")%>
                                                    </td>
                                                    <td style="width: 250px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.region_name")%>
                                                    </td>                                                                
                                                </tr>
                                            </table>

                                        </ItemTemplate>
                                        <FooterTemplate>
                                        </FooterTemplate>                                                        
                                    </telerik:RadComboBox>   
                                </td>
                            </tr>
                            <tr >
                                <td class="tdLabel">
                                    Cost Center:
                                </td>
                                <td style="vertical-align:top; text-align:left">                                   
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cost_center" runat="server" Width="350px"  ReadOnly="true"
                                    DropDownWidth="650px" EmptyMessage="- Select a Cost Center -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" AutoPostBack="true" 
                                        OnItemsRequested="cb_cost_center_ItemsRequested" OnSelectedIndexChanged="cb_cost_center_SelectedIndexChanged"
                                        OnPreRender="cb_cost_center_PreRender">
                                        <HeaderTemplate>
                                            <table style="width: 400px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 150px;">
                                                        Cost Center Code
                                                    </td>
                                                    <td style="width: 250px;">
                                                        Cost Center Name
                                                    </td>                                                                
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 400px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 150px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.CostCenter")%>
                                                    </td>
                                                    <td style="width: 250px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.CostCenterName")%>
                                                    </td>                                                                
                                                </tr>
                                            </table>

                                        </ItemTemplate>
                                        <FooterTemplate>
                                        </FooterTemplate>                                                        
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr >
                                <td class="tdLabel">
                                    Unit Code:
                                </td>
                                <td style="vertical-align:top; text-align:left">                                   
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_unit" runat="server" Width="350px"  ReadOnly="true"
                                    DropDownWidth="650px" EmptyMessage="- Select a Unit -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" AutoPostBack="true" 
                                        OnItemsRequested="cb_unit_ItemsRequested" >
                                        <HeaderTemplate>
                                            <table style="width: 550px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 80px;">
                                                        Unit Code
                                                    </td>
                                                    <td style="width: 300px;">
                                                        Unit Name
                                                    </td>
                                                    <td style="width: 120px;">
                                                        Model No.
                                                    </td>
                                                    <td style="width: 50px;">
                                                        Project
                                                    </td>                                                                
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 550px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 80px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                    </td>
                                                    <td style="width: 300px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.unit_name")%>
                                                    </td>
                                                    <td style="width: 120px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.model_no")%>
                                                    </td>
                                                    <td style="width: 50px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.region_code")%>
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
                                    PIC Asset:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_pic" runat="server" Width="250px"  ReadOnly="true"
                                            EmptyMessage="- Select PIC     -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                             MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" 
                                             OnItemsRequested="cb_pic_ItemsRequested" OnSelectedIndexChanged="cb_pic_SelectedIndexChanged"
                                                OnPreRender="cb_pic_PreRender">                                                                                                     
                                            </telerik:RadComboBox>
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>                           
                        </table>           
                    </td>
                    
                </tr>    
                   
            </table>
        </div>

        <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 5px;" class="table_trx">
            <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="97%" 
            SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Silk">
            <Tabs>
                <telerik:RadTab Text="Purchase Detail" Height="15px"> 
                </telerik:RadTab>
                <telerik:RadTab Text="Book Depreciation" Height="15px">
                </telerik:RadTab>
                <telerik:RadTab Text="Account Setting" Height="15px">
                </telerik:RadTab>
                <telerik:RadTab Text="Selling Detail" Height="15px">
                </telerik:RadTab>
                <telerik:RadTab Text="Depreciation Info" Height="15px">
                </telerik:RadTab>
            </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage runat="server" ID="RadMultiPage1"  SelectedIndex="0" Width="97%" >
                <telerik:RadPageView runat="server" ID="RadPageView1" Height="358px">
                    <table>
                        <tr>
                            <td>
                                <table style="padding: 10px 0px 0px 10px">
                                    <tr >
                                        <td >
                                            Currency :
                                        </td>
                                        <td>
                                            <%--<telerik:RadTextBox ReadOnly="true" ID="txt_currency" Width="70px" runat="server" >
                                                </telerik:RadTextBox>--%>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_currency" runat="server" Width="120px"
                                                EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" 
                                                OnItemsRequested="cb_currency_ItemsRequested" OnSelectedIndexChanged="cb_currency_SelectedIndexChanged"
                                                OnPreRender="cb_currency_PreRender">                                                                                                     
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="padding-left:10px" >
                                            Kurs :
                                        </td>
                                        <td>
                                            <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_tax_kurs" Width="100px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  ReadOnly="true"
                                                    onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" BorderStyle="None">
                                                </telerik:RadTextBox>  
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Purchase Cost :
                                        </td>
                                        <td colspan="3">
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_pur_cost" Width="150px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" AutoPostBack="true"
                                                    onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" Value="0" EnabledStyle-HorizontalAlign="Right"
                                                 OnTextChanged="txt_pur_cost_TextChanged">
                                                </telerik:RadNumericTextBox>                                
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Purchase Cost (Valas):
                                        </td>
                                        <td colspan="3">
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_pur_cost_valas" Width="150px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  ReadOnly="true" EnabledStyle-HorizontalAlign="Right"
                                                    onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" Value="0" >
                                                </telerik:RadNumericTextBox>                                
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >
                                            Order Number :
                                        </td>
                                        <td colspan="3">
                                            <telerik:RadTextBox ID="txt_order_no" Width="150px" runat="server" >
                                                </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                       <td >
                                            Order Date :
                                        </td>
                                        <td colspan="3">
                                            <telerik:RadDatePicker ID="dtp_order_date"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                TabIndex="4" Skin="Silk"> 
                                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Silk" 
                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                </DateInput>
                                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                            </telerik:RadDatePicker>
                                        </td>
                                   </tr>
                                </table>
                            </td>                            
                        </tr>
                    </table>                    
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView2" Height="358px">
                    <table>
                        <tr>
                            <td>
                                <table style="padding: 10px 0px 0px 10px">
                                    <tr >
                                        <td >
                                            Useful Life (Year):
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_use_life_year" Width="70px" runat="server" 
                                                Text="0" EnabledStyle-HorizontalAlign="Center" >
                                                </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >
                                            Depreciation Method :
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_dep_method" Width="150px" runat="server" >
                                                </telerik:RadTextBox> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Appreciation :
                                        </td>
                                        <td >
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_appreciation" Width="70px" runat="server" 
                                                Text="0" EnabledStyle-HorizontalAlign="Center">
                                                </telerik:RadTextBox> %                              
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            PreDepre:
                                        </td>
                                        <td >
                                            <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_pre_depre_month" Width="70px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" Value="0" EnabledStyle-HorizontalAlign="Center"
                                                    onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="0" >
                                                </telerik:RadNumericTextBox> Month                                
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >
                                            PreDepre (Value) :
                                        </td>
                                        <td >
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_pre_depre_val" Width="150px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" Value="0" EnabledStyle-HorizontalAlign="Right" 
                                                    onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" >
                                                </telerik:RadNumericTextBox>  
                                        </td>
                                    </tr>
                                     <tr>
                                        <td >
                                            Acquisition Value :
                                        </td>
                                        <td >
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_acq_val" Width="150px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" Value="0" EnabledStyle-HorizontalAlign="Right" 
                                                    onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" >
                                                </telerik:RadNumericTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >
                                            Salvage Value :
                                        </td>
                                        <td >
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_salvage_val" Width="150px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  Value="0" EnabledStyle-HorizontalAlign="Right"
                                                    onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" >
                                                </telerik:RadNumericTextBox>
                                        </td>
                                    </tr>
                                   
                                </table>
                            </td>
                            <td style="vertical-align:top">
                                <table style="padding: 10px 0px 0px 10px">
                                    <tr >
                                        <td >
                                            Useful Life (Hour):
                                        </td>
                                        <td>                                           
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_uselife_hour" Width="100px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  Value="0" EnabledStyle-HorizontalAlign="Right"
                                                onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" >
                                            </telerik:RadNumericTextBox>
                                        </td>
                                    </tr>
                                    <%--<tr >
                                        <td >
                                            HM Start:
                                        </td>
                                        <td>
                                             <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_hm_start" Width="100px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  Value="0" EnabledStyle-HorizontalAlign="Right"
                                                onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" >
                                            </telerik:RadNumericTextBox>
                                            
                                        </td>
                                    </tr>--%>
                                    <tr >
                                        <td >
                                           HM Minimal :
                                        </td>
                                        <td>
                                           <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_hm_min" Width="100px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  Value="0" EnabledStyle-HorizontalAlign="Right"
                                                onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" >
                                            </telerik:RadNumericTextBox>
                                        </td>
                                    </tr>
                                    <%--<tr >
                                        <td >
                                            HM Rate:
                                        </td>
                                        <td>
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_hm_rate" Width="125px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  Value="0" EnabledStyle-HorizontalAlign="Right" ReadOnly="true"
                                                onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" OnTextChanged="txt_hm_rate_TextChanged" >
                                            </telerik:RadNumericTextBox> IDR
                                        </td>
                                    </tr>--%>
                                     <tr>
                                        <td>
                                            Status :
                                        </td>
                                        <td >
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_status" Width="150px" runat="server" >
                                                </telerik:RadTextBox>                               
                                        </td>
                                    </tr>
                                    <tr>
                                       <td >
                                            Depre Start :
                                        </td>
                                        <td colspan="3">
                                            <telerik:RadDatePicker ID="dtp_depre_start"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                TabIndex="4" Skin="Silk"> 
                                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Silk" 
                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                </DateInput>
                                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                            </telerik:RadDatePicker>
                                        </td>
                                   </tr>
                                    <tr>
                                       <td >
                                            Depre Last Posting :
                                        </td>
                                        <td colspan="3">
                                            <telerik:RadDatePicker ID="dtp_depre_last_post"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                TabIndex="4" Skin="Silk"> 
                                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Silk" 
                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                </DateInput>
                                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                            </telerik:RadDatePicker>
                                        </td>
                                   </tr>
                                </table>
                            </td>                            
                        </tr>
                    </table>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView3" Height="358px">
                    <table>
                        <tr>
                            <td>
                                <table style="padding: 3px 0px 0px 10px">
                                    <tr >
                                        <td >
                                            Acc. Depr :
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_acc_depre_no" Width="180px" runat="server" >
                                                </telerik:RadTextBox>
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_acc_depre_desc" Width="450px" runat="server" >
                                                </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >
                                            Cost. Depr :
                                        </td>
                                        <td>
                                           <telerik:RadTextBox ReadOnly="true" ID="txt_cost_depre_no" Width="180px" runat="server" >
                                                </telerik:RadTextBox>
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_cost_depre_desc" Width="450px" runat="server" >
                                                </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Acc. Lost :
                                        </td>
                                        <td >
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_acc_lost_no" Width="180px" runat="server" >
                                                </telerik:RadTextBox>
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_acc_lost_desc" Width="450px" runat="server" >
                                                </telerik:RadTextBox>                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Acc. Gain:
                                        </td>
                                        <td >
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_acc_gain_no" Width="180px" runat="server" >
                                                </telerik:RadTextBox>
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_acc_gain_desc" Width="450px" runat="server" >
                                                </telerik:RadTextBox>                             
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >
                                            Acc. Disposal :
                                        </td>
                                        <td >
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_acc_disposal_no" Width="180px" runat="server" >
                                                </telerik:RadTextBox>
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_acc_disposal_desc" Width="450px" runat="server" >
                                                </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                       <td >
                                            Cost. Accu :
                                        </td>
                                        <td >
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_cost_accu_no" Width="180px" runat="server" >
                                                </telerik:RadTextBox>
                                            <telerik:RadTextBox ReadOnly="true" ID="txt_cost_accu_desc" Width="450px" runat="server" >
                                                </telerik:RadTextBox>
                                        </td>
                                   </tr>
                                </table>
                            </td>                            
                        </tr>
                    </table>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView4" Height="358px">
                    <table>
                        <tr>
                            <td>
                                <table style="padding: 3px 0px 0px 10px">
                                    <tr >
                                        <td >
                                            Sold Date :
                                        </td>
                                        <td>
                                            <telerik:RadDatePicker ID="dtp_sold_date"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                TabIndex="4" Skin="Silk" DateInput-ReadOnly="true" Enabled="false"> 
                                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Silk" 
                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                </DateInput>
                                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                            </telerik:RadDatePicker>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >
                                            Actual Resale Value :
                                        </td>
                                        <td>
                                           <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_actual_resale_val" Width="220px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ReadOnly="true" 
                                                    onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" >
                                                </telerik:RadNumericTextBox>  
                                        </td>
                                    </tr>
                                </table>
                            </td>                            
                        </tr>
                    </table>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView5" Height="358px" >
                    <div style="width:99%; padding-left:10px;">
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_depre_by_prm" runat="server" Width="120px"
                                        EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" 
                                        OnItemsRequested="cb_depre_prm_ItemsRequested" OnSelectedIndexChanged="cb_depre_by_prm_SelectedIndexChanged">                                                                                                     
                                    </telerik:RadComboBox>
                                </td>
                                <td>
                                    
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_years_depre_prm" runat="server" Width="120px" 
                                        EnableLoadOnDemand="True" HighlightTemplatedItems="true" Label="Year :" ShowMoreResultsBox="true"
                                        MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" 
                                        OnItemsRequested="cb_years_depre_prm_ItemsRequested" >                                                                                                     
                                    </telerik:RadComboBox>
                                        
                                </td>
                                <td>
                                    <asp:Button ID="btn_retrive_depre" runat="server" OnClick="btn_retrive_depre_Click" Text="Retrieve" BorderStyle="Solid" BackColor="Transparent"
                                        Width="120px" Height="25px" />                            
                                </td>
                               
                            </tr>
                        </table>
                            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid2"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Silk" Width="1200px"
                        AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="6" OnNeedDataSource="RadGrid2_NeedDataSource" >
                       <PagerStyle ShowPagerText="false" />                         
                            <MasterTableView CommandItemDisplay="Top" DataKeyNames="bulan_tahun" Font-Size="12px"
                            EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                                    CommandItemSettings-ShowRefreshButton="false" >                                          
                                <Columns>
                               
                                    <telerik:GridBoundColumn UniqueName="bulan_tahun" HeaderText="Month" DataField="bulan_tahun"
                                        ItemStyle-Width="60px" FilterControlWidth="60px">                                    
                                        <HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="status" HeaderText="Status" DataField="status" 
                                            ItemStyle-Width="50px" FilterControlWidth="50px">
                                        <HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="book_value" HeaderText="Book Value Month Start" DataField="book_value" 
                                            ItemStyle-Width="80px" FilterControlWidth="80px" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                                    </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="susut" HeaderText="PreDepre." DataField="susut" 
                                            ItemStyle-Width="80px" FilterControlWidth="80px" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="harga_min" HeaderText="Salvage Value" DataField="harga_min" ItemStyle-HorizontalAlign="Right" 
                                            ItemStyle-Width="80px" FilterControlWidth="100px" DataFormatString="{0:#,###,###0.00}">
                                        <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="Depre_Value" HeaderText="Depreciation Expense" DataField="Depre_Value" 
                                        FilterControlWidth="80px" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}" >
                                        <HeaderStyle Width="80px"></HeaderStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="tot_dep" HeaderText="Acumulated Depre." DataField="tot_dep" 
                                        FilterControlWidth="80px" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}" >
                                        <HeaderStyle Width="80px"></HeaderStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="tot_hm" HeaderText="Acumulated HM" DataField="hm_cum" Visible="false"
                                        FilterControlWidth="80px" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}" >
                                        <HeaderStyle Width="80px"></HeaderStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="Book_value_end" HeaderText="Book Value Month End" DataField="Book_value_end" 
                                        FilterControlWidth="80px" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                                        <HeaderStyle Width="80px"></HeaderStyle>
                                    </telerik:GridBoundColumn>
                                                        
                                </Columns>
                   
                            </MasterTableView>
                        <ClientSettings>                         
                            <Selecting AllowRowSelect="true"></Selecting>
                        </ClientSettings>
                    </telerik:RadGrid>
                      
                    </div>
                    
                </telerik:RadPageView>
            </telerik:RadMultiPage>
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
