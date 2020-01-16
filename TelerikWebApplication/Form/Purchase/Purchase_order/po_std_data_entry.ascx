<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="po_std_data_entry.ascx.cs" Inherits="TelerikWebApplication.Form.Purchase.Purchase_order.po_std_data_entry" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<div class="demo-container wrapper">
    <asp:Panel ID="Panel1" runat="server">
        <div class="rgEditForm">
            <div runat="server" 
                style="position:inherit; width:1050px; padding-top:10px; float:right; padding-left:15px; padding-right:15px; 
                padding-bottom:5px; border-collapse: collapse;"> 
                <asp:Button ID="btnUpdate" runat="server"
                    Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                    CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'>
                </asp:Button>&nbsp
                 <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                CommandName="Cancel" OnClick="btnCancel_Click"></asp:Button> 
            </div>
            <%--<table id="Table1" border="0" style="border-collapse: collapse; padding-top:10px; padding-left:15px; 
                padding-right:15px; padding-bottom:10px ">    
               <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module">
                
                            <tr>
                                <td>
                                    PO Number:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_po_number" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                      Text='<%# DataBinder.Eval(Container, "DataItem.po_code") %>' AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>             
                            <tr>
                                <td>PO Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_po"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.po_date") %>' TabIndex="4" Skin="Metro"> 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                        <ReadOnlyStyle Resize="None"></ReadOnlyStyle>
                                        <FocusedStyle Resize="None"></FocusedStyle>
                                        <DisabledStyle Resize="None"></DisabledStyle>
                                        <InvalidStyle Resize="None"></InvalidStyle>
                                        <HoveredStyle Resize="None"></HoveredStyle>
                                        <EnabledStyle Resize="None"></EnabledStyle>
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td>Expired:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_exp" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.exp_date") %>' 
                                        TabIndex="4" Skin="Silk">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td>Tipe:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_po_type" runat="server" Width="150"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.TransName") %>'
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" OnItemsRequested="cb_po_type_ItemsRequested"  
                                        OnSelectedIndexChanged="cb_po_type_SelectedIndexChanged" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Priority:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="150"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.prio_desc") %>'
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" OnItemsRequested="cb_priority_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_priority_SelectedIndexChanged" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>ETD:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_etd" runat="server" MinDate="1/1/1900" Width="150px"
                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.etd") %>'
                                        TabIndex="4" Skin="Silk" >
                                        <Calendar runat="server"  UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                        <DateInput  runat="server"  TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td>Ship Mode:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ship_mode" runat="server" Width="150px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.ShipMode") %>'
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" OnItemsRequested="cb_ship_mode_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_ship_mode_SelectedIndexChanged" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Validation value:
                                </td> 
                                <td>
                                    <telerik:RadTextBox ID="txt_validity" runat="server" Width="59px" Text='<%# DataBinder.Eval(Container, "DataItem.validity_period") %>'>
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align: top; padding-left:15px">
                        <table id="Table3" border="0" class="module">

                            <tr>
                                <td >Supplier:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="300"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.vendor_name") %>'
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" OnItemsRequested="cb_supplier_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged" AutoPostBack="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                
               
                            <tr>
                                <td>Currency:
                                </td>
                                <td style="vertical-align:top">
                                    <telerik:RadTextBox ID="txt_curr" runat="server" Width="111px" Enabled="false" 
                                        Text='<%# DataBinder.Eval(Container, "DataItem.cur_code") %>'>
                                    </telerik:RadTextBox>
                                    &nbsp
                                    Kurs 
                                    <telerik:RadTextBox ID="txt_kurs" runat="server" Width="130px" Enabled="false" 
                                        Text='<%# DataBinder.Eval(Container, "DataItem.kurs") %>'>
                                    </telerik:RadTextBox>
                                </td>
                            </tr>

                            <tr>
                                <td>Tax Kurs:
                                </td>
                                <td style="vertical-align:top">
                                    <telerik:RadTextBox ID="txt_tax_kurs" runat="server" Width="111px" Enabled="false" 
                                        Text='<%# DataBinder.Eval(Container, "DataItem.kurs_tax") %>'>
                                    </telerik:RadTextBox>
                                     &nbsp                                                 
                                    <asp:CheckBox ID="chk_ppn_incl" runat="server" AutoPostBack="false" Text="PPN Include" 
                                        Checked='<%# DataBinder.Eval(Container, "DataItem.PPNIncl").ToString()!="0"?true:false %>' />
                                </td>
                            </tr>

                            <tr>
                                <td>Tax 1:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax1" runat="server" Width="150"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.tax1") %>' 
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" OnItemsRequested="cb_tax1_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_tax1_SelectedIndexChanged" AutoPostBack="true">
                                    </telerik:RadComboBox>
                                   &nbsp Tax1 %                         
                                    <telerik:RadNumericTextBox ID="txt_pppn" runat="server" Width="75px" Enabled="false" Type="Percent" 
                                      EnabledStyle-HorizontalAlign="Right" Text='<%# DataBinder.Eval(Container, "DataItem.PPPN") %>'>
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>

                            <tr>
                                <td>Tax 2:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax2" runat="server" Width="150"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.tax2") %>' AutoPostBack="true"
                                        EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" OnItemsRequested="cb_tax2_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_tax2_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                    &nbsp Tax2 % 
                                    <telerik:RadNumericTextBox ID="txt_po_tax" runat="server" Width="75px" Enabled="false" Type="Percent"
                                      EnabledStyle-HorizontalAlign="Right"   Text='<%# DataBinder.Eval(Container, "DataItem.PoTax") %>'>
                                    </telerik:RadNumericTextBox>                       
                                </td>
                            </tr>
                            <tr>
                                <td>Tax 3:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax3" runat="server" Width="150"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.tax3") %>' AutoPostBack="true"
                                        EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" OnItemsRequested="cb_tax3_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged">
                                    </telerik:RadComboBox>  
                                    &nbsp Tax3 % 
                                    <telerik:RadNumericTextBox ID="txt_ppph" runat="server" Width="75px" Enabled="false" Type="Percent"
                                     EnabledStyle-HorizontalAlign="Right" Text='<%# DataBinder.Eval(Container, "DataItem.Ppph") %>'>
                                    </telerik:RadNumericTextBox>  
                       
                                </td>
                            </tr>
                            <tr>
                                <td>Project:
                                </td>
                                <td>                       
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' OnItemsRequested="cb_project_ItemsRequested"
                                        AutoPostBack="True" OnSelectedIndexChanged="cb_project_SelectedIndexChanged" EnableLoadOnDemand="true"
                                        Skin="Metro" >
                                    </telerik:RadComboBox>               
                                </td>
                            </tr>
                            <tr>
                                <td>PR Number:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_reff" runat="server" Width="300px" DropDownWidth="600px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.refNo") %>'
                                        EnableLoadOnDemand="true" OnItemsRequested="cb_reff_ItemsRequested" AutoPostBack="true"
                                        HighlightTemplatedItems="true" MarkFirstMatch="true" DropDownCssClass="customRadComboBox"
                                        OnItemDataBound="cb_reff_ItemDataBound" OnDataBound="cb_reff_DataBound" Skin="Metro" 
                                        OnSelectedIndexChanged="cb_reff_SelectedIndexChanged">
                                    <HeaderTemplate>
                                        <ul>
                                            <li class="col1" style="width:120px">PR Number</li>
                                            <li class="col2" style="width:450px">Remark</li>
                                        </ul>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <ul>
                                            <li class="col1" style="width:120px">
                                                <%# DataBinder.Eval(Container, "DataItem.pr_code") %></li>
                                            <li class="col2" style="width:450px;text-wrap:normal">
                                                <%# DataBinder.Eval(Container, "DataItem.remark") %></li>
                                        </ul>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        A total of
                                        <asp:Literal runat="server" ID="RadComboItemsCount" />
                                        items
                                    </FooterTemplate>
                                </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr >
                                <td>Cost Ctr:
                                </td>
                                <td style="vertical-align:top">                       
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cost_center" runat="server" Width="120px" DropDownWidth="300px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' 
                                        AutoPostBack="true" EnableLoadOnDemand="true"
                                        OnSelectedIndexChanged="cb_project_SelectedIndexChanged" OnItemsRequested="cb_project_ItemsRequested"
                                        Skin="Metro">
                                    </telerik:RadComboBox>               
                                &nbsp PR Date 
                                    <telerik:RadTextBox ID="txt_pr_date" runat="server" Width="100px" Enabled="false" 
                                        Text='<%# DataBinder.Eval(Container, "DataItem.Ppph") %>'>
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>           
                    </td>
                    <td >
                         <table id="Table4" border="0" class="module">
                             <tr>
                                <td>Term:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_term" runat="server" Width="120"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.PayTerm") %>'
                                        EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" OnItemsRequested="cb_tax3_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged">
                                    </telerik:RadComboBox>                       
                                    &nbsp Days:
                                    <telerik:RadTextBox ID="txt_term_days" Width="60px" Text='<%# DataBinder.Eval(Container, "DataItem.JTempo") %>' runat="server" >
                                    </telerik:RadTextBox>                       
                                </td>
                            </tr>
                             <tr>
                                <td>
                                    ATT Name
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_att_name" Width="250px" Text='<%# DataBinder.Eval(Container, "DataItem.attname") %>' runat="server" ></telerik:RadTextBox>
                                </td>

                            </tr>
                            <tr>
                                <td style="vertical-align: top">Remark:
                                </td>                
                                <td>
                                    <telerik:RadTextBox ID="txt_remark" Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>' runat="server" TextMode="MultiLine"
                                        Width="250px" Rows="0" Columns="100" TabIndex="5" Resize="Both">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Prepare By
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_prepared" runat="server" Width="250"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.Prepare_by") %>'
                                        EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" OnItemsRequested="cb_tax3_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </td>

                            </tr>
                            <tr>
                                <td >
                                    Verified By
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_verified" runat="server" Width="250"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.Order_by") %>'
                                        EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" OnItemsRequested="cb_tax3_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </td>

                            </tr>
                            <tr>
                                <td >
                                    Approved By
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.Approve_by") %>'
                                        EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" OnItemsRequested="cb_tax3_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </td>

                            </tr>
                 
                             <tr>
                                <td >
                                    PO Status
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_po_status" runat="server" Width="160px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.doc_status") %>'
                                        EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" OnItemsRequested="cb_tax3_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                       
                                </td>

                            </tr>
                             <tr>
                                 <td>
                                     Share Date 
                                 </td>
                                 <td>
                                     <telerik:RadDatePicker ID="dtp_share_date" runat="server" MinDate="1/1/1900" Width="150px"
                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.po_date") %>' TabIndex="4" Skin="Silk"> 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                    </telerik:RadDatePicker>
                                 </td>
                             </tr>
                             <tr>
                                <td colspan="2">
                                    
                                    <asp:CheckBox ID="cb_fullSupply" runat="server" AutoPostBack="false" Text="Full Supply"
                                        Checked='<%# DataBinder.Eval(Container, "DataItem.tFullSupply").ToString()!="0"?true:false %>' />
                                    &nbsp
                                    <asp:CheckBox ID="cb_mon_order" runat="server" AutoPostBack="false" Text="Monitoring Order"
                                        Checked='<%# DataBinder.Eval(Container, "DataItem.tMonOrder").ToString()!="0"?true:false %>' />
                               </td>
                     
                            </tr>
                        </table>
                    </td>
                </tr>    
               <tr>
                   <td colspan="3" style="padding-top:20px; padding-bottom:20px">
                       <table>
                           <tr>
                               <td >
                                   User :
                               </td>
                               <td style="width:70px">
                                   <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="90px" Text='<%# DataBinder.Eval(Container, "DataItem.userid") %>' runat="server" >
                                    </telerik:RadTextBox>
                               </td>
                               <td style="width:70px; padding-left:15px">
                                   Last Update :
                               </td>
                               <td style="width:70px;">
                                   <telerik:RadTextBox ReadOnly="true" ID="txt_lastUpdate" Width="140px" Text='<%# DataBinder.Eval(Container, "DataItem.lastUpdate") %>' runat="server" >
                                    </telerik:RadTextBox>
                               </td>
                               <td style="width:70px;padding-left:15px">
                                   Sub Total :
                               </td>
                               <td>
                                   <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_sub_total" Width="130px" Text='<%# DataBinder.Eval(Container, "DataItem.tot_amount") %>' runat="server" ></telerik:RadNumericTextBox>
                               </td>
                               <td style="width:50px; padding-left:15px">
                                   Tax 2 :
                               </td>
                               <td>
                                   <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_tax2_value" Width="130px" Text='<%# DataBinder.Eval(Container, "DataItem.jTax2") %>' runat="server" ></telerik:RadNumericTextBox>
                               </td>
                               <td style="width:60px; padding-left:15px">
                                   Other :
                               </td>
                               <td style="width:70px">
                                   <telerik:RadNumericTextBox  ReadOnly="true" EnabledStyle-HorizontalAlign="Right" ID="txt_other_value" Width="150px" Text='<%# DataBinder.Eval(Container, "DataItem.Othercost") %>' en runat="server" ></telerik:RadNumericTextBox>
                               </td>
                           </tr>

                           <tr>
                               <td style="width:70px;">
                                   Owner :
                               </td>
                               <td>
                                   <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="90px" Text='<%# DataBinder.Eval(Container, "DataItem.Owner") %>' runat="server" >
                                    </telerik:RadTextBox>
                               </td>
                               <td style="padding-left:15px">
                                   Printed :
                               </td>
                               <td>
                                   <telerik:RadTextBox ReadOnly="true" ID="txt_printed" Width="40px" Text='<%# DataBinder.Eval(Container, "DataItem.Printed") %>' runat="server" >
                                   </telerik:RadTextBox>
                                   &nbsp
                                   Edited
                                   &nbsp
                                   <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" Text='<%# DataBinder.Eval(Container, "DataItem.Edited") %>' runat="server" >
                                   </telerik:RadTextBox>
                               </td>
                               <td style="padding-left:15px">
                                   Tax 1 :
                               </td>
                               <td>
                                   <telerik:RadNumericTextBox  ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_tax1_value" Width="130px" Text='<%# DataBinder.Eval(Container, "DataItem.jTax1") %>' 
                                       runat="server" ></telerik:RadNumericTextBox>
                               </td>
                               <td style="padding-left:15px">
                                   Tax 3 :
                               </td>
                               <td>
                                   <telerik:RadNumericTextBox  ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_tax3_value" Width="130px" Text='<%# DataBinder.Eval(Container, "DataItem.jTax3") %>' 
                                       runat="server" ></telerik:RadNumericTextBox>
                               </td>
                               <td style="padding-left:15px">
                                   Total :
                               </td>
                               <td>
                                   <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_total" Width="150px" Text='<%# DataBinder.Eval(Container, "DataItem.Net") %>' runat="server" >
                                    </telerik:RadNumericTextBox>
                               </td>
                           </tr>
                       </table>
                   </td>
               </tr>   
            </table>--%>
        </div>
        <%--<div class="detailTransaction" >
            <table>
                <tr>
                    <td>         
                        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" runat="server" AllowAutomaticDeletes="True"
                         AllowAutomaticInserts="True" PageSize="5" AllowPaging="True" Height="260px" BorderStyle="Solid" Font-Names="Calibri"
                         CssClass="RadGrid_ModernBrowsers" ShowFooter="true" Width="1050px"  OnNeedDataSource="RadGrid2_NeedDataSource"
                            AutoGenerateColumns="False">
                            <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                            <MasterTableView CommandItemDisplay="Top" DataKeyNames="Prod_code" Font-Size="12px"                            
                                AutoGenerateColumns="False">
                                <BatchEditingSettings EditType="Row" HighlightDeletedRows="true" />  
                                <HeaderStyle Height="10px" />
                                <CommandItemStyle Height="10px" />                                            
                                <Columns>
                                    <telerik:GridBoundColumn DataField="prod_type" HeaderStyle-Width="15px" HeaderText="Type" SortExpression="prod_type"
                                        UniqueName="prod_type" ItemStyle-HorizontalAlign="Center">
                                        <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator ForeColor="Red" Text="*This field is required" Display="Dynamic">
                                            </RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="100px" UniqueName="Prod_code" 
                                        DataField="Prod_code" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <%# Eval("Prod_code") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadDropDownList RenderMode="Lightweight" runat="server" ID="CategoryIDDropDown" DataValueField="prod_code"
                                                DataTextField="prod_code" DataSourceID="SqlDataSource1">
                                            </telerik:RadDropDownList>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridNumericColumn DataField="qty" HeaderStyle-Width="40px" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"
                                        SortExpression="qty" UniqueName="qty" DataFormatString="{0:#,###0.00;(#,###0.00);0}">
                                    </telerik:GridNumericColumn>
                                    <telerik:GridNumericColumn DataField="SatQty" HeaderStyle-Width="40px" HeaderText="UoM" ItemStyle-HorizontalAlign="Left"
                                        SortExpression="SatQty" UniqueName="SatQty" ItemStyle-Width="30">
                                    </telerik:GridNumericColumn>
                     
                                    <telerik:GridTemplateColumn HeaderText="UnitPrice" HeaderStyle-Width="55px" SortExpression="harga" UniqueName="harga"
                                        DataField="harga" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblUnitPrice" Text='<%# Eval("harga", "{0:#,###0.00;(#,###0.00);0}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <span>
                                                <telerik:RadNumericTextBox RenderMode="Lightweight" Width="55px" runat="server" ID="tbUnitPrice">
                                                </telerik:RadNumericTextBox>
                                                <span style="color: Red">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                                        ControlToValidate="tbUnitPrice" ErrorMessage="*Required" runat="server" Display="Dynamic">
                                                    </asp:RequiredFieldValidator>
                                                </span>
                                            </span>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridButtonColumn ConfirmText="Delete this product?" ConfirmDialogType="RadWindow"
                                        ConfirmTitle="Delete" HeaderText="Delete" HeaderStyle-Width="20px" 
                                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings AllowKeyboardNavigation="true"></ClientSettings>
                        </telerik:RadGrid>
                    </td>
                </tr>    
                <tr>
                    <td>               
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConString %>"
                            ProviderName="System.Data.SqlClient" SelectCommand="SELECT [prod_code], [spec] FROM [ms_product] WHERE stEdit != 4">
                        </asp:SqlDataSource>    
                    </td>
                </tr>
            </table>     
        </div>--%>
    </asp:Panel>  
</div>