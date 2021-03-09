<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc00h31.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Finance.OtherARAP.acc00h31" %>
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
                    <telerik:AjaxUpdatedControl ControlID="txt_curr" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
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
                            <telerik:RadLabel ID="lbl_form_name" Text="Other AR/AP" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                                padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                            </telerik:RadLabel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div> 
    
    <div class="scroller" style="overflow-y:scroll; height:620px"> 
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="True" CssClass="RadGrid_ModernBrowsers"
            ShowFooter ="false" AutoGenerateColumns="False" MasterTableView-AutoGenerateColumns="False"
            OnNeedDataSource ="RadGrid1_NeedDataSource" OnInsertCommand ="RadGrid1_InsertCommand" OnUpdateCommand ="RadGrid1_UpdateCommand"
            OnDeleteCommand ="RadGrid1_DeleteCommand" Skin ="Silk" OnItemCreated ="RadGrid1_ItemCreated"
            MasterTableView-CommandItemDisplay="Top" MasterTableView-DataKeyNames="KoTrans" MasterTableView-ClientDataKeyNames="KoTrans" 
            MasterTableView-AllowFilteringByColumn="True" AllowSorting="True">
           <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
            <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName ="EditCommandColumn">
                        <HeaderStyle Width ="15px" ></HeaderStyle>
                        <ItemStyle Width = "15px" />
                    </telerik:GridEditCommandColumn>
                     <telerik:GridBoundColumn HeaderText ="Code" DataField ="KoTrans" >
                        <HeaderStyle Width ="100px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Name" DataField ="TransName" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Account No" DataField ="accountno" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Account Name" DataField ="accountname" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn UniqueName ="DeleteColumn" Text ="Delete" CommandName="Delete" HeaderStyle-Width="30px"
                        ConfirmText="Delete This Product?" ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="FontIconButton">
                        <HeaderStyle Width="30px"></HeaderStyle>
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table id="Table2" cellspacing="4" cellpadding="5" width="100%" border="0" rules="none" class="formTemplate_Table">
                            <tr>
                                <td>
                                    Code:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_code" runat="server" Width="75px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.KoTrans") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Name:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_name" runat="server" Width="75px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.TransName") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Display:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_display" runat="server" RenderMode="Lightweight" Width ="78px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.tStatus") %>' 
                                        OnItemsRequested ="cb_display_ItemsRequested" OnSelectedIndexChanged ="cb_display_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_display_PreRender"
                                        EnableVirtualScrolling="false" ShowMoreResultsBox="false"
                                        AutoPostBack="false" Skin ="MetroTouch" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Account Ledger:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="txt_acc_ledger" runat="server" RenderMode="Lightweight" Width ="500px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.accountComb") %>' 
                                        OnItemsRequested ="txt_acc_ledger_ItemsRequested" OnSelectedIndexChanged ="txt_acc_ledger_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="txt_acc_ledger_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true" 
                                        AutoPostBack="true" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                    <%--&nbsp
                                    <telerik:radTextBox ID="txt_acc_name" runat="server" Width="75px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.accountname") %>' AutoPostBack="false">
                                    </telerik:radTextBox>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Currency:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_curr" runat="server" Width="75px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.cur_code") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Level:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_level" runat="server" Width="50px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.Lvl") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <td align="right" colspan="2">
                                    <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                    runat ="server" CommandName ='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' >
                                        </asp:Button>&nbsp;
                                    <asp:Button ID ="btnCancel" Text="Cancel" runat="server" CausesValidation ="false" CommandName="Cancel"> </asp:Button>
                                </td>
                        </table>
                    </FormTemplate>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
</asp:Content>
