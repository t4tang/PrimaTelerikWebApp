<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="acc00d22.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Asset.acc00d22" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
     <telerik:RadScriptManager ID="RadScriptManager1" runat="server">            
    </telerik:RadScriptManager>
    <div style="overflow-y:scroll;width:100%">
        <table>
            <tr>
                <td>
                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_depre_by_prm" runat="server" Width="120px"  ReadOnly="true"
                        EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                        MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true" 
                        OnItemsRequested="cb_depre_prm_ItemsRequested" OnSelectedIndexChanged="cb_depre_by_prm_SelectedIndexChanged">                                                                                                     
                    </telerik:RadComboBox>
                </td>
                <td>
                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_years_depre_prm" runat="server" Width="120px"  ReadOnly="true"
                        EnableLoadOnDemand="True" HighlightTemplatedItems="true" Label="Year :"
                        MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true" 
                        OnItemsRequested="cb_years_depre_prm_ItemsRequested" >                                                                                                     
                    </telerik:RadComboBox>
                </td>
                <td>
                    <asp:Button ID="btn_retrive_depre" runat="server" OnClick="btn_retrive_depre_Click" Text="Retrieve" BorderStyle="Solid" BackColor="Transparent"
                        Width="120px" Height="25px" />
                            
                </td>
            </tr>
        </table>
                       
        <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid2"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
        AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="12" OnNeedDataSource="RadGrid2_NeedDataSource" >
        <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
        <ClientSettings EnablePostBackOnRowClick="true" >
        </ClientSettings>
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
                    <telerik:GridBoundColumn UniqueName="susut" HeaderText="PreDepre" DataField="susut" 
                        ItemStyle-Width="80px" FilterControlWidth="80px" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                    <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="harga_min" HeaderText="Salvage Value" DataField="harga_min" ItemStyle-HorizontalAlign="Right" 
                        ItemStyle-Width="80px" FilterControlWidth="100px" DataFormatString="{0:#,###,###0.00}">
                    <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="Depre_Value" HeaderText="Deprciation Expense" DataField="Depre_Value" 
                    FilterControlWidth="80px" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}" >
                    <HeaderStyle Width="80px"></HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn UniqueName="tot_dep" HeaderText="Acumulated Depreciation" DataField="tot_dep" 
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
    </form>
</body>
</html>
