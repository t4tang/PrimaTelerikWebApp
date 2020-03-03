<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc00h07.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Customer.MasterCustomer.acc00h07" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl"/>
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
    
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
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="scroller">
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" ShowFooter="true" 
            AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false"
            MasterTableView-DataKeyNames="cust_code" MasterTableView-ClientDataKeyNames="cust_code" 
            MasterTableView-AllowFilteringByColumn="true" MasterTableView-CommandItemDisplay="Top"  
            OnNeedDataSource="RadGrid1_NeedDataSource" OnItemCreated="RadGrid1_ItemCreated" OnDeleteCommand="RadGrid1_DeleteCommand" 
            OnUpdateCommand="RadGrid1_UpdateCommand" OnInsertCommand="RadGrid1_InsertCommand"    
             
            >
            <MasterTableView>
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Code" DataField="cust_code">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Customer" DataField="cust_name">
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Contact Person" DataField="con_person">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Phone" DataField="hp_no">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="E-Mail" DataField="email">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Salesman" DataField="sales_name">
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Address" DataField="pay_add">
                        <HeaderStyle Width="30px" />
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
                                     <b>Master Customer</b>
                                 </td>
                             </tr>
                             <tr>
                                 <td>
                                     <table id="Table3" border="0" class="module">
                                         <tr>
                                             <td>Code*
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_cust_code" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.cust_code") %>' AutoPostBack="false" >
                                                 </telerik:RadTextBox>
                                             </td>
                                             <td>RefF. Code
                                             </td>
                                             <td>
                                                 <telerik:RadComboBox ID="cb_reff" runat="server" RenderMode="Lightweight" Width="250px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.supplier_name") %>' 
                                                     OnItemsRequested="cb_reff_ItemsRequested" OnPreRender="cb_reff_PreRender" OnSelectedIndexChanged="cb_reff_SelectedIndexChanged" 
                                                    EnableVirtualScrolling ="false" ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                 </telerik:RadComboBox> 
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Name*
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_cust_name" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.cust_name") %>' AutoPostBack="false" >
                                                 </telerik:RadTextBox>
                                             </td>
                                             <td>Sub Area
                                             </td>
                                             <td>
                                                 <telerik:RadComboBox ID="cb_area" runat="server" RenderMode="Lightweight" Width="100px" Enabled="true"
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.sar_name") %>' EnableVirtualScrolling="false" 
                                                     OnPreRender="cb_area_PreRender" OnItemsRequested="cb_area_ItemsRequested" OnSelectedIndexChanged="cb_area_SelectedIndexChanged"
                                                     ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                 </telerik:RadComboBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Contact Person
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_con_person" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.con_person") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                             <td>NPWP
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_npwp" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.npwp_no") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Phone
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_phone" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.hp_no") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                             <td>Currency*
                                             </td>
                                             <td>
                                                 <telerik:RadComboBox ID="cb_currency" runat="server" RenderMode="Lightweight" Width="100px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.cur_name") %>' EnableVirtualScrolling="false" 
                                                     OnPreRender="cb_currency_PreRender" OnItemsRequested="cb_currency_ItemsRequested" OnSelectedIndexChanged="cb_currency_SelectedIndexChanged" 
                                                     ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                 </telerik:RadComboBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>E-Mail
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_email" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.email") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                             <td>Kind*
                                             </td>
                                             <td>
                                                 <telerik:RadComboBox ID="cb_kind" runat="server" RenderMode="Lightweight" Width="100px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.cust_kind") %>' EnableVirtualScrolling="false" 
                                                     OnItemsRequested="cb_kind_ItemsRequested" OnPreRender="cb_kind_PreRender" OnSelectedIndexChanged="cb_kind_SelectedIndexChanged" 
                                                     ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                 </telerik:RadComboBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Credit Limit(Rp)*
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_credit" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.cust_limit") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                             <td>Term(Days)
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_limit_day" runat="server" RenderMode="Lightweight" Width="50px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.limit_day") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                             <td>Payment
                                             </td>
                                             <td>
                                                 <telerik:RadComboBox ID="cb_payment" runat="server" RenderMode="Lightweight" Width="100px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.pay_code") %>' 
                                                     OnItemsRequested="cb_payment_ItemsRequested" OnPreRender="cb_payment_PreRender" OnSelectedIndexChanged="cb_payment_SelectedIndexChanged" 
                                                     EnableVirtualScrolling="false" ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" 
                                                     EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                 </telerik:RadComboBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Status
                                             </td>
                                             <td>
                                                 <asp:CheckBox ID="chk_active" Text="Active" runat="server" 
                                                    Checked='True' />
                                             </td>
                                             <td>Salesman
                                             </td>
                                             <td>
                                                 <telerik:RadComboBox ID="cb_sales" runat="server" RenderMode="Lightweight" Width="100px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.sales_name") %>' EnableVirtualScrolling="false" 
                                                     OnItemsRequested="cb_sales_ItemsRequested" OnPreRender="cb_sales_PreRender" OnSelectedIndexChanged="cb_sales_SelectedIndexChanged"  
                                                     ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                 </telerik:RadComboBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Joint Date
                                             </td>
                                             <td>
                                                 <telerik:RadDateTimePicker ID="dtp_date" runat="server" RenderMode="Lightweight" Width="80px">
                                                 </telerik:RadDateTimePicker>
                                             </td>
                                             <td>Send Mode
                                             </td>
                                             <td>
                                                 <telerik:RadComboBox ID="cb_send_mode" runat="server" RenderMode="Lightweight" Width="100px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.ShipModeName") %>' EnableVirtualScrolling="false" 
                                                     OnItemsRequested="cb_send_mode_ItemsRequested" OnPreRender="cb_send_mode_PreRender" OnSelectedIndexChanged="cb_send_mode_SelectedIndexChanged" 
                                                     ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                 </telerik:RadComboBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Bank Account 1
                                             </td>
                                             <td>
                                                 <telerik:RadComboBox ID="cb_account1" runat="server" RenderMode="Lightweight" Width="100px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.account_no") %>' 
                                                     OnItemsRequested="cb_account1_ItemsRequested" OnPreRender="cb_account1_PreRender" OnSelectedIndexChanged="cb_account1_SelectedIndexChanged" 
                                                     EnableVirtualScrolling="false" ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                 </telerik:RadComboBox>
                                             </td>
                                             <td>NPPKP
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_nppkp" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.NPPKP") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Bank Account 2
                                             </td>
                                             <td>
                                                 <telerik:RadComboBox ID="cb_account2" runat="server" RenderMode="Lightweight" Width="100px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.account_no2") %>' 
                                                     OnItemsRequested="cb_account2_ItemsRequested" OnPreRender="cb_account2_PreRender" OnSelectedIndexChanged="cb_account2_SelectedIndexChanged"  
                                                     EnableVirtualScrolling="false" ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                 </telerik:RadComboBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Tax Address
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_tax_addr" runat="server" RenderMode="Lightweight" Width="380px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.tax_address") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox> 
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Payment
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>A/R*
                                             </td>
                                             <td>
                                                 <telerik:RadComboBox ID="cb_ar" runat="server" RenderMode="Lightweight" Width="250px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.accountname1") %>' EnableVirtualScrolling="false"
                                                      OnItemsRequested="cb_ar_ItemsRequested" OnPreRender="cb_ar_PreRender" OnSelectedIndexChanged="cb_ar_SelectedIndexChanged" 
                                                     ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                 </telerik:RadComboBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Down Payment*
                                             </td>
                                             <td>
                                                 <telerik:RadComboBox ID="cb_dp" runat="server" RenderMode="Lightweight" Width="250px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.accountname2") %>' EnableVirtualScrolling="false" 
                                                     OnItemsRequested="cb_dp_ItemsRequested" OnPreRender="cb_dp_PreRender" OnSelectedIndexChanged="cb_dp_SelectedIndexChanged" 
                                                     ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                 </telerik:RadComboBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Payment
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Address
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_pay_add" runat="server" RenderMode="Lightweight" Width="380px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.pay_add") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>City*
                                             </td>
                                             <td>
                                                <telerik:RadComboBox ID="cb_city" runat="server" RenderMode="Lightweight" Width="100px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.pay_city") %>' EnableVirtualScrolling="false" 
                                                     OnItemsRequested="cb_city_ItemsRequested" OnPreRender="cb_city_PreRender" OnSelectedIndexChanged="cb_city_SelectedIndexChanged" 
                                                     ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                 </telerik:RadComboBox>
                                             </td>
                                             <td>Zip Code
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_zip" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.pay_postal") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>SLI
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_sli" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.pay_sli_code") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                             <td>SLJ
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_slj" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.pay_slj_code") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                             <td>Phone
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_pay_phone" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.pay_phone") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                             <td>Fax
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_fax" runat="server" RenderMode="Lightweight" Width="150px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.pay_fax_num") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Delivery
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>Address
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_send_add" runat="server" RenderMode="Lightweight" Width="380px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.send_add") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>City*
                                             </td>
                                             <td>
                                                 <telerik:RadComboBox ID="cb_send_city" runat="server" RenderMode="Lightweight" Width="100px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.send_city") %>' EnableVirtualScrolling="false" 
                                                     OnItemsRequested="cb_send_city_ItemsRequested" OnPreRender="cb_send_city_PreRender" OnSelectedIndexChanged="cb_send_city_SelectedIndexChanged" 
                                                     ShowMoreResultsBox="true" AutoPostBack="true" Skin ="MetroTouch" EnableLoadOnDemand="true" Height="200" MarkFirstMatch="true">
                                                 </telerik:RadComboBox>
                                             </td>
                                             <td>Zip Code
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_send_postal" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.sen_postal") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td>SLI
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_sli_code2" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.send_sli_code") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                             <td align="left">SLJ
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_slj_code2" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true" 
                                                     Text='<%# DataBinder.Eval(Container, "DataItem.send_slj_code") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                             <td align="left">Phone
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_send_phone" runat="server" RenderMode="Lightweight" Width="200px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.send_phone") %>' AutoPostBack="false">
                                                 </telerik:RadTextBox>
                                             </td>
                                             <td align="left">Fax
                                             </td>
                                             <td>
                                                 <telerik:RadTextBox ID="txt_send_fax" runat="server" RenderMode="Lightweight" Width="150px" Enabled="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.sen_fax_num") %>' AutoPostBack="false">
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
                                <td align="left" colspan="2"  style="padding-top:10px">
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
