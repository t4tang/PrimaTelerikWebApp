<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="pur00h08.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Supplier.SupplierGroup.pur00h08" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
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
                            <telerik:RadLabel ID="lbl_form_name" Text="Master Supplier Group" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                                padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                            </telerik:RadLabel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div> 
    
    <div class="scroller" style="overflow-y:scroll; height:620px"> 
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="True" 
            ShowFooter ="False" CssClass="RadGrid_ModernBrowsers"
            AutoGenerateColumns="False" MasterTableView-AutoGenerateColumns="False"
             OnNeedDataSource ="RadGrid1_NeedDataSource" OnInsertCommand ="RadGrid1_InsertCommand" OnUpdateCommand ="RadGrid1_UpdateCommand"
            OnDeleteCommand ="RadGrid1_DeleteCommand" Skin ="Silk" OnItemCreated ="RadGrid1_ItemCreated"
             MasterTableView-CommandItemDisplay="Top" MasterTableView-DataKeyNames="KoGSup" MasterTableView-ClientDataKeyNames="KoGSup" 
            MasterTableView-AllowFilteringByColumn="True" AllowSorting="True">
            <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
            <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName ="EditCommandColumn">
                        <HeaderStyle Width ="15px" ></HeaderStyle>
                        <ItemStyle Width = "15px" />
                    </telerik:GridEditCommandColumn>
                     <telerik:GridBoundColumn HeaderText ="Code" DataField ="KoGSup" >
                        <HeaderStyle Width ="100px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Supplier Group" DataField ="NmGSup" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Currency" DataField ="cur_name" >
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
                                    <telerik:RadTextBox ID="txt_KoGSup" runat="server" Width="50px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.KoGSup") %>' AutoPostBack="false"></telerik:RadTextBox>

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Supplier Group:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_NmGSup" runat="server" Width="250px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.NmGSup") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                               <tr>
                                <td>
                                    Currency:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_currency" runat="server" RenderMode="Lightweight" Width ="150px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.cur_name") %>' 
                                         OnItemsRequested ="cb_currency_ItemsRequested" OnSelectedIndexChanged ="cb_currency_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_currency_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                        AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>                  
                              <tr>
                                <td>
                                    Acc. Payable:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_payable" runat="server" RenderMode="Lightweight" Width ="350px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.korekname") %>' 
                                         OnItemsRequested ="cb_payable_ItemsRequested" OnSelectedIndexChanged ="cb_payable_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_payable_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                        AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>                  
                             <tr>
                                <td>
                                    AP Accrued:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_accrued" runat="server" RenderMode="Lightweight" Width ="350px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.umname") %>' 
                                         OnItemsRequested ="cb_accrued_ItemsRequested" OnSelectedIndexChanged ="cb_accrued_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_accrued_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                        AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>                  
                             <tr>
                                <td>
                                    DP:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_dp" runat="server" RenderMode="Lightweight" Width ="350px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.Expensename") %>' 
                                         OnItemsRequested ="cb_dp_ItemsRequested" OnSelectedIndexChanged ="cb_dp_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_dp_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                        AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>                       
                            <tr >
                                <td align="right" colspan="2">
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
