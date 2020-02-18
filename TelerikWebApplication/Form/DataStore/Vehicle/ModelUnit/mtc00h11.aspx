<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc00h11.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Vehicle.ModelUnit.mtc00h11" %>
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
            AutoGenerateColumns="false" MasterTableView-DataKeyNames="model_no" MasterTableView-ClientDataKeyNames="model_no" 
            MasterTableView-AllowFilteringByColumn="true" MasterTableView-CommandItemDisplay="Top" 
            OnDeleteCommand="RadGrid1_DeleteCommand" OnItemCreated="RadGrid1_ItemCreated" 
            OnUpdateCommand="RadGrid1_UpdateCommand" OnInsertCommand="RadGrid1_InsertCommand" 
            >
            
            <MasterTableView>
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Model Number" DataField="model_no">
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Model Remark" DataField="model_remark">
                        <HeaderStyle Width="350px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Manufacture" DataField="manu_name" Visible="true">
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
                                    <b>Vehicle</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="Table3" border="0" class="module">
                                        <tr>
                                            <td>Model Number</td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_model_number" runat="server" RenderMode="Lightweight" Width="150px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.model_no") %>' AutoPostBack="false">
                                                </telerik:RadTextBox>
                                            </td>                                            
                                        </tr>
                                        <tr>
                                            <td>Model Remark</td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_model_remark" runat="server" RenderMode="Lightweight" Width="150px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.model_remark") %>' AutoPostBack="false">
                                                </telerik:RadTextBox> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Manufacture</td>
                                            <td>
                                                <telerik:RadComboBox ID="dd_manu" runat="server" RenderMode="Lightweight" Width="200px" EnableLoadOnDemand="true" 
                                                    ShowDropDownOnTextboxClick="true" EnableVirtualScrolling="true" ShowMoreResultsBox="true" Height="200" MarkFirstMatch="true"  
                                                    OnItemsRequested="dd_manu_ItemsRequested" OnSelectedIndexChanged="dd_manu_SelectedIndexChanged1"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.manu_name") %>' OnPreRender="dd_manu_PreRender" >
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
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Title="Editing Record"
                     Height="490px" Width="850px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">

                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager> 
    </div>
</asp:Content>
