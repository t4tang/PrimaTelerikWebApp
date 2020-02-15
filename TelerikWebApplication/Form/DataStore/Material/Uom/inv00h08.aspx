<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h08.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Material.Uom.inv00h08" %>
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
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="True" AutoGenerateColumns="false"
            ShowFooter="True" MasterTableView-AllowFilteringByColumn="true" AllowSorting="True" 
            MasterTableView-DataKeyNames="unit_code" MasterTableView-ClientDataKeyNames="unit_code"
             OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand" 
            MasterTableView-CommandItemDisplay="Top" OnUpdateCommand="RadGrid1_EditCommand" OnInsertCommand="RadGrid1_InsertCommand"   
            >

            <MasterTableView>
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                                        
                    <telerik:GridBoundColumn HeaderText="Unit Code" DataField="unit_code">
                    <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    
                     <telerik:GridBoundColumn HeaderText="Unit Name" DataField="unit_name">
                    <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>                    
                    
                     <telerik:GridButtonColumn UniqueName="Delete" CommandName="Delete" HeaderStyle-Width="30px" 
                         ConfirmText="Delete this Supplier?" ConfirmDialogType="RadWindow" ConfirmTitle="Delete" 
                         ButtonType="FontIconButton">
                         <HeaderStyle Width="30px" />
                     </telerik:GridButtonColumn>

                 </Columns>

                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table>
                           <tr>
                                <td>Unit Code</td>
                                <td>
                                <telerik:RadTextBox ID="txt_unit_code" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight" 
                                Text='<%# DataBinder.Eval(Container, "DataItem.unit_code") %>' AutoPostBack="false">
                                </telerik:RadTextBox> 
                                </td>
                            </tr>
                            <tr>
                                <td>Unit Name</td>
                                <td>
                                <telerik:RadTextBox ID="txt_unit_name" runat="server" Width="350px" Enabled="true" RenderMode="Lightweight" 
                                Text='<%# DataBinder.Eval(Container, "DataItem.unit_name") %>' AutoPostBack="false">
                                </telerik:RadTextBox> 
                                </td>
                            </tr>
                            <%--<tr>
                                <td>Last Update</td>
                                <td>
                                    <telerik:RadDateTimePicker ID="lastupdate" runat="server" 
                                        Text='<%# DataBinder.Eval(Container, "DataItem.userid") %>' AutoPostBack="false" >
                                        <Calendar runat="server" EnableWeekends="true"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/mm/yy" DateFormat="dd/mm/yy">
                                            <EmptyMessageStyle Resize="Both" />
                                        </DateInput>
                                    </telerik:RadDateTimePicker>
                                </td>
                            </tr>
                            <tr>
                                <td>User ID</td>
                                <td>
                                    <telerik:RadTextBox ID="txt_userid" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight" 
                                        Text='<%# DataBinder.Eval(Container, "DataItem.userid") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>--%>
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
