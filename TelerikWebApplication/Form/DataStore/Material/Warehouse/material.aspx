﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="material.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Material.Warehouse.material" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
        <div>
            <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <telerik:RadGrid ID="RadGridGLAcc" runat="server" RenderMode="Lightweight" AllowPaging="false" ShowFooter="false" AllowSorting="true" 
                        AutoGenerateColumns="false" Skin="Telerik" AllowFilteringByColumn="true"
                        OnNeedDataSource="RadGridGLAcc_NeedDataSource">
                        <MasterTableView CommandItemDisplay="Top" AllowFilteringByColumn="true" DataKeyNames="prod_code" Width="100%" Font-Names="Calibri" Font-Size="13px" 
                            EditFormSettings-PopUpSettings-KeepInScreenBounds="true">
                            <Columns>
                                <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                                    <HeaderStyle Width="20px" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridBoundColumn HeaderText ="Material Code" DataField="prod_code" FilterControlWidth="70px">
                                    <HeaderStyle Width="50px" />
                                    <ItemStyle Width="50px" />
                                </telerik:GridBoundColumn> 
                                <telerik:GridBoundColumn HeaderText ="Specification" DataField="spec">
                                    <HeaderStyle Width="300px" />
                                    <ItemStyle Width="300px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText ="Uom" DataField="unit">
                                    <HeaderStyle Width="30px" />
                                    <ItemStyle Width="30px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText ="Qty Actual" DataField="QACT">
                                    <HeaderStyle Width="250px" />
                                    <ItemStyle Width="250px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText ="Qty Max" DataField="qtyMax">
                                    <HeaderStyle Width="250px" />
                                    <ItemStyle Width="250px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText ="Qty Min" DataField="qtyMin">
                                    <HeaderStyle Width="250px" />
                                    <ItemStyle Width="250px" />
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