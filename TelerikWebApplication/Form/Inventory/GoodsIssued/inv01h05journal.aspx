<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h05journal.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.GoodsIssued.inv01h05journal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="padding: 20px 5px 0px 5px">
        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" GridLines="None" runat="server" Skin="MetroTouch" 
            PageSize="10" HeaderStyle-Font-Size="Small" HeaderStyle-Font-Bold="true" ItemStyle-Font-Size="small" Font-Size="Small"
            Font-Names="Segoe UI" CellSpacing="0" OnNeedDataSource="RadGrid1_NeedDataSource">
            <MasterTableView DataKeyNames="doc_code"
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
                        HeaderStyle-BackColor="#00ABE3" HeaderStyle-ForeColor="White">                                
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="accountname" HeaderStyle-Width="250px" HeaderText="Account Name" SortExpression="accountname"
                        UniqueName="accountname" ReadOnly="true" HeaderStyle-HorizontalAlign="Center"
                        HeaderStyle-BackColor="#00ABE3" HeaderStyle-ForeColor="White">                                
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="debet" HeaderStyle-Width="100px" HeaderText="Debet" SortExpression="debet"
                        UniqueName="debet" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#00ABE3" HeaderStyle-ForeColor="White"
                        DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#00CC00">                                
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="credit" HeaderStyle-Width="100px" HeaderText="Credit" SortExpression="credit"
                        UniqueName="credit" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#00ABE3" HeaderStyle-ForeColor="White"
                        DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#FF6600">                                
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="remark" HeaderStyle-Width="200px" HeaderText="Remark" SortExpression="remark"
                        UniqueName="remark" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#00ABE3" HeaderStyle-ForeColor="White">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <ClientSettings AllowKeyboardNavigation="true"></ClientSettings>
        </telerik:RadGrid>
    </div>
    </form>
</body>
</html>
