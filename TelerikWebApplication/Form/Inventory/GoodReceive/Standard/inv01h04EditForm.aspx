<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h04EditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.GoodReceive.Standard.inv01h04EditForm" %>

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
   <style type="text/css">
       .lbObject
         {
             color:teal;
             font-size:12px;
             font-weight:normal;
             font-family: Segoe UI, Tahoma, Geneva, 'Verdana', sans-serif;         
         }

       .lblEditInfo
       {
         font-size:11px;
         color:black;
         font-style:italic;
         /*background-color:greenyellow;*/
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
    <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
    <div>
            <div style="padding: 15px 15px 10px 15px;" class="lbObject">
                <table id="Table2" width="Auto" border="0" class="module">
                <tr>
                    <td style="vertical-align:top; width:auto">
                        <table>
                            <tr>
                                <td colspan="2" style="padding:0px 0px 5px 5px">
                                    <%--<telerik:RadButton ID="btn_save" runat="server" Text="Save" BackColor="#ff6600" ForeColor="White" Width="80px" Height="28px"
                                    OnClick="btnSave_Click" Skin="Material"></telerik:RadButton>--%>
                                    <asp:ImageButton runat="server" ID="btnSave" AlternateText="New" OnClick="btnSave_Click" ToolTip="Save" Visible="true"
                                    Height="30px" Width="32px" ImageUrl="~/Images/simpan.png"></asp:ImageButton>
                                </td>
                            </tr>
                            <tr style="vertical-align: top; width:auto">                               
                                <td  style="vertical-align: top">
                                    <telerik:RadLabel runat="server" Text="GR Number:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>                                  
                                    <telerik:RadTextBox ID="txt_gr_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                       Skin="Telerik"  EmptyMessage="Let it blank">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr style="vertical-align: top">                               
                                <td  style="vertical-align: top">
                                    <telerik:RadLabel runat="server" Text="From:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>                          
                                    <telerik:RadComboBox ID="cb_from" runat="server" Width="150" EnableLoadOnDemand="True" ShowMoreResultsBox="false"
                                        Skin="Telerik" EnableVirtualScrolling="true" OnItemsRequested="cb_from_ItemsRequested"
                                        OnSelectedIndexChanged="cb_from_SelectedIndexChanged" OnPreRender="cb_from_PreRender">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                               <td >
                                  <telerik:RadLabel runat="server" Text="GR Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                               </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_gr" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="Telerik"> 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="MetroTouch" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                    </telerik:RadDatePicker>
                                </td>
                           </tr>
                            <tr>
                                <td>                            
                                    <telerik:RadLabel runat="server" Text="Project Area:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td >
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="250px" DropDownWidth="250px"
                                                AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                                OnPreRender="cb_project_PreRender">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_project" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>                             
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                           </tr>                            
                            <tr>
                               <td>
                                   <telerik:RadLabel runat="server" Text="Supplier:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                              </td>
                                <td style="width:310px">  
                                     <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                        <ContentTemplate>
                                         <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="250px" DropDownWidth="250px"
                                            AutoPostBack="true" CausesValidation="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"  
                                            OnItemsRequested="cb_supplier_ItemsRequested" OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged" OnPreRender="cb_supplier_PreRender">
                                        </telerik:RadComboBox>                                   
                                        <asp:RequiredFieldValidator runat="server" ID="supplierValidator" ControlToValidate="cb_supplier" ForeColor="Red" 
                                       Font-Size="X-Small"  Text="Required!" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                           </tr>
                        </table>
                    </td>
                    <td style="vertical-align:top; width:auto">
                        <table>
                            
                            <tr>
                               <td style="width:auto">
                                   <telerik:RadLabel runat="server" Text="PO Refference:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                               </td>
                                <td style="width:280px">
                                   <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ref" runat="server" Width="200px" AutoPostBack="true" CausesValidation="false"
                                                DropDownWidth="900px" EnableLoadOnDemand="True" HighlightTemplatedItems="true"
                                                MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="sro_code" DataValueField="sro_code"
                                                OnItemsRequested="cb_ref_ItemsRequested" OnSelectedIndexChanged="cb_ref_SelectedIndexChanged">
                                                <HeaderTemplate>
                                                    <table style="width: 900px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 100px; font-variant:small-caps; color: #3399FF;">PO NUMBER.
                                                            </td>
                                                            <td style="width: 75px;font-variant:small-caps; color: #3399FF;">PO DATE
                                                            </td>
                                                            <td style="width: 700px;font-variant:small-caps; color: #3399FF;">Remark
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 900px; font-size: smaller">
                                                        <tr>
                                                            <td style="width: 100px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.po_code")%>
                                                            </td>
                                                            <td style="width: 75px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.Po_date")%>
                                                            </td>
                                                            <td style="width: 700px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.remark")%>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                </FooterTemplate>
                                            </telerik:RadComboBox>
                                           <asp:RequiredFieldValidator runat="server" ID="reffCodeValidator" ControlToValidate="cb_ref" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                           </tr>
                            <tr>
                                <td >
                                    <telerik:RadLabel runat="server" Text="PO Date:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                               </td> 
                                <td>
                                   <asp:UpdatePanel ID="UpdatePanel8" runat="server">                                        
                                        <ContentTemplate>
                                           <telerik:RadTextBox ID="txt_reff_date" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight"
                                                AutoPostBack="false">
                                            </telerik:RadTextBox>
                                            <asp:RequiredFieldValidator runat="server" ID="reffDateValidator" ControlToValidate="txt_reff_date" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!" ></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                   <telerik:RadLabel runat="server" Text="Cost Center:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadComboBox ID="cb_costcenter" runat="server" Width="150px"
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
                                        <asp:RequiredFieldValidator runat="server" ID="cost_ctr_Validator" ControlToValidate="cb_costcenter" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>
                                    </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_ref" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <telerik:RadLabel runat="server" Text="Storage:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_warehouse" runat="server" Width="150" DropDownWidth="300px"
                                                AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" Font-Size="Small"
                                                OnItemsRequested="cb_warehouse_ItemsRequested" OnSelectedIndexChanged="cb_warehouse_SelectedIndexChanged" 
                                                OnPreRender="cb_warehouse_PreRender">
                                            </telerik:RadComboBox>                                             
                                            <asp:RequiredFieldValidator runat="server" ID="warehouseValidator" ControlToValidate="cb_warehouse" ForeColor="Red" 
                                                    Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr> 
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Delivery Note:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_delivery_note" runat="server" Width="300px" Enabled="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>                            
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Remark:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td style="width:350px">
                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_remark"
                                                runat="server" TextMode="MultiLine"
                                                Width="300px" Rows="0" TabIndex="5" Resize="Both">
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
                    <td style="vertical-align:top; width:auto">
                        <table>
                                          
                            <tr>
                                <td style="vertical-align: top; text-align: left">
                                    <telerik:RadLabel runat="server" Text="Created By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                                    <ContentTemplate>
                                    <telerik:RadComboBox ID="cb_createdBy" runat="server" Width="250px"
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
                                    <telerik:RadLabel runat="server" Text="Received By:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>  
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                    <ContentTemplate>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_received" runat="server" Width="250px"
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
                                    <telerik:RadLabel CssClass="lbObject" runat="server" Text="Approved By:" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
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
                            <tr>
                                <td colspan="2" style="vertical-align:central">
                                    <asp:CheckBox ID="chk_posting" runat="server" Checked="false" Text="Posting" Enabled="false" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding-top:15px"> 
                                    <telerik:RadLabel runat="server" ID="lbl_userId" Width="100px" Text="User: " CssClass="lblEditInfo" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadLabel runat="server" ID="lbl_lastUpdate" Width="220px" Text="Last Update: " CssClass="lblEditInfo"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"> 
                                    <telerik:RadLabel runat="server" ID="lbl_Owner" Width="100px" Text="Owner: " CssClass="lblEditInfo"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadLabel runat="server" ID="lbl_edited" Width="100px" Text="Edited: " CssClass="lblEditInfo"/>
                                </td>
                            </tr>        
                        </table>
                    </td>
                </tr>                  
               </table>
            </div>            
            
            <div style="padding: 5px 15px 15px 15px; height:360px">
            <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="98.5%" 
            SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Telerik" CausesValidation="false">
                <Tabs>
                    <telerik:RadTab Text="Detail" Height="10px" >
                    </telerik:RadTab>
                    <telerik:RadTab Text="Journal" Height="10px"> 
                    </telerik:RadTab>            
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage runat="server" SelectedIndex="0" ID="RadMultiPage1" >
                <telerik:RadPageView runat="server" ID="PageView1" Height="350px">
                 <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Always">
                      <ContentTemplate>
                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" PageSize="10" runat="server" Skin="Telerik"
                                HeaderStyle-Font-Size="Small" HeaderStyle-Font-Bold="true" ItemStyle-Font-Size="small" Font-Size="Small"
                                Font-Names="Segoe UI" CellSpacing="0" 
                                OnNeedDataSource="RadGrid2_NeedDataSource"
                                OnPreRender="RadGrid2_PreRender" 
                                OnDeleteCommand="RadGrid2_DeleteCommand">
                                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="Prod_code" Font-Size="11px" EditMode="Batch"
                                  AllowAutomaticUpdates="true" AllowAutomaticInserts="true" AllowAutomaticDeletes="true" HeaderStyle-Font-Bold="false"
                                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item" 
                                CommandItemSettings-ShowRefreshButton="False" ItemStyle-ForeColor="#006600">
                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="False" ShowCancelChangesButton="false" />
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Type" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Center" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblProdType" Width="40px" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>                                           
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="150px" ItemStyle-Width="150px"
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblProdCode" Width="150px" Text='<%# DataBinder.Eval(Container.DataItem, "Prod_code") %>'></asp:Label>
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>
                                                                                
                                        <telerik:GridTemplateColumn HeaderText="Location" HeaderStyle-Width="100px" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Left"
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <%--<telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtLocation" Width="100px"  ReadOnly="true" 
                                                    EnabledStyle-HorizontalAlign="Left" Text='<%# DataBinder.Eval(Container.DataItem, "KoLok") %>'>
                                                </telerik:RadTextBox>--%>
                                                <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cbKolok" Width="100px" Skin="Telerik"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "KoLok") %>'
                                                    EnableLoadOnDemand="True" EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"  
                                                    DataTextField="kolok" DataValueField="kolok" OnItemsRequested="cbKolok_ItemsRequested">
                                                </telerik:RadComboBox>
                                            </ItemTemplate>                                            
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Order Qty" HeaderStyle-Width="80px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="80px"  ReadOnly="false" 
                                                    EnabledStyle-HorizontalAlign="Right"
                                                    NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "qty_Sisa", "{0:#,###,###0.00}") %>'
                                                    onkeydown="blurTextBox(this, event)"
                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                    NumberFormat-DecimalDigits="2">
                                                </telerik:RadTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                       <%-- <telerik:GridTemplateColumn HeaderText="PO Qty" HeaderStyle-Width="70px" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblQtyPo" Text='<%# DataBinder.Eval(Container.DataItem, "qtypo", "{0:#,###,###0.00}") %>'></asp:Label>
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>--%>

                                        <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="50px" ItemStyle-Width="50px" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblUom" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>' ></asp:Label>
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Cost Center" HeaderStyle-Width="100px" ItemStyle-Width="100px" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblCostCtr" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                            
                                        <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="300px" HeaderStyle-Width="300px" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="300px"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>'>
                                                </telerik:RadTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Ctrl. No" HeaderStyle-Width="130px" ItemStyle-Width="130px" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblRS" Text='<%# DataBinder.Eval(Container.DataItem, "nocontr") %>' Width="130px"></asp:Label>
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Warranty" HeaderStyle-Width="50px" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center"
                                             HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkWarranty" Width="50px" Checked='<%# DataBinder.Eval(Container.DataItem, "twarranty") %>' />
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ConfirmTitle="Delete" ConfirmDialogType="RadWindow"
                                            ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-ForeColor="Red">
                                        </telerik:GridButtonColumn>

                                    </Columns>
                                </MasterTableView>  
                                <ClientSettings>
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="310px" />
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
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView1" Height="350px">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid3" GridLines="None" PageSize="10" runat="server" Skin="Telerik"  
                        HeaderStyle-Font-Size="Small" HeaderStyle-Font-Bold="true" ItemStyle-Font-Size="small" Font-Size="Small"
                        Font-Names="Segoe UI" CellSpacing="0" 
                        OnNeedDataSource="RadGrid3_NeedDataSource" 
                        OnPreRender="RadGrid3_PreRender">
                        <MasterTableView DataKeyNames="nomor" HeaderStyle-ForeColor="Teal"
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
                                    HeaderStyle-BackColor="#00ABE3" >                                
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="accountname" HeaderStyle-Width="250px" HeaderText="Account Name" SortExpression="accountname"
                                    UniqueName="accountname" ReadOnly="true" HeaderStyle-HorizontalAlign="Center"
                                    HeaderStyle-BackColor="#00ABE3" >                                
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="debet" HeaderStyle-Width="100px" HeaderText="Debet" SortExpression="debet"
                                    UniqueName="debet" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#00ABE3" 
                                    DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#00CC00">                                
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="credit" HeaderStyle-Width="100px" HeaderText="Credit" SortExpression="credit"
                                    UniqueName="credit" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#00ABE3" 
                                    DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" ItemStyle-ForeColor="#FF6600">                                
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="remark" HeaderStyle-Width="200px" HeaderText="Remark" SortExpression="remark"
                                    UniqueName="remark" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#00ABE3" >
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                        <ClientSettings AllowKeyboardNavigation="true">
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="310px" />
                            <Selecting AllowRowSelect="true"></Selecting>     
                        </ClientSettings>
                    </telerik:RadGrid>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
            </div>

            <%--<div style="padding: 5px 15px 5px 15px;" runat="server" >
                <table>
                    <tr>
                        <td style="padding: 0px 10px 0px 10px" > 
                            <telerik:RadLabel runat="server" ID="lbl_userId" Width="100px" Text="User: " CssClass="lblEditInfo" />
                        </td>
                        <td style="width: 240px; padding-left: 5px">
                            <telerik:RadLabel runat="server" ID="lbl_lastUpdate" Width="220px" Text="Last Update: " CssClass="lblEditInfo"/>
                        </td>
                        <td style="padding: 0px 10px 0px 10px"> 
                            <telerik:RadLabel runat="server" ID="lbl_Owner" Width="100px" Text="Owner: " CssClass="lblEditInfo"/>
                        </td>
                        <td style="padding: 0px 10px 0px 10px">
                            <telerik:RadLabel runat="server" ID="lbl_edited" Width="100px" Text="Edited: " CssClass="lblEditInfo"/>
                        </td>
                        <td  style="padding-top:0px; text-align:left">
                            
                        </td>
                    </tr>                   
                </table>
            </div>--%>
            
    </div>
        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data telah disimpan" Position="Center" Skin="Windows7"
                    AutoCloseDelay="7000" Width="350" Height="110" Title="Congrotulation" EnableRoundedCorners="true">
        </telerik:RadNotification>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
        
    </form>
</body>
</html>
