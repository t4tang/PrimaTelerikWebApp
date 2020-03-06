<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="pro00h03.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.MineControlProduction.Location.pro00h03" %>
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
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="true" ShowFooter="true" AllowSorting="true"
                         AutoGenerateColumns="false" Skin="MetroTouch" OnNeedDataSource="RadGrid1_NeedDataSource"
                         OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand" OnDeleteCommand="RadGrid1_DeleteCommand"
                         OnItemCreated="RadGrid1_ItemCreated" AllowFilteringByColumn="true">
            <PagerStyle Mode="NextPrevNumericAndAdvanced" />
            <MasterTableView CommandItemDisplay="Top" AllowFilteringByColumn="true" DataKeyNames="Loc_code" Width="100%" Font-Names="Calibri" Font-Size="13px" 
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText ="Code" DataField="Loc_code">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Location" DataField="loc_name">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Project Area" DataField="region_name">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Remark" DataField="remark">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" 
                            ConfirmText="Are you sure you want to delete this row or record?">
                             <HeaderStyle Width="20px"></HeaderStyle>
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table ID="Table2" cellspacing="4" cellpadding="5" width="70%" border="0" style="border-collapse: collapse; padding-left:35px; 
                            padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
                            <tr>
                                <td>
                                    Code :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_code" runat="server" Width="90px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.Loc_code") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Location :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_location" runat="server" Width="190px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.loc_name") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Category :
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_category" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight"
                                                     Text='<%#DataBinder.Eval(Container, "DataItem.cat_name") %>' AutoPostBack="false"
                                                     ShowDropDownOnTextboxClick="true" OnPreRender="cb_category_PreRender" EnableLoadOnDemand="true"
                                                     EnableVirtualScrolling="true" ShowMoreResultsBox="true" MarkFirstMatch="true"
                                                     OnItemsRequested="cb_category_ItemsRequested" OnSelectedIndexChanged="cb_category_SelectedIndexChanged">
                                </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Area :
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_area" runat="server" Width="250px" Enabled="true" RenderMode="Lightweight"
                                                     Text='<%#DataBinder.Eval(Container, "DataItem.region_code") %>' AutoPostBack="false"
                                                     ShowDropDownOnTextboxClick="true" OnPreRender="cb_area_PreRender" EnableLoadOnDemand="true"
                                                     EnableVirtualScrolling="true" ShowMoreResultsBox="true" MarkFirstMatch="true"
                                                     OnItemsRequested="cb_area_ItemsRequested" OnSelectedIndexChanged="cb_area_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                    <%--&nbsp;
                                <td>
                                    <telerik:RadTextBox ID="RadTextBox1" runat="server" Width="270px" Enabled="true" RenderMode="Lightweight"
                                                    Text='<%#DataBinder.Eval(Container, "DataItem.region_name") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>--%>
                                </td>
                             </tr>
                            <tr>
                                <td>
                                    Remark :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_remark" runat="server" Width="270px" Height="50px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.remark") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                               <td colspan="2" style="padding:10px 0px 10px 0px">
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
    </div>
</asp:Content>
