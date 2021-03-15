<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="pur00h01.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Supplier.MasterSupplier.pur00h01" %>
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
                            <telerik:RadLabel ID="lbl_form_name" Text="Master Supplier" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
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
             MasterTableView-CommandItemDisplay="Top" MasterTableView-DataKeyNames="supplier_code" MasterTableView-ClientDataKeyNames="supplier_code" 
            MasterTableView-AllowFilteringByColumn="True" AllowSorting="True">
            <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
            <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic">
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
                                    Supplier Code
                                </td>
                                  <td>
                                    <telerik:RadTextBox ID="txt_supplier_code" runat="server" Width="100px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.supplier_code") %>' AutoPostBack="false"></telerik:RadTextBox>
                                &nbsp
                                    <telerik:RadComboBox ID="cb_refcode" runat="server" RenderMode="Lightweight" Width ="400px" Label="Ref. Code"
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
                                    Supplier Name
                                </td>
                                  <td>
                                    <telerik:RadTextBox ID="txt_supplier_name" runat="server" Width="300px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.supplier_name") %>' AutoPostBack="false"></telerik:RadTextBox>
                                &nbsp
                               
                                    <telerik:RadTextBox ID="txt_norek" runat="server" Width="250px" Label ="Bank Acc. Number" Enabled="true"
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
                                  &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp
                                    <telerik:RadTextBox ID="txt_rekname" runat="server" Width="250px" Label ="On Behalf Of" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.rekname") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    NPWP
                                 </td>
                                  <td>
                                    <telerik:RadTextBox ID="txt_NPWP" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.NPWP") %>' AutoPostBack="false"></telerik:RadTextBox>
                                 &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp
                                    <telerik:RadTextBox ID="txt_bank_name" runat="server" Width="250px" Label ="Bank Name" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.bankname") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Address
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_address1" runat="server" Width="600px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.address1") %>'  AutoPostBack="false" TextMode="MultiLine"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    City
                                </td>
                                  <td>
                                    <telerik:RadTextBox ID="txt_cityName" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.cityName") %>'  AutoPostBack="false"></telerik:RadTextBox>
                               &nbsp
                                    Contact
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Phone
                                </td>
                                  <td>
                                    <telerik:RadTextBox ID="txt_phone" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.phone") %>'  AutoPostBack="false"></telerik:RadTextBox>
                               &nbsp
                                    Name
                               &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
                                      &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp
                                    Phone
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Fax
                               </td>
                                  <td>
                                    <telerik:RadTextBox ID="txt_fax" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.fax") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                &nbsp
                                    <telerik:RadTextBox ID="txt_contact1" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.contact1") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                &nbsp
                                    <telerik:RadTextBox ID="txt_hp1" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.hp1") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    E-mail
                               </td>
                                  <td>
                                    <telerik:RadTextBox ID="txt_email" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.email") %>'  AutoPostBack="false"></telerik:RadTextBox>
                               &nbsp
                                    <telerik:RadTextBox ID="txt_contact2" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.contact2") %>'  AutoPostBack="false"></telerik:RadTextBox>
                               &nbsp
                                    <telerik:RadTextBox ID="txt_hp2" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.hp2") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Website
                               </td>
                                  <td>
                                    <telerik:RadTextBox ID="txt_website" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.website") %>'  AutoPostBack="false"></telerik:RadTextBox>
                               &nbsp
                                    
                               
                                    <telerik:RadNumericTextBox ID="txt_limit_ap" runat="server" Width="200px" Label ="Limit AP" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.limit_ap") %>'  AutoPostBack="false"></telerik:RadNumericTextBox>
                                </td>
                            </tr>
                           
                            <tr>
                                <td>
                                    Tax
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
                                &nbsp
                                    
                                
                                    <telerik:RadComboBox ID="cb_tax2" runat="server" RenderMode="Lightweight" Width ="200px" Label ="Otax2"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.OTAX2NAME") %>' 
                                         OnItemsRequested ="cb_tax2_ItemsRequested" OnSelectedIndexChanged ="cb_tax2_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_tax2_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                        AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                               &nbsp
                                   
                               
                                     <telerik:RadComboBox ID="cb_paycode" runat="server" RenderMode="Lightweight" Width ="200px" Label =" Term Of Payment"
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
                                    Otax1
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
                                &nbsp
                                    
                               
                                    <telerik:RadComboBox ID="cb_shipmode" runat="server" RenderMode="Lightweight" Width ="200px" Label ="Ship Mode"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.ShipModeName") %>' 
                                         OnItemsRequested ="cb_shipmode_ItemsRequested" OnSelectedIndexChanged ="cb_shipmode_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_shipmode_PreRender"
                                        EnableVirtualScrolling="false" ShowMoreResultsBox="true"
                                        AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                               &nbsp
                                   
                                
                                    <telerik:RadNumericTextBox ID="txt_JTempo" runat="server" Width="200px" Enabled="true" Label =" Limit (Days)"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.JTempo") %>'  AutoPostBack="false"></telerik:RadNumericTextBox>
                                </td>
                            </tr> 
                             <tr>
                                <td>
                                    G/L Account
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Currency
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
                                    Acc. Payable
                                </td>
                                  <td>
                                    <telerik:RadTextBox ID="txt_korek" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.korek") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                 &nbsp
                                    <telerik:RadTextBox ID="txt_korekname" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.korekName") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>      
                             <tr>
                                <td>
                                    AP Accrued
                                </td>
                                  <td>
                                    <telerik:RadTextBox ID="txt_um" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.um") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                 &nbsp
                                    <telerik:RadTextBox ID="txt_umname" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.umName") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>      
                             <tr>
                                <td>
                                    DP
                                </td>
                                  <td>
                                    <telerik:RadTextBox ID="txt_expense" runat="server" Width="200px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.Expense") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                &nbsp
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
