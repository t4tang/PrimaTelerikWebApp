<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h10.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Support.Departemen.inv00h10" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="../../../../Styles/common.css" rel="stylesheet" />
        <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl"/>
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="scroller">
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AutoGenerateColumns="false" 
            AllowPaging="true" AllowSorting="true" ShowFooter="true" MasterTableView-DataKeyNames="dept_code" 
            MasterTableView-ClientDataKeyNames="dept_code" MasterTableView-CommandItemDisplay="Top" 
            OnNeedDataSource="RadGrid1_NeedDataSource" OnItemCreated="RadGrid1_ItemCreated" 
            OnDeleteCommand="RadGrid1_DeleteCommand" OnUpdateCommand="RadGrid1_UpdateCommand" OnInsertCommand="RadGrid1_InsertCommand" 
            >
             <MasterTableView>
                 <Columns>
                     <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                         <HeaderStyle Width="30px"/>
                     </telerik:GridEditCommandColumn>
                     <telerik:GridBoundColumn HeaderText="Code Dept" DataField="dept_code">
                         <HeaderStyle Width="100px" />
                     </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText="Department" DataField="dept_name">
                         <HeaderStyle Width="250px" />
                     </telerik:GridBoundColumn>
                     <telerik:GridButtonColumn UniqueName="Delete" CommandName="Delete" HeaderStyle-Width="30px" 
                         ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow">
                         <HeaderStyle Width="30px" />
                     </telerik:GridButtonColumn>
                 </Columns>

                 <EditFormSettings EditFormType="Template">
                     <FormTemplate>
                         <table id="table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                                    padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;" >
                             <tr class="EditFormHeader">
                                 <td colspan="2">
                                     <b>File Support (Depertment)</b>
                                 </td>
                             </tr>
                             <tr>
                                 <td>
                                     <table id="Table3" border="0" class="module">
                                         <tr>
                                             <td>Code</td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_code" runat="server" Width="50px" RenderMode="Lightweight" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Department</td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_name" runat="server" Width="350px" RenderMode="Lightweight" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.dept_name") %>' AutoPostBack="false">
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
