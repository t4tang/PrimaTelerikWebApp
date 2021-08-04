<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pur01d02.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.Purchase_order.edit_form" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    <style>
        body {
            font: 14px/1.4 Helvetica, Arial, sans-serif;
        }
 
        button.RadButton span.rbIcon {
            vertical-align: sub;
        }
 
        .rdfLabel.rdfBlock {
            margin-top: 6px;
        }
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
        <script type="text/javascript">
                function CloseAndRebind(args) {
                    GetRadWindow().BrowserWindow.refreshGrid(args);
                    GetRadWindow().close();
                }
 
                function GetRadWindow() {
                    var oWindow = null;
                    if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
                    else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)
 
                    return oWindow;
                }
 
                function CancelEdit() {
                    GetRadWindow().close();
                }
            </script>
            
            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                    <telerik:AjaxSetting AjaxControlID="cb_project">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="cb_reff" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                            <telerik:AjaxUpdatedControl ControlID="cb_prepared" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                            <telerik:AjaxUpdatedControl ControlID="cb_verified" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                            <telerik:AjaxUpdatedControl ControlID="cb_approved" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                        </UpdatedControls>
                    </telerik:AjaxSetting>  
                    <telerik:AjaxSetting AjaxControlID="cb_reff">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="cb_cost_center" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                            <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                        </UpdatedControls>
                    </telerik:AjaxSetting> 
                    <telerik:AjaxSetting AjaxControlID="RadGrid2">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                        </UpdatedControls>
                    </telerik:AjaxSetting>                 
                </AjaxSettings>
            </telerik:RadAjaxManager>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
            </telerik:RadAjaxLoadingPanel>
            
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
                <Scripts>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
                </Scripts>
            </telerik:RadScriptManager>
            
            <div>                  
                <asp:Panel ID="Panel1" runat="server">  
                    <div style="position:fixed; width:1100px">
                        <telerik:RadButton ID="btnStandard" runat="server" Text="Save" OnClick="btnStandard_Click" Height="30px"
                        SingleClick="true" SingleClickText="Saving..." Style="clear: both; float: left; margin: 5px 0;">
                        </telerik:RadButton>
                    </div>                    
                    <div style="padding-top:34px">                               
                        <table id="Table1" border="0" style="border-collapse: collapse; padding-top:5px; padding-left:15px; 
                            padding-right:15px; padding-bottom:10px; font-size:smaller ">    
                           <tr style="vertical-align: top">
                                <td style="vertical-align: top">
                                    <table id="Table2" width="Auto" border="0" class="module">                
                                        <tr>
                                            <td class="tdLabel">
                                                PO Number:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_po_number" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                                  AutoPostBack="false">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>             
                                        <tr>
                                            <td class="tdLabel">
                                                PO Date:
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
                                                Expired:
                                            </td>
                                            <td>
                                                <telerik:RadDatePicker ID="dtp_exp" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                    TabIndex="4" Skin="Silk">
                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                    </DateInput>
                                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                Tipe:
                                            </td>
                                            <td>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_po_type" runat="server" Width="150"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" 
                                                    OnItemsRequested="cb_po_type_ItemsRequested" OnSelectedIndexChanged="cb_po_type_SelectedIndexChanged"
                                                    EnableVirtualScrolling="true" >
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                Priority:
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
                                                ETD:
                                            </td>
                                            <td>
                                                <telerik:RadDatePicker ID="dtp_etd" runat="server" MinDate="1/1/1900" Width="150px"
                                                    TabIndex="4" Skin="Silk" >
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
                                                Ship Mode:
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
                                                Validation value:
                                            </td> 
                                            <td style="vertical-align:top; text-align:left">
                                                <telerik:RadTextBox ID="txt_validity" runat="server" Width="59px">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="vertical-align: top; padding-left:15px">
                                    <table id="Table3" border="0" class="module">

                                        <tr>
                                            <td class="tdLabel">
                                                Supplier:
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
                                                Currency:
                                            </td>
                                            <td style="vertical-align:top; text-align:left">
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadTextBox ID="txt_curr" runat="server" Enabled="false" Width="111px">
                                                        </telerik:RadTextBox>&nbsp
                                                        Kurs 
                                                        <telerik:RadTextBox ID="txt_kurs" runat="server" Enabled="false" Width="100px">
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
                                                Tax Kurs:
                                            </td>
                                            <td style="vertical-align:top; text-align:left">
                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadTextBox ID="txt_tax_kurs" runat="server" Width="111px" Enabled="false" >
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
                                                Tax 1:
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
                                                Tax 2:
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
                                                Tax 3:
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
                                                Project:
                                            </td>
                                            <td style="vertical-align:top; text-align:left">                      
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                                    AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -"
                                                    OnSelectedIndexChanged="cb_project_SelectedIndexChanged">
                                                </telerik:RadComboBox>               
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                PR Number:
                                            </td>
                                            <td style="vertical-align:top; text-align:left">
                                                <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_reff" runat="server" Width="300px" 
                                                         EnableLoadOnDemand="false" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                        DropDownWidth="650px" AutoPostBack="true" EmptyMessage="- Select a PR Code -"
                                                        OnSelectedIndexChanged="cb_reff_SelectedIndexChanged" OnItemsRequested="cb_reff_ItemsRequested"
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
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                        </asp:AsyncPostBackTrigger>
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                                
                                            </td>
                                        </tr>
                                        <tr >
                                            <td class="tdLabel">
                                                Cost Ctr:
                                            </td>
                                            <td style="vertical-align:top; text-align:left">
                                                <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cost_center" runat="server" Width="120px" DropDownWidth="300px"
                                                                EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                                        </telerik:RadComboBox>               
                                                        &nbsp PR Date 
                                                        <telerik:RadTextBox ID="txt_pr_date" runat="server" Width="100px" Enabled="false" >                                                   
                                                        </telerik:RadTextBox>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="cb_reff" EventName="SelectedIndexChanged">
                                                        </asp:AsyncPostBackTrigger>
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>           
                                </td>
                                <td >
                                     <table id="Table4" border="0" class="module">
                                         <tr>
                                            <td class="tdLabel">
                                                Term:
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
                                                ATT Name
                                            </td>
                                            <td style="vertical-align:top; text-align:left">
                                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadTextBox ID="txt_att_name" Width="250px" 
                                                           runat="server" ></telerik:RadTextBox>
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
                                                Remark:
                                            </td>                
                                            <td style="vertical-align:top; text-align:left">
                                                <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadTextBox ID="txt_remark" 
                                                           runat="server" TextMode="MultiLine"
                                                            Width="250px" Rows="0" Columns="100" TabIndex="5" Resize="Both">
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
                                                Prepare By
                                            </td>
                                            <td style="vertical-align:top; text-align:left">
                                                <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_prepared" runat="server" Width="250px" 
                                                        DropDownWidth="450px" AutoPostBack="false" EmptyMessage="- Select -" EnableLoadOnDemand="false"                                                       
                                                            OnSelectedIndexChanged="cb_prepared_SelectedIndexChanged" OnItemsRequested="cb_prepared_ItemsRequested"
                                                            OnDataBound="cb_prepared_DataBound" Skin="Metro">
                                                            <HeaderTemplate>
                                                                <table style="width: 400px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 80px;">
                                                                            NIK
                                                                        </td>
                                                                        <td style="width: 300px;">
                                                                            Position
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>                                                       
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 350px; font-size:smaller">
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
                                                                A total of
                                                                <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                                items
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
                                                Verified By
                                            </td>
                                            <td style="vertical-align:top; text-align:left">
                                                 <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_verified" runat="server" Width="250px" 
                                                            DropDownWidth="350px" AutoPostBack="false" EmptyMessage="- Select -" EnableLoadOnDemand="false" 
                                                            OnSelectedIndexChanged="cb_verified_SelectedIndexChanged"
                                                            Skin="Metro">
                                                            <HeaderTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 150px;">
                                                                                NIK
                                                                            </td>
                                                                            <td style="width: 200px;">
                                                                                Position
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>                                                       
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
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
                                                                    A total of
                                                                    <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                                    items
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
                                                Approved By
                                            </td>
                                            <td style="vertical-align:top; text-align:left">
                                                <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                                                    <ContentTemplate>                                                        
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px" 
                                                            DropDownWidth="380px" AutoPostBack="false" EmptyMessage="- Select -" EnableLoadOnDemand="false" 
                                                            OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                            Skin="Metro">
                                                            <HeaderTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 150px;">
                                                                                Nik
                                                                            </td>
                                                                            <td style="width: 200px;">
                                                                                Position
                                                                            </td>                                                                
                                                                        </tr>
                                                                    </table>                                                       
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 350px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 150px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                            </td>
                                                                            <td style="width: 300px;">
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
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                            </asp:AsyncPostBackTrigger>
                                                        </Triggers>
                                                </asp:UpdatePanel>
                                            </td>

                                        </tr>
                 
                                         <tr>
                                            <td class="tdLabel">
                                                PO Status
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
                                                 Share Date 
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
                               <td colspan="3" style="padding-top:20px; padding-bottom:20px;">
                                   <table>
                                       <tr>
                                           <td style="width:50px" class="tdLabel">
                                               User :
                                           </td>
                                           <td style="width:50px">
                                               <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="50px" runat="server" >
                                                </telerik:RadTextBox>
                                           </td>
                                           <td style="width:80px; padding-left:15px" class="tdLabel">
                                               Last Update :
                                           </td>
                                           <td style="width:70px;">
                                               <telerik:RadTextBox ReadOnly="true" ID="txt_lastUpdate" Width="140px" runat="server" >
                                                </telerik:RadTextBox>
                                           </td>
                                           <td style="width:70px;padding-left:15px" class="tdLabel">
                                               Sub Total :
                                           </td>
                                           <td>
                                               <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_sub_total" Width="130px" 
                                                runat="server" ></telerik:RadNumericTextBox>
                                           </td>
                                           <td style="width:50px; padding-left:15px" class="tdLabel">
                                               Tax 2 :
                                           </td>
                                           <td>
                                               <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_tax2_value" Width="130px" 
                                                   runat="server" ></telerik:RadNumericTextBox>
                                           </td>
                                           <td style="width:60px; padding-left:15px" class="tdLabel">
                                               Other :
                                           </td>
                                           <td style="width:70px">
                                               <telerik:RadNumericTextBox  ReadOnly="true" EnabledStyle-HorizontalAlign="Right" ID="txt_other_value" Width="150px"
                                                  runat="server" ></telerik:RadNumericTextBox>
                                           </td>
                                       </tr>

                                       <tr>
                                           <td class="tdLabel">
                                               Owner :
                                           </td>
                                           <td>
                                               <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="50px" runat="server" >
                                                </telerik:RadTextBox>
                                           </td>
                                           <td style="padding-left:15px" class="tdLabel">
                                               Printed :
                                           </td>
                                           <td>
                                               <telerik:RadTextBox ReadOnly="true" ID="txt_printed" Width="40px" runat="server" >
                                               </telerik:RadTextBox>
                                               &nbsp
                                               Edited
                                               &nbsp
                                               <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" runat="server" >
                                               </telerik:RadTextBox>
                                           </td>
                                           <td style="padding-left:15px" class="tdLabel">
                                               Tax 1 :
                                           </td>
                                           <td>
                                               <telerik:RadNumericTextBox  ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_tax1_value" Width="130px"
                                                   runat="server" ></telerik:RadNumericTextBox>
                                           </td>
                                           <td style="padding-left:15px" class="tdLabel">
                                               Tax 3 :
                                           </td>
                                           <td>
                                               <telerik:RadNumericTextBox  ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_tax3_value" Width="130px" 
                                                   runat="server" ></telerik:RadNumericTextBox>
                                           </td>
                                           <td style="padding-left:15px" class="tdLabel">
                                               Total :
                                           </td>
                                           <td>
                                               <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_total" Width="150px" runat="server" >
                                                </telerik:RadNumericTextBox>
                                           </td>
                                       </tr>
                                   </table>
                               </td>
                           </tr>   
                        </table>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel14" runat="server">
                    <ContentTemplate>
                    <div>                        
                        <table>
                            <tr>
                                <td style="text-align: right">
                                     <asp:CheckBox ID="chk_lock_detail" runat="server" AutoPostBack="false" Text="Lock detail transaction" OnCheckedChanged="chk_lock_detail_CheckedChanged"/>
                                </td>
                            </tr>
                            <tr>
                                <td>         
                                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" runat="server" 
                                        PageSize="5" AllowPaging="true" Height="260px" Font-Names="Calibri"
                                        AllowAutomaticUpdates="True" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" 
                                        ShowFooter="false" Width="1050px" AutoGenerateColumns="False" Skin="MetroTouch">   
                                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="Prod_code" Font-Size="12px" EditMode="Batch"
                                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >
                                            <BatchEditingSettings EditType="Cell" HighlightDeletedRows="true" />                                              
                                            <CommandItemSettings ShowRefreshButton="false" />                                        
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="prod_type" HeaderStyle-Width="15px" HeaderText="Type" SortExpression="prod_type"
                                                    UniqueName="prod_type" ItemStyle-HorizontalAlign="Center">
                                                    <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                                        <RequiredFieldValidator ForeColor="Red" Text="*This field is required" Display="Dynamic">
                                                        </RequiredFieldValidator>
                                                    </ColumnValidationSettings>
                                                    <HeaderStyle Width="15px" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="Prod_code" HeaderText="Material Code" HeaderStyle-Width="100px" UniqueName="Prod_code" 
                                                    ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <%# Eval("Prod_code") %>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadDropDownList RenderMode="Lightweight" runat="server" ID="CategoryIDDropDown" DataValueField="prod_code"
                                                            DataTextField="prod_code" DataSourceID="SqlDataSource1">
                                                        </telerik:RadDropDownList>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="100px" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridNumericColumn DataField="qty" HeaderStyle-Width="40px" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"
                                                    SortExpression="qty" UniqueName="qty" DataFormatString="{0:#,###0.00;(#,###0.00);0}">
                                                    <HeaderStyle Width="40px" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </telerik:GridNumericColumn>
                                                <telerik:GridNumericColumn DataField="SatQty" HeaderStyle-Width="40px" HeaderText="UoM" ItemStyle-HorizontalAlign="Left"
                                                    SortExpression="SatQty" UniqueName="SatQty" ItemStyle-Width="30">
                                                    <HeaderStyle Width="40px" />
                                                    <ItemStyle HorizontalAlign="Left" Width="30px" />
                                                </telerik:GridNumericColumn>
                     
                                                <telerik:GridTemplateColumn DataField="harga" HeaderText="UnitPrice" HeaderStyle-Width="55px" SortExpression="harga" UniqueName="harga"
                                                    ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblUnitPrice" Text='<%# Eval("harga", "{0:#,###0.00;(#,###0.00);0}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <span>
                                                            <telerik:RadNumericTextBox RenderMode="Lightweight" Width="55px" runat="server" ID="tbUnitPrice">
                                                            </telerik:RadNumericTextBox>
                                                            <span style="color: Red">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                                                    ControlToValidate="tbUnitPrice" ErrorMessage="*Required" runat="server" Display="Dynamic">
                                                                </asp:RequiredFieldValidator>
                                                            </span>
                                                        </span>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="55px" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridButtonColumn ConfirmText="Delete this product?" ConfirmDialogType="RadWindow"
                                                    ConfirmTitle="Delete" HeaderText="Delete" HeaderStyle-Width="20px" 
                                                    CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                                    <HeaderStyle Width="20px" />
                                                </telerik:GridButtonColumn>
                                            </Columns>
                                        </MasterTableView>
                                        <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                                        <ClientSettings AllowKeyboardNavigation="true"></ClientSettings>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <FilterMenu RenderMode="Lightweight">
                                        </FilterMenu>
                                        <HeaderContextMenu RenderMode="Lightweight">
                                        </HeaderContextMenu>
                                    </telerik:RadGrid>
                                </td>
                            </tr>    
                            <tr>
                                <td>               
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConString %>"
                                        ProviderName="System.Data.SqlClient" SelectCommand="SELECT [prod_code], [spec] FROM [ms_product] WHERE stEdit != 4">
                                    </asp:SqlDataSource>    
                                </td>
                            </tr>
                        </table>
                        </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="RadGrid2" EventName="BatchEditCommand">
                            </asp:AsyncPostBackTrigger>
                             <asp:AsyncPostBackTrigger ControlID="cb_reff" EventName="SelectedIndexChanged">
                            </asp:AsyncPostBackTrigger>
                        </Triggers>
                    </asp:UpdatePanel>     
                    
                </asp:Panel>  
            </div>
          
    </div>
    </form>
</body>
</html>
