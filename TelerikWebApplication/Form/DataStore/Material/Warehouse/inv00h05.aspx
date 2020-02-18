<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h05.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Material.Warehouse.inv00h05" %>
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
                         AutoGenerateColumns="false" OnDeleteCommand="RadGrid1_DeleteCommand" Skin="MetroTouch" OnNeedDataSource="RadGrid1_NeedDataSource"
                         OnUpdateCommand="RadGrid1_UpdateCommand" AllowFilteringByColumn="true" OnInsertCommand="RadGrid1_InsertCommand" OnItemCreated="RadGrid1_ItemCreated">
            <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
            <MasterTableView CommandItemDisplay="Top" AllowFilteringByColumn="true" DataKeyNames="wh_code" Width="100%" Font-Names="Calibri" Font-Size="13px" 
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText ="Code" DataField="wh_code">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Storage Location" DataField="wh_name">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Type" DataField="type_out">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Material" DataField="ref_prod_code">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Capacity" DataField="FluitCap">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" 
                            ConfirmText="Are you sure you want to delete this row or record?">
                             <HeaderStyle Width="20px"></HeaderStyle>
                        </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table id="Table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                            padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
                            <tr>
                                <td>
                                    Code :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_code" runat="server" Width="80px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.wh_code") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                                &nbsp;
                                <td>
                                    Consignment :
                                </td>
                                <td>
                                    <asp:CheckBox ID="cb_consig" runat="server" Text='<%#DataBinder.Eval(Container, "DataItem.type_out") %>' AutoPostBack="false">
                                    </asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Storage :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_storage" runat="server" Width="230px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.wh_name") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Project :
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_project" runat="server" Width="215px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.region_name") %>' AutoPostBack="false"
                                                         ShowDropDownOnTextboxClick="true" OnPreRender="cb_project_PreRender" EnableLoadOnDemand="true" EnableVirtualScrolling="true"
                                                         ShowMoreResultsBox="true" MarkFirstMatch="true" OnItemsRequested="cb_project_ItemsRequested"
                                                         OnSelectedIndexChanged="cb_project_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr >
                                <td>
                                    Type:
                                </td>
                                <td >
                                    <telerik:RadComboBox ID="cb_type" runat="server" RenderMode="Lightweight" Width="100px"
                                                         Text='<%#DataBinder.Eval(Container, "DataItem.type_out") %>'
                                                         ShowDropDownOnTextboxClick="true" OnPreRender="cb_type_PreRender"
                                                         EnableLoadOnDemand="True" EnableVirtualScrolling="false"
                                                         ShowMoreResultsBox="false" MarkFirstMatch="True"
                                                         OnItemsRequested="cb_type_ItemsRequested" OnSelectedIndexChanged="cb_type_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                           <tr >
                                <td>
                                    Material Reference:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_material_ref" runat="server" RenderMode="Lightweight" Width="170px"
                                                         Text='<%#DataBinder.Eval(Container, "DataItem.ref_prod_code") %>'
                                                         ShowDropDownOnTextboxClick="true" EnableLoadOnDemand="True" EnableVirtualScrolling="false"
                                                         ShowMoreResultsBox="false" MarkFirstMatch="True" DropDownWidth="350px"
                                                         OnItemsRequested="cb_material_ref_ItemsRequested" OnSelectedIndexChanged="cb_material_ref_SelectedIndexChanged">
                                        <%--<HeaderTemplate>
                                            <table style="width: 275px" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td style="width: 175px;">
                                                        Product Name
                                                    </td>
                                                    <td style="width: 60px;">
                                                        Quantity
                                                    </td>
                                                    <td style="width: 40px;">
                                                        Price
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 600px">
                                                <tr>
                                                    <td style="width: 140px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.prod_code")%>
                                                    </td>
                                                    <td style="width: 460px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.spec")%>
                                                    </td>                                                                
                                                </tr>
                                            </table>
                                        </ItemTemplate>--%>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Cap. Tanki :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_cap_tanki" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.FluitCap") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Address :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_address" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.address") %>' AutoPostBack="false">
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
        <telerik:RadWindowManager ID="RadWindowManager1" RenderMode="Lightweight" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Title="Editing Record" Height="490px"
                                    Width="850px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
</asp:Content>
