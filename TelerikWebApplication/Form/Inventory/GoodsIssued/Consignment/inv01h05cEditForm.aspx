<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h05cEditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.GoodsIssued.Consignment.inv01h05cEditForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <script type ="text/javascript" >  
        function GetRadWindow()     
        {     
           var oWindow = null;     
           if (window.radWindow)
           oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog     
           else if (window.frameElement.radWindow)
           oWindow = window.frameElement.radWindow;//IE (and Moz as well)     
           return oWindow;               
        }     
        function Close()     
        {     
          GetRadWindow().Close();          
        }

        function CloseAndRebind(args) {
            GetRadWindow().BrowserWindow.refreshGrid(args);
            GetRadWindow().close();
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cb_project">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_warehouse"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cb_CostCenter"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cb_ref"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cb_CustSupp"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_ref">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cb_CostCenter"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_CostCenterName"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_unit"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_remark"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>    
        </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="1000" BackgroundPosition="None" >
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
        </telerik:RadAjaxLoadingPanel>

        <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
        <div>
            <div style="padding: 15px 15px 10px 15px;" class="lbObject">
                <table>
                    <tr style="vertical-align: top">
                        <td style="vertical-align: top">
                            <table id="Table2" width="Auto" border="0" class="module">
                                <tr>
                                    <td >
                                        <telerik:RadLabel runat="server" Text="GI Number" CssClass="lbObject"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txt_gi_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                           Skin="Telerik"  EmptyMessage="Let it blank" >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                 <tr>
                                    <td >
                                        <telerik:RadLabel runat="server" Text="Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker ID="dtp_date" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="Telerik">
                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                                FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
<EmptyMessageStyle Resize="None"></EmptyMessageStyle>

<ReadOnlyStyle Resize="None"></ReadOnlyStyle>

<FocusedStyle Resize="None"></FocusedStyle>

<DisabledStyle Resize="None"></DisabledStyle>

<InvalidStyle Resize="None"></InvalidStyle>

<HoveredStyle Resize="None"></HoveredStyle>

<EnabledStyle Resize="None"></EnabledStyle>
                                            </DateInput>
                                            <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ControlToValidate="dtp_date" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Type" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_type_ref" runat="server" Width="150" CausesValidation="false" 
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Telerik" AutoPostBack="false" EnableVirtualScrolling="true"
                                            OnItemsRequested="cb_type_ref_ItemsRequested"
                                            OnSelectedIndexChanged="cb_type_ref_SelectedIndexChanged"
                                            OnPreRender="cb_type_ref_PreRender">
                                        </telerik:RadComboBox>                                        
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_type_ref" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Project Area" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cb_Project" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
                                            EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="250" DropDownWidth="270px" 
                                            OnItemsRequested="cb_Project_ItemsRequested"
                                            OnSelectedIndexChanged="cb_Project_SelectedIndexChanged"
                                            OnPreRender="cb_Project_PreRender">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_Project" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">                                        
                                        <telerik:RadLabel runat="server" Text="Supplier" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cb_CustSupp" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  HighlightTemplatedItems="true"
                                            EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" Enabled="true" Width="250" DropDownWidth="270px" CausesValidation="false"  
                                            OnItemsRequested="cb_CustSupp_ItemsRequested"
                                            OnPreRender="cb_CustSupp_PreRender"
                                            OnSelectedIndexChanged="cb_CustSupp_SelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_CustSupp" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Ref. No." CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_ref" runat="server" RenderMode="Lightweight" Width="200px" DataTextField="doc_code" DataValueField="doc_code" 
                                                    EnableLoadOnDemand="true" EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" Skin="Telerik" CausesValidation="false"
                                                    OnItemsRequested="cb_ref_ItemsRequested"

                                                    DropDownWidth="650px" AutoPostBack="true">
                                                    <HeaderTemplate>
                                                        <table style="width: 450px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 150px;">
                                                                    Reff. No.
                                                                </td>
                                                                <td style="width: 300px;">
                                                                    Remark
                                                                </td>                                                                
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 450px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 150px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.doc_code")%>
                                                                </td>
                                                                <td style="width: 300px;">
                                                                    <asp:label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "doc_remark") %>'></asp:label> 
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
                                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="cb_ref" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>                                   
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="vertical-align: top; padding-left:15px">
                            <table id="Table3" border="0" class="module">
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Storage Loc." CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_warehouse" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true" CausesValidation="false"
                                                    EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="false" Width="200" DropDownWidth="200px" AutoPostBack="false"  
                                                    
                                                    >
                                                </telerik:RadComboBox>
                                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="cb_warehouse" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>                                 
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Cost Center" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                                        <ContentTemplate>
                                                            <telerik:RadComboBox ID="cb_CostCenter" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true" AutoPostBack="false"
                                                                EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" Width="150" DropDownWidth="350px" CausesValidation="false"
                                                                
                                                                >
                                                                <HeaderTemplate>
                                                                    <table style="width: 350px; font-size: smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">Code
                                                                            </td>
                                                                            <td style="width: 250px;">Name
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 350px; font-size: smaller">
                                                                        <tr>
                                                                            <td style="width: 100px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.code")%>
                                                                            </td>
                                                                            <td style="width: 250px;">
                                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="cb_CostCenter" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged" />  
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </td>
                                                <td>
                                                    <telerik:RadLabel runat="server" Text="Cost Name" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                                        <ContentTemplate>
                                                            <telerik:RadTextBox ID="txt_CostCenterName" runat="server" Width="200px" ReadOnly="true" AutoPostBack="false" RenderMode="Lightweight" >
                                                            </telerik:RadTextBox>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <%--<asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />--%>
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </td>
                                            </tr>
                                        </table>                                                                                                         
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">                                        
                                        <telerik:RadLabel runat="server" Text="Unit Code" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadTextBox ID="txt_unit" runat="server" RenderMode="Lightweight" Skin="Telerik" Width="150px" 
                                                    ReadOnly="true" AutoPostBack="false">
                                                </telerik:RadTextBox>
                                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="txt_unit" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>                                          
                                            </ContentTemplate>
                                            <Triggers>
                                               <%-- <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />--%>
                                            </Triggers>
                                        </asp:UpdatePanel>                                   
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Received By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_receipt" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                                    AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                                    HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                    
                                                    >
                                                    <HeaderTemplate>
                                                        <table style="width: 650px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 300px;">
                                                                    Name
                                                                </td>
                                                                <td style="width: 350px;">
                                                                    Position
                                                                </td>                                                                
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 650px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 300px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                                </td>
                                                                <td style="width: 350px;">
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
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left=15px">
                                        <telerik:RadLabel runat="server" Text="Issued By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_issued" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                                    AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                                    HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                    
                                                    >
                                                    <HeaderTemplate>
                                                        <table style="width: 650px; font-size:smaller">
                                                            <tr>
                                                               <td style="width: 300px;">
                                                                   Name
                                                               </td>
                                                               <td style="width: 350px;">
                                                                   Position
                                                               </td>                                                                
                                                           </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 650px; font-size:smaller">
                                                            <tr>
                                                               <td style="width: 300px;">
                                                                   <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                               </td>
                                                               <td style="width: 350px;">
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
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left=15px">
                                        <telerik:RadLabel runat="server" Text="Approved By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_approval" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                                    AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                                    HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                    
                                                    >
                                                    <HeaderTemplate>
                                                        <table style="width: 650px; font-size:smaller">
                                                            <tr>
                                                               <td style="width: 300px;">
                                                                   Name
                                                               </td>
                                                               <td style="width: 350px;">
                                                                   Position
                                                               </td>                                                                
                                                           </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 650px; font-size:smaller">
                                                            <tr>
                                                               <td style="width: 300px;">
                                                                   <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                               </td>
                                                               <td style="width: 350px;">
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
                                                &nbsp
                                                <asp:CheckBox ID="chk_posting" runat="server" Checked="false" Text="Posting"/>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Remark" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>                
                                    <td style="vertical-align:top; text-align:left">                               
                                        <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadTextBox ID="txt_remark" runat="server" TextMode="MultiLine"
                                                    Width="350px" Rows="0" TabIndex="5" Resize="Both" Skin="Telerik">
                                                </telerik:RadTextBox>
                                            </ContentTemplate>
                                            <Triggers>
                                                <%--<asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />--%>
                                            </Triggers>
                                        </asp:UpdatePanel>                                  
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 5px 15px 15px 15px; border-bottom-style:double; border-bottom-width: 1px; border-bottom-color:deeppink; ">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" Skin="Telerik"
                AllowPaging="false" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" ShowStatusBar="true" 
                    >
                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                <MasterTableView CommandItemDisplay="None"  DataKeyNames="prod_code" Font-Size="11px" EditMode="Batch"
                AllowAutomaticUpdates="true" AllowAutomaticInserts="true" AllowAutomaticDeletes="true"
                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item" 
                CommandItemSettings-ShowRefreshButton="False" ItemStyle-ForeColor="#006600">
                    <Columns>
                            <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                <ItemTemplate>
                                    <telerik:RadTextBox runat="server" ID="txt_ProdCode" ReadOnly="true" BorderStyle="None" Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>'>
                                    </telerik:RadTextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Original Material" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblProdCodeOri" Text='<%# DataBinder.Eval(Container, "DataItem.prod_code_ori") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                                    
                            <telerik:GridTemplateColumn HeaderText="Superior" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblSuperior" ></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                                    
                            <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                                HeaderStyle-HorizontalAlign="Center" DefaultInsertValue="0"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                <ItemTemplate>
                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_Part_Qty" Width="85px"  ReadOnly="false" EnabledStyle-HorizontalAlign="Right"
                                        NumberFormat-AllowRounding="true"
                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                        Text='<%# DataBinder.Eval(Container.DataItem, "qty_out", "{0:#,###,###0.00}") %>'
                                        onkeydown="blurTextBox(this, event)"
                                        AutoPostBack="true" MaxLength="11" Type="Number"
                                        NumberFormat-DecimalDigits="2">
                                    </telerik:RadTextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Uom" HeaderStyle-Width="100px" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-HorizontalAlign="Center" 
                                HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "unit_code") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                                    
                            <telerik:GridTemplateColumn HeaderText="Cost Center" HeaderStyle-Width="75px" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Center" 
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCostCntr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                                    
                            <telerik:GridTemplateColumn HeaderText="Storage Loc." HeaderStyle-Width="80px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" 
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblstorage" Text='<%# DataBinder.Eval(Container.DataItem, "wh_code") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                                    
                            <telerik:GridTemplateColumn HeaderText="Warranty" HeaderStyle-Width="60px" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                <ItemTemplate>
                                    <%--<asp:Label runat="server" ID="lblWarranty" Text='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>'></asp:Label>--%>
                                    <asp:CheckBox runat="server" ID="chkWarranty" Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                                    
                            <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="350px" ItemStyle-Width="350px" HeaderStyle-HorizontalAlign="Center" 
                                HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                <ItemTemplate>
                                    <telerik:RadTextBox runat="server" ID="txtRemark" Width="350px" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></telerik:RadTextBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                            </telerik:GridButtonColumn>
                        </Columns>
                </MasterTableView>
                <ClientSettings>                         
                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="273px" />
                </ClientSettings>
                </telerik:RadGrid>
            </ContentTemplate>
            </asp:UpdatePanel>
            </div>

            <div style="padding: 5px 15px 5px 15px;">
                <table>
                    <tr>    
                        <td style="padding: 0px 10px 0px 10px"> 
                            <telerik:RadLabel runat="server" ID="lbl_userId" Width="100px" Text="User: " CssClass="lbObject" Font-Size="Small"/>
                        </td>
                        <td style="width: 240px; padding-left: 5px">
                            <telerik:RadLabel runat="server" ID="lbl_lastUpdate" Width="220px" Text="Last Update: " CssClass="lbObject" Font-Size="Small"/>
                        </td>
                        <td style="padding: 0px 10px 0px 10px"> 
                            <telerik:RadLabel runat="server" ID="lbl_Owner" Width="100px" Text="Owner: " CssClass="lbObject" Font-Size="Small"/>
                        </td>
                        <td style="padding: 0px 10px 0px 10px">
                            <telerik:RadLabel runat="server" ID="lbl_edited" Width="100px" Text="Edited: " CssClass="lbObject" Font-Size="Small"/>
                        </td>                    
                        <td style="padding-top:0px; text-align:left">
                            <telerik:RadButton ID="btn_save" runat="server" Text="Save" CssClass="btn-wrapper" ForeColor="White"
                              Skin="Material"></telerik:RadButton>                        
                        </td>
                    </tr>                   
                </table>
            </div>

        </div>
        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Initial text" Position="Center" Skin="Windows7"
                    AutoCloseDelay="7000" Width="350" Height="110" Title="Current time" EnableRoundedCorners="true">
        </telerik:RadNotification>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
