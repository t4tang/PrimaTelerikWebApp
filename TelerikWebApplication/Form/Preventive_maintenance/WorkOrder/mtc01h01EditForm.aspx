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

<%--        <telerik:RadTabStrip RenderMode="Lightweight" ID="RadTabStrip1"  SelectedIndex="0" runat="server" MultiPageID="RadMultiPage1"
             Align="Justify" Skin="Silk" CssClass="tabStrip" CausesValidation="false">
        </telerik:RadTabStrip>
        <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" OnPageViewCreated="RadMultiPage1_PageViewCreated"
            CssClass="multiPage">
        </telerik:RadMultiPage>--%>




        <div style="padding: 10px 5px 3px 15px;" class="lbObject">
            <table id="Table1" border="0" style="border-collapse: collapse; padding-top:5px; padding-left:15px; 
                padding-right:15px; padding-bottom:0px; font-size:smaller ">    
                <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module">  
                            <tr>
                                <td colspan="2" style="padding-top:0px; text-align:left">
                                    <%--<telerik:RadButton ID="btn_save" runat="server" Text="Save" CssClass="btn-wrapper" ForeColor="White" OnClick="btn_save_Click"
                                    Skin="Material" ></telerik:RadButton>--%>
                                    <asp:ImageButton runat="server" ID="btnSave" AlternateText="New" OnClick="btn_save_Click" ToolTip="Save" Visible="true"
                                    Height="30px" Width="32px" ImageUrl="~/Images/simpan.png"></asp:ImageButton>
                                </td>
                            </tr>              
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Reg. Number" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_reg_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                        Text='<%# DataBinder.Eval(Container, "DataItem.trans_id") %>'
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
                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.trans_date") %>'
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
                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.EstExcDate") %>'
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
                                        Text='<%# DataBinder.Eval(Container, "DataItem.statusName") %>' 
                                        OnItemsRequested="cb_status_ItemsRequested"
                                        OnSelectedIndexChanged="cb_status_SelectedIndexChanged"
                                        OnPreRender="cb_status_PreRender" >
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
                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="150px"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" AutoPostBack="false" CausesValidation="false" Skin="Telerik" 
                                        Text='<%# DataBinder.Eval(Container, "DataItem.prio_desc") %>'
                                        OnItemsRequested="cb_priority_ItemsRequested"
                                        OnSelectedIndexChanged="cb_priority_SelectedIndexChanged"
                                        OnPreRender="cb_priority_PreRender"
                                        EnableVirtualScrolling="true" >
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
                                    <%--<asp:UpdatePanel runat="server">
                                        <ContentTemplate>--%>
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                            CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                            Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>'
                                            ID="cb_project" 
                                            Width="250px" 
                                            AutoPostBack="true"
                                            OnItemsRequested="cb_project_ItemsRequested"
                                            OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                            OnPreRender="cb_project_PreRender" >
                                            </telerik:RadComboBox>
                                       <%-- </ContentTemplate>
                                    </asp:UpdatePanel>--%>
                                           
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Ref. Number" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                        CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"  
                                        Text='<%# DataBinder.Eval(Container, "DataItem.pm_id") %>'
                                        DropDownWidth="1000px" 
                                        ID="cb_reff" 
                                        Width="250px"
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
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Req. Date" CssClass="lbObject" ForeColor="Transparent"></telerik:RadLabel>
                                </td>
                                <td>
                                    <%--<telerik:RadDateTimePicker ID="dtp_reqDate" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Silk">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                        <DateInput runat="server" Enabled="false" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"> 
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDateTimePicker>--%>
                                    <telerik:RadTextBox ID="txt_reqDate" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" BorderStyle="None"
                                            Skin="Silk"   >
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
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                            CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.unit_code") %>'
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
                                
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Model No " CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_unit_name" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                    Text='<%# DataBinder.Eval(Container, "DataItem.model_no") %>' Skin="Telerik">
                                    </telerik:RadTextBox>                           
                                </td>
                            </tr>
                            <tr>
                                <td style="width:130px">
                                    <telerik:RadLabel runat="server" Text="HM reading " CssClass="lbObject"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="hmValidator" ControlToValidate="txt_hm" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ID="txt_hm" runat="server" Width="100px" ReadOnly="false" RenderMode="Lightweight"
                                        DBValue='<%# DataBinder.Eval(Container, "DataItem.time_reading") %>' 
                                        ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true" EnabledStyle-HorizontalAlign="Right"
                                        onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                        AutoPostBack="false" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2" Skin="Telerik">
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr> 
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="HM Est. Accum. " CssClass="lbObject"></telerik:RadLabel>
                                  
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ID="txt_hmEstAccum" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight"
                                        DBValue='<%# DataBinder.Eval(Container, "DataItem.hmEstAccum") %>'  
                                        ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true" EnabledStyle-HorizontalAlign="Right"
                                        onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                        AutoPostBack="false" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2" Skin="Telerik">
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr> 
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Order Type " CssClass="lbObject"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="cb_orderType" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td>
                               
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                        CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.OrderName") %>' 
                                        ID="cb_orderType" 
                                        Width="250px" 
                                        AutoPostBack="true"
                                        DropDownWidth="250px" ForeColor="#003300"
                                        OnItemsRequested="cb_orderType_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_orderType_SelectedIndexChanged"
                                        OnPreRender="cb_orderType_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr> 
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Job Type " CssClass="lbObject"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ControlToValidate="cb_jobType" ForeColor="Red" 
                                        Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                        CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                        Text='<%# DataBinder.Eval(Container, "DataItem.PMAct_Name") %>' 
                                        ID="cb_jobType" 
                                        Width="250px" 
                                        AutoPostBack="false" 
                                        DropDownWidth="250px"
                                        OnItemsRequested="cb_jobType_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_jobType_SelectedIndexChanged"
                                        OnPreRender="cb_jobType_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <telerik:RadLabel runat="server" Text="JSA" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                        CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.jsa_name") %>' 
                                        ID="cb_jsa" 
                                        Width="250px" 
                                        AutoPostBack="false"
                                        DropDownWidth="450px"                                             
                                        OnItemsRequested="cb_jsa_ItemsRequested"
                                        OnSelectedIndexChanged="cb_jsa_SelectedIndexChanged"
                                        OnPreRender="cb_jsa_PreRender" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>           
                    </td>
                    <td style="vertical-align: top; padding-left:15px">
                        <table id="Table4" border="0" class="module">
                            <tr>
                                <td >
                                    <telerik:RadLabel runat="server" Text="Unit Status " CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <%--<asp:UpdatePanel runat="server">
                                        <ContentTemplate>--%>
                                            <asp:CheckBox ID="chk_breakdown" runat="server" AutoPostBack="true" Text="Breakdown" Font-Size="12px"  CausesValidation="false"
                                            OnCheckedChanged="chk_breakdown_CheckedChanged" Checked='<%# DataBinder.Eval(Container, "DataItem.tDown") %>' OnPreRender="chk_breakdown_PreRender"  />
                                        <%--</ContentTemplate>
                                    </asp:UpdatePanel>       --%>                                 
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <telerik:RadLabel runat="server" Text="BD Date" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <%-- <asp:UpdatePanel runat="server">
                                        <ContentTemplate>--%>
                                            <telerik:RadDatePicker ID="dtp_breakdownDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.BDDate") %>' Enabled="false"
                                                TabIndex="4" Skin="Telerik" > 
                                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                                </DateInput>
                                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                            </telerik:RadDatePicker> 
                                            &nbsp                          
                                            <telerik:RadTimePicker ID="rtp_breakdownTime" runat="server" RenderMode="Lightweight" Width="80px" AutoPostBack="false"
                                               Enabled="false" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.breakdown_time") %>'></telerik:RadTimePicker> 
                                    <%--</ContentTemplate>
                                         <Triggers>
                                             <asp:AsyncPostBackTrigger ControlID="chk_breakdown" />
                                         </Triggers>
                                    </asp:UpdatePanel>     --%>                                        
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Exc. Start Date" CssClass="lbObject"></telerik:RadLabel>
                                </td>                
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadDatePicker ID="dtp_excStartDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.compstdate") %>'
                                        TabIndex="4" Skin="Telerik" > 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                    </telerik:RadDatePicker> 
                                    &nbsp
                          
                                    <telerik:RadTimePicker ID="rtp_excStartTime" runat="server" RenderMode="Lightweight" Width="80px" AutoPostBack="false"                                
                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.ext_start_time") %>'></telerik:RadTimePicker>   
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Exc. Finish Date" CssClass="lbObject"></telerik:RadLabel>
                                </td>                
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadDatePicker ID="dtp_excFinishDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"                                
                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.compfndate") %>'
                                        TabIndex="4" Skin="Telerik" > 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                    </telerik:RadDatePicker>  
                                    &nbsp
                                    <telerik:RadTimePicker ID="rtp_excFinishTime" runat="server" RenderMode="Lightweight" Width="80px" AutoPostBack="false"                               
                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.ext_fnish_time") %>'></telerik:RadTimePicker>            
                                </td>
                            </tr>                   
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Maint. Type" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                        CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.maintType") %>'
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
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Silk" 
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
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Silk" 
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
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Silk" 
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
                <tr>
                    <td colspan="5">
                        <table>
                            <tr>
                                <td class="tdLabel"> 
                                    <telerik:RadLabel runat="server" ID="lbl_userId" Width="100px" Text="User: " ForeColor="YellowGreen" Font-Italic="true" CssClass="lbObject" />
                                </td>
                                <td style="width: 240px; padding-left: 5px" class="tdLabel">
                                    <telerik:RadLabel runat="server" ID="lbl_lastUpdate" Width="220px" Text="Last Update: " ForeColor="YellowGreen" Font-Italic="true" CssClass="lbObject"/>
                                </td>
                                <td style="padding: 0px 10px 0px 10px" class="tdLabel"> 
                                    <telerik:RadLabel runat="server" ID="lbl_Owner" Width="100px" Text="Owner: " ForeColor="YellowGreen" Font-Italic="true" CssClass="lbObject"/>
                                </td>
                                <td style="padding: 0px 10px 0px 10px" class="tdLabel">
                                    <telerik:RadLabel runat="server" ID="lbl_edited" Width="100px" Text="Edited: " ForeColor="YellowGreen" Font-Italic="true" CssClass="lbObject"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>       
            </table>
        </div>
        <div style="padding: 5px 15px 10px 15px;">
            <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip2" 
            SelectedIndex="1" MultiPageID="RadMultiPage2" Skin="Silk" CausesValidation="False">
            <Tabs>
                <telerik:RadTab Text="Component" Height="20px" Visible="true"> 
                </telerik:RadTab>
                <telerik:RadTab Text="DMBD" Height="20px"  Visible="true" Selected="True" >
                </telerik:RadTab>
                <telerik:RadTab Text="External Service" Height="20px"  Visible="true"> 
                </telerik:RadTab>
                <telerik:RadTab Text="Operation" Height="20px" Visible="true">
                </telerik:RadTab>  
                <telerik:RadTab Text="Material Request" Height="20px" Visible="true">
                </telerik:RadTab>             
            </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage runat="server" ID="RadMultiPage2"  SelectedIndex="1" >
                <telerik:RadPageView runat="server" ID="RadPageView1" Height="290px" >
                    <table>
                        <tr>
                            <td>
                                <telerik:RadLabel runat="server" Text="Comp. Group " CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_compGroup" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                            </td>
                            <td>
                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Silk" 
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
                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Silk" 
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
                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Silk" 
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
                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Silk" 
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
                                    runat="server" TextMode="MultiLine" Font-Size="X-Small"
                                    Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>                    
                </telerik:RadPageView>               
                <telerik:RadPageView runat="server" ID="RadPageView2" Height="290px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="3"  Skin="Silk"
                        AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True"  
                        OnNeedDataSource="RadGrid2_NeedDataSource" 
                        OnInsertCommand="RadGrid2_InsertCommand" 
                        OnUpdateCommand="RadGrid2_UpdateCommand"                        
                        OnDeleteCommand="RadGrid2_DeleteCommand" 
                        OnItemCommand="RadGrid2_ItemCommand"
                        ShowStatusBar="true">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader" ForeColor="Teal" Font-Size="11px"/>
                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="trans_id,status,down_date,down_time" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New" InsertItemDisplay="Bottom">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowCancelChangesButton="False" />                                    
                            <Columns>
                                <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                                    <HeaderStyle Width="40px"/>
                                    <ItemStyle Width="60px" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-Width="110px"  ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <telerik:RadDatePicker runat="server" ID="trans_date" Width="110px"  Skin="Silk"
                                        DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.down_date")%>' 
                                        onkeydown="blurTextBox(this, event)" Type="Date">
                                        <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                    </telerik:RadDatePicker>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadDatePicker runat="server" ID="trans_date_edt" Width="120px" Skin="Silk"
                                        DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.down_date")%>'                                        
                                        onkeydown="blurTextBox(this, event)" Type="Date">
                                        <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <%--<InsertItemTemplate>
                                    <telerik:RadDatePicker runat="server" ID="trans_date_edt" Width="120px" Skin="Silk"                                                                              
                                        onkeydown="blurTextBox(this, event)" Type="Date">
                                        <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                    </telerik:RadDatePicker>
                                </InsertItemTemplate>--%>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn HeaderText="Down" HeaderStyle-Width="50px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>                                        
                                        <%--<asp:Label runat="server" ID="lbl_down_time" Text='<%# DataBinder.Eval(Container.DataItem, "down_time") %>'></asp:Label>--%>
                                        <telerik:RadTimePicker ID="rtp_breakdownTimeitem" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.down_time") %>' runat="server" 
                                            RenderMode="Lightweight" Width="70px" AutoPostBack="false"></telerik:RadTimePicker> 
                                        </ItemTemplate>
                                    <EditItemTemplate>                                       
                                        <telerik:RadTimePicker ID="rtp_breakdownTime" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.down_time") %>' runat="server" 
                                            RenderMode="Lightweight" Width="70px" AutoPostBack="false"></telerik:RadTimePicker> 
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Act" HeaderStyle-Width="50px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                   ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>                                        
                                        <telerik:RadTimePicker ID="rtp_breakdownActItem" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.down_act") %>' runat="server" 
                                            RenderMode="Lightweight" Width="70px" AutoPostBack="false"></telerik:RadTimePicker>  
                                        </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTimePicker ID="rtp_breakdownAct" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.down_act") %>' runat="server" 
                                            RenderMode="Lightweight" Width="70px" AutoPostBack="false"></telerik:RadTimePicker>  
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Up" HeaderStyle-Width="50px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                    ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>                                        
                                        <telerik:RadTimePicker ID="rtp_breakdownUpItem" runat="server" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.down_up") %>' 
                                            RenderMode="Lightweight" Width="70px" AutoPostBack="false"></telerik:RadTimePicker>  
                                        </ItemTemplate>
                                    <EditItemTemplate>                                        
                                        <telerik:RadTimePicker ID="rtp_breakdownUp" runat="server" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.down_up") %>' 
                                            RenderMode="Lightweight" Width="70px" AutoPostBack="false"></telerik:RadTimePicker>  
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>                                
                                <telerik:GridTemplateColumn HeaderText="Status" HeaderStyle-Width="80px" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" 
                                  ItemStyle-HorizontalAlign="Center">
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
                                            <table style="width: 670px; font-size:smaller">
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
                                            <table style="width: 670px; font-size:smaller">
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
                                
                                <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="380px" ItemStyle-Width="500px" HeaderStyle-HorizontalAlign="Center" 
                                    >
                                    <ItemTemplate>                                        
                                        <asp:Label runat="server" ID="lbl_remark" Text='<%# DataBinder.Eval(Container.DataItem, "remark_activity") %>'></asp:Label>
                                        </ItemTemplate>
                                    <EditItemTemplate>                                        
                                        <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_remark" Width="500px" 
                                            Text='<%# DataBinder.Eval(Container.DataItem, "remark_activity") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Run" HeaderStyle-Width="30px" ItemStyle-Width="30px" Visible="false">
                                    <ItemTemplate>                                        
                                        <asp:Label runat="server" ID="lbl_runItem" Text='<%# DataBinder.Eval(Container.DataItem, "run") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>                                        
                                        <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="lbl_runEdit" Width="30px"  ReadOnly="true"
                                            Text='<%# DataBinder.Eval(Container.DataItem, "run") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>                                        
                                        <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="lbl_runInsert" Width="30px" ReadOnly="true"
                                            Text="0">
                                        </telerik:RadTextBox>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView3" Height="290px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" AutoGenerateColumns="false" PageSize="3"  Skin="Silk"
                        AllowPaging="true" AllowSorting="true" runat="server" Width="100%" 
                        OnNeedDataSource="RadGrid3_NeedDataSource" 
                        OnInsertCommand="RadGrid3_InsertCommand"
                        OnUpdateCommand="RadGrid3_UpdateCommand"
                        OnDeleteCommand="RadGrid3_DeleteCommand"
                        ShowStatusBar="true">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader" ForeColor="Teal" Font-Size="11px" />
                        <MasterTableView CommandItemDisplay="Bottom" DataKeyNames="sup_code" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New" InsertItemDisplay="Bottom">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                            <Columns>
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                    HeaderText="Edit" HeaderStyle-Width="70px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridEditCommandColumn>
                                <%--<telerik:GridDateTimeColumn UniqueName="trans_date" HeaderText="Date" DataField="trans_date" ItemStyle-Width="100px" 
                                        EnableRangeFiltering="false" PickerType="DatePicker" 
                                        DataFormatString="{0:d}" >
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle Width="100px" />
                                </telerik:GridDateTimeColumn>--%>
                                <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-Width="100px" ItemStyle-Width="100px" 
                                    HeaderStyle-HorizontalAlign="Center"  HeaderStyle-ForeColor="#009900"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <telerik:RadDatePicker runat="server" ID="dtpDate" Width="100px"
                                            DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.trans_date")%>' 
                                            onkeydown="blurTextBox(this, event)" Type="Date">
                                            <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                        </telerik:RadDatePicker>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Supplier Code" HeaderStyle-Width="120px" ItemStyle-Width="120px" 
                                    HeaderStyle-HorizontalAlign="Center"  HeaderStyle-ForeColor="#009900"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_SupCode" Text='<%# DataBinder.Eval(Container.DataItem, "sup_code") %>'></asp:Label>
                                    </ItemTemplate>                                    
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Supplier" HeaderStyle-Width="320px" ItemStyle-Width="320px" 
                                    HeaderStyle-HorizontalAlign="Center"  HeaderStyle-ForeColor="#009900"
                                    ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_SupName" Text='<%# DataBinder.Eval(Container.DataItem, "supplier_name") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_supplier" EnableLoadOnDemand="True" DataTextField="supplier_name"
                                            DataValueField="supplier_code" AutoPostBack="true" 
                                            Text='<%# DataBinder.Eval(Container, "DataItem.supplier_name") %>'
                                            HighlightTemplatedItems="true" Width="320px" DropDownWidth="550px" DropDownAutoWidth="Enabled" 
                                            OnItemsRequested="cb_supplier_ItemsRequested" 
                                            OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged" >                                                   
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
                                     HeaderStyle-ForeColor="#009900">
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
                                     HeaderStyle-ForeColor="#009900" DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
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
                                    ButtonType="FontIconButton" ItemStyle-Width="70px" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Red">
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>                    
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView4" Height="290px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid4" GridLines="None" AutoGenerateColumns="false" PageSize="3"  Skin="Silk"
                        AllowPaging="true" AllowSorting="true" runat="server" Width="550px" 
                        OnNeedDataSource="RadGrid4_NeedDataSource" 
                        OnInsertCommand="RadGrid4_InsertCommand" 
                        OnDeleteCommand="RadGrid4_DeleteCommand"
                        ShowStatusBar="true">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader" ForeColor="Teal" Font-Size="11px" />
                        <MasterTableView CommandItemDisplay="Bottom" DataKeyNames="chart_code" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" EditItemStyle-Height="15px" EditItemStyle-ForeColor="#3366CC" 
                            InsertItemDisplay="Bottom" CommandItemSettings-AddNewRecordText="New" CommandItemStyle-Height="20px">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="true"
                                ShowCancelChangesButton="false" />
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                            
                            <Columns>              
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900"
                                    HeaderText="Edit" HeaderStyle-Width="60px" ItemStyle-Width="60px" UpdateText="Update" >
                                </telerik:GridEditCommandColumn>                  
                                <telerik:GridTemplateColumn HeaderText="Opr. Code" HeaderStyle-Width="120px" ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_chart_code" Text='<%# DataBinder.Eval(Container.DataItem, "chart_code") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Maintenance Operation" HeaderStyle-Width="200px" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Left" 
                                        HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_OprName" Width="150px" Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>                                 
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation" EnableLoadOnDemand="True" DataTextField="OprCode"
                                            DataValueField="OprCode" AutoPostBack="true" CausesValidation="false"
                                            HighlightTemplatedItems="true" Width="180px" DropDownWidth="400px" DropDownAutoWidth="Enabled" 
                                        Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'
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
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView5" Height="290px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid5" GridLines="None" AutoGenerateColumns="false" PageSize="5" Skin="Silk"
                        AllowPaging="true" AllowSorting="true" runat="server" 
                        OnNeedDataSource="RadGrid5_NeedDataSource"
                        OnInsertCommand="RadGrid5_InsertCommand"
                        OnUpdateCommand="RadGrid5_InsertCommand" 
                        OnEditCommand="RadGrid5_EditCommand"
                        OnDeleteCommand="RadGrid5_DeleteCommand" >
                        <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                        <HeaderStyle CssClass="gridHeader" ForeColor="Teal" Font-Size="11px" />
                        <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="part_code, sro_code" Font-Size="11px" EditMode="InPlace"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New" InsertItemDisplay="Top">
                            <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowCancelChangesButton="False" SaveChangesText="Save" 
                                CancelChangesText="Cancel" ShowPrintButton="true" />
                                                   
                            <Columns>
                                <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                    HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update" ItemStyle-Width="60px" >
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn HeaderText="MR. Code" HeaderStyle-Width="120px" ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_trans_id" Width="120px" Text='<%# DataBinder.Eval(Container.DataItem, "sro_code") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:Label runat="server" ID="lbl_trans_id_insert" Width="120px"></asp:Label>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Operation" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Left" 
                                        HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_operation" Width="150px" Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>                                 
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation" EnableLoadOnDemand="True" DataTextField="OprCode"
                                            DataValueField="OprCode" AutoPostBack="true" CausesValidation="false" Enabled="false"
                                            HighlightTemplatedItems="true" Width="150px" DropDownWidth="300px" DropDownAutoWidth="Enabled" 
                                            Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'
                                            OnItemsRequested="cb_MR_operation_ItemsRequested" 
                                            OnPreRender="cb_MR_operation_PreRender"
                                            OnSelectedIndexChanged="cb_MR_operation_SelectedIndexChanged">                                                   
                                            <HeaderTemplate>
                                            <table style="width: 300px; font-size:smaller">
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
                                                <table style="width: 300px; font-size:smaller">
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
                                <InsertItemTemplate>
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_operation_insertTemp" EnableLoadOnDemand="True" DataTextField="OprCode"
                                        DataValueField="OprCode" AutoPostBack="true" CausesValidation="false"
                                        HighlightTemplatedItems="true" Width="150px" DropDownWidth="300px" DropDownAutoWidth="Enabled" 
                                        OnItemsRequested="cb_MR_operation_ItemsRequested"
                                        OnSelectedIndexChanged="cb_MR_operation_SelectedIndexChanged">                                                   
                                        <HeaderTemplate>
                                        <table style="width: 300px; font-size:smaller">
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
                                            <table style="width: 300px; font-size:smaller">
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
                                </InsertItemTemplate>
                                </telerik:GridTemplateColumn>
                                <%--<telerik:GridTemplateColumn HeaderText="Opr. Code" HeaderStyle-Width="100px" ItemStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_chart_code" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "chart_code") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>  --%>                                         
                                <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_prodType" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                                    </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label runat="server" ID="lbl_prodType_editTemp" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>
                                </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:Label runat="server" ID="lbl_prodType_insertTemp" Width="50px" ></asp:Label>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="130px" ItemStyle-Width="130px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_partCode" Width="130px" Text='<%# DataBinder.Eval(Container.DataItem, "part_code") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="Prod_code"
                                            DataValueField="Prod_code" AutoPostBack="true" Enabled="false"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.part_code") %>' EmptyMessage="- Select product -"
                                            HighlightTemplatedItems="true" Width="130px" DropDownWidth="450px" DropDownAutoWidth="Enabled" 
                                            OnItemsRequested="cb_prod_code_ItemsRequested"
                                            OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged"  >                                                   
                                            <HeaderTemplate>
                                            <table style="width: 450px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 230px;">
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
                                            <table style="width: 450px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 230px;">
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
                                    <InsertItemTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code_insertTemp" EnableLoadOnDemand="True" DataTextField="spec"
                                            DataValueField="prod_code" AutoPostBack="true"
                                            EmptyMessage="- Search product name here -"
                                            HighlightTemplatedItems="true" Height="190px" Width="130px" DropDownWidth="450px"
                                            OnItemsRequested="cb_prod_code_ItemsRequested" 
                                            OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged">                                                   
                                            <HeaderTemplate>
                                            <table style="width: 450px; font-size:smaller">
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
                                            <table style="width: 450px; font-size:smaller">
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
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblPartQty" Width="70px" Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="70px"  ReadOnly="false" 
                                            EnabledStyle-HorizontalAlign="Right"
                                            NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'
                                            onkeydown="blurTextBox(this, event)"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2">
                                        </telerik:RadNumericTextBox>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty_insertTemp" Width="70px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"                                                
                                            onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2" >
                                        </telerik:RadNumericTextBox>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>
                                <%--<telerik:GridTemplateColumn HeaderText="QRS" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_qtyRs" Text='<%# DataBinder.Eval(Container.DataItem, "part_qty", "{0:#,###,###0.00}") %>'>
                                        </asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>                                        
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qtyRs_editTemp" Width="70px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                            DbValue='<%# Convert.ToDouble(Eval("part_qty", "{0:#,###,###0.00}")) %>'
                                            onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2" >
                                        </telerik:RadNumericTextBox>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_qtyRs_insertTemp" Width="70px" NumberFormat-AllowRounding="true"
                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"                                                
                                            onkeydown="blurTextBox(this, event)" ReadOnly="false"
                                            AutoPostBack="true" MaxLength="11" Type="Number"
                                            NumberFormat-DecimalDigits="2" >
                                        </telerik:RadNumericTextBox>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>--%>
                                <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="50px" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_UoM" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label runat="server" ID="lbl_UoM_editTemp" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "part_unit") %>'></asp:Label>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:Label runat="server" ID="lbl_UoM_insertTemp" Width="50px" ></asp:Label>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Waranty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chk_waranty" Text="Warranty" Width="70px"
                                            Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="false" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox runat="server" ID="chk_waranty_editTemp" Width="70px" Text="Warranty"  Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' Enabled="true" />
                                    </EditItemTemplate> 
                                    <InsertItemTemplate>
                                        <asp:CheckBox runat="server" ID="chk_waranty_insertTemp" Width="70px" Text="Warranty" Enabled="true" />
                                    </InsertItemTemplate>                                         
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="310px" ItemStyle-Width="310px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-ForeColor="#009900">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbl_remark" Width="310px" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_editTemp" Width="310px"
                                            Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_insertTemp" Width="310px"
                                        ></telerik:RadTextBox>
                                    </InsertItemTemplate>
                                </telerik:GridTemplateColumn>                                
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                                     HeaderStyle-ForeColor="#009900" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ItemStyle-ForeColor="Red"
                                    ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                </telerik:GridButtonColumn>

                            </Columns>
                        </MasterTableView>
                        <ClientSettings>                         
                                <%--<Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="273px" />--%>
                            </ClientSettings>
                    </telerik:RadGrid>
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
