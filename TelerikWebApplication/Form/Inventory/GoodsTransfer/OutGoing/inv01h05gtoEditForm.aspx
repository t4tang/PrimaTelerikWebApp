<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h05gtoEditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.GoodsTransfer.OutGoing.inv01h05gtoEditForm" %>

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
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="cb_proj_from">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="cb_CostCtr" />
                        <telerik:AjaxUpdatedControl ControlID="cb_warehouse" />
                        <telerik:AjaxUpdatedControl ControlID="cb_expedition" />
                        <telerik:AjaxUpdatedControl ControlID="cb_ship" />
                        <telerik:AjaxUpdatedControl ControlID="txt_remark" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="cb_proj_to">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="cb_warehouse_to" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="1000" BackgroundPosition="None">
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
                                    <td style="vertical-align: top">
                                        <telerik:RadLabel runat="server" Text="Reg. No. :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                    <%--</td>
                                    <td >--%>
                                        
                                        <telerik:RadTextBox ID="txt_do_code" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" EmptyMessage="Let it blank">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Date* :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                    <%--</td>
                                    <td >--%>
                                        <telerik:RadDatePicker ID="dtp_do" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                            TabIndex="4" Skin="Telerik">
                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Telerik"
                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                        <telerik:RadLabel Text="Original" runat="server" Font-Bold="true"></telerik:RadLabel><br /> 
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <telerik:RadLabel runat="server" Text="Project Area:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_proj_from" ForeColor="Red" 
                                            Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_proj_from" runat="server" Width="300" DropDownWidth="300px"
                                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                    OnItemsRequested="cb_proj_from_ItemsRequested" OnSelectedIndexChanged="cb_proj_from_SelectedIndexChanged" Font-Size="Small"
                                                    OnPreRender="cb_proj_from_PreRender">
                                                </telerik:RadComboBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <telerik:RadLabel runat="server" Text="Cost Center:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        <asp:RequiredFieldValidator runat="server" ID="CostCenterValidator1" ControlToValidate="cb_CostCtr" ForeColor="Red" 
                                            Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_CostCtr" runat="server" Width="250px"
                                                    DropDownWidth="450px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                    MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" 
                                                    OnItemsRequested="cb_CostCtr_ItemsRequested" OnSelectedIndexChanged="cb_CostCtr_SelectedIndexChanged" 
                                                    OnPreRender="cb_CostCtr_PreRender">
                                                    <HeaderTemplate>
                                                        <table style="width: 450px; font-size: smaller">
                                                            <tr>
                                                                <td style="width: 100px;">Code</td>
                                                                <td style="width: 350px;">Name</td>
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
                                                <asp:AsyncPostBackTrigger ControlID="cb_proj_from" EventName="SelectedIndexChanged" />
                                            </Triggers>
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
                                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"
                                                    OnItemsRequested="cb_warehouse_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged" Font-Size="Small"
                                                    OnPreRender="cb_warehouse_PreRender" CausesValidation="false">
                                                </telerik:RadComboBox>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_proj_from" EventName="SelectedIndexChanged" />
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
                                        <telerik:RadLabel runat="server" Text="Expedition:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        <asp:RequiredFieldValidator runat="server" ID="ExpeditionValidator" ControlToValidate="cb_expedition" ForeColor="Red" 
                                            Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator>
                                        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_expedition" runat="server" Width="200px" AutoPostBack="true" CausesValidation="false"
                                                    DropDownWidth="300px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                    OnItemsRequested="cb_expedition_ItemsRequested" 
                                                    OnSelectedIndexChanged="cb_expedition_SelectedIndexChanged" 
                                                    OnPreRender="cb_expedition_PreRender"
                                                    MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true">
                                                </telerik:RadComboBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <telerik:RadLabel runat="server" Text="Ship Mode:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        <asp:RequiredFieldValidator runat="server" ID="ShipModeValidator" ControlToValidate="cb_ship" ForeColor="Red" 
                                            Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator>
                                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ship" runat="server" Width="200px" AutoPostBack="true" CausesValidation="false"
                                                    DropDownWidth="200px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                    MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true"
                                                    OnItemsRequested="cb_ship_ItemsRequested" OnSelectedIndexChanged="cb_ship_SelectedIndexChanged" OnPreRender="cb_ship_PreRender">
                                                </telerik:RadComboBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                        <telerik:RadLabel Text="Destination" runat="server" Font-Bold="true"></telerik:RadLabel><br /> 
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <telerik:RadLabel runat="server" Text="Project Area:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        <asp:RequiredFieldValidator runat="server" ID="ProjectDestiValidator" ControlToValidate="cb_proj_to" ForeColor="Red" 
                                            Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_proj_to" runat="server" Width="300" DropDownWidth="300px"
                                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                    OnItemsRequested="cb_proj_to_ItemsRequested" OnSelectedIndexChanged="cb_proj_to_SelectedIndexChanged" Font-Size="Small"
                                                    OnPreRender="cb_proj_to_PreRender">
                                                </telerik:RadComboBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <telerik:RadLabel runat="server" Text="Storage:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        <asp:RequiredFieldValidator runat="server" ID="WarehouseToValidator" ControlToValidate="cb_warehouse_to" ForeColor="Red" 
                                            Font-Size="X-Small" Text="Empty not allowed!"></asp:RequiredFieldValidator><br />
                                        <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse_to" runat="server" Width="300" DropDownWidth="300px"
                                                    AutoPostBack="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"
                                                    OnItemsRequested="cb_warehouse_to_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_to_SelectedIndexChanged" Font-Size="Small"
                                                    OnPreRender="cb_warehouse_to_PreRender">
                                                </telerik:RadComboBox>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_proj_to" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <telerik:RadLabel runat="server" Text="Remark:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                                        <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadTextBox ID="txt_remark"
                                                    runat="server" TextMode="MultiLine"
                                                    Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                                </telerik:RadTextBox>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_proj_from" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
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
                    <tr>
                        <td colspan="4">
                            <table>
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
                                                <asp:AsyncPostBackTrigger ControlID="cb_proj_from" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                    <td style="vertical-align: top; text-align: left; ">
                                        <telerik:RadLabel CssClass="lbObject" runat="server" Text="Send By:" ForeColor="Black"></telerik:RadLabel><br />
                                        <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_send_by" runat="server" Width="250px"
                                                    DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                    MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                    OnItemsRequested="cb_send_by_ItemsRequested"
                                                    OnSelectedIndexChanged="cb_send_by_SelectedIndexChanged" OnPreRender="cb_send_by_PreRender">
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
                                                <asp:AsyncPostBackTrigger ControlID="cb_proj_from" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                    <td style="vertical-align: top; text-align: left; ">
                                        <telerik:RadLabel CssClass="lbObject" runat="server" Text="Ack. By:" ForeColor="Black"></telerik:RadLabel><br />
                                        <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox ID="cb_ack_by" runat="server" Width="250px"
                                                    DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                    MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                                    OnItemsRequested="cb_ack_by_ItemsRequested"
                                                    OnSelectedIndexChanged="cb_ack_by_SelectedIndexChanged" OnPreRender="cb_ack_by_PreRender">
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
                                                <asp:AsyncPostBackTrigger ControlID="cb_proj_from" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 5px 15px 5px 15px;">
                <table>
                    <tr>
                        <td style="width:20%;">
                            <telerik:RadToolTip ID="RadToolTip1" runat="server" TargetControlID="Image1" Width="280px" Height="200px" 
                                Position="MiddleRight" RelativeTo="Element" ShowEvent="OnMouseOver" HideDelay="10000" Font-Names="Century Gothic" ForeColor="#006600">
                                <asp:UpdatePanel ID="Updatepanel12" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </telerik:RadToolTip>
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/info.png" Height="20px" Width="22px" />
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 5px 15px 5px 15px;">
                <table>
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
                    <tr>
                        <td style="text-align:center">
                            <telerik:RadButton ID="btn_save" runat="server" Text="Save" CssClass="btn-wrapper" ForeColor="White"
                                OnClick="btn_save_Click" Skin="Material"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
            <%--<div style="padding: 5px 15px 5px 15px;">
                <table>
                    
                </table>
            </div>--%>

        </div>

        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data telah disimpan" Position="Center" Skin="Windows7"
                    AutoCloseDelay="7000" Width="350" Height="110" Title="Congratulation" EnableRoundedCorners="true">
        </telerik:RadNotification>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>

    </form>
</body>
</html>
