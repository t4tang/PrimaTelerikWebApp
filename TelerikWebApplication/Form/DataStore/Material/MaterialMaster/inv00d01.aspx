<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv00d01.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Material.MaterialMaster.inv00d01" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <telerik:RadGrid runat="server" ID="RadGrid2" RenderMode="Lightweight" Skin="MetroTouch"
            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="false" OnNeedDataSource="RadGrid2_NeedDataSource"
            CssClass="RadGridFormTemplate" >
            <MasterTableView Font-Names="Calibri" Font-Size="13px" ShowHeadersWhenNoRecords="true" DataKeyNames="KoLok">
                <Columns>
                    <telerik:GridBoundColumn UniqueName="prod_code" HeaderText="Storage" DataField="wh_name">
                    <HeaderStyle Width="220px"></HeaderStyle>
                    </telerik:GridBoundColumn>                        
                    <telerik:GridBoundColumn UniqueName="spec" HeaderText="Location" DataField="NmLok">
                        <HeaderStyle Width="120px"></HeaderStyle>
                    </telerik:GridBoundColumn>                   
                    <telerik:GridNumericColumn UniqueName="QOH" HeaderText="On Hand" DataField="QACT" ItemStyle-HorizontalAlign="Right">
                        <HeaderStyle Width="120px"></HeaderStyle>
                    </telerik:GridNumericColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    </form>
</body>
</html>
