﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h05EditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.GoodsIssued.inv01h05EditForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    <link href="../../../Styles/common.css" rel="stylesheet" />
    
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

        function ShowJournal(id) {
            window.radopen("inv01h05journal.aspx?doc_code=" + id, "JournalDialog");
            return false;
        }
    </script>
    <style type="text/css">
        .lblErrorDescription {
            color: red;
            font-size: 11px;
            font-weight: normal;
            font-style: italic;
            font-family: Segoe UI, Tahoma, Geneva, 'Verdana', sans-serif;
        }
    </style>

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
                    <telerik:AjaxUpdatedControl ControlID="txt_unit_code"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_unit_name"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_remark"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cb_ref">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cb_CostCenter"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_unit_code"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_unit_name"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="txt_remark"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting> 
            <telerik:AjaxSetting AjaxControlID="cb_warehouse">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>    
        </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="1000" BackgroundPosition="None" >
        <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
        </telerik:RadAjaxLoadingPanel>

        <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
        <div style="background-color:transparent">
            <div style="padding: 15px 15px 5px 15px; background-color:transparent" class="lbObject">
                <table>
                    <tr style="vertical-align: top">
                        <td style="vertical-align: top; width:auto">
                            <table id="Table2" width="Auto" border="0" class="module">                                
                            <tr>
                                <td colspan="2" style="padding:0px 0px 5px 5px">
                                    <asp:ImageButton runat="server" ID="btnSave" AlternateText="New" OnClick="btn_save_Click" ToolTip="Save" Visible="true"
                                    Height="30px" Width="32px" ImageUrl="~/Images/simpan.png"></asp:ImageButton>
                                    <%--<telerik:RadButton ID="btn_save" runat="server" Text="Save" BackColor="YellowGreen" ForeColor="WhiteSmoke" Width="80px" Height="28px"
                                    OnClick="btn_save_Click" Skin="Material"></telerik:RadButton>--%>
                                &nbsp;
                                    <%--<telerik:RadButton ID="btnJournal" runat="server" Text="Journal" ForeColor="YellowGreen" BackColor="WhiteSmoke" Width="80px" Height="28px"
                                     OnClick="btnJournal_Click" Skin="Material"></telerik:RadButton>--%>
                                </td>
                            </tr>
                                <tr>
                                    <td >
                                        <telerik:RadLabel runat="server" Text="GI Number" CssClass="lbObject"></telerik:RadLabel>
                                    </td>
                                    <td colspan="3">
                                        <telerik:RadTextBox ID="txt_gi_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                           Skin="Silk"  EmptyMessage="Let it blank" >
                                        <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                        <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                        <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                        <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                        <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Type" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_type_ref" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                    </td>
                                    <td colspan="3">
                                        <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_type_ref" runat="server" Width="150" CausesValidation="false" 
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Silk" AutoPostBack="true"
                                                    OnItemsRequested="cb_type_ref_ItemsRequested" 
                                                    OnPreRender="cb_type_ref_PreRender"
                                                    OnSelectedIndexChanged="cb_type_ref_SelectedIndexChanged" EmptyMessage="- Select a Type -"
                                                    EnableVirtualScrolling="true">
                                                </telerik:RadComboBox>                                        
                                                
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">                                        
                                        <telerik:RadLabel runat="server" Text="Cust/Supp" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_CustSupp" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                    </td>
                                    <td colspan="3">
                                        <telerik:RadComboBox ID="cb_CustSupp" runat="server" RenderMode="Lightweight" Skin="Silk" EnableLoadOnDemand="true"  HighlightTemplatedItems="true"
                                            EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" Enabled="true" Width="250" DropDownWidth="270px" CausesValidation="false"  
                                            OnItemsRequested="cb_CustSupp_ItemsRequested" 
                                            OnPreRender="cb_CustSupp_PreRender" 
                                            OnSelectedIndexChanged="cb_CustSupp_SelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Project" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_Project" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                    </td>
                                    <td colspan="3" >
                                        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_Project" runat="server" RenderMode="Lightweight" Skin="Silk" EnableLoadOnDemand="true"  CausesValidation="false"
                                                    EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="250" DropDownWidth="270px" 
                                                    OnItemsRequested="cb_Project_ItemsRequested" 
                                                    OnPreRender="cb_Project_PreRender" 
                                                    OnSelectedIndexChanged="cb_Project_SelectedIndexChanged">
                                                </telerik:RadComboBox>
                                                
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel" style="width:110px">
                                        <telerik:RadLabel runat="server" Text="Reff. No" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="cb_ref" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                    </td>
                                    <td style="vertical-align:top; text-align:left; width:350px">
                                        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_ref" runat="server" RenderMode="Lightweight" Width="200px" AutoPostBack="true" CausesValidation="false"  
                                                    DropDownWidth="850px" EnableLoadOnDemand="true" MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" DataTextField="doc_code" DataValueField="doc_code"
                                                    ShowMoreResultsBox="true"  
                                                    OnItemsRequested="cb_ref_ItemsRequested"
                                                    OnPreRender="cb_ref_PreRender" 
                                                    OnSelectedIndexChanged="cb_ref_SelectedIndexChanged" 
                                                     >
                                                    <HeaderTemplate>
                                                        <table style="width: 850px; font-size:11px">
                                                            <tr>
                                                                <td style="width: 100px;">
                                                                    Reff. No.
                                                                </td>
                                                                <td style="width: 750px;">
                                                                    Remark
                                                                </td>                                                                
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 850px; font-size:11px">
                                                            <tr>
                                                                <td style="width: 100px;">
                                                                    <%# DataBinder.Eval(Container, "DataItem.doc_code")%>
                                                                </td>
                                                                <td style="width: 750px;">
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
                                                &nbsp <telerik:RadLabel runat="server" Skin="Silk" ID="lbl_reff_no" Width="120px" ></telerik:RadLabel> 
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_type_ref" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>                                 
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Cost Center" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="cb_CostCenter" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                    </td>
                                    <td >
                                        <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_CostCenter" runat="server" RenderMode="Lightweight" Skin="Silk" EnableLoadOnDemand="true" AutoPostBack="true"   
                                                    EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" Width="200" DropDownWidth="350px" CausesValidation="false"
                                                    OnItemsRequested="cb_CostCenter_ItemsRequested" 
                                                    OnPreRender="cb_CostCenter_PreRender" 
                                                    OnSelectedIndexChanged="cb_CostCenter_SelectedIndexChanged" DataTextField="dept_code" DataValueField="dept_code">
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
                                                
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_Project" EventName="SelectedIndexChanged" />  
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>                                           
                                <tr>
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
                                                <%--<asp:AsyncPostBackTrigger ControlID="cb_CostCenter" EventName="SelectedIndexChanged" />--%>
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
                                                <telerik:RadComboBox ID="cb_warehouse" runat="server" RenderMode="Lightweight" Skin="Silk" EnableLoadOnDemand="true" CausesValidation="false"
                                                    EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="false" Width="200" DropDownWidth="200px" AutoPostBack="true"  
                                                    OnItemsRequested="cb_loc_ItemsRequested" 
                                                    OnPreRender="cb_loc_PreRender" 
                                                    OnSelectedIndexChanged="cb_loc_SelectedIndexChanged">
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
                                        <telerik:RadLabel runat="server" Text="Unit Code" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadTextBox ID="txt_unit" runat="server" RenderMode="Lightweight" Skin="Silk" Width="150px" 
                                                    ReadOnly="true" AutoPostBack="false">
                                                </telerik:RadTextBox>                                          
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>                                   
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker ID="dtp_date" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="MetroTouch">
                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                                FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                            <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ControlToValidate="dtp_date" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                        &nbsp
                                        <telerik:RadLabel runat="server" Text="Limit" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        <telerik:RadTextBox ID="txt_limit" runat="server" Width="100px" Enabled="false" RenderMode="Lightweight"
                                            AutoPostBack="false" >
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Received By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_receipt" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="500px"
                                                    AutoPostBack="false" ShowMoreResultsBox="true" Skin="Silk" EnableLoadOnDemand="true" 
                                                    HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                    OnItemsRequested="cb_receipt_ItemsRequested" 
                                                    OnPreRender="cb_receipt_PreRender" 
                                                    OnSelectedIndexChanged="cb_receipt_SelectedIndexChanged">
                                                    <HeaderTemplate>
                                                        <table style="width: 500px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 200px;">
                                                                    Name
                                                                </td>
                                                                <td style="width: 300px;">
                                                                    Position
                                                                </td>                                                                
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 500px; font-size:smaller">
                                                            <tr>
                                                                <td style="width: 200px;">
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
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Issued By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_issued" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="500px"
                                                    AutoPostBack="false" ShowMoreResultsBox="true" Skin="Silk" EnableLoadOnDemand="true" 
                                                    HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                    OnItemsRequested="cb_issued_ItemsRequested" 
                                                    OnPreRender="cb_issued_PreRender" 
                                                    OnSelectedIndexChanged="cb_issued_SelectedIndexChanged">
                                                    <HeaderTemplate>
                                                        <table style="width: 500px; font-size:smaller">
                                                            <tr>
                                                               <td style="width: 200px;">
                                                                   Name
                                                               </td>
                                                               <td style="width: 300px;">
                                                                   Position
                                                               </td>                                                                
                                                           </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 500px; font-size:smaller">
                                                            <tr>
                                                               <td style="width: 200px;">
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
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Approved By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_approval" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="500px"
                                                    AutoPostBack="false" ShowMoreResultsBox="true" Skin="Silk" EnableLoadOnDemand="true" 
                                                    HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                    OnItemsRequested="cb_approval_ItemsRequested" 
                                                    OnPreRender="cb_approval_PreRender" 
                                                    OnSelectedIndexChanged="cb_approval_SelectedIndexChanged">
                                                    <HeaderTemplate>
                                                        <table style="width: 500px; font-size:smaller">
                                                            <tr>
                                                               <td style="width: 200px;">
                                                                   Name
                                                               </td>
                                                               <td style="width: 300px;">
                                                                   Position
                                                               </td>                                                                
                                                           </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 500px; font-size:smaller">
                                                            <tr>
                                                               <td style="width: 200px;">
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
                                                    Width="350px" Rows="0" TabIndex="5" Resize="Both" Skin="Silk">
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
                        <td style="padding-left:35px">
                            <table>
                                <tr>    
                                    <td > 
                                        <telerik:RadLabel runat="server" ID="lbl_userId" Width="100px" Text="User: " CssClass="lbObject" Font-Size="Small"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        <telerik:RadLabel runat="server" ID="lbl_lastUpdate" Width="220px" Text="Last Update: " CssClass="lbObject" Font-Size="Small"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td > 
                                        <telerik:RadLabel runat="server" ID="lbl_Owner" Width="100px" Text="Owner: " CssClass="lbObject" Font-Size="Small"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        <telerik:RadLabel runat="server" ID="lbl_edited" Width="100px" Text="Edited: " CssClass="lbObject" Font-Size="Small"/>
                                    </td>                    
                       
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chk_posting" runat="server" Checked="false" Text="Posting" CssClass="lbObject"/>
                                    </td>
                                </tr>                   
                            </table>
                        </td>
                    </tr>
                </table>

            </div>
            
            <%--<div style="padding: 5px 0px 5px 15px;position:absolute">
                <telerik:RadLabel runat="server" ID="lblErrorDescription" Width="650px" ForeColor="Red" CssClass="lblErrorDescription"/>
            </div>--%>

            <div style="padding: 5px 15px 15px 15px; height:300px">
            <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"
            SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Silk" CausesValidation="False">
                <Tabs>
                    <telerik:RadTab Text="Detail" Height="10px">
                    </telerik:RadTab>
                    <telerik:RadTab Text="Journal" Height="10px"> 
                    </telerik:RadTab>            
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage runat="server" SelectedIndex="0" ID="RadMultiPage1">
                <telerik:RadPageView runat="server" ID="PageView1" Height="300px" Selected="true">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" Skin="Silk" CssClass="RadGrid_ModernBrowsers"
                            AllowPaging="false" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" ShowStatusBar="true" 
                            OnNeedDataSource="RadGrid2_NeedDataSource"
                            OnDeleteCommand="RadGrid2_DeleteCommand"
                            OnPreRender="RadGrid2_PreRender" >
                            <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                            <HeaderStyle Font-Size="12px" ForeColor="Highlight" />
                            <MasterTableView CommandItemDisplay="None"  DataKeyNames="prod_code" Font-Size="11px" 
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item" 
                            CommandItemSettings-ShowRefreshButton="False" ItemStyle-ForeColor="#006600">
                                <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="False" ShowCancelChangesButton="false" />
                                <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                            >
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lbl_ProdCode" ReadOnly="true" BorderStyle="None" Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>'>
                                                </asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Original Material" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                            >
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblProdCodeOri" Text='<%# DataBinder.Eval(Container, "DataItem.prod_code_ori") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    
                                        <%--<telerik:GridTemplateColumn HeaderText="Superior" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                            >
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblSuperior" ></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>--%>
                                    
                                        <telerik:GridTemplateColumn HeaderText="Qty" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                                            HeaderStyle-HorizontalAlign="Center" DefaultInsertValue="0"  >
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
                                            >
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "uom") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    
                                        <telerik:GridTemplateColumn HeaderText="Cost Center" HeaderStyle-Width="75px" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Center" 
                                            HeaderStyle-HorizontalAlign="Center" >
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblCostCntr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    
                                        <telerik:GridTemplateColumn HeaderText="Storage Loc." HeaderStyle-Width="80px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center" 
                                            HeaderStyle-HorizontalAlign="Center" >
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblstorage" Text='<%# DataBinder.Eval(Container.DataItem, "wh_code") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    
                                        <telerik:GridTemplateColumn HeaderText="Warranty" HeaderStyle-Width="60px" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Center"
                                            HeaderStyle-HorizontalAlign="Center" >
                                            <ItemTemplate>
                                                <%--<asp:Label runat="server" ID="lblWarranty" Text='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>'></asp:Label>--%>
                                                <asp:CheckBox runat="server" ID="chkWarranty" Checked='<%# DataBinder.Eval(Container.DataItem, "tWarranty") %>' />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    
                                        <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="350px" ItemStyle-Width="350px" HeaderStyle-HorizontalAlign="Center" 
                                            >
                                            <ItemTemplate>
                                                <telerik:RadTextBox runat="server" ID="txtRemark" Width="350px" Text='<%# DataBinder.Eval(Container.DataItem, "remark") %>'></telerik:RadTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" 
                                            ConfirmDialogType="Classic" ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                        </telerik:GridButtonColumn>
                                    </Columns>
                            </MasterTableView>
                            <ClientSettings>
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="192px" />
                                    <Selecting AllowRowSelect="true"></Selecting> 
                            </ClientSettings>
                            </telerik:RadGrid>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView1" Height="300px" >
                   <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" AutoGenerateColumns="false" Skin="Silk" CssClass="RadGrid_ModernBrowsers"
                        AllowPaging="false" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" ShowStatusBar="true"        
                        OnNeedDataSource="RadGrid3_NeedDataSource" 
                        OnPreRender="RadGrid3_PreRender">
                            <HeaderStyle Font-Size="12px" />
                            <AlternatingItemStyle Font-Size="10px" Font-Names="Comic Sans MS" />
                            <MasterTableView DataKeyNames="nomor" HeaderStyle-ForeColor="Highlight" ItemStyle-Font-Size="10px" ItemStyle-Font-Names="Comic Sans MS"
                                HorizontalAlign="NotSet" AutoGenerateColumns="False">
                            <SortExpressions>
                                <telerik:GridSortExpression FieldName="nomor" SortOrder="Descending" />
                            </SortExpressions>
                            <ColumnGroups>
                                <telerik:GridColumnGroup Name="IDR" HeaderText="IDR"
                                    HeaderStyle-HorizontalAlign="Center" />
                                <telerik:GridColumnGroup Name="Valas" HeaderText="Valas"
                                    HeaderStyle-HorizontalAlign="Center" />
                            </ColumnGroups>
                            <Columns>
                                <telerik:GridBoundColumn DataField="accountcode" HeaderStyle-Width="100px" HeaderText="Account No." SortExpression="accountcode"
                                    UniqueName="accountcode" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="70px" 
                                    >                                
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="accountname" HeaderStyle-Width="250px" HeaderText="Account Name" SortExpression="accountname"
                                    UniqueName="accountname" ReadOnly="true" HeaderStyle-HorizontalAlign="Center"
                                    >                                
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="debet" HeaderStyle-Width="100px" HeaderText="Debet" SortExpression="debet"
                                    UniqueName="debet" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" 
                                    DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" >                                
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="credit" HeaderStyle-Width="100px" HeaderText="Credit" SortExpression="credit"
                                    UniqueName="credit" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" 
                                    DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" >                                
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="remark" HeaderStyle-Width="200px" HeaderText="Remark" SortExpression="remark"
                                    UniqueName="remark" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" >
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                        <ClientSettings AllowKeyboardNavigation="true">
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="192px" />
                                    <Selecting AllowRowSelect="true"></Selecting> 
                            </ClientSettings>
                    </telerik:RadGrid>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
            
            </div>

        </div>
        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Initial text" Position="Center" Skin="Windows7"
                    AutoCloseDelay="7000" Width="350" Height="110" Title="Current time" EnableRoundedCorners="true">
        </telerik:RadNotification>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="JournalDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1150px" Height="670px" Modal="true" AutoSize="True">
                </telerik:RadWindow>                
            </Windows>
        </telerik:RadWindowManager>
    </form>
</body>
</html>
