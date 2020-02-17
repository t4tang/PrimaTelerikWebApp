<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc00h25.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.PreventiveMaintenance.MaintenanceOperation.mtc00h25" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl"/>
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>

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
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="scroller">
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" OnNeedDataSource="RadGrid1_NeedDataSource" 
            ShowFooter="true" AllowPaging="true" AllowSorting="true" 
            AutoGenerateColumns="false" MasterTableView-DataKeyNames="OprCode" MasterTableView-ClientDataKeyNames="OprCode" 
            MasterTableView-AllowFilteringByColumn="true" MasterTableView-CommandItemDisplay="Top" 
            OnDeleteCommand="RadGrid1_DeleteCommand" OnItemCreated="RadGrid1_ItemCreated" 
            OnUpdateCommand="RadGrid1_UpdateCommand" OnInsertCommand="RadGrid1_InsertCommand" 
            >

            <MasterTableView>
                <Columns>
                     <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Code" DataField="OprCode">
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>    
                    <telerik:GridBoundColumn HeaderText="Operation Maintenance" DataField="OprName">
                        <HeaderStyle Width="350px" />
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
                            <tr class="EditFormHeader">
                                <td colspan="2">
                                    <b>Maintenance Operation</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="Table3" border="0" class="module">
                                        <tr>
                                            <td>Code</td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_code" runat="server" RenderMode="Lightweight" Width="150px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.OprCode") %>' AutoPostBack="false">
                                                </telerik:RadTextBox>
                                            </td>                                            
                                        </tr>
                                        <tr>
                                            <td>Operation</td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_operation" runat="server" RenderMode="Lightweight" Width="150px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.OprName") %>' AutoPostBack="false">
                                                </telerik:RadTextBox> 
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td ></td>
                                <td></td>
                            </tr>
                            <tr>
                                 <td align="right" colspan="2">
                                     <asp:Button ID="btnupdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' 
                                         runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' />                                                                               
                                     <asp:Button ID="btncancel" Text="Cancel" runat="server" CausesValidation="false" CommandName="Cancel" />
                                 </td>
                             </tr>
                        </table>
                    </FormTemplate>
                </EditFormSettings>
            </MasterTableView>
            <FilterMenu RenderMode="Lightweight"></FilterMenu>
        </telerik:RadGrid>
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server" RenderMode="Lightweight" EnableShadow="true">
            <Windows>
                <telerik:RadWindow ID="UserListDialog" runat="server" RenderMode="Lightweight" Title="EditingRecord" 
                    Height="490px" Width="850px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
</asp:Content>
