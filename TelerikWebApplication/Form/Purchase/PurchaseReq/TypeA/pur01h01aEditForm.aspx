<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pur01h01aEditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.PurchaseReq.pur01h01aEditForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
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
            </UpdatedControls>
        </telerik:AjaxSetting>
            
    </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
    <div>
            <div style="padding: 15px 15px 20px 15px; width:600px">
                <table id="Table2" width="Auto" border="0" class="module">
                   <tr style="vertical-align: top">                               
                       <td  style="vertical-align: top">
                            <telerik:RadLabel runat="server" Text="PR Number :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadTextBox ID="txt_doc_code" EmptyMessage="- Leave Me blank -" runat="server" Width="300px" ReadOnly="true"
                                RenderMode="Lightweight" Font-Size="Small">
                            </telerik:RadTextBox>
                       </td>
                       <td colspan="4" style="vertical-align: top; text-align: left">
                            <telerik:RadLabel runat="server" Text="Priority :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                           <asp:RequiredFieldValidator runat="server" ID="priorityValidator" ControlToValidate="cb_priority" ForeColor="Red" 
                               Font-Size="X-Small" Text="Empty not allowed!" Display="Dynamic"></asp:RequiredFieldValidator><br />
                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="300" DropDownWidth="300px"
                                AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"  Font-Size="Small"
                                OnItemsRequested="cb_priority_ItemsRequested" OnSelectedIndexChanged="cb_priority_SelectedIndexChanged" OnPreRender="cb_priority_PreRender">
                            </telerik:RadComboBox>
                           
                    </td>
                   </tr>
                   <tr>
                       <td >
                          <telerik:RadLabel runat="server" Text="PR Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                          <telerik:RadDatePicker ID="dtp_pr" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                           Skin="Telerik">
                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Font-Size="Small">
                            </Calendar>
                            <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" Font-Size="Small">
                            </DateInput>
                            <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                        </telerik:RadDatePicker>
                       </td>
                       <td colspan="4">
                          <telerik:RadLabel runat="server" Text="PR Source :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel> 
                           <asp:RequiredFieldValidator runat="server" ID="prSourceValidator" ControlToValidate="cb_type_ref" ForeColor="Red" 
                               Font-Size="X-Small"  Text="Empty not allowed!" Display="Dynamic"></asp:RequiredFieldValidator><br />
                          <telerik:RadComboBox RenderMode="Lightweight" ID="cb_type_ref" runat="server" Width="300"
                            EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Telerik" EnableVirtualScrolling="true"
                            OnItemsRequested="cb_type_ref_ItemsRequested" OnPreRender="cb_type_ref_PreRender" Font-Size="Small">
                        </telerik:RadComboBox>
                          
                       </td>
                   </tr>
               </table>
            </div>            
            <div style="padding: 10px 15px 10px 15px; width:600px">
                <table>
                   <tr>
                        <td >                            
                            <telerik:RadLabel runat="server" Text="Project Area :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_project" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" Font-Size="Small" CausesValidation="false"
                                OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged" OnPreRender="cb_project_PreRender">
                                </telerik:RadComboBox>                              
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                       <td colspan="2" >
                            <telerik:RadLabel runat="server" Text="Storage :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                           <asp:RequiredFieldValidator runat="server" ID="warehouseValidator" ControlToValidate="cb_warehouse" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                <ContentTemplate>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="300px" DropDownWidth="300px"
                                        ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" Font-Size="Small"
                                        OnItemsRequested="cb_warehouse_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged"
                                        OnPreRender="cb_warehouse_PreRender">
                                    </telerik:RadComboBox>
                                    
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>                                                                    
                   <tr>
                       <td>
                           <telerik:RadLabel runat="server" Text="Cost Center :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                           <asp:RequiredFieldValidator runat="server" ID="costCtrValidator" ControlToValidate="cb_cost_ctr" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                           <asp:UpdatePanel ID="UpdatePanel8" runat="server">                                        
                                <ContentTemplate>
                                   <telerik:RadComboBox ID="cb_cost_ctr" runat="server" Width="300px"
                                        DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true"  Font-Size="Small"
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
                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                       </td>
                   </tr>
                   
                   <tr>
                        <td colspan="2">
                            <telerik:RadLabel runat="server" Text="Remark :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                <ContentTemplate>
                                    <telerik:RadTextBox ID="txt_remark"  Font-Size="Small"
                                        runat="server" TextMode="MultiLine" Skin="Telerik"
                                        Width="600px" Rows="0" Resize="None">
                                    </telerik:RadTextBox>
                                </ContentTemplate>
                                <%--<Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />
                                </Triggers>--%>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="padding: 10px 15px 10px 15px; width:600px">
                <table>
                   <tr>
                      <td style="vertical-align: top; text-align: left">
                          <telerik:RadLabel runat="server" Text="Prepare By :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                          <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                            <ContentTemplate>
                                    <telerik:RadComboBox ID="cb_prepare_by" runat="server" Width="300px"  Font-Size="Small"
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
                      <td style="vertical-align: top; text-align: left">
                         <telerik:RadLabel runat="server" Text="Checked By :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                         <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                               <telerik:RadComboBox RenderMode="Lightweight" ID="cb_checked" runat="server" Width="300px"
                                    DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"  Font-Size="Small"
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
                      <td style="vertical-align: top; text-align: left">
                            <telerik:RadLabel runat="server" Text="Order By :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                <ContentTemplate>
                                    <telerik:RadComboBox ID="cb_orderBy" runat="server" Width="300px" Font-Size="Small"
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
                      <td style="vertical-align: top; text-align: left; ">
                         <telerik:RadLabel CssClass="lbObject" runat="server" Text="Approved By :" ForeColor="Black"></telerik:RadLabel><br />
                         <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                            <ContentTemplate>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="300px"
                                    DropDownWidth="550px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" Font-Size="Small"
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
                    <tr>
                        <td colspan="2" style="padding-top:30px">
                            <telerik:RadButton ID="btn_save" runat="server" Text="Save Me!" CssClass="btn-wrapper" ForeColor="#ff0066" Font-Bold="true" 
                                OnClick="btn_save_Click" Skin="Material"></telerik:RadButton>
                        </td>
                    </tr>
                   
                </table>
            </div>
            <table border="0">               
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
                    <%--<td style="padding: 0px 10px 0px 10px" >
                        <telerik:RadLabel runat="server" ID="lbl_printed" Width="70px" Text="Printed: " Visible="false"  />                                     
                    </td>--%>
                </tr>                        
           </table>
    </div>
        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Initial text" Position="Center" Skin="Windows7"
                    AutoCloseDelay="7000" Width="350" Height="110" Title="Current time" EnableRoundedCorners="true">
        </telerik:RadNotification>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
        
    </form>
</body>
</html>
