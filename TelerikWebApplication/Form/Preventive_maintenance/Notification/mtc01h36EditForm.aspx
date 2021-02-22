<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mtc01h36EditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.Notification.mtc01h36EditForm" %>

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
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="cb_project">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="cb_unit" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="cb_unit">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="txt_model" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
        
        <div>
            <div style="padding: 15px 15px 10px 15px;" class="lbObject">
                <table>
                    <tr style="vertical-align: top">
                        <td style="vertical-align: top">
                            <table id="Table2" width="Auto" border="0" class="module">
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" Text="Notif. Number" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox runat="server" RenderMode="Lightweight" ID="txt_notif" ReadOnly="true" Skin="Telerik" EmptyMessage="Let it blank" Width="150px">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" Text="WO. Number" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox runat="server" RenderMode="Lightweight" ID="txt_WO" ReadOnly="true" Skin="Telerik" EmptyMessage="Let it blank" Width="150px" Enabled="false">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" Text="Req. Date" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker runat="server" RenderMode="Lightweight" ID="dtp_req" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="MetroTouch">
                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" 
                                                Skin="Telerik"></Calendar>
                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                            <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="dtp_req" ForeColor="Red" Font-Size="X-Small" 
                                            Text="Required!" CssClass="required_validator">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" Text="Notif. Type" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                                            <ContentTemplate>
                                                <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cb_notif" Skin="Telerik" 
                                                    EnableLoadOnDemand="true" EnableVirtualScrolling="true" MarkFirstMatch="true" AutoPostBack="true" CausesValidation="false" 
                                                    Width="150" DropDownWidth="180px" ShowMoreResultsBox="true" 
                                                    OnItemsRequested="cb_notif_ItemsRequested" 
                                                    OnSelectedIndexChanged="cb_notif_SelectedIndexChanged" 
                                                    OnPreRender="cb_notif_PreRender">
                                                </telerik:RadComboBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" Text="Status" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel runat="server" ID="UpdatePanel3">
                                            <ContentTemplate>
                                                <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cb_status" Skin="Telerik" 
                                                    EnableLoadOnDemand="true" EnableVirtualScrolling="true" MarkFirstMatch="true" AutoPostBack="true" CausesValidation="false" 
                                                    Width="150" DropDownWidth="180px" ShowMoreResultsBox="true" 
                                                    OnItemsRequested="cb_status_ItemsRequested" 
                                                    OnSelectedIndexChanged="cb_status_SelectedIndexChanged"
                                                    OnPreRender="cb_status_PreRender">
                                                </telerik:RadComboBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" Text="Report By" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox runat="server" RenderMode="Lightweight" ID="txt_report" Skin="Telerik" Width="180px"></telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" Text="Problem" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                                            <ContentTemplate>
                                                <telerik:RadTextBox runat="server" RenderMode="Lightweight" ID="txt_problem" TextMode="MultiLine" Width="300px" Rows="0" 
                                                    TabIndex="5" Resize="Both">
                                                </telerik:RadTextBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="vertical-align: top; padding-left:15px">
                            <table id="Table3" border="0" class="module">
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" Text="Project" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cb_Project" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true" 
                                            CausesValidation="false" EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" 
                                            Width="250" DropDownWidth="270px" 
                                            OnItemsRequested="cb_Project_ItemsRequested" 
                                            OnPreRender="cb_Project_PreRender" 
                                            OnSelectedIndexChanged="cb_Project_SelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_Project" ForeColor="Red" Font-Size="X-Small" 
                                            Text="Required!" CssClass="required_validator">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" Text="Unit" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel runat="server" ID="UpdatePanel4">
                                            <ContentTemplate>
                                                <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cb_unit" Skin="Telerik" EnableLoadOnDemand="true" 
                                                    EnableVirtualScrolling="true" MarkFirstMatch="true" AutoPostBack="true" Width="150" DropDownWidth="750px" HighlightTemplatedItems="true" 
                                                    CausesValidation="false" DataTextField="unit_code" DataValueField="unit_code" Font-Size="Small" 
                                                    OnItemsRequested="cb_unit_ItemsRequested" 
                                                    OnSelectedIndexChanged="cb_unit_SelectedIndexChanged" 
                                                    OnPreRender="cb_unit_PreRender">
                                                    <HeaderTemplate>
                                                        <table style="width: 750px; font-size: smaller">
                                                            <tr>
                                                                <td style="width: 150px; font-variant:small-caps; color: #3399FF;">Unit Code
                                                                </td>
                                                                <td style="width: 200px; font-variant:small-caps; color: #3399FF;"">Unit Name
                                                                </td>
                                                                <td style="width: 150px; font-variant:small-caps; color: #3399FF;"">Model No
                                                                </td>
                                                                <td style="width: 100px; font-variant:small-caps; color: #3399FF;"">Project
                                                                </td>
                                                                <td style="width: 100px; font-variant:small-caps; color: #3399FF;"">Cost Center
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 750px; font-size: smaller">
                                                            <tr>
                                                                <td style="width: 150px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                                </td>
                                                                <td style="width: 200px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.unit_name")%>
                                                                </td>
                                                                <td style="width: 150px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.model_no")%>
                                                                </td>
                                                                <td style="width: 100px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.region_code")%>
                                                                </td>
                                                                <td style="width: 150px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.CostCenterName")%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                    </FooterTemplate>
                                                </telerik:RadComboBox>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" Text="Model No" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadTextBox runat="server" RenderMode="Lightweight" ID="txt_model" Width="150px" Skin="Telerik"></telerik:RadTextBox>
                                                &nbsp
                                                <telerik:RadLabel runat="server" RenderMode="Lightweight" Text="Reading" ForeColor="Black"></telerik:RadLabel>
                                                <telerik:RadNumericTextBox ID="txt_reading" runat="server" Width="100px" RenderMode="Lightweight" AutoPostBack="false"></telerik:RadNumericTextBox>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_unit" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" Text="Unit Status" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="chk_breakdown" Text="Breakdown" />
                                        &nbsp
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" Text="B/D Time" ForeColor="Black"></telerik:RadLabel>
                                        <telerik:RadDatePicker runat="server" RenderMode="Lightweight" ID="dtp_time" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="MetroTouch">
                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                                FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                            <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="dtp_req" ForeColor="Red" 
                                            Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                        &nbsp
                                        <telerik:RadNumericTextBox runat="server" RenderMode="Lightweight" Width="100px" ForeColor="Black" ID="txt_breakdown"></telerik:RadNumericTextBox>    
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" ForeColor="Black" Text="Comp.Group"></telerik:RadLabel>
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <asp:UpdatePanel runat="server" ID="UpdatePanel5">
                                            <ContentTemplate>
                                                <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cb_group" Width="350" DropDownWidth="350px" Skin="Telerik" 
                                                    AutoPostBack="false" EnableLoadOnDemand="true" EnableVirtualScrolling="true" HighlightTemplatedItems="true" ShowMoreResultsBox="true" 
                                                    MarkFirstMatch="true" OnItemsRequested="cb_group_ItemsRequested"
                                                    OnSelectedIndexChanged="cb_group_SelectedIndexChanged" 
                                                    OnPreRender="cb_group_PreRender">
                                                    <HeaderTemplate>
                                                        <table style="width: 350px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 100px;">
                                                                    Code
                                                                </td>
                                                                <td style="width: 250px;">
                                                                    Group Name
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 350px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 100px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.com_group")%>
                                                                </td>
                                                                <td style="width: 250px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.com_group_name")%>
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
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" ForeColor="Black" Text="Component"></telerik:RadLabel>
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <asp:UpdatePanel runat="server" ID="UpdatePanel6">
                                            <ContentTemplate>
                                                <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cb_component" Width="350" DropDownWidth="350px" 
                                                    Skin="Telerik" AutoPostBack="false" EnableLoadOnDemand="true" EnableVirtualScrolling="true" HighlightTemplatedItems="true" 
                                                    ShowMoreResultsBox="true" MarkFirstMatch="true" 
                                                    OnItemsRequested="cb_component_ItemsRequested" 
                                                    OnSelectedIndexChanged="cb_component_SelectedIndexChanged" 
                                                    OnPreRender="cb_component_PreRender">
                                                    <HeaderTemplate>
                                                        <table style="width: 350px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 100px;">
                                                                    Code
                                                                </td>
                                                                <td style="width: 250px;">
                                                                    Component Name
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 350px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 100px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.com_code")%>
                                                                </td>
                                                                <td style="width: 250px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.com_name")%>
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
                            </table>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 5px 15px 5px 15px;">
                <table>
                    <tr>    
                        <td style="padding: 0px 10px 0px 10px"> 
                            <telerik:RadLabel runat="server" ID="lbl_userId" Width="100px" Text="User: " CssClass="lbObject" Font-Size="Small"/>
                        </td>
                        <td style="width: 240px; padding-left: 5px">
                            <telerik:RadLabel runat="server" ID="lbl_lastUpdate" Width="220px" Text="Last Update: " CssClass="lbObject" Font-Size="Small"/>
                        </td>
                        <td style="padding: 0px 10px 0px 10px"> 
                            <telerik:RadLabel runat="server" ID="lbl_release" Width="220px" Text="Date Release: " CssClass="lbObject" Font-Size="Small"/>
                        </td>
                        <td style="padding: 0px 10px 0px 10px">
                            <telerik:RadLabel runat="server" ID="lbl_closed" Width="220px" Text="Date Closed: " CssClass="lbObject" Font-Size="Small"/>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 5px 15px 5px 15px;">
                <table>
                    <tr>
                        <td style="width:20%;">
                            <telerik:RadToolTip ID="RadToolTip1" runat="server" TargetControlID="Image1" Width="280px" Height="200px" 
                                Position="MiddleRight" RelativeTo="Element" ShowEvent="OnMouseOver" HideDelay="10000" Font-Names="Century Gothic" ForeColor="#006600" >
                                <asp:UpdatePanel ID="Updatepanel12" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </telerik:RadToolTip>
                           
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/info.png" Height="20px" Width="22px" />
                        </td>
                    </tr>
                    <tr>                    
                        <td style="text-align:center">
                            <telerik:RadButton ID="btn_save" runat="server" Text="Save" CssClass="btn-wrapper" ForeColor="White"
                            OnClick="btn_save_Click"  Skin="Material"></telerik:RadButton>                        
                        </td>
                    </tr>                   
                </table>
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
