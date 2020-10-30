<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mtc01h01EditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.WorkOrder.mtc01h01EditForm" %>

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
                <telerik:AjaxUpdatedControl ControlID="cb_reff"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_prepared"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_verified"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_approved"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="cb_reff">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="dtp_doc_date"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_unit"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_unit_name"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_hm" />
                <telerik:AjaxUpdatedControl ControlID="txt_hmEstAccum" />
                <telerik:AjaxUpdatedControl ControlID="dtp_breakdownDate" />
                <telerik:AjaxUpdatedControl ControlID="rtp_breakdownTime" />
                <telerik:AjaxUpdatedControl ControlID="cb_breakdown" />
                <telerik:AjaxUpdatedControl ControlID="cb_compGroup" />
                <telerik:AjaxUpdatedControl ControlID="cb_comp" />
                <telerik:AjaxUpdatedControl ControlID="txt_jobDesc" />
                <%--<telerik:AjaxUpdatedControl ControlID="cb_orderType" />
                <telerik:AjaxUpdatedControl ControlID="cb_jobType" />--%>
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
                                    <telerik:RadLabel runat="server" Text="Reg. Number" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_reg_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
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
                                <td>
                                    <telerik:RadLabel runat="server" Text="Doc. Date " CssClass="lbObject"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ControlToValidate="dtp_doc_date" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_doc_date"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
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
                                <td >
                                    <telerik:RadLabel runat="server" Text="Est. Exct " CssClass="lbObject"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ControlToValidate="dtp_estExct" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_estExct" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Telerik">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"> 
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Status " CssClass="lbObject"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator12" ControlToValidate="cb_status" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_status" runat="server" Width="150"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Skin="Telerik"
                                        OnItemsRequested="cb_status_ItemsRequested"  >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <telerik:RadLabel runat="server" Text="Project " CssClass="lbObject"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator9" ControlToValidate="cb_project" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                        Font-Size="Small"
                                        OnItemsRequested="cb_project_ItemsRequested"
                                        OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                        OnPreRender="cb_project_PreRender" >
                                    </telerik:RadComboBox>               
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Ref. Number" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                     <telerik:RadComboBox RenderMode="Lightweight" ID="cb_reff" runat="server" Width="300px"
                                         AutoPostBack="true" CausesValidation="false"
                                                DropDownWidth="800px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="PM_id" DataValueField="PM_id"                                                 
                                            OnSelectedIndexChanged="cb_reff_SelectedIndexChanged"
                                         OnItemsRequested="cb_reff_ItemsRequested">
                                            <HeaderTemplate>
                                                <table style="width: 800px">
                                                    <tr>
                                                        <td style="width: 140px;">
                                                            Req. Number
                                                        </td>
                                                        <td style="width: 80px;">
                                                            Date
                                                        </td> 
                                                        <td style="width: 120px;">
                                                            Unit
                                                        </td>
                                                        <td style="width: 60px;">
                                                            Unit Status
                                                        </td> 
                                                        <td style="width: 110px;">
                                                            Order Type
                                                        </td>
                                                        <td style="width: 260px;">
                                                            Problem
                                                        </td>                                                                    
                                                    </tr>
                                                </table>                                                       
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 600px">
                                                    <tr>
                                                        <td style="width: 140px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.PM_id")%>
                                                        </td>
                                                        <td style="width: 80px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.Req_date")%>
                                                        </td>
                                                        <td style="width: 120px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                        </td>
                                                        <td style="width: 60px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.unitstatus")%>
                                                        </td>
                                                        <td style="width: 110px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.Notif_type_name")%>
                                                        </td>
                                                        <td style="width: 260px;">
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
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Req. Date" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <%--<telerik:RadDateTimePicker ID="dtp_reqDate" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Telerik">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput runat="server" Enabled="false" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"> 
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDateTimePicker>--%>
                                    <telerik:RadTextBox ID="txt_reqDate" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" 
                                            Skin="Telerik"   >
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
                                    <telerik:RadLabel runat="server" Text="Priority " CssClass="lbObject"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="cb_priority" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td>
                                     <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                        <ContentTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="100px"
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
                           
                        </table>
                    </td>
                    <td style="vertical-align: top; padding-left:15px">
                        <table id="Table3" border="0" class="module">
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Unit " CssClass="lbObject"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="cb_unit" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td>
                                     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                        <telerik:RadComboBox ID="cb_unit" runat="server" Width="250px" AutoPostBack="true" CausesValidation="false"
                                            DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" Font-Size="Small"
                                            OnItemsRequested="cb_unit_ItemsRequested" 
                                            OnSelectedIndexChanged="cb_unit_SelectedIndexChanged"
                                            OnPreRender="cb_unit_PreRender">
                                            <HeaderTemplate>
                                                    <table style="width: 650px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 300px;">Unit Code
                                                            </td>
                                                            <td style="width: 350px;">Model No.
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 650px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                            </td>
                                                            <td style="width: 350px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.model_no")%>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                </FooterTemplate>
                                        </telerik:RadComboBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Model No " CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadTextBox ID="txt_unit_name" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" Font-Size="Small"
                                        Skin="Telerik">
                                        </telerik:RadTextBox>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cb_unit" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                    </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                   <telerik:RadLabel runat="server" Text="HM reading " CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                   <asp:RequiredFieldValidator runat="server" ID="hmValidator" ControlToValidate="txt_hm" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadNumericTextBox ID="txt_hm" runat="server" Width="100px" ReadOnly="false" RenderMode="Lightweight" 
                                            ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                            onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2" Skin="Telerik">
                                        </telerik:RadNumericTextBox>
                                    </ContentTemplate>
                                    
                                    </asp:UpdatePanel>
                                </td>
                            </tr> 
                            <tr>
                                <td>
                                   <telerik:RadLabel runat="server" Text="HM Est. Accum. " CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                  
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadNumericTextBox ID="txt_hmEstAccum" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" 
                                          ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                            onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2" Skin="Telerik">
                                        </telerik:RadNumericTextBox>
                                    </ContentTemplate>
                                    
                                    </asp:UpdatePanel>
                                </td>
                            </tr> 
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Order Type " CssClass="lbObject"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="cb_orderType" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td>
                                     <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                        <ContentTemplate>
                                        <telerik:RadComboBox ID="cb_orderType" runat="server" Width="250px" AutoPostBack="true" CausesValidation="false"
                                            DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" Font-Size="Small"
                                            OnItemsRequested="cb_orderType_ItemsRequested" 
                                            OnSelectedIndexChanged="cb_orderType_SelectedIndexChanged"
                                            OnPreRender="cb_orderType_PreRender">
                                        </telerik:RadComboBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr> 
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Job Type " CssClass="lbObject"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ControlToValidate="cb_jobType" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td>
                                     <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                        <ContentTemplate>
                                        <telerik:RadComboBox ID="cb_jobType" runat="server" Width="250px" AutoPostBack="true" CausesValidation="false"
                                            DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" Font-Size="Small"
                                            OnItemsRequested="cb_jobType_ItemsRequested" 
                                            OnSelectedIndexChanged="cb_jobType_SelectedIndexChanged"
                                            OnPreRender="cb_jobType_PreRender">
                                        </telerik:RadComboBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <telerik:RadLabel runat="server" Text="JSA" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                     <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                        <ContentTemplate>
                                        <telerik:RadComboBox ID="cb_jsa" runat="server" Width="250px" AutoPostBack="true" CausesValidation="false"
                                            DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" Font-Size="Small"
                                            OnItemsRequested="cb_jsa_ItemsRequested"
                                            OnSelectedIndexChanged="cb_jsa_SelectedIndexChanged"
                                            OnPreRender="cb_jsa_PreRender" >
                                        </telerik:RadComboBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>           
                    </td>
                    <td >
                            <table id="Table4" border="0" class="module">
                            <tr>
                                <td >
                                    <telerik:RadLabel runat="server" Text="Unit Status " CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:CheckBox ID="chk_breakdown" runat="server" AutoPostBack="false" Text="Breakdown" Font-Size="12px"/>            
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <telerik:RadLabel runat="server" Text="BD Date" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadDatePicker ID="dtp_breakdownDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Telerik" > 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                    </telerik:RadDatePicker> 
                                    &nbsp
                                    <%--<telerik:RadTextBox ID="txt_breakdownTime" runat="server" Width="60px" ReadOnly="false" RenderMode="Lightweight" Font-Size="Small"
                                        Skin="Telerik">
                                    </telerik:RadTextBox> --%>
                                    <telerik:RadTimePicker ID="rtp_breakdownTime" runat="server" RenderMode="Lightweight" Width="80px" AutoPostBack="true"></telerik:RadTimePicker>                                             
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Exc. Start Date" CssClass="lbObject"></telerik:RadLabel>
                                </td>                
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadDatePicker ID="dtp_excStartDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Telerik" > 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                    </telerik:RadDatePicker> 
                                    &nbsp
                                   <%-- <telerik:RadTextBox ID="txt_excStartTime" runat="server" Width="60px" ReadOnly="false" RenderMode="Lightweight" Font-Size="Small"
                                        Skin="Telerik">
                                    </telerik:RadTextBox>--%>
                                    <telerik:RadTimePicker ID="rtp_excStartTime" runat="server" RenderMode="Lightweight" Width="80px" AutoPostBack="true"></telerik:RadTimePicker>   
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Exc. Finish Date" CssClass="lbObject"></telerik:RadLabel>
                                </td>                
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadDatePicker ID="dtp_excFinishDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Telerik" > 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                    </telerik:RadDatePicker>  
                                    &nbsp
                                    <%--<telerik:RadTextBox ID="txt_excFinishTime" runat="server" Width="60px" ReadOnly="false" RenderMode="Lightweight" Font-Size="Small"
                                        Skin="Telerik">
                                    </telerik:RadTextBox>--%>
                                    <telerik:RadTimePicker ID="rtp_excFinishTime" runat="server" RenderMode="Lightweight" Width="80px" AutoPostBack="true"></telerik:RadTimePicker>            
                                </td>
                            </tr>
                            <%--<tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Duration" CssClass="lbObject"></telerik:RadLabel>
                                </td>                
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadTextBox ID="RadTextBox1" runat="server" Width="100px" ReadOnly="false" RenderMode="Lightweight" Font-Size="Small"
                                        Skin="Telerik">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>--%>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Maint. Type" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_mainType" runat="server" Width="250px"
                                        ShowMoreResultsBox="true" EnableLoadOnDemand="true" Skin="Telerik"
                                        EnableVirtualScrolling="true" 
                                        OnSelectedIndexChanged="cb_mainType_SelectedIndexChanged"
                                        OnItemsRequested="cb_mainType_ItemsRequested">
                                    </telerik:RadComboBox>
                       
                                </td>

                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Order By" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                                        <ContentTemplate>                                            
                                            <telerik:RadComboBox ID="cb_orderBy" runat="server" Width="250px"
                                                DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                OnSelectedIndexChanged="cb_orderBy_SelectedIndexChanged"
                                                OnItemsRequested="cb_orderBy_ItemsRequested"
                                                OnPreRender="cb_orderBy_PreRender" >
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
                                    <telerik:RadLabel runat="server" Text="Recorded By" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                        <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_recordBy" runat="server" Width="250px"
                                                DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                OnSelectedIndexChanged="cb_recordBy_SelectedIndexChanged" 
                                                OnItemsRequested="cb_recordBy_ItemsRequested"
                                                OnPreRender="cb_recordBy_PreRender" >
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
                                    <telerik:RadLabel runat="server" Text="Acknowledged By" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel14" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_acknowledgedBy" runat="server" Width="250px"
                                                DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                OnSelectedIndexChanged="cb_acknowledgedBy_SelectedIndexChanged"
                                                OnItemsRequested="cb_acknowledgedBy_ItemsRequested"
                                                OnPreRender="cb_acknowledgedBy_PreRender">
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
                 
                        </table>
                    </td>
                </tr>    
                <%--<tr>
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
                            </tr>
                        </table>
                    </td>
                </tr>--%>   
            </table>
        </div>

        <div style="padding: 5px 15px 10px 15px; border-bottom-style:double; border-bottom-width: 1px; border-bottom-color:deeppink;height:290px">
            <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="97%" 
            SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Telerik" CausesValidation="false">
            <Tabs>
                <telerik:RadTab Text="Component" Height="20px"> 
                </telerik:RadTab>
                <telerik:RadTab Text="DMBD" Height="20px">
                </telerik:RadTab>
                <telerik:RadTab Text="External Service" Height="20px"> 
                </telerik:RadTab>
                <telerik:RadTab Text="Operation" Height="20px">
                </telerik:RadTab>             
            </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage runat="server" ID="RadMultiPage1"  SelectedIndex="0" Width="97%" >
                <telerik:RadPageView runat="server" ID="RadPageView1" Height="245px">
                    <table>
                        <tr>
                            <td>
                                <telerik:RadLabel runat="server" Text="Comp. Group " CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_compGroup" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                            </td>
                            <td>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_compGroup" runat="server" Width="300" DropDownWidth="300px"
                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                    Font-Size="Small" >
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel runat="server" Text="Comp. " CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_comp" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                            </td>
                            <td>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_comp" runat="server" Width="300" DropDownWidth="300px"
                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                    Font-Size="Small" >
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel runat="server" Text="Diagnosis " CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_diagnosis" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                            </td>
                            <td>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_diagnosis" runat="server" Width="300" DropDownWidth="300px"
                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                    Font-Size="Small" >
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel runat="server" Text="Symptom " CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_symptom" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                            </td>
                            <td>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_symptom" runat="server" Width="300" DropDownWidth="300px"
                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                    Font-Size="Small" >
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel runat="server" Text="Job Description " CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="txt_jobDesc" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txt_jobDesc"
                                    runat="server" TextMode="MultiLine"
                                    Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>                    
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView2" Height="245px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
                        AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"  
                        OnNeedDataSource="RadGrid2_NeedDataSource" 
                        ShowStatusBar="true">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                        <MasterTableView CommandItemDisplay="None" DataKeyNames="trans_id" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                            <GroupByExpressions>
                                <telerik:GridGroupByExpression>
                                    <SelectFields>
                                        <telerik:GridGroupByField FieldAlias="Operation" FieldName="OprName"></telerik:GridGroupByField>
                                    </SelectFields>
                                    <GroupByFields>
                                        <telerik:GridGroupByField FieldName="OprName" ></telerik:GridGroupByField>
                                    </GroupByFields>
                                </telerik:GridGroupByExpression>
                                
                            </GroupByExpressions>
                            <Columns>
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                    HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update" >
                                </telerik:GridEditCommandColumn>
                                <telerik:GridDateTimeColumn UniqueName="trans_date" HeaderText="Date" DataField="trans_date" ItemStyle-Width="100px" 
                                        EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                                        DataFormatString="{0:d}" >
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle Width="80px" />
                                </telerik:GridDateTimeColumn>
                                <telerik:GridTemplateColumn HeaderText="Down" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>                                        
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_down_time" Width="50px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                            DbValue='<%# Convert.ToDouble(Eval("down_time")) %>'
                                            onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2">
                                        </telerik:RadNumericTextBox>
                                    </ItemTemplate>
                                    
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Act" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_down_act" Width="50px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                            DbValue='<%# Convert.ToDouble(Eval("down_act")) %>'
                                            onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2" >
                                        </telerik:RadNumericTextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Up" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%--<asp:Label runat="server" ID="lbl_down_up" Text='<%# DataBinder.Eval(Container.DataItem, "down_up", "{0:#,###,###0.00}") %>'></asp:Label>--%>
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_down_up" Width="50px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                            DbValue='<%# Convert.ToDouble(Eval("down_up")) %>'
                                            onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2">
                                        </telerik:RadNumericTextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Tot. Down Time" HeaderStyle-Width="100px" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <%--<asp:Label runat="server" ID="lbl_tot" Text='<%# DataBinder.Eval(Container.DataItem, "tot_time_down", "{0:#,###,###0.00}") %>'></asp:Label>--%>
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_tot_time_down" Width="100px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                            DbValue='<%# Convert.ToDouble(Eval("tot_time_down")) %>'
                                            onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2">
                                        </telerik:RadNumericTextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Status" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%--<asp:Label runat="server" ID="lbl_status" Text='<%# DataBinder.Eval(Container.DataItem, "status") %>'></asp:Label>--%>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_status" EnableLoadOnDemand="True" DataTextField="Prod_code"
                                            DataValueField="Prod_code" AutoPostBack="true"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.status") %>'
                                            HighlightTemplatedItems="true" Width="130px" DropDownWidth="550px" DropDownAutoWidth="Enabled" 
                                             >                                                   
                                            <HeaderTemplate>
                                            <table style="width: 550px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 50px;">
                                                        Code
                                                    </td>
                                                    <td style="width: 120px;">
                                                        Status B/D
                                                    </td>     
                                                   <%-- <td style="width: 120px;">
                                                        Type B/D
                                                    </td>--%>
                                                    <td style="width: 250px;">
                                                        Remark
                                                    </td>                                                        
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 550px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 50px;">
                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                    </td>        
                                                    <td style="width: 120px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['wo_desc']")%>
                                                    </td>
                                                   <%-- <td style="width: 120px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['unit']")%>
                                                    </td>--%>
                                                    <td style="width: 250px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['remark']")%>
                                                    </td>                                                                                                
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="250px" ItemStyle-Width="250px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>                                        
                                        <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_remark" Width="250px" 
                                            Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'>
                                        </telerik:RadTextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView3" Height="245px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
                        AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" Width="1100px" 
                        OnNeedDataSource="RadGrid3_NeedDataSource"
                        ShowStatusBar="true">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                        <MasterTableView CommandItemDisplay="None" DataKeyNames="sup_code" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                            <Columns>
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                    HeaderText="Edit" HeaderStyle-Width="70px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridEditCommandColumn>
                                <telerik:GridDateTimeColumn UniqueName="trans_date" HeaderText="Date" DataField="trans_date" ItemStyle-Width="100px" 
                                        EnableRangeFiltering="false" PickerType="DatePicker" 
                                        DataFormatString="{0:d}" >
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle Width="100px" />
                                </telerik:GridDateTimeColumn>
                                <telerik:GridTemplateColumn HeaderText="Supplier" HeaderStyle-Width="320px" ItemStyle-Width="320px" 
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_SupName" Text='<%# DataBinder.Eval(Container.DataItem, "supplier_name") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_supplier" EnableLoadOnDemand="True" DataTextField="supplier_name"
                                            DataValueField="supplier_code" AutoPostBack="true" 
                                            Text='<%# DataBinder.Eval(Container, "DataItem.supplier_name") %>'
                                            HighlightTemplatedItems="true" Width="320px" DropDownWidth="550px" DropDownAutoWidth="Enabled" 
                                             >                                                   
                                            <HeaderTemplate>
                                            <table style="width: 550px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 50px;">
                                                        Code
                                                    </td>
                                                    <td style="width: 250px;">
                                                        Supplier
                                                    </td>                                           
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 550px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 50px;">
                                                        <%# DataBinder.Eval(Container, "Value")%>
                                                    </td>        
                                                    <td style="width: 250px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['supplier_name']")%>
                                                    </td>                                                                                  
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-Width="350px" ItemStyle-Width="350px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_description" Text='<%# DataBinder.Eval(Container.DataItem, "description") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_description" Width="350px"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.description") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Cost" HeaderStyle-Width="110px" ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Right" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_rate" Text='<%# DataBinder.Eval(Container.DataItem, "price", "{0:#,###,###0.00}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_rate" Width="110px"
                                            EnabledStyle-HorizontalAlign="Right"
                                            NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            Text='<%# DataBinder.Eval(Container.DataItem, "price", "{0:#,###,###0.00}") %>'                                            
                                            onkeydown="blurTextBox(this, event)"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>                    
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView4" Height="245px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid4" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
                        AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" Width="550px" 
                        OnNeedDataSource="RadGrid4_NeedDataSource"
                        ShowStatusBar="true">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                        <MasterTableView CommandItemDisplay="None" DataKeyNames="chart_code" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                            
                            <Columns>                                
                                <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_chart_code" Text='<%# DataBinder.Eval(Container.DataItem, "chart_code") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="200px" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_OprName" Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
       </div>
            
            <div style="padding: 5px 15px 5px 15px; position:absolute">
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
                                Skin="Material" ></telerik:RadButton>
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
