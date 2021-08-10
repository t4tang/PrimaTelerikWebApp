<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="entry.ascx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.DBCM.entry" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<link href="../../../Styles/custom-cs.css" rel="stylesheet" />

<script type ="text/javascript">
    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow)
            oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog     
        else if (window.frameElement.radWindow)
            oWindow = window.frameElement.radWindow;//IE (and Moz as well)     
        return oWindow;
    }
    function Close() {
        GetRadWindow().Close();
    }

    function CloseAndRebind(args) {
        GetRadWindow().BrowserWindow.refreshGrid(args);
        GetRadWindow().close();
    }
</script>

<div style="padding: 5px 5px 3px 15px;" class="entryFormStyle">
    <table id="Table1" border="0" style="border-collapse: collapse; padding-top:0px; padding-left:15px; 
        padding-right:15px; padding-bottom:0px; font-size:smaller;">
        <tr style="vertical-align: top;">
            <td style="vertical-align: top;">
                <table id="Table2" width="Auto" border="0" class="module">
                    <tr>
                        <td colspan="2" style="padding: 0px 0px 10px 5px; text-align:left">
                            <asp:Button ID="btnUpdate" BorderStyle="NotSet" BorderWidth="1px" Width="100px" OnClick="btn_save_Click" Height="25px" 
                                Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" 
                               CssClass="btn-entryFrm" >
                            </asp:Button>&nbsp;
                            
                            <asp:Button ID="btnCancel" BorderStyle="NotSet" BorderWidth="1px" Width="100px" Height="25px" 
                                Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="WO. Number" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txt_wo_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight"
                                Text='<%# DataBinder.Eval(Container, "DataItem.trans_id") %>' 
                                Skin="Telerik"  EmptyMessage="Let it blank" >
                                <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Unit Code" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txt_unit" runat="server" RenderMode="Lightweight" Width="150px" Skin="Telerik"
                                Text='<%# DataBinder.Eval(Container, "DataItem.unit_code") %>' ></telerik:RadTextBox>
                        </td>
                    </tr> 
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="HM BD" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadNumericTextBox runat="server" ID="txt_hm" RenderMode="Lightweight" Width="120px" Skin="Telerik" 
                                Text='<%# DataBinder.Eval(Container, "DataItem.time_reading") %>'></telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Status" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txt_status" RenderMode="Lightweight" Width="80px" Skin="Telerik" 
                                Text='<%# DataBinder.Eval(Container, "DataItem.status") %>'></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Date" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="dtp_date" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="Telerik" 
                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.down_date") %>'>
                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"
                                    FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Time" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadNumericTextBox runat="server" ID="txt_time" RenderMode="Lightweight" Width="120px" Skin="Telerik" 
                                Text='<%# DataBinder.Eval(Container, "DataItem.down_time") %>'></telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Trouble Description" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txt_trouble" RenderMode="Lightweight" Width="200px" Skin="Telerik" 
                                Text='<%# DataBinder.Eval(Container, "DataItem.trouble_des") %>'></telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="vertical-align: top;">
                <table id="Table3" width="Auto" border="0" class="module" style="padding: 0px 0px 0px 7px">
                    <tr>
                        <td class="tdLabel"
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
