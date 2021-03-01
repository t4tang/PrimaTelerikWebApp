<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h04.aspx.cs" Inherits="TelerikWebApplication.Form.Master_data.Material.Brand.material_brand" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function RowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
 
            function onPopUpShowing(sender, args) {
                args.get_popUp().className += " popUpEditForm";
            }
        </script>
    </telerik:RadCodeBlock>

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
                            <telerik:RadLabel ID="lbl_form_name" Text="Material Brand" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                                padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                            </telerik:RadLabel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>

    <div class="scroller" style="overflow-y:scroll; height:620px">
        <!-- Page Content -->
             <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" Skin="Silk" CssClass="RadGrid_ModernBrowsers"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnUpdateCommand="RadGrid1_UpdateCommand" AllowFilteringByColumn="true" OnItemCreated="RadGrid1_ItemCreated"
                OnInsertCommand="RadGrid1_InsertCommand" OnDeleteCommand="RadGrid1_DeleteCommand" BorderStyle="Solid" Font-Names="Calibri">
                 <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
                <MasterTableView Width="100%" CommandItemDisplay="none" DataKeyNames="brand_code" Font-Size="11px" Font-Names="Century Gothic">                        
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn"><HeaderStyle Width="20px"></HeaderStyle>
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="brand_code" HeaderText="Brand Code" DataField="brand_code">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>                        
                        <telerik:GridBoundColumn UniqueName="brand_name" HeaderText="Brand Name" DataField="brand_name">
                            <HeaderStyle Width="250px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" 
                            ConfirmText="Are you sure you want to delete this row or record?">
                                <HeaderStyle Width="20px"></HeaderStyle>
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table cellspacing="4" cellpadding="5" width="100%" border="0" class="formTemplate_Table">
                            <tr >
                                <td>Brand Code:
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_brand_code" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.brand_code") %>'>
                                    </asp:TextBox>
                                </td>
                            </tr>             
                            <tr>
                                <td>Brand Name:
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_brand_name" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.brand_name") %>'>
                                    </asp:TextBox>
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

    </div>
</asp:Content>
