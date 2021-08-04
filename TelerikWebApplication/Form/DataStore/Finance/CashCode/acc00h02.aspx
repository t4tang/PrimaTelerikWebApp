<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc00h02.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Finance.CashCode.acc00h02" %>
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
                            <telerik:RadLabel ID="lbl_form_name" Text="Cash Code" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                                padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                            </telerik:RadLabel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div> 
    
    <div class="scroller" style="overflow-y:scroll; height:620px"> 
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" OnNeedDataSource="RadGrid1_NeedDataSource"  
                            AllowPaging="true" AllowSorting="true" ShowFooter="false" AutoGenerateColumns="false" 
                            MasterTableView-DataKeyNames="KoKas" MasterTableView-ClientDataKeyNames="KoKas" 
                            MasterTableView-AllowFilteringByColumn="true" MasterTableView-CommandItemDisplay="Top" 
                            OnItemCreated="RadGrid1_ItemCreated" OnDeleteCommand="RadGrid1_DeleteCommand" 
                            OnUpdateCommand="RadGrid1_UpdateCommand" OnInsertCommand="RadGrid1_InsertCommand" 
                            Skin="Silk" CssClass="RadGrid_ModernBrowsers">
            <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
            <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Project" DataField="region_code" Visible="false">
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Region" DataField="region_name" Visible="false">
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Cash Code" DataField="KoKas">
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>    
                    <telerik:GridBoundColumn HeaderText="Name Cash" DataField="NamKas">
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Account Number" DataField="accountno">
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Account Name" DataField="accountname">
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Currency" DataField="cur_code">
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn UniqueName="Delete" CommandName="Delete" HeaderStyle-Width="35px" 
                        ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                </Columns>

                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table id="table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                                    padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
                            <tr class="EditFormHeader">
                                <td colspan="2">
                                    <b>Master Kode Kas</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="Table3" border="0" class="module">
                                       
                                        <tr>
                                            <td>Project : 
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="cb_project" runat="server" RenderMode="Lightweight" Width="250px" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.region_code") %>' OnPreRender="cb_project_PreRender" 
                                                    OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged" 
                                                    EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" 
                                                    EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch"
                                                    MarkFirstMatch="true">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <%--<tr>
                                            <td></td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_reg_name" runat="server" RenderMode="Lightweight" Width="150px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' AutoPostBack="false">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>--%> 
                                        <tr>
                                            <td>Cash Code : 
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_code" runat="server" RenderMode="Lightweight" Width="150px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.KoKas") %>' AutoPostBack="false">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Name Cash : 
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_name" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.NamKas") %>' AutoPostBack="false">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Account Number : 
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="cb_no" runat="server" RenderMode="Lightweight" Width="250px"  
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.accountno") %>' OnPreRender="cb_no_PreRender" 
                                                    OnItemsRequested="cb_no_ItemsRequested" OnSelectedIndexChanged="cb_no_SelectedIndexChanged" 
                                                    EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" 
                                                    EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch"
                                                    MarkFirstMatch="true" >
                                                </telerik:RadComboBox>   
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_noname" runat="server" RenderMode="Lightweight" Width="150px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.accountname") %>' AutoPostBack="false" Visible="true">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Currency
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txt_currency" runat="server" RenderMode="Lightweight" Width="150px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.cur_code") %>' AutoPostBack="false">
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
                <telerik:RadWindow ID="UserListDialog" runat="server" RenderMode="Lightweight" Title="EditingRecord" 
                    Height="490px" Width="850px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
</asp:Content>
