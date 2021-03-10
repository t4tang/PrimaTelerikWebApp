<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="pro00h04.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.MineControlProduction.LocationCategory.pro00h04" %>
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
                            <telerik:RadLabel ID="lbl_form_name" Text="Location Of Product" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                                padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                            </telerik:RadLabel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div> 
    
    <div class="scroller" style="overflow-y:scroll; height:620px"> 
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="true" ShowFooter="true" AllowSorting="true"
                         AutoGenerateColumns="false" Skin="Silk" OnNeedDataSource="RadGrid1_NeedDataSource" CssClass="RadGrid_ModernBrowsers"
                         OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand" OnDeleteCommand="RadGrid1_DeleteCommand"
                         OnItemCreated="RadGrid1_ItemCreated" AllowFilteringByColumn="true">
            <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
            <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic" AllowFilteringByColumn="true" DataKeyNames="loc_cate_code" Width="100%"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText ="Code" DataField="loc_cate_code">
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Category" DataField="cat_name">
                        <HeaderStyle Width="800px" />
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
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.loc_cate_code") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Loc. Category :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_category" runat="server" Width="270px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.cat_name") %>' AutoPostBack="false">
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
