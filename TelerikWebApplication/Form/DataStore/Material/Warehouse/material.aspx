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
                        OnNeedDataSource="RadGridMaterial_NeedDataSource"
                         OnInsertCommand="RadGridMaterial_InsertCommand">
                        <MasterTableView CommandItemDisplay="Top" AllowFilteringByColumn="true" DataKeyNames="prod_code" Width="100%" Font-Names="Calibri" Font-Size="13px" 
                                         EditFormSettings-PopUpSettings-KeepInScreenBounds="true">
                            <Columns>
                                <%--<telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                                    <HeaderStyle Width="20px" />
                                </telerik:GridEditCommandColumn>--%>
                               <%-- <telerik:GridBoundColumn HeaderText ="Material Code" DataField="prod_code" FilterControlWidth="70px" HeaderStyle-Width="50px">
                                    <HeaderStyle Width="50px" />
                                    <ItemStyle Width="50px" />                                   
                                </telerik:GridBoundColumn> --%>
                                <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="100px" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" FilterControlWidth="80" >
                                    <FooterTemplate>Template footer</FooterTemplate>
                                    <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" /> 
                                    <ItemTemplate>    
                                        <asp:Label runat="server" ID="lbl_prod_code" Text='<%# DataBinder.Eval(Container.DataItem, "prod_code") %>' Width="100px"></asp:Label>                                        
                                    </ItemTemplate>
                                    <InsertItemTemplate>                                 
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="spec"
                                            DataValueField="prod_code" AutoPostBack="true"
                                            EmptyMessage="- Select product -"
                                            HighlightTemplatedItems="true" Width="150px" DropDownWidth="530px" DropDownAutoWidth="Enabled"
                                            OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                            OnItemsRequested="cb_prod_code_ItemsRequested" >                                                   
                                            <HeaderTemplate>
                                            <table style="width: 530px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 350px;">
                                                        Prod. Name
                                                    </td>     
                                                    <td style="width: 120px;">
                                                        Prod. Code
                                                    </td> 
                                                    <td style="width: 60px;">
                                                        UoM
                                                    </td> 
                                                                                                    
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 530px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                    </td>        
                                                    <td style="width: 120px;">
                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                    </td> 
                                                    <td style="width: 60px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['unit']")%>
                                                    </td>
                                                                                                                                                         
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        </telerik:RadComboBox>                                        
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>   
                               <%-- <telerik:GridBoundColumn HeaderText ="Specification" DataField="spec">
                                    <HeaderStyle Width="500px" />
                                    <ItemStyle Width="500px" />
                                </telerik:GridBoundColumn>--%>
                                <telerik:GridTemplateColumn HeaderText="Specification" HeaderStyle-Width="170px" ItemStyle-Width="170px" FilterControlWidth="150" 
                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblSpec" Text='<%# DataBinder.Eval(Container.DataItem, "spec") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:Label runat="server" ID="lblSpec_insertTemp" Width="350px" ></asp:Label>
                                    </InsertItemTemplate>                                        
                                </telerik:GridTemplateColumn>
                               <%-- <telerik:GridBoundColumn HeaderText ="UoM" DataField="unit" FilterControlWidth="70px">
                                    <HeaderStyle Width="30px" />
                                    <ItemStyle Width="30px" />
                                </telerik:GridBoundColumn> --%>
                                <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="60px" ItemStyle-Width="60px" 
                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "unit") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:Label runat="server" ID="lblUom_insertTemp" ></asp:Label>
                                    </InsertItemTemplate>                                         
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText ="Qty Actual" HeaderStyle-Width="60px" ItemStyle-Width="60px"
                                    headers DataField="QACT" AllowFiltering="false">
                                    <HeaderStyle Width="50px" />
                                    <ItemStyle Width="50px" />
                                </telerik:GridTemplateColumn> 
                                <telerik:GridTemplateColumn HeaderText ="Qty Max" DataField="qtyMax" AllowFiltering="false">
                                    <HeaderStyle Width="50px" />
                                    <ItemStyle Width="50px" />
                                </telerik:GridTemplateColumn> 
                                <telerik:GridTemplateColumn HeaderText ="Qty Min" DataField="qtyMin" AllowFiltering="false">
                                    <HeaderStyle Width="50px" />
                                    <ItemStyle Width="50px" />
                                </telerik:GridTemplateColumn> 
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
