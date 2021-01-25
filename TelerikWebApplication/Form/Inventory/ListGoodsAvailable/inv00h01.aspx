<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h01.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.ListGoodsAvailable.inv00h01" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    
    <script type="text/javascript" src="../../../Script/Script.js" ></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
        <AjaxSettings>  
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>          
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_project">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cb_warehouse"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None">
        <img alt="Loading..." src="../../../Images/loader.gif" style="border: 0px; width:90px; height:65px; position: absolute; top: 300px; left:600px" />
    </telerik:RadAjaxLoadingPanel>

    <div class="scroller" runat="server">        

        <div style=" padding-left:15px; width:98%; border-bottom-color: #FF9933; border-bottom-width: 1px; border-bottom-style: inset;">
            <table id="tbl_control">
                <tr>                     
                    <td></td>  
                    <td style="width:100%; text-align:right">
                        <telerik:RadLabel ID="lbl_form_name" Text="Goods Available List" runat="server" style="font-weight:lighter; 
                            font-size:10px; font-variant: small-caps; padding-right:5px; 
                        padding-bottom:0px; font-size:x-large; color:Highlight"></telerik:RadLabel>
                    </td>
                </tr>
            </table>            
        </div> 
        <div runat="server" style=" padding-left:15px;">
            <table >
                <tr> 
                    <td >
                        <telerik:RadLabel runat="server" Text="Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                    </td>
                    <td >
                        <telerik:RadDatePicker ID="dtp_date" runat="server" RenderMode="Lightweight" Width="120px"  Skin="Telerik"
                            DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                        </telerik:RadDatePicker>
                    </td>
                    <td >
                        <telerik:RadLabel runat="server" Text="Project:" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel>
                    </td>
                    <td >
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="250px" DropDownWidth="250px"
                            AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                            OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged" EmptyMessage="Project"
                            OnPreRender="cb_project_PreRender">
                        </telerik:RadComboBox>
                        <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_project" ForeColor="Red" 
                        Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>
                    </td>
                    <td >
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="180" 
                            AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" EmptyMessage="Warehouse"
                            OnItemsRequested="cb_warehouse_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged" 
                            OnPreRender="cb_warehouse_PreRender">
                        </telerik:RadComboBox>
                    </td>
                    <td style="width:100px" >                                            
                        <asp:RequiredFieldValidator runat="server" ID="warehouseValidator" ControlToValidate="cb_warehouse" ForeColor="Red" 
                        Font-Size="X-Small" Text="Required*"></asp:RequiredFieldValidator>
                    </td>
                    <td >
                        <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="OK" Height="25px"
                            Skin="Material"></telerik:RadButton>
                    </td>
                </tr>
            </table> 
        </div>
        <div class="table_trx" id="div1" style="padding-bottom:5px">                               
            <%--<telerik:RadPivotGrid RenderMode="Lightweight" runat="server" ID="RadGrid1" AllowPaging="true"  PageSize="10" Height="640px"
                OnNeedDataSource="RadGrid1_NeedDataSource"  Skin="MetroTouch"
                AllowSorting="true" AllowFiltering="false" ShowFilterHeaderZone="false" Font-Size="Small" Font-Names="Segoe UI" 
                TotalsSettings-ColumnGrandTotalsPosition="None">
                <PagerStyle Mode="NextPrevNumericAndAdvanced" AlwaysVisible="true"></PagerStyle>
                <DataCellStyle Width="100px" />
                <Fields>
                    <telerik:PivotGridRowField DataField="category" CellStyle-Width="100px" Caption="Category" >
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridRowField DataField="material_code" CellStyle-Width="120px" Caption="Material Code">
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridRowField DataField="Specification" CellStyle-Width="200px" Caption="Specification">
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridRowField DataField="brand_name" CellStyle-Width="150px" Caption="Brand Name">
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridRowField DataField="class_code" CellStyle-Width="50px" Caption="Stock Class">
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridRowField DataField="KoLok" CellStyle-Width="50px" Caption="Location">
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridColumnField DataField="warehouse" Caption="Warehouse">
                    </telerik:PivotGridColumnField>                  
                    <telerik:PivotGridAggregateField DataField="soh" Aggregate="Sum" Caption="SOH"
                        DataFormatString="{0:#,###,###0.00}" CellStyle-Width="70px" CellStyle-ForeColor="#006699">
                    </telerik:PivotGridAggregateField>                  
                    <telerik:PivotGridAggregateField DataField="Qty_GIT" Aggregate="Sum" Caption="GIT"
                        DataFormatString="{0:#,###,###0.00}" CellStyle-Width="70px" CellStyle-ForeColor="#006699">
                    </telerik:PivotGridAggregateField>                  
                    <telerik:PivotGridAggregateField DataField="qty_purchase" Aggregate="Sum" Caption="PO"
                        DataFormatString="{0:#,###,###0.00}" CellStyle-Width="70px" CellStyle-ForeColor="#006699">
                    </telerik:PivotGridAggregateField>                  
                    <telerik:PivotGridAggregateField DataField="saldo_akhir" Aggregate="Sum" Caption="Saldo"
                        DataFormatString="{0:#,###,###0.00}" CellStyle-Width="70px" CellStyle-ForeColor="#006699">
                    </telerik:PivotGridAggregateField>
                </Fields>
                <ClientSettings>
                    <Scrolling AllowVerticalScroll="true"></Scrolling>
                    
                </ClientSettings>
            </telerik:RadPivotGrid>--%>

            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowSorting="True" AllowMultiRowSelection="True" PageSize="20" 
                AllowPaging="True" ShowGroupPanel="True" AutoGenerateColumns="False" GridLines="none" AllowFilteringByColumn="true" Skin="Telerik"
                OnNeedDataSource="RadGrid1_NeedDataSource1">
            <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
            <HeaderStyle Font-Size="Small" BackColor="WhiteSmoke" ForeColor="#666666" BorderColor="OrangeRed" BorderStyle="Inset" />
            <ClientSettings EnablePostBackOnRowClick="false" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" AllowGroupExpandCollapse="False" />
            <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
            <SortingSettings EnableSkinSortStyles="false" />
            <MasterTableView Width="100%">
                <GroupByExpressions>
                    <%--<telerik:GridGroupByExpression>
                        <SelectFields>
                            <telerik:GridGroupByField FieldAlias="Warehouse" FieldName="warehouse"></telerik:GridGroupByField>
                        </SelectFields>
                        <GroupByFields>
                            <telerik:GridGroupByField FieldName="warehouse"></telerik:GridGroupByField>
                        </GroupByFields>
                    </telerik:GridGroupByExpression>--%>
                    <telerik:GridGroupByExpression>
                        <SelectFields>
                            <telerik:GridGroupByField FieldAlias="Category" FieldName="category"></telerik:GridGroupByField>
                        </SelectFields>
                        <GroupByFields>
                            <telerik:GridGroupByField FieldName="category"></telerik:GridGroupByField>
                        </GroupByFields>
                    </telerik:GridGroupByExpression>
                </GroupByExpressions>
                <Columns>
                    <telerik:GridBoundColumn SortExpression="category" HeaderText="Category" HeaderButtonType="TextButton"
                        DataField="category" ItemStyle-Width="95px" FilterControlWidth="80px">                        
                        <HeaderStyle Width="95px" />   
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="material_code" HeaderText="Material Code" HeaderButtonType="TextButton"
                        DataField="material_code" ItemStyle-Width="135px" FilterControlWidth="120px">                        
                        <HeaderStyle Width="135px" />   
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="Specification" HeaderText="Specification" HeaderButtonType="TextButton"
                        DataField="Specification" ItemStyle-Width="155px" FilterControlWidth="140px">                        
                        <HeaderStyle Width="155px" />   
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="brand_name" HeaderText="Brand" HeaderButtonType="TextButton"
                        DataField="brand_name" ItemStyle-Width="125px" FilterControlWidth="110px">                        
                        <HeaderStyle Width="130px" />   
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="class_code" HeaderText="Class" HeaderButtonType="TextButton"
                        DataField="class_code" ItemStyle-Width="55px" FilterControlWidth="40px">                        
                        <HeaderStyle Width="65px" />   
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="warehouse" HeaderText="Warehouse" HeaderButtonType="TextButton"
                        DataField="warehouse" ItemStyle-Width="105px" FilterControlWidth="90px">                        
                        <HeaderStyle Width="110px" />   
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="KoLok" HeaderText="Location" HeaderButtonType="TextButton"
                        DataField="KoLok" ItemStyle-Width="45px" AllowFiltering="false">                        
                        <HeaderStyle Width="75px" />   
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="soh" HeaderText="SOH" HeaderButtonType="None"
                        DataField="soh" ItemStyle-Width="75px" AllowFiltering="false" DataFormatString="{0:#,##0.00}" DataType="System.Double">                        
                        <HeaderStyle Width="75px" />                                 
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="Qty_GIT" HeaderText="GIT" HeaderButtonType="None"
                        DataField="Qty_GIT" ItemStyle-Width="75px" AllowFiltering="false" DataFormatString="{0:#,##0.00}" DataType="System.Double">                        
                        <HeaderStyle Width="75px" />                                
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="qty_purchase" HeaderText="PO" HeaderButtonType="None"
                        DataField="qty_purchase" ItemStyle-Width="75px" AllowFiltering="false" DataFormatString="{0:#,##0.00}" DataType="System.Double">                        
                        <HeaderStyle Width="75px" />                                 
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="saldo_akhir" HeaderText="Saldo" HeaderButtonType="None"
                        DataField="saldo_akhir" ItemStyle-Width="75px" AllowFiltering="false" DataFormatString="{0:#,##0.00}" DataType="System.Double">                        
                        <HeaderStyle Width="75px" />                                
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <ClientSettings ReorderColumnsOnClient="True" AllowDragToGroup="True" AllowColumnsReorder="True">
                <Selecting AllowRowSelect="True"></Selecting>
                <Resizing AllowRowResize="True" AllowColumnResize="True" EnableRealTimeResize="True"
                    ResizeGridOnColumnResize="False"></Resizing>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="430px" />
            </ClientSettings>
            <GroupingSettings ShowUnGroupButton="true"></GroupingSettings>
            </telerik:RadGrid>
        </div>

        
    </div>
</asp:Content>
