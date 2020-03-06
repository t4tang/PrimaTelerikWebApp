<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc00h30.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Controlling.WorkCenter.mtc00h30" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
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
            <telerik:AjaxSetting AjaxControlID="ConfiguratorPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <div class="scroller">
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="True" 
            ShowFooter ="true" AutoGenerateColumns="False" MasterTableView-AutoGenerateColumns="False"
            OnNeedDataSource ="RadGrid1_NeedDataSource" OnInsertCommand ="RadGrid1_InsertCommand" OnUpdateCommand ="RadGrid1_UpdateCommand"
            OnDeleteCommand ="RadGrid1_DeleteCommand" Skin ="MetroTouch" OnItemCreated ="RadGrid1_ItemCreated"
            MasterTableView-CommandItemDisplay="Top" MasterTableView-DataKeyNames="wkcencode" MasterTableView-ClientDataKeyNames="wkcencode" 
            MasterTableView-AllowFilteringByColumn="True" AllowSorting="True">
            <MasterTableView>
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName ="EditCommandColumn">
                        <HeaderStyle Width ="15px" ></HeaderStyle>
                        <ItemStyle Width = "15px" />
                    </telerik:GridEditCommandColumn>
                     <telerik:GridBoundColumn HeaderText ="Code" DataField ="wkcencode" >
                        <HeaderStyle Width ="100px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Work Center" DataField ="wkcenname" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Cat." DataField ="wkcencat" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Cntr. Ket" DataField ="controlkey" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Cost Center" DataField ="CostCenCode" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Project Area" DataField ="Region_Code" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn UniqueName ="DeleteColumn" Text ="Delete" CommandName="Delete" HeaderStyle-Width="30px"
                        ConfirmText="Delete This Product?" ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="FontIconButton">
                        <HeaderStyle Width="30px"></HeaderStyle>
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table id="Table2" cellspacing="4" cellpadding="5" width="100%" border="0" rules="none" class="formTemplate_Table">
                            <tr>
                                <td>
                                    Code:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_code" runat="server" Width="95px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.wkcencode") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Work Center:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_work_center" runat="server" Width="175px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.wkcenname") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Project Area:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_project" runat="server" RenderMode="Lightweight" Width ="250px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' 
                                        OnItemsRequested ="cb_project_ItemsRequested" OnSelectedIndexChanged ="cb_project_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_project_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                        AutoPostBack="true" Skin ="MetroTouch" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Control Key:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="txt_control_key" runat="server" RenderMode="Lightweight" Width ="190px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.controlComb") %>' 
                                        OnItemsRequested ="txt_control_key_ItemsRequested" OnSelectedIndexChanged ="txt_control_key_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="txt_control_key_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" 
                                        AutoPostBack="true" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Capacity Cat:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_capacity" runat="server" RenderMode="Lightweight" Width ="170px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.CapCatComb") %>' 
                                        OnItemsRequested ="cb_capacity_ItemsRequested" OnSelectedIndexChanged ="cb_capacity_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_capacity_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" 
                                        AutoPostBack="true" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Category:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_category" runat="server" RenderMode="Lightweight" Width ="190px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.wkcencatComb") %>' 
                                        OnItemsRequested ="cb_category_ItemsRequested" OnSelectedIndexChanged ="cb_category_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_category_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" 
                                        AutoPostBack="true" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Person Responsible:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_respon" runat="server" RenderMode="Lightweight" Width ="400px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.PersonResponComb") %>' 
                                        OnItemsRequested ="cb_respon_ItemsRequested" OnSelectedIndexChanged ="cb_respon_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_respon_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" 
                                        AutoPostBack="true" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Usage:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_usage" runat="server" RenderMode="Lightweight" Width ="300px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.UsageComb") %>' 
                                        OnItemsRequested ="cb_usage_ItemsRequested" OnSelectedIndexChanged ="cb_usage_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_usage_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" 
                                        AutoPostBack="true" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Start Validity Date
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_start" runat="server" RenderMode="Lightweight" Width="180px"
                                        SelectedDate='<%# DataBinder.Eval(Container, "DataItem.DateValidStart") %>'>
                                    </telerik:RadDatePicker>
                                
                                &nbsp;
                                
                                    End Validity Date
                                
                                    <telerik:RadDatePicker ID="dtp_end" runat="server" RenderMode="Lightweight" Width="180px"
                                       SelectedDate='<%# DataBinder.Eval(Container, "DataItem.DateValidEnd") %>' >
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Cost Center:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_cost_center" runat="server" RenderMode="Lightweight" Width ="400px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.CostCenterComb") %>' 
                                        OnItemsRequested ="cb_cost_center_ItemsRequested" OnSelectedIndexChanged ="cb_cost_center_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_cost_center_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" 
                                        AutoPostBack="true" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Act Type:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_act_type" runat="server" RenderMode="Lightweight" Width ="240px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.Act_typeComb") %>' 
                                        OnItemsRequested ="cb_act_type_ItemsRequested" OnSelectedIndexChanged ="cb_act_type_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_act_type_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" 
                                        AutoPostBack="true" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <td align="right" colspan="2">
                                    <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                    runat ="server" CommandName ='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' >
                                    </asp:Button>&nbsp;
                                    <asp:Button ID ="btnCancel" Text="Cancel" runat="server" CausesValidation ="false" CommandName="Cancel">
                                    </asp:Button>
                                </td>
                        </table>
                    </FormTemplate>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
</asp:Content>
