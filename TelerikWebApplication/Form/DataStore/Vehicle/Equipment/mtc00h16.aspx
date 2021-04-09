<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc00h16.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Vehicle.Equipment.mtc00h16" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl"/>
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_new">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>               
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>       
                <td style="vertical-align: middle; margin-left: 10px; padding:0px 0px 0px 0px">
                    <telerik:RadButton ID="btn_new" runat="server" ForeColor="OrangeRed" BackColor="#33ccff" Text="New" Width="80px" Height="30px"
                        Skin="Telerik" OnClick="btn_new_Click" ></telerik:RadButton>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                     
                </td>                           
                <td style="width: 98%; text-align: right; padding-right:17px">
                     <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <telerik:RadLabel ID="lbl_form_name" Text="Master Equipment" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                                padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                            </telerik:RadLabel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div> 
    
    <div class="scroller" style="overflow-y:scroll; height:620px"> 
        <div style="overflow-x:auto">
            <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" ShowFooter="False"
                AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" Width="1600px"
                MasterTableView-AllowFilteringByColumn="true" MasterTableView-CommandItemDisplay="Top" 
                OnNeedDataSource="RadGrid1_NeedDataSource" OnItemCreated="RadGrid1_ItemCreated"
                Skin="Silk" CssClass="RadGrid_ModernBrowsers" PageSize="20">
                <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
                <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic">
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                            <HeaderStyle Width="20px" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn HeaderText="Unit Code" DataField="unit_code">
                            <HeaderStyle Width="70px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Project Area" DataField="region_name">
                            <HeaderStyle Width="180px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Class" DataField="class_name">
                            <HeaderStyle Width="50px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Model" DataField="model_no">
                            <HeaderStyle Width="70px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Manufacture" DataField="manu_name">
                            <HeaderStyle Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="SN" DataField="key_no">
                            <HeaderStyle Width="70px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Engine Model" DataField="engine_no">
                            <HeaderStyle Width="70px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Status Condition" DataField="equ_status">
                            <HeaderStyle Width="70px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Purchase Date" DataField="pur_date">
                            <HeaderStyle Width="40px" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn HeaderText="Receive Date" DataField="arr_date">
                            <HeaderStyle Width="40px" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn HeaderText="Status" DataField="con_status">
                            <HeaderStyle Width="40px" />                             
                        </telerik:GridBoundColumn>

                        <telerik:GridButtonColumn UniqueName="Delete" CommandName="Delete" HeaderStyle-Width="35px" 
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                            <HeaderStyle Width="35px" />
                        </telerik:GridButtonColumn>
                    </Columns>

                    <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                            <table id="table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                                        padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
                                <tr>
                                    <td colspan="2"  style="padding: 10px 0px 10px 0px">
                                        <asp:Button ID="btnupdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' 
                                             runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' />                                                                               
                                         <asp:Button ID="btncancel" Text="Cancel" runat="server" CausesValidation="false" CommandName="Cancel" />
                                    </td>
                                </tr>
                                <%--<tr class="EditFormHeader">
                                    <td colspan="6" style="padding: 10px 0px 10px 0px">
                                        <b>Master Compartement</b>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td colspan="5">
                                        <table id="Table3" border="0" class="module">
                                            <tr style="text-align:left">
                                                <td style="width:100px">Unit Code
                                                </td>
                                                <td >
                                                     <%--<telerik:RadTextBox ID="txt_equipment_code" runat="server" RenderMode="Lightweight" Width="120px" Enabled="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.unit_code") %>' AutoPostBack="false" >
                                                     </telerik:RadTextBox>--%>
                                                     <telerik:RadComboBox ID="cb_equipment_code" runat="server" RenderMode="Lightweight" Width ="150px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.unit_code") %>'  DropDownWidth="900px"                              
                                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="true" Skin ="Silk"
                                                        OnItemsRequested="cb_equipment_code_ItemsRequested"
                                                        OnSelectedIndexChanged="cb_equipment_code_SelectedIndexChanged"
                                                        Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">
                                                         <HeaderTemplate>
                                                            <table style="width: 900px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 200px;">Code
                                                                    </td>
                                                                    <td style="width: 350px;">Description
                                                                    </td>
                                                                    <td style="width: 350px;">Project
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table style="width: 900px; font-size: smaller">
                                                                <tr>
                                                                    <td style="width: 200px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                                    </td>
                                                                    <td style="width: 350px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.AssetSpec")%>
                                                                    </td>
                                                                    <td style="width: 350px;">
                                                                        <%# DataBinder.Eval(Container, "DataItem.region_code")%>
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                        </FooterTemplate>                                        
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="text-align:left">
                                                     <telerik:RadTextBox ID="txt_equipment_Name" runat="server" RenderMode="Lightweight" Width="470px" Enabled="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.unit_name") %>' ReadOnly="true" Skin="Silk">
                                                     </telerik:RadTextBox>    
                                                </td>
                                                <td style="width:65px; padding: 0px 7px 0px 15px;">
                                                    Asset Code
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox ID="txt_asset_code" runat="server" RenderMode="Lightweight" Width="150px" Enabled="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ak_id") %>' ReadOnly="true" Skin="Silk">
                                                     </telerik:RadTextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align:top; padding: 10px 0px 0px 0px" >
                                        <table>
                                            <tr>
                                                <td style="width:100px">Type
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadComboBox ID="cb_type" runat="server" RenderMode="Lightweight" Width ="250px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.equipment_type_name") %>'                                
                                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="Silk"
                                                        Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Kind
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadComboBox ID="cb_kind" runat="server" RenderMode="Lightweight" Width ="250px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.equip_kind") %>'             
                                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="Silk"
                                                        Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Manufacture
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadComboBox ID="cb_manufacture" runat="server" RenderMode="Lightweight" Width ="250px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.manufactur_name") %>'             
                                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="Silk"
                                                        Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Model No
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadComboBox ID="cb_model" runat="server" RenderMode="Lightweight" Width ="250px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.model_no") %>'                                
                                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="Silk"
                                                        Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Status
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadComboBox ID="cb_status" runat="server" RenderMode="Lightweight" Width ="250px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.equ_status") %>'             
                                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="Silk"
                                                        Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>                                                
                                            <tr>
                                                <td>
                                                    Reading Type
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadComboBox ID="cb_reading_type" runat="server" RenderMode="Lightweight" Width ="250px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.reading_code") %>'             
                                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="Silk"
                                                        Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Std. Operation
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadTextBox ID="txt_std_opr" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.hour_avai") %>' AutoPostBack="false" Skin="Silk">
                                                        </telerik:RadTextBox>
                                                </td>
                                            </tr>                                             
                                            <tr>
                                                <td style="width:100px" >Class
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadComboBox ID="cb_class" runat="server" RenderMode="Lightweight" Width ="250px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.class_name") %>'                                
                                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="Silk"
                                                        Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="vertical-align:top; padding: 10px 0px 0px 20px">
                                        <table>
                                            <tr>
                                                <td>
                                                    Engine No
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadTextBox ID="txt_engine_no" runat="server" RenderMode="Lightweight" Width="300px" Enabled="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.engine_no") %>' AutoPostBack="false" Skin="Silk">
                                                        </telerik:RadTextBox>
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td style="width:100px">
                                                    Engine Model
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadTextBox ID="txt_engine_model" runat="server" RenderMode="Lightweight" Width="300px" Enabled="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.engine_size") %>' AutoPostBack="false" Skin="Silk">
                                                        </telerik:RadTextBox>
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td>
                                                    S/N
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadTextBox ID="txt_sn" runat="server" RenderMode="Lightweight" Width="300px" Enabled="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.key_no") %>' AutoPostBack="false" Skin="Silk">
                                                        </telerik:RadTextBox>
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td>
                                                    Project
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadComboBox ID="cb_project" runat="server" RenderMode="Lightweight" Width ="300px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>'
                                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="Silk"
                                                        Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td>
                                                    Cost Center
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cost_center" runat="server" Width="120px" DropDownWidth="100px"                                                               
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>'
                                                        EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Skin="Metro" >
                                                    </telerik:RadComboBox>   
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td>
                                                    Supplier
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="300px" DropDownWidth="300px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.supplier_name") %>'      
                                                        EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Skin="Metro" >
                                                    </telerik:RadComboBox>   
                                                </td>
                                            </tr> 
                                           <%-- <tr>
                                                <td>
                                                    Asset Code
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_asset_code" runat="server" Width="120px" DropDownWidth="300px"
                                                            EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Skin="Silk" >
                                                    </telerik:RadComboBox>   
                                                </td>
                                            </tr> --%>
                                            <tr>
                                                <td>
                                                    PIC
                                                </td>
                                                <td colspan="3">
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_pic" runat="server" Width="120px" DropDownWidth="300px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.pic") %>'      
                                                            EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Skin="Silk" >
                                                    </telerik:RadComboBox>   
                                                </td>
                                            </tr>
                                        </table>    
                                    </td>
                                    <td style="vertical-align:top; padding: 10px 0px 0px 20px">
                                        <table>
                                            <tr>
                                                <td style="width:100px" >Purchase Date
                                                </td>
                                                <td >
                                                   <telerik:RadDatePicker ID="dtp_purchase" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                        Skin="Silk" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.pur_date") %>'>
                                                        <Calendar  runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" >
                                                        </Calendar>
                                                        <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" >
                                                        </DateInput>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                                    </telerik:RadDatePicker>       
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Arrived Date
                                                </td>
                                                <td >
                                                    <telerik:RadDatePicker ID="dtp_arrive_date" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                        Skin="Silk" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.arr_date") %>'>
                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" >
                                                        </Calendar>
                                                        <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" >
                                                        </DateInput>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                                    </telerik:RadDatePicker>  
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td>
                                                    Condition
                                                </td>
                                                <td >
                                                    <telerik:RadComboBox ID="cb_condition" runat="server" RenderMode="Lightweight" Width ="250px"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.con_status") %>'
                                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="Silk"
                                                        Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td>
                                                    Tank Capacity
                                                </td>
                                                <td >
                                                    <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_tank_capacity" Width="70px" NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                        onkeydown="blurTextBox(this, event)" ReadOnly="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.cap_tanki") %>'
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2" >
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    % Unschedule BD
                                                </td>
                                                <td >
                                                    <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_unschedule_bd_perc" Width="70px" NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                        onkeydown="blurTextBox(this, event)" ReadOnly="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.us_percent") %>'
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2" >
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td>
                                                    Schedule BD
                                                </td>
                                                <td >
                                                    <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_schedule_bd_perc" Width="70px" NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                        onkeydown="blurTextBox(this, event)" ReadOnly="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.sch_percent") %>'
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2" >
                                                    </telerik:RadNumericTextBox>  
                                                </td>
                                            </tr> 
                                            <tr>
                                                <td>
                                                    Expected Lifetime
                                                </td>
                                                <td >
                                                    <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_expected_lifetime" Width="70px" NumberFormat-AllowRounding="true"
                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                        onkeydown="blurTextBox(this, event)" ReadOnly="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.exp_life") %>'
                                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                                        NumberFormat-DecimalDigits="2" >
                                                    </telerik:RadNumericTextBox> 
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                </tr>
                                
                            </table>

                            <div style="padding: 7px 0px 12px 0px; min-height:275px">
                                <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="97%" 
                                SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Silk" CausesValidation="false">
                                    <Tabs>
                                        <telerik:RadTab Text="Vehicle" Height="15px"> 
                                        </telerik:RadTab>
                                        <telerik:RadTab Text="Finance" Height="15px">
                                        </telerik:RadTab>
                                        <telerik:RadTab Text="Reg / Warranty" Height="15px">
                                        </telerik:RadTab>
                                        <telerik:RadTab Text="Leasing" Height="15px">
                                        </telerik:RadTab>
                                        <telerik:RadTab Text="Description" Height="15px">
                                        </telerik:RadTab>
                                    </Tabs>
                                </telerik:RadTabStrip>
                                <telerik:RadMultiPage runat="server" ID="RadMultiPage1"  SelectedIndex="0" Width="99%" >
                                        <telerik:RadPageView runat="server" ID="RadPageView1" Height="300px" >
                                            <div runat="server" style="padding:15px 15px 15px 15px; float:left; width:15%">
                                                <table>
                                                    <tr>
                                                        <td colspan="2">
                                                            <telerik:RadLabel runat="server" Text="Vehicle Detail" Font-Size="14px" Font-Names="Calibri" Font-Bold="true" 
                                                                ForeColor="#ffffff" BackColor="#0099cc">
                                                            </telerik:RadLabel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Year
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_year" Width="70px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.v_year") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>
                                                                                                        
                                                    <tr>
                                                        <td>
                                                            Seat Capacity
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_seat_capacity" Width="70px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.seat_capa") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>
                                                            VIN/Chasis
                                                        </td>
                                                        <td>
                                                            <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="RadNumericTextBox1" Width="120px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.chasis") %>' 
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadTextBox> 
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td style="width:120px">
                                                            No Of Cylinders
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_no_of_cyl" Width="70px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.no_of_cylin") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>
                                                            Transmition
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_transmition" Width="120px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.transmission") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>
                                                            Radio No
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_radio_no" Width="120px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.radio_no") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div runat="server" style="padding:15px 15px 15px 15px; float:left; width:25%">
                                                <table>
                                                    <tr>
                                                        <td colspan="2">
                                                            <telerik:RadLabel runat="server" Text="Tyres" Font-Size="14px" Font-Names="Calibri" Font-Bold="true" 
                                                                ForeColor="#ffffff" BackColor="#0099cc">
                                                            </telerik:RadLabel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 120px" >
                                                            Tyre Size Steer
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_tyre_size_steer" Width="85px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.tyre_size_steer") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                            &nbsp No. Of &nbsp
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_no_of_tyre_size_steer" Width="55px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.tyre_no_steer") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>
                                                                                                        
                                                    <tr>
                                                        <td>
                                                            Tyre Size Drive
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_tyre_size_drive" Width="85px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.tyre_size_drive") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                            &nbsp No. Of &nbsp
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_no_of_tyre_size_drive" Width="55px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.tyre_no_drive") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>
                                                            Wheel Base
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_wheel_base" Width="55px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.wheel_base") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                             &nbsp Wheel Drive &nbsp
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_wheel_drive" Width="55px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.wheel_drive") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>
                                                            No Of Axles
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_no_of_axles" Width="55px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.no_of_axles") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>
                                                    
                                                </table>
                                                <table>
                                                    <tr>
                                                        <td colspan="2" style="padding-top:15px">
                                                            <telerik:RadLabel runat="server" Text="Weight/Dimension" Font-Size="14px" Font-Names="Calibri" Font-Bold="true" 
                                                                ForeColor="#ffffff" BackColor="#0099cc">
                                                            </telerik:RadLabel>
                                                        </td>
                                                    </tr>
                                                    
                                                    
                                                    <tr>
                                                        <td style="width: 120px" >
                                                            Tare Weight
                                                        </td>
                                                        <td>
                                                            <telerik:RadTextBox ID="txt_tare_weight" runat="server" Width="150px" ReadOnly="false"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.tare_weight") %>'         
                                                                RenderMode="Lightweight" >
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td style="width:50px;padding-left:25px">
                                                            Height
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_tare_height" Width="55px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.tare_height") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>
                                                                                                        
                                                    <tr>
                                                        <td>
                                                            Gross Weight
                                                        </td>
                                                        <td>
                                                             <telerik:RadTextBox ID="txt_gross_weight" runat="server" Width="150px" ReadOnly="false"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.gross_weight") %>'         
                                                                RenderMode="Lightweight" >
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td style="width:50px;padding-left:25px">
                                                            Width 
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_gross_width" Width="55px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.gross_width") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>
                                                            Color
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_color" runat="server" Width="150px" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.color") %>'     
                                                            DropDownWidth="250px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                            OnItemsRequested="cb_color_ItemsRequested" OnSelectedIndexChanged="cb_color_SelectedIndexChanged" >
                                                            </telerik:RadComboBox>                                                        
                                                        </td>
                                                        <td style="width:50px;padding-left:25px">
                                                            Lenght 
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_lenght" Width="55px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.length") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>


                                                </table>
                                            </div>
                                            <div runat="server" style="padding:15px 15px 15px 15px; float:left; width:30%">
                                                <table>
                                                    <tr>
                                                        <td colspan="2">
                                                            <telerik:RadLabel runat="server" Text="Fuels Details" Font-Size="14px" Font-Names="Calibri" Font-Bold="true" 
                                                                ForeColor="#ffffff" BackColor="#0099cc">
                                                            </telerik:RadLabel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="text-align:right; padding-right:50px">
                                                            <telerik:RadLabel runat="server" Text="Tank Capacity" Font-Size="11px" Font-Names="Calibri" Font-Bold="true" 
                                                                ForeColor="#0099cc" >
                                                            </telerik:RadLabel>
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr>
                                                        <td>
                                                            Primary Fuel
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_primary_fuel" runat="server" Width="170px" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.fuel_code") %>'       
                                                            DropDownWidth="250px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false">
                                                            </telerik:RadComboBox>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_primary_tank_cap" Width="80px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                            onkeydown="blurTextBox(this, event)" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.tank_capa1") %>'
                                                            AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>                                                                                                        
                                                    <tr>
                                                        <td>
                                                            Secondary Fuel
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_secondary_fuel" runat="server" Width="170px" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.s_fuel") %>'        
                                                            DropDownWidth="250px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false">
                                                            </telerik:RadComboBox>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_secondary_tank_cap" Width="80px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                            onkeydown="blurTextBox(this, event)" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.tank_capa2") %>'
                                                            AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Tank unit
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_tank_unit" runat="server" Width="170px" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.tank_unit") %>'        
                                                            DropDownWidth="250px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false">
                                                            </telerik:RadComboBox>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_tank_unit_cap" Width="80px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                            onkeydown="blurTextBox(this, event)" 
                                                        
                                                            AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td colspan="2" style="padding-top:15px">
                                                            <telerik:RadLabel runat="server" Text="Machinery Insfection" Font-Size="14px" Font-Names="Calibri" Font-Bold="true" 
                                                                ForeColor="#ffffff" BackColor="#0099cc">
                                                            </telerik:RadLabel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Machinery Inspect Done
                                                        </td>
                                                        <td>
                                                            <telerik:RadDatePicker ID="dtp_machinery_inspect_done" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                            Skin="Telerik" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.mechin_inspect_done") %>'>
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" >
                                                            </Calendar>
                                                            <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" >
                                                            </DateInput>
                                                        </telerik:RadDatePicker> 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Certificate No
                                                        </td>
                                                        <td>
                                                            <telerik:RadTextBox ID="txt_certifice_no" runat="server" Width="300px" ReadOnly="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.certi_no") %>'     
                                                            RenderMode="Lightweight" >
                                                        </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Next Due
                                                        </td>
                                                        <td>
                                                            <telerik:RadDatePicker ID="dtp_next_due" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                                            Skin="Telerik" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.next_due") %>'
                                                            >
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" >
                                                            </Calendar>
                                                            <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" >
                                                            </DateInput>
                                                        </telerik:RadDatePicker> 
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </telerik:RadPageView>
                                        <telerik:RadPageView runat="server" ID="RadPageView2" Height="300px">
                                            <div runat="server" style="padding:15px 15px 15px 15px; float:left; width:15%">
                                                <table>
                                                    <tr>
                                                        <td colspan="2">
                                                            <telerik:RadLabel runat="server" Text="Purchase Detail" Font-Size="14px" Font-Names="Calibri" Font-Bold="true" 
                                                                ForeColor="#ffffff" BackColor="#0099cc">
                                                            </telerik:RadLabel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Purchase Cost
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="RadNumericTextBox2" Width="70px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.v_year") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Order Number
                                                        </td>
                                                        <td>
                                                            <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="RadNumericTextBox3" Width="70px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.seat_capa") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadNumericTextBox> 
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                        <td>
                                                            IBO (Rp)
                                                        </td>
                                                        <td>
                                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="RadTextBox1" Width="120px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.chasis") %>' 
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadTextBox> 
                                                        </td>
                                                    </tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <tr>
                                                        <td colspan="2">
                                                            <telerik:RadLabel runat="server" Text="Value" Font-Size="14px" Font-Names="Calibri" Font-Bold="true" 
                                                                ForeColor="#ffffff" BackColor="#0099cc">
                                                            </telerik:RadLabel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Market Value
                                                        </td>
                                                        <td>
                                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="RadTextBox2" Width="120px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                               Text='<%# DataBinder.Eval(Container, "DataItem.chasis") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadTextBox> 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Replacement Value
                                                        </td>
                                                        <td>
                                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="RadTextBox3" Width="120px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.chasis") %>' 
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadTextBox> 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Change Over Value
                                                        </td>
                                                        <td>
                                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="RadTextBox4" Width="120px" NumberFormat-AllowRounding="true"
                                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" EnabledStyle-HorizontalAlign="Right"
                                                                onkeydown="blurTextBox(this, event)" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.chasis") %>'
                                                                AutoPostBack="false" MaxLength="11" Type="Number">
                                                            </telerik:RadTextBox> 
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div runat="server" style="padding:15px 15px 15px 15px; float:left; width:15%">
                                                <table>
                                                    <tr>
                                                        <td colspan="2">
                                                            <telerik:RadLabel runat="server" Text="Depreciation" Font-Size="14px" Font-Names="Calibri" Font-Bold="true" 
                                                                ForeColor="#ffffff" BackColor="#0099cc">
                                                            </telerik:RadLabel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                    </telerik:RadPageView>
                                </telerik:RadMultiPage>
                            </div>
                        </FormTemplate>
                    </EditFormSettings>
                </MasterTableView>
                <FilterMenu RenderMode="Lightweight"></FilterMenu>
            </telerik:RadGrid>
        </div>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Title="Editing Record"
                     Height="490px" Width="850px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>    
    </div>
</asp:Content>
