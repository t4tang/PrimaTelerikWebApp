<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h02.aspx.cs" Inherits="TelerikWebApplication.Form.Master_data.Material.Category.category" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
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
                            <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                                padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                            </telerik:RadLabel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>    

    <div class="scroller" style="overflow-y:scroll; height:620px">   

            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="true" Skin="Silk" CssClass="RadGrid_ModernBrowsers"
                    AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true"
                    OnNeedDataSource="RadGrid1_NeedDataSource" OnUpdateCommand="RadGrid1_UpdateCommand" AllowFilteringByColumn="true"
                    OnInsertCommand="RadGrid1_InsertCommand" OnDeleteCommand="RadGrid1_DeleteCommand" OnItemCreated="RadGrid1_ItemCreated" 
                        BorderStyle="Solid" Font-Names="Calibri">
                        <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
                        <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                        <MasterTableView Width="100%" CommandItemDisplay="None" DataKeyNames="kind_code" Font-Size="11px" PageSize="10"
                        EditFormSettings-PopUpSettings-KeepInScreenBounds="true" Font-Names="Century Gothic">
                            <CommandItemStyle BackColor="#00ccff" ForeColor="White" />                        
                        <Columns>
                            <telerik:GridEditCommandColumn UniqueName="EditCommandColumn"><HeaderStyle Width="20px"></HeaderStyle>
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn UniqueName="kind_code" HeaderText="Code" DataField="kind_code">
                                <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>                        
                            <telerik:GridBoundColumn UniqueName="kind_name" HeaderText="Category" DataField="kind_name">
                                <HeaderStyle Width="300px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="prod_type_name" HeaderText="Type" DataField="prod_type_name">
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="status_main" HeaderText="Status Maintenance" DataField="status_main">
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" 
                                ConfirmText="Are you sure you want to delete this row or record?">
                                    <HeaderStyle Width="20px"></HeaderStyle>
                            </telerik:GridButtonColumn>
                        </Columns>
                        <%--<EditFormSettings UserControlName="category_data_entry.ascx" EditFormType="WebUserControl">
                            <EditColumn UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>--%>
                        <EditFormSettings EditFormType="Template">
                            <FormTemplate>
                                <table id="Table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                                        padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
                                    <tr class="EditFormHeader">
                                        <td colspan="2">
                                            <b>Material Data</b>
                                        </td>
                                    </tr>
                                    <tr>        
                                        <td>
                                            <table id="Table3" border="0" class="module">                
                                                <tr>
                                                    <td>Category Code:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_kind_code" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.kind_code") %>'>
                                                        </asp:TextBox>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
                                                    </td>
                                                </tr>             
                                                <tr>
                                                    <td>Category Name:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_kind_name" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.kind_name") %>'>
                                                        </asp:TextBox>
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td>Product Type:
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_type" runat="server" Width="300" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.prod_type_name") %>'
                                                            DataValueField='<%# DataBinder.Eval(Container, "DataItem.prod_type_code") %>' 
                                                            DataTextField="prod_type_name" AutoPostBack="false" OnPreRender="cb_type_PreRender"
                                                            EmptyMessage="Select the product type" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                            EnableVirtualScrolling="true" OnItemsRequested="cb_type_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_type_SelectedIndexChanged">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>                  
                                                <tr>
                                                    <td>
                                                        Status Maintenance:
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_st_main" runat="server" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.status_main") %>' 
                                                            AutoPostBack="false" Width="300px" OnPreRender="cb_st_main_PreRender" 
                                                            OnSelectedIndexChanged="cb_st_main_SelectedIndexChanged" 
                                                            EmptyMessage="Select the status maintenance" EnableLoadOnDemand="True" ShowMoreResultsBox="false"
                                                            EnableVirtualScrolling="true" OnItemsRequested="cb_st_main_ItemsRequested" >
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td style="height:30px">
                                                        <asp:Button ID="btn_gl_account" Text="GL Account Setting" runat="server" CausesValidation="False"></asp:Button>
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
                                        <td align="right" colspan="2" style="height:30px">
                                            <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                                runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'></asp:Button>&nbsp;
                                            <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                                                CommandName="Cancel"></asp:Button>
                                        </td>
                                    </tr>
                                </table>
                            </FormTemplate>
                        </EditFormSettings>
                    </MasterTableView>
                    <ClientSettings>
                        <ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />
                    </ClientSettings>
            </telerik:RadGrid>   

    </div>

</asp:Content>
