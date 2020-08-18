<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h03mEditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.ReservationSlip.Manual.inv01h03mEditForm" %>

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
                <telerik:AjaxUpdatedControl ControlID="txt_unit_code"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_unit_name"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_hm"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_remark"></telerik:AjaxUpdatedControl>
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
                                <telerik:RadLabel runat="server" Text="RS Number:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                <telerik:RadTextBox ID="txt_doc_code" runat="server" Width="300px" ReadOnly="true" RenderMode="Lightweight" CssClass="lbObject"
                                    AutoPostBack="false" Font-Size="Small" EmptyMessage="- Leave it Blank - ">
                                </telerik:RadTextBox>
                           </td>
                      </tr>
                            <tr>
                       <td >
                          <telerik:RadLabel runat="server" Text="RS Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                          <telerik:RadDatePicker ID="dtp_rs" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                           Skin="Telerik">
                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Font-Size="Small">
                            </Calendar>
                            <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" Font-Size="Small">
                            </DateInput>
                            <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                        </telerik:RadDatePicker>
                       </td>
                   </tr>
                            <tr>
                       <td colspan="2">
                          <telerik:RadLabel runat="server" Text="Excute Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel> <br />                          
                            <telerik:RadDatePicker ID="dtp_exe" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                TabIndex="4" Skin="Telerik">
                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"
                                    FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik">
                                </Calendar>
                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" Font-Size="Small">
                                </DateInput>
                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                            </telerik:RadDatePicker>                          
                       </td>
                   </tr>
                            <tr>
                               <td colspan="2">
                                   <telerik:RadLabel runat="server" Text="Type Ref:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel> 
                                   <asp:RequiredFieldValidator runat="server" ID="reffTypeValidator" ControlToValidate="cb_type_ref" ForeColor="Red" 
                                       Font-Size="X-Small"  Text="Empty not allowed!" Display="Dynamic"></asp:RequiredFieldValidator><br />
                                  <telerik:RadComboBox RenderMode="Lightweight" ID="cb_type_ref" runat="server" Width="300" Font-Size="Small"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Telerik" EnableVirtualScrolling="true"
                                    OnItemsRequested="cb_type_ref_ItemsRequested" OnPreRender="cb_type_ref_PreRender" OnSelectedIndexChanged="cb_type_ref_SelectedIndexChanged" >
                                </telerik:RadComboBox>
                              </td>
                           </tr>
                            <tr>
                                <td colspan="2">                            
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
                                    <telerik:RadLabel runat="server" Text="Storage :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
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
                            <tr>
                               <td colspan="2">
                                   <telerik:RadLabel runat="server" Text="MR No.:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                  <%-- <asp:RequiredFieldValidator runat="server" ID="mrCodeValidator" ControlToValidate="txt_mr_no" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />--%>
                                   <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>                                       
                                            <telerik:RadTextBox ID="txt_mr_no" runat="server" Width="300px" ReadOnly="false" RenderMode="Lightweight" Font-Size="Small"
                                                 Skin="Telerik">
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_type_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                               </td>
                           </tr>
                            <tr>
                               <td colspan="2">
                                   <telerik:RadLabel runat="server" Text="WO No.:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                   <%--<asp:RequiredFieldValidator runat="server" ID="woCodeValidator" ControlToValidate="txt_wo_no" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />--%>
                                   <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>                                       
                                            <telerik:RadTextBox ID="txt_wo_no" runat="server" Width="300px" ReadOnly="false" RenderMode="Lightweight" Font-Size="Small"
                                                 Skin="Telerik">
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_type_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
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
                                   <telerik:RadLabel runat="server" Text="Unit Code :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                   <%--<asp:RequiredFieldValidator runat="server" ID="unitCodeValidator" ControlToValidate="txt_unit_code" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />--%>
                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                    <ContentTemplate>
                                    <%--<telerik:RadTextBox ID="txt_unit_code" runat="server" Width="150px" ReadOnly="false" RenderMode="Lightweight" Font-Size="Small"
                                         Skin="Telerik">
                                    </telerik:RadTextBox>--%>
                                    <telerik:RadComboBox ID="cb_unit" runat="server" Width="150px" AutoPostBack="true" CausesValidation="false"
                                        DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" Font-Size="Small"
                                        OnItemsRequested="cb_unit_ItemsRequested" OnSelectedIndexChanged="cb_unit_SelectedIndexChanged"
                                        OnPreRender="cb_unit_PreRender">
                                            <HeaderTemplate>
                                                    <table style="width: 650px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 300px;">Unit Code
                                                            </td>
                                                            <td style="width: 350px;">Model No.
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 650px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 300px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                            </td>
                                                            <td style="width: 350px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.model_no")%>
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
                               <td>
                                   <telerik:RadLabel runat="server" Text="Model No:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                   <%--<asp:RequiredFieldValidator runat="server" ID="unitNameValidator" ControlToValidate="txt_unit_name" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />--%>
                                    <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadTextBox ID="txt_unit_name" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" Font-Size="Small"
                                        Skin="Telerik">
                                        </telerik:RadTextBox>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cb_unit" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                    </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                   <telerik:RadLabel runat="server" Text="HM :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                  <%-- <asp:RequiredFieldValidator runat="server" ID="hmValidator" ControlToValidate="txt_hm" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />--%>
                                    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadTextBox ID="txt_hm" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" Font-Size="Small"
                                           Skin="Telerik">
                                        </telerik:RadTextBox>
                                    </ContentTemplate>
                                    
                                    </asp:UpdatePanel>
                                </td>
                            </tr>                            
                            <tr>
                               <td colspan="2">
                                   <telerik:RadLabel runat="server" Text="Cost Center:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                   <asp:RequiredFieldValidator runat="server" ID="costCtrValidator" ControlToValidate="cb_cost_ctr" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Empty not allowed!" ></asp:RequiredFieldValidator><br />
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
                                        <asp:AsyncPostBackTrigger ControlID="cb_unit" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                     
                                </asp:UpdatePanel>
                               </td>                       
                           </tr>                                                      
                            <tr>
                                <td colspan="2" style="vertical-align: top; text-align: left">
                                    <telerik:RadLabel runat="server" Text="Order By :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                    <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                                    <ContentTemplate>
                                    <telerik:RadComboBox ID="cb_orderBy" runat="server" Width="300px"
                                        DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" Font-Size="Small"
                                        OnItemsRequested="cb_orderBy_ItemsRequested" OnSelectedIndexChanged="cb_orderBy_SelectedIndexChanged"
                                        OnPreRender="cb_orderBy_PreRender">
                                            <HeaderTemplate>
                                                    <table style="width: 650px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 300px;">Name
                                                            </td>
                                                            <td style="width: 350px;">Position
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 650px; font-size: smaller">
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
                                <td colspan="2" style="vertical-align: top; text-align: left; ">
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
                                <td colspan="2" style="vertical-align: top; text-align: left">
                                <telerik:RadLabel runat="server" Text="Received By :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                <ContentTemplate>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_received" runat="server" Width="300px"
                                        DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                        MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" Font-Size="Small"
                                        OnItemsRequested="cb_received_ItemsRequested" OnSelectedIndexChanged="cb_received_SelectedIndexChanged"
                                        OnPreRender="cb_received_PreRender">
                                        <HeaderTemplate>
                                            <table style="width: 650px; font-size: smaller">
                                                <tr>
                                                    <td style="width: 300px;">Name
                                                    </td>
                                                    <td style="width: 350px;">Position
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 650px; font-size: smaller">
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
                <tr>
                    <td  colspan="2">
                        <telerik:RadLabel runat="server" Text="Remark :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                        <ContentTemplate>
                            <telerik:RadTextBox ID="txt_remark"  Font-Size="Small"
                                runat="server" TextMode="MultiLine" Skin="Telerik"
                                Width="650px" Rows="0" Resize="None">
                            </telerik:RadTextBox>
                        </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>                   
               </table>
                
            </div>     

            <div style="padding: 5px 15px 5px 15px;">
                <table>
                    <tr>
                        <td style="width:20%;">
                            <telerik:RadToolTip ID="RadToolTip1" runat="server" TargetControlID="Image1" Width="280px" Height="200px" 
                                Position="MiddleRight" RelativeTo="Element" ShowEvent="OnMouseOver" HideDelay="10000" Font-Names="Century Gothic" ForeColor="#006600" >
                                <asp:UpdatePanel ID="Updatepanel12" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </telerik:RadToolTip>
                           
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/info.png" Height="20px" Width="22px" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:center">
                            <telerik:RadButton ID="btn_save" runat="server" Text="Save" CssClass="btn-wrapper" ForeColor="White"
                                OnClick="btnSave_Click" Skin="Material"></telerik:RadButton>
                        </td>
                        
                        
                    </tr>
                    <%--<tr>
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
                    </tr>--%>                   
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
