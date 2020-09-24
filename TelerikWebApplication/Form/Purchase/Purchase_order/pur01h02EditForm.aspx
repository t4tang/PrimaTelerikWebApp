<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pur01h02EditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.Purchase_order.pur01h02EditForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../../Styles/common.css" rel="stylesheet" />
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
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="cb_project">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cb_cost_center"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_reff"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_prepared"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_verified"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_approved"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="cb_reff">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cb_cost_center"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_remark"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_pr_date" />
            </UpdatedControls>                
        </telerik:AjaxSetting>  
        <telerik:AjaxSetting AjaxControlID="cb_supplier">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cb_tax1"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_tax2"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_tax3"></telerik:AjaxUpdatedControl>
            </UpdatedControls>                
        </telerik:AjaxSetting>  
        <telerik:AjaxSetting AjaxControlID="RadGrid2">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadGrid2"></telerik:AjaxUpdatedControl>
            </UpdatedControls>                
        </telerik:AjaxSetting>
          
    </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="1000" BackgroundPosition="None" >
    <img alt="Loading..." src="../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
    <div>
        <div style="padding: 10px 5px 3px 15px;" class="lbObject">
            <table id="Table1" border="0" style="border-collapse: collapse; padding-top:5px; padding-left:15px; 
                padding-right:15px; padding-bottom:0px; font-size:smaller ">    
                <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module">                
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="PO Number" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_po_code" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
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
                                    <telerik:RadLabel runat="server" Text="PO Date" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_po"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Telerik" > 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                        <ReadOnlyStyle Resize="None"></ReadOnlyStyle>
                                        <FocusedStyle Resize="None"></FocusedStyle>
                                        <DisabledStyle Resize="None"></DisabledStyle>
                                        <InvalidStyle Resize="None"></InvalidStyle>
                                        <HoveredStyle Resize="None"></HoveredStyle>
                                        <EnabledStyle Resize="None"></EnabledStyle>
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Expired" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_exp" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Telerik">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
<EmptyMessageStyle Resize="None"></EmptyMessageStyle>

<ReadOnlyStyle Resize="None"></ReadOnlyStyle>

<FocusedStyle Resize="None"></FocusedStyle>

<DisabledStyle Resize="None"></DisabledStyle>

<InvalidStyle Resize="None"></InvalidStyle>

<HoveredStyle Resize="None"></HoveredStyle>

<EnabledStyle Resize="None"></EnabledStyle>
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Tipe" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_po_type" runat="server" Width="150"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Skin="Telerik" 
                                        OnSelectedIndexChanged="cb_po_type_SelectedIndexChanged" OnItemsRequested="cb_po_type_ItemsRequested">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Priority" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                     <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                        <ContentTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="150"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" AutoPostBack="true" Skin="Telerik" 
                                            OnItemsRequested="cb_priority_ItemsRequested" 
                                            OnSelectedIndexChanged="cb_priority_SelectedIndexChanged"
                                            OnPreRender="cb_priority_PreRender"
                                            EnableVirtualScrolling="true" >
                                        </telerik:RadComboBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="ETD" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_etd" runat="server" MinDate="1/1/1900" Width="150px"
                                        TabIndex="4" Skin="Telerik" >
                                        <Calendar runat="server"  UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput  runat="server"  TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
<EmptyMessageStyle Resize="None"></EmptyMessageStyle>

<ReadOnlyStyle Resize="None"></ReadOnlyStyle>

<FocusedStyle Resize="None"></FocusedStyle>

<DisabledStyle Resize="None"></DisabledStyle>

<InvalidStyle Resize="None"></InvalidStyle>

<HoveredStyle Resize="None"></HoveredStyle>

