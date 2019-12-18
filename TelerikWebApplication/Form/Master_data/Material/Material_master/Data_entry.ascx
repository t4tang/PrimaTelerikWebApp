﻿<%@ Control Language="C#" CodeBehind="Data_entry.ascx.cs" Inherits="TelerikWebApplication.Form.Master_data.Material.Material_master.Data_entry" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
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
                    <td>Material Code:
                    </td>
                    <td>
                        <asp:TextBox ID="txt_material_code" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>'>
                        </asp:TextBox>
                    </td>
                </tr>             
                <tr>
                    <td>Specification:
                    </td>
                    <td>
                        <asp:TextBox ID="txt_specification" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.spec") %>'>
                        </asp:TextBox>
                    </td>
                </tr> 
               <tr>
                    <td>Unit of Measure:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_uom" runat="server" Width="300" 
                            Text='<%# DataBinder.Eval(Container, "DataItem.unit") %>'
                            EmptyMessage="Select the UoM" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_uom_ItemsRequested" DataValueField="unit" OnSelectedIndexChanged="cb_uom_SelectedIndexChanged">
                        </telerik:RadComboBox>
                    </td>
                </tr> 
                 <tr>
                    <td>Brand:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_brand" Width="300" runat="server"
                            Text='<%# DataBinder.Eval(Container, "DataItem.brand_name") %>'
                            EmptyMessage="Select the brand" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_brand_ItemsRequested" OnSelectedIndexChanged="cb_brand_SelectedIndexChanged" >
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td>Category:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_category" runat="server" Width="300"
                            Text='<%# DataBinder.Eval(Container, "DataItem.kind_name") %>'
                            EmptyMessage="Select the category" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_category_ItemsRequested" OnSelectedIndexChanged="cb_category_SelectedIndexChanged" >
                        </telerik:RadComboBox>
                    </td>
                </tr>  
                <tr>
                    <td>Group:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_group" runat="server" Width="300"
                            Text='<%# DataBinder.Eval(Container, "DataItem.group_name") %>'
                            EmptyMessage="Select the group" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_group_ItemsRequested" OnSelectedIndexChanged="cb_group_SelectedIndexChanged" >
                        </telerik:RadComboBox>
                    </td>
                </tr>  
               
                <tr>
                    <td>
                        Status Maintenance:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_st_main" runat="server" 
                          Text='<%# DataBinder.Eval(Container, "DataItem.stMain") %>' 
                          AutoPostBack="false" Width="300px" AllowCustomText="false"
                            EmptyMessage="Select the status maintenance" EnableLoadOnDemand="True" ShowMoreResultsBox="True"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_st_main_ItemsRequested" >

                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
        </td>
        <td >
            <table>
                <tr>
                    <td>
                        <telerik:RadCheckBox ID="chk_use_serial_number" runat="server" Text="Use Serial Number" Skin="Telerik" AutoPostback="false"
                            Checked='<%# DataBinder.Eval (Container, "DataItem.tSN").ToString()!="0"?true:false %>'>
                        </telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <telerik:RadCheckBox ID="chk_active" runat="server" Text="Active" Skin="Telerik" AutoPostback="false"
                            Checked='<%# DataBinder.Eval (Container, "DataItem.tActive").ToString()!="0"?true:false %>'>
                        </telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <telerik:RadCheckBox ID="chk_warranty" runat="server" Text="Warranty" Skin="Telerik" AutoPostback="false"
                            Checked='<%# DataBinder.Eval (Container, "DataItem.tWarranty").ToString()!="0"?true:false %>'>
                        </telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <telerik:RadCheckBox ID="chk_monitoring_stock" runat="server" Text="Monitoring Stock" AutoPostback="false"
                            Checked='<%# DataBinder.Eval (Container, "DataItem.tMonitor").ToString()!="0"?true:false %>'>
                        </telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <telerik:RadCheckBox ID="chk_consignment" runat="server" Text="Consignment" Skin="Telerik" AutoPostback="false" 
                            Checked='<%# DataBinder.Eval (Container, "DataItem.tConsig").ToString()!="0"?true:false %>'>
                        </telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td class="title" style="font-weight: bold;" colspan="2">Purchase:</td>
                </tr>
                <tr>
                    <td>Min Stock:</td>
                    <td>
                        <asp:TextBox ID="txt_min_stock" runat="server"  Text='<%# DataBinder.Eval(Container, "DataItem.QtyMin") %>'>
                        </asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Min Purchase:</td>
                    <td>
                        <asp:TextBox ID="txt_min_purchase" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.QtyMinPur") %>'>
                        </asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="title" style="font-weight: bold;" colspan="2">Sales:</td>
                </tr>
                <tr>
                    <td>Selling Price:</td>
                    <td>
                        <asp:TextBox ID="txt_selling_price" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.price_sale") %>'>
                        </asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Sales forecast:</td>
                    <td>
                        <asp:TextBox ID="txt_sales_forecast" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SalesFore") %>'>
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
        <td class="auto-style1"></td>
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
