<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="acc01h13EditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.PurchaseExpenses.acc01h13EditForm" %>

<!DOCTYPE html>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
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
            </UpdatedControls>
        </telerik:AjaxSetting>  
        <telerik:AjaxSetting AjaxControlID="cb_supplier">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cb_tax1"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_tax2"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_tax3"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_term" />
                <telerik:AjaxUpdatedControl ControlID="txt_term_days" />
            </UpdatedControls>                
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="RadGrid2">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadGrid2" />
            </UpdatedControls>
        </telerik:AjaxSetting>   
    </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="500" BackgroundPosition="None" >
    <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
    <div>
            <div style="padding: 15px 15px 10px 15px;" class="lbObject">
                <table id="Table2" width="Auto" border="0" class="module">
                    <tr style="vertical-align: top">                                
                        <td colspan="2" style="padding-bottom:10px">
                            <telerik:RadButton ID="btn_save" runat="server" Text="Save" BackColor="#ff6600" ForeColor="White" Width="80px" Height="28px"
                                Skin="Material" OnClick="btn_save_Click"></telerik:RadButton>
                        </td>                        
                    </tr>
                    <tr>
                        <td style="vertical-align:top; width:390px">
                            <table>
                                <tr style="vertical-align: top">                               
                                    <td  style="vertical-align: top">
                                        <telerik:RadLabel runat="server" Text="Reg No.:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txt_doc_code" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" EmptyMessage="Let it blank">
                                        </telerik:RadTextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td  style="vertical-align: top">
                                        <telerik:RadLabel runat="server" Text="Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker ID="dtp_purex" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                            TabIndex="4" Skin="Telerik">
                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;">
                                            </Calendar>
                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                                            </DateInput>
                                        </telerik:RadDatePicker>

                                    </td>
                                </tr>
                                <tr>
                                    <td  style="vertical-align: top">
                                        <telerik:RadLabel runat="server" Text="Ctrl No.:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td> 
                                        <telerik:RadTextBox ID="txt_ctrl_no" runat="server" Width="150px" ReadOnly="false" RenderMode="Lightweight"
                                            AutoPostBack="false">
                                        </telerik:RadTextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Invoice No. :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td> 
                                        <telerik:RadTextBox ID="txt_invoice_no" runat="server" Width="150px" ReadOnly="false" RenderMode="Lightweight"
                                            AutoPostBack="false">
                                        </telerik:RadTextBox>
                                        <asp:RequiredFieldValidator runat="server" ID="priorityValidator" ControlToValidate="txt_invoice_no" ForeColor="Red" 
                                            Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>                                      
                                    </td>
                                </tr>
                                <tr>
                                    <td  style="vertical-align: top">
                                        <telerik:RadLabel runat="server" Text="Invoice Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker ID="dtp_invoice_date" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                            TabIndex="4" Skin="Telerik">
                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;">
                                            </Calendar>
                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                                            </DateInput>
                                        </telerik:RadDatePicker>                                        
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="dtp_invoice_date" ForeColor="Red" 
                                            Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator> 
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Tax Invoice:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td> 
                                        <telerik:RadTextBox ID="txt_tax_invoice" runat="server" Width="150px" ReadOnly="false" RenderMode="Lightweight"
                                            AutoPostBack="false">
                                        </telerik:RadTextBox>                                     
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Project" CssClass="lbObject"></telerik:RadLabel>
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300"
                                            AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                            OnItemsRequested="cb_project_ItemsRequested" 
                                            OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                            OnPreRender="cb_project_PreRender">
                                        </telerik:RadComboBox>               
                                    </td>
                                </tr>
                                <tr >
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Cost Center" CssClass="lbObject"></telerik:RadLabel>
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cost_center" runat="server" Width="300px" DropDownWidth="300px" Skin="Telerik"
                                                    EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true" 
                                                    OnItemsRequested="cb_cost_center_ItemsRequested" 
                                                    OnSelectedIndexChanged="cb_cost_center_SelectedIndexChanged"
                                                    OnPreRender="cb_cost_center_PreRender">
                                                </telerik:RadComboBox>
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
                                        <telerik:RadLabel runat="server" Text="Supplier" CssClass="lbObject"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                            <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="300px"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" AutoPostBack="true"
                                                OnItemsRequested="cb_supplier_ItemsRequested" 
                                                OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged"
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
                                                </telerik:RadTextBox>
                                                &nbsp
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
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax1" runat="server" Width="150" Enabled="true" 
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" AutoPostBack="true" CausesValidation="false" 
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
                                                    OnItemsRequested="cb_tax2_ItemsRequested"
                                                    OnSelectedIndexChanged="cb_tax2_SelectedIndexChanged"
                                                    OnPreRender="cb_tax2_PreRender"
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
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax3" runat="server" Width="150" AutoPostBack="true"
                                                    EnableLoadOnDemand="true" ShowMoreResultsBox="true" 
                                                    OnItemsRequested="cb_tax3_ItemsRequested"
                                                    OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged"
                                                    OnPreRender="cb_tax3_PreRender"
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
                                        <telerik:RadLabel runat="server" Text="Term" CssClass="lbObject"></telerik:RadLabel>
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_term" runat="server" Width="120" ShowMoreResultsBox="true"
                                                    EnableVirtualScrolling="true" EnableLoadOnDemand="true" 
                                                    OnItemsRequested="cb_term_ItemsRequested"
                                                    OnSelectedIndexChanged="cb_term_SelectedIndexChanged"
                                                    OnPreRender="cb_term_PreRender" >
                                                </telerik:RadComboBox>                       
                                                &nbsp Days:
                                                <telerik:RadNumericTextBox ID="txt_term_days" Width="60px" 
                                                    runat="server" >
                                                </telerik:RadNumericTextBox> 
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>  
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Remark:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                    </td>
                                    <td> 
                                        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadTextBox ID="txt_remark"
                                                    runat="server" TextMode="MultiLine"
                                                    Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                                </telerik:RadTextBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="vertical-align:top">
                            <table>
                                <tr>
                                    <td style="vertical-align: top; text-align: left; ">
                                    <telerik:RadLabel CssClass="lbObject" runat="server" Text="Prepared By:" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td> 
                                    <asp:UpdatePanel ID="UpdatePanel14" runat="server">
                                    <ContentTemplate>
                                    <telerik:RadComboBox ID="cb_prepare_by" runat="server" Width="250px"
                                        DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                        OnItemsRequested="cb_prepare_by_ItemsRequested"
                                        OnSelectedIndexChanged="cb_prepare_by_SelectedIndexChanged" 
                                        OnPreRender="cb_prepare_by_PreRender">
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
                                    </telerik:RadComboBox>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                    </Triggers>
                                    </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top; text-align: left">
                                        <telerik:RadLabel runat="server" Text="Ack. By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td> 
                                    <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_checked" runat="server" Width="250px"
                                            DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                            OnItemsRequested="cb_checked_ItemsRequested"
                                            OnSelectedIndexChanged="cb_checked_SelectedIndexChanged"
                                            OnPreRender="cb_checked_PreRender">
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
                                        <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                    </Triggers>
                                    </asp:UpdatePanel>
                                    </td>                                                      
                                </tr>
                                <tr>
                                    <td style="vertical-align: top; text-align: left; ">
                                        <telerik:RadLabel CssClass="lbObject" runat="server" Text="Approved By:" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td> 
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px"
                                            DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true"
                                            OnItemsRequested="cb_approved_ItemsRequested"
                                            OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                            OnPreRender="cb_approved_PreRender" >
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
                                        <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                    </Triggers>
                                    </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <asp:CheckBox ID="cb_posted" runat="server" AutoPostBack="false" Text="Posted"/>
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
                                        <telerik:RadLabel runat="server" Text="DP" CssClass="lbObject"></telerik:RadLabel>
                                    </td>
                                    <td style="width:70px">
                                         <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <telerik:RadNumericTextBox  ReadOnly="true" EnabledStyle-HorizontalAlign="Right" ID="txt_DP"  Width="130px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
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
            
            <div style="padding: 5px 15px 15px 15px; height:300px">
                <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <telerik:RadGrid runat="server" ID="RadGrid2" RenderMode="Lightweight"  GridLines="None" AutoGenerateColumns="false" 
                            PageSize="5"  Skin="Telerik" AllowPaging="true" 
                            ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true"  
                            OnNeedDataSource="RadGrid2_NeedDataSource" OnInsertCommand="RadGrid2_InsertCommand" OnUpdateCommand="RadGrid2_InsertCommand" 
                            OnEditCommand="RadGrid2_InsertCommand"
                            OnDeleteCommand="RadGrid2_DeleteCommand" >
                            <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                            <%--<ClientSettings EnablePostBackOnRowClick="false" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />--%>
                            <MasterTableView CommandItemDisplay="Top" DataKeyNames="NoBuk, code_biaya" Font-Size="11px" EditMode="InPlace" 
                                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="false" CommandItemSettings-AddNewRecordText="Insert">
                                <CommandItemSettings ShowRefreshButton="false" ShowSaveChangesButton="false" ShowAddNewRecordButton="true" ShowCancelChangesButton="false" />
                                <Columns>
                                    <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                        HeaderText="Edit" HeaderStyle-Width="30px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridTemplateColumn ItemStyle-Width="0px" HeaderStyle-Width="0px" Visible="false"
                                        HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblNomor" Text='<%# DataBinder.Eval(Container.DataItem, "nomor") %>' Width="0px"></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Code" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblCodeBiaya" Text='<%# DataBinder.Eval(Container.DataItem, "code_biaya") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_CodeBiaya" EnableLoadOnDemand="true" DataTextField="remark" 
                                                        DataValueField="code_biaya" AutoPostBack="true" Text='<%# DataBinder.Eval(Container, "DataItem.code_biaya") %>' EmptyMessage="- Select Material -" 
                                                        HighlightTemplatedItems="true" Width="150px" DropDownWidth="650px" DropDownAutoWidth="Enabled" 
                                                        OnItemsRequested="cb_CodeBiaya_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_CodeBiaya_SelectedIndexChanged"
                                                        OnPreRender="cb_CodeBiaya_PreRender" CausesValidation="false">
                                                        <HeaderTemplate>
                                                            <table style="width: 650px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 150px;">
                                                                        Code
                                                                    </td>     
                                                                    <td style="width: 250px;">
                                                                        Specification
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 650px; font-size:smaller">
                                                                <tr>
                                                                    <td style="width: 150px;">
                                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                                    </td>     
                                                                    <td style="width: 250px;">
                                                                        <%# DataBinder.Eval(Container, "Attributes['remark']")%>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                              
                                        </EditItemTemplate>
                                      <%--<InsertItemTemplate>
                                          <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_CodeBiaya" EnableLoadOnDemand="true"  
                                                AutoPostBack="true"  
                                                HighlightTemplatedItems="true" Width="150px" DropDownWidth="650px" DropDownAutoWidth="Enabled" 
                                                OnItemsRequested="cb_CodeBiaya_ItemsRequested" 
                                                OnSelectedIndexChanged="cb_CodeBiaya_SelectedIndexChanged1"
                                                 CausesValidation="false">
                                                <HeaderTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                Code
                                                            </td>     
                                                            <td style="width: 250px;">
                                                                Specification
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 650px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                            </td>     
                                                            <td style="width: 250px;">
                                                                <%# DataBinder.Eval(Container, "Attributes['remark']")%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </telerik:RadComboBox> 
                                      </InsertItemTemplate>--%> 
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="280px" ItemStyle-Width="280px"
                                        HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblRemark" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="280px"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Amount" HeaderStyle-Width="120px" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right" 
                                        HeaderStyle-ForeColor="#009900" DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <telerik:RadLabel RenderMode="Lightweight" runat="server" ID="txtSubPrice" Width="120px"  ReadOnly="false" 
                                                EnabledStyle-HorizontalAlign="Right" BorderStyle="None"
                                                NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "sub_price", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2">
                                            </telerik:RadLabel>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtSubPrice" Width="120px"  ReadOnly="false" 
                                                EnabledStyle-HorizontalAlign="Right" BorderStyle="None"
                                                NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "sub_price", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2">
                                            </telerik:RadNumericTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Tax 1" HeaderStyle-Width="40px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                                        HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chk_tax1" runat="server" Font-Size="10px" ForeColor="#003399"
                                                Checked='<%# DataBinder.Eval(Container.DataItem, "tTax") %>' AutoPostBack="true" Width="40px" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Tax 2" HeaderStyle-Width="40px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                                        HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chk_tax2" runat="server" Font-Size="10px" ForeColor="#003399"
                                                Checked='<%# DataBinder.Eval(Container.DataItem, "tOTax") %>' AutoPostBack="true" Width="40px" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Tax 3" HeaderStyle-Width="40px" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center"
                                        HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chk_tax3" runat="server" Font-Size="10px" ForeColor="#003399"
                                                Checked='<%# DataBinder.Eval(Container.DataItem, "tpph") %>'  AutoPostBack="true" Width="40px"></asp:CheckBox>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Net" HeaderStyle-Width="120px" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Right" 
                                        HeaderStyle-ForeColor="#009900" DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <telerik:RadLabel RenderMode="Lightweight" runat="server" ID="lblTotal" Width="120px"  ReadOnly="true" 
                                                EnabledStyle-HorizontalAlign="Right" BorderStyle="None"
                                                NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "pay_tot", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2">
                                            </telerik:RadLabel>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="lblTotal" Width="120px"  ReadOnly="true" 
                                                EnabledStyle-HorizontalAlign="Right" BorderStyle="None"
                                                NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "pay_tot", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2">
                                            </telerik:RadNumericTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Cost Center" HeaderStyle-Width="80px" ItemStyle-Width="80px" 
                                        HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblCostCtr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                                        HeaderStyle-ForeColor="#009900" ConfirmTitle="Delete" ConfirmDialogType="RadWindow"
                                        ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Text="Data tersimpan" Position="BottomRight"
                            AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
                        </telerik:RadNotification>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

            <div style="padding: 5px 15px 5px 15px; position:absolute; ">
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
                        <td  style="padding-top:0px; text-align:left">
                            
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