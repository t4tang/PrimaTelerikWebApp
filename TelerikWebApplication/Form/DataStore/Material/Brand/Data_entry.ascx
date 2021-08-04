<%@ Control Language="C#" CodeBehind="Data_entry.ascx.cs" Inherits="TelerikWebApplication.Form.Master_data.Material.Brand.Data_entry" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<div class="dataEntry">
    <table id="Table2" cellspacing="2" cellpadding="1" width="100%" border="0" rules="none"
    style="border-collapse: collapse;">
    <tr class="EditFormHeader">
        <td colspan="2">
            <b>PO Information</b>
        </td>
    </tr>
    <tr>
        <td>
            <table id="Table3" width="650px" border="0" class="module">
                <%--<tr>
                    <td class="title" style="font-weight: bold;" colspan="2">Company Info:</td>
                </tr>--%>
                <tr>
                    <td>Brand Code:
                    </td>
                    <td>
                        <asp:TextBox ID="txt_brand_code" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.brand_code") %>'>
                        </asp:TextBox>
                    </td>
                </tr>             
                <tr>
                    <td>Brand Name:
                    </td>
                    <td>
                        <asp:TextBox ID="txt_brand_name" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.brand_name") %>'>
                        </asp:TextBox>
                    </td>
                </tr>  
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td align="right" colspan="2">
            <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'></asp:Button>&nbsp;
            <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                CommandName="Cancel"></asp:Button>
        </td>
    </tr>
</table>
</div>

