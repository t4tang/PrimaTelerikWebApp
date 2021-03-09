﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="acc01h13EditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.InvoiceIncoming.acc01h13EditForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
     <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type ="text/javascript" >  
        
            function Select(index) {
                   var grid = $find("<%= RadGrid2.ClientID %>");
                   grid.MasterTableView.get_dataItems()[index].set_selected(true);
            }

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
    </telerik:RadCodeBlock>
    <style type="text/css">
       .lbObject
         {
             color:teal;
             font-size:12px;
             font-weight:normal;
             font-family: Segoe UI, Tahoma, Geneva, 'Verdana', sans-serif;         
         }

       .lblEditInfo
       {
         font-size:11px;
         color:black;
         font-style:italic;
         /*background-color:greenyellow;*/
         font-family: Segoe UI, Tahoma, Geneva, 'Verdana', sans-serif;
       }
   </style>
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
                <telerik:AjaxUpdatedControl ControlID="txt_po_date" />
            </UpdatedControls>                
        </telerik:AjaxSetting>  
        <telerik:AjaxSetting AjaxControlID="cb_supplier">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cb_tax1"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_tax2"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_tax3"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_curr"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_kurs"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_tax_kurs"></telerik:AjaxUpdatedControl>
            </UpdatedControls>                
        </telerik:AjaxSetting>  
        <telerik:AjaxSetting AjaxControlID="RadGrid2">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadGrid1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>                
        </telerik:AjaxSetting>
          
        <telerik:AjaxSetting AjaxControlID="cb_from_type">
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
    <div style="overflow-x:auto; width:1500px">
        <div style="padding: 10px 5px 3px 15px;" class="lbObject">
            <table id="Table1" border="0" style="border-collapse: collapse; padding-top:5px; padding-left:15px; 
                padding-right:15px; padding-bottom:0px; font-size:smaller ">    
                <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module">
                            <tr>
                                <td colspan="2" style="padding:0px 0px 5px 5px">
                                    <asp:ImageButton runat="server" ID="btnSave" AlternateText="New" OnClick="btn_save_Click" ToolTip="Save" Visible="true"
                                    Height="30px" Width="32px" ImageUrl="~/Images/simpan.png"></asp:ImageButton>
                                &nbsp;
                                    <%--<telerik:RadButton ID="btnJournal" runat="server" Text="Journal" ForeColor="YellowGreen" BackColor="WhiteSmoke" Width="80px" Height="28px"
                                     OnClick="btnJournal_Click" Skin="Material"></telerik:RadButton>--%>
                                </td>
                            </tr>                
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Reg Number" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_reg_code" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
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
                                    <telerik:RadLabel runat="server" Text="Reg Date" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_reg"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
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
                                    <telerik:RadLabel runat="server" Text="From" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_from_type" runat="server" Width="150" AutoPostBack="true"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Skin="Telerik" 
                                                OnSelectedIndexChanged="cb_from_type_SelectedIndexChanged" OnItemsRequested="cb_from_type_ItemsRequested"
                                                OnPreRender="cb_from_type_PreRender">
                                            </telerik:RadComboBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Invoice No" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_inv_no" Width="250px" runat="server" ReadOnly="false" RenderMode="Lightweight" 
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
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Invoice Date" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_inv" runat="server" MinDate="1/1/1900" Width="150px"
                                        TabIndex="4" Skin="Telerik" >
                                        <Calendar runat="server"  UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput  runat="server"  TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"> 
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Tax Invoice" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel15" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_inv_code" Width="250px" runat="server" ReadOnly="false" RenderMode="Lightweight" 
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
                                    <telerik:RadLabel runat="server" Text="Project" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="250"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                        OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged" Font-Size="Small"
                                        OnPreRender="cb_project_PreRender">
                                    </telerik:RadComboBox>               
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
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="250px"
                                        EnableLoadOnDemand="true" ShowMoreResultsBox="true" AutoPostBack="true" Skin="Telerik" CausesValidation="false"
                                        OnItemsRequested="cb_supplier_ItemsRequested" OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" >
                                    </telerik:RadComboBox>
                                       
                                </td>
                            </tr>
                
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Ref Number" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                     <telerik:RadComboBox RenderMode="Lightweight" ID="cb_reff" runat="server" Width="250px"
                                         AutoPostBack="true" CausesValidation="false"
                                                DropDownWidth="900px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="po_code" DataValueField="po_code"                                                 
                                            OnSelectedIndexChanged="cb_reff_SelectedIndexChanged"
                                         OnItemsRequested="cb_reff_ItemsRequested"
                                            OnDataBound="cb_reff_DataBound">
                                            <HeaderTemplate>
                                                <table style="width: 600px">
                                                    <tr>
                                                        <td style="width: 140px;">
                                                            PO Number
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
                                                            <%# DataBinder.Eval(Container, "DataItem.po_code")%>
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
                                                OnItemsRequested="cb_cost_center_ItemsRequested" 
                                                OnSelectedIndexChanged="cb_cost_center_SelectedIndexChanged"
                                                OnPreRender="cb_cost_center_PreRender">
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
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged" />
                                        </Triggers>          
                                    </asp:UpdatePanel>                                                
                                </td>
                            </tr>
                            <tr>
                            <td class="tdLabel">
                                <telerik:RadLabel runat="server" Text="Kurs" CssClass="lbObject"></telerik:RadLabel>
                            </td>
                            <td style="vertical-align:top; text-align:left">
                                <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadNumericTextBox ID="txt_kurs" runat="server" Enabled="false" Width="100px" ReadOnly="true" RenderMode="Lightweight" 
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
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged" />
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
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged" />
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
                                                
                      </table>           
                    </td>
                    <td style="padding-left=15px" >
                        <table id="Table4" border="0" class="module">
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
                                                OnPreRender="cb_prepared_PreRender">
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
                                <td colspan="2">
                                    
                                    <asp:CheckBox ID="cb_posting" runat="server" AutoPostBack="false" Text="Posting"/>
                                   
                                </td>
                     
                            </tr>
                            <tr>
                                
                                <td class="tdLabel" style="padding-top:15px">
                                    <telerik:RadLabel runat="server" Text="Sub Total" CssClass="lbObject" Width="40px"></telerik:RadLabel>
                                </td>
                                <td style="padding-top:15px">
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_sub_total" Width="130px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                        runat="server" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" BackColor="WhiteSmoke"
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
                                    <telerik:RadLabel runat="server" Text="Tax 1" CssClass="lbObject" Width="40px"></telerik:RadLabel>
                                </td>
                                <td>
                                     <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                        <telerik:RadNumericTextBox  ReadOnly="true" runat="server" ID="txt_tax1_value" Width="130px" EnabledStyle-HorizontalAlign="Right"  NumberFormat-AllowRounding="true"
                                        onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  BackColor="WhiteSmoke"
                                         MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" Skin="Telerik"  >
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
                                    <telerik:RadLabel runat="server" Text="Tax 2" CssClass="lbObject" Width="40px"></telerik:RadLabel>
                                </td>
                                <td>
                                     <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                        <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_tax2_value" Width="130px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                        runat="server" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  BackColor="WhiteSmoke"
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
                                    <telerik:RadLabel runat="server" Text="Tax 3" CssClass="lbObject" Width="40px"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                        <telerik:RadNumericTextBox  ReadOnly="true" runat="server"  ID="txt_tax3_value" Width="130px" EnabledStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                        onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  BackColor="WhiteSmoke"
                                         MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" Skin="Telerik"  >
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
                                    <telerik:RadLabel runat="server" Text="Other" CssClass="lbObject" Width="40px"></telerik:RadLabel>
                                </td>
                                <td style="width:70px">
                                     <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                       <telerik:RadNumericTextBox  ReadOnly="true" EnabledStyle-HorizontalAlign="Right" ID="txt_other_value"  Width="130px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                        runat="server" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" BackColor="WhiteSmoke"
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
                                    <telerik:RadLabel runat="server" Text="Total" CssClass="lbObject" Width="40px"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                        <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_total" Width="130px" runat="server" 
                                            ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                            onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" BackColor="WhiteSmoke"
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
                    <td style="padding-left:15px" >
                        <table id="Table4" border="0" class="module">
                            
                            <tr>
                                <td colspan="2" > 
                                    <telerik:RadLabel runat="server" ID="lbl_userId" Width="100px" Text="User: " CssClass="lblEditInfo" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadLabel runat="server" ID="lbl_lastUpdate" Width="220px" Text="Last Update: " CssClass="lblEditInfo"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"> 
                                    <telerik:RadLabel runat="server" ID="lbl_Owner" Width="100px" Text="Owner: " CssClass="lblEditInfo"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadLabel runat="server" ID="lbl_edited" Width="100px" Text="Edited: " CssClass="lblEditInfo"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>    
                <tr>
                    <td colspan="3" style="padding-top:5px; padding-bottom:0px; "">
                        <table>
                            

                        </table>
                    </td>
                </tr>   
            </table>
        </div>
        <div style="padding: 5px 15px 15px 15px; min-height:360px">
           <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop"
            SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Silk" CausesValidation="false">
                <Tabs>
                    <telerik:RadTab Text="Detail" Height="10px" Width="100px" >
                    </telerik:RadTab>
                    <telerik:RadTab Text="Journal" Height="10px" Width="100px"> 
                    </telerik:RadTab>            
                </Tabs>
            </telerik:RadTabStrip>
             <telerik:RadMultiPage runat="server" SelectedIndex="0" ID="RadMultiPage1" >
                <telerik:RadPageView runat="server" ID="PageView1" > 
                   <div style="padding: 10px 10px 5px 10px; overflow-x:auto; width:1430px; height:310px; overflow:auto">                               
                        <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Always">
                        <ContentTemplate>
                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AllowPaging="true" PageSize="5" runat="server" Skin="Silk" CssClass="RadGrid_ModernBrowsers" 
                                HeaderStyle-Font-Size="10px" HeaderStyle-Font-Bold="true" ItemStyle-Font-Size="small" Font-Size="10px" Font-Names="Segoe UI" CellSpacing="0" 
                                OnNeedDataSource="RadGrid2_NeedDataSource" 
                                OnPreRender="RadGrid2_PreRender"  
                                OnItemDataBound="RadGrid2_ItemDataBound"
                                OnItemCommand="RadGrid2_ItemCommand" 
                                OnUpdateCommand="RadGrid2_UpdateCommand"
                                OnInsertCommand="RadGrid2_InsertCommand" >
                                <PagerStyle Mode="NumericPages" PageButtonCount="4" />
                                <HeaderStyle Font-Bold="false" ForeColor="#0083ae"/>
                                <AlternatingItemStyle Font-Size="10px" />
                                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="Prod_code" EditMode="InPlace"
                                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >
                                <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="False" ShowCancelChangesButton="false" />
                                <CommandItemTemplate>
                                <div style="padding: 5px 5px;">
                                    <asp:LinkButton ID="LinkButton1" runat="server" CommandName="InitInsert" Enabled="false" >
                                        <img style="border:0px;vertical-align:middle; width:22px; height:22px; padding-right:5px"  alt="" 
                                            src="../../../Images/add-new.png"/>Add new</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelAll" Visible='<%# RadGrid2.EditIndexes.Count > 0 || RadGrid2.MasterTableView.IsItemInserted %>'>
                                        <img style="border:0px;vertical-align:middle;width:20px; height:22px;" alt="" 
                                            src="../../../Images/Undo.png"/>Cancel</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <%--<asp:LinkButton ID="LinkButton2" runat="server" CommandName="PerformInsert" Visible='<%# RadGrid2.MasterTableView.IsItemInserted %>'>
                                        <img style="border:0px;vertical-align:middle; width:20px; height:22px; padding-right:5px"  alt="" 
                                            src="../../../Images/simpan.png"/>save</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;--%>
                                    <asp:LinkButton ID="LinkButton3" OnClientClick="javascript:return confirm('Delete selected item?')" Enabled="false" 
                                        runat="server" CommandName="DeleteSelected"><img style="border:0px;vertical-align:middle; width:22px; height:22px; padding-right:5px" alt="" 
                                            src="../../../Images/error.png"/>Delete Item</asp:LinkButton>
                                </div>
                                </CommandItemTemplate>
                                    <Columns>
                                    <telerik:GridEditCommandColumn>
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridTemplateColumn UniqueName="select" HeaderStyle-Width="30px" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chk_select" OnCheckedChanged="chk_select_CheckedChanged" Checked="true" Width="30px" AutoPostBack="true" />
                                        </ItemTemplate>                                        
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn UniqueName="prod_type" HeaderText="Type" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="40px" 
                                        ItemStyle-HorizontalAlign="Left"  ItemStyle-Width="40px" >
                                        <ItemTemplate>  
                                            <Telerik:RadLabel runat="server" ID="lblProdType" Width="40px" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></Telerik:RadLabel>
                                        </ItemTemplate>                     
                                        <InsertItemTemplate>
                                            <Telerik:RadLabel runat="server" ID="lblProdTypeInsert" Width="40px" ></Telerik:RadLabel>
                                        </InsertItemTemplate> 
                                        <EditItemTemplate>
                                            <Telerik:RadLabel runat="server" ID="lblProdTypeEdit" Width="40px" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></Telerik:RadLabel>
                                        </EditItemTemplate>                  
                                    </telerik:GridTemplateColumn>  
                                    <telerik:GridTemplateColumn UniqueName="prod_code" HeaderText="Prod. Code" HeaderStyle-Width="100px"
                                        SortExpression="prod_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Left">
                                        <FooterTemplate>Template footer</FooterTemplate>
                                        <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                        <ItemTemplate>                                               
                                            <telerik:RadLabel runat="server" ID="lblProdCode" Width="85px" Text='<%# DataBinder.Eval(Container.DataItem, "Prod_code") %>'></telerik:RadLabel>
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_insertTemp" EnableLoadOnDemand="True" DataTextField="spec"
                                                DataValueField="prod_code" AutoPostBack="true"
                                                HighlightTemplatedItems="true" Height="190px" Width="130px" DropDownWidth="1350px"
                                                OnItemsRequested="cb_prod_code_insertTemp_ItemsRequested" 
                                                OnSelectedIndexChanged="cb_prod_code_insertTemp_SelectedIndexChanged" >                                                   
                                                <HeaderTemplate>
                                                <table style="width: 1350px; font-size:10px">
                                                    <tr>     
                                                        <td style="width: 120px;">
                                                            Prod. Code
                                                        </td>
                                                        <td style="width: 250px;">
                                                            Prod. Name
                                                        </td>
                                                        <td style="width: 50px;">
                                                            Qty
                                                        </td>
                                                        <td style="width: 50px;">
                                                            UoM
                                                        </td>  
                                                        <td style="width: 90px;">
                                                            Price
                                                        </td>    
                                                        <td style="width: 50px;">
                                                            disc
                                                        </td>   
                                                        <td style="width: 110px;">
                                                            GI Number
                                                        </td>   
                                                        <td style="width: 100px;">
                                                            Date
                                                        </td>   
                                                        <td style="width: 150px;">
                                                            Info Record
                                                        </td>     
                                                        <td style="width: 50px;">
                                                            Cost Ctr
                                                        </td>                                                        
                                                    </tr>
                                                </table>                                                       
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 1350px; font-size:10px; font-family:'Segoe UI'">
                                                    <tr>       
                                                        <td style="width: 120px;">
                                                            <%# DataBinder.Eval(Container, "Value")%>
                                                        </td>
                                                        <td style="width: 350px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['prod_spec']")%>
                                                        </td> 
                                                        <td style="width: 50px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['qty_out']")%>
                                                        </td> 
                                                        <td style="width: 50px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['unit_code']")%>
                                                        </td>
                                                        <td style="width: 90px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['price']")%>
                                                        </td>
                                                        <td style="width: 50px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['disc']")%>
                                                        </td>
                                                        <td style="width: 110px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['do_code']")%>
                                                        </td>
                                                        <td style="width: 100px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['Tgl']")%>
                                                        </td>
                                                        <td style="width: 150px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['info_code']")%>
                                                        </td>                     
                                                        <td style="width: 50px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['dept_code']")%>
                                                        </td>                                                                                 
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </InsertItemTemplate>                                            
                                        <EditItemTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_editTemp" EnableLoadOnDemand="True" DataTextField="spec"
                                                DataValueField="prod_code" AutoPostBack="true" Text='<%# DataBinder.Eval(Container.DataItem, "Prod_code") %>' 
                                                HighlightTemplatedItems="true" Height="190px" Width="130px" DropDownWidth="1350px"
                                                OnItemsRequested="cb_prod_code_insertTemp_ItemsRequested" 
                                                OnSelectedIndexChanged="cb_prod_code_editTemp_SelectedIndexChanged" >                                                   
                                                <HeaderTemplate>
                                                <table style="width: 1350px; font-size:10px">
                                                    <tr>     
                                                        <td style="width: 120px;">
                                                            Prod. Code
                                                        </td>
                                                        <td style="width: 250px;">
                                                            Prod. Name
                                                        </td>
                                                        <td style="width: 50px;">
                                                            Qty
                                                        </td>
                                                        <td style="width: 50px;">
                                                            UoM
                                                        </td>  
                                                        <td style="width: 90px;">
                                                            Price
                                                        </td>    
                                                        <td style="width: 50px;">
                                                            disc
                                                        </td>   
                                                        <td style="width: 110px;">
                                                            GI Number
                                                        </td>   
                                                        <td style="width: 100px;">
                                                            Date
                                                        </td>   
                                                        <td style="width: 150px;">
                                                            Info Record
                                                        </td>     
                                                        <td style="width: 50px;">
                                                            Cost Ctr
                                                        </td>                                                        
                                                    </tr>
                                                </table>                                                       
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 1350px; font-size:10px; font-family:'Segoe UI'">
                                                    <tr>       
                                                        <td style="width: 120px;">
                                                            <%# DataBinder.Eval(Container, "Value")%>
                                                        </td>
                                                        <td style="width: 350px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['prod_spec']")%>
                                                        </td> 
                                                        <td style="width: 50px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['qty_out']")%>
                                                        </td> 
                                                        <td style="width: 50px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['unit_code']")%>
                                                        </td>
                                                        <td style="width: 90px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['price']")%>
                                                        </td>
                                                        <td style="width: 50px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['disc']")%>
                                                        </td>
                                                        <td style="width: 110px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['do_code']")%>
                                                        </td>
                                                        <td style="width: 100px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['Tgl']")%>
                                                        </td>
                                                        <td style="width: 150px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['info_code']")%>
                                                        </td>                     
                                                        <td style="width: 50px;">
                                                            <%# DataBinder.Eval(Container, "Attributes['dept_code']")%>
                                                        </td>                                                                                 
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>    
                                    </telerik:GridTemplateColumn>                                                            
                                    <telerik:GridTemplateColumn UniqueName="Qty" HeaderText="Qty" ItemStyle-Width="70px" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0" 
                                        HeaderStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <telerik:RadLabel runat="server" ID="lbl_qty" Width="55px" Text='<%# DataBinder.Eval(Container.DataItem, "qty","{0:#,###,###0.00}") %>'></telerik:RadLabel>  
                                            <%--<telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty" Width="55px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right" Skin="Silk"
                                                DbValue='<%# Convert.ToDouble(Eval("qty")) %>'
                                                onkeydown="blurTextBox(this, event)" ReadOnly="false"  BorderStyle="None"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2" 
                                                OnTextChanged="calculate_sub_price">
                                            </telerik:RadNumericTextBox>--%>
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty_insert" Width="55px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right" Skin="Silk"
                                                onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2" 
                                                OnTextChanged="calculate_sub_price_new">
                                            </telerik:RadNumericTextBox>
                                        </InsertItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty_edit" Width="55px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right" Skin="Silk"
                                                DbValue='<%# Convert.ToDouble(Eval("qty")) %>'
                                                onkeydown="blurTextBox(this, event)" ReadOnly="false"  BorderStyle="None"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2" 
                                                OnTextChanged="calculate_sub_price_edit">
                                            </telerik:RadNumericTextBox>
                                        </EditItemTemplate>    
                                    </telerik:GridTemplateColumn> 
                                    <telerik:GridTemplateColumn UniqueName="UoM" HeaderText="UoM" ItemStyle-Width="50px" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <telerik:RadLabel runat="server" Width="50px" ID="lbl_uom" Skin="Silk" Text='<%# DataBinder.Eval(Container, "DataItem.part_unit") %>'></telerik:RadLabel>  
                                              <%--  <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="150px" runat="server" ID="cb_uom_d" Skin="Silk"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.SatQty") %>' Width="70px"
                                                EnableLoadOnDemand="True" DataTextField="part_unit" DataValueField="part_unit" >
                                            </telerik:RadComboBox>--%>
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <Telerik:RadLabel runat="server" ID="lblUomInsert" Width="70px" Skin="Silk" ></Telerik:RadLabel>
                                        </InsertItemTemplate> 
                                        <EditItemTemplate>
                                            <telerik:RadLabel runat="server" Width="70px" ID="lblUomEdit" Skin="Silk" Text='<%# DataBinder.Eval(Container, "DataItem.part_unit") %>'></telerik:RadLabel> 
                                        </EditItemTemplate>    
                                    </telerik:GridTemplateColumn>                   
                                    <telerik:GridTemplateColumn UniqueName="harga" DataField="harga" HeaderText="Harga" HeaderStyle-Width="110px" ItemStyle-Width="110px"
                                        ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>          
                                                <telerik:RadLabel runat="server" Width="100px" ID="lbl_harga" Skin="Silk" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.harga","{0:#,###,###0.00}") %>'></telerik:RadLabel>                                
                                                <%--<telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_harga" Width="125px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right" Skin="Silk"
                                                    DbValue='<%# Convert.ToDouble(Eval("harga")) %>'
                                                    onkeydown="blurTextBox(this, event)" 
                                                    AutoPostBack="true" MaxLength="20" Type="Number" EnabledStyle-HorizontalAlign="Right" BorderStyle="None"
                                                    NumberFormat-DecimalDigits="2" 
                                                    OnTextChanged="calculate_sub_price" >
                                                </telerik:RadNumericTextBox>--%>
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_hargaInsert" Width="125px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right" Skin="Silk"
                                                    onkeydown="blurTextBox(this, event)" 
                                                    AutoPostBack="true" MaxLength="20" Type="Number" EnabledStyle-HorizontalAlign="Right"
                                                    NumberFormat-DecimalDigits="2" 
                                                    OnTextChanged="calculate_sub_price_new" >
                                                </telerik:RadNumericTextBox>
                                        </InsertItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_hargaEdit" Width="125px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right" Skin="Silk"
                                                    DbValue='<%# Convert.ToDouble(Eval("harga")) %>'
                                                    onkeydown="blurTextBox(this, event)" 
                                                    AutoPostBack="true" MaxLength="20" Type="Number" EnabledStyle-HorizontalAlign="Right" BorderStyle="None"
                                                    NumberFormat-DecimalDigits="2" 
                                                    OnTextChanged="calculate_sub_price_edit" >
                                                </telerik:RadNumericTextBox>
                                        </EditItemTemplate>    
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn UniqueName="Disc" HeaderText="Disc. %" ItemStyle-Width="70px" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0"
                                        HeaderStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>  
                                            <telerik:RadLabel runat="server" Width="55px" ID="lbl_disc" Skin="Silk" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Disc","{0:#,###,###0.00}") %>'></telerik:RadLabel>   
                                            <%--<telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_disc" Width="55px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right" Skin="Silk"
                                                DbValue='<%# Convert.ToDouble(Eval("Disc")) %>' 
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"  BorderStyle="None"
                                                NumberFormat-DecimalDigits="2" 
                                                OnTextChanged="calculate_sub_price">
                                            </telerik:RadNumericTextBox>--%>
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_discInsert" Width="55px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right" Skin="Silk"
                                                    onkeydown="blurTextBox(this, event)" 
                                                    AutoPostBack="true" MaxLength="20" Type="Number" EnabledStyle-HorizontalAlign="Right"
                                                    NumberFormat-DecimalDigits="2" 
                                                    OnTextChanged="calculate_sub_price_new" >
                                                </telerik:RadNumericTextBox>
                                        </InsertItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_discEdit" Width="55px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right" Skin="Silk"
                                                DbValue='<%# Convert.ToDouble(Eval("Disc")) %>' 
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"  BorderStyle="None"
                                                NumberFormat-DecimalDigits="2" 
                                                OnTextChanged="calculate_sub_price_edit">
                                            </telerik:RadNumericTextBox>
                                        </EditItemTemplate>    
                                    </telerik:GridTemplateColumn>                                 
                                    <telerik:GridTemplateColumn UniqueName="sub_price" HeaderText="Sub Price" ItemStyle-Width="110px" HeaderStyle-Width="110px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0"
                                        HeaderStyle-HorizontalAlign="Center"  >
                                        <ItemTemplate>
                                            <telerik:RadLabel runat="server" Width="105px" ID="lbl_sub_price" Skin="Silk" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.jumlah","{0:#,###,###0.00}") %>'></telerik:RadLabel>   
                                           <%-- <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_sub_price" Width="135px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right" Skin="Silk"
                                                DbValue='<%# Convert.ToDouble(Eval("jumlah")) %>' 
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right" ReadOnly="true" BorderStyle="None"
                                                NumberFormat-DecimalDigits="2">
                                            </telerik:RadNumericTextBox>--%>
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <Telerik:RadNumericTextBox runat="server" ID="txt_sub_priceInsert" Width="135px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right" Skin="Silk"
                                                onkeydown="blurTextBox(this, event)"
                                                MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right" ReadOnly="true"
                                                NumberFormat-DecimalDigits="2" ></Telerik:RadNumericTextBox>
                                        </InsertItemTemplate> 
                                        <EditItemTemplate>
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_sub_priceEdit" Width="135px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right" Skin="Silk"
                                                DbValue='<%# Convert.ToDouble(Eval("jumlah")) %>' 
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right" ReadOnly="true" BorderStyle="None"
                                                NumberFormat-DecimalDigits="2">
                                            </telerik:RadNumericTextBox>
                                        </EditItemTemplate>    
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn UniqueName="factor" HeaderText="Other Cost" ItemStyle-Width="80px" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                                        <ItemTemplate>  
                                            <telerik:RadLabel runat="server" Width="65px" ID="lbl_factor" Skin="Silk" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.factor","{0:#,###,###0.00}") %>'></telerik:RadLabel>  
                                            <%--<telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_factor" Width="65px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right" Skin="Silk"
                                                DbValue='<%# Convert.ToDouble(Eval("factor")) %>' 
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right" BorderStyle="None"
                                                NumberFormat-DecimalDigits="2"  
                                                OnTextChanged="calculate_sub_price">
                                            </telerik:RadNumericTextBox>--%>
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <Telerik:RadNumericTextBox runat="server" ID="txt_factorInsert" Width="65px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right" Skin="Silk"
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"
                                                NumberFormat-DecimalDigits="2" OnTextChanged="calculate_sub_price_new" ></Telerik:RadNumericTextBox>
                                        </InsertItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_factorEdit" Width="65px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right" Skin="Silk"
                                                DbValue='<%# Convert.ToDouble(Eval("factor")) %>' 
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right" BorderStyle="None"
                                                NumberFormat-DecimalDigits="2"  
                                                OnTextChanged="calculate_sub_price_edit">
                                            </telerik:RadNumericTextBox>
                                        </EditItemTemplate>    
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn UniqueName="tTax" HeaderText="Tax 1" HeaderStyle-Width="40px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" 
                                                HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkTax1" OnCheckedChanged="edt_chkTax1_CheckedChanged" OnPreRender="edt_chkTax1_PreRender" Width="30px"
                                                Checked='<%# DataBinder.Eval(Container.DataItem, "tTax") %>' AutoPostBack="true" />
                                        </ItemTemplate> 
                                        <InsertItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkTax1Insert" OnCheckedChanged="edt_chkTax1_CheckedChanged" OnPreRender="edt_chkTax1_PreRender" Width="30px"
                                                AutoPostBack="true" />
                                        </InsertItemTemplate>    
                                        <EditItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkTax1Edit" OnCheckedChanged="edt_chkTax1_CheckedChanged" OnPreRender="edt_chkTax1_PreRender" Width="30px"
                                                Checked='<%# DataBinder.Eval(Container.DataItem, "tTax") %>' AutoPostBack="true" />
                                        </EditItemTemplate>                                       
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn UniqueName="tOtax" HeaderText="Tax 2" HeaderStyle-Width="40px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                                            HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkOTax" OnCheckedChanged="edt_chkOTax_CheckedChanged" OnPreRender="edt_chkOTax_PreRender"  Width="30px"
                                                Checked='<%# DataBinder.Eval(Container.DataItem, "tOtax") %>' AutoPostBack="true" />
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkOTaxInsert" OnCheckedChanged="edt_chkOTax_CheckedChanged" OnPreRender="edt_chkOTax_PreRender" Width="30px"
                                                AutoPostBack="true" />
                                        </InsertItemTemplate>     
                                        <EditItemTemplate>
                                             <asp:CheckBox runat="server" ID="chkOTaxEdit" OnCheckedChanged="edt_chkOTax_CheckedChanged" OnPreRender="edt_chkOTax_PreRender"  Width="30px"
                                                Checked='<%# DataBinder.Eval(Container.DataItem, "tOtax") %>' AutoPostBack="true" />
                                        </EditItemTemplate>                                        
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn UniqueName="tpph" HeaderText="Tax 3" HeaderStyle-Width="40px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                                                HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkTpph" OnCheckedChanged="edt_chkTpph_CheckedChanged" OnPreRender="edt_chkTpph_PreRender" Width="30px"
                                                Checked='<%# DataBinder.Eval(Container.DataItem, "tpph") %>'  AutoPostBack="true" />
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkTpphInsert" OnCheckedChanged="edt_chkTpph_CheckedChanged" OnPreRender="edt_chkTpph_PreRender" Width="30px"
                                                AutoPostBack="true" />
                                        </InsertItemTemplate>     
                                        <EditItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkTpphEdit" OnCheckedChanged="edt_chkTpph_CheckedChanged" OnPreRender="edt_chkTpph_PreRender" Width="30px"
                                                Checked='<%# DataBinder.Eval(Container.DataItem, "tpph") %>'  AutoPostBack="true" />
                                        </EditItemTemplate>                                         
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn UniqueName="dept_code" DataField="dept_code" HeaderText="Cost Ctr" HeaderStyle-Width="75px" ItemStyle-Width="75px" SortExpression="dept_code"
                                        ItemStyle-HorizontalAlign="Left"  >
                                        <ItemTemplate>  
                                            <telerik:RadLabel runat="server" ID="lbl_cost_ctr" Width="60px" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'>
                                            </telerik:RadLabel>
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <telerik:RadLabel runat="server" ID="lbl_cost_ctrInsert" Width="60px"></telerik:RadLabel>                                            
                                        </InsertItemTemplate>  
                                        <EditItemTemplate>
                                            <telerik:RadLabel runat="server" ID="lbl_cost_ctrEdit" Width="60px" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'>
                                            </telerik:RadLabel>
                                        </EditItemTemplate>    
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn UniqueName="ref_date" HeaderText="Ctrl. Date" HeaderStyle-Width="115px"  ItemStyle-Width="115px" ItemStyle-HorizontalAlign="Center"
                                        HeaderStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <telerik:RadDatePicker runat="server" ID="dtpSroDate" Width="110px" DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.ref_date")%>' 
                                                DateInput-Enabled="false" onkeydown="blurTextBox(this, event)" Type="Date" Skin="Silk">
                                                <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                            </telerik:RadDatePicker>
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <telerik:RadDatePicker runat="server" ID="dtpSroDateInsert" Width="110px" onkeydown="blurTextBox(this, event)" Type="Date" Skin="Silk">
                                                <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                            </telerik:RadDatePicker>
                                        </InsertItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadDatePicker runat="server" ID="dtpSroDateEdit" Width="110px" DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.ref_date")%>' 
                                                DateInput-Enabled="false" onkeydown="blurTextBox(this, event)" Type="Date" Skin="Silk">
                                                <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                            </telerik:RadDatePicker>
                                        </EditItemTemplate>    
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn UniqueName="remark" HeaderText="Remark" ItemStyle-Width="250px" HeaderStyle-Width="250px" Visible="true"
                                        HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%--<telerik:RadLabel runat="server" TextWrap="True" ID="lblRemark_d" Width="150px" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'>
                                            </telerik:RadLabel>--%>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="250px" Skin="Silk" BorderStyle="None" ReadOnly="true"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                            </telerik:RadTextBox>
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d_Insert" Width="250px" Skin="Silk" >
                                            </telerik:RadTextBox>
                                        </InsertItemTemplate>
                                        <EditItemTemplate>                                            
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d_Edit" Width="250px" Skin="Silk" 
                                                Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>    
                                    </telerik:GridTemplateColumn>

                                </Columns>
                                </MasterTableView>
                                <ClientSettings>
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="225px" />
                                    <Selecting AllowRowSelect="true"></Selecting>                    
                                </ClientSettings>
                            </telerik:RadGrid>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="cb_tax1" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="cb_tax2" EventName="SelectedIndexChanged"/>
                            <asp:AsyncPostBackTrigger ControlID="cb_tax3" EventName="SelectedIndexChanged"/>
                        </Triggers>
                        </asp:UpdatePanel>
                   </div>
                </telerik:RadPageView>

                <telerik:RadPageView runat="server" ID="RadPageView1">
                    <div style="padding: 10px 10px 5px 10px;">  
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" PageSize="10" runat="server" Skin="Silk" CssClass="RadGrid_ModernBrowsers"   
                    HeaderStyle-Font-Size="Small" HeaderStyle-Font-Bold="true" ItemStyle-Font-Size="small" Font-Size="Small" Width="1200px"
                    Font-Names="Segoe UI" CellSpacing="0" 
                    OnNeedDataSource="RadGrid3_NeedDataSource"
                    OnPreRender="RadGrid3_PreRender" >
                    <HeaderStyle Font-Bold="true" />
                    <MasterTableView HeaderStyle-ForeColor="Teal"
                        HorizontalAlign="NotSet" AutoGenerateColumns="False">
                        <%--<SortExpressions>
                            <telerik:GridSortExpression FieldName="nomor" SortOrder="Descending" />
                        </SortExpressions>--%>
                        <ColumnGroups>
                            <telerik:GridColumnGroup Name="IDR" HeaderText="IDR"
                                HeaderStyle-HorizontalAlign="Center" />
                            <telerik:GridColumnGroup Name="Valas" HeaderText="Valas"
                                HeaderStyle-HorizontalAlign="Center" />
                        </ColumnGroups>
                        <Columns>
                            <telerik:GridBoundColumn DataField="accountcode" HeaderStyle-Width="100px" HeaderText="Account No." SortExpression="accountcode"
                                UniqueName="accountcode" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="70px" 
                                 >                                
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="accountname" HeaderStyle-Width="250px" HeaderText="Account Name" SortExpression="accountname"
                                UniqueName="accountname" ReadOnly="true" HeaderStyle-HorizontalAlign="Center"
                                 >                                
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="debet" HeaderStyle-Width="100px" HeaderText="Debet" SortExpression="debet"
                                UniqueName="debet" ReadOnly="true" HeaderStyle-HorizontalAlign="Center"  
                                DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#00CC00">                                
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="credit" HeaderStyle-Width="100px" HeaderText="Credit" SortExpression="credit"
                                UniqueName="credit" ReadOnly="true" HeaderStyle-HorizontalAlign="Center"  
                                DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#3399ff">                                
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="remark" HeaderStyle-Width="200px" HeaderText="Remark" SortExpression="remark"
                                UniqueName="remark" ReadOnly="true" HeaderStyle-HorizontalAlign="Center"  >
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings AllowKeyboardNavigation="true">
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="310px" />
                        <Selecting AllowRowSelect="true"></Selecting>     
                    </ClientSettings>
                </telerik:RadGrid>
                    </div>
                    
                </telerik:RadPageView>
            </telerik:RadMultiPage>
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
