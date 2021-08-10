<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h12.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Material.LocationProduct.inv00h12" %>
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

        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" ShowFooter="false" AutoGenerateColumns="false" 
        MasterTableView-AllowFilteringByColumn="true" MasterTableView-DataKeyNames="KdLok" Skin="Silk" CssClass="RadGrid_ModernBrowsers"
        MasterTableView-ClientDataKeyNames="KdLok" MasterTableView-CommandItemDisplay="Top" 
        AllowPaging="true" AllowSorting="true" OnNeedDataSource="RadGrid1_NeedDataSource" 
        OnDeleteCommand="RadGrid1_DeleteCommand" OnInsertCommand="RadGrid1_InsertCommand" 
        OnUpdateCommand="RadGrid1_UpdateCommand" OnItemCreated="RadGrid1_ItemCreated" >
            <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
            <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Height="30px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridBoundColumn HeaderText="Location Code" DataField="KdLok">
                        <HeaderStyle Height="150px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn HeaderText="Location Name" DataField="NmLok">
                        <HeaderStyle Height="150px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn HeaderText="Warehouse" DataField="wh_name">
                        <HeaderStyle Height="150px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridButtonColumn UniqueName="Delete" CommandName="Delete" HeaderStyle-Width="30px" 
                        ButtonType="FontIconButton" ConfirmText="Are You Sure ?" ConfirmDialogType="Radwindow" 
                        ConfirmTitle="Delete">
                        <HeaderStyle Width="30px" />
                    </telerik:GridButtonColumn>
                </Columns>

                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table id="table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                               padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
                            <tr class="EditFormHeader">
                                <td colspan="2">
                                    <b>Location Product</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="Table3" border="0" class="module">
                                        <tr>
                                            <td>Code Location</td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_KdLok" runat="server" Width="100px" Enabled="true" RenderMode="Lightweight" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.KdLok") %>' AutoPostBack="false">
                                                </telerik:RadTextBox> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Name Location</td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_NmLok" runat="server" Width="350px" Enabled="true" RenderMode="Lightweight" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.NmLok") %>' AutoPostBack="false">
                                                </telerik:RadTextBox> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Warehouse</td>
                                            <td>
                                                <telerik:RadComboBox ID="cb_wh" runat="server" RenderMode="Lightweight" Width="150px" EnableLoadOnDemand="true" 
                                                    ShowDropDownOnTextboxClick="true" EnableVirtualScrolling="true" ShowMoreResultsBox="true"  
                                                    Height="200" MarkFirstMatch="true" 
                                                    OnItemsRequested="cb_wh_ItemsRequested" OnSelectedIndexChanged="cb_wh_SelectedIndexChanged" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.wh_name") %>' OnPreRender="cb_wh_PreRender">
                                                </telerik:RadComboBox>
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
            <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Title="EditingRecord" Height="490px" 
                Width="850px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    </div>

</asp:Content>
