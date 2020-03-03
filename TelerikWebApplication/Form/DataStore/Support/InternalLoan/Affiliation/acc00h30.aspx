<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc00h30.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Support.InternalLoan.Affiliation.acc00h30" %>
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
            <telerik:AjaxSetting AjaxControlID="ConfiguratorPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <div class="scroller">
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="True" 
            ShowFooter ="true" 
            AutoGenerateColumns="False" MasterTableView-AutoGenerateColumns="False"
             OnNeedDataSource ="RadGrid1_NeedDataSource" OnInsertCommand ="RadGrid1_InsertCommand" OnUpdateCommand ="RadGrid1_UpdateCommand"
            OnDeleteCommand ="RadGrid1_DeleteCommand" Skin ="MetroTouch" OnItemCreated ="RadGrid1_ItemCreated"
             MasterTableView-CommandItemDisplay="Top" MasterTableView-DataKeyNames="emp_code" MasterTableView-ClientDataKeyNames="emp_code" 
            MasterTableView-AllowFilteringByColumn="True" AllowSorting="True">
            <MasterTableView>
                <Columns>
          
                    <telerik:GridEditCommandColumn UniqueName ="EditCommandColumn">
                        <HeaderStyle Width ="15px" ></HeaderStyle>
                        <ItemStyle Width = "15px" />
                    </telerik:GridEditCommandColumn>
                     <telerik:GridBoundColumn HeaderText ="ID" DataField ="emp_code" >
                        <HeaderStyle Width ="100px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Name" DataField ="emp_name" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Project Area" DataField ="region_name" >
                        <HeaderStyle Width ="300px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                      <telerik:GridBoundColumn HeaderText ="Cost Center" DataField ="CostCenterName" >
                        <HeaderStyle Width ="300px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Group" DataField ="NmGAfi" >
                        <HeaderStyle Width ="300px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Currency" DataField ="cur_name" >
                        <HeaderStyle Width ="200px" > </HeaderStyle>
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
                                    ID:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_emp_code" runat="server" Width="50px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.emp_code") %>' AutoPostBack="false"></telerik:RadTextBox>

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Name:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_emp_name" runat="server" Width="250px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.emp_name") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                             <tr>
                                <td>
                                    No. Ref:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_ref_code" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.ref_code") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>  
                             <tr>
                                <td>
                                    Address:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_alamat" runat="server" Width="300px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.alamat") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                             <tr>
                                <td>
                                    Project Area:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_project" runat="server" RenderMode="Lightweight" Width ="200px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' 
                                         OnItemsRequested ="cb_project_ItemsRequested" OnSelectedIndexChanged ="cb_project_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_project_PreRender"
                                        EnableVirtualScrolling="false" ShowMoreResultsBox="true"
                                        AutoPostBack="true" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                              </tr>                 
                             <tr>
                                <td>
                                    Cost Center:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_CostCenter" runat="server" RenderMode="Lightweight" Width ="300px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.CostCenterName") %>' 
                                        OnSelectedIndexChanged ="cb_CostCenter_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_CostCenter_PreRender"
                                        EnableVirtualScrolling="false" ShowMoreResultsBox="true"
                                        AutoPostBack="true" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                             
                             <tr>
                                <td>
                                    Group:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_group" runat="server" RenderMode="Lightweight" Width ="200px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.NmGAfi") %>' 
                                         OnItemsRequested ="cb_group_ItemsRequested" OnSelectedIndexChanged ="cb_group_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_group_PreRender"
                                        EnableVirtualScrolling="false" ShowMoreResultsBox="true"
                                        AutoPostBack="true" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                              </tr> 
                             <tr>
                                <td>
                                    Currency:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_cur_name" runat="server" Width="150px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.cur_name") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                             <td>
                                    <telerik:RadTextBox ID="txt_cur" runat="server" Width="150px" Enabled="false"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.cur_code") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr> 
                            <tr>
                                <td>
                                    G/L Account A/R:
                                </td>
                            </tr>                     
                             <tr>
                                 <td>
                                    A/R:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_norek" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.norek") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                 <td colspan="4">
                                    <telerik:RadTextBox ID="txt_norekname" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.norekname") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>      
                             <tr>
                                 <td>
                                    A/R Interest:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_ar_inter" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.ar_inter") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td colspan="6">
                                    <telerik:RadTextBox ID="txt_ar_intername" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.ar_intername") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>      
                             <tr>
                               <td>
                                    A/R Accrued:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_um" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.um") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td colspan="6">
                                    <telerik:RadTextBox ID="txt_umname" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.umname") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>  
                              <tr>
                               <td>
                                    Interest Income:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_inc_inter" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.inc_inter") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td colspan="6">
                                    <telerik:RadTextBox ID="txt_inc_intername" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.inc_intername") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr> 
                            <tr>
                                <td>
                                    G/L Account A/P:
                                </td>
                            </tr>                     
                             <tr>
                                 <td>
                                   A/P:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_korek" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.korek") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                 <td colspan="4">
                                    <telerik:RadTextBox ID="txt_korekname" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.korekName") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>      
                             <tr>
                                 <td>
                                     A/P Interest:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_ap_inter" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.ap_inter") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td colspan="6">
                                    <telerik:RadTextBox ID="txt_ap_intername" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.ap_intername") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>      
                             <tr>
                               <td>
                                   A/P Accrued:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_ap_accrued" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.ap_accrued") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td colspan="6">
                                    <telerik:RadTextBox ID="txt_ap_accruedname" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.ap_accruedname") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>  
                              <tr>
                               <td>
                                    Interest Expense:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_exp_inter" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.exp_inter") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td colspan="6">
                                    <telerik:RadTextBox ID="txt_exp_intername" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.exp_intername") %>'  AutoPostBack="false"></telerik:RadTextBox>
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
