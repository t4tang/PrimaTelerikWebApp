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
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>            
        </AjaxSettings>
    </telerik:RadAjaxManager>

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
                    
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView3" Height="600px" Visible="True">
                                   
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView4" Height="600px" Visible="True">
                    
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView5" Height="600px" Visible="True">
                    
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </div>
    </div>

</asp:Content>
