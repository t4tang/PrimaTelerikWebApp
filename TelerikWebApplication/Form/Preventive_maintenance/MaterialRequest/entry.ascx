<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="entry.ascx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.MaterialRequest.entry" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<link href="../../../Styles/custom-cs.css" rel="stylesheet" />

<script type ="text/javascript" >  
    function GetRadWindow()     
    {     
        var oWindow = null;     
        if (window.radWindow)
        oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog     
        else if (window.frameElement.radWindow)
        oWindow = window.frameElement.radWindow;//IE (and Moz as well)     
        return oWindow;               
    }     
    function Close()     
    {     
        GetRadWindow().Close();          
    }

    function CloseAndRebind(args) {
        GetRadWindow().BrowserWindow.refreshGrid(args);
        GetRadWindow().close();
    }

</script>
<%--<telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePageMethods="True">
    <Scripts>
        <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
        <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
        <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
    </Scripts>
</telerik:RadScriptManager>--%>

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
                            <telerik:RadLabel runat="server" Text="MR Number" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txt_mr_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight"
                                Text='<%# DataBinder.Eval(Container, "DataItem.sro_code") %>' 
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
                            <telerik:RadLabel runat="server" Text="Project Area" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                        </td>
                        <td>
                            <%--<asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                <ContentTemplate>--%>
                                    <telerik:RadComboBox ID="cb_Project" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' 
                                        EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="250" DropDownWidth="270px" 
                                        OnItemsRequested="cb_Project_ItemsRequested" 
                                        OnPreRender="cb_Project_PreRender" 
                                        OnSelectedIndexChanged="cb_Project_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_Project" ForeColor="Red" 
                                    Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                <%--</ContentTemplate>
                            </asp:UpdatePanel>--%>
                                                

                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="WO. Number" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                        </td>
                        <td>
                                                
                            <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>--%>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_wo" runat="server" Width="200px" AutoPostBack="true" CausesValidation="false"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.trans_id") %>' 
                                        DropDownWidth="1000px" EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="trans_id" DataValueField="trans_id"
                                        OnItemsRequested="cb_wo_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_wo_SelectedIndexChanged" 
                                        OnPreRender="cb_wo_PreRender">
                                        <HeaderTemplate>
                                            <table style="width: 1000px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 150px; font-variant:small-caps; color: #3399FF;">Wo Number
                                                    </td>
                                                    <td style="width: 75px; font-variant:small-caps; color: #3399FF;">Date
                                                    </td>
                                                    <td style="width: 100px; font-variant:small-caps; color: #3399FF;">Unit Code 
                                                    </td>                                                    
                                                    <td style="width: 250px; font-variant:small-caps; color: #3399FF;">Problem
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 1000px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 150px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.trans_id")%>
                                                    </td>
                                                    <td style="width: 75px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.trans_date")%>
                                                    </td>
                                                    <td style="width: 100px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                    </td>
                                                    <%--<td style="width: 75px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.unitstatus")%>
                                                    </td>
                                                    <td style="width: 750px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.DBDate")%>
                                                    </td>
                                                    <td style="width: 75px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.BDTime")%>
                                                    </td>
                                                    <td style="width: 200px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.OrderName")%>
                                                    </td>--%>
                                                    <td style="width: 250px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.remark")%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                        </FooterTemplate>
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_wo" ForeColor="Red" 
                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                <%--</ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                </Triggers>
                            </asp:UpdatePanel>--%>
                                                
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
                            <telerik:RadLabel runat="server" Text="Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="dtp_date" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="Telerik" 
                                  DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.sro_date") %>'>
                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"
                                  FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                                </DateInput>
                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Delivery Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="dtp_deliv" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="Telerik" 
                                 DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.deliv_date") %>'>
                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"
                                 FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                                </DateInput>
                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    
                </table>
            </td>
            <td style="vertical-align: top;">
                <table id="Table3" width="Auto" border="0" class="module" style="padding: 0px 0px 0px 7px"> 
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Priority" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cb_priority" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
                                Text='<%# DataBinder.Eval(Container, "DataItem.prio_desc") %>' 
                                EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="false" Width="150" DropDownWidth="150px" 
                                OnItemsRequested="cb_priority_ItemsRequested" 
                                OnPreRender="cb_priority_PreRender" 
                                OnSelectedIndexChanged="cb_priority_SelectedIndexChanged">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_priority" ForeColor="Red" 
                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Order Type" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cb_Order" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
                                Text='<%# DataBinder.Eval(Container, "DataItem.OrderName") %>' 
                                EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="false" Width="180" DropDownWidth="180px" 
                                OnItemsRequested="cb_Order_ItemsRequested" 
                                OnPreRender="cb_Order_PreRender" 
                                OnSelectedIndexChanged="cb_Order_SelectedIndexChanged">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="cb_Order" ForeColor="Red" 
                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Job Type" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cb_job" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true" CausesValidation="false" 
                                Text='<%# DataBinder.Eval(Container, "DataItem.PMAct_Name") %>' 
                                EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="180" DropDownWidth="180px" 
                                OnItemsRequested="cb_job_ItemsRequested" 
                                OnPreRender="cb_job_PreRender" 
                                OnSelectedIndexChanged="cb_job_SelectedIndexChanged">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="cb_job" ForeColor="Red" 
                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Ordered By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                        </td>
                        <td style="vertical-align:top; text-align:left">
                           <%-- <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>--%>
                                    <telerik:RadComboBox ID="cb_ordered" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.OrdByName") %>' 
                                        AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                        HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                        OnItemsRequested="cb_ordered_ItemsRequested" 
                                        OnPreRender="cb_ordered_PreRender" 
                                        OnSelectedIndexChanged="cb_ordered_SelectedIndexChanged">
                                        <HeaderTemplate>
                                            <table style="width: 650px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 300px;">
                                                        Name
                                                    </td>
                                                    <td style="width: 350px;">
                                                        Position
                                                    </td>                                                                
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 650px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 300px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                    </td>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                    </td>                                                                
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            A total of
                                            <asp:Literal runat="server" ID="RadComboItemsCount" />
                                            items
                                        </FooterTemplate>
                                    </telerik:RadComboBox>
                               <%-- </ContentTemplate>
                            </asp:UpdatePanel>--%>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left=15px">
                            <telerik:RadLabel runat="server" Text="Checked By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                        </td>
                        <td>
                           <%-- <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>--%>
                                    <telerik:RadComboBox ID="cb_checked" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.CheckedByName") %>' 
                                        AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                        HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                        OnItemsRequested="cb_checked_ItemsRequested" 
                                        OnPreRender="cb_checked_PreRender" 
                                        OnSelectedIndexChanged="cb_checked_SelectedIndexChanged">
                                        <HeaderTemplate>
                                            <table style="width: 650px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 300px;">
                                                        Name
                                                    </td>
                                                    <td style="width: 350px;">
                                                        Position
                                                    </td>                                                                
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 650px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 300px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                    </td>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                    </td>                                                                
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            A total of
                                            <asp:Literal runat="server" ID="RadComboItemsCount" />
                                            items
                                        </FooterTemplate>
                                    </telerik:RadComboBox>
                                <%--</ContentTemplate>
                            </asp:UpdatePanel>--%>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Acknowledged By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                        </td>
                        <td>
                            <%--<asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                <ContentTemplate>--%>
                                    <telerik:RadComboBox ID="cb_ack" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.AckByName") %>' 
                                        AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                        HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                        OnItemsRequested="cb_ack_ItemsRequested" 
                                        OnPreRender="cb_ack_PreRender" 
                                        OnSelectedIndexChanged="cb_ack_SelectedIndexChanged">
                                        <HeaderTemplate>
                                            <table style="width: 650px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 300px;">
                                                        Name
                                                    </td>
                                                    <td style="width: 350px;">
                                                        Position
                                                    </td>                                                                
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 650px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 300px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                    </td>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                    </td>                                                                
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            A total of
                                            <asp:Literal runat="server" ID="RadComboItemsCount" />
                                            items
                                        </FooterTemplate>
                                    </telerik:RadComboBox>
                               <%-- </ContentTemplate>
                            </asp:UpdatePanel>--%>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Remark" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                        </td>                
                        <td style="vertical-align:top; text-align:left">                               
                            <%--<asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                <ContentTemplate>--%>
                                    <telerik:RadTextBox ID="txt_remark" runat="server" TextMode="MultiLine"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.sro_remark") %>' 
                                        Width="350px" Rows="0" TabIndex="5" Resize="Both" Skin="Telerik">
                                    </telerik:RadTextBox>
                                    
                                    <asp:CheckBox runat="server" Checked="false" ID="chk_close" Visible="false" />
                                <%--</ContentTemplate>
                            </asp:UpdatePanel> --%>                                 
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        
    </table>
</div>
