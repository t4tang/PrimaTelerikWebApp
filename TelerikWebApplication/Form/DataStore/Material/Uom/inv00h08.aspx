<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h08.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Material.Uom.inv00h08" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="../../../../Styles/common.css" rel="stylesheet" />
        <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl"/>
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_new">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>       
                <td style="vertical-align: middle; margin-left: 10px; padding:0px 0px 0px 0px">
                    <telerik:RadButton ID="btn_new" runat="server" ForeColor="OrangeRed" BackColor="#33ccff" Text="New" Width="80px" Height="30px"
                        Skin="Telerik" OnClick="btn_new_Click" ></telerik:RadButton>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                     
                </td>                           
                <td style="width: 98%; text-align: right; padding-right:17px">
                     <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <telerik:RadLabel ID="lbl_form_name" Text="UoM" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                                padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                            </telerik:RadLabel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div> 

    <div class="scroller" style="overflow-y:scroll; height:620px">

        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" ShowFooter="false" AutoGenerateColumns="false" 
            MasterTableView-AllowFilteringByColumn="true" MasterTableView-DataKeyNames="unit_code" Skin="Silk" CssClass="RadGrid_ModernBrowsers"
            MasterTableView-ClientDataKeyNames="unit_code" MasterTableView-CommandItemDisplay="Top" 
            AllowPaging="true" AllowSorting="true" OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand" 
            OnUpdateCommand="RadGrid1_EditCommand" OnInsertCommand="RadGrid1_InsertCommand" >
            <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
            <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic">
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
                                 <td colspan="2" style="padding:10px 0px 10px 0px">
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
