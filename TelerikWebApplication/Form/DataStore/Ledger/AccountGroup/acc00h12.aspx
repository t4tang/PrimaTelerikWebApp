<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc00h12.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Ledger.AccountGroup.acc00h10" %>
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
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" ShowFooter="true" 
            AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" 
            MasterTableView-DataKeyNames="accountgroup" MasterTableView-ClientDataKeyNames="accountgroup" 
            MasterTableView-AllowFilteringByColumn="true" MasterTableView-CommandItemDisplay="Top" 
            OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand" 
            OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand" OnItemCreated="RadGrid1_ItemCreated" 
            >

            <MasterTableView Font-Names="Calibri" Font-Size="13px">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Code" DataField="accountgroup">
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Name" DataField="groupname">
                        <HeaderStyle Width="300px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText="Balance" DataField="balance">
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Sub Category" DataField="name">
                        <HeaderStyle Width="300px" />
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
                                    <b>Currency Code</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="Table3" border="0" class="module">
                                        <tr>
                                            <td>Code
                                            </td>
                                            <td>
                                                 <telerik:RadTextBox ID="txt_account" runat="server" RenderMode="Lightweight" Width="100px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.accountgroup") %>' AutoPostBack="false" >
                                                 </telerik:RadTextBox>
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Group Name
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_gp_name" runat="server" RenderMode="Lightweight" Width="250px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.groupname") %>' AutoPostBack="false">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Balance
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="cb_balance" runat="server" RenderMode="Lightweight" Width="200px" EnableLoadOnDemand="true" 
                                                    ShowDropDownOnTextboxClick="true" EnableVirtualScrolling="true" ShowMoreResultsBox="true" MarkFirstMatch="true" 
                                                    OnItemsRequested="cb_balance_ItemsRequested" OnSelectedIndexChanged="cb_balance_SelectedIndexChanged" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.balance") %>' OnPreRender="cb_balance_PreRender">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Sub Category
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="cb_sub" runat="server" RenderMode="Lightweight" Width="250px" EnableLoadOnDemand="true" 
                                                    ShowDropDownOnTextboxClick="true" EnableVirtualScrolling="true" ShowMoreResultsBox="true" Height="200" MarkFirstMatch="true" 
                                                    OnItemsRequested="cb_sub_ItemsRequested" OnSelectedIndexChanged="cb_sub_SelectedIndexChanged" AutoPostBack="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.name") %>' OnPreRender="cb_sub_PreRender" >
                                                </telerik:RadComboBox> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
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
                                <td align="right" colspan="2"  style="padding-top:10px">
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
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Title="Editing Record"
                     Height="490px" Width="850px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">

                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
</asp:Content>
