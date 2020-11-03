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
                <telerik:AjaxUpdatedControl ControlID="txt_reqDate"></telerik:AjaxUpdatedControl>
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
                <telerik:AjaxUpdatedControl ControlID="cb_orderType" />
                <%--<telerik:AjaxUpdatedControl ControlID="cb_jobType" />--%>
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
                                        OnItemsRequested="cb_status_ItemsRequested"
                                        OnSelectedIndexChanged="cb_status_SelectedIndexChanged"
                                        OnPreRender="cb_status_PreRender"  >
                                    </telerik:RadComboBox>
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
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" AutoPostBack="false" CausesValidation="false" Skin="Telerik" 
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
                                <td >
                                    <telerik:RadLabel runat="server" Text="Project " CssClass="lbObject"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator9" ControlToValidate="cb_project" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                        CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                        ID="cb_project" 
                                        Width="300" 
                                        AutoPostBack="true" 
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
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                           <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"  
                                                DropDownWidth="1000px" 
                                                ID="cb_reff" 
                                                Width="300px"
                                                AutoPostBack="true" 
                                                DataTextField="PM_id" 
                                                DataValueField="PM_id"                                                 
                                                OnSelectedIndexChanged="cb_reff_SelectedIndexChanged"
                                                OnItemsRequested="cb_reff_ItemsRequested">
                                            <HeaderTemplate>
                                                <table style="width: 1000px">
                                                    <tr>
                                                        <td style="width: 90px;">
                                                            Req. Code
                                                        </td>
                                                        <td style="width: 70px;">
                                                            Date
                                                        </td> 
                                                        <td style="width: 80px;">
                                                            Unit Code
                                                        </td>
                                                        <td style="width: 60px;">
                                                            Unit Status
                                                        </td> 
                                                        <td style="width: 120px;">
                                                            Order Type
                                                        </td>
                                                        <td style="width: 560px;">
                                                            Problem
                                                        </td>                                                                    
                                                    </tr>
                                                </table>                                                       
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 1000px">
                                                    <tr>
                                                        <td style="width: 90px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.PM_id")%>
                                                        </td>
                                                        <td style="width: 70px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.Req_date","{0:dd/MM/yyyy}")%>
                                                        </td>
                                                        <td style="width: 100px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                        </td>
                                                        <td style="width: 60px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.unitstatus")%>
                                                        </td>
                                                        <td style="width: 110px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.Notif_type_name")%>
                                                        </td>
                                                        <td style="width: 560px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.remark")%>
                                                        </td>                                                                
                                                    </tr>
                                                </table>

                                            </ItemTemplate>
                                            
                                        </telerik:RadComboBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                                                                     
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Req. Date" CssClass="lbObject" ForeColor="Transparent"></telerik:RadLabel>
                                </td>
                                <td>
                                    <%--<telerik:RadDateTimePicker ID="dtp_reqDate" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Telerik">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput runat="server" Enabled="false" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"> 
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDateTimePicker>--%>
                                    <telerik:RadTextBox ID="txt_reqDate" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" BorderStyle="None"
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
                                <td>
                                    <telerik:RadLabel runat="server" Text="Unit " CssClass="lbObject"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="cb_unit" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td>
                                     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                                ID="cb_unit" Width="250px" 
                                                AutoPostBack="true" 
                                                DropDownWidth="250px"                                           
                                                OnItemsRequested="cb_unit_ItemsRequested" 
                                                OnSelectedIndexChanged="cb_unit_SelectedIndexChanged"
                                                OnPreRender="cb_unit_PreRender">
                                                <HeaderTemplate>
                                                    <table style="width: 250px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 100px;">Unit Code
                                                            </td>
                                                            <td style="width: 150px;">Model No.
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 250px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 100px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                            </td>
                                                            <td style="width:150px;">
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
                                        <telerik:RadTextBox ID="txt_unit_name" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
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
                                            ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true" EnabledStyle-HorizontalAlign="Right"
                                            onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            AutoPostBack="false" MaxLength="11" Type="Number"
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
                                          ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true" EnabledStyle-HorizontalAlign="Right"
                                            onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            AutoPostBack="false" MaxLength="11" Type="Number"
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
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                            CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                            ID="cb_orderType" 
                                            Width="250px" 
                                            AutoPostBack="true"
                                            DropDownWidth="250px" ForeColor="#003300"
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
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                            CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                            ID="cb_jobType" 
                                            Width="250px" 
                                            AutoPostBack="false" 
                                            DropDownWidth="250px"
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
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                                ID="cb_jsa" Width="250px" 
                                                AutoPostBack="false"
                                                DropDownWidth="450px"                                             
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
                                    <telerik:RadTimePicker ID="rtp_breakdownTime" runat="server" RenderMode="Lightweight" Width="80px" AutoPostBack="false"></telerik:RadTimePicker>                                             
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
                                    <telerik:RadTimePicker ID="rtp_excStartTime" runat="server" RenderMode="Lightweight" Width="80px" AutoPostBack="false"></telerik:RadTimePicker>   
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
                                    <telerik:RadTimePicker ID="rtp_excFinishTime" runat="server" RenderMode="Lightweight" Width="80px" AutoPostBack="false"></telerik:RadTimePicker>            
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
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                        CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                        ID="cb_mainType" 
                                        Width="250px"                                       
                                        OnSelectedIndexChanged="cb_mainType_SelectedIndexChanged"
                                        OnItemsRequested="cb_mainType_ItemsRequested" 
                                        OnPreRender="cb_mainType_PreRender">
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
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                                ID="cb_orderBy" 
                                                Width="250px"
                                                DropDownWidth="650px"
                                                OnSelectedIndexChanged="cb_ordered_SelectedIndexChanged"    
                                                OnItemsRequested="cb_ordered_ItemsRequested"
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
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                                ID="cb_recordBy" 
                                                Width="250px"
                                                DropDownWidth="650px"
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
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                                ID="cb_acknowledgedBy"
                                                Width="250px"
                                                DropDownWidth="650px"
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
                   
            </table>
        </div>

        <div style="padding: 5px 15px 10px 15px; border-bottom-style:double; border-bottom-width: 1px; border-bottom-color:deeppink;height:290px">
            <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1" Width="97%" 
            SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Telerik" CausesValidation="False">
            <Tabs>
                <telerik:RadTab Text="Component" Height="20px" Visible="true"> 
                </telerik:RadTab>
                <telerik:RadTab Text="DMBD" Height="20px"  Visible="true">
                </telerik:RadTab>
                <telerik:RadTab Text="External Service" Height="20px"  Visible="true"> 
                </telerik:RadTab>
                <telerik:RadTab Text="Operation" Height="20px" Visible="true">
                </telerik:RadTab>  
                <telerik:RadTab Text="Material Request" Height="20px" Visible="true">
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
                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                    CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                    Font-Size="X-Small" 
                                    ID="cb_compGroup"
                                    Width="300" 
                                    DropDownWidth="300px"
                                    AutoPostBack="false" 
                                    OnItemsRequested="cb_compGroup_ItemsRequested" 
                                    OnSelectedIndexChanged="cb_compGroup_SelectedIndexChanged" 
                                    OnPreRender="cb_compGroup_PreRender" >
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
                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                    CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                    Font-Size="X-Small"
                                    ID="cb_comp" 
                                    Width="300"
                                    DropDownWidth="300px"
                                    AutoPostBack="false"
                                    OnItemsRequested="cb_comp_ItemsRequested"
                                    OnSelectedIndexChanged="cb_comp_SelectedIndexChanged"
                                    OnPreRender="cb_comp_PreRender" >
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
                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                    CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                    Font-Size="X-Small" 
                                    ID="cb_diagnosis" 
                                    Width="300" 
                                    DropDownWidth="300px"
                                    AutoPostBack="false"
                                    OnItemsRequested="cb_diagnosis_ItemsRequested" 
                                    OnSelectedIndexChanged="cb_diagnosis_SelectedIndexChanged" 
                                    OnPreRender="cb_diagnosis_PreRender" >
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
                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                    CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                    Font-Size="X-Small"
                                    ID="cb_symptom" 
                                    Width="300" DropDownWidth="300px"
                                    AutoPostBack="false"
                                    OnItemsRequested="cb_symptom_ItemsRequested"
                                    OnSelectedIndexChanged="cb_symptom_SelectedIndexChanged"
                                    OnPreRender="cb_symptom_PreRender">
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
                <telerik:RadPageView runat="server" ID="RadPageView2" Height="245px" Visible="True">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
                        AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"  
                        OnNeedDataSource="RadGrid2_NeedDataSource" 
                        ShowStatusBar="true">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                        <MasterTableView CommandItemDisplay="Bottom" CommandItemSettings-ShowAddNewRecordButton="true" DataKeyNames="trans_id" Font-Size="11px" 
                            EditMode="Batch" ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="Add" CommandItemSettings-SaveChangesText="Save">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowCancelChangesButton="false"  />
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
                               <%-- <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                    HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update" >
                                </telerik:GridEditCommandColumn>--%>
                                <%--<telerik:GridDateTimeColumn UniqueName="trans_date" HeaderText="Date" DataField="trans_date" ItemStyle-Width="100px" 
                                        EnableRangeFiltering="false" PickerType="DatePicker" 
                                        DataFormatString="{0:d}" >
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle Width="100px" />
                                </telerik:GridDateTimeColumn>--%>
                                <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-Width="110px"  ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-HorizontalAlign="Center"  HeaderStyle-ForeColor="Highlight">
                                <ItemTemplate>
                                    <telerik:RadDatePicker runat="server" ID="trans_date" Width="110px"
                                        DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.trans_date")%>' 
                                        onkeydown="blurTextBox(this, event)" Type="Date">
                                        <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                    </telerik:RadDatePicker>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadDatePicker runat="server" ID="trans_date_edt" Width="110px"
                                        
                                        onkeydown="blurTextBox(this, event)" Type="Date">
                                        <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                </telerik:GridTemplateColumn> 
                                <telerik:GridTemplateColumn HeaderText="Down" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>                                        
                                        <asp:Label runat="server" ID="lbl_down_time" Text='<%# DataBinder.Eval(Container.DataItem, "breakdown_time", "{0:hh:mm}") %>'></asp:Label>
                                     </ItemTemplate>
                                    <EditItemTemplate>                                       
                                        <telerik:RadTimePicker ID="rtp_breakdownTime" SelectedDate='<%# Convert.ToDateTime(Eval("breakdown_time")) %>' runat="server" 
                                            RenderMode="Lightweight" Width="70px" AutoPostBack="false"></telerik:RadTimePicker> 
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Act" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                     <ItemTemplate>                                        
                                        <asp:Label runat="server" ID="lbl_down_act" Text='<%# DataBinder.Eval(Container.DataItem, "down_act", "{0:hh:mm}") %>'></asp:Label>
                                     </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTimePicker ID="rtp_breakdownAct" SelectedDate='<%# Convert.ToDateTime(Eval("down_act")) %>' runat="server" 
                                            RenderMode="Lightweight" Width="70px" AutoPostBack="false"></telerik:RadTimePicker>  
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Up" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                     <ItemTemplate>                                        
                                        <asp:Label runat="server" ID="lbl_down_up" Text='<%# DataBinder.Eval(Container.DataItem, "down_up", "{0:hh:mm}") %>'></asp:Label>
                                     </ItemTemplate>
                                    <EditItemTemplate>                                        
                                        <telerik:RadTimePicker ID="rtp_breakdownUp" SelectedDate='<%# Convert.ToDateTime(Eval("down_up")) %>' runat="server" 
                                            RenderMode="Lightweight" Width="70px" AutoPostBack="false"></telerik:RadTimePicker>  
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>                                
                                <telerik:GridTemplateColumn HeaderText="Status" HeaderStyle-Width="80px" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>                                        
                                        <asp:Label runat="server" ID="lbl_status" Text='<%# DataBinder.Eval(Container.DataItem, "status") %>'></asp:Label>
                                     </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_bd_status" EnableLoadOnDemand="True" DataTextField="wo_desc"
                                            DataValueField="wo_status" AutoPostBack="false"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.status") %>'
                                            HighlightTemplatedItems="true" Width="80px" DropDownWidth="850px" DropDownAutoWidth="Enabled" 
                                             OnItemsRequested="cb_bd_status_ItemsRequested">                                                   
                                            <HeaderTemplate>
                                            <table style="width: 850px; font-size:smaller">
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
                                                    <td style="width: 550px;">
                                                        Remark
                                                    </td>                                                        
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 850px; font-size:smaller">
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
                                                    <td style="width: 550px;">
                                                        <%# DataBinder.Eval(Container, "Attributes['remark']")%>
                                                    </td>                                                                                                
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="380px" ItemStyle-Width="380px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>                                        
                                        <asp:Label runat="server" ID="lbl_remark" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                                     </ItemTemplate>
                                    <EditItemTemplate>                                        
                                        <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_remark" Width="380px" 
                                            Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'>
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
                <telerik:RadPageView runat="server" ID="RadPageView3" Height="245px" Visible="True">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
                                AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" Width="1100px" 
                                OnNeedDataSource="RadGrid3_NeedDataSource"
                                ShowStatusBar="true">
                                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="sup_code" Font-Size="11px" EditMode="Batch"
                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="Add">
                                    <CommandItemSettings ShowRefreshButton="False" ShowCancelChangesButton="false" ShowSaveChangesButton="False" 
                                        ShowAddNewRecordButton="true" />
                                    <Columns>
                                        <%--<telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                            HeaderText="Edit" HeaderStyle-Width="70px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                        </telerik:GridEditCommandColumn>--%>
                                        <%--<telerik:GridDateTimeColumn UniqueName="trans_date" HeaderText="Date" DataField="trans_date" ItemStyle-Width="100px" 
                                                EnableRangeFiltering="false" PickerType="DatePicker" 
                                                DataFormatString="{0:d}" >
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                            <ItemStyle Width="100px" />
                                        </telerik:GridDateTimeColumn>--%>
                                        <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-Width="110px"  ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Center"
                                            HeaderStyle-HorizontalAlign="Center"  HeaderStyle-ForeColor="Highlight">
                                            <ItemTemplate>
                                                <telerik:RadDatePicker runat="server" ID="trans_date" Width="110px"
                                                    DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.trans_date")%>' 
                                                    onkeydown="blurTextBox(this, event)" Type="Date">
                                                    <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                                </telerik:RadDatePicker>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadDatePicker runat="server" ID="trans_date_edt" Width="110px"
                                        
                                                    onkeydown="blurTextBox(this, event)" Type="Date">
                                                    <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                                </telerik:RadDatePicker>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn> 
                                        <telerik:GridTemplateColumn HeaderText="Supplier" HeaderStyle-Width="290px" ItemStyle-Width="290px" 
                                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900"
                                            ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lbl_SupName" Text='<%# DataBinder.Eval(Container.DataItem, "supplier_name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_supplier" EnableLoadOnDemand="True" DataTextField="supplier_name"
                                                    DataValueField="supplier_code" AutoPostBack="false" BorderStyle="Inset" BorderWidth="1px"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.supplier_name") %>'
                                                    HighlightTemplatedItems="true" Width="290px" DropDownWidth="550px" DropDownAutoWidth="Enabled" 
                                                     OnItemsRequested="cb_supplier_ItemsRequested">                                                   
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

                                        <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-Width="380px" ItemStyle-Width="380px" HeaderStyle-HorizontalAlign="Center" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lbl_description" Text='<%# DataBinder.Eval(Container.DataItem, "description") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_description" Width="380px" BorderStyle="Inset" BorderWidth="1px"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.description", "{0:#,###,###0.00}") %>'>
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
                                                    EnabledStyle-HorizontalAlign="Right" BorderStyle="Inset" BorderWidth="1px"
                                                    NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "price", "{0:#,###,###0.00}") %>'                                            
                                                    onkeydown="blurTextBox(this, event)"
                                                    AutoPostBack="false" MaxLength="11" Type="Number"
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
                        </ContentTemplate>
                    </asp:UpdatePanel>               
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView4" Height="245px" Visible="True">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid4" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
                            AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" Width="450px" 
                            OnNeedDataSource="RadGrid4_NeedDataSource"
                            ShowStatusBar="true">
                            <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                            <HeaderStyle CssClass="gridHeader" />
                            <MasterTableView CommandItemDisplay="Top" CommandItemStyle-Height="25px" DataKeyNames="OprCode" Font-Size="11px" EditMode="Batch"
                                CommandItemSettings-ShowAddNewRecordButton="true"
                                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="Add">
                                <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowCancelChangesButton="False" />                            
                                <Columns>
                                    <%--<telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                        HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update">
                                    </telerik:GridEditCommandColumn>               --%>         
                                    
                                    <%--    
                                    <telerik:GridTemplateColumn HeaderText="Code" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lbl_chart_code" Text='<%# DataBinder.Eval(Container.DataItem, "OprCode") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Label runat="server" ID="lbl_chart_code_edt" Text='<%# DataBinder.Eval(Container.DataItem, "OprCode") %>'></asp:Label>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>--%>
                                

                                    <telerik:GridTemplateColumn HeaderText="Maintenance Operation" HeaderStyle-Width="400px" ItemStyle-Width="400px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lbl_OprName" Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation" EnableLoadOnDemand="True" DataTextField="OprCode"
                                                DataValueField="OprCode" AutoPostBack="true" CausesValidation="false"
                                                HighlightTemplatedItems="true" Width="400px" DropDownWidth="400px" DropDownAutoWidth="Enabled" 
                                                 OnItemsRequested="cb_operation_ItemsRequested" 
                                                OnSelectedIndexChanged="cb_operation_SelectedIndexChanged">                                                   
                                                <HeaderTemplate>
                                                <table style="width: 550px; font-size:smaller">
                                                    <tr>
                                                        <td style="width: 50px;">
                                                            Code
                                                        </td>
                                                        <td style="width: 250px;">
                                                            Operation Maintenance
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
                                                            <%# DataBinder.Eval(Container, "Attributes['OprName']")%>
                                                        </td>                                                                                  
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                         
                                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                        ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                            </telerik:RadGrid>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView5" Height="245px" Visible="True">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid5" GridLines="None" AutoGenerateColumns="false" PageSize="5" Skin="Telerik"
                                AllowPaging="true" AllowSorting="true" runat="server" ShowStatusBar="true"
                                ClientSettings-EnableAlternatingItems="True" ItemStyle-Height="15px" 
                                AllowAutomaticDeletes="True" AllowAutomaticInserts="True"  
                                OnNeedDataSource="RadGrid5_NeedDataSource" >
                                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                                <MasterTableView CommandItemDisplay="None" DataKeyNames="part_code" Font-Size="11px"
                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="Add" InsertItemDisplay="Bottom">
                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                                                   
                                    <Columns>
                                        <%--<telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                            HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update" >
                                        </telerik:GridEditCommandColumn>--%>
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
                                       <%-- <telerik:GridTemplateColumn HeaderText="QRS" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                <ItemTemplate>
                                                <asp:Label runat="server" ID="lblQtyRs" Text='<%# DataBinder.Eval(Container.DataItem, "qty_pr", "{0:#,###,###0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                                           
                                        </telerik:GridTemplateColumn>--%>
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
                                            <EditItemTemplate>
                                                <asp:CheckBox runat="server" ID="chk_warranty" Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                                            </EditItemTemplate>                                        
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
                                    </Columns>
                                </MasterTableView>
                                <ClientSettings>                         
                                    <%-- <Scrolling AllowScroll="true" UseStaticHeaders="false" ScrollHeight="273px" />--%>
                                    </ClientSettings>
                            </telerik:RadGrid>
                        </ContentTemplate>
                    </asp:UpdatePanel>
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
                            <telerik:RadButton ID="btn_save" runat="server" Text="Save" CssClass="btn-wrapper" ForeColor="White" OnClick="btn_save_Click"
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
