<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h06.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Material.ServiceMaster.inv00h06" %>
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
                         AutoGenerateColumns="false" OnDeleteCommand="RadGrid1_DeleteCommand" Skin="MetroTouch" AllowFilteringByColumn="true" OnNeedDataSource="RadGrid1_NeedDataSource"
                         OnUpdateCommand="RadGrid1_UpdateCommand" Font-Names="Calibri" OnInsertCommand="RadGrid1_InsertCommand" OnItemCreated="RadGrid1_ItemCreated">
            <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
            <MasterTableView CommandItemDisplay="Top" AllowFilteringByColumn="true" DataKeyNames="prod_code" Width="100%" Font-Size="13px" 
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText ="Activity Code" DataField="prod_code">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Activity Name" DataField="spec">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Category" DataField="kind_name">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="UoM" DataField="unit">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" 
                            ConfirmText="Are you sure you want to delete this row or record?">
                             <HeaderStyle Width="20px"></HeaderStyle>
                    </telerik:GridButtonColumn>
                  </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table id="table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                            padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
                            <tr>
                                <td>
                                    Activity Code :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_activity" runat="server" Width="80px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.prod_code") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                                &nbsp;
                                <td>
                                    UoM :
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_uom" runat="server" Text='<%#DataBinder.Eval(Container, "DataItem.unit") %>' AutoPostBack="false" ShowDropDownOnTextboxClick="true" OnPreRender="cb_uom_PreRender"
                                                         EnableLoadOnDemand="true" EnableVirtualScrolling="true" ShowMoreResultsBox="true" MarkFirstMatch="true" OnItemsRequested="cb_uom_ItemsRequested" OnSelectedIndexChanged="cb_uom_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Activity Name :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_activity_name" runat="server" Width="230px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.spec") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Alias Code :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_alias_code" runat="server" Width="230px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.koref") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Alias Name :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_alias_name" runat="server" Width="230px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.NmRef") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Service Category :
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_service" runat="server" Width="215px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.kind_name") %>' AutoPostBack="false"
                                                         ShowDropDownOnTextboxClick="true" OnPreRender="cb_service_PreRender" EnableLoadOnDemand="true" EnableVirtualScrolling="true"
                                                         ShowMoreResultsBox="true" MarkFirstMatch="true" OnItemsRequested="cb_service_ItemsRequested"
                                                         OnSelectedIndexChanged="cb_service_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Active :
                                </td>
                                <td>
                                    <asp:CheckBox ID="cb_active" runat="server" Text='<%#DataBinder.Eval(Container, "DataItem.tMonitor") %>' AutoPostBack="false">
                                    </asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                               <td>
                                  <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                              runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' />
                           &nbsp; <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="false" CommandName="Cancel" />
                               </td>
                            </tr>
                        </table>
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
