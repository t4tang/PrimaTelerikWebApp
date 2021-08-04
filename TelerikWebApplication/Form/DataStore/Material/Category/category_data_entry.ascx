<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="category_data_entry.ascx.cs" Inherits="TelerikWebApplication.Form.Master_data.Material.Category.category_data_entry" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<div class="dataEntry">
    <table id="Table2" cellspacing="2" cellpadding="1" width="100%" border="0" rules="none" 
    style="border-collapse: collapse;">
    <tr class="EditFormHeader">
        <td colspan="2">
            <b>Material Data</b>
        </td>
    </tr>
    <tr>        
        <td>
            <table id="Table3" border="0" class="module">                
                <tr>
                    <td>Category Code:
                    </td>
                    <td>
                        <asp:TextBox ID="txt_kind_code" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.kind_code") %>'>
                        </asp:TextBox>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
                    </td>
                </tr>             
                <tr>
                    <td>Category Name:
                    </td>
                    <td>
                        <asp:TextBox ID="txt_kind_name" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.kind_name") %>'>
                        </asp:TextBox>
                    </td>
                </tr> 
               <tr>
                    <td>Product Type:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_type" runat="server" Width="300" 
                            Text='<%# DataBinder.Eval(Container, "DataItem.prod_type_name") %>'
                            DataValueField='<%# DataBinder.Eval(Container, "DataItem.prod_type_code") %>' 
                            DataTextField="prod_type_name" AutoPostBack="true"
                            EmptyMessage="Select the product type" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_type_ItemsRequested" 
                            OnSelectedIndexChanged="cb_type_SelectedIndexChanged">
                        </telerik:RadComboBox>
                    </td>
                </tr>                  
                <tr>
                    <td>
                        Status Maintenance:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_st_main" runat="server" 
                          Text='<%# DataBinder.Eval(Container, "DataItem.status_main") %>' 
                          AutoPostBack="true" Width="300px" 
                            EmptyMessage="Select the status maintenance" EnableLoadOnDemand="True" ShowMoreResultsBox="false"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_st_main_ItemsRequested" >
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td style="height:30px">
                        <asp:Button ID="btn_gl_account" Text="GL Account Setting" runat="server" CausesValidation="False"></asp:Button>
                    </td>
                </tr>
            </table>
        </td>
        
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>
    <tr>
        <td ></td>
        <td></td>
    </tr>
    <tr>
        <td align="right" colspan="2" style="height:30px">
            <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'></asp:Button>&nbsp;
            <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                CommandName="Cancel"></asp:Button>
        </td>
    </tr>
</table>
</div>
