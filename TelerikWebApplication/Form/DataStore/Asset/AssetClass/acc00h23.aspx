<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc00h23.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Asset.AssetClass.acc00h23" %>
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
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" ShowFooter="true" 
            AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" 
            MasterTableView-DataKeyNames="AK_CODE" MasterTableView-ClientDataKeyNames="AK_CODE" 
            MasterTableView-AllowFilteringByColumn="true" MasterTableView-CommandItemDisplay="Top" 
            OnNeedDataSource="RadGrid1_NeedDataSource" OnItemCreated="RadGrid1_ItemCreated" OnDeleteCommand="RadGrid1_DeleteCommand" 
            OnUpdateCommand="RadGrid1_UpdateCommand" OnInsertCommand="RadGrid1_InsertCommand" 
            CssClass="RadGrid_ModernBrowsers">
            <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
            <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Code" DataField="AK_CODE">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Class Name" DataField="AK_NAME">
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="BOOK Exp. Life" DataField="exp_life_year">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="BOOK Dep. Methode" DataField="mtd">
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="BOOK Appre." DataField="mtd_per">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="TAX Exp. Life" DataField="exp_life_year_tax">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="TAX Dep. Methode" DataField="mtdTax">
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="TAX Appre." DataField="mtd_per_tax">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="GL. ACCOUNT" DataField="ak_cum_rek">
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="ACC. DEPRE." DataField="ak_rek">
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="ACC. LOSS" DataField="ak_ex_rek">
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="ACC. GAIN" DataField="ak_gain">
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="ACC. DISPOSAL" DataField="ak_disposal">
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Cost. Depr." DataField="auc_rek" Visible="false" >
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Cost. Accu." DataField="asset_rek" Visible="false" >
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="IO-CC" DataField="IOCC">
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="STATUS" DataField="status_class">
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="CATEGORY" DataField="cat_code">
                        <HeaderStyle Width="130px" />
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
                                    <b>Master Equipment Type</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="Table3" border="0" class="module">
                                        <tr>
                                            <td>Code
                                            </td>
                                            <td colspan="4">
                                                 <telerik:RadTextBox ID="txt_AK_CODE" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.AK_CODE") %>' AutoPostBack="false" >
                                                 </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Class Name
                                            </td>
                                            <td colspan="4">
                                                 <telerik:RadTextBox ID="txt_AK_NAME" runat="server" RenderMode="Lightweight" Width="280px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.AK_NAME") %>' AutoPostBack="false" >
                                                 </telerik:RadTextBox>    
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Status
                                            </td>
                                            <td colspan="4">
                                                <telerik:RadComboBox ID="cb_status" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.status_class") %>' OnPreRender="cb_status_PreRender" 
                                                    OnItemsRequested="cb_status_ItemsRequested" OnSelectedIndexChanged="cb_status_SelectedIndexChanged" EnableVirtualScrolling="false" ShowMoreResultsBox="true"
                                                    AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                </telerik:RadComboBox> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>Book Depre.
                                            </td>
                                            <td></td>
                                            <td>Tax Depre.
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>Method
                                            </td>
                                            <td style="text-align:left" class="selected">
                                                <telerik:RadComboBox ID="cb_mtd" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true"  
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.mtd") %>' OnPreRender="cb_mtd_PreRender" 
                                                     OnItemsRequested="cb_mtd_ItemsRequested" OnSelectedIndexChanged="cb_mtd_SelectedIndexChanged"
                                                     EnableVirtualScrolling="false" ShowMoreResultsBox="false" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true"
                                                    Height="100" MarkFirstMatch="true">
                                                </telerik:RadComboBox>
                                            </td>
                                            <td>Method
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="cb_mtdTax" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.mtdTax") %>' OnPreRender="cb_mtdTax_PreRender" 
                                                     OnItemsRequested="cb_mtdTax_ItemsRequested" OnSelectedIndexChanged="cb_mtdTax_SelectedIndexChanged" 
                                                    EnableVirtualScrolling="false" ShowMoreResultsBox="false" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true"
                                                    Height="100" MarkFirstMatch="true">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>Useful Life
                                            </td>
                                            <td>
                                                <telerik:RadNumericTextBox ID="txt_life" runat="server" RenderMode="Lightweight" Width="80" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.exp_life_year") %>' AutoPostBack="false" Value="0">
                                                </telerik:RadNumericTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Required"
                                                     ControlToValidate="txt_life"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>Useful Life
                                            </td>
                                            <td>
                                                <telerik:RadNumericTextBox ID="txt_lifeTax" runat="server" RenderMode="Lightweight" Width="80" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.exp_life_year_tax") %>' AutoPostBack="false">
                                                </telerik:RadNumericTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Required"
                                                     ControlToValidate="txt_lifeTax"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>Appreciation
                                            </td>
                                            <td>
                                                <telerik:RadNumericTextBox ID="txt_apre" runat="server" RenderMode="Lightweight" Width="80" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.mtd_per") %>' AutoPostBack="false">
                                                </telerik:RadNumericTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*Required"
                                                     ControlToValidate="txt_apre"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>Appreciation
                                            </td>
                                            <td>
                                                <telerik:RadNumericTextBox ID="txt_apreTax" runat="server" RenderMode="Lightweight" Width="80" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.mtd_per_tax") %>' AutoPostBack="false">
                                                </telerik:RadNumericTextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*Required" ForeColor="Red"
                                                     ControlToValidate="txt_apreTax"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>IO-CC
                                            </td>
                                            <td colspan="4">
                                                <telerik:RadComboBox ID="cb_IOCC" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.IOCC") %>' OnPreRender="cb_IOCC_PreRender" 
                                                     OnItemsRequested="cb_IOCC_ItemsRequested" OnSelectedIndexChanged="cb_IOCC_SelectedIndexChanged"
                                                     EnableVirtualScrolling="false" ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" 
                                                    EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                </telerik:RadComboBox> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Category
                                            </td>
                                            <td colspan="4">
                                                <telerik:RadComboBox ID="cb_cat_code" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.cat_code") %>' OnPreRender="cb_cat_code_PreRender" 
                                                     OnItemsRequested="cb_cat_code_ItemsRequested" OnSelectedIndexChanged="cb_cat_code_SelectedIndexChanged"
                                                     EnableVirtualScrolling="false" ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" 
                                                    EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                </telerik:RadComboBox> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Acc. Depr.
                                            </td>
                                            <td colspan="4">
                                                <telerik:RadComboBox ID="cb_ak_rek" runat="server" RenderMode="Lightweight" Width="450px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.ak_rekname") %>' OnPreRender="cb_ak_rek_PreRender" 
                                                     OnItemsRequested="cb_ak_rek_ItemsRequested" OnSelectedIndexChanged="cb_ak_rek_SelectedIndexChanged"
                                                     EnableVirtualScrolling="false" ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" 
                                                    EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                </telerik:RadComboBox> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Cost. Depr.
                                            </td>
                                            <td colspan="4">
                                                <telerik:RadComboBox ID="cb_cost" runat="server" RenderMode="Lightweight" Width="450px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.auc_rekname") %>' OnPreRender="cb_cost_PreRender"
                                                      OnItemsRequested="cb_cost_ItemsRequested" OnSelectedIndexChanged="cb_cost_SelectedIndexChanged" 
                                                     EnableVirtualScrolling="false" ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" 
                                                    EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                </telerik:RadComboBox> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Acc. Loss.
                                            </td>
                                            <td colspan="4">
                                                <telerik:RadComboBox ID="cb_ak_ex_rek" runat="server" RenderMode="Lightweight" Width="450px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.ak_ex_rekname") %>' OnPreRender="cb_ak_ex_rek_PreRender" 
                                                     OnItemsRequested="cb_ak_ex_rek_ItemsRequested" OnSelectedIndexChanged="cb_ak_ex_rek_SelectedIndexChanged"
                                                     EnableVirtualScrolling="false" ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" 
                                                    EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                </telerik:RadComboBox> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Acc. Gain.
                                            </td>
                                            <td colspan="4">
                                                <telerik:RadComboBox ID="cb_ak_gain" runat="server" RenderMode="Lightweight" Width="450px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.ak_gainname") %>' OnPreRender="cb_ak_gain_PreRender" 
                                                     OnItemsRequested="cb_ak_gain_ItemsRequested" OnSelectedIndexChanged="cb_ak_gain_SelectedIndexChanged"
                                                     EnableVirtualScrolling="false" ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" 
                                                    EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                </telerik:RadComboBox> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Acc. Disposal.
                                            </td>
                                            <td colspan="4">
                                                <telerik:RadComboBox ID="cb_ak_disposal" runat="server" RenderMode="Lightweight" Width="450px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.ak_disposalname") %>' OnPreRender="cb_ak_disposal_PreRender" 
                                                     OnItemsRequested="cb_ak_disposal_ItemsRequested" OnSelectedIndexChanged="cb_ak_disposal_SelectedIndexChanged"
                                                     EnableVirtualScrolling="false" ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" 
                                                    EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                </telerik:RadComboBox> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Cost. Accu.
                                            </td>
                                            <td colspan="4">
                                                <telerik:RadComboBox ID="cb_asset" runat="server" RenderMode="Lightweight" Width="450px" Enabled="true" 
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.asset_rekname") %>' OnPreRender="cb_asset_PreRender" 
                                                     OnItemsRequested="cb_asset_ItemsRequested" OnSelectedIndexChanged="cb_asset_SelectedIndexChanged"
                                                     EnableVirtualScrolling="false" ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" 
                                                    EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                </telerik:RadComboBox> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td colspan="4">
                                                 <telerik:RadTextBox ID="txt_ak_cum_rek" runat="server" RenderMode="Lightweight" Width="80" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.ak_cum_rek") %>' AutoPostBack="false" Visible="false" >
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
                                <td align="right" colspan="2"  style="padding-top:10px">
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
                <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Title="Editing Record"
                     Height="490px" Width="850px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager> 
    </div>
</asp:Content>
