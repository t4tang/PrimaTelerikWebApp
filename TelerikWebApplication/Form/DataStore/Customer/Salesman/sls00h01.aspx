<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="sls00h01.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Customer.Salesman.sls00h01" %>
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

    <telerik:RadAjaxLoadingPanel runat="server" ID="GridLoadingPanel1">
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
                            <telerik:RadLabel ID="lbl_form_name" Text="Master Salesman" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                                padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                            </telerik:RadLabel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div> 
    
    <div class="scroller" style="overflow-y:scroll; height:620px"> 
        <%--PAGE CONTENT--%>
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="true" ShowFooter="false" AllowSorting="true"
                         AutoGenerateColumns="false" Skin="Silk" OnNeedDataSource="RadGrid1_NeedDataSource" CssClass="RadGrid_ModernBrowsers"
                         OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand" OnDeleteCommand="RadGrid1_DeleteCommand"
                         OnItemCreated="RadGrid1_ItemCreated" AllowFilteringByColumn="true">
            <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
            <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
            <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText ="Code" DataField="sales_code">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Salesman" DataField="sales_name">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Sub Area" DataField="sar_name">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Target" DataField="tJual">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText="Active" DataField="status">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <%--<telerik:GridCheckBoxColumn DataType="System.Boolean" HeaderText ="Active" DataField="status">
                        <HeaderStyle Width="200px" />
                    </telerik:GridCheckBoxColumn>--%>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" 
                            ConfirmText="Are you sure you want to delete this row or record?">
                             <HeaderStyle Width="20px"></HeaderStyle>
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table ID="Table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                            padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
                            <tr class="EditFormHeader">
                                <td colspan="2">
                                    <b style="font-weight: bold; font-variant: small-caps; text-decoration: underline; color: #990000;">Salesman</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Code :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_code" runat="server" Width="80px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.sales_code") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                                &nbsp;
                                <td>
                                    Active :
                                </td>
                                <td>
                                    <asp:CheckBox ID="chk_active" runat="server" Text="Active" Checked="true"/>
                                                  
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Salesman :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_salesman" runat="server" Width="230px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.sales_name") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Sub Area Sales :
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_sub_area" runat="server" Width="215px" Enabled="true" RenderMode="Lightweight"
                                                         Text='<%#DataBinder.Eval(Container, "DataItem.sar_name") %>' AutoPostBack="false"
                                                         ShowDropDownOnTextboxClick="true" OnPreRender="cb_sub_area_PreRender" EnableLoadOnDemand="true"
                                                         EnableVirtualScrolling="true" ShowMoreResultsBox="true" MarkFirstMatch="true"
                                                         OnItemsRequested="cb_sub_area_ItemsRequested" OnSelectedIndexChanged="cb_sub_area_SelectedIndexChanged" 
                                                         EmptyMessage="Select area sales">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Target :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_target" runat="server" Width="230px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.tJual") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Address :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_address" runat="server" Width="230px" Height="50px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.address") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    City :
                                </td>
                            <td>
                                <telerik:RadComboBox ID="txt_city" runat="server" Width="215px" Enabled="true" RenderMode="Lightweight"
                                                     Text='<%#DataBinder.Eval(Container, "DataItem.city_name") %>' AutoPostBack="false"
                                                     ShowDropDownOnTextboxClick="true" OnPreRender="txt_city_PreRender" EnableLoadOnDemand="true"
                                                     EnableVirtualScrolling="true" ShowMoreResultsBox="true" MarkFirstMatch="true"
                                                     OnItemsRequested="txt_city_ItemsRequested" OnSelectedIndexChanged="txt_city_SelectedIndexChanged" 
                                                     EmptyMessage="Select City">
                                </telerik:RadComboBox>
                            </td>
                            &nbsp;
                                <td>
                                    Phone :
                                </td>
                            <td>
                                <telerik:RadTextBox ID="txt_phone" runat="server" Width="230px" Enabled="true" RenderMode="Lightweight"
                                                    Text='<%#DataBinder.Eval(Container, "DataItem.phone") %>' AutoPostBack="false">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                            <tr>
                                <td>
                                    E-Mail :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_email" runat="server" Width="230px" Enabled="true" RenderMode="Lightweight"
                                                        Text='<%#DataBinder.Eval(Container, "DataItem.email") %>' AutoPostBack="false">
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
