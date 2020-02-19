<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc00h01.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Finance.BankCode.acc00h01" %>
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
            <telerik:AjaxSetting AjaxControlID="cb_koRek">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_ko_rek" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" RenderMode="Lightweight">
    </telerik:RadAjaxLoadingPanel>

    <div class="scroller">        
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="True" 
            ShowFooter ="true" 
            AutoGenerateColumns="False" MasterTableView-AutoGenerateColumns="False" 
             OnNeedDataSource ="RadGrid1_NeedDataSource" OnItemCreated="RadGrid1_ItemCreated"
             OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand" OnDeleteCommand="RadGrid1_DeleteCommand"
             Skin ="MetroTouch"
             MasterTableView-CommandItemDisplay="Top" MasterTableView-DataKeyNames="CostCenter"  
            MasterTableView-AllowFilteringByColumn="True" AllowSorting="True">
            <MasterTableView Font-Names="Calibri" Font-Size="13px" DataKeyNames="KoBank">
                <Columns>               
                    <telerik:GridEditCommandColumn UniqueName ="EditCommandColumn">
                        <HeaderStyle Width ="15px" ></HeaderStyle>
                    </telerik:GridEditCommandColumn>
                     <telerik:GridBoundColumn HeaderText ="Code" DataField ="KoBank" >
                        <HeaderStyle Width ="30px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Bank Name" DataField ="NamBank" >
                        <HeaderStyle Width ="290px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Account Name" DataField ="NamaRek" >
                        <HeaderStyle Width ="290px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Account No" DataField ="NoRek" >
                        <HeaderStyle Width ="120px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Account Ledger" DataField ="KoRek" >
                        <HeaderStyle Width ="120px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Account Ledger Name" DataField ="accountname">
                        <HeaderStyle Width ="350px" > </HeaderStyle>
                    </telerik:GridBoundColumn> 
                    <telerik:GridBoundColumn HeaderText ="Curency" DataField ="cur_code" >
                        <HeaderStyle Width ="50px" > </HeaderStyle>
                    </telerik:GridBoundColumn>    
                                   
                    <telerik:GridButtonColumn UniqueName ="DeleteColumn" Text ="Delete" CommandName="Delete" HeaderStyle-Width="30px"
                        ConfirmText="Delete This Product?" ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="FontIconButton">
                        <HeaderStyle Width="30px"></HeaderStyle>
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table id="Table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                            padding-top:12px; padding-bottom:5px; background-color: #F0FFFE; margin:5px">
                            <tr>
                                <td>
                                    Code:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_code" runat="server" Width="80px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.KoBank") %>'  
                                        AutoPostBack="false"></telerik:RadTextBox>
                                     &nbsp;&nbsp
                                    <asp:CheckBox ID="chk_active" Text="Active" runat="server" 
                                     Checked='True'/>
                                    &nbsp;&nbsp
                                    <asp:CheckBox ID="chk_unlock" Text="Ulock" runat="server" 
                                    Checked='False'/>
                                </td>
                                
                            </tr>
                            <tr >
                                <td>
                                    Project:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_project" runat="server" RenderMode="Lightweight" Width ="250px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.project_name") %>'
                                        OnItemsRequested="cb_project_ItemsRequested" OnPreRender="cb_project_PreRender" OnSelectedIndexChanged="cb_project_SelectedIndexChanged"                                 
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                    </telerik:RadComboBox>
                                </td>
                                
                            </tr>
                            <tr>
                                <td>
                                    Bank Name:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_BankName" runat="server" Width="250px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.NamBank") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                
                            </tr>
                            <tr>
                                <td>
                                    Account Name:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_nama_rek" runat="server" Width="250px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.NamaRek") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                    
                                </td>
                               
                            </tr>
                            <tr>
                                <td>
                                    Account No:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_account_no" runat="server" Width="250px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.NoRek") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Account Ledger:
                                </td>
                                <td >
                                    <telerik:RadComboBox ID="cb_koRek" runat="server" RenderMode="Lightweight" Width ="450px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.accountComb") %>'
                                        OnItemsRequested="cb_nama_rek_ItemsRequested" OnPreRender="cb_nama_rek_PreRender" 
                                        OnSelectedIndexChanged="cb_koRek_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                         AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                               
                            </tr>
                           <%-- <tr>
                                <td>
                                    
                                </td>
                                <td colspan="3">
                                    <telerik:RadTextBox ID="txt_ko_rek" runat="server" Width="450px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.KoRek") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>                                          
                                </td>
                            </tr>--%>
                            <tr style="text-align:left">
                                <td>
                                    Currency :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_cur" runat="server" Width="80px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.cur_code") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                &nbsp;&nbsp
                                    Level:
                                 &nbsp;&nbsp
                                    <telerik:RadTextBox ID="txt_level" runat="server" Width="50px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.lvl") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                
                                </td>
                            </tr>
                           
                            <tr >
                                <td colspan="3" style="padding-top:15px;padding-bottom:15px">
                                    <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                    runat ="server" CommandName ='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' >
                                        </asp:Button>&nbsp;
                                    <asp:Button ID ="btnCancel" Text="Cancel" runat="server" CausesValidation ="false" CommandName="Cancel"> </asp:Button>
                                </td>
                            </tr>
                        </table> 
                    </FormTemplate>
                </EditFormSettings>     
            </MasterTableView>
        </telerik:RadGrid>
    </div>

</asp:Content>
