<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h19.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Controlling.ProfitCenter.inv00h19" %>
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
                            <telerik:RadLabel ID="lbl_form_name" Text="Profit Center" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
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
            MasterTableView-DataKeyNames="ProfitCtr" MasterTableView-ClientDataKeyNames="ProfitCtr" MasterTableView-CommandItemDisplay="Top" 
            AllowPaging="true" AllowSorting="true" OnNeedDataSource="RadGrid1_NeedDataSource" 
            OnItemCreated="RadGrid1_ItemCreated" OnDeleteCommand="RadGrid1_DeleteCommand" Skin="Silk"
            OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand"
            CssClass="RadGrid_ModernBrowsers">
            <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
            <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic">
                <Columns>

                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Height="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Profit Center" DataField="ProfitCtr">
                        <HeaderStyle Height="200" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Profit Center Name" DataField="ProfitCtrName">
                        <HeaderStyle Height="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Project Area" DataField ="region_name" >
                        <HeaderStyle Width="420px" /> 
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn UniqueName="Delete" CommandName="Delete" HeaderStyle-Width="30px" 
                        ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ConfirmText="Are You Sure ?" 
                        ButtonType="FontIconButton">
                        <HeaderStyle Width="30px" />
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table id="table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                                    padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
                            <tr class="EditFormHeader">
                                <td colspan="2">
                                    <b style="font-weight: bold; font-variant: small-caps; text-decoration: underline; color: #990000;">Controlling</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="Table3" border="0" class="module">
                                        <tr>
                                            <td>
                                                Profit Center :
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_profit_ctr" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.ProfitCtr") %>' AutoPostBack="false">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Profit Center Name :
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_profit_center_name" runat="server" Width="350px" Enabled="true" RenderMode="Lightweight" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.ProfitCtrName") %>' AutoPostBack="false">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Company :
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="cb_company" runat="server" RenderMode="Lightweight" Width ="350px"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.company_name") %>' EnableVirtualScrolling="false" 
                                                    OnItemsRequested="cb_company_ItemsRequested" OnPreRender="cb_company_PreRender" 
                                                    OnSelectedIndexChanged="cb_company_SelectedIndexChanged" EnableLoadOnDemand="true" Enabled="true" 
                                                    ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch" Height="200" 
                                                    MarkFirstMatch="true" EmptyMessage="Select Company">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Project Area :
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="cb_region" runat="server" RenderMode="Lightweight" Width ="350px"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' EnableVirtualScrolling="false" 
                                                    OnItemsRequested="cb_region_ItemsRequested" OnPreRender="cb_region_PreRender" 
                                                    OnSelectedIndexChanged="cb_region_SelectedIndexChanged" EnableLoadOnDemand="true" Enabled="true"
                                                    ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch" Height="200" 
                                                    MarkFirstMatch="true" EmptyMessage="Select Area Project">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Person In Charge :
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_PersonIC" runat="server" Width="350px" Enabled="true"
                                                    RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.PersonIC") %>'  AutoPostBack="false">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Category :
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="cb_category" runat="server" RenderMode="Lightweight" Width ="350px"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.DivName") %>' EnableVirtualScrolling="false" 
                                                    OnItemsRequested="cb_category_ItemsRequested" OnPreRender="cb_category_PreRender" 
                                                    OnSelectedIndexChanged="cb_category_SelectedIndexChanged" EnableLoadOnDemand="true" Enabled="true"  
                                                    ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch" Height="200" 
                                                    MarkFirstMatch="true" EmptyMessage="Select Category">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Heirarchy :
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_Heirarchy" runat="server" Width="350px" Enabled="true"
                                                    RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.Heirarchy") %>'  AutoPostBack="false">
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
        <telerik:RadWindowManager ID="RadWindowManager" runat="server" RenderMode="Lightweight" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Title="Editing Record"
                     Height="490px" Width="850px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
</asp:Content>
