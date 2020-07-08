<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="pur01h02.aspx.cs" Inherits="TelerikWebApplication.Forms.Purchase.Purchase_order.pur01h02" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    
    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("reportViewer.aspx?doc_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
        </script>
    </telerik:RadCodeBlock>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="Server">
     <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
            <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
        </ContentTemplate>        
    </asp:UpdatePanel> 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>            
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
        

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>
    
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="1250px" Height="670px">
        <ContentTemplate>
             <div runat="server" style="padding:20px 10px 10px 10px;" id="Div1">
                 <table>
                     <tr>
                         <td style="width:200px">                             
                             <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="Date From " 
                                DateInput-ReadOnly="true" Width="200px" Height="26px"></telerik:RadDatePicker>                
                         </td>
                         <td style="width:250px">                             
                             <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="To Date " 
                                 DateInput-ReadOnly="true" Width="200px" Height="26px"></telerik:RadDatePicker>
                         </td>
                         <td style="width:320px">                           
                             <telerik:RadComboBox ID="cb_project_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="Project" AutoPostBack="false"
                                EnableLoadOnDemand="True" Skin="Office2010Silver"  EnableVirtualScrolling="true" 
                                Height="200" Width="350" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"
                                OnItemsRequested="cb_projectPrm_ItemsRequested" OnSelectedIndexChanged="cb_projectPrm_SelectedIndexChanged">
                             </telerik:RadComboBox>
                         </td>
                         <td >
                             <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Retrieve" BorderStyle="Solid" BackColor="Transparent"
                                  Width="120px" Height="25px" />
                         </td>                         
                         <td>
                             <asp:Button ID="btnOk" runat="server" Text="Select & Close" BorderStyle="Solid" BackColor="Transparent" OnClick="btnOk_Click"
                                  Width="120px" Height="25px" />
                         </td>
                     </tr>
                 </table>  
            </div>
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="10"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnPreRender="RadGrid1_PreRender" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="po_code" Font-Size="12px" 
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                     CommandItemSettings-ShowRefreshButton="false" >
                    <Columns>
                        <telerik:GridClientSelectColumn UniqueName="SelectColumn" ></telerik:GridClientSelectColumn> 
                        <%--<telerik:GridTemplateColumn UniqueName="TemplateEditColumn" AllowFiltering="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:ImageButton ID="EditLink" runat="server" Text="Edit" ImageUrl="~/Images/modify.png" 
                                    Width="15px" Height="15px" ImageAlign="Middle" />
                            </ItemTemplate>
                            <HeaderStyle Width="30px"></HeaderStyle>
                        </telerik:GridTemplateColumn>--%>
                        <telerik:GridBoundColumn UniqueName="po_code" HeaderText="PO Number" DataField="po_code" ItemStyle-Width="70px" FilterControlWidth="70px">
                            <HeaderStyle Width="70px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="Po_date" HeaderText="Date" DataField="Po_date" ItemStyle-Width="60px" 
                                EnableRangeFiltering="false" FilterControlWidth="90px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="vendor_name" HeaderText="Vendor Name" DataField="vendor_name" 
                            FilterControlWidth="220px" >
                            <HeaderStyle Width="220px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="remark" HeaderText="Remark" DataField="remark" ItemStyle-Wrap="true"
                                ItemStyle-Width="300px" FilterControlWidth="300px">
                            <HeaderStyle Width="300px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="project" HeaderText="Project" DataField="plantCode" ItemStyle-Width="40px" FilterControlWidth="40px">
                            <HeaderStyle Width="40px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="amount" HeaderText="Amount" DataField="tot_amount" ItemStyle-Width="90px" FilterControlWidth="90px" ItemStyle-HorizontalAlign="Right" 
                            DataFormatString="{0:#,##0.00}" DataType="System.Double">
                            <HeaderStyle Width="90px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn> 
                        <telerik:GridBoundColumn UniqueName="net" HeaderText="Net" DataField="Net" ItemStyle-Width="90px" FilterControlWidth="90px" ItemStyle-HorizontalAlign="Right" 
                            DataFormatString="{0:#,##0.00}" DataType="System.Double">
                            <HeaderStyle Width="90px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>   
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" >

                        </telerik:GridButtonColumn> 
                    </Columns>
                </MasterTableView>
                <ClientSettings>                         
                    <Selecting AllowRowSelect="true"></Selecting>
                    <ClientEvents OnRowDblClick="RowDblClick" />
                </ClientSettings>
            </telerik:RadGrid>
           
        </ContentTemplate>
    </telerik:RadWindow>

    <div class="scroller">        
        <div style=" padding-left:15px; width:100%; border-bottom-color: #FF9933; border-bottom-width: 1px; border-bottom-style: inset;">
            <table id="tbl_control">
                <tr>
                                        
                    <td  style="text-align:right;vertical-align:middle;">
                        <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                            Height="30px" Width="35px" ImageUrl="~/Images/daftar.png" >                            
                        </asp:ImageButton>                                                 
                    </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:8px">
                        <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/tambah-gray.png">
                        </asp:ImageButton>
                    </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:13px">
                        <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" OnClick="btnSave_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/simpan-gray.png">
                        </asp:ImageButton>
                    </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:13px">
                        <asp:ImageButton runat="server" ID="btnPrint" AlternateText="Print" OnClick="btnPrint_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/cetak-gray.png">
                        </asp:ImageButton>
                    </td>                    
                    <td style="width:85%; text-align:right">
                        <telerik:RadLabel ID="lbl_form_name" Text="User Request" runat="server" style="font-weight:lighter; 
                            font-size:10px; font-variant: small-caps; padding-left:10px; 
                        padding-bottom:0px; font-size:x-large; color:Highlight"></telerik:RadLabel>
                    </td>
                </tr>
            </table>            
        </div>   
        
        <div class="table_trx" id="div1"> 
            <table id="Table1" border="0" style="border-collapse: collapse; padding-top:5px; padding-left:15px; 
                padding-right:15px; padding-bottom:10px; font-size:smaller ">    
                <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module">                
                            <tr>
                                <td class="tdLabel">
                                    PO Number:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_po_number" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>             
                            <tr>
                                <td class="tdLabel">
                                    PO Date:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_po"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Metro"> 
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
                                <td class="tdLabel">
                                    Expired:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_exp" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Metro">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Tipe:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_po_type" runat="server" Width="150"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" 
                                        OnSelectedIndexChanged="cb_po_type_SelectedIndexChanged" OnItemsRequested="cb_po_type_ItemsRequested">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Priority:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="150"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" 
                                        OnItemsRequested="cb_priority_ItemsRequested" OnSelectedIndexChanged="cb_priority_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    ETD:
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_etd" runat="server" MinDate="1/1/1900" Width="150px"
                                        TabIndex="4" Skin="Metro" >
                                        <Calendar runat="server"  UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                        <DateInput  runat="server"  TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Ship Mode:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ship_mode" runat="server" Width="150px"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" 
                                        OnItemsRequested="cb_ship_mode_ItemsRequested" OnSelectedIndexChanged="cb_ship_mode_SelectedIndexChanged"
                                        EnableVirtualScrolling="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Validation value:
                                </td> 
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadTextBox ID="txt_validity" runat="server" Width="59px">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align: top; padding-left:15px">
                        <table id="Table3" border="0" class="module">

                            <tr>
                                <td class="tdLabel">
                                    Supplier:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="300px"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" AutoPostBack="true"
                                        OnItemsRequested="cb_supplier_ItemsRequested" OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                
               
                            <tr>
                                <td class="tdLabel">
                                    Currency:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_curr" runat="server" Enabled="false" Width="111px">
                                            </telerik:RadTextBox>&nbsp
                                            Kurs 
                                            <telerik:RadTextBox ID="txt_kurs" runat="server" Enabled="false" Width="100px">
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>                                                
                                </td>
                            </tr>

                            <tr>
                                <td class="tdLabel">
                                    Tax Kurs:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_tax_kurs" runat="server" Width="111px" Enabled="false" >
                                            </telerik:RadTextBox>
                                                &nbsp                                                 
                                            <asp:CheckBox ID="chk_ppn_incl" runat="server" AutoPostBack="false" Text="PPN Include" />
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>

                            <tr>
                                <td class="tdLabel">
                                    Tax 1:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax1" runat="server" Width="150"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" 
                                                OnItemsRequested="cb_tax1_ItemsRequested" OnSelectedIndexChanged="cb_tax1_SelectedIndexChanged"
                                                EnableVirtualScrolling="true" >
                                            </telerik:RadComboBox>
                                            &nbsp Tax1 %                         
                                            <telerik:RadNumericTextBox ID="txt_pppn" runat="server" Width="75px" Enabled="false" Type="Percent" 
                                                EnabledStyle-HorizontalAlign="Right" >
                                            </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>                                                
                                </td>
                            </tr>

                            <tr>
                                <td class="tdLabel">
                                    Tax 2:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax2" runat="server" Width="150" AutoPostBack="true"
                                                EnableLoadOnDemand="true" ShowMoreResultsBox="true" 
                                                OnItemsRequested="cb_tax2_ItemsRequested" OnSelectedIndexChanged="cb_tax2_SelectedIndexChanged"
                                                EnableVirtualScrolling="true">
                                            </telerik:RadComboBox>
                                            &nbsp Tax2 % 
                                            <telerik:RadNumericTextBox ID="txt_po_tax" runat="server" Width="75px" Enabled="false" Type="Percent"
                                                EnabledStyle-HorizontalAlign="Right" >
                                            </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>                                                                       
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Tax 3:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_tax3" runat="server" Width="150" AutoPostBack="true"
                                                EnableLoadOnDemand="true" ShowMoreResultsBox="true" 
                                                OnItemsRequested="cb_tax3_ItemsRequested" OnSelectedIndexChanged="cb_tax3_SelectedIndexChanged"
                                                EnableVirtualScrolling="true" >
                                            </telerik:RadComboBox>  
                                            &nbsp Tax3 % 
                                            <telerik:RadNumericTextBox ID="txt_ppph" runat="server" Width="75px" Enabled="false" Type="Percent"
                                                EnabledStyle-HorizontalAlign="Right">
                                            </telerik:RadNumericTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel> 
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Project:
                                </td>
                                <td style="vertical-align:top; text-align:left">                      
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -"
                                        OnSelectedIndexChanged="cb_project_SelectedIndexChanged">
                                    </telerik:RadComboBox>               
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    PR Number:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_reff" runat="server" Width="300px" 
                                                EnableLoadOnDemand="false" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            DropDownWidth="650px" AutoPostBack="true" EmptyMessage="- Select a PR Code -"
                                            OnSelectedIndexChanged="cb_reff_SelectedIndexChanged" OnItemsRequested="cb_reff_ItemsRequested"
                                            OnDataBound="cb_reff_DataBound">
                                            <HeaderTemplate>
                                                <table style="width: 600px">
                                                    <tr>
                                                        <td style="width: 140px;">
                                                            PR Number
                                                        </td>
                                                        <td style="width: 460px;">
                                                            Remark
                                                        </td>                                                                
                                                    </tr>
                                                </table>                                                       
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 600px">
                                                    <tr>
                                                        <td style="width: 140px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.pr_code")%>
                                                        </td>
                                                        <td style="width: 460px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.remark")%>
                                                        </td>                                                                
                                                    </tr>
                                                </table>

                                            </ItemTemplate>
                                            <FooterTemplate>
                                                A total of
                                                <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                items
                                            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                                
                                </td>
                            </tr>
                            <tr >
                                <td class="tdLabel">
                                    Cost Ctr:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cost_center" runat="server" Width="120px" DropDownWidth="300px"
                                                    EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                            </telerik:RadComboBox>               
                                            &nbsp PR Date 
                                            <telerik:RadTextBox ID="txt_pr_date" runat="server" Width="100px" Enabled="false" >                                                   
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_reff" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>           
                    </td>
                    <td >
                            <table id="Table4" border="0" class="module">
                                <tr>
                                <td class="tdLabel">
                                    Term:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_term" runat="server" Width="120" ShowMoreResultsBox="true"
                                            EnableVirtualScrolling="true" EnableLoadOnDemand="true" >
                                            </telerik:RadComboBox>                       
                                            &nbsp Days:
                                            <telerik:RadTextBox ID="txt_term_days" Width="60px" 
                                                runat="server" >
                                            </telerik:RadTextBox>  
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>  
                                                                     
                                </td>
                            </tr>
                                <tr>
                                <td class="tdLabel">
                                    ATT Name
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_att_name" Width="250px" 
                                                runat="server" ></telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_supplier" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>                                                
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Remark:
                                </td>                
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_remark" 
                                                runat="server" TextMode="MultiLine"
                                                Width="250px" Rows="0" Columns="100" TabIndex="5" Resize="Both">
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_reff" EventName="SelectedIndexChanged">
                                            </asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                                
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Prepare By
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_prepared" runat="server" Width="250px" 
                                            DropDownWidth="450px" AutoPostBack="false" EmptyMessage="- Select -" EnableLoadOnDemand="false"                                                       
                                                OnSelectedIndexChanged="cb_prepared_SelectedIndexChanged" OnItemsRequested="cb_prepared_ItemsRequested"
                                                OnDataBound="cb_prepared_DataBound" Skin="Metro">
                                                <HeaderTemplate>
                                                    <table style="width: 400px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 80px;">
                                                                NIK
                                                            </td>
                                                            <td style="width: 300px;">
                                                                Position
                                                            </td>                                                                
                                                        </tr>
                                                    </table>                                                       
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 350px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                            </td>
                                                            <td style="width: 200px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                            </td>                                                                
                                                        </tr>
                                                    </table>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    A total of
                                                    <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                    items
                                                </FooterTemplate>                                                        
                                            </telerik:RadComboBox>
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>

                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Verified By
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                        <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_verified" runat="server" Width="250px" 
                                                DropDownWidth="350px" AutoPostBack="false" EmptyMessage="- Select -" EnableLoadOnDemand="false" 
                                                OnSelectedIndexChanged="cb_verified_SelectedIndexChanged"
                                                Skin="Metro">
                                                <HeaderTemplate>
                                                        <table style="width: 350px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 150px;">
                                                                    NIK
                                                                </td>
                                                                <td style="width: 200px;">
                                                                    Position
                                                                </td>                                                                
                                                            </tr>
                                                        </table>                                                       
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 350px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 150px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                </td>
                                                                <td style="width: 200px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                                </td>                                                                
                                                            </tr>
                                                        </table>

                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        A total of
                                                        <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                        items
                                                    </FooterTemplate>  
                                            </telerik:RadComboBox>
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>

                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Approved By
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel14" runat="server">
                                        <ContentTemplate>                                                        
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px" 
                                                DropDownWidth="380px" AutoPostBack="false" EmptyMessage="- Select -" EnableLoadOnDemand="false" 
                                                OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                Skin="Metro">
                                                <HeaderTemplate>
                                                        <table style="width: 350px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 150px;">
                                                                    Nik
                                                                </td>
                                                                <td style="width: 200px;">
                                                                    Position
                                                                </td>                                                                
                                                            </tr>
                                                        </table>                                                       
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 350px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 150px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                </td>
                                                                <td style="width: 300px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                                </td>                                                                
                                                            </tr>
                                                        </table>

                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        A total of
                                                        <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                        items
                                                    </FooterTemplate>  
                                            </telerik:RadComboBox>
                                        </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>

                            </tr>
                 
                                <tr>
                                <td class="tdLabel">
                                    PO Status
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_po_status" runat="server" Width="160px"
                                        ShowMoreResultsBox="true" EnableLoadOnDemand="true"
                                        EnableVirtualScrolling="true" OnSelectedIndexChanged="cb_po_status_SelectedIndexChanged" 
                                        OnItemsRequested="cb_po_status_ItemsRequested">
                                    </telerik:RadComboBox>
                       
                                </td>

                            </tr>
                                <tr>
                                    <td class="tdLabel">
                                        Share Date 
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <telerik:RadDatePicker ID="dtp_share_date" runat="server" MinDate="1/1/1900" Width="150px"
                                        TabIndex="4" Skin="Silk"> 
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
                                    
                                    <asp:CheckBox ID="cb_fullSupply" runat="server" AutoPostBack="false" Text="Full Supply"/>
                                    &nbsp
                                    <asp:CheckBox ID="cb_mon_order" runat="server" AutoPostBack="false" Text="Monitoring Order"/>
                                </td>
                     
                            </tr>
                        </table>
                    </td>
                </tr>    
                <tr>
                    <td colspan="3" style="padding-top:10px; padding-bottom:10px;">
                        <table>
                            <tr>
                                <td style="width:50px" class="tdLabel">
                                    User :
                                </td>
                                <td style="width:50px">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="50px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width:80px; padding-left:15px" class="tdLabel">
                                    Last Update :
                                </td>
                                <td style="width:70px;">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_lastUpdate" Width="140px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width:70px;padding-left:15px" class="tdLabel">
                                    Sub Total :
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_sub_total" Width="130px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                    runat="server" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2" >
                                    </telerik:RadNumericTextBox>                                    
                                </td>
                                <td style="width:50px; padding-left:15px" class="tdLabel">
                                    Tax 2 :
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_tax2_value" Width="130px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                    runat="server" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2" >
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td style="width:60px; padding-left:15px" class="tdLabel">
                                    Other :
                                </td>
                                <td style="width:70px">
                                   <telerik:RadNumericTextBox  ReadOnly="true" EnabledStyle-HorizontalAlign="Right" ID="txt_other_value"  Width="130px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                    runat="server" onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2" >
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>

                            <tr>
                                <td class="tdLabel">
                                    Owner :
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="50px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px" class="tdLabel">
                                    Printed :
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_printed" Width="40px" runat="server" >
                                    </telerik:RadTextBox>
                                    &nbsp
                                    Edited
                                    &nbsp
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px" class="tdLabel">
                                    Tax 1 :
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox  ReadOnly="true" runat="server" ID="txt_tax1_value" Width="130px" EnabledStyle-HorizontalAlign="Right"  NumberFormat-AllowRounding="true"
                                    onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                     MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" >
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td style="padding-left:15px" class="tdLabel">
                                    Tax 3 :
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox  ReadOnly="true" runat="server"  ID="txt_tax3_value" Width="130px" EnabledStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                    onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                     MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" >
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td style="padding-left:15px" class="tdLabel">
                                    Total :
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ReadOnly="true" EnabledStyle-HorizontalAlign="Right"  ID="txt_total" Width="150px" runat="server" 
                                        ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                        onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2" >
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>   
            </table>

            <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 1px;"> 
                <asp:UpdatePanel ID="UpdatePanel15" runat="server">
                     <ContentTemplate>
                         <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" runat="server" PageSize="5" AllowPaging="true" Font-Names="Calibri" 
                            AllowAutomaticUpdates="True" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" ShowFooter="false" 
                             AutoGenerateColumns="False" Skin="MetroTouch" 
                             OnNeedDataSource="RadGrid2_NeedDataSource" OnInsertCommand="RadGrid2_save_handler" OnDeleteCommand="RadGrid2_DeleteCommand">   
                            <MasterTableView CommandItemDisplay="Top" DataKeyNames="Prod_code" Font-Size="12px" EditMode="InPlace"
                                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >
                                <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />          
                                <Columns>
                                    <telerik:GridTemplateColumn UniqueName="prod_code" HeaderText="Prod. Code" HeaderStyle-Width="100px"
                                            SortExpression="prod_code" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Left">
                                            <FooterTemplate>Template footer</FooterTemplate>
                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <%#DataBinder.Eval(Container.DataItem, "Prod_code")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="spec"
                                                    OnItemsRequested="cb_prod_code_ItemsRequested" DataValueField="prod_code" AutoPostBack="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Prod_code") %>' EmptyMessage="- Search product name here -"
                                                    HighlightTemplatedItems="true" Height="190px" Width="220px" DropDownWidth="430px"
                                                    OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" OnPreRender="cb_prod_code_PreRender">                                                   
                                                    <HeaderTemplate>
                                                    <table style="width: 430px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 250px;">
                                                                Prod. Name
                                                            </td>     
                                                            <td style="width: 180px;">
                                                                Prod. Code
                                                            </td>                                                           
                                                        </tr>
                                                    </table>                                                       
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 430px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 250px;">
                                                                <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                            </td>        
                                                            <td style="width: 180px;">
                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                            </td>                                                        
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Part Name" ItemStyle-Width="180px" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Left" >
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "spec")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_prod_name" Width="180px" ReadOnly="true"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.spec") %>'>
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>                                    
                                    <telerik:GridTemplateColumn HeaderText="Qty" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "qty", "{0:#,###,###0.00}")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_qty" Width="50px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "qty", "{0:#,###,###0.00}") %>'
                                                    onkeydown="blurTextBox(this, event)"
                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                    NumberFormat-DecimalDigits="2" >
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn> 
                                   <telerik:GridTemplateColumn HeaderText="UoM" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "SatQty")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="50" runat="server" ID="cb_uom_d"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.SatQty") %>'
                                                EnableLoadOnDemand="True" Skin="MetroTouch" DataTextField="part_unit" DataValueField="part_unit" >
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>                   
                                    <telerik:GridTemplateColumn DataField="harga" HeaderText="Harga" HeaderStyle-Width="90px" ItemStyle-Width="90px"  SortExpression="harga" UniqueName="harga"
                                        ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblHarga" Text='<%# Eval("harga", "{0:#,###0.00;-#,###0.00;0}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <span>                                                
                                                <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_harga" Width="100px" NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "harga", "{0:#,###,###0.00}") %>'
                                                    onkeydown="blurTextBox(this, event)"
                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                    NumberFormat-DecimalDigits="2" >
                                                </telerik:RadTextBox>
                                                <span style="color: Red">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                                        ControlToValidate="tbUnitPrice" ErrorMessage="*Required" runat="server" Display="Dynamic">
                                                    </asp:RequiredFieldValidator>
                                                </span>
                                            </span>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="55px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Disc. %" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "Disc", "{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_disc" Width="50px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "Disc", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2" >
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn> 
                                    <telerik:GridTemplateColumn HeaderText="Factor" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "factor", "{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_factor" Width="40px" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ItemStyle-HorizontalAlign="Right"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "factor", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2" >
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Sub Price" ItemStyle-Width="90px" HeaderStyle-Width="90px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                                        <ItemTemplate>  
                                            <%#DataBinder.Eval(Container.DataItem, "jumlah", "{0:#,###,###0.00}")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_sub_price" Width="90px" ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "jumlah", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2" >
                                            </telerik:RadTextBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="dept_code" HeaderText="Cost Ctr" HeaderStyle-Width="55px" ItemStyle-Width="55px" SortExpression="dept_code" UniqueName="dept_code"
                                        ItemStyle-HorizontalAlign="Left" >
                                        <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "dept_code")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_cost_ctr" Width="55px" ReadOnly="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>'>
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                     <telerik:GridTemplateColumn DataField="Prod_code_ori" HeaderText="Ori. Prod" HeaderStyle-Width="75px" ItemStyle-Width="75px" SortExpression="Prod_code_ori" UniqueName="Prod_code_ori"
                                        ItemStyle-HorizontalAlign="left">
                                        <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "Prod_code_ori")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_Prod_code_ori" Width="75px" ReadOnly="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Prod_code_ori") %>'>
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridButtonColumn ConfirmText="Delete this product?" ConfirmDialogType="RadWindow"
                                        ConfirmTitle="Delete" HeaderText="Delete" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center"
                                        CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                            <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                            <ClientSettings AllowKeyboardNavigation="true"></ClientSettings>
                            <ItemStyle HorizontalAlign="Right" />
                            <FilterMenu RenderMode="Lightweight">
                            </FilterMenu>
                            <HeaderContextMenu RenderMode="Lightweight">
                            </HeaderContextMenu>
                         </telerik:RadGrid>                        
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="RadGrid2" EventName="UpdateCommand">
                        </asp:AsyncPostBackTrigger>
                    </Triggers>
                </asp:UpdatePanel> 
            </div>
        </div>       

        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server"  ReloadOnShow="true" ShowContentDuringLoad="false"
                  Width="1150px" Height="670px" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
            
         <script type="text/javascript">
        //<![CDATA[
            Sys.Application.add_load(function() {
                $windowContentDemo.contentTemplateID = "<%=RadWindow_ContentTemplate.ClientID%>";
                $windowContentDemo.templateWindowID = "<%=RadWindow_ContentTemplate.ClientID %>";
            });
        //]]>
        </script>  
 
    </div>
    
</asp:Content>