<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="po_std_data_entry.ascx.cs" Inherits="TelerikWebApplication.Form.Purchase.Purchase_order.po_std_data_entry" %>
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
                
                <tr>
                    <td>PO Number:
                    </td>
                    <td>
                        <asp:TextBox ID="txt_po_number" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.po_code") %>'>
                        </asp:TextBox>
                    </td>
                </tr>             
                <tr>
                    <td>PO Date:
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="dtp_po" runat="server" MinDate="1/1/1900" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.Po_date") %>'
                            TabIndex="4" Skin="Silk"> 
                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                            </DateInput>
                            <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                        </telerik:RadDatePicker>
                    </td>
                </tr>
                <tr>
                    <td>Expired:
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="dtp_exp" runat="server" MinDate="1/1/1900" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.Po_date") %>'
                            TabIndex="4" Skin="Silk">
                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                            </DateInput>
                            <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                        </telerik:RadDatePicker>
                    </td>
                </tr>
                <tr>
                    <td>Tipe:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_po_type" runat="server" Width="300"
                            EmptyMessage="Select the purchase type" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_po_type_ItemsRequested" >
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td>Priority:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="300"
                            EmptyMessage="Select the priority" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_priority_ItemsRequested" >
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td>ETD:
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="dtp_etd" runat="server" MinDate="1/1/1900" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.etd") %>'
                            TabIndex="4" Skin="Silk">
                            <Calendar runat="server"  UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                            <DateInput  runat="server"  TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                            </DateInput>
                            <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                        </telerik:RadDatePicker>
                    </td>
                </tr>
                <tr>
                    <td>Ship Mode:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ship_mode" runat="server" Width="300"
                            EmptyMessage="Select the ship mode" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_ship_mode_ItemsRequested" >
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td>Validation value:
                    </td>
                    <td>
                        <asp:TextBox ID="txt_validity" runat="server" Width="59px" Text='<%# DataBinder.Eval(Container, "DataItem.validity_period") %>'>
                        </asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
        <td style="vertical-align: top;">
            <table id="Table1" cellspacing="1" cellpadding="1" width="100%" border="0" class="module">

                <tr>
                    <td >Supplier:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="300"
                            EmptyMessage="Select the supplier" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_supplier_ItemsRequested" >
                        </telerik:RadComboBox>
                    </td>
                </tr>

                <tr>
                    <td>Currency:
                    </td>
                    <td style="vertical-align:top">
                        <asp:TextBox ID="txt_curr" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.cur_code") %>'>
                        </asp:TextBox>
                        &nbsp
                        Kurs 
                        <asp:TextBox ID="txt_kurs" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.kurs") %>'>
                        </asp:TextBox>
                    </td>
                </tr>

                <tr>
                    <td>Tax 1:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax1" runat="server" Width="150"
                            EmptyMessage="Select tax 1" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_tax1_ItemsRequested" >
                        </telerik:RadComboBox>
                        &nbsp
                        <telerik:RadCheckBox ID="chk_ppn_incl" runat="server" Text="Include"></telerik:RadCheckBox>
                    </td>
                </tr>

                <tr>
                    <td>Tax 2:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax2" runat="server" Width="150"
                            EmptyMessage="Select tax 2" EnableLoadOnDemand="false" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_tax2_ItemsRequested" >
                        </telerik:RadComboBox>                       
                    </td>
                </tr>
                <tr>
                    <td>Tax 3:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax3" runat="server" Width="150"
                            EmptyMessage="Select tax 3" EnableLoadOnDemand="false" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_tax3_ItemsRequested" >
                        </telerik:RadComboBox>                       
                    </td>
                </tr>
                <tr>
                    <td>PR Number:
                    </td>
                    <td>
                        <asp:TextBox ID="txt_no_ref" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.no_ref") %>'>
                        </asp:TextBox>
                    </td>
                </tr>
              
                <tr>
                    <td>Remark:
                    </td>                
                    <td>
                        <asp:TextBox ID="txt_remark" Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>' runat="server" TextMode="MultiLine"
                            Rows="5" Columns="40" TabIndex="5">
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