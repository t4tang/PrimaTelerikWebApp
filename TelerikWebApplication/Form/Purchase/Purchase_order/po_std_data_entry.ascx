<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="po_std_data_entry.ascx.cs" Inherits="TelerikWebApplication.Form.Purchase.Purchase_order.po_std_data_entry" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<div class="dataEntry">
    <table id="Table1" cellspacing="2" cellpadding="1" width="100%" border="0" rules="none"
    style="vertical-align: top;">
    <tr>
        <td align="left" colspan="3">
            <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'></asp:Button>&nbsp;
            <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                CommandName="Cancel"></asp:Button>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <b>PO Information</b>
        </td>
    </tr>
    <tr style="vertical-align: top">
        <td style="vertical-align: top">
            <table id="Table1" width="Auto" border="0" class="module">
                
                <tr>
                    <td>PO Number:
                    </td>
                    <td>
                        <asp:TextBox ID="txt_po_number" runat="server" Width="150px" Enabled="false"
                            Text='<%# DataBinder.Eval(Container, "DataItem.po_code") %>'>
                        </asp:TextBox>
                    </td>
                </tr>             
                <tr>
                    <td>PO Date:
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="dtp_po" runat="server" MinDate="1/1/1900" Width="150px"
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
                    <td>Expired:
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="dtp_exp" runat="server" MinDate="1/1/1900" Width="150px" 
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
                            EmptyMessage="Select the purchase type" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_po_type_ItemsRequested"  
                            OnSelectedIndexChanged="cb_po_type_SelectedIndexChanged">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td>Priority:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="150"
                            Text='<%# DataBinder.Eval(Container, "DataItem.prio_desc") %>'
                            EmptyMessage="Select the priority" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_priority_ItemsRequested" 
                            OnSelectedIndexChanged="cb_priority_SelectedIndexChanged">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td>ETD:
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="dtp_etd" runat="server" MinDate="1/1/1900" Width="150px"
                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.etd") %>'
                            TabIndex="4" Skin="Silk">
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
                            EmptyMessage="Select the ship mode" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_ship_mode_ItemsRequested" 
                            OnSelectedIndexChanged="cb_ship_mode_SelectedIndexChanged">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td>Validation value:
                    </td>
                    <td>
                        <asp:TextBox ID="txt_validity" runat="server" Width="59px" Text='<%# DataBinder.Eval(Container, "DataItem.validity_period") %>'>
                        </asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
        <td style="vertical-align: top;">
            <table id="Table3" cellspacing="1" cellpadding="1" width="100%" border="0" class="module">

                <tr>
                    <td >Supplier:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="300"
                            Text='<%# DataBinder.Eval(Container, "DataItem.vendor_name") %>'
                            EmptyMessage="Select a supplier" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_supplier_ItemsRequested" 
                            OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged" AutoPostBack="true">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td>Term:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_term" runat="server" Width="150"
                            Text='<%# DataBinder.Eval(Container, "DataItem.PayTerm") %>'
                            EmptyMessage="Select a term" EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_tax3_ItemsRequested" 
                            OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged">
                        </telerik:RadComboBox>                       
                        &nbsp Days:
                        <asp:TextBox ID="txt_term_days" Width="60px" Text='<%# DataBinder.Eval(Container, "DataItem.JTempo") %>' runat="server" >
                        </asp:TextBox>                       
                    </td>
                </tr>
                <tr>
                    <td>
                        ATT Name
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txt_att_name" Width="290px" Text='<%# DataBinder.Eval(Container, "DataItem.attname") %>' runat="server" ></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td>Currency:
                    </td>
                    <td style="vertical-align:top">
                        <asp:TextBox ID="txt_curr" runat="server" Width="111px" Enabled="false" 
                            Text='<%# DataBinder.Eval(Container, "DataItem.cur_code") %>'>
                        </asp:TextBox>
                        &nbsp
                        Kurs 
                        <asp:TextBox ID="txt_kurs" runat="server" Width="112px" Enabled="false" 
                            Text='<%# DataBinder.Eval(Container, "DataItem.kurs") %>'>
                        </asp:TextBox>
                    </td>
                </tr>

                <tr>
                    <td>Tax Kurs:
                    </td>
                    <td style="vertical-align:top">
                        <asp:TextBox ID="txt_tax_kurs" runat="server" Width="111px" Enabled="false" 
                            Text='<%# DataBinder.Eval(Container, "DataItem.kurs_tax") %>'>
                        </asp:TextBox>
                         &nbsp
                        <telerik:RadCheckBox ID="chk_ppn_incl" runat="server" Text="PPN Include"></telerik:RadCheckBox>
                    </td>
                </tr>

                <tr>
                    <td>Tax 1:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax1" runat="server" Width="150"
                            Text='<%# DataBinder.Eval(Container, "DataItem.tax1") %>' AutoPostBack="true"
                            EmptyMessage="Select tax 1" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_tax1_ItemsRequested" 
                            OnSelectedIndexChanged="cb_tax1_SelectedIndexChanged">
                        </telerik:RadComboBox>
                       &nbsp Tax1 % 
                        <asp:TextBox ID="txt_pppn" runat="server" Width="45px" Enabled="false" 
                            Text='<%# DataBinder.Eval(Container, "DataItem.PPPN") %>'>
                        </asp:TextBox>
                    </td>
                </tr>

                <tr>
                    <td>Tax 2:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax2" runat="server" Width="150"
                            Text='<%# DataBinder.Eval(Container, "DataItem.tax2") %>' AutoPostBack="true"
                            EmptyMessage="Select tax 2" EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_tax2_ItemsRequested" 
                            OnSelectedIndexChanged="cb_tax2_SelectedIndexChanged">
                        </telerik:RadComboBox>
                        &nbsp Tax2 % 
                        <asp:TextBox ID="txt_po_tax" runat="server" Width="45px" Enabled="false" 
                            Text='<%# DataBinder.Eval(Container, "DataItem.PoTax") %>'>
                        </asp:TextBox>                       
                    </td>
                </tr>
                <tr>
                    <td>Tax 3:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax3" runat="server" Width="150"
                            Text='<%# DataBinder.Eval(Container, "DataItem.tax3") %>' AutoPostBack="true"
                            EmptyMessage="Select tax 3" EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_tax3_ItemsRequested" 
                            OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged">
                        </telerik:RadComboBox>  
                        &nbsp Tax3 % 
                        <asp:TextBox ID="txt_ppph" runat="server" Width="45px" Enabled="false" 
                            Text='<%# DataBinder.Eval(Container, "DataItem.Ppph") %>'>
                        </asp:TextBox>                     
                    </td>
                </tr>
                <tr>
                    <td>Project:
                    </td>
                    <td>                       
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                            Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' 
                            AutoPostBack="true" EmptyMessage="- Select a Project -" EnableLoadOnDemand="true"
                            OnSelectedIndexChanged="cb_project_SelectedIndexChanged" OnItemsRequested="cb_project_ItemsRequested"
                            Skin="Metro">
                        </telerik:RadComboBox>               
                    </td>
                </tr>
                <tr>
                    <td>PR Number:
                    </td>
                    <td>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_reff" runat="server" Width="300px" DropDownWidth="600px"
                            Text='<%# DataBinder.Eval(Container, "DataItem.refNo") %>'
                            EmptyMessage="- Select a refference -" AutoPostBack="true"
                            EnableLoadOnDemand="true" OnItemsRequested="cb_reff_ItemsRequested"
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
                            AutoPostBack="true" EmptyMessage="- Select a cost center -" EnableLoadOnDemand="true"
                            OnSelectedIndexChanged="cb_project_SelectedIndexChanged" OnItemsRequested="cb_project_ItemsRequested"
                            Skin="Metro">
                        </telerik:RadComboBox>               
                    &nbsp PR Date 
                        <asp:TextBox ID="txt_pr_date" runat="server" Width="100px" Enabled="false" 
                            Text='<%# DataBinder.Eval(Container, "DataItem.Ppph") %>'>
                        </asp:TextBox>
                    </td>
                </tr>
            </table>           
        </td>
        <td >
             <table id="Table4" cellspacing="1" cellpadding="1" width="100%" border="0" class="module">
                
                <tr>
                    <td style="vertical-align: top">Remark:
                    </td>                
                    <td>
                        <asp:TextBox ID="txt_remark" Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>' runat="server" TextMode="MultiLine"
                            Rows="5" Columns="40" TabIndex="5">
                        </asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Prepare By
                    </td>
                    <td colspan="3">
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_prepared" runat="server" Width="250"
                            Text='<%# DataBinder.Eval(Container, "DataItem.Prepare_by") %>'
                            EmptyMessage="Select" EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_tax3_ItemsRequested" 
                            OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged">
                        </telerik:RadComboBox>
                    </td>

                </tr>
                <tr>
                    <td >
                        Verified By
                    </td>
                    <td colspan="3">
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_verified" runat="server" Width="250"
                            Text='<%# DataBinder.Eval(Container, "DataItem.Order_by") %>'
                            EmptyMessage="Select" EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_tax3_ItemsRequested" 
                            OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged">
                        </telerik:RadComboBox>
                    </td>

                </tr>
                <tr>
                    <td >
                        Approved By
                    </td>
                    <td colspan="3">
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250"
                            Text='<%# DataBinder.Eval(Container, "DataItem.Approve_by") %>'
                            EmptyMessage="Select" EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_tax3_ItemsRequested" 
                            OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged">
                        </telerik:RadComboBox>
                    </td>

                </tr>
                 <tr>
                    <td>
                    </td>
                    <td>
                        <telerik:RadCheckBox ID="cb_full_supply" runat="server" Text="Full Supply"></telerik:RadCheckBox>
                        &nbsp
                        <telerik:RadCheckBox ID="cb_monitor_order" runat="server" Text="Monitoring Order"></telerik:RadCheckBox>
                    </td>
                </tr>
                 <tr>
                    <td >
                        PO Status
                    </td>
                    <td colspan="3">
                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_po_status" runat="server" Width="160px"
                            Text='<%# DataBinder.Eval(Container, "DataItem.doc_status") %>'
                            EmptyMessage="Select" EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cb_tax3_ItemsRequested" 
                            OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged">
                        </telerik:RadComboBox>
                        &nbsp
                        Share Date 
                        &nbsp
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
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>
    <tr>
        <td colspan="3"></td>
    </tr>
    <%--<tr>
        <td colspan="3">
           

            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" runat="server" AllowAutomaticDeletes="True"
            AllowAutomaticInserts="True" PageSize="10" AllowAutomaticUpdates="True" AllowPaging="True"
             OnInsertCommand="RadGrid2_InsertCommand" OnUpdateCommand="RadGrid2_UpdateCommand" OnDeleteCommand="RadGrid2_DeleteCommand"
            AutoGenerateColumns="False" OnBatchEditCommand="RadGrid2_BatchEditCommand" >
            <MasterTableView CommandItemDisplay="TopAndBottom" DataKeyNames="ProductID"
                 HorizontalAlign="NotSet" EditMode="Batch" AutoGenerateColumns="False">
                <BatchEditingSettings EditType="Row" HighlightDeletedRows="true"/>
                <SortExpressions>
                    <telerik:GridSortExpression FieldName="ProductID" SortOrder="Descending" />
                </SortExpressions>
                <Columns>
                    <telerik:GridBoundColumn DataField="ProductName" HeaderStyle-Width="210px" HeaderText="ProductName" SortExpression="ProductName"
                        UniqueName="ProductName">
                        <ColumnValidationSettings EnableRequiredFieldValidation="true">
                            <RequiredFieldValidator ForeColor="Red" Text="*This field is required" Display="Dynamic">
                            </RequiredFieldValidator>
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Category" DefaultInsertValue="Beverages" HeaderStyle-Width="150px" UniqueName="CategoryID" DataField="CategoryID">
                        <ItemTemplate>
                            <%# Eval("CategoryName") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadDropDownList RenderMode="Lightweight" runat="server" ID="CategoryIDDropDown" DataValueField="CategoryID"
                                DataTextField="CategoryName" DataSourceID="SqlDataSource2">
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridNumericColumn DataField="UnitsInStock" HeaderStyle-Width="80px" HeaderText="Units In Stock"
                        SortExpression="UnitsInStock" UniqueName="UnitsInStock">
                    </telerik:GridNumericColumn>
                    <telerik:GridCheckBoxColumn DataField="Discontinued" HeaderStyle-Width="80px" HeaderText="Discontinued" SortExpression="Discontinued"
                        UniqueName="Discontinued">
                    </telerik:GridCheckBoxColumn>
                    <telerik:GridTemplateColumn HeaderText="UnitPrice" HeaderStyle-Width="80px" SortExpression="UnitPrice" UniqueName="TemplateColumn"
                        DataField="UnitPrice">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblUnitPrice" Text='<%# Eval("UnitPrice", "{0:C}") %>'></asp:Label>
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
                        ConfirmTitle="Delete" HeaderText="Delete" HeaderStyle-Width="50px" 
                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>
            <ClientSettings AllowKeyboardNavigation="true"></ClientSettings>
        </telerik:RadGrid>

        </td>
    </tr>
        <tr>
        <td colspan="3">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString35 %>"
                DeleteCommand="sp_delete_poh" 
                SelectCommand="SELECT prod_type, Prod_code, Spec, qty, SatQty, harga, Disc, ISNULL(tfactor,0) as tfactor, jumlah, tTax, tOtax, tpph, dept_code, 
                Prod_code_ori, twarranty, jTax1, jTax2, jTax3, nomer as nomor FROM tr_purchaseD WHERE po_code = @po_code">
                <SelectParameters>
                    <asp:Parameter Name="po_code" Type="String"></asp:Parameter>
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="po_code" Type="String"></asp:Parameter>
                </DeleteParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString35 %>"
                ProviderName="System.Data.SqlClient" SelectCommand="SELECT [CategoryID], [CategoryName] FROM [Categories]">
            </asp:SqlDataSource>
    
        </td>
    </tr>--%>
    <tr>
    <td colspan="3"></td>
    </tr>
   <tr>

       <td colspan="3">
           <table>
               <tr>
                   <td >
                       User :
                   </td>
                   <td style="width:70px">
                       <asp:TextBox ID="txt_uid" Width="90px" Text='<%# DataBinder.Eval(Container, "DataItem.userid") %>' runat="server" >
                        </asp:TextBox>
                   </td>
                   <td style="width:100px; padding-left:15px">
                       Last Update :
                   </td>
                   <td>
                       <asp:TextBox ID="txt_lastUpdate" Width="137px" Text='<%# DataBinder.Eval(Container, "DataItem.lastUpdate") %>' runat="server" >
                        </asp:TextBox>
                   </td>
                   <td style="width:90px;padding-left:15px">
                       Sub Total :
                   </td>
                   <td>
                       <telerik:RadNumericTextBox EnabledStyle-HorizontalAlign="Right"  ID="txt_sub_total" Width="130px" Text='<%# DataBinder.Eval(Container, "DataItem.tot_amount") %>' runat="server" ></telerik:RadNumericTextBox>
                   </td>
                   <td style="width:70px; padding-left:15px">
                       Tax 2 :
                   </td>
                   <td>
                       <telerik:RadNumericTextBox EnabledStyle-HorizontalAlign="Right"  ID="txt_tax2_value" Width="130px" Text='<%# DataBinder.Eval(Container, "DataItem.jTax2") %>' runat="server" ></telerik:RadNumericTextBox>
                   </td>
                   <td style="width:70px; padding-left:15px">
                       Other :
                   </td>
                   <td style="width:70px; padding-left:15px">
                       <telerik:RadNumericTextBox EnabledStyle-HorizontalAlign="Right" ID="txt_other_value" Width="130px" Text='<%# DataBinder.Eval(Container, "DataItem.Othercost") %>' en runat="server" ></telerik:RadNumericTextBox>
                   </td>
               </tr>

               <tr>
                   <td style="width:70px;">
                       Owner :
                   </td>
                   <td>
                       <asp:TextBox ID="txt_owner" Width="90px" Text='<%# DataBinder.Eval(Container, "DataItem.Owner") %>' runat="server" >
                        </asp:TextBox>
                   </td>
                   <td style="padding-left:15px">
                       Printed :
                   </td>
                   <td>
                       <asp:TextBox ID="txt_printed" Width="40px" Text='<%# DataBinder.Eval(Container, "DataItem.Printed") %>' runat="server" >
                        </asp:TextBox>
                       &nbsp
                       Edited
                       &nbsp
                       <asp:TextBox ID="txt_edited" Width="40px" Text='<%# DataBinder.Eval(Container, "DataItem.Edited") %>' runat="server" >
                        </asp:TextBox>
                   </td>
                   <td style="padding-left:15px">
                       Tax 1 :
                   </td>
                   <td>
                       <telerik:RadNumericTextBox EnabledStyle-HorizontalAlign="Right"  ID="txt_tax1_value" Width="130px" Text='<%# DataBinder.Eval(Container, "DataItem.jTax1") %>' 
                           runat="server" ></telerik:RadNumericTextBox>
                   </td>
                   <td style="padding-left:15px">
                       Tax 3 :
                   </td>
                   <td>
                       <telerik:RadNumericTextBox EnabledStyle-HorizontalAlign="Right"  ID="txt_tax3_value" Width="130px" Text='<%# DataBinder.Eval(Container, "DataItem.jTax3") %>' 
                           runat="server" ></telerik:RadNumericTextBox>
                   </td>
                   <td style="padding-left:15px">
                       Total :
                   </td>
                   <td>
                       <telerik:RadNumericTextBox EnabledStyle-HorizontalAlign="Right"  ID="txt_total" Width="170px" Text='<%# DataBinder.Eval(Container, "DataItem.Net") %>' runat="server" ></telerik:RadNumericTextBox>
                   </td>
               </tr>
           </table>
       </td>
   </tr>
</table>
</div>