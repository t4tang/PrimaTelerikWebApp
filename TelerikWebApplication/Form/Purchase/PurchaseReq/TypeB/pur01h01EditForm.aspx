<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pur01h01EditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.PurchaseReq.pur01h01EditForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
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
                <telerik:AjaxUpdatedControl ControlID="cb_cost_ctr"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="cb_ref"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_unit_code"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_unit_name"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_hm"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_remark"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="cb_ref">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2"></telerik:AjaxUpdatedControl>
            </UpdatedControls>                
        </telerik:AjaxSetting>    
    </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="1000" BackgroundPosition="None" >
    <img alt="Loading..." src="../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
    <div>
            <div style="padding: 15px 15px 10px 15px;" class="lbObject">
                <table id="Table2" width="Auto" border="0" class="module">
                <tr>
                    <td style="vertical-align:top; width:350px">
                        <table>
                            <tr style="vertical-align: top">                               
                                <td  style="vertical-align: top">
                                    <telerik:RadLabel runat="server" Text="PR Number:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                    <telerik:RadTextBox ID="txt_doc_code" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" EmptyMessage="Let it blank">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                               <td >
                                  <telerik:RadLabel runat="server" Text="RS Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                    <telerik:RadDatePicker ID="dtp_pr" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Telerik">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;">
                                        </Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                               </td>
                           </tr>                            
                            <tr>
                               <td>
                                   <telerik:RadLabel runat="server" Text="PR Source:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel> 
                                   <asp:RequiredFieldValidator runat="server" ID="prSourceValidator" ControlToValidate="cb_type_ref" ForeColor="Red" 
                                       Font-Size="X-Small"  Text="Empty not allowed!" Display="Dynamic"></asp:RequiredFieldValidator><br />
                                     <telerik:RadComboBox RenderMode="Lightweight" ID="cb_type_ref" runat="server" Width="150"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Telerik" EnableVirtualScrolling="true"
                                        OnItemsRequested="cb_type_ref_ItemsRequested" OnPreRender="cb_type_ref_PreRender" OnSelectedIndexChanged="cb_type_ref_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                              </td>
                           </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadLabel runat="server" Text="Priority:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="priorityValidator" ControlToValidate="cb_priority" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="300" DropDownWidth="300px"
                                        AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"
                                        OnItemsRequested="cb_priority_ItemsRequested" OnSelectedIndexChanged="cb_priority_SelectedIndexChanged" OnPreRender="cb_priority_PreRender">
                                    </telerik:RadComboBox>                                        
                                </td>
                            </tr>
                            <tr>
                                <td>                            
                                    <telerik:RadLabel runat="server" Text="Project Area:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_project" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                        <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                                AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged" Font-Size="Small"
                                                OnPreRender="cb_project_PreRender">
                                            </telerik:RadComboBox>                             
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                           </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadLabel runat="server" Text="Storage:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                   <asp:RequiredFieldValidator runat="server" ID="warehouseValidator" ControlToValidate="cb_warehouse" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="300" DropDownWidth="300px"
                                                AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"
                                                OnItemsRequested="cb_warehouse_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged" Font-Size="Small"
                                                OnPreRender="cb_warehouse_PreRender">
                                            </telerik:RadComboBox> 
                                    
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr> 
                        </table>
                    </td>
                    <td style="vertical-align:top; width:350px">
                        <table>                                                            
                            <tr>
                               <td colspan="2">
                                   <telerik:RadLabel runat="server" Text="Refference:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                   <asp:RequiredFieldValidator runat="server" ID="reffCodeValidator" ControlToValidate="cb_ref" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                   <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ref" runat="server" Width="200px" AutoPostBack="true" CausesValidation="false"
                                                DropDownWidth="900px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="sro_code" DataValueField="sro_code"
                                                OnItemsRequested="cb_ref_ItemsRequested" OnSelectedIndexChanged="cb_ref_SelectedIndexChanged">
                                                <HeaderTemplate>
                                                    <table style="width: 900px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 100px; font-variant:small-caps; color: #3399FF;">RS NUMBER.
                                                            </td>
                                                            <td style="width: 75px;font-variant:small-caps; color: #3399FF;">RS DATE
                                                            </td>
                                                            <td style="width: 700px;font-variant:small-caps; color: #3399FF;">UNIT
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 900px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 100px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.doc_code")%>
                                                            </td>
                                                            <td style="width: 75px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.doc_date")%>
                                                            </td>
                                                            <td style="width: 700px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.doc_remark")%>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                </FooterTemplate>
                                            </telerik:RadComboBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                               </td>
                           </tr>
                            <tr>
                               <td colspan="2">
                                   <telerik:RadLabel runat="server" Text="Reff. Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                   <asp:RequiredFieldValidator runat="server" ID="reffDateValidator" ControlToValidate="txt_reff_date" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Empty not allowed!" ></asp:RequiredFieldValidator><br />
                                   <asp:UpdatePanel ID="UpdatePanel8" runat="server">                                        
                                        <ContentTemplate>
                                           <telerik:RadTextBox ID="txt_reff_date" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight"
                                                AutoPostBack="false">
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                               </td>
                       
                           </tr>
                            <tr>                                                        
                               <td>
                                   <telerik:RadLabel runat="server" Text="Unit Code :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                   <asp:RequiredFieldValidator runat="server" ID="unitCodeValidator" ControlToValidate="txt_unit_code" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                    <ContentTemplate>
                                    <telerik:RadTextBox ID="txt_unit_code" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" Font-Size="Small"
                                         Skin="Telerik">
                                    </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                                <td>
                                   <telerik:RadLabel runat="server" Text="Unit Name:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                   <asp:RequiredFieldValidator runat="server" ID="unitNameValidator" ControlToValidate="txt_unit_name" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                    <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadTextBox ID="txt_unit_name" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" Font-Size="Small"
                                        Skin="Telerik">
                                        </telerik:RadTextBox>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                    </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                   <telerik:RadLabel runat="server" Text="HM :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                   <asp:RequiredFieldValidator runat="server" ID="hmValidator" ControlToValidate="txt_hm" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadTextBox ID="txt_hm" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" Font-Size="Small"
                                           Skin="Telerik">
                                        </telerik:RadTextBox>
                                    </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                   <telerik:RadLabel runat="server" Text="Cost Center:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                   <asp:RequiredFieldValidator runat="server" ID="cost_ctr_Validator" ControlToValidate="cb_cost_ctr" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadComboBox ID="cb_cost_ctr" runat="server" Width="250px"
                                            DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                            MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" 
                                            OnItemsRequested="cb_cost_ctr_ItemsRequested" OnSelectedIndexChanged="cb_cost_ctr_SelectedIndexChanged" 
                                            OnPreRender="cb_cost_ctr_PreRender">
                                                <HeaderTemplate>
                                                <table style="width: 450px; font-size: smaller">
                                                    <tr>
                                                        <td style="width: 100px;">Code
                                                        </td>
                                                        <td style="width: 350px;">Name
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 450px; font-size: smaller">
                                                    <tr>
                                                        <td style="width: 100px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.code")%>
                                                        </td>
                                                        <td style="width: 350px;">
                                                            <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                                
                                        </telerik:RadComboBox>
                                    </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_work_order" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight"
                                                AutoPostBack="false">
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            </table>
                    </td>
                    <td style="vertical-align:top">
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Remark:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_remark"
                                                runat="server" TextMode="MultiLine"
                                                Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: top; text-align: left; ">
                                <telerik:RadLabel CssClass="lbObject" runat="server" Text="Prepared By:" ForeColor="Black"></telerik:RadLabel><br />
                                <asp:UpdatePanel ID="UpdatePanel14" runat="server">
                                <ContentTemplate>
                                <telerik:RadComboBox ID="cb_prepare_by" runat="server" Width="250px"
                                                DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                   OnItemsRequested="cb_prepare_by_ItemsRequested"
                                                OnSelectedIndexChanged="cb_prepare_by_SelectedIndexChanged" OnPreRender="cb_prepare_by_PreRender">
                                                 <HeaderTemplate>
                                                    <table style="width: 550px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 200px;">Name
                                                            </td>
                                                            <td style="width: 350px;">Position
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 550px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 200px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                            </td>
                                                            <td style="width: 350px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                </FooterTemplate>
                                    </telerik:RadComboBox>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                </Triggers>
                                </asp:UpdatePanel>
                                </td>
                            </tr>                            
                            <tr>
                                <td style="vertical-align: top; text-align: left">
                                    <telerik:RadLabel runat="server" Text="Order By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                    <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                                    <ContentTemplate>
                                    <telerik:RadComboBox ID="cb_orderBy" runat="server" Width="250px"
                                                DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                OnItemsRequested="cb_orderBy_ItemsRequested"
                                                OnSelectedIndexChanged="cb_orderBy_SelectedIndexChanged"
                                                OnPreRender="cb_orderBy_PreRender">
                                         <HeaderTemplate>
                                            <table style="width: 550px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 200px;">Name
                                                    </td>
                                                    <td style="width: 350px;">Position
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 550px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 200px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                    </td>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                    </td>
                                                </tr>
                                            </table>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                </FooterTemplate>
                                    </telerik:RadComboBox>
                                </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                    </Triggers>
                                </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: top; text-align: left">
                                <telerik:RadLabel runat="server" Text="Checked By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                <ContentTemplate>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_checked" runat="server" Width="250px"
                                        DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                        OnItemsRequested="cb_received_ItemsRequested"
                                        OnSelectedIndexChanged="cb_received_SelectedIndexChanged"
                                        OnPreRender="cb_received_PreRender">
                                        <HeaderTemplate>
                                            <table style="width: 550px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 200px;">Name
                                                    </td>
                                                    <td style="width: 350px;">Position
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 550px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 200px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                    </td>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                    </td>
                                                </tr>
                                            </table>

                                        </ItemTemplate>
                                        <FooterTemplate>
                                        </FooterTemplate>
                                    </telerik:RadComboBox>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                </Triggers>
                                </asp:UpdatePanel>
                                </td>                                                      
                            </tr>
                            <tr>
                                <td style="vertical-align: top; text-align: left; ">
                                <telerik:RadLabel CssClass="lbObject" runat="server" Text="Approved By:" ForeColor="Black"></telerik:RadLabel><br />
                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                <ContentTemplate>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px"
                                        DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true"
                                        OnItemsRequested="cb_approved_ItemsRequested"
                                        OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                        OnPreRender="cb_approved_PreRender" >
                                        <HeaderTemplate>
                                            <table style="width: 550px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 200px;">Name
                                                    </td>
                                                    <td style="width: 350px;">Position
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 550px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 200px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                    </td>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.jabatan")%>
                                                    </td>
                                                </tr>
                                            </table>

                                        </ItemTemplate>
                                        <FooterTemplate>
                                        </FooterTemplate>
                                    </telerik:RadComboBox>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                </Triggers>
                                </asp:UpdatePanel>
                                </td>
                            </tr>                            
                        </table>
                    </td>
                </tr>                  
               </table>
            </div>            
            
            <div style="padding: 5px 15px 0px 15px; border-bottom-style:double; border-bottom-width: 1px; border-bottom-color:deeppink; height:250px; overflow-y:auto">
                 <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Always">
                      <ContentTemplate>
                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" Skin="Telerik" PageSize="5"
                                AllowPaging="false" AllowSorting="true" runat="server" ShowStatusBar="true"  ClientSettings-Selecting-AllowRowSelect="true"
                                OnNeedDataSource="RadGrid2_NeedDataSource"
                                OnPreRender="RadGrid2_PreRender" >
                                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="Prod_code" Font-Size="12px" EditMode="Batch"
                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >
                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="False" ShowCancelChangesButton="false" />
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Type" ItemStyle-Width="50px" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Highlight" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblProdType" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>                                           
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="150px" ItemStyle-Width="150px"
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Highlight" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblProdCode" Text='<%# DataBinder.Eval(Container.DataItem, "Prod_code") %>'></asp:Label>
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="RS Number" HeaderStyle-Width="100px" ItemStyle-Width="100px" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Highlight" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblRS" Text='<%# DataBinder.Eval(Container.DataItem, "no_ref") %>'></asp:Label>
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="OH Qty" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Highlight" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblSoh" Text='<%# DataBinder.Eval(Container.DataItem, "stock_hand", "{0:#,###,###0.00}") %>'></asp:Label>
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Order Qty" HeaderStyle-Width="80px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Highlight" DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="80px"  ReadOnly="false" 
                                                    EnabledStyle-HorizontalAlign="Right"
                                                    NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "qty", "{0:#,###,###0.00}") %>'
                                                    onkeydown="blurTextBox(this, event)"
                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                    NumberFormat-DecimalDigits="2">
                                                </telerik:RadTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="PO Qty" HeaderStyle-Width="70px" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Highlight" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblQtyPo" Text='<%# DataBinder.Eval(Container.DataItem, "qtypo", "{0:#,###,###0.00}") %>'></asp:Label>
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="50px" ItemStyle-Width="50px" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Highlight">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblUom" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>'></asp:Label>
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Cost Center" HeaderStyle-Width="100px" ItemStyle-Width="100px" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Highlight" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblCostCtr" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Delivery Date" HeaderStyle-Width="110px"  ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Highlight" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>  
                                                <telerik:RadDatePicker runat="server" ID="dtpDelivDate" Width="110px"
                                                    SelectedDate='<%#DataBinder.Eval(Container, "DataItem.DeliDate")%>' 
                                                    onkeydown="blurTextBox(this, event)" Type="Date">
                                                    <DateInput DisplayDateFormat="dd-MM-yyyy" runat="server" /> 
                                                </telerik:RadDatePicker>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn> 
                            
                                        <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="200px" ItemStyle-Width="200px"
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Highlight" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="200px"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>'>
                                                </telerik:RadTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Highlight" ConfirmTitle="Delete" ConfirmDialogType="RadWindow"
                                            ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                        </telerik:GridButtonColumn>

                                    </Columns>
                                </MasterTableView>
                                <ClientSettings>
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="180px" />
                                    <Selecting AllowRowSelect="true"></Selecting>                    
                                </ClientSettings>
                            </telerik:RadGrid>
                            <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Text="Data tersimpan" Position="BottomRight"
                                    AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
                            </telerik:RadNotification>
                     </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                    </Triggers>
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
                        <td colspan="2" style="padding-top:0px; text-align:left">
                            <telerik:RadButton ID="btn_save" runat="server" Text="Save Me!" CssClass="btn-wrapper" ForeColor="White"
                                OnClick="btn_save_Click" Skin="Material"></telerik:RadButton>
                        </td>
                    </tr>                   
                </table>
            </div>
            
    </div>
        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data telah disimpan" Position="Center" Skin="Windows7"
                    AutoCloseDelay="7000" Width="350" Height="110" Title="Congrotulation" EnableRoundedCorners="true">
        </telerik:RadNotification>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
        
    </form>
</body>
</html>
