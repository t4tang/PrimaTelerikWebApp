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
    <div style=" width:100%; border-top-style:solid; border-top-width:thin; padding-top:5px">           
        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" AutoGenerateColumns="false" PageSize="4"  Skin="Telerik"
            AllowPaging="true" AllowSorting="true" runat="server" CssClass="RadGrid_ModernBrowsers"
                
            ShowStatusBar="true">
            <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
            <HeaderStyle CssClass="gridHeader"/>
            <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
            <MasterTableView CommandItemDisplay="Top" DataKeyNames="sro_code,part_code" Font-Size="11px" Font-Names="Century Gothic" EditMode="InPlace" BorderStyle="Solid" 
                BorderColor="Silver" BorderWidth="1px" ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" 
                HeaderStyle-BorderStyle="Solid" HeaderStyle-BorderColor="Teal">
                <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="true" AddNewRecordText="New" />                    
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="40px"/>
                        <ItemStyle Width="60px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridTemplateColumn HeaderText="Operation" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                            ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lbl_operation" Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'></asp:Label>
                        </ItemTemplate>                                        
                        <EditItemTemplate>
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation_editTemp" EnableLoadOnDemand="True" DataTextField="OprName"
                                DataValueField="chart_code" AutoPostBack="true"
                                Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'
                                HighlightTemplatedItems="true" Height="70px" Width="120px" DropDownWidth="130px"
                                OnItemsRequested="cb_operation_inserttTemp_ItemsRequested"
                                OnSelectedIndexChanged="cb_operation_SelectedIndexChanged">
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation_insertTemp" EnableLoadOnDemand="True" AutoPostBack="true"
                                HighlightTemplatedItems="true" Height="70px" Width="120px" DropDownWidth="130px"
                                OnItemsRequested="cb_operation_inserttTemp_ItemsRequested"
                                OnSelectedIndexChanged="cb_operation_SelectedIndexChanged">
                            </telerik:RadComboBox>
                        </InsertItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                            ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lbl_prodType" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label runat="server" ID="lbl_prodType_editTemp" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:Label runat="server" ID="lbl_prodType_insertTemp"></asp:Label>
                        </InsertItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="120px" ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" >
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lbl_partCode" Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_editTemp" EnableLoadOnDemand="True" DataTextField="spec"
                                DataValueField="prod_code" AutoPostBack="true"
                                Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>' EmptyMessage="- Search product name here -"
                                HighlightTemplatedItems="true" Height="190px" Width="220px" DropDownWidth="430px"
                                OnItemsRequested="cb_prod_code_ItemsRequested" 
                                OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                OnPreRender="cb_prod_code_PreRender">                                                  
                                <HeaderTemplate>
                                <table style="width: 430px; font-size:smaller">
                                    <tr>
                                        <td style="width: 250px;">
                                            Prod. Name
                                        </td>     
                                        <td style="width: 180px;">
                                            Prod. Code
                                        </td>                                                           
                                    </tr>
                                </table>                                                       
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table style="width: 430px; font-size:smaller">
                                        <tr>
                                            <td style="width: 250px;">
                                                <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                            </td>        
                                            <td style="width: 180px;">
                                                <%# DataBinder.Eval(Container, "Value")%>
                                            </td>                                                        
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_insertTemp" EnableLoadOnDemand="True" DataTextField="spec"
                                DataValueField="prod_code" AutoPostBack="true"
                                EmptyMessage="- Search product name here -"
                                HighlightTemplatedItems="true" Height="190px" Width="220px" DropDownWidth="430px"
                                OnItemsRequested="cb_prod_code_ItemsRequested" 
                                OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" 
                                OnPreRender="cb_prod_code_PreRender">                                                   
                                <HeaderTemplate>
                                <table style="width: 430px; font-size:smaller">
                                    <tr>
                                        <td style="width: 250px;">
                                            Prod. Name
                                        </td>     
                                        <td style="width: 180px;">
                                            Prod. Code
                                        </td>                                                           
                                    </tr>
                                </table>                                                       
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table style="width: 430px; font-size:smaller">
                                        <tr>
                                            <td style="width: 250px;">
                                                <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                            </td>        
                                            <td style="width: 180px;">
                                                <%# DataBinder.Eval(Container, "Value")%>
                                            </td>                                                        
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </InsertItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lbl_qty" Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'>
                            </asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty_editTemp" Width="70px" NumberFormat-AllowRounding="true"
                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                DbValue='<%# Convert.ToDouble(Eval("part_qty")) %>'
                                onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                AutoPostBack="true" MaxLength="11" Type="Number"
                                NumberFormat-DecimalDigits="2" >
                            </telerik:RadNumericTextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty_insertTemp" Width="70px" NumberFormat-AllowRounding="true"
                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"                                                
                                onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                AutoPostBack="true" MaxLength="11" Type="Number"
                                NumberFormat-DecimalDigits="2" >
                            </telerik:RadNumericTextBox>
                        </InsertItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="QRS" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lbl_qtyRs" Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'>
                            </asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>                                        
                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qtyRs_editTemp" Width="70px" NumberFormat-AllowRounding="true"
                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                DbValue='<%# Convert.ToDouble(Eval("qty_pr")) %>'
                                onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                AutoPostBack="true" MaxLength="11" Type="Number"
                                NumberFormat-DecimalDigits="2" >
                            </telerik:RadNumericTextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qtyRs_insertTemp" Width="70px" NumberFormat-AllowRounding="true"
                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"                                                
                                onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                AutoPostBack="true" MaxLength="11" Type="Number"
                                NumberFormat-DecimalDigits="2" >
                            </telerik:RadNumericTextBox>
                        </InsertItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                            ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lbl_UoM" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label runat="server" ID="lbl_UoM_editTemp" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:Label runat="server" ID="lbl_UoM_insertTemp" ></asp:Label>
                        </InsertItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Waranty" HeaderStyle-Width="50px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" 
                            HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chk_waranty" Text="Warranty"
                                Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox runat="server" ID="chk_waranty_editTemp" Text="Warranty"
                                Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                        </EditItemTemplate>  
                        <InsertItemTemplate>
                            <asp:CheckBox runat="server" ID="chk_waranty_insertTemp" Text="Warranty" Enabled="true" />
                        </InsertItemTemplate>                                      
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="250px" ItemStyle-Width="250px" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lbl_remark" Width="250px" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_editTemp" Width="250px" 
                            Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></telerik:RadTextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_insertTemp" Width="250px"
                            ></telerik:RadTextBox>
                        </InsertItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                        ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-ForeColor="Red">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>               
    </div>
</div>

