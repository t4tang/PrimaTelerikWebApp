<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc00h27.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Vehicle.Compartment.mtc00h27" %>
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
            MasterTableView-DataKeyNames="compart_code" MasterTableView-ClientDataKeyNames="compart_code" 
            MasterTableView-AllowFilteringByColumn="true" MasterTableView-CommandItemDisplay="Top" 
            OnNeedDataSource="RadGrid1_NeedDataSource" OnItemCreated="RadGrid1_ItemCreated" OnDeleteCommand="RadGrid1_DeleteCommand" 
            OnUpdateCommand="RadGrid1_UpdateCommand" OnInsertCommand="RadGrid1_InsertCommand" 
            >

            <MasterTableView Font-Names="Calibri" Font-Size="13px">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Code" DataField="compart_code">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Compartement" DataField="compart_remark">
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Equipment" DataField="equipment_remark">
                        <HeaderStyle Width="30px" />
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
                                    <b>Master Compartement</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="Table3" border="0" class="module">
                                        <tr>
                                            <td>Code
                                            </td>
                                            <td>
                                                 <telerik:RadTextBox ID="txt_compart_code" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.compart_code") %>' AutoPostBack="false" >
                                                 </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Compartement
                                            </td>
                                            <td>
                                                 <telerik:RadTextBox ID="txt_compart_remark" runat="server" RenderMode="Lightweight" Width="280px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.compart_remark") %>' AutoPostBack="false" >
                                                 </telerik:RadTextBox>    
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Equipment Remark
                                            </td>
                                            <td>
                                                 <telerik:RadTextBox ID="txt_equipment_remark" runat="server" RenderMode="Lightweight" Width="280px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.equipment_remark") %>' AutoPostBack="false" >
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
