 <%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc00h22.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.PreventiveMaintenance.JobType.mtc00h22" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl"/>
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div style="overflow:auto">
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="true" AllowSorting="true" 
            AutoGenerateColumns="false" ShowFooter="true" MasterTableView-DataKeyNames="PMact_type" 
            MasterTableView-ClientDataKeyNames="PMact_type" MasterTableView-CommandItemDisplay="Top" 
            MasterTableView-AllowFilteringByColumn="true" OnNeedDataSource="RadGrid1_NeedDataSource" 
            OnItemCreated="RadGrid1_ItemCreated" OnUpdateCommand="RadGrid1_UpdateCommand" 
            OnInsertCommand="RadGrid1_InsertCommand" OnDeleteCommand="RadGrid1_DeleteCommand" 
            >

            <MasterTableView Font-Names="Calibri" Font-Size="13px">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="30px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Code" DataField="PMact_type">
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Job Type" DataField="PMact_name">
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Historical" DataField="status_hist">
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn UniqueName="Delete" CommandName="Delete" HeaderStyle-Width="30px" 
                        ConfirmText="Are you sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                        <HeaderStyle Width="30px" />
                    </telerik:GridButtonColumn> 
                </Columns>

                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table id="table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                               padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
                            <tr class="EditFormHeader">
                                <td colspan="2">
                                    <b>Master Job Type</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="Table3" border="0" class="module">
                                        <tr>
                                            <td>Code</td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_code" runat="server" Width="50px" Enabled="true" RenderMode="Lightweight" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.PMact_type") %>' AutoPostBack="false">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Job Type</td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_job" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.PMact_name") %>' AutoPostBack="false">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Historical</td>
                                            <td>
                                                <telerik:RadComboBox ID="cb_hist" runat="server" RenderMode="Lightweight" Width="150px" EnableLoadOnDemand="true" 
                                                    ShowDropDownOnTextboxClick="true" EnableVirtualScrolling="true" ShowMoreResultsBox="true" Height="200" MarkFirstMatch="true" 
                                                    OnItemsRequested="cb_hist_ItemsRequested" OnSelectedIndexChanged="cb_hist_SelectedIndexChanged"                                                      
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.status_hist") %>' OnPreRender="cb_hist_PreRender" >
                                                </telerik:RadComboBox>
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
                <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Title="Editing Record"
                     Height="490px" Width="850px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
</asp:Content>
