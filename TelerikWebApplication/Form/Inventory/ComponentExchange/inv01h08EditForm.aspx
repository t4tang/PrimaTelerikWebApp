<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h08EditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.ComponentExchange.inv01h08EditForm" %>

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
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="1000" BackgroundPosition="None" >
    <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
    
        <div>
            <div style="padding: 15px 15px 10px 15px;" class="lbObject">
                <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"
                    SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Telerik">
                    <Tabs>
                        <telerik:RadTab Text="Entry" Height="15px" Selected="true"> 
                        </telerik:RadTab>
                        <telerik:RadTab Text="Detail" Height="15px">
                        </telerik:RadTab>                
                    </Tabs>
                </telerik:RadTabStrip>

                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <telerik:RadMultiPage runat="server" ID="RadMultiPage1" Height="600px">
                            <telerik:RadPageView runat="server" ID="EntryPage" Selected="true">
                                <div style="padding: 15px 15px 10px 20px;" class="lbObject">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" Text="Reg. Number" CssClass="lbObject"></asp:Label>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox runat="server" ID="txt_RegNo" Width="150px" Skin="Telerik" RenderMode="Lightweight" ReadOnly="true" EmptyMessage="Let it Blank">
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
                                                <asp:Label runat="server" Text="Date" CssClass="lbObject" ForeColor="Black"></asp:Label>
                                            </td>
                                            <td>
                                                <telerik:RadDatePicker runat="server" ID="dtp_date" RenderMode="Lightweight" MinDate="1/1/1900" Skin="MetroTouch" TabIndex="4">
                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                                        FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik">
                                                    </Calendar>
                                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                <asp:Label runat="server" Text="Job Start" CssClass="lbObject" ForeColor="Black"></asp:Label>
                                            </td>
                                            <td>
                                                <telerik:RadDatePicker runat="server" ID="dtp_StartDate" RenderMode="Lightweight" MinDate="1/1/1900" Skin="MetroTouch" TabIndex="4">
                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                                        FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik">
                                                    </Calendar>
                                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                <asp:Label runat="server" Text="Job Finish" CssClass="lbObject" ForeColor="Black"></asp:Label>
                                            </td>
                                            <td>
                                                <telerik:RadDatePicker runat="server" ID="dtp_FinishDate" RenderMode="Lightweight" MinDate="1/1/1900" Skin="MetroTouch" TabIndex="4">
                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                                        FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik">
                                                    </Calendar>
                                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                <asp:Label runat="server" Text="Ref. No" CssClass="lbObject"></asp:Label>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox runat="server" ID="txt_RefNo" RenderMode="Lightweight" Skin="Telerik" Width="150px">
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
                                                <asp:Label runat="server" CssClass="lbObject" Text="Work Desc"></asp:Label>
                                            </td>
                                            <td>
                                                <telerik:RadTextBox runat="server" ID="txt_WorkDesc" RenderMode="Lightweight" Skin="Telerik" Width="350px">
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
                                                <asp:Label runat="server" Text="Job Status" CssClass="lbObject"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox runat="server" ID="cb_JobStatus" RenderMode="Lightweight" Skin="Telerik" 
                                                            EnableLoadOnDemand="true" EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" 
                                                            AutoPostBack="true" Width="100" DropDownWidth="120px" CausesValidation="false" 
                                                            OnItemsRequested="cb_JobStatus_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_JobStatus_SelectedIndexChanged" 
                                                            OnPreRender="cb_JobStatus_PreRender">
                                                        </telerik:RadComboBox>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                <asp:Label runat="server" Text="Responsible" CssClass="lbObject"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:UpdatePanel runat="server" ID="UpdatePanel3">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox runat="server" ID="cb_Responsible" RenderMode="Lightweight" Skin="Telerik" 
                                                            EnableLoadOnDemand="true" EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" 
                                                            AutoPostBack="true" Width="150" DropDownWidth="350px" CausesValidation="false" 
                                                            OnItemsRequested="cb_Responsible_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_Responsible_SelectedIndexChanged" 
                                                            OnPreRender="cb_Responsible_PreRender">
                                                        </telerik:RadComboBox>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                <asp:Label runat="server" Text="Project Area" CssClass="lbObject"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:UpdatePanel runat="server" ID="UpdatePanel4">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox runat="server" ID="cb_Project" RenderMode="Lightweight" Skin="Telerik" 
                                                            EnableLoadOnDemand="true" EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" 
                                                            AutoPostBack="true" Width="150" DropDownWidth="170px" CausesValidation="false" 
                                                            OnItemsRequested="cb_Project_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_Project_SelectedIndexChanged" 
                                                            OnPreRender="cb_Project_PreRender">
                                                        </telerik:RadComboBox>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdLabel">
                                                <asp:Label runat="server" Text="Cost Center" CssClass="lbObject"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                                                    <ContentTemplate>
                                                        <telerik:RadComboBox runat="server" ID="cb_CostCenter" RenderMode="Lightweight" Skin="Telerik" 
                                                            EnableLoadOnDemand="true" EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" 
                                                            AutoPostBack="true" Width="250" DropDownWidth="350px" CausesValidation="false" 
                                                            OnItemsRequested="cb_CostCenter_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_CostCenter_SelectedIndexChanged" 
                                                            OnPreRender="cb_CostCenter_PreRender">
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
                                                    OnClick="btn_save_Click" Skin="Material"></telerik:RadButton>
                                            </td>    
                                        </tr>
                                    </table>
                                </div>
                            </telerik:RadPageView>

                             <telerik:RadPageView runat="server" ID="DetailPage" Enabled="False">
                                 <div style="padding: 15px 15px 10px 20px;" class="lbObject">
                                     <div style=" width:100%; border-top-color: #336600;  height:170px; padding-top: 20px;">
                                         <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" GridLines="None" AutoGenerateColumns="false" PageSize="3"  Skin="Telerik"
                                             AllowPaging="true" AllowSorting="true" runat="server" ClientSettings-Selecting-AllowRowSelect="true" 
                                             AllowAutomaticDeletes="True" AllowAutomaticInserts="True"  Width="450px" ClientSettings-EnablePostBackOnRowClick="true"
                                             OnNeedDataSource="RadGrid1_NeedDataSource"
                                             OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged"
                                             OnPreRender="RadGrid1_PreRender"
                                             ShowStatusBar="true">
                                             <PagerStyle Mode="NumericPages" PageButtonCount="4" />
                                             <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                                             <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                                             <MasterTableView CommandItemDisplay="None" DataKeyNames="prod_code" Font-Size="11px" EditMode="InPlace"
                                                 ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item">
                                                 <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                                                 <Columns>
                                                     <telerik:GridClientSelectColumn UniqueName="SelectColumn" ItemStyle-Width="30px"></telerik:GridClientSelectColumn>
                                                     <telerik:GridBoundColumn UniqueName="prod_code" HeaderText="Material Code" DataField="prod_code">
                                                         <HeaderStyle Width="100px"></HeaderStyle>
                                                         <ItemStyle Width="100px" />
                                                     </telerik:GridBoundColumn>
                                                     <telerik:GridBoundColumn UniqueName="spec" HeaderText="Spec" DataField="spec">
                                                         <HeaderStyle Width="100px"></HeaderStyle>
                                                         <ItemStyle Width="100px" />
                                                     </telerik:GridBoundColumn>
                                                     <telerik:GridBoundColumn UniqueName="qty" HeaderText="QTY" DataField="qty">
                                                         <HeaderStyle Width="100px"></HeaderStyle>
                                                         <ItemStyle Width="100px" />
                                                     </telerik:GridBoundColumn>
                                                     <telerik:GridBoundColumn UniqueName="SatQty" HeaderText="UoM" DataField="SatQty">
                                                         <HeaderStyle Width="100px"></HeaderStyle>
                                                         <ItemStyle Width="100px" />
                                                     </telerik:GridBoundColumn>
                                                 </Columns>
                                             </MasterTableView>
                                         </telerik:RadGrid>
                                     </div>

                                     <div style=" width:100%; border-top-color:coral; border-top-style:solid; border-top-width:1px; padding-top:5px;">
                                         <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"  Skin="Telerik"
                                            AllowPaging="true" AllowSorting="true" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" ShowStatusBar="true" 
                                            OnNeedDataSource="RadGrid2_NeedDataSource"
                                            OnDeleteCommand="RadGrid2_DeleteCommand" 
                                            OnInsertCommand="RadGrid2_SaveHandler" 
                                            OnUpdateCommand="RadGrid2_SaveHandler" >
                                             <PagerStyle Mode="NumericPages" PageButtonCount="4" />
                                             <HeaderStyle CssClass="gridHeader" BackColor="YellowGreen" />
                                             <MasterTableView CommandItemDisplay="Top" DataKeyNames="prod_code" Font-Size="11px" EditMode="InPlace"
                                                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="Insert">
                                                 <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />
                                                 <Columns>
                                                    <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"  HeaderStyle-ForeColor="#009900" 
                                                        HeaderText="Edit" HeaderStyle-Width="30px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                                    </telerik:GridEditCommandColumn>
                                                    <telerik:GridTemplateColumn UniqueName="prod_code" HeaderText="Material Code" HeaderStyle-Width="120px" SortExpression="jobno" ItemStyle-Width="120px">
                                                        <FooterTemplate>Template footer</FooterTemplate>
                                                        <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lbl_prod_code" Text='<%#DataBinder.Eval(Container.DataItem, "prod_code")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cb_ProdCode_EditFormD" EnableLoadOnDemand="true" DataTextField="spec" 
                                                                DataValueField="prod_code" AutoPostBack="true" Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>' EmptyMessage="- Select Material -" 
                                                                HighlightTemplatedItems="true" Width="150px" DropDownWidth="650px" DropDownAutoWidth="Enabled" 
                                                                OnItemsRequested="cb_ProdCode_EditFormD_ItemsRequested" OnSelectedIndexChanged="cb_ProdCode_EditFormD_SelectedIndexChanged"
                                                                OnPreRender="cb_ProdCode_EditFormD_PreRender">
                                                                <HeaderTemplate>
                                                                    <table style="width: 650px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 150px;">
                                                                                Material Code
                                                                            </td>     
                                                                            <td style="width: 250px;">
                                                                                Specification
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                UoM 
                                                                            </td>     
                                                                            <td style="width: 200px;">
                                                                                StMain
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table style="width: 650px; font-size:smaller">
                                                                        <tr>
                                                                            <td style="width: 150px;">
                                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                                            </td>     
                                                                            <td style="width: 250px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['spec']")%>
                                                                            </td>
                                                                            <td style="width: 50px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['UoM']")%> 
                                                                            </td>     
                                                                            <td style="width: 200px;">
                                                                                <%# DataBinder.Eval(Container, "Attributes['StMain']")%>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Qty Plan" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900" 
                                                        HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:Label RenderMode="Lightweight" runat="server" ID="lblQtyPlan" Width="70px"  ReadOnly="False" EnabledStyle-HorizontalAlign="Right" 
                                                                NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                                Text='<%# DataBinder.Eval(Container.DataItem, "qty", "{0:#,###,###0.00}") %>'
                                                                onkeydown="blurTextBox(this, event)" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" ForeColor="#006600">
                                                            </asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_QtyPlan" Width="70px"  ReadOnly="False" EnabledStyle-HorizontalAlign="Right" 
                                                                NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                                Text='<%# DataBinder.Eval(Container.DataItem, "qty", "{0:#,###,###0.00}") %>'
                                                                onkeydown="blurTextBox(this, event)" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" ForeColor="#006600">
                                                            </telerik:RadTextBox>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Qty GR" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900" 
                                                        HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:Label RenderMode="Lightweight" runat="server" ID="lblQtyGR" Width="70px"  ReadOnly="False" EnabledStyle-HorizontalAlign="Right" 
                                                                NumberFormat-AllowRounding="true" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" 
                                                                onkeydown="blurTextBox(this, event)" AutoPostBack="true" MaxLength="11" Type="Number" NumberFormat-DecimalDigits="2" ForeColor="#006600">
                                                            </asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="70px" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="#009900" 
                                                        HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lbl_uom" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cb_Uom" EnableLoadOnDemand="true" AutoPostBack="true" HighlightTemplatedItems="true" 
                                                                Width="70px" DropDownWidth="130px" DropDownAutoWidth="Enabled" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>' 
                                                                OnItemsRequested="cb_Uom_ItemsRequested" OnSelectedIndexChanged="cb_Uom_SelectedIndexChanged" OnPreRender="cb_Uom_PreRender">
                                                            </telerik:RadComboBox> 
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Remark" HeaderStyle-Width="350px" ItemStyle-Width="350px" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="350px" BorderStyle="None" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                                            </telerik:RadTextBox>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" HeaderStyle-ForeColor="#009900" ConfirmTitle="Delete" 
                                                        ConfirmDialogType="RadWindow" ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                                                    </telerik:GridButtonColumn>
                                                 </Columns>
                                             </MasterTableView>
                                         </telerik:RadGrid>
                                     </div>
                                 </div>
                             </telerik:RadPageView>

                        </telerik:RadMultiPage>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btn_save" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>  
        </div>

    <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data tersimpan" Position="Center" Skin="Windows7"
        AutoCloseDelay="7000" Width="350" Height="110" Title="Current time" EnableRoundedCorners="true">
    </telerik:RadNotification>
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
    </telerik:RadWindowManager>

    </form>
</body>
</html>
