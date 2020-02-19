﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="sls00h01.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Customer.Salesman.sls00h01" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="GridLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ConfiguratorPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel runat="server" ID="GridLoadingPanel1">
    </telerik:RadAjaxLoadingPanel>
    <div class="scroller">
        <%--PAGE CONTENT--%>
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="true" ShowFooter="true" AllowSorting="true"
                         AutoGenerateColumns="false" Skin="MetroTouch" OnNeedDataSource="RadGrid1_NeedDataSource"
                         OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand" OnDeleteCommand="RadGrid1_DeleteCommand"
                         OnItemCreated="RadGrid1_ItemCreated" AllowFilteringByColumn="true">
            <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
            <MasterTableView CommandItemDisplay="Top" AllowFilteringByColumn="true" DataKeyNames="sales_code" Width="100%" Font-Names="Calibri" Font-Size="13px" 
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText ="Code" DataField="sales_code">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Salesman" DataField="sales_name">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Sub Area" DataField="sar_name">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Target" DataField="ref_prod_code">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Active" DataField="FluitCap">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" 
                            ConfirmText="Are you sure you want to delete this row or record?">
                             <HeaderStyle Width="20px"></HeaderStyle>
                        </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate id="Table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                            padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
                            <tr>
                                <td>
                                    Code :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_code" runat="server" Width="80px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.sales_code") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                                &nbsp;
                                <td>
                                    Active :
                                </td>
                                <td>
                                    <asp:CheckBox ID="cb_active" runat="server" Text='<%#DataBinder.Eval(Container, "DataItem.status") %>' AutoPostBack="false">
                                    </asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Salesman :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_salesman" runat="server" Width="230px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.sales_name") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Sub Area Sales :
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_sub_area" runat="server" Width="215px" Enabled="true" RenderMode="Lightweight"
                                                         Text='<%#DataBinder.Eval(Container, "DataItem.city_code") %>' AutoPostBack="false"
                                                         ShowDropDownOnTextboxClick="true" OnPreRender="cb_project_PreRender" EnableLoadOnDemand="true"
                                                         EnableVirtualScrolling="true" ShowMoreResultsBox="true" MarkFirstMatch="true"
                                                         OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Target :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_target" runat="server" Width="230px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.wh_name") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Address :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_address" runat="server" Width="230px" Height="50px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.wh_name") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    City :
                                </td>
                            <td>
                                <telerik:RadComboBox ID="txt_city" runat="server" Width="215px" Enabled="true" RenderMode="Lightweight"
                                                     Text='<%#DataBinder.Eval(Container, "DataItem.region_name") %>' AutoPostBack="false"
                                                     ShowDropDownOnTextboxClick="true" OnPreRender="cb_project_PreRender" EnableLoadOnDemand="true"
                                                     EnableVirtualScrolling="true" ShowMoreResultsBox="true" MarkFirstMatch="true"
                                                     OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged">
                                </telerik:RadComboBox>
                            </td>
                            &nbsp;
                                <td>
                                    Phone :
                                </td>
                            <td>
                                <telerik:RadTextBox ID="txt_phone" runat="server" Width="230px" Enabled="true" RenderMode="Lightweight"
                                                    Text='<%#DataBinder.Eval(Container, "DataItem.wh_name") %>' AutoPostBack="false">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                            <tr>
                                <td>
                                    E-Mail :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_email" runat="server" Width="230px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.wh_name") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                    </FormTemplate>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
        <telerik:RadWindowManager ID="RadWindowManager1" RenderMode="Lightweight" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Title="Editing Record" Height="490px"
                                    Width="850px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
</asp:Content>
