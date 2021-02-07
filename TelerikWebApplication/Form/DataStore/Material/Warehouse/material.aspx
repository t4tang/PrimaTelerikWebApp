<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="material.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Material.Warehouse.material" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
        <div>
            <asp:UpdatePanel ID="panel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <telerik:RadGrid ID="RadGridMaterial" runat="server" RenderMode="Lightweight" AllowPaging="false" ShowFooter="false" AllowSorting="true" 
                            AutoGenerateColumns="false" Skin="Telerik" AllowFilteringByColumn="true" 
                            OnNeedDataSource="RadGridMaterial_NeedDataSource">
                        <MasterTableView CommandItemDisplay="Top" AllowFilteringByColumn="true" DataKeyNames="prod_code" Width="100%" Font-Names="Calibri" Font-Size="13px" 
                                         EditFormSettings-PopUpSettings-KeepInScreenBounds="true">
                            <Columns>
                                <%--<telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                                    <HeaderStyle Width="20px" />
                                </telerik:GridEditCommandColumn>--%>
                                <telerik:GridBoundColumn HeaderText ="Material Code" DataField="prod_code" FilterControlWidth="70px" HeaderStyle-Width="50px">
                                    <HeaderStyle Width="50px" />
                                    <ItemStyle Width="50px" />
                                </telerik:GridBoundColumn> 
                                <telerik:GridBoundColumn HeaderText ="Specification" DataField="spec">
                                    <HeaderStyle Width="500px" />
                                    <ItemStyle Width="500px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText ="UoM" DataField="unit" FilterControlWidth="70px">
                                    <HeaderStyle Width="30px" />
                                    <ItemStyle Width="30px" />
                                </telerik:GridBoundColumn> 
                                <telerik:GridBoundColumn HeaderText ="Qty Actual" DataField="QACT" FilterControlWidth="70px">
                                    <HeaderStyle Width="50px" />
                                    <ItemStyle Width="50px" />
                                </telerik:GridBoundColumn> 
                                <telerik:GridBoundColumn HeaderText ="Qty Max" DataField="qtyMax" FilterControlWidth="70px">
                                    <HeaderStyle Width="50px" />
                                    <ItemStyle Width="50px" />
                                </telerik:GridBoundColumn> 
                                <telerik:GridBoundColumn HeaderText ="Qty Min" DataField="qtyMin" FilterControlWidth="70px">
                                    <HeaderStyle Width="50px" />
                                    <ItemStyle Width="50px" />
                                </telerik:GridBoundColumn> 
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" ItemStyle-ForeColor="Red" 
                                    ConfirmText="Are you sure you want to delete this row or record?">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
