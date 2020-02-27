<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="pur00h01.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Supplier.MasterSupplier.pur00h01" %>
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
    <div class="scroller" style="overflow-x:auto">
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="True" 
            ShowFooter ="true" 
            AutoGenerateColumns="False" MasterTableView-AutoGenerateColumns="False"
             OnNeedDataSource ="RadGrid1_NeedDataSource" OnInsertCommand ="RadGrid1_InsertCommand" OnUpdateCommand ="RadGrid1_UpdateCommand"
            OnDeleteCommand ="RadGrid1_DeleteCommand" Skin ="MetroTouch" OnItemCreated ="RadGrid1_ItemCreated"
             MasterTableView-CommandItemDisplay="Top" MasterTableView-DataKeyNames="supplier_code" MasterTableView-ClientDataKeyNames="supplier_code" 
            MasterTableView-AllowFilteringByColumn="True" AllowSorting="True">
            <MasterTableView>
                <Columns>
          
                    <telerik:GridEditCommandColumn UniqueName ="EditCommandColumn">
                        <HeaderStyle Width ="15px" ></HeaderStyle>
                        <ItemStyle Width = "15px" />
                    </telerik:GridEditCommandColumn>
                     <%--<telerik:GridBoundColumn HeaderText ="Code" DataField ="supplier_code" >
                        <HeaderStyle Width ="100px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText ="Ref. Code" DataField ="koref" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn HeaderText ="Supplier" DataField ="supplier_name" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText ="Curr." DataField ="cur_name" >
                        <HeaderStyle Width ="20px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                        <%--<telerik:GridBoundColumn HeaderText ="Group" DataField ="NmGSup" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Bank Acc. Number" DataField ="norek" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText ="On Behalf Of" DataField ="rekname" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText ="Bank Name" DataField ="bankname" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText ="Tax" DataField ="ppn" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText ="Otax" DataField ="OTax" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText ="Otax2" DataField ="pph" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Ship Mode" DataField ="ShipModeEtd" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Limit AP" DataField ="limit_ap" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText ="Term Of Payment" DataField ="pay_code" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Limit (Day)" DataField ="JTempo" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText ="Acc. Payable" DataField ="korek" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText ="AP Accrued" DataField ="um" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="DP" DataField ="Expense" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>--%>
                     <telerik:GridBoundColumn HeaderText ="Address" DataField ="address1" >
                        <HeaderStyle Width ="650px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="City" DataField ="cityName" >
                        <HeaderStyle Width ="320px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Phone" DataField ="phone" >
                        <HeaderStyle Width ="320px" > </HeaderStyle>
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
                                    Supplier Code:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_supplier_code" runat="server" Width="100px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.supplier_code") %>' AutoPostBack="false"></telerik:RadTextBox>

                                </td>
                            
                                <td >
                                    Ref. Code:
                                </td>
                                <td colspan ="6">
                                    <telerik:RadComboBox ID="cb_refcode" runat="server" RenderMode="Lightweight" Width ="400px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.cust_name") %>' 
                                         OnItemsRequested ="cb_refcode_ItemsRequested" OnSelectedIndexChanged ="cb_refcode_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_refcode_PreRender"
                                        EnableVirtualScrolling="false" ShowMoreResultsBox="true"
                                        AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr> 
                             <tr>
                                <td>
                                    Supplier Name:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_supplier_name" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.supplier_name") %>' AutoPostBack="false"></telerik:RadTextBox>

                                </td> 
                            
                                <td>
                                    Bank Acc. Number:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_norek" runat="server" Width="250px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.norek") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                             <tr>
                                <td>
                                    Group:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_group" runat="server" RenderMode="Lightweight" Width ="200px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.NmGSup") %>' 
                                         OnItemsRequested ="cb_group_ItemsRequested" OnSelectedIndexChanged ="cb_group_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_group_PreRender"
                                        EnableVirtualScrolling="false" ShowMoreResultsBox="true"
                                        AutoPostBack="true" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            
                                <td>
                                    On Behalf Of:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_rekname" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.rekname") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    NPWP:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_NPWP" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.NPWP") %>' AutoPostBack="false"></telerik:RadTextBox>

                                </td>
                                <td>
                                    Bank Name:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_bank_name" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.bankname") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Address:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_address1" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.address1") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    City:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_cityName" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.cityName") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td>
                                    Contact:
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Phone:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_phone" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.phone") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            
                                <td>
                                    Name
                                </td>
                                <td>
                                    Phone
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Fax:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_fax" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.fax") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_contact1" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.contact1") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                 <td>
                                    <telerik:RadTextBox ID="txt_hp1" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.hp1") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    E-mail:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_email" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.email") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_contact2" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.contact2") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_hp2" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.hp2") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Website:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_website" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.website") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td>
                                    Limit AP:
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ID="txt_limit_ap" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.limit_ap") %>'  AutoPostBack="false"></telerik:RadNumericTextBox>
                                </td>
                            </tr>
                           
                            <tr>
                                <td>
                                    Tax:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_tax" runat="server" RenderMode="Lightweight" Width ="200px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.TAX1NAME") %>' 
                                         OnItemsRequested ="cb_tax_ItemsRequested" OnSelectedIndexChanged ="cb_tax_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_tax_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                        AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                                 <td>
                                    Otax2:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_tax2" runat="server" RenderMode="Lightweight" Width ="200px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.OTAX2NAME") %>' 
                                         OnItemsRequested ="cb_tax2_ItemsRequested" OnSelectedIndexChanged ="cb_tax2_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_tax2_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                        AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                                <td>
                                    Term Of Payment:
                                </td>
                                <td>
                                     <telerik:RadComboBox ID="cb_paycode" runat="server" RenderMode="Lightweight" Width ="200px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.pay_code") %>' 
                                         OnItemsRequested ="cb_paycode_ItemsRequested" OnSelectedIndexChanged ="cb_paycode_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_paycode_PreRender"
                                        EnableVirtualScrolling="false" ShowMoreResultsBox="true"
                                        AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                   
                                </td>
                            </tr> 
                            <tr>
                                <td>
                                    Otax1:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_tax1" runat="server" RenderMode="Lightweight" Width ="200px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.OTAX1NAME") %>' 
                                         OnItemsRequested ="cb_tax1_ItemsRequested" OnSelectedIndexChanged ="cb_tax1_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_tax1_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                        AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                                <td>
                                    Ship Mode:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_shipmode" runat="server" RenderMode="Lightweight" Width ="200px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.ShipModeName") %>' 
                                         OnItemsRequested ="cb_shipmode_ItemsRequested" OnSelectedIndexChanged ="cb_shipmode_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_shipmode_PreRender"
                                        EnableVirtualScrolling="false" ShowMoreResultsBox="true"
                                        AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                                 <td>
                                    Limit (Days):
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ID="txt_JTempo" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.JTempo") %>'  AutoPostBack="false"></telerik:RadNumericTextBox>
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
                                    Acc. Payable:
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
                                    AP Accrued:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_um" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.um") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td colspan="6">
                                    <telerik:RadTextBox ID="txt_umname" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.umName") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>      
                             <tr>
                                <td>
                                    DP:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_expense" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.Expense") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td colspan="6">
                                    <telerik:RadTextBox ID="txt_expensename" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.expName") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>         
                            <tr >
                                <td align="right" colspan="6">
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
