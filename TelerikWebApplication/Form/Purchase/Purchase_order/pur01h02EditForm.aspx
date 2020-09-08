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
    </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="1000" BackgroundPosition="None" >
    <img alt="Loading..." src="../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
    <div>
        <div style="padding: 15px 15px 10px 15px;" class="lbObject">
            <table id="Table1" border="0" style="border-collapse: collapse; padding-top:5px; padding-left:15px; 
                padding-right:15px; padding-bottom:10px; font-size:smaller ">    
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
                                        TabIndex="4" Skin="Metro"> 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro"></Calendar>
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
                                        TabIndex="4" Skin="Metro">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
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
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" 
                                        OnSelectedIndexChanged="cb_po_type_SelectedIndexChanged" OnItemsRequested="cb_po_type_ItemsRequested">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Priority" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="150"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" 
                                        OnItemsRequested="cb_priority_ItemsRequested" OnSelectedIndexChanged="cb_priority_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="ETD" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_etd" runat="server" MinDate="1/1/1900" Width="150px"
                                        TabIndex="4" Skin="Metro" >
                                        <Calendar runat="server"  UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                        <DateInput  runat="server"  TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
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
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ship_mode" runat="server" Width="150px"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" 
                                        OnItemsRequested="cb_ship_mode_ItemsRequested" OnSelectedIndexChanged="cb_ship_mode_SelectedIndexChanged"
                                        EnableVirtualScrolling="true">
                                    </telerik:RadComboBox>
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
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="300px"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" AutoPostBack="true"
                                        OnItemsRequested="cb_supplier_ItemsRequested" OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" >
                                    </telerik:RadComboBox>
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
                                            <telerik:RadTextBox ID="txt_kurs" runat="server" Enabled="false" Width="100px" ReadOnly="true" RenderMode="Lightweight" 
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
                                    <telerik:RadLabel runat="server" Text="Tax Kurs" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_tax_kurs" runat="server" Width="111px" ReadOnly="true" RenderMode="Lightweight" 
                                           Skin="Telerik"   >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
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
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" 
                                                OnItemsRequested="cb_tax1_ItemsRequested" OnSelectedIndexChanged="cb_tax1_SelectedIndexChanged"
                                                EnableVirtualScrolling="true" >
                                            </telerik:RadComboBox>
                                            &nbsp Tax1 %                         
                                            <telerik:RadNumericTextBox ID="txt_pppn" runat="server" Width="75px" Enabled="false" Type="Percent" 
                                                EnabledStyle-HorizontalAlign="Right" >
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
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
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
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel> 
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Project" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
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
                                            EnableVirtualScrolling="true" EnableLoadOnDemand="true" >
                                            </telerik:RadComboBox>                       
                                            &nbsp Days:
                                            <telerik:RadTextBox ID="txt_term_days" Width="60px" 
                                                runat="server" >
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
                    <td colspan="3" style="padding-top:10px; padding-bottom:10px;">
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
                                    <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_sub_total" Width="130px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                    runat="server" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2" Skin="Telerik">
                                    </telerik:RadNumericTextBox>                                    
                                </td>
                                <td style="width:50px; padding-left:15px" class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Tax 2" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_tax2_value" Width="130px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                    runat="server" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2" Skin="Telerik">
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td style="width:60px; padding-left:15px" class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Other" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="width:70px">
                                   <telerik:RadNumericTextBox  ReadOnly="true" EnabledStyle-HorizontalAlign="Right" ID="txt_other_value"  Width="130px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                    runat="server" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2" Skin="Telerik">
                                    </telerik:RadNumericTextBox>
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
                                    <telerik:RadNumericTextBox  ReadOnly="true" runat="server" ID="txt_tax1_value" Width="130px" EnabledStyle-HorizontalAlign="Right"  NumberFormat-AllowRounding="true"
                                    onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                     MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" Skin="Telerik"  >
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td style="padding-left:15px" class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Tax 3" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox  ReadOnly="true" runat="server"  ID="txt_tax3_value" Width="130px" EnabledStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                    onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                     MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" Skin="Telerik"  >
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td style="padding-left:15px" class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Total" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_total" Width="150px" runat="server" 
                                        ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                        onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2" Skin="Telerik"  >
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>   
            </table>
        </div>

        <div style="padding: 5px 15px 0px 15px; border-bottom-style:double; border-bottom-width: 1px; border-bottom-color:deeppink; height:250px; overflow-y:auto">
                 <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Always">
                      <ContentTemplate>
                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" Skin="Telerik" PageSize="5"
                                AllowPaging="false" AllowSorting="true" runat="server" ShowStatusBar="true"  ClientSettings-Selecting-AllowRowSelect="true"
                                 >
                                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="Prod_code" Font-Size="12px" EditMode="Batch"
                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >
                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="False" ShowCancelChangesButton="false" />
                                    <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Type" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Left" >
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "prod_type")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_type" Width="180px" ReadOnly="true"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.prod_type") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>   
                                    <telerik:GridTemplateColumn UniqueName="prod_code" HeaderText="Prod. Code" HeaderStyle-Width="100px"
                                            SortExpression="prod_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Left">
                                            <FooterTemplate>Template footer</FooterTemplate>
                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <%#DataBinder.Eval(Container.DataItem, "Prod_code")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="spec"
                                                    DataValueField="prod_code" AutoPostBack="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Prod_code") %>' EmptyMessage="- Search product name here -"
                                                    HighlightTemplatedItems="true" Height="190px" Width="220px" DropDownWidth="430px" >                                                   
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
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Part Name" ItemStyle-Width="180px" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Left" >
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "spec")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_prod_name" Width="180px" ReadOnly="true"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.spec") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>                                    
                                    <telerik:GridTemplateColumn HeaderText="Qty" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "qty", "{0:#,###,###0.00}")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty" Width="50px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "qty", "{0:#,###,###0.00}") %>'
                                                    onkeydown="blurTextBox(this, event)"
                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                    NumberFormat-DecimalDigits="2" >
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn> 
                                   <telerik:GridTemplateColumn HeaderText="UoM" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "SatQty")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="50" runat="server" ID="cb_uom_d"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.SatQty") %>'
                                                EnableLoadOnDemand="True" Skin="MetroTouch" DataTextField="part_unit" DataValueField="part_unit" >
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>                   
                                    <telerik:GridTemplateColumn DataField="harga" HeaderText="Harga" HeaderStyle-Width="90px" ItemStyle-Width="90px"  SortExpression="harga" UniqueName="harga"
                                        ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblHarga" Text='<%# Eval("harga", "{0:#,###0.00;-#,###0.00;0}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <span>                                                
                                                <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_harga" Width="100px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "harga", "{0:#,###,###0.00}") %>'
                                                    onkeydown="blurTextBox(this, event)"
                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                    NumberFormat-DecimalDigits="2" >
                                                </telerik:RadTextBox>
                                                <span style="color: Red">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                                        ControlToValidate="txt_harga" ErrorMessage="*Required" runat="server" Display="Dynamic">
                                                    </asp:RequiredFieldValidator>
                                                </span>
                                            </span>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="55px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Disc. %" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "Disc", "{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_disc" Width="50px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "Disc", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2" >
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn> 
                                    <telerik:GridTemplateColumn HeaderText="Factor" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "factor", "{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_factor" Width="40px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "factor", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2" >
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Sub Price" ItemStyle-Width="90px" HeaderStyle-Width="90px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "jumlah", "{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_sub_price" Width="90px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "jumlah", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2" >
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="dept_code" HeaderText="Cost Ctr" HeaderStyle-Width="55px" ItemStyle-Width="55px" SortExpression="dept_code" UniqueName="dept_code"
                                        ItemStyle-HorizontalAlign="Left" >
                                        <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "dept_code")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_cost_ctr" Width="55px" ReadOnly="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>'>
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                     <telerik:GridTemplateColumn DataField="Prod_code_ori" HeaderText="Ori. Prod" HeaderStyle-Width="75px" ItemStyle-Width="75px" SortExpression="Prod_code_ori" UniqueName="Prod_code_ori"
                                        ItemStyle-HorizontalAlign="left">
                                        <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "Prod_code_ori")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_Prod_code_ori" Width="75px" ReadOnly="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Prod_code_ori") %>'>
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridButtonColumn ConfirmText="Delete this product?" ConfirmDialogType="RadWindow"
                                        ConfirmTitle="Delete" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center"
                                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                    </telerik:GridButtonColumn>
                                </Columns>
                                </MasterTableView>
                                <ClientSettings>
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="192px" />
                                    <Selecting AllowRowSelect="true"></Selecting>                    
                                </ClientSettings>
                            </telerik:RadGrid>
                            <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Text="Data tersimpan" Position="BottomRight"
                                    AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
                            </telerik:RadNotification>
                     </ContentTemplate>
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
                                Skin="Material"></telerik:RadButton>
                        </td>
                    </tr>                   
                </table>
            </div>

    </div>
    </form>
</body>
</html>
