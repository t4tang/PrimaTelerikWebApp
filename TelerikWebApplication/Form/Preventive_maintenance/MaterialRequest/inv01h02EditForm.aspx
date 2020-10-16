<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h02EditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.MaterialRequest.inv01h02EditForm" %>

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

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cb_project">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cb_warehouse"></telerik:AjaxUpdatedControl>
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
                                <td>
                                    <telerik:RadLabel runat="server" Text="MR Number" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_mr_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
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
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Project Area" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_Project" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
                                        EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="250" DropDownWidth="270px" 
                                        OnItemsRequested="cb_Project_ItemsRequested" 
                                        OnPreRender="cb_Project_PreRender" 
                                        OnSelectedIndexChanged="cb_Project_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_Project" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="WO. Number" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_wo" runat="server" RenderMode="Lightweight" Width="200px" AutoPostBack="true" CausesValidation="false"   
                                                DropDownWidth="1000px" EnableLoadOnDemand="true" MarkFirstMatch="true" Skin="Telerik" EnableVirtualScrolling="true" DataTextField="sro_code" DataValueField="sro_code"
                                                ShowMoreResultsBox="true"  
                                                OnItemsRequested="cb_wo_ItemsRequested" OnPreRender="cb_wo_PreRender"
                                                OnSelectedIndexChanged="cb_wo_SelectedIndexChanged">
                                                <HeaderTemplate>
                                                    <table style="width: 1000px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                Wo Number
                                                            </td>
                                                            <td style="width: 100px;">
                                                                Date
                                                            </td>
                                                            <td style="width: 100px;">
                                                                Unit Code 
                                                            </td>
                                                            <td style="width: 75px;">
                                                                Status
                                                            </td>
                                                            <td style="width: 100px;">
                                                                B/D Date
                                                            </td>
                                                            <td style="width: 75px;">
                                                                B/D Time
                                                            </td> 
                                                            <td style="width: 150px;">
                                                                Order Type
                                                            </td> 
                                                            <td style="width: 250px;">
                                                                Problem
                                                            </td>                                            
                                                        </tr>
                                                    </table
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 1000px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.trans_id")%>
                                                            </td>
                                                            <td style="width: 100px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.trans_date")%>
                                                            </td>
                                                            <td style="width: 100px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                            </td>
                                                            <td style="width: 75px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.unitstatus")%>
                                                            </td>
                                                            <td style="width: 100px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.DBDate")%>
                                                            </td>
                                                            <td style="width: 75px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.BDTime")%>
                                                            </td>
                                                            <td style="width: 150px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.OrderName")%>
                                                            </td>
                                                            <td style="width: 250px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.remark")%>
                                                            </td>                                                                                                                                                        
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                </FooterTemplate>
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_wo" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Unit Code" CssClass="lbObject"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_unit" runat="server" RenderMode="Lightweight" Width="150px" Skin="Telerik"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_date" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="MetroTouch">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                             FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Delivery Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_deliv" runat="server" RenderMode="Lightweight" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="MetroTouch">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                             FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Priority" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_priority" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
                                        EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="150" DropDownWidth="150px" 
                                        OnItemsRequested="cb_priority_ItemsRequested" 
                                        OnPreRender="cb_priority_PreRender" 
                                        OnSelectedIndexChanged="cb_priority_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_priority" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align: top; padding-left:15px">
                        <table id="Table3" border="0" class="module">
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Order Type" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_Order" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true"  CausesValidation="false"
                                        EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="150" DropDownWidth="150px" 
                                        OnItemsRequested="cb_Order_ItemsRequested" 
                                        OnPreRender="cb_Order_PreRender" 
                                        OnSelectedIndexChanged="cb_Order_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="cb_Order" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Job Type" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_job" runat="server" RenderMode="Lightweight" Skin="Telerik" EnableLoadOnDemand="true" CausesValidation="false" 
                                        EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" Width="150" DropDownWidth="150px" 
                                        OnItemsRequested="cb_job_ItemsRequested" 
                                        OnPreRender="cb_job_PreRender" 
                                        OnSelectedIndexChanged="cb_job_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="cb_job" ForeColor="Red" 
                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Ordered By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_ordered" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                                AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                                HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                OnItemsRequested="cb_ordered_ItemsRequested" 
                                                OnPreRender="cb_ordered_PreRender" 
                                                OnSelectedIndexChanged="cb_ordered_SelectedIndexChanged">
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
                                    <telerik:RadLabel runat="server" Text="Checked By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_checked" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                                AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                                HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                OnItemsRequested="cb_checked_ItemsRequested" 
                                                OnPreRender="cb_checked_PreRender" 
                                                OnSelectedIndexChanged="cb_checked_SelectedIndexChanged">
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
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Acknowledged By" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="cb_ack" runat="server" RenderMode="Lightweight" Width="250px" DropDownWidth="650px"
                                                AutoPostBack="false" ShowMoreResultsBox="true" Skin="Telerik" EnableLoadOnDemand="true" 
                                                HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                                OnItemsRequested="cb_ack_ItemsRequested" 
                                                OnPreRender="cb_ack_PreRender" 
                                                OnSelectedIndexChanged="cb_ack_SelectedIndexChanged">
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
                                <td class="tdLabel">
                                    <telerik:RadLabel runat="server" Text="Remark" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>                
                                <td style="vertical-align:top; text-align:left">                               
                                    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_remark" runat="server" TextMode="MultiLine"
                                                Width="350px" Rows="0" TabIndex="5" Resize="Both" Skin="Telerik">
                                            </telerik:RadTextBox>
                                            &nbsp
                                            <telerik:RadLabel runat="server" Text="Close" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                            <asp:CheckBox runat="server" Checked="false" ID="chk_close" />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>                                  
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>

        <div style="padding: 5px 15px 15px 15px; border-bottom-style:double; border-bottom-width: 1px; border-bottom-color:deeppink; ">
            <asp:UpdatePanel runat="server" ID="UpdatePanel5">
                <ContentTemplate>
                    <telerik:RadGrid ID="RadGrid2" runat="server" RenderMode="Lightweight" AllowPaging="true" AllowSorting="true" 
                        AllowAutomaticDeletes="true" AllowAutomaticInserts="true" AutoGenerateColumns="false" Skin="Telerik" ShowStatusBar="true" 
                        OnNeedDataSource="RadGrid2_NeedDataSource" 
                        OnDeleteCommand="RadGrid2_DeleteCommand">
                        <PagerStyle Mode="NumericPages" PageButtonCount="4" />
                        <MasterTableView CommandItemDisplay="None"  DataKeyNames="chart_code" Font-Size="11px" EditMode="Batch"
                            AllowAutomaticUpdates="true" AllowAutomaticInserts="true" AllowAutomaticDeletes="true"
                            ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item" 
                            CommandItemSettings-ShowRefreshButton="False" ItemStyle-ForeColor="#006600">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Opr. Code" HeaderStyle-Width="150px" ItemStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" 
                                    HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                    <ItemTemplate>
                                        <telerik:RadTextBox runat="server" ID="txt_OprCode" ReadOnly="true" BorderStyle="None" Width="150px" 
                                            Text='<%# DataBinder.Eval(Container, "DataItem.chart_code") %>'>
                                        </telerik:RadTextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Maintenance Operation" HeaderStyle-Width="250px" ItemStyle-Width="250px" ItemStyle-HorizontalAlign="Center" 
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblMainOpr" Text='<%# DataBinder.Eval(Container.DataItem, "OprName") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Material" HeaderStyle-Width="150px" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" 
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblMaterial" Text='<%# DataBinder.Eval(Container.DataItem, "wh_code") %>'></asp:Label>
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
                    <td style="padding: 0px 10px 0px 10px">
                        <telerik:RadLabel runat="server" ID="lbl_Printed" Width="100px" Text="Printed: " CssClass="lbObject" Font-Size="Small"/>
                    </td>                    
                    <td style="padding-top:0px; text-align:left">
                        <telerik:RadButton ID="btn_save" runat="server" Text="Save" CssClass="btn-wrapper" ForeColor="White" OnClick="btn_save_Click"
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
