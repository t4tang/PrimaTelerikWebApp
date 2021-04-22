<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h05fcEditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.FluidControl.Fuel.inv01h05fcEditForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
            <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cb_project">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_cost_ctr"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cb_unit"></telerik:AjaxUpdatedControl>
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_tanki" EventName="SelectedIndexChanged">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_save" EventName="Click">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_literHmKm"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
           <%-- <telerik:AjaxSetting AjaxControlID="cb_unit">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_modelNo"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_tankCapacity"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cb_costCenter"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_lastHmKm"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_hmCum"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>    --%>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="1000" BackgroundPosition="None" >
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
        </telerik:RadAjaxLoadingPanel>

        <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
    <div>
        <div style="padding: 15px 15px 10px 15px;" class="lbObject">
            <table>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="GI Number" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_gi_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                           Skin="Telerik"  EmptyMessage="Let it blank" >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                    </telerik:RadTextBox>
                                 </td>
                                 <td colspan="2">
                                    <asp:CheckBox Text="Posting" runat="server" ID="chkPosting" />                                 
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Project Area" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td colspan="3">                                    
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300px" Font-Size="Small"
                                            AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                            DropDownCssClass="rcbItem"
                                            OnItemsRequested="cb_project_prm_ItemsRequested" 
                                            OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                            OnPreRender="cb_project_PreRender">
                                            </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator runat="server" ID="rfv_projectValidator" ControlToValidate="cb_project" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>                             
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Unit Code" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td > 
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_unit" runat="server" Width="150" DropDownWidth="300px" Font-Size="Small"
                                                AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                DropDownCssClass="rcbItem"
                                                OnItemsRequested="cb_unit_ItemsRequested"
                                                OnSelectedIndexChanged="cb_unit_SelectedIndexChanged"
                                                OnPreRender="cb_unit_PreRender">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator runat="server" ID="rfv_unitValidator" ControlToValidate="cb_unit" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Model" CssClass="lbObject"></telerik:RadLabel></td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_modelNo" runat="server" Width="120px" ReadOnly="true" RenderMode="Lightweight" 
                                                   Skin="Telerik" >
                                                <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_unit" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Tank Capacity." CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <telerik:RadNumericTextBox ID="txt_tankCapacity" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                Skin="Telerik"  NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" Value="0"
                                                ReadOnlyStyle-HorizontalAlign="Right" onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2">
                                                <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                            </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_unit" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Cost Center" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td colspan="3"> 
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_costCenter" runat="server" Width="250px"
                                                DropDownWidth="350px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DropDownCssClass="rcbItem"
                                                OnItemsRequested="cb_cost_ctr_ItemsRequested" OnSelectedIndexChanged="cb_cost_ctr_SelectedIndexChanged" 
                                                OnPreRender="cb_cost_ctr_PreRender">
                                                    <HeaderTemplate>
                                                    <table style="width: 450px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 100px;">Code
                                                            </td>
                                                            <td style="width: 350px;">Name
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 450px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 100px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.code")%>
                                                            </td>
                                                            <td style="width: 350px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>                                                
                                            </telerik:RadComboBox>                                    
                                        <asp:RequiredFieldValidator runat="server" ID="rfv_costCtrValidator" ControlToValidate="cb_costcenter" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_unit" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Operator / Driver" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td colspan="3"> 
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_operator" runat="server" Width="250px"
                                        DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                        DropDownCssClass="rcbItem"
                                        OnItemsRequested="MP_ItemsRequested"
                                        OnSelectedIndexChanged="MP_SelectedIndexChanged"
                                        OnPreRender="MP_PreRender">
                                        <HeaderTemplate>
                                            <table style="width: 550px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 200px;">Name
                                                    </td>
                                                    <td style="width: 350px;">Position
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 550px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 200px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                    </td>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                    </td>
                                                </tr>
                                            </table>

                                        </ItemTemplate>
                                        <FooterTemplate>
                                        </FooterTemplate>
                                    </telerik:RadComboBox>                                   
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_driverValidator" ControlToValidate="cb_operator" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Fuelman" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td colspan="3"> 
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_fuelMan" runat="server" Width="250px"
                                        DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                        DropDownCssClass="rcbItem"
                                        OnItemsRequested="MP_ItemsRequested"
                                        OnSelectedIndexChanged="MP_SelectedIndexChanged"
                                        OnPreRender="MP_PreRender">
                                        <HeaderTemplate>
                                            <table style="width: 550px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 200px;">Name
                                                    </td>
                                                    <td style="width: 350px;">Position
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 550px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 200px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                    </td>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                    </td>
                                                </tr>
                                            </table>

                                        </ItemTemplate>
                                        <FooterTemplate>
                                        </FooterTemplate>
                                    </telerik:RadComboBox>                                   
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_fuelValidator" ControlToValidate="cb_fuelMan" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Unit Operation" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_unitOperation" runat="server" Width="150" DropDownWidth="300px" Font-Size="Small"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                        DropDownCssClass="rcbItem"
                                        OnItemsRequested="cb_unitOperation_ItemsRequested">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_unitOperationFieldValidator" ControlToValidate="cb_unitOperation" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Refueling" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_refueling" runat="server" Width="100px" Font-Size="Small"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                        DropDownCssClass="rcbItem"
                                        OnItemsRequested="cb_refueling_ItemsRequested" >
                                    </telerik:RadComboBox>
                                   <%-- <asp:RequiredFieldValidator runat="server" ID="rfv_refuelingValidator" ControlToValidate="cb_refueling" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Loading Type" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td colspan="3">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_LoadingType" runat="server" Width="150" DropDownWidth="300px" Font-Size="Small"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                        DropDownCssClass="rcbItem"
                                        OnItemsRequested="cb_LoadingType_ItemsRequested"
                                        OnSelectedIndexChanged="cb_LoadingType_SelectedIndexChanged"
                                        OnPreRender="cb_LoadingType_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Type Out" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td > 
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_typeOut" runat="server" Width="100px" DropDownWidth="100px" Font-Size="Small"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                        DropDownCssClass="rcbItem"
                                        OnItemsRequested="cb_typeOut_ItemsRequested"
                                        OnSelectedIndexChanged="cb_typeOut_SelectedIndexChanged"
                                        OnPreRender="cb_typeOut_PreRender">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_typeOutValidator" ControlToValidate="cb_typeOut" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Info Code" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_infoCode" runat="server" Width="100px" DropDownWidth="100px" Font-Size="Small"
                                        AutoPostBack="false" Enabled="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                        DropDownCssClass="rcbItem"
                                        >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Tanki / Fuel Truck" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td colspan="3">
                                    <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tanki" runat="server" Width="300px" DropDownWidth="300px" Font-Size="Small"
                                                AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                DropDownCssClass="rcbItem"
                                                OnItemsRequested="cb_tanki_ItemsRequested"
                                                OnSelectedIndexChanged="cb_tanki_SelectedIndexChanged"
                                                OnPreRender="cb_tanki_PreRender" >
                                            </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_tanki" ControlToValidate="cb_tanki" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Date" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td colspan="3">
                                    <telerik:RadDatePicker ID="dtp_transaction" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Telerik"> 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="MetroTouch" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        </DateInput>                        
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_dateTransaction" ControlToValidate="dtp_transaction" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Time" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>                                            
                                            <telerik:RadTimePicker ID="rtp_time" runat="server" RenderMode="Lightweight" OnSelectedDateChanged="rtp_time_SelectedDateChanged" 
                                                Width="100px" AutoPostBack="true"></telerik:RadTimePicker>
                                            <asp:RequiredFieldValidator runat="server" ID="rfv_time" ControlToValidate="rtp_time" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    
                                </td>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Shift" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_shift" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" 
                                               Skin="Telerik" >
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox> 
                                        </ContentTemplate>                                     
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="rtp_time" EventName="SelectedDateChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="HM" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <telerik:RadNumericTextBox ID="txt_HM" runat="server" Width="100px" ReadOnly="false" RenderMode="Lightweight" 
                                                Skin="Telerik" CausesValidation="false"  NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" Value="0" 
                                                onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" AutoPostBack="true"
                                                OnTextChanged="txt_HM_TextChanged">
                                                <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                <EnabledStyle CssClass="MyEnabledTextBox" HorizontalAlign="Right"></EnabledStyle>
                                                <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                            </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_HM" ControlToValidate="txt_HM" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Total HM" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                        <telerik:RadNumericTextBox ID="txt_totHm" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" 
                                            Skin="Telerik" ReadOnlyStyle-HorizontalAlign="Right" Value="0" 
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                            onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="txt_HM" EventName="TextChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Last HM/Km" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <telerik:RadNumericTextBox ID="txt_lastHmKm" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" 
                                                Skin="Telerik" ReadOnlyStyle-HorizontalAlign="Right" Value="0" 
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                onkeydown="blurTextBox(this, event)" NumberFormat-DecimalDigits="2">
                                            </telerik:RadNumericTextBox>                                    
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_unit" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Liter HM/Km" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ID="txt_literHmKm" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" 
                                           Skin="Telerik" ReadOnlyStyle-HorizontalAlign="Right"
                                         NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" Value="0" 
                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2">
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                    </telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_literHmKm" ControlToValidate="txt_literHmKm" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="HM Cum." CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <telerik:RadNumericTextBox ID="txt_hmCum" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" 
                                                Skin="Telerik" ReadOnlyStyle-HorizontalAlign="Right"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" Value="0" 
                                                onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2">
                                                <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                            </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_unit" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Approved" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td colspan="3">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px"
                                        DropDownWidth="350px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                        DropDownCssClass="rcbItem"
                                        OnItemsRequested="MP_ItemsRequested"
                                        OnSelectedIndexChanged="MP_SelectedIndexChanged"
                                        OnPreRender="MP_PreRender">
                                        <HeaderTemplate>
                                            <table style="width: 350px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 150px;">Name
                                                    </td>
                                                    <td style="width: 200px;">Position
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 350px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 150px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                    </td>
                                                    <td style="width: 200px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                    </td>
                                                </tr>
                                            </table>

                                        </ItemTemplate>
                                        <FooterTemplate>
                                        </FooterTemplate>
                                    </telerik:RadComboBox>                                   
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Remark" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td colspan="3">
                                    <telerik:RadTextBox ID="txt_remark" runat="server" Width="300px" ReadOnly="false" RenderMode="Lightweight" 
                                           Skin="Telerik" TextMode="MultiLine" >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                    </telerik:RadTextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_remark" ControlToValidate="txt_remark" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>                                   
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div style="padding: 5px 15px 0px 15px; border-bottom-style:double; border-bottom-width: 1px; border-bottom-color:deeppink; height:250px; overflow-y:auto">
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                 <ContentTemplate>
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" Skin="Telerik" PageSize="5"
                        AllowPaging="false" AllowSorting="true" runat="server" ShowStatusBar="true"  ClientSettings-Selecting-AllowRowSelect="true"
                        OnNeedDataSource="RadGrid2_NeedDataSource" >
                        <MasterTableView CommandItemDisplay="None" DataKeyNames="prod_code" Font-Size="12px" EditMode="Batch" 
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Material Code" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center" 
                                HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center" UniqueName="prod_code" SortExpression="prod_code">
                                <ItemTemplate> 
                                    <asp:Label ID="lblProdCode" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "prod_code") %>'></asp:Label> 
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Spec" HeaderStyle-Width="250px" ItemStyle-Width="250px"
                                HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblSpec" Text='<%# DataBinder.Eval(Container.DataItem, "prod_spec") %>'></asp:Label>
                                </ItemTemplate>                                        
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="100px" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Right" ColumnGroupName="QtyGroup" 
                                HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate> 
                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_qty" Width="80px"  ReadOnly="false" 
                                        EnabledStyle-HorizontalAlign="Right"
                                        NumberFormat-AllowRounding="true"
                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                        Text='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                        onkeydown="blurTextBox(this, event)"
                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2">
                                    </telerik:RadTextBox>
                                </ItemTemplate>                                      
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_uom" runat="server" ReadOnly="true" Text='<%# DataBinder.Eval(Container.DataItem, "uom") %>'></asp:Label>
                                </ItemTemplate>                                                                           
                            </telerik:GridTemplateColumn>
                        </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="cb_tanki" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <div style="padding: 5px 15px 5px 15px;">
            <table style="width:100%">
                <tr>                        
                    <td colspan="4" style="padding-top:0px; text-align:left; width:100%">
                        <telerik:RadButton ID="btn_save" runat="server" Text="Save" CssClass="btn-wrapper" ForeColor="White"
                        OnClick="btn_save_Click"  Skin="Material" AutoPostBack="true"></telerik:RadButton>                            
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
