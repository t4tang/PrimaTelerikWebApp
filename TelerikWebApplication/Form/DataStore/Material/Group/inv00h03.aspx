﻿<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h03.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Material.Group.inv00h03" %>
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
        <!-- Page Content -->
             <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" Skin="Silk"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand"
                 OnDeleteCommand="RadGrid1_DeleteCommand" OnItemCreated="RadGrid1_ItemCreated" CssClass="RadGrid_ModernBrowsers"
                AllowFilteringByColumn="true" BorderStyle="Solid" Font-Names="Calibri" Font-Size="Small">
                <%--<PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>--%>
                 <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
                    <MasterTableView Width="100%" CommandItemDisplay="None" DataKeyNames="group_code" Font-Size="11px" PageSize="10"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" Font-Names="Century Gothic">                        
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn"><HeaderStyle Width="20px"></HeaderStyle>
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="group_code" HeaderText="Code" DataField="group_code">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>                        
                        <telerik:GridBoundColumn UniqueName="group_name" HeaderText="Group" DataField="group_name">
                            <HeaderStyle Width="300px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" 
                            ConfirmText="Are you sure you want to delete this row or record?">
                             <HeaderStyle Width="20px"></HeaderStyle>
                        </telerik:GridButtonColumn>
                    </Columns>
                   
                    <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                            <table id="Table2" cellspacing="4" cellpadding="5" width="100%" border="0" class="formTemplate_Table">
                                <tr>        
                                    <td>
                                        <table id="Table3" border="0" class="module">                
                                            <tr>
                                                <td>Group Code
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_group_code" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.group_code") %>'>
                                                    </asp:TextBox>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
                                                </td>
                                            </tr>             
                                            <tr>
                                                <td>Group Name
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_group_name" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.group_name") %>'>
                                                    </asp:TextBox>
                                                </td>
                                            </tr> 
                                           <tr style="vertical-align:top">
                                                <td>Group Type
                                                </td>
                                                <td>   
                                                    <telerik:RadComboBox ID="cb_group_type" runat="server" RenderMode="Lightweight" Width="200px" EnableLoadOnDemand="true" 
                                                        ShowDropDownOnTextboxClick="true"  ShowMoreResultsBox="true" Height="200" MarkFirstMatch="true"  
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.GroupType") %>' 
                                                         OnPreRender="cb_group_type_PreRender" OnItemsRequested="cb_group_type_ItemsRequested" 
                                                        OnSelectedIndexChanged="cb_group_type_SelectedIndexChanged" >
                                                    </telerik:RadComboBox>
                                                    <%--<asp:RadioButtonList SelectedValue='<%#Eval("GroupType")%>' ID="rbl_group_type" OnPreRender="rbl_group_type_PreRender" 
                                                        RepeatDirection="Vertical"  runat="server">
                                                        <asp:ListItem Value="Sparepart" Text="Sparepart"></asp:ListItem>
                                                        <asp:ListItem Value="Fuel" Text="Fuel"></asp:ListItem>
                                                        <asp:ListItem Value="Oil" Text="Oil"></asp:ListItem>
                                                        <asp:ListItem Value="Asset" Text="Asset"></asp:ListItem>
                                                        <asp:ListItem Value="Service" Text="Service"></asp:ListItem>
                                                        <asp:ListItem Value="Other" Text="Other"></asp:ListItem>
                                                    </asp:RadioButtonList>--%>
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
                                    <td colspan="2" style="padding:10px 0px 10px 0px">
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
