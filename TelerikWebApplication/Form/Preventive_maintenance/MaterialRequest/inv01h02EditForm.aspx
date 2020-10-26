<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h02EditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.MaterialRequest.inv01h02EditForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    <link href="../../../Styles/common.css" rel="stylesheet" />
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
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="1000" BackgroundPosition="None" >
    <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" ></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" ></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_Project">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_wo"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_unit" />
                    <telerik:AjaxUpdatedControl ControlID="cb_priority" />
                    <telerik:AjaxUpdatedControl ControlID="cb_Order" />
                    <telerik:AjaxUpdatedControl ControlID="cb_job" />
                    <telerik:AjaxUpdatedControl ControlID="txt_remark" />
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_wo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_save">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadTabStrip1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="EntryPage"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <%--<telerik:AjaxSetting AjaxControlID="RadGrid2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
        <div>    
            <div style="padding: 10px 5px 3px 15px;" class="lbObject">
                <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"
                SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Telerik">
                <Tabs>
                    <telerik:RadTab Text="Entry" Height="15px" Selected="true"> 
                    </telerik:RadTab>
                    <telerik:RadTab Text="Detail" Height="15px">
                    </telerik:RadTab>                
                </Tabs>
            </telerik:RadTabStrip>
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <telerik:RadMultiPage runat="server" ID="RadMultiPage1" Height="600px">
                            <telerik:RadPageView runat="server" ID="EntryPage" Selected="true" >                
                                <div style="padding: 15px 15px 10px 20px;" class="lbObject">
                                    <table>
                                        <tr>
                                            <td>
                                                <telerik:RadLabel runat="server" Text="MR Number" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_mr_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
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
                                                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox ID="cb_Project" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
                                                            EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="250" DropDownWidth="270px" 
                                                            OnItemsRequested="cb_Project_ItemsRequested" 
                                                            OnPreRender="cb_Project_PreRender" 
                                                            OnSelectedIndexChanged="cb_Project_SelectedIndexChanged">
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_Project" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                

                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                <telerik:RadLabel runat="server" Text="WO. Number" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_wo" runat="server" Width="200px" AutoPostBack="true" CausesValidation="false"
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
                                                                        <td style="width: 75px; font-variant:small-caps; color: #3399FF;"">Date
                                                                        </td>
                                                                        <td style="width: 100px; font-variant:small-caps; color: #3399FF;"">Unit Code 
                                                                        </td>
                                                                        <td style="width: 75px; font-variant:small-caps; color: #3399FF;"">Status
                                                                        </td>
                                                                        <td style="width: 75px; font-variant:small-caps; color: #3399FF;"">B/D Date
                                                                        </td>
                                                                        <td style="width: 75px; font-variant:small-caps; color: #3399FF;"">B/D Time
                                                                        </td> 
                                                                        <td style="width: 200px; font-variant:small-caps; color: #3399FF;"">Order Type
                                                                        </td> 
                                                                        <td style="width: 250px; font-variant:small-caps; color: #3399FF;"">Problem
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
                                                                        <td style="width: 75px;">
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
                                                                        </td>
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
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                                
                                            </td>
                                            <%--<td style="vertical-align:top; text-align:left">                                
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox ID="cb_wo" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true" 
                                                            EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="false" Width="250px" DropDownWidth="1000px" 
                                                            OnItemsRequested="cb_wo_ItemsRequested" OnPreRender="cb_wo_PreRender" OnSelectedIndexChanged="cb_wo_SelectedIndexChanged" 
                                                            HighlightTemplatedItems="true">
                                                            <HeaderTemplate>
                                                                <table style="width: 1000px; font-size:smaller;">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            Wo Number
                                                                        </td>
                                                                        <td style="width: 75px;">
                                                                            Date
                                                                        </td>
                                                                        <td style="width: 100px;">
                                                                            Unit Code 
                                                                        </td>
                                                                        <td style="width: 75px;">
                                                                            Status
                                                                        </td>
                                                                        <td style="width: 75px;">
                                                                            B/D Date
                                                                        </td>
                                                                        <td style="width: 75px;">
                                                                            B/D Time
                                                                        </td> 
                                                                        <td style="width: 200px;">
                                                                            Order Type
                                                                        </td> 
                                                                        <td style="width: 250px;">
                                                                            Problem
                                                                        </td>                                            
                                                                    </tr>
                                                                </table
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 1000px; font-size:smaller;">
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
                                                                        <td style="width: 75px;">
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
                                                                        </td>
                                                                        <td style="width: 250px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.remark")%>
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
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_wo" ForeColor="Red" 
                                                    Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                            </td>--%>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                <telerik:RadLabel runat="server" Text="Unit Code" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_unit" runat="server" RenderMode="Lightweight" Width="150px" Skin="Telerik"></telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                <telerik:RadLabel runat="server" Text="Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadDatePicker ID="dtp_date" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="MetroTouch">
                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                <telerik:RadLabel runat="server" Text="Delivery Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadDatePicker ID="dtp_deliv" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="MetroTouch">
                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                <telerik:RadLabel runat="server" Text="Priority" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="cb_priority" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
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
                                                    EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="false" Width="180" DropDownWidth="180px" 
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
                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox ID="cb_ordered" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
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
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left=15px">
                                                <telerik:RadLabel runat="server" Text="Checked By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox ID="cb_checked" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
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
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                <telerik:RadLabel runat="server" Text="Acknowledged By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox ID="cb_ack" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
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
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                <telerik:RadLabel runat="server" Text="Remark" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                            </td>                
                                            <td style="vertical-align:top; text-align:left">                               
                                                <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadTextBox ID="txt_remark" runat="server" TextMode="MultiLine"
                                                            Width="350px" Rows="0" TabIndex="5" Resize="Both" Skin="Telerik">
                                                        </telerik:RadTextBox>
                                                        &nbsp
                                                        <telerik:RadLabel runat="server" Text="Close" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                        <asp:CheckBox runat="server" Checked="false" ID="chk_close" Visible="false" />
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>                                  
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadButton ID="btn_save" runat="server" Text="Save" CssClass="btn-wrapper" ForeColor="White" OnClick="btn_save_Click"
                                                        Skin="Material"></telerik:RadButton>   
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                    
                                            </td>
                                        </tr>
                                    </table>
                                </div> 
                                <div style="padding: 5px 15px 5px 15px;">
                                    <table>
                                        <tr>    
                                            <%--<td style="padding: 0px 10px 0px 10px"> 
                                                <telerik:RadLabel runat="server" ID="lbl_userId" Width="100px" Text="User: " CssClass="lbObject" Font-Size="Small"/>
                                            </td>
                                            <td style="width: 240px; padding-left: 5px">
                                                <telerik:RadLabel runat="server" ID="lbl_lastUpdate" Width="220px" Text="Last Update: " CssClass="lbObject" Font-Size="Small"/>
                                            </td>
                                            <td style="padding: 0px 10px 0px 10px"> 
                                                <telerik:RadLabel runat="server" ID="lbl_Owner" Width="100px" Text="Owner: " CssClass="lbObject" Font-Size="Small"/>
                                            </td>
                                            <td style="padding: 0px 10px 0px 10px">
                                                <telerik:RadLabel runat="server" ID="lbl_edited" Width="100px" Text="Edited: " CssClass="lbObject" Font-Size="Small"/>
                                            </td>
                                            <td style="padding: 0px 10px 0px 10px">
                                                <telerik:RadLabel runat="server" ID="lbl_Printed" Width="100px" Text="Printed: " CssClass="lbObject" Font-Size="Small"/>
                                            </td>                    --%>
                                            <td style="padding-top:0px; text-align:left">
                                                     
                                            </td>
                                        </tr>                   
                                    </table>
                                </div>
                            </telerik:RadPageView>

                             <telerik:RadPageView runat="server" ID="DetailPage" Enabled="False">
                                <div style="padding: 15px 15px 10px 20px;" class="lbObject">
                                    <div style=" width:100%; border-top-color: #336600;  height:170px; padding-top: 20px;">
                                        <%--<asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>--%>
                                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" GridLines="None" AutoGenerateColumns="false" PageSize="3"  Skin="Telerik"
                                                AllowPaging="true" AllowSorting="true" runat="server" ClientSettings-Selecting-AllowRowSelect="true" 
                                                AllowAutomaticDeletes="True" AllowAutomaticInserts="True"  Width="450px" ClientSettings-EnablePostBackOnRowClick="true"
                                                OnNeedDataSource="RadGrid1_NeedDataSource"
                                                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged"
                                             OnPreRender="RadGrid1_PreRender"
                                                ShowStatusBar="true">
                                                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                                <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />  
                                                <ClientSettings EnablePostBackOnRowClick="true" />                          
                                                <MasterTableView CommandItemDisplay="None" DataKeyNames="chart_code" Font-Size="11px" EditMode="InPlace"
                                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item">
                                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="30px" ></telerik:GridClientSelectColumn> 
                                                        <telerik:GridBoundColumn UniqueName="chart_code" HeaderText="Opr. Code" DataField="chart_code">
                                                            <HeaderStyle Width="100px"></HeaderStyle>
                                                            <ItemStyle Width="100px" />
                                                        </telerik:GridBoundColumn>
                                                        <%--<telerik:GridTemplateColumn HeaderText="Opr. Code" HeaderStyle-Width="100px" ItemStyle-Width="100px" 
                                                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900"
                                                            ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lbl_OprCode" Text='<%# DataBinder.Eval(Container.DataItem, "chart_code") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>--%>
                                                        <telerik:GridBoundColumn UniqueName="OprName" HeaderText="Maintenance Operation" DataField="OprName">
                                                            <HeaderStyle Width="250px"></HeaderStyle>
                                                            <ItemStyle Width="250px" />
                                                        </telerik:GridBoundColumn>
                                                       <%-- <telerik:GridTemplateColumn HeaderText="Maintenance Operation" HeaderStyle-Width="250px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblMainOpr" Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>--%>

                                                    </Columns>
                                                </MasterTableView>
                                            </telerik:RadGrid>
                                       <%-- </ContentTemplate>
                                        </asp:UpdatePanel>--%>
                                    </div>

                                    <div style=" width:100%; border-top-color:coral; border-top-style:solid; border-top-width:1px; padding-top:5px;">
                                       <%-- <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>--%>
                                                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5" Skin="Telerik"
                                                    AllowPaging="true" AllowSorting="true" runat="server" ShowStatusBar="true"
                                                ClientSettings-EnableAlternatingItems="True" ItemStyle-Height="15px" MasterTableView-EditMode="InPlace"
                                                AllowAutomaticDeletes="True" AllowAutomaticInserts="True"  
                                                OnNeedDataSource="RadGrid2_NeedDataSource"
                                                OnInsertCommand="RadGrid2_save_handler">
                                                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                                <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                                                <MasterTableView CommandItemDisplay="Bottom" DataKeyNames="part_code" Font-Size="11px" EditMode="InPlace"
                                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="Add Item" InsertItemDisplay="Bottom">
                                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                                                    <%--<GroupByExpressions>
                                                        <telerik:GridGroupByExpression>
                                                            <SelectFields>
                                                                <telerik:GridGroupByField FieldAlias="Operation" FieldName="OprName"></telerik:GridGroupByField>
                                                            </SelectFields>
                                                            <GroupByFields>
                                                                <telerik:GridGroupByField FieldName="OprName" ></telerik:GridGroupByField>
                                                            </GroupByFields>
                                                        </telerik:GridGroupByExpression>
                                
                                                    </GroupByExpressions>--%>
                                                    <Columns>
                                                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                                            HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update" >
                                                        </telerik:GridEditCommandColumn>
                                                        <%--<telerik:GridTemplateColumn HeaderText="No" HeaderStyle-Width="20px" ItemStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" 
                                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lbl_nomor" Width="10px" Text='<%# DataBinder.Eval(Container.DataItem, "nomor") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>--%>
                                                        <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lbl_prodType" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lbl_partCode" Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="Prod_code"
                                                                    DataValueField="Prod_code" AutoPostBack="true"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.part_code") %>' EmptyMessage="- Select product -"
                                                                    HighlightTemplatedItems="true" Width="130px" DropDownWidth="550px" DropDownAutoWidth="Enabled" 
                                                                    OnItemsRequested="cb_prod_code_ItemsRequested"
                                                                    OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged"  >                                                   
                                                                    <HeaderTemplate>
                                                                    <table style="width: 550px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 350px;">
                                                                                Prod. Name
                                                                            </td>     
                                                                            <td style="width: 120px;">
                                                                                Prod. Code
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                UoM
                                                                            </td>                                                        
                                                                        </tr>
                                                                    </table>                                                       
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 550px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 350px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                                            </td>        
                                                                            <td style="width: 120px;">
                                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['unit']")%>
                                                                            </td>                                                                                                
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblPartQty" Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="80px"  ReadOnly="false" 
                                                                    EnabledStyle-HorizontalAlign="Right"
                                                                    NumberFormat-AllowRounding="true"
                                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'
                                                                    onkeydown="blurTextBox(this, event)"
                                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                                    NumberFormat-DecimalDigits="2">
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="QRS" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                             <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblQtyRs" Text='<%# DataBinder.Eval(Container.DataItem, "qty_pr", "{0:#,###,###0.00}") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <%--<EditItemTemplate>
                                                                <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qtyRs" Width="70px" NumberFormat-AllowRounding="true"
                                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                    DbValue='<%# Convert.ToDouble(Eval("qty_pr")) %>' Value="0"
                                                                    onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                                                    AutoPostBack="false" MaxLength="11" Type="Number"
                                                                    NumberFormat-DecimalDigits="2" >
                                                                </telerik:RadNumericTextBox>
                                                            </EditItemTemplate>--%>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lbl_UoM" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Waranty" HeaderStyle-Width="50px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" 
                                                                HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" ID="chk_waranty" Text="Warranty"
                                                                    Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                                                            </ItemTemplate>                                        
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="250px" ItemStyle-Width="250px" HeaderStyle-HorizontalAlign="Center" 
                                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lbl_remark" Width="250px" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="310px"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <%--<telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                                            ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                                        </telerik:GridButtonColumn>--%>
                                                    </Columns>
                                                </MasterTableView>
                                                <ClientSettings>                         
                                                   <%-- <Scrolling AllowScroll="true" UseStaticHeaders="false" ScrollHeight="273px" />--%>
                                                 </ClientSettings>
                                            </telerik:RadGrid>
                                        <%--</ContentTemplate>                                            
                                        </asp:UpdatePanel>  --%>
                                    </div>
                                </div>

                            </telerik:RadPageView>
                        </telerik:RadMultiPage>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btn_save" />
                    </Triggers>
                </asp:UpdatePanel>                
            </div>
        </div>

        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Initial text" Position="Center" Skin="Windows7"
                    AutoCloseDelay="7000" Width="350" Height="110" Title="Current time" EnableRoundedCorners="true">
        </telerik:RadNotification>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>  

    </form>
</body>
</html>
