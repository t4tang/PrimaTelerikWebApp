<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="gl_account.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Material.Warehouse.gl_account" %>

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
                        OnNeedDataSource="RadGridGLAcc_NeedDataSource" >
                        <MasterTableView CommandItemDisplay="Top" AllowFilteringByColumn="true" DataKeyNames="kind_code" Width="100%" Font-Names="Calibri" Font-Size="13px" 
                            EditFormSettings-PopUpSettings-KeepInScreenBounds="true">
                            <Columns>
                                <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                                    <HeaderStyle Width="20px" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridBoundColumn HeaderText ="Code" DataField="wh_code" FilterControlWidth="70px">
                                    <HeaderStyle Width="50px" />
                                    <ItemStyle Width="50px" />
                                </telerik:GridBoundColumn> 
                                <telerik:GridBoundColumn HeaderText ="Material Category" DataField="kind_name">
                                    <HeaderStyle Width="300px" />
                                    <ItemStyle Width="300px" />
                                </telerik:GridBoundColumn>                                            
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" ItemStyle-ForeColor="Red" 
                                    ConfirmText="Are you sure you want to delete this row or record?">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                </telerik:GridButtonColumn>
                            </Columns>
                                <EditFormSettings EditFormType="Template">
                                    <FormTemplate>
                                        <table id="Table2" cellspacing="1" cellpadding="1" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                                            padding-top:4px; padding-bottom:5px; background-color: #F0FFFE;">
                                            <tr>
                                                <td>                                    
                                                    <tr>
                                                        <td colspan="2" style="padding:10px 0px 10px 0px">
                                                            <asp:Button ID="btnUpdateAcc" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' OnClick="btnUpdateAcc_Click"
                                                                        runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' />
                                                                &nbsp; <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="false" CommandName="Cancel" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <telerik:RadLabel runat="server" ID="lbl_grp_sales" Text="Sales Distribution " CssClass="lbObject" Font-Bold="true" Font-Size="12px"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="lbl_sales_acc" Width="100px" Text="Sales: " CssClass="lbObject" Font-Size="12px"/>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_sales_acc" runat="server" RenderMode="Lightweight" Width="200px" AutoPostBack="true" CausesValidation="false"  
                                                                DropDownWidth="550px" EnableLoadOnDemand="true" MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="doc_code" DataValueField="doc_code"
                                                                ShowMoreResultsBox="true" Text='<%# DataBinder.Eval(Container, "DataItem.AccSales") %>' 
                                                                OnItemsRequested="cb_acc_ItemsRequested"
                                                                OnSelectedIndexChanged="cb_sales_acc_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Account No.
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                Account Name
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                Curr.
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.accountno")%>
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "accountname") %>'></asp:label> 
                                                                            </td>  
                                                                            <td style="width: 50px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "cur_code") %>'></asp:label> 
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="lbl_sales_acc_name" CssClass="lbObject" Font-Size="12px" Text='<%# DataBinder.Eval(Container, "DataItem.accSalesName") %>' />
                                                        </td>
                                                    </tr>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td> 
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="RadLabel2" Width="100px" Text="Return: " CssClass="lbObject" Font-Size="12px"/>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_sales_return" runat="server" RenderMode="Lightweight" Width="200px" AutoPostBack="true" CausesValidation="false"  
                                                                DropDownWidth="550px" EnableLoadOnDemand="true" MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="doc_code" DataValueField="doc_code"
                                                                ShowMoreResultsBox="true" Text='<%# DataBinder.Eval(Container, "DataItem.AccReturn") %>' 
                                                                OnItemsRequested="cb_acc_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_sales_return_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Account No.
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                Account Name
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                Curr.
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.accountno")%>
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "accountname") %>'></asp:label> 
                                                                            </td>  
                                                                            <td style="width: 50px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "cur_code") %>'></asp:label> 
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="lbl_sales_return" CssClass="lbObject" Font-Size="12px" Text='<%# DataBinder.Eval(Container, "DataItem.accReturnName") %>' />
                                                        </td>
                                                    </tr>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td> 
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="RadLabel1" Width="100px" Text="Discount: " CssClass="lbObject" Font-Size="12px"/>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_sales_disc" runat="server" RenderMode="Lightweight" Width="200px" AutoPostBack="true" CausesValidation="false"  
                                                                DropDownWidth="550px" EnableLoadOnDemand="true" MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="doc_code" DataValueField="doc_code"
                                                                ShowMoreResultsBox="true" Text='<%# DataBinder.Eval(Container, "DataItem.AccSalesDisc") %>' 
                                                                OnItemsRequested="cb_acc_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_sales_disc_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Account No.
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                Account Name
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                Curr.
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.accountno")%>
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "accountname") %>'></asp:label> 
                                                                            </td>  
                                                                            <td style="width: 50px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "cur_code") %>'></asp:label> 
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="lbl_sales_disc_name" CssClass="lbObject" Font-Size="12px" Text='<%# DataBinder.Eval(Container, "DataItem.accSalesDiscName") %>' />
                                                        </td>
                                                    </tr>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td> 
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="RadLabel3" Width="100px" Text="COGS: " CssClass="lbObject" Font-Size="12px"/>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_sales_cogs" runat="server" RenderMode="Lightweight" Width="200px" AutoPostBack="true" CausesValidation="false"  
                                                                DropDownWidth="550px" EnableLoadOnDemand="true" MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="doc_code" DataValueField="doc_code"
                                                                ShowMoreResultsBox="true" Text='<%# DataBinder.Eval(Container, "DataItem.AccCOGS") %>' 
                                                                OnItemsRequested="cb_acc_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_sales_cogs_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Account No.
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                Account Name
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                Curr.
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.accountno")%>
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "accountname") %>'></asp:label> 
                                                                            </td>  
                                                                            <td style="width: 50px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "cur_code") %>'></asp:label> 
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="lbl_sales_cogs_name" CssClass="lbObject" Font-Size="12px" Text='<%# DataBinder.Eval(Container, "DataItem.accCogsName") %>' />
                                                        </td>
                                                    </tr>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td> 
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="RadLabel5" Width="100px" Text="Inventory: " CssClass="lbObject" Font-Size="12px"/>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_pur_inventory" runat="server" RenderMode="Lightweight" Width="200px" AutoPostBack="true" CausesValidation="false"  
                                                                DropDownWidth="550px" EnableLoadOnDemand="true" MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="doc_code" DataValueField="doc_code"
                                                                ShowMoreResultsBox="true" Text='<%# DataBinder.Eval(Container, "DataItem.AccInventory") %>' 
                                                                OnItemsRequested="cb_acc_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_sales_inventory_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Account No.
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                Account Name
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                Curr.
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.accountno")%>
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "accountname") %>'></asp:label> 
                                                                            </td>  
                                                                            <td style="width: 50px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "cur_code") %>'></asp:label> 
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="lbl_pur_inventory_name" CssClass="lbObject" Font-Size="12px" Text='<%# DataBinder.Eval(Container, "DataItem.accInventoryName") %>' />
                                                        </td>
                                                    </tr>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td> 
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="RadLabel7" Width="100px" Text="Return: " CssClass="lbObject" Font-Size="12px"/>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_pur_return" runat="server" RenderMode="Lightweight" Width="200px" AutoPostBack="true" CausesValidation="false"  
                                                                DropDownWidth="550px" EnableLoadOnDemand="true" MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="doc_code" DataValueField="doc_code"
                                                                ShowMoreResultsBox="true" Text='<%# DataBinder.Eval(Container, "DataItem.AccReturnBeli") %>' 
                                                                OnItemsRequested="cb_acc_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_pur_return_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Account No.
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                Account Name
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                Curr.
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.accountno")%>
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "accountname") %>'></asp:label> 
                                                                            </td>  
                                                                            <td style="width: 50px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "cur_code") %>'></asp:label> 
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="lbl_pur_return_name" CssClass="lbObject" Font-Size="12px" Text='<%# DataBinder.Eval(Container, "DataItem.accReturnBeliName") %>' />
                                                        </td>
                                                    </tr>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td> 
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="RadLabel11" Width="100px" Text="Discount: " CssClass="lbObject" Font-Size="12px"/>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_pur_discount" runat="server" RenderMode="Lightweight" Width="200px" AutoPostBack="true" CausesValidation="false"  
                                                                DropDownWidth="550px" EnableLoadOnDemand="true" MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="doc_code" DataValueField="doc_code"
                                                                ShowMoreResultsBox="true" Text='<%# DataBinder.Eval(Container, "DataItem.AccDiscBeli") %>' 
                                                                OnItemsRequested="cb_acc_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_pur_discount_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Account No.
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                Account Name
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                Curr.
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.accountno")%>
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "accountname") %>'></asp:label> 
                                                                            </td>  
                                                                            <td style="width: 50px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "cur_code") %>'></asp:label> 
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="lbl_pur_discount_name" CssClass="lbObject" Font-Size="12px" Text='<%# DataBinder.Eval(Container, "DataItem.accDiscBeliName") %>' />
                                                        </td>
                                                    </tr>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td> 
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="RadLabel13" Width="100px" Text="Assembly: " CssClass="lbObject" Font-Size="12px"/>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_other_assembly" runat="server" RenderMode="Lightweight" Width="200px" AutoPostBack="true" CausesValidation="false"  
                                                                DropDownWidth="550px" EnableLoadOnDemand="true" MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="doc_code" DataValueField="doc_code"
                                                                ShowMoreResultsBox="true" Text='<%# DataBinder.Eval(Container, "DataItem.AccAssem") %>' 
                                                                OnItemsRequested="cb_acc_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_other_assembly_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Account No.
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                Account Name
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                Curr.
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.accountno")%>
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "accountname") %>'></asp:label> 
                                                                            </td>  
                                                                            <td style="width: 50px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "cur_code") %>'></asp:label> 
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="lbl_other_assembly_name" CssClass="lbObject" Font-Size="12px" Text='<%# DataBinder.Eval(Container, "DataItem.accAssemName") %>' />
                                                        </td>
                                                    </tr>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td> 
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="RadLabel9" Width="100px" Text="Revision: " CssClass="lbObject" Font-Size="12px"/>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_other_rev" runat="server" RenderMode="Lightweight" Width="200px" AutoPostBack="true" CausesValidation="false"  
                                                                DropDownWidth="550px" EnableLoadOnDemand="true" MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="doc_code" DataValueField="doc_code"
                                                                ShowMoreResultsBox="true" Text='<%# DataBinder.Eval(Container, "DataItem.AccRev") %>' 
                                                                OnItemsRequested="cb_acc_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_other_rev_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Account No.
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                Account Name
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                Curr.
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.accountno")%>
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "accountname") %>'></asp:label> 
                                                                            </td>  
                                                                            <td style="width: 50px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "cur_code") %>'></asp:label> 
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="lbl_other_rev_name" CssClass="lbObject" Font-Size="12px" Text='<%# DataBinder.Eval(Container, "DataItem.accRevName") %>' />
                                                        </td>
                                                    </tr>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td> 
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="RadLabel15" Width="100px" Text="Consumption: " CssClass="lbObject" Font-Size="12px"/>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_other_consumption" runat="server" RenderMode="Lightweight" Width="200px" AutoPostBack="true" CausesValidation="false"  
                                                                DropDownWidth="550px" EnableLoadOnDemand="true" MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="doc_code" DataValueField="doc_code"
                                                                ShowMoreResultsBox="true" Text='<%# DataBinder.Eval(Container, "DataItem.AccConsum") %>' 
                                                                OnItemsRequested="cb_acc_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_other_consumption_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Account No.
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                Account Name
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                Curr.
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.accountno")%>
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "accountname") %>'></asp:label> 
                                                                            </td>  
                                                                            <td style="width: 50px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "cur_code") %>'></asp:label> 
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="lbl_other_consumption_name" CssClass="lbObject" Font-Size="12px" Text='<%# DataBinder.Eval(Container, "DataItem.accConsumName") %>' />
                                                        </td>
                                                    </tr>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td> 
                                                    <tr>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="RadLabel17" Width="100px" Text="Consignment: " CssClass="lbObject" Font-Size="12px"/>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_other_consign" runat="server" RenderMode="Lightweight" Width="200px" AutoPostBack="true" CausesValidation="false"  
                                                                DropDownWidth="550px" EnableLoadOnDemand="true" MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="doc_code" DataValueField="doc_code"
                                                                ShowMoreResultsBox="true" Text='<%# DataBinder.Eval(Container, "DataItem.AccConsign") %>' 
                                                                OnItemsRequested="cb_acc_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_other_consign_SelectedIndexChanged">
                                                                <HeaderTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                Account No.
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                Account Name
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                Curr.
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 550px; font-size:11px">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.accountno")%>
                                                                            </td>
                                                                            <td style="width: 400px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "accountname") %>'></asp:label> 
                                                                            </td>  
                                                                            <td style="width: 50px;">
                                                                                <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "cur_code") %>'></asp:label> 
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadLabel runat="server" ID="lbl_other_consign_name" CssClass="lbObject" Font-Size="12px" Text='<%# DataBinder.Eval(Container, "DataItem.accConsignName") %>' />
                                                        </td>
                                                    </tr>
                                                </td>
                                            </tr>
                                        </table>
                                    </FormTemplate>
                                </EditFormSettings>
                        </MasterTableView>
                        <ClientSettings>
                            <Scrolling UseStaticHeaders="true" AllowScroll="true" ScrollHeight="410px" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