<EnabledStyle Resize="None"></EnabledStyle>
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Shift Mode" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ship_mode" runat="server" Width="150px"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" AutoPostBack="true" Skin="Telerik" 
                                            OnItemsRequested="cb_ship_mode_ItemsRequested" 
                                            OnSelectedIndexChanged="cb_ship_mode_SelectedIndexChanged"
                                            OnPreRender="cb_ship_mode_PreRender"
                                            EnableVirtualScrolling="true">
                                        </telerik:RadComboBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Validation" CssClass="lbObject"></telerik:RadLabel>
                                </td> 
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadTextBox ID="txt_validity" runat="server" Width="59px" RenderMode="Lightweight" 
                                           Skin="Telerik"   >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align: top; padding-left:15px">
                        <table id="Table3" border="0" class="module">

                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Supplier" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                        <ContentTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="300px"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" AutoPostBack="true"
                                            OnItemsRequested="cb_supplier_ItemsRequested" OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged"
                                            EnableVirtualScrolling="true" >
                                        </telerik:RadComboBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                
               
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Currency" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_curr" runat="server" Enabled="false" Width="111px" ReadOnly="true" RenderMode="Lightweight" 
                                           Skin="Telerik"   >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>&nbsp
                                            Kurs 
                                            <telerik:RadNumericTextBox ID="txt_kurs" runat="server" Enabled="false" Width="100px" ReadOnly="true" RenderMode="Lightweight" 
                                           Skin="Telerik"   >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>                                                
                                </td>
                            </tr>

                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Tax Kurs" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadNumericTextBox ID="txt_tax_kurs" runat="server" Width="111px" ReadOnly="true" RenderMode="Lightweight" 
                                           Skin="Telerik"   >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadNumericTextBox>
                                                &nbsp                                                 
                                            <asp:CheckBox ID="chk_ppn_incl" runat="server" AutoPostBack="false" Text="PPN Include" />
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>

                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Tax 1" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left"> 
                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                        <ContentTemplate>                                     
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax1" runat="server" Width="150"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" AutoPostBack="true"
                                                OnItemsRequested="cb_tax1_ItemsRequested" 
                                                OnSelectedIndexChanged="cb_tax1_SelectedIndexChanged"
                                                OnPreRender="cb_tax1_PreRender"
                                                EnableVirtualScrolling="true" >
                                            </telerik:RadComboBox>                                                                                                                
                                        &nbsp Tax1 %                                                           
                                        <telerik:RadNumericTextBox ID="txt_pppn" runat="server" Width="75px" Enabled="false" Type="Percent" 
                                            EnabledStyle-HorizontalAlign="Right" >
                                        </telerik:RadNumericTextBox>
                                     </ContentTemplate>                                        
                                    </asp:UpdatePanel>                                                          
                                </td>
                            </tr>

                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Tax 2" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax2" runat="server" Width="150" AutoPostBack="true"
                                                EnableLoadOnDemand="true" ShowMoreResultsBox="true" 
                                                OnItemsRequested="cb_tax2_ItemsRequested" OnSelectedIndexChanged="cb_tax2_SelectedIndexChanged"
                                                EnableVirtualScrolling="true">
                                            </telerik:RadComboBox>
                                            &nbsp Tax2 % 
                                            <telerik:RadNumericTextBox ID="txt_po_tax" runat="server" Width="75px" Enabled="false" Type="Percent"
                                                EnabledStyle-HorizontalAlign="Right" >
                                            </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                        <%--<Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>--%>
                                    </asp:UpdatePanel>                                                                       
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Tax 3" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax3" runat="server" Width="150" AutoPostBack="true"
                                                EnableLoadOnDemand="true" ShowMoreResultsBox="true" 
                                                OnItemsRequested="cb_tax3_ItemsRequested" OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged"
                                                EnableVirtualScrolling="true" >
                                            </telerik:RadComboBox>  
                                            &nbsp Tax3 % 
                                            <telerik:RadNumericTextBox ID="txt_ppph" runat="server" Width="75px" Enabled="false" Type="Percent"
                                                EnabledStyle-HorizontalAlign="Right">
                                            </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                        <%--<Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>--%>
                                    </asp:UpdatePanel> 
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Project" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                        OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged" Font-Size="Small"
                                        OnPreRender="cb_project_PreRender">
                                    </telerik:RadComboBox>               
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="PR Number" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                     <telerik:RadComboBox RenderMode="Lightweight" ID="cb_reff" runat="server" Width="300px"
                                         AutoPostBack="true" CausesValidation="false"
                                                DropDownWidth="900px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="pr_code" DataValueField="pr_code"                                                 
                                            OnSelectedIndexChanged="cb_reff_SelectedIndexChanged"
                                         OnItemsRequested="cb_reff_ItemsRequested"
                                            OnDataBound="cb_reff_DataBound">
                                            <HeaderTemplate>
                                                <table style="width: 600px">
                                                    <tr>
                                                        <td style="width: 140px;">
                                                            PR Number
                                                        </td>
                                                        <td style="width: 460px;">
                                                            Remark
                                                        </td>                                                                
                                                    </tr>
                                                </table>                                                       
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 600px">
                                                    <tr>
                                                        <td style="width: 140px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.pr_code")%>
                                                        </td>
                                                        <td style="width: 460px;">
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
                                </td>
                            </tr>
                            <tr >
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Cost Center" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cost_center" runat="server" Width="120px" DropDownWidth="300px" Skin="Telerik"
                                                EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true" 
                                                OnItemsRequested="cb_cost_ctr_ItemsRequested" 
                                                OnSelectedIndexChanged="cb_cost_ctr_SelectedIndexChanged" 
                                                OnPreRender="cb_cost_ctr_PreRender">
                                            </telerik:RadComboBox>               
                                            &nbsp PR Date 
                                            <telerik:RadTextBox ID="txt_pr_date" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" 
                                            Skin="Telerik"   >
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>           
                    </td>
                    <td >
                            <table id="Table4" border="0" class="module">
                                <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Term" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_term" runat="server" Width="120" ShowMoreResultsBox="true"
                                            EnableVirtualScrolling="true" EnableLoadOnDemand="true" 
                                            OnItemsRequested="cb_term_ItemsRequested"
                                            OnSelectedIndexChanged="cb_term_SelectedIndexChanged"
                                            OnPreRender="cb_term_PreRender">
                                            </telerik:RadComboBox>                       
                                            &nbsp Days:
                                            <telerik:RadNumericTextBox ID="txt_term_days" Width="60px" 
                                                runat="server" >
                                            </telerik:RadNumericTextBox>  
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>  
                                                                     
                                </td>
                            </tr>
                                <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="ATT Name" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_att_name" Width="250px" runat="server" ReadOnly="false" RenderMode="Lightweight" 
                                           Skin="Telerik"   >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>                                                
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Remark" CssClass="lbObject"></telerik:RadLabel>
                                </td>                
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_remark" 
                                                runat="server" TextMode="MultiLine"
                                                Width="250px" Rows="0" Columns="100" TabIndex="5" Resize="Both" RenderMode="Lightweight" 
                                           Skin="Telerik"   >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_reff" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                                
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Prepare By" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                                        <ContentTemplate>                                            
                                            <telerik:RadComboBox ID="cb_prepared" runat="server" Width="250px"
                                                DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                OnSelectedIndexChanged="cb_prepared_SelectedIndexChanged" 
                                                OnItemsRequested="cb_prepared_ItemsRequested"
                                                OnPreRender="ccb_prepared_PreRender">
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
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>

                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Verified By" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                        <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_verified" runat="server" Width="250px"
                                                DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                OnSelectedIndexChanged="cb_verified_SelectedIndexChanged" 
                                                OnItemsRequested="cb_verified_ItemsRequested"
                                                OnPreRender="cb_verified_PreRender">
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
                                            
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>

                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Approved By" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel14" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_approved" runat="server" Width="250px"
                                                DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                OnItemsRequested="cb_approved_ItemsRequested" 
                                                OnPreRender="cb_approved_PreRender">
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
                                            
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>

                            </tr>
                 
                                <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="PO Status" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_po_status" runat="server" Width="160px"
                                        ShowMoreResultsBox="true" EnableLoadOnDemand="true"
                                        EnableVirtualScrolling="true" OnSelectedIndexChanged="cb_po_status_SelectedIndexChanged" 
                                        OnItemsRequested="cb_po_status_ItemsRequested">
                                    </telerik:RadComboBox>
                       
                                </td>

                            </tr>
                                <tr>
                                    <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Shared Date" CssClass="lbObject"></telerik:RadLabel>
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <telerik:RadDatePicker ID="dtp_share_date" runat="server" MinDate="1/1/1900" Width="150px"
                                        TabIndex="4" Skin="Silk"> 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                    </telerik:RadDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                <td colspan="2">
                                    
                                    <asp:CheckBox ID="cb_fullSupply" runat="server" AutoPostBack="false" Text="Full Supply"/>
                                    &nbsp
                                    <asp:CheckBox ID="cb_mon_order" runat="server" AutoPostBack="false" Text="Monitoring Order"/>
                                </td>
                     
                            </tr>
                        </table>
                    </td>
                </tr>    
                <tr>
                    <td colspan="3" style="padding-top:5px; padding-bottom:0px; "">
                        <table>
                            <tr>
                                <td style="width:50px" class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="User" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="width:50px">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="50px" runat="server" RenderMode="Lightweight" 
                                           Skin="Telerik"   >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                </td>
                                <td style="width:80px; padding-left:15px" class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Last Update" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="width:70px;">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_lastUpdate" Width="140px" runat="server" RenderMode="Lightweight" 
                                           Skin="Telerik"   >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                </td>
                                <td style="width:70px;padding-left:15px" class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Sub Total" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_sub_total" Width="130px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                        runat="server" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2" Skin="Telerik">
                                    </telerik:RadNumericTextBox>  
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="RadGrid2" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                                                      
                                </td>
                                <td style="width:50px; padding-left:15px" class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Tax 2" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                     <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                        <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_tax2_value" Width="130px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                        runat="server" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2" Skin="Telerik">
                                        </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="RadGrid2" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                                <td style="width:60px; padding-left:15px" class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Other" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="width:70px">
                                     <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                       <telerik:RadNumericTextBox  ReadOnly="true" EnabledStyle-HorizontalAlign="Right" ID="txt_other_value"  Width="130px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                        runat="server" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2" Skin="Telerik">
                                        </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="RadGrid2" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>

                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Owner" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="50px" runat="server" RenderMode="Lightweight" 
                                           Skin="Telerik"   >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px" class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Printed" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_printed" Width="40px" runat="server" RenderMode="Lightweight" 
                                           Skin="Telerik"   >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    &nbsp
                                    <telerik:RadLabel runat="server" Text="Edited" CssClass="lbObject"></telerik:RadLabel>
                                    &nbsp
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" runat="server" RenderMode="Lightweight" 
                                           Skin="Telerik"   >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px" class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Tax 1" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                     <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                        <telerik:RadNumericTextBox  ReadOnly="true" runat="server" ID="txt_tax1_value" Width="130px" EnabledStyle-HorizontalAlign="Right"  NumberFormat-AllowRounding="true"
                                        onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                         MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" Skin="Telerik"  >
                                        </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="RadGrid2" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                                <td style="padding-left:15px" class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Tax 3" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                        <telerik:RadNumericTextBox  ReadOnly="true" runat="server"  ID="txt_tax3_value" Width="130px" EnabledStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                        onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                         MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" Skin="Telerik"  >
                                        </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="RadGrid2" />
                                    </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                                <td style="padding-left:15px" class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Total" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                        <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_total" Width="150px" runat="server" 
                                            ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                            onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2" Skin="Telerik"  >
                                        </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="RadGrid2" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>   
            </table>
        </div>

        <div style="padding: 5px 15px 10px 15px; border-bottom-style:double; border-bottom-width: 1px; border-bottom-color:deeppink;height:255px">
                 <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Always">
                      <ContentTemplate>
                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" Skin="Telerik" PageSize="5"
                                AllowPaging="false" AllowSorting="true" runat="server" ShowStatusBar="true"  ClientSettings-Selecting-AllowRowSelect="true"
                                OnNeedDataSource="RadGrid2_NeedDataSource" >
                                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="Prod_code" Font-Size="12px" EditMode="Batch"
                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >
                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="False" ShowCancelChangesButton="false" />
                                    <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Left"  ItemStyle-Width="40px" 
                                        HeaderStyle-ForeColor="#009900">
                                        <ItemTemplate>  
                                            <asp:Label runat="server" ID="lblProdType" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                                        </ItemTemplate>
                                        
                                    </telerik:GridTemplateColumn>  
                                    <telerik:GridTemplateColumn UniqueName="prod_code" HeaderText="Prod. Code" HeaderStyle-Width="100px"
                                            SortExpression="prod_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Left">
                                            <FooterTemplate>Template footer</FooterTemplate>
                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                            <ItemTemplate>                                               
                                                <asp:Label runat="server" ID="lblProdCode" Text='<%# DataBinder.Eval(Container.DataItem, "Prod_code") %>'></asp:Label>
                                            </ItemTemplate>
                                    </telerik:GridTemplateColumn>                                                            
                                    <telerik:GridTemplateColumn HeaderText="Qty" ItemStyle-Width="70px" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0" 
                                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900">
                                        <ItemTemplate>  
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty" Width="70px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                DbValue='<%# Convert.ToDouble(Eval("qty")) %>'
                                                onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2" 
                                                OnTextChanged="calculate_sub_price">
                                            </telerik:RadNumericTextBox>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn> 
                                   <telerik:GridTemplateColumn HeaderText="UoM" ItemStyle-Width="85px" HeaderStyle-Width="85px" HeaderStyle-HorizontalAlign="Center"
                                       HeaderStyle-ForeColor="#009900">
                                        <ItemTemplate>  
                                             <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="85px" runat="server" ID="cb_uom_d"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.SatQty") %>' Width="85px"
                                                EnableLoadOnDemand="True" Skin="Telerik" DataTextField="part_unit" DataValueField="part_unit" >
                                            </telerik:RadComboBox>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>                   
                                   <telerik:GridTemplateColumn DataField="harga" HeaderText="Harga" HeaderStyle-Width="140px" ItemStyle-Width="140px" UniqueName="harga"
                                        ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900">
                                        <ItemTemplate>                                         
                                                <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_harga" Width="140px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right"
                                                    DbValue='<%# Convert.ToDouble(Eval("harga")) %>'
                                                    onkeydown="blurTextBox(this, event)" 
                                                    AutoPostBack="true" MaxLength="20" Type="Number" EnabledStyle-HorizontalAlign="Right"
                                                    NumberFormat-DecimalDigits="2" 
                                                    OnTextChanged="calculate_sub_price" >
                                                </telerik:RadNumericTextBox>
                                        </ItemTemplate>
                                        
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Disc. %" ItemStyle-Width="70px" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0"
                                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900">
                                        <ItemTemplate>  
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_disc" Width="70px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right"
                                                DbValue='<%# Convert.ToDouble(Eval("Disc")) %>' 
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"
                                                NumberFormat-DecimalDigits="2" 
                                                OnTextChanged="calculate_sub_price">
                                            </telerik:RadNumericTextBox>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn> 
                                    <telerik:GridTemplateColumn HeaderText="Factor" ItemStyle-Width="60px" HeaderStyle-Width="60px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0"
                                        HeaderStyle-ForeColor="#009900" >
                                        <ItemTemplate>  
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_factor" Width="60px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right"
                                                DbValue='<%# Convert.ToDouble(Eval("factor")) %>' 
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"
                                                NumberFormat-DecimalDigits="2"  
                                                OnTextChanged="calculate_sub_price">
                                            </telerik:RadNumericTextBox>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Sub Price" ItemStyle-Width="180px" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0"
                                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900" >
                                        <ItemTemplate>
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_sub_price" Width="180px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right"
                                                DbValue='<%# Convert.ToDouble(Eval("jumlah")) %>' 
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right" ReadOnly="true"
                                                NumberFormat-DecimalDigits="2">
                                            </telerik:RadNumericTextBox>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Tax 1" HeaderStyle-Width="50px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" 
                                            HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="edt_chkTax1" OnCheckedChanged="edt_chkTax1_CheckedChanged" OnPreRender="edt_chkTax1_PreRender"
                                                Checked='<%# DataBinder.Eval(Container.DataItem, "tTax") %>' AutoPostBack="true" />
                                        </ItemTemplate>                                        
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Tax 2" HeaderStyle-Width="50px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                                        HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="edt_chkOTax" OnCheckedChanged="edt_chkOTax_CheckedChanged" OnPreRender="edt_chkOTax_PreRender"
                                                Checked='<%# DataBinder.Eval(Container.DataItem, "tOTax") %>' AutoPostBack="true" />
                                        </ItemTemplate>
                                                                               
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Tax 3" HeaderStyle-Width="50px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                                            HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="edt_chkTpph" OnCheckedChanged="edt_chkTpph_CheckedChanged" OnPreRender="edt_chkTpph_PreRender"
                                                Checked='<%# DataBinder.Eval(Container.DataItem, "tpph") %>'  AutoPostBack="true" />
                                        </ItemTemplate>                                       
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="dept_code" HeaderText="Cost Ctr" HeaderStyle-Width="75px" ItemStyle-Width="75px" SortExpression="dept_code" UniqueName="dept_code"
                                        ItemStyle-HorizontalAlign="Left" HeaderStyle-ForeColor="#009900" >
                                        <ItemTemplate>  
                                            <asp:Label runat="server" ID="lbl_cost_ctr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Prod_code_ori" HeaderText="Ori. Prod" HeaderStyle-Width="100px" ItemStyle-Width="100px" SortExpression="Prod_code_ori" UniqueName="Prod_code_ori"
                                        ItemStyle-HorizontalAlign="left" HeaderStyle-ForeColor="#009900">
                                        <ItemTemplate>  
                                            <asp:Label runat="server" ID="lbl_Prod_code_ori" Text='<%# DataBinder.Eval(Container, "DataItem.Prod_code_ori") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridButtonColumn ConfirmText="Delete this product?" ConfirmDialogType="RadWindow"
                                        ConfirmTitle="Delete" HeaderStyle-Width="40px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Left"
                                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                    </telerik:GridButtonColumn>
                                </Columns>
                                </MasterTableView>
                                <ClientSettings>
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="192px" SaveScrollPosition="true" />
                                    <Selecting AllowRowSelect="true"></Selecting>                    
                                </ClientSettings>
                            </telerik:RadGrid>
                            <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Text="Data tersimpan" Position="BottomRight"
                                    AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
                            </telerik:RadNotification>
                     </ContentTemplate>
                     <Triggers>
                         <asp:AsyncPostBackTrigger ControlID="cb_tax1" EventName="SelectedIndexChanged" />
                         <asp:AsyncPostBackTrigger ControlID="cb_tax2" EventName="SelectedIndexChanged"/>
                         <asp:AsyncPostBackTrigger ControlID="cb_tax3" EventName="SelectedIndexChanged"/>
                     </Triggers>
                    </asp:UpdatePanel>
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
                            <telerik:RadLabel runat="server" ID="lbl_Owner" Width="100px" Text="Owner: " CssClass="lbObject" Font-Size="Small"/>
                        </td>
                        <td style="padding: 0px 10px 0px 10px">
                            <telerik:RadLabel runat="server" ID="lbl_edited" Width="100px" Text="Edited: " CssClass="lbObject" Font-Size="Small"/>
                        </td>
                        <td colspan="2" style="padding-top:0px; text-align:left">
                            <telerik:RadButton ID="btn_save" runat="server" Text="Save" CssClass="btn-wrapper" ForeColor="White"
                                Skin="Material" OnClick="btn_save_Click"></telerik:RadButton>
                        </td>
                    </tr>                   
                </table>
            </div>

        </div>
        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data telah disimpan" Position="Center" Skin="Windows7"
                    AutoCloseDelay="7000" Width="350" Height="110" Title="Congrotulation" EnableRoundedCorners="true">
        </telerik:RadNotification>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
