<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mtc01h02EditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.MechanicActivity.mtc01h02EditForm" %>


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
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cb_project">
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
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" Text="Reg. Number"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox runat="server" RenderMode="Lightweight" ID="txt_ma_number" ReadOnly="true" Skin="Telerik" EmptyMessage="Let it blank" Width="150px">
                                            <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                            <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                            <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                            <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                            <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" Text="Project Area"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cb_project" Skin="Telerik" EnableLoadOnDemand="true" EnableVirtualScrolling="true" 
                                            MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="true" CausesValidation="false" Width="250" DropDownWidth="270px" 
                                            OnItemsRequested="cb_project_ItemsRequested" 
                                            OnPreRender="cb_project_PreRender" 
                                            OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                            >                                           
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_Project" ForeColor="Red" Font-Size="X-Small" 
                                            Text="Required!" CssClass="required_validator">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadLabel runat="server" RenderMode="Lightweight" CssClass="lbObject" Text="Employee" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td style="vertical-align:top; text-align:left">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cb_employee" Skin="Telerik" EnableLoadOnDemand="true" 
                                                    EnableVirtualScrolling="true" MarkFirstMatch="true" ShowMoreResultsBox="true" AutoPostBack="false" HighlightTemplatedItems="true" 
                                                    Width="250" DropDownWidth="650px" 
                                                    OnItemsRequested="cb_employee_ItemsRequested" 
                                                    OnPreRender="cb_employee_PreRender" 
                                                    OnSelectedIndexChanged="cb_employee_SelectedIndexChanged">
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
                                    <td>
                                        <telerik:RadLabel runat="server" Text="Date" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker runat="server" RenderMode="Lightweight" ID="dtp_date" MinDate="1/1/1900" Width="150px" TabIndex="4" Skin="MetroTouch">
                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                                FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                            <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4" />
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="dtp_date" ForeColor="Red" 
                                            Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                        &nbsp
                                        <telerik:RadLabel runat="server" Text="Ctrl. No." CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                        <telerik:RadTextBox runat="server" RenderMode="Lightweight" ID="txt_ctrl" AutoPostBack="false" Width="100px"></telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdLabel">
                                        <telerik:RadLabel runat="server" Text="Remark" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                    </td>                
                                    <td style="vertical-align:top; text-align:left">                               
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
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
            <%--<div style="padding: 5px 15px 15px 15px; border-bottom-style:double; border-bottom-width: 1px; border-bottom-color:deeppink; ">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" Skin="Telerik"
                            AllowPaging="false" AllowSorting="true" runat="server" AllowAutomaticDeletes="true" AllowAutomaticInserts="true"   
                            OnNeedDataSource="RadGrid2_NeedDataSource" OnInsertCommand="RadGrid2_InsertCommand" 
                            OnDeleteCommand="RadGrid2_DeleteCommand" ShowStatusBar="true">
                            <PagerStyle Mode="NumericPages" PageButtonCount="4" />
                            <MasterTableView CommandItemDisplay="Top"  DataKeyNames="jobtype" Font-Size="11px" EditMode="InPlace" 
                                AllowAutomaticUpdates="true" AllowAutomaticInserts="true" AllowAutomaticDeletes="true"
                                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item" 
                                CommandItemSettings-ShowRefreshButton="False" ItemStyle-ForeColor="#006600">
                                <Columns>
                                    <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                        HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update">
                                    </telerik:GridEditCommandColumn>

                                    <telerik:GridTemplateColumn UniqueName="jobtype" HeaderText="Manpower Activity" HeaderStyle-Width="120px"
                                        SortExpression="jobno" ItemStyle-Width="120px">
                                        <FooterTemplate>Template footer</FooterTemplate>
                                        <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%#DataBinder.Eval(Container.DataItem, "jobtype")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_jobnoD" EnableLoadOnDemand="True" DataTextField="job_name"
                                                OnItemsRequested="cb_jobnoD_ItemsRequested" DataValueField="job_code" AutoPostBack="true"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.jobtype") %>' EmptyMessage="- Search product name here -"
                                                HighlightTemplatedItems="true" Height="190px" Width="220px" DropDownWidth="430px"
                                                OnSelectedIndexChanged="cb_jobnoD_SelectedIndexChanged" OnPreRender="cb_jobnoD_PreRender">
                                                <HeaderTemplate>
                                                    <table style="width: 400px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                Prod. Code 
                                                            </td>     
                                                            <td style="width: 250px;">
                                                                Prod. Name
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 400px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                            </td>
                                                            <td style="width: 250px;">
                                                                <%# DataBinder.Eval(Container, "Attributes['job_name']")%>
                                                            </td>                                                                   
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Durasi Hour" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                                        HeaderStyle-HorizontalAlign="Center" DefaultInsertValue="0"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                        <ItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_Hours" Width="85px"  ReadOnly="false" EnabledStyle-HorizontalAlign="Right"
                                                NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "time_tot", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2">
                                            </telerik:RadTextBox>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Adj Tot" HeaderStyle-Width="90px" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right" 
                                        HeaderStyle-HorizontalAlign="Center" DefaultInsertValue="0"  HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                        <ItemTemplate>
                                            <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_adj" Width="85px"  ReadOnly="false" EnabledStyle-HorizontalAlign="Right"
                                                NumberFormat-AllowRounding="true"
                                                NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                Text='<%# DataBinder.Eval(Container.DataItem, "adj_tot", "{0:#,###,###0.00}") %>'
                                                onkeydown="blurTextBox(this, event)"
                                                AutoPostBack="true" MaxLength="11" Type="Number"
                                                NumberFormat-DecimalDigits="2">
                                            </telerik:RadTextBox>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-Width="350px" ItemStyle-Width="350px" HeaderStyle-HorizontalAlign="Center" 
                                        HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="Teal">
                                        <ItemTemplate>
                                            <telerik:RadTextBox runat="server" ID="txtDesc" Width="350px" Text='<%# DataBinder.Eval(Container.DataItem, "activity") %>'></telerik:RadTextBox> 
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
            </div>--%>
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
                            <telerik:RadLabel runat="server" ID="lbl_edited" Width="100px" Text="Edited: " CssClass="lbObject" Font-Size="Small"/>
                        </td>                    
                        <td style="padding-top:0px; text-align:left">
                            <telerik:RadButton ID="btn_save" runat="server" Text="Save" CssClass="btn-wrapper" ForeColor="White"
                                OnClick="btn_save_Click"  Skin="Material"></telerik:RadButton>                        
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
