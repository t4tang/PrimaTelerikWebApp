<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="material.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Material.Warehouse.material" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <telerik:RadGrid ID="RadGridMaterial" runat="server" RenderMode="Lightweight" AllowPaging="false" ShowFooter="false" AllowSorting="true" 
                        AutoGenerateColumns="false" Skin="Telerik" AllowFilteringByColumn="true" 
                       >
                    <MasterTableView CommandItemDisplay="Top" AllowFilteringByColumn="true" DataKeyNames="prod_code" Width="100%" Font-Names="Calibri" Font-Size="13px" 
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
                                                        <asp:Button ID="btnUpdateAcc" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' 
                                                                        runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' />
                                                                &nbsp; <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="false" CommandName="Cancel" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <telerik:RadLabel runat="server" ID="lbl_grp_sales" Text="Sales Distribution " CssClass="lbObject" Font-Bold="true" Font-Size="12px"/>
                                                    </td>
                                                </tr>
                                            </td>
                                        </tr>
                                    </table>
                                </FormTemplate>
                            </EditFormSettings>
                    </MasterTableView>

                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
