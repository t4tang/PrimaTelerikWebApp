<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc00h24.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Asset.AssetType.acc00h24" %>
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
                         AutoGenerateColumns="false" Skin="MetroTouch" AllowFilteringByColumn="true" Font-Names="Calibri" OnDeleteCommand="RadGrid1_DeleteCommand"
                         OnNeedDataSource="RadGrid1_NeedDataSource" OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand" OnItemCreated="RadGrid1_ItemCreated">
            <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
            <MasterTableView CommandItemDisplay="Top" AllowFilteringByColumn="true" DataKeyNames="AK_GROUP" Font-Size="13px" 
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText ="Code" DataField="AK_GROUP">
                        <HeaderStyle Width="70px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Asset Type" DataField="AK_GROUP_NAME">
                        <HeaderStyle Width="150px" />
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
                                    Code :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_code" runat="server" Width="70px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.AK_GROUP") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Asset Type :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_asset_type" runat="server" Width="200px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.AK_GROUP_NAME") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
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
