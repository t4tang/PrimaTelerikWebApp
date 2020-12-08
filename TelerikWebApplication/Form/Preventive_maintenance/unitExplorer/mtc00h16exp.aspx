<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc00h16exp.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.unitExplorer.mtc00h16exp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
            <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
        </ContentTemplate>        
    </asp:UpdatePanel> 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <%--<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <%--<AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_unit2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_model2" />
                </UpdatedControls> 
            </telerik:AjaxSetting> 
            <telerik:AjaxSetting AjaxControlID="btnSearch3">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_unit3" />
                    <telerik:AjaxUpdatedControl ControlID="txt_model3" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch4">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_unit4" />
                    <telerik:AjaxUpdatedControl ControlID="txt_model4" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch5">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_unit5" />
                    <telerik:AjaxUpdatedControl ControlID="txt_model5" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch6">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_unit6" />
                    <telerik:AjaxUpdatedControl ControlID="txt_model6" />
                </UpdatedControls>
            </telerik:AjaxSetting> 
            <telerik:AjaxSetting AjaxControlID="btnSearch7">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_unit7" />
                    <telerik:AjaxUpdatedControl ControlID="txt_model7" />
                </UpdatedControls>
            </telerik:AjaxSetting>          
        </AjaxSettings>--%>
    </telerik:RadAjaxManager>--%>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 170px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="2000" BackgroundPosition="Center"></telerik:RadAjaxLoadingPanel>

    <div style="padding-left: 15px; ">
        <table id="tbl_control">
            <tr> 
                <td style="width: 100%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

    <div >
        <div style="padding: 0px 0px 0px 10px; display:inline; float:left" >
            <h3 style="padding: 0px 0px 0px 10px">Vehicle/Equipment</h3>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <telerik:RadTreeView RenderMode="Lightweight" ID="RadTreeView1" runat="server" OnNodeClick="RadTreeView1_NodeClick"  Width="200px" Height="570px"
                         Skin="Telerik" Font-Size="11px">
                        <DataBindings>
                            <telerik:RadTreeNodeBinding Expanded="False"></telerik:RadTreeNodeBinding>
                        </DataBindings>
                    </telerik:RadTreeView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="demo-container size-thin" style="display:inline; float:left; width:1050px;">
             <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip2" Font-Size="11px"
            SelectedIndex="0" MultiPageID="RadMultiPage2" Skin="Telerik" CausesValidation="False">
            <Tabs>
                <telerik:RadTab Text="General Information" Height="15px" Visible="true"> 
                </telerik:RadTab>
                <telerik:RadTab Text="Finance" Height="15px"  Visible="true">
                </telerik:RadTab>
                <telerik:RadTab Text="Rego/Waranty" Height="15px"  Visible="true"> 
                </telerik:RadTab>
                <telerik:RadTab Text="WO Explorer" Height="15px" Visible="true">
                </telerik:RadTab>  
                <telerik:RadTab Text="Material Request" Height="15px" Visible="true">
                </telerik:RadTab> 
                <telerik:RadTab Text="Historical Mayor Rapair" Height="15px" Visible="true">
                </telerik:RadTab>    
                <telerik:RadTab Text="Reading Recording" Height="15px" Visible="true">
                </telerik:RadTab> 
                <telerik:RadTab Text="Notification" Height="15px" Visible="true">
                </telerik:RadTab> 
                <telerik:RadTab Text="WO Backlog" Height="15px" Visible="true">
                </telerik:RadTab>               
            </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage runat="server" ID="RadMultiPage2"  SelectedIndex="0" Width="97%" >
                <telerik:RadPageView runat="server" ID="RadPageView1" Height="600px">                
                    <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td colspan="3" style="background-color:lightseagreen; text-align:center">
                                        <telerik:RadLabel runat="server" id="lbl_unit_description" style="font-size:large; background-color:lightseagreen;color:white"></telerik:RadLabel>  
                                    <%--<telerik:RadLabel runat="server" Text="Unit Description" Font-Size="Medium" Font-Bold="true" ForeColor="White"></telerik:RadLabel>--%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <telerik:RadLabel runat="server" Text="Unit Detail" Font-Size="Small" Font-Bold="true" Font-Underline="true" 
                                        ForeColor="deepskyblue"></telerik:RadLabel>
                                </td>
                            </tr>
                            <tr>
                                <td style="vertical-align:top">
                                    <table>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Equipment Type " CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_eqp_type" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik" >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Equipment Kind " CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_eqp_kind" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Manufacture" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_manufacture" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Model No" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_model" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Status" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_status" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Reading Type" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_reading_type" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                                &nbsp
                                                <telerik:RadLabel runat="server" Text="Or" CssClass="lbObject"></telerik:RadLabel>
                                                <telerik:RadTextBox ID="txt_readType2" runat="server" Width="50px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="opr. Hours" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_opr_hours" runat="server" Width="50px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                                <telerik:RadLabel runat="server" Text="Per day" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Active" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                        
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Category" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_category" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Class" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_class" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
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
                                <td style="vertical-align:top">
                                    <table>
                                
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Supplier" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_supplier" runat="server" Width="300px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Purchase Date" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_purc_date" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                                <%--<telerik:RadDatePicker ID="dtp_purc_date"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
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
                                                </telerik:RadDatePicker>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Arrived Date" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_arrived_date" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                                <%--<telerik:RadDatePicker ID="dtp_arrived_date"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
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
                                                </telerik:RadDatePicker>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Engine No." CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_engine_no" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Engine Model" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_engine_model" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="S/N" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_sn" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Condition" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_condition" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Job Site" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_project" runat="server" Width="250px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Year" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_year" runat="server" Width="50px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            &nbsp <telerik:RadLabel runat="server" Text="Seating Capacity" CssClass="lbObject"></telerik:RadLabel>
                                                <telerik:RadTextBox ID="txt_seat_cap" runat="server" Width="50px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
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
                                <td style="vertical-align:top">
                                    <table>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="VIN/Chasis" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_chasis" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="No. Cylinders" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_no_cylinder" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Transmission" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_transmission" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Radio No" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_radio_no" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="S/N Sarana" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_sn_sarana" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Expected Lifetime" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_exp_lifetime" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Unschedule B/D" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_unschedule_bd" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Schedule B/D" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_schedule_bd" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                                <td >
                                                <telerik:RadLabel runat="server" Text="Tank Capacity" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_tank_capacity" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
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
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td style="vertical-align:top">
                                    <table>
                                        <tr>
                                            <td colspan="4">
                                                <telerik:RadLabel runat="server" Text="Tyre" Font-Size="Small" Font-Bold="true" Font-Underline="true" 
                                                    ForeColor="deepskyblue"></telerik:RadLabel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <telerik:RadLabel runat="server" Text="Tyre Size Steer" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_steer_size" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                                &nbsp<telerik:RadLabel runat="server" Text="No Of" CssClass="lbObject"></telerik:RadLabel>
                                                <telerik:RadTextBox ID="txt_noOf_steer_size" runat="server" Width="63px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <telerik:RadLabel runat="server" Text="Tyre Size Drive" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_tyre_size_drive" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                                &nbsp<telerik:RadLabel runat="server" Text="No Of" CssClass="lbObject"></telerik:RadLabel>
                                                <telerik:RadTextBox ID="txt_noOf_tyre_size_drive" runat="server" Width="63px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <telerik:RadLabel runat="server" Text="Wheel Base" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_wheel_base" runat="server" Width="50px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                                &nbsp<telerik:RadLabel runat="server" Text="Wheel Drive" CssClass="lbObject"></telerik:RadLabel>
                                                <telerik:RadTextBox ID="txt_wheel_drive" runat="server" Width="50px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <telerik:RadLabel runat="server" Text="No Of Axles" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_no_of_axles" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
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
                                <td style="vertical-align:top">
                                    <table>
                                        <tr>
                                            <td colspan="4">
                                                <telerik:RadLabel runat="server" Text="Weight/Dimension" Font-Size="Small" Font-Bold="true" Font-Underline="true" 
                                                    ForeColor="deepskyblue"></telerik:RadLabel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <telerik:RadLabel runat="server" Text="Tare Weight" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_tare_weight" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                                &nbsp<telerik:RadLabel runat="server" Text="Height" CssClass="lbObject"></telerik:RadLabel>
                                                <telerik:RadTextBox ID="txt_height" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <telerik:RadLabel runat="server" Text="Gross Weight" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_gross_weight" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                                &nbsp<telerik:RadLabel runat="server" Text="Width" CssClass="lbObject"></telerik:RadLabel>&nbsp
                                                <telerik:RadTextBox ID="txt_width" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <telerik:RadLabel runat="server" Text="Color" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_color" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                                &nbsp<telerik:RadLabel runat="server" Text="Lenght" CssClass="lbObject"></telerik:RadLabel>
                                                <telerik:RadTextBox ID="txt_lenght" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
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
                                <td style="vertical-align:top">
                                    <table>
                                        <tr>
                                            <td colspan="4">
                                                <telerik:RadLabel runat="server" Text="Fuel Detail" Font-Size="Small" Font-Bold="true" Font-Underline="true" 
                                                    ForeColor="deepskyblue"></telerik:RadLabel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <telerik:RadLabel runat="server" Text="Primary Fuel" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_primary_fuel" runat="server" Width="80px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                                &nbsp<telerik:RadLabel runat="server" Text="Tank Capacity" CssClass="lbObject"></telerik:RadLabel>
                                                <telerik:RadTextBox ID="txt_primary_tank_capacity" runat="server" Width="60px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <telerik:RadLabel runat="server" Text="Secondary Fuel" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_secondary_fuel" runat="server" Width="80px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                                &nbsp<telerik:RadLabel runat="server" Text="Tank Capacity" CssClass="lbObject"></telerik:RadLabel>
                                                <telerik:RadTextBox ID="txt_secondary_fuel_capacity" runat="server" Width="60px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
                                                    <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                    <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                    <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                    <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                    <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <telerik:RadLabel runat="server" Text="Tank Unit" CssClass="lbObject"></telerik:RadLabel>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_tank_unit" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik"  >
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
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td colspan="4">
                                    <telerik:RadLabel runat="server" Text="Machinery Inspection" Font-Size="Small" Font-Bold="true" Font-Underline="true" 
                                        ForeColor="deepskyblue"></telerik:RadLabel>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <telerik:RadLabel runat="server" Text="Machinery Inspect Done" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_inspect_done" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                            Skin="Telerik"  >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <telerik:RadLabel runat="server" Text="Certificate No" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_certificate_no" runat="server" Width="70px" ReadOnly="true" RenderMode="Lightweight" 
                                            Skin="Telerik"  >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <telerik:RadLabel runat="server" Text="Next Due" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_next_due" runat="server" Width="50px" ReadOnly="true" RenderMode="Lightweight" 
                                            Skin="Telerik"  >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                    </telerik:RadTextBox>
                                </td>
                            </tr>                    
                        </table>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="RadTreeView1" />
                    </Triggers>
                </asp:UpdatePanel>  
                </telerik:RadPageView>

                <telerik:RadPageView runat="server" ID="RadPageView2" Height="600px" Visible="True">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td colspan="3" style="background-color:lightseagreen; text-align:center">
                                        <telerik:RadLabel runat="server" id="lbl_finance_description" style="font-size:large; background-color:lightseagreen;color:white"></telerik:RadLabel>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align:top">
                                        <table>
                                            <tr>
                                                <td colspan="4">
                                                    <telerik:RadLabel runat="server" Text="Purchase Detail" Font-Size="Small" Font-Bold="true" Font-Underline="true" 
                                                        ForeColor="deepskyblue"></telerik:RadLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Purchase Date" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_pur_date" Width="120px" ReadOnly="true" RenderMode="Lightweight" 
                                                        Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Arrived Purchase" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_arrived_pur" Width="120px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Condition" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_con_pur" Width="100px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Purchase Cost" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_pur_cost" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Order Number" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_ord_no" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                    <td style="vertical-align:top">
                                        <table>
                                            <tr>
                                                <td colspan="4">
                                                    <telerik:RadLabel runat="server" Text="Depreciation" Font-Size="Small" Font-Bold="true" Font-Underline="true" 
                                                        ForeColor="deepskyblue"></telerik:RadLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Expected Life(Yrs)" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_expect_life" Width="80px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
                                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                    </telerik:RadTextBox>
                                                    &nbsp
                                                    <telerik:RadLabel runat="server" Text="Or" CssClass="lbObject"></telerik:RadLabel>
                                                    <telerik:RadTextBox runat="server" ID="txt_expect_life_hour" Width="50px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
                                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                    </telerik:RadTextBox>
                                                    <telerik:RadLabel runat="server" Text="Hours" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Depreciation Type" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_depre_type" Width="180px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Salvage Value" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_sal_value" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Appreciation" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_appre" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Current Value" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_curr_value" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td style="vertical-align:top">
                                        <table>
                                            <tr>
                                                <td colspan="4"> 
                                                    <telerik:RadLabel runat="server" Text="Value" Font-Size="Small" Font-Bold="true" Font-Underline="true" 
                                                        ForeColor="deepskyblue"></telerik:RadLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Market Value" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_market_value" Width="180px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Replacement Value" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_replace_value" Width="180px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Change Over Value" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_ch_over_value" Width="180px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Last Evaluation Date" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_last_eva_date" Width="180px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Next Evaluation Date" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_next_eva_date" Width="180px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                    <td style="vertical-align:top">
                                        <table>
                                            <tr>
                                                <td colspan="4">
                                                    <telerik:RadLabel runat="server" Text="Selling Details" Font-Size="Small" Font-Bold="true" Font-Underline="true" 
                                                        ForeColor="deepskyblue">
                                                    </telerik:RadLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Date Sold" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_date_sold" Width="120px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Actual Resale Value" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_resale_value" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Replaced Vehicle" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_repla_vehic" Width="180px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                </tr>
                            </table>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="RadTreeView1" />
                        </Triggers>
                    </asp:UpdatePanel>
                </telerik:RadPageView>

                <telerik:RadPageView runat="server" ID="RadPageView3" Height="600px" Visible="True">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td colspan="3" style="background-color:lightseagreen; text-align:center">
                                        <telerik:RadLabel runat="server" id="lbl_RegoWarranty" style="font-size:large; background-color:lightseagreen;color:white"></telerik:RadLabel>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align:top">
                                        <table>
                                            <tr>
                                                <td colspan="4">
                                                    <telerik:RadLabel runat="server" Text="Registration" Font-Size="Small" Font-Bold="true" Font-Underline="true" 
                                                        ForeColor="deepskyblue"></telerik:RadLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Reg No" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_reg_no" Width="120px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Inspect Date" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_inspect_date" Width="120px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Date Due" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_date_due" Width="120px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Cost" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_cost" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Licency Code" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_licen_code" Width="200px" RenderMode="Lightweight" Skin="Telerik">
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
                                    <td style="vertical-align:top">
                                        <table>
                                            <tr>
                                                <td colspan="4">
                                                    <telerik:RadLabel runat="server" Text="Warranty" Font-Size="Small" Font-Bold="true" Font-Underline="true" 
                                                        ForeColor="deepskyblue"></telerik:RadLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Start" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_start" Width="100px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
                                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                    </telerik:RadTextBox>
                                                    &nbsp
                                                    <telerik:RadLabel runat="server" Text="Finish" CssClass="lbObject"></telerik:RadLabel>
                                                    <telerik:RadTextBox runat="server" ID="txt_finish" Width="100px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Hours" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_hours" Width="100px" RenderMode="Lightweight" ReadOnly="true" Skin="Telerik">
                                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                    </telerik:RadTextBox>
                                                    &nbsp
                                                    <telerik:RadLabel runat="server" Text="Or" CssClass="lbObject"></telerik:RadLabel>
                                                    <telerik:RadTextBox runat="server" ID="txt_month" Width="100px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
                                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                                    </telerik:RadTextBox>
                                                    <telerik:RadLabel runat="server" Text="Month" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Warranty Supplier" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_war_sup" Width="250px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td style="vertical-align:top">
                                        <table>
                                            <tr>
                                                <td colspan="4">
                                                    <telerik:RadLabel runat="server" Text="Insurance Detail" Font-Size="Small" Font-Bold="true" Font-Underline="true" 
                                                        ForeColor="deepskyblue"></telerik:RadLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Insurance Value" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_insur_value" Width="150px" RenderMode="Lightweight" ReadOnly="true" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Renewal" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_renewal" Width="150px" RenderMode="Lightweight" ReadOnly="true" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Company" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_company" Width="200px" RenderMode="Lightweight" ReadOnly="true" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Policy Number" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_policy_no" Width="180px" RenderMode="Lightweight" ReadOnly="true" Skin="Telerik">
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
                                                    <telerik:RadLabel runat="server" Text="Premium" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_premium" Width="150px" RenderMode="Lightweight" ReadOnly="true" Skin="Telerik">
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
                                    <td style="vertical-align:top">
                                        <table>
                                            <tr>
                                                <td colspan="4">
                                                    <telerik:RadLabel runat="server" Text="FBT" Font-Size="Small" Font-Bold="true" Font-Underline="true" 
                                                        ForeColor="deepskyblue"></telerik:RadLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Private Use" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <asp:CheckBox runat="server" ID="chk_private_use" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="FBT Rate" CssClass="lbObject"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox runat="server" ID="txt_fbtRate" Width="150px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik">
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
                                </tr>
                            </table>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="RadTreeView1" />
                        </Triggers>
                    </asp:UpdatePanel>                                                     
                </telerik:RadPageView>

                <telerik:RadPageView runat="server" ID="RadPageView4" Height="600px" Visible="True">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Date From    :" ForeColor="DeepSkyBlue" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadDatePicker runat="server" ID="dtp_from" RenderMode="Lightweight" Width="150px" Skin="Telerik" DateInput-ReadOnly="false" 
                                            DateInput-DateFormat="dd/MM/yyyy">
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="To Date  :" ForeColor="DeepSkyBlue" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadDatePicker runat="server" ID="dtp_to" RenderMode="Lightweight" Width="150px" Skin="Telerik" DateInput-ReadOnly="false" 
                                            DateInput-DateFormat="dd/MM/yyyy">
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td colspan="2">
                                        <telerik:RadButton runat="server" ID="btnSearch2" Text="Filter" Width="95%" Height="35px" CausesValidation="false" Skin="Material" 
                                            ForeColor="DeepSkyBlue" OnClick="btnSearch2_Click">
                                        </telerik:RadButton>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Unit Code    :" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadTextBox runat="server" ID="txt_unit2" RenderMode="Lightweight" Width="150px" ReadOnly="true" Skin="Telerik">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Model No :" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadTextBox runat="server" ID="txt_model2" RenderMode="Lightweight" Width="150px" ReadOnly="true" Skin="Telerik">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                            </table>
                            <div class="scroller" runat="server">
                               <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <telerik:RadGrid runat="server" ID="RadGrid2" RenderMode="Lightweight" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false"  
                                            PageSize="10" Skin="Telerik" ShowFooter="false" GridLines="None" Width="100%" 
                                            OnNeedDataSource="Radgrid2_NeedDataSource" 
                                            OnInsertCommand="RadGrid2_InsertCommand">
                                            <PagerStyle Mode="NumericPages" />
                                            <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                                            <MasterTableView Width="100%" CommandItemDisplay="None" DataKeyNames="unit_code" Font-Size="11px" EditFormSettings-PopUpSettings-KeepInScreenBounds="false" 
                                                AllowFilteringByColumn="true">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="WO. Number" ItemStyle-Width="100px" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblTransID" Text='<%# DataBinder.Eval(Container.DataItem, "trans_id") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Date" ItemStyle-Width="120px" HeaderStyle-Width="140px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <telerik:RadDatePicker runat="server" ID="dtptransDate" Width="110px"
                                                                DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.trans_date")%>' 
                                                                onkeydown="blurTextBox(this, event)" Type="Date">
                                                                <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                                            </telerik:RadDatePicker>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Order Type" ItemStyle-Width="150px" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblOrderName" Text='<%# DataBinder.Eval(Container.DataItem, "orderName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Status" ItemStyle-Width="70px" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblWODesc" Text='<%# DataBinder.Eval(Container.DataItem, "wo_desc") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Unit HM" HeaderStyle-Width="50px" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center" 
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblUnitReading" Text='<%# DataBinder.Eval(Container.DataItem, "time_reading", "{0:#,###,###0.00}") %>'> </asp:Label>
                                                        </ItemTemplate>                                        
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Unit Status" ItemStyle-Width="70px" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblStatusName" Text='<%# DataBinder.Eval(Container.DataItem, "statusName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="B/D Date" ItemStyle-Width="120px" HeaderStyle-Width="140px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <telerik:RadDatePicker runat="server" ID="dtpbdDate" Width="110px"
                                                                DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.DBDate")%>' 
                                                                onkeydown="blurTextBox(this, event)" Type="Date">
                                                                <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                                            </telerik:RadDatePicker>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Job Description" ItemStyle-Width="250px" HeaderStyle-Width="250px" ItemStyle-HorizontalAlign="Justify" 
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblSroRemark" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </ContentTemplate>
                               </asp:UpdatePanel>    
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </telerik:RadPageView>

                <telerik:RadPageView runat="server" ID="RadPageView5" Height="600px" Visible="True">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Unit Code    :" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadTextBox runat="server" ID="txt_unit3" RenderMode="Lightweight" Width="150px" ReadOnly="true" Skin="Telerik">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Model No :" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadTextBox runat="server" ID="txt_model3" RenderMode="Lightweight" Width="150px" ReadOnly="true" Skin="Telerik">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                    <td>
                                        <telerik:RadButton runat="server" ID="btnSearch3" Text="Filter" Width="95%" Height="35px" CausesValidation="false" Skin="Material" 
                                            ForeColor="DeepSkyBlue" OnClick="btnSearch3_Click">
                                        </telerik:RadButton>
                                    </td>
                                </tr>
                            </table>
                            <div class="scroller" runat="server">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <telerik:RadGrid runat="server" ID="RadGrid3" RenderMode="Lightweight" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false"
                                            PageSize="10" Skin="Telerik" ShowFooter="false" GridLines="None" Width="100%" 
                                            OnNeedDataSource="RadGrid3_NeedDataSource" 
                                            OnInsertCommand="RadGrid3_InsertCommand">
                                            <PagerStyle Mode="NumericPages" />
                                            <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings> 
                                            <MasterTableView Width="100%" DataKeyNames="unit_code" Font-Size="11px" EditFormSettings-PopUpSettings-KeepInScreenBounds="false" 
                                                AllowFilteringByColumn="true" CommandItemDisplay="None">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="MR. Number" ItemStyle-Width="90px" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblMrNo" Text='<%# DataBinder.Eval(Container.DataItem, "sro_code") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Date" ItemStyle-Width="90px" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <telerik:RadDatePicker runat="server" ID="dtpSroDate" Width="100px"
                                                                DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.sro_date")%>' 
                                                                onkeydown="blurTextBox(this, event)" Type="Date">
                                                                <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                                            </telerik:RadDatePicker>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Work Order" ItemStyle-Width="110px" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblWorkOrder" Text='<%# DataBinder.Eval(Container.DataItem, "trans_id") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Job Description" ItemStyle-Width="240px" HeaderStyle-Width="250px" ItemStyle-HorizontalAlign="Justify"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblSroRemark" Text='<%# DataBinder.Eval(Container.DataItem, "sro_remark") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView6" Height="600px" Visible="True">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Unit Code    :" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadTextBox runat="server" ID="txt_unit4" RenderMode="Lightweight" Width="150px" ReadOnly="true" Skin="Telerik">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Model No :" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadTextBox runat="server" ID="txt_model4" RenderMode="Lightweight" Width="150px" ReadOnly="true" Skin="Telerik">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                    <td>
                                        <telerik:RadButton runat="server" ID="btnSearch4" Text="Filter" Width="95%" Height="35px" CausesValidation="false" Skin="Material" 
                                            ForeColor="DeepSkyBlue" OnClick="btnSearch4_Click">
                                        </telerik:RadButton>
                                    </td>
                                </tr>
                            </table>
                            <div class="scroller" runat="server">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <telerik:RadGrid runat="server" ID="RadGrid4" RenderMode="Lightweight" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" 
                                            PageSize="10" Skin="Telerik" ShowFooter="false" GridLines="None" Width="100%" 
                                            OnNeedDataSource="RadGrid4_NeedDataSource" 
                                            OnInsertCommand="RadGrid4_InsertCommand">
                                            <PagerStyle Mode="NumericPages" />
                                            <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                                            <MasterTableView Width="100%" CommandItemDisplay="None" DataKeyNames="unit_code" Font-Size="11px" EditFormSettings-PopUpSettings-KeepInScreenBounds="false" 
                                                AllowFilteringByColumn="true">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Site" ItemStyle-Width="70px" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblSite" Text='<%# DataBinder.Eval(Container.DataItem, "region_code") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Date" ItemStyle-Width="90px" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <telerik:RadDatePicker runat="server" ID="dtpHMRdate" Width="100px"
                                                                DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.trans_date")%>' 
                                                                onkeydown="blurTextBox(this, event)" Type="Date">
                                                                <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                                            </telerik:RadDatePicker>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Comp. Code" ItemStyle-Width="70px" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblCompCode" Text='<%# DataBinder.Eval(Container.DataItem, "com_code") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Comp. Name" ItemStyle-Width="160px" HeaderStyle-Width="170px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblCompName" Text='<%# DataBinder.Eval(Container.DataItem, "com_name") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="HM/KM" HeaderStyle-Width="85px" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Right"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblTimeReading" Text='<%# DataBinder.Eval(Container.DataItem, "time_reading", "{0:#,###,###0.00}") %>'></asp:Label>
                                                        </ItemTemplate>                                        
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="SM/UM" HeaderStyle-Width="85px" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Right"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblDownType" Text='<%# DataBinder.Eval(Container.DataItem, "down_type", "{0:#,###,###0.00}") %>'></asp:Label>
                                                        </ItemTemplate>                                        
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Job Status" ItemStyle-Width="90px" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblJobStatus" Text='<%# DataBinder.Eval(Container.DataItem, "job_status") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Comment/Remark" ItemStyle-Width="240px" HeaderStyle-Width="250px" ItemStyle-HorizontalAlign="Justify" 
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblRemark" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </telerik:RadPageView>

                <telerik:RadPageView runat="server" ID="RadPageView7" Height="600px" Visible="true">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Date From    :" ForeColor="DeepSkyBlue" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadDatePicker runat="server" ID="dtp_from_ReadRecord" RenderMode="Lightweight" Width="150px" Skin="Telerik" DateInput-ReadOnly="false" 
                                            DateInput-DateFormat="dd/MM/yyyy">
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="To Date  :" ForeColor="DeepSkyBlue" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadDatePicker runat="server" ID="dtp_to_ReadRecord" RenderMode="Lightweight" Width="150px" Skin="Telerik" DateInput-ReadOnly="false"  
                                            DateInput-DateFormat="dd/MM/yyyy">
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td>
                                        <telerik:RadButton runat="server" ID="btnSearch5" Text="Filter" Width="95%" Height="35px" CausesValidation="false" Skin="Material" 
                                            ForeColor="DeepSkyBlue" OnClick="btnSearch5_Click">
                                        </telerik:RadButton>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Unit Code    :" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadTextBox runat="server" ID="txt_unit5" RenderMode="Lightweight" Width="150px" ReadOnly="true" Skin="Telerik">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Model No    :" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadTextBox runat="server" ID="txt_model5" RenderMode="Lightweight" Width="150px" ReadOnly="true" Skin="Telerik">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                            </table>
                            <div class="scroller" runat="server">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <telerik:RadGrid runat="server" ID="RadGrid5" RenderMode="Lightweight" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false"  
                                            PageSize="10" Skin="Telerik" ShowFooter="false" GridLines="None" Width="100%" 
                                            OnNeedDataSource="RadGrid5_NeedDataSource" 
                                            OnInsertCommand="RadGrid5_InsertCommand">
                                            <PagerStyle Mode="NumericPages" />
                                            <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                                            <MasterTableView Width="100%" CommandItemDisplay="None" DataKeyNames="unit_code" Font-Size="11px" EditFormSettings-PopUpSettings-KeepInScreenBounds="false" 
                                                AllowFilteringByColumn="true">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Frequency Type" ItemStyle-Width="70px" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblFreqType" Text='<%# DataBinder.Eval(Container.DataItem, "reading_code") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Date" ItemStyle-Width="90px" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <telerik:RadDatePicker runat="server" ID="dtpReadRecordDate" Width="90px"
                                                                DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.reading_date")%>' 
                                                                onkeydown="blurTextBox(this, event)" Type="Date">
                                                                <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                                            </telerik:RadDatePicker>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Reading" HeaderStyle-Width="85px" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Right"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblReadingAmount3" Text='<%# DataBinder.Eval(Container.DataItem, "reading_amount3", "{0:#,###,###0.00}") %>'></asp:Label>
                                                        </ItemTemplate>                                        
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Accum. Reading" HeaderStyle-Width="85px" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Right"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblReadingAmount1" Text='<%# DataBinder.Eval(Container.DataItem, "reading_amount1", "{0:#,###,###0.00}") %>'></asp:Label>
                                                        </ItemTemplate>                                        
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Broken Hours" ItemStyle-Width="70px" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblBrokenHours" Text='<%# DataBinder.Eval(Container.DataItem, "broken_hm") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="WH" HeaderStyle-Width="85px" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Right"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblWH" Text='<%# DataBinder.Eval(Container.DataItem, "wh", "{0:#,###,###0.00}") %>'></asp:Label>
                                                        </ItemTemplate>                                        
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </telerik:RadPageView>

                <telerik:RadPageView runat="server" ID="RadPageView8" Height="600px" Visible="true">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Unit Code    :" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadTextBox runat="server" ID="txt_unit6" RenderMode="Lightweight" Width="150px" ReadOnly="true" Skin="Telerik">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Model No    :" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadTextBox runat="server" ID="txt_model6" RenderMode="Lightweight" Width="150px" ReadOnly="true" Skin="Telerik">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                    <td>
                                        <telerik:RadButton runat="server" ID="btnSearch6" Text="Filter" Width="95%" Height="35px" CausesValidation="false" Skin="Material" 
                                            ForeColor="DeepSkyBlue" OnClick="btnSearch6_Click">
                                        </telerik:RadButton>
                                    </td>
                                </tr>
                            </table>
                            <div class="scroller" runat="server">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <telerik:RadGrid runat="server" ID="RadGrid6" RenderMode="Lightweight" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false"  
                                            PageSize="10" Skin="Telerik" ShowFooter="false" GridLines="None" Width="100%" 
                                            OnNeedDataSource="RadGrid6_NeedDataSource" 
                                            OnInsertCommand="RadGrid6_InsertCommand">
                                            <PagerStyle Mode="NumericPages" />
                                            <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                                            <MasterTableView Width="100%" CommandItemDisplay="None" DataKeyNames="unit_code" Font-Size="11px" 
                                                EditFormSettings-PopUpSettings-KeepInScreenBounds="false" AllowFilteringByColumn="true">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Notif. No" ItemStyle-Width="90px" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblNotifNo" Text='<%# DataBinder.Eval(Container.DataItem, "PM_id") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Date Req." ItemStyle-Width="90px" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <telerik:RadDatePicker runat="server" ID="dtpReqDate" Width="100px"
                                                                DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.Req_date")%>' 
                                                                onkeydown="blurTextBox(this, event)" Type="Date">
                                                                <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                                            </telerik:RadDatePicker>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Type" ItemStyle-Width="70px" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblNotifType" Text='<%# DataBinder.Eval(Container.DataItem, "Notif_type_name") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Report By." ItemStyle-Width="90px" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblNotifReportBy" Text='<%# DataBinder.Eval(Container.DataItem, "reportby") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Unit HM" HeaderStyle-Width="80px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblNotifTime" Text='<%# DataBinder.Eval(Container.DataItem, "time_reading", "{0:#,###,###0.00}") %>'></asp:Label>
                                                        </ItemTemplate>                                        
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Unit Status" ItemStyle-Width="60px" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblNotifUnitStatus" Text='<%# DataBinder.Eval(Container.DataItem, "unitstatus") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Status" ItemStyle-Width="70px" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblNotifStatus" Text='<%# DataBinder.Eval(Container.DataItem, "wo_desc") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="240px" HeaderStyle-Width="250px" ItemStyle-HorizontalAlign="Justify" 
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblNotifRemark" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </telerik:RadPageView>

                <telerik:RadPageView runat="server" ID="RadPageView9" Height="600px" Visible="true">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Date From    :" ForeColor="DeepSkyBlue" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadDatePicker runat="server" ID="RadDatePicker1" RenderMode="Lightweight" Width="150px" Skin="Telerik" DateInput-ReadOnly="false" 
                                            DateInput-DateFormat="dd/MM/yyyy">
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="To Date  :" ForeColor="DeepSkyBlue" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadDatePicker runat="server" ID="RadDatePicker2" RenderMode="Lightweight" Width="150px" Skin="Telerik" DateInput-ReadOnly="false" 
                                            DateInput-DateFormat="dd/MM/yyyy">
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td>
                                        <telerik:RadButton runat="server" ID="btnSearch7" Text="Filter" Width="95%" Height="35px" CausesValidation="false" Skin="Material" 
                                            ForeColor="DeepSkyBlue" OnClick="btnSearch7_Click">
                                        </telerik:RadButton>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Unit Code    :" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadTextBox runat="server" ID="RadTextBox1" RenderMode="Lightweight" Width="150px" ReadOnly="true" Skin="Telerik">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Model No :" CssClass="lbObject"></telerik:RadLabel>
                                        <telerik:RadTextBox runat="server" ID="RadTextBox2" RenderMode="Lightweight" Width="150px" ReadOnly="true" Skin="Telerik">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                            </table>
                            <div class="scroller" runat="server">
                               <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <telerik:RadGrid runat="server" ID="RadGrid7" RenderMode="Lightweight" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" 
                                            PageSize="10" Skin="Telerik" ShowFooter="false" GridLines="None" Width="100%" 
                                            OnNeedDataSource="RadGrid7_NeedDataSource" 
                                            OnInsertCommand="RadGrid7_InsertCommand">
                                            <PagerStyle Mode="NumericPages" />
                                            <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                                            <MasterTableView Width="100%" CommandItemDisplay="None" DataKeyNames="trans_id" Font-Size="11px" EditFormSettings-PopUpSettings-KeepInScreenBounds="false"  
                                                AllowFilteringByColumn="true">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="WO. Number" ItemStyle-Width="90px" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblTransID" Text='<%# DataBinder.Eval(Container.DataItem, "trans_id") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Date" ItemStyle-Width="90px" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <telerik:RadDatePicker runat="server" ID="dtptransDate" Width="100px"
                                                                DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.trans_date")%>' 
                                                                onkeydown="blurTextBox(this, event)" Type="Date">
                                                                <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                                            </telerik:RadDatePicker>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Order Type" ItemStyle-Width="110px" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblOrderName" Text='<%# DataBinder.Eval(Container.DataItem, "orderName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Status" ItemStyle-Width="80px" HeaderStyle-Width="90px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblWODesc" Text='<%# DataBinder.Eval(Container.DataItem, "wo_desc") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Unit HM" HeaderStyle-Width="90px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblUnitReading" Text='<%# DataBinder.Eval(Container.DataItem, "time_reading", "{0:#,###,###0.00}") %>'> </asp:Label>
                                                        </ItemTemplate>                                        
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Unit Status" ItemStyle-Width="85px" HeaderStyle-Width="95px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblStatusName" Text='<%# DataBinder.Eval(Container.DataItem, "statusName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="B/D Date" ItemStyle-Width="90px" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <telerik:RadDatePicker runat="server" ID="dtpbdDate" Width="100px"
                                                                DbSelectedDate='<%#DataBinder.Eval(Container, "DataItem.DBDate")%>' 
                                                                onkeydown="blurTextBox(this, event)" Type="Date">
                                                                <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" ReadOnly="true" /> 
                                                            </telerik:RadDatePicker>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Job Description" ItemStyle-Width="240px" HeaderStyle-Width="250px" ItemStyle-HorizontalAlign="Justify"
                                                        HeaderStyle-HorizontalAlign="Center"  HeaderStyle-BackColor="YellowGreen" HeaderStyle-ForeColor="#009900">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblSroRemark" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </ContentTemplate>
                               </asp:UpdatePanel>    
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </div>

        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
    </div>

</asp:Content>
