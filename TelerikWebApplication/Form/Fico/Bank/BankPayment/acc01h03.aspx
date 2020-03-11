<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h03.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Bank.BankPayment.acc01h03" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
    <script type="text/javascript" src="../../../../Script/Script.js" ></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
            <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
        </ContentTemplate>        
    </asp:UpdatePanel> 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>            
            <telerik:AjaxSetting AjaxControlID="btnFind">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="cb_project_prm">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="1110px" Height="580px">
        <ContentTemplate>
            <div runat="server" style="padding:20px 10px 10px 10px;" id="searchParam">                
                <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="Date From " Height="26px"></telerik:RadDatePicker>                
                <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="To Date " Height="26px"></telerik:RadDatePicker>
                <telerik:RadComboBox ID="cb_project_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="Project" AutoPostBack="true"
                    EnableLoadOnDemand="True" Skin="MetroTouch"  OnItemsRequested="cb_project_prm_ItemsRequested" EnableVirtualScrolling="true" 
                    Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"
                    OnSelectedIndexChanged="cb_project_prm_SelectedIndexChanged"></telerik:RadComboBox>&nbsp
                &nbsp
                <asp:Button ID="btnFind" runat="server" Text="Search" OnClick="btnFind_Click" />
                 &nbsp
                <asp:Button ID="btnOk" runat="server" Text="Select & Close"/>
            </div>
                <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="10"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                    <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                    <ClientSettings EnablePostBackOnRowClick="true" >
                    </ClientSettings>
                    <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="slip_no" Font-Size="12px"
                     EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                     CommandItemSettings-ShowRefreshButton="false">
                        <Columns>
                            <telerik:GridBoundColumn UniqueName="slip_no" HeaderText="Reg. No" DataField="slip_no">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="cashbank" HeaderText="Bank Code" DataField="cashbank">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="noctrl" HeaderText="Ctrl. No" DataField="noctrl">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridDateTimeColumn UniqueName="doc_date" HeaderText="Date" DataField="doc_date" ItemStyle-Width="80px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="80px"></HeaderStyle>
                            </telerik:GridDateTimeColumn>
                            <telerik:GridBoundColumn UniqueName="supplier_name" HeaderText="Supplier" DataField="supplier_name">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="cur_code" HeaderText="Curr" DataField="cur_code">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="kurs" HeaderText="Kurs" DataField="kurs">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="tot_pay" HeaderText="Tot. Amount" DataField="tot_pay">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="Remark" HeaderText="Remark" DataField="Remark">
                            <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings>                         
                    <Selecting AllowRowSelect="true"></Selecting>
                    </ClientSettings>
                </telerik:RadGrid>
            </ContentTemplate>
    </telerik:RadWindow>
    <div class="scroller">
        <table id="tbl_control">
            <tr>
                <td  style="text-align:right;">
                        <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                            Height="30px" Width="35px" ImageUrl="~/Images/list.png" >                            
                        </asp:ImageButton>
                </td>
                <td style="vertical-align:middle; margin-left:10px">
                        <asp:ImageButton runat="server" ID="btnNew" AlternateText="New"
                            Height="37px" Width="49px" ImageUrl="~/Images/add.png">
                        </asp:ImageButton>
                </td>
                <td style="vertical-align:middle; margin-left:20px">
                    <asp:ImageButton runat="server" ID="btnEdit" AlternateText="Edit"
                        Height="25px" Width="30px" ImageUrl="~/Images/edit.png">
                    </asp:ImageButton>
                </td>
                <td style="vertical-align:top; margin-left:20px;padding-left:7px">
                    <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save"
                        Height="37px" Width="38px" ImageUrl="~/Images/save.png">
                    </asp:ImageButton>
                </td>
            </tr>
        </table>
    </div>
    <div class="table_trx">
        <table id="Table1" border="0">
            <tr style="vertical-align: top">
                <td style="vertical-align: top">
                    <table id="Table2" width="Auto" border="0" class="module">
                        <tr>
                            <td class="tdLabel">
                                Reg No :
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txt_slip_number" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                    AutoPostBack="false">
                                </telerik:RadTextBox>
                            &nbsp;
                            Posting :
                               <asp:CheckBox ID="chk_posting" runat="server" Checked="true"/>
                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                            Giro No :
                            &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                <telerik:RadTextBox ID="txt_giro" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                    AutoPostBack="false">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdLabel">
                                Supplier:
                            </td>
                            <td style="vertical-align:top; text-align:left">                      
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="300" DropDownWidth="300px"
                                    AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        >
                                </telerik:RadComboBox>
                                 &nbsp;
                                Prepared by : &nbsp;
                                <telerik:RadComboBox RenderMode="Lightweight" ID="txt_pre" runat="server" Width="300" DropDownWidth="300px"
                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        >
                                </telerik:RadComboBox>          
                            </td>
                           
                            <%--<td>
                                Remark :
                                <telerik:RadTextBox ID="txt_remark" runat="server" Width="250px" Enabled="false" RenderMode="Lightweight"
                                    AutoPostBack="false" TextMode="MultiLine">
                                </telerik:RadTextBox>
                            </td>--%>
                        </tr>
                        <tr>
                            <td class="tdLabel">
                                Currency :
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txt_currency" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                    AutoPostBack="false">
                                </telerik:RadTextBox>
                            &nbsp;
                            Kurs :
                               <telerik:RadTextBox ID="txt_kurs" runat="server" Width="108px" Enabled="false" RenderMode="Lightweight"
                                    AutoPostBack="false">
                                </telerik:RadTextBox>
                            &nbsp;
                            Checked by :
                                &nbsp;&nbsp;&nbsp;<telerik:RadComboBox RenderMode="Lightweight" ID="txt_check" runat="server" Width="300" DropDownWidth="300px"
                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        >
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                        <td class="tdLabel">
                             Reference:
                            </td>
                            <td>
                                <telerik:RadComboBox RenderMode="Lightweight" ID="NoRef" runat="server" Width="150"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Metro"
                                   
                                    EnableVirtualScrolling="true" >
                                </telerik:RadComboBox>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                Approve by :
                                &nbsp;&nbsp
                                <telerik:RadComboBox RenderMode="Lightweight" ID="txt_approve" runat="server" Width="300" DropDownWidth="300px"
                                    AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        >
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdLabel">
                                Bank :
                            </td>
                            <td style="vertical-align:top; text-align:left">                      
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_bank" runat="server" Width="300" DropDownWidth="300px"
                                    AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Bank -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                        >
                                </telerik:RadComboBox>
                                &nbsp;
                                User :
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <telerik:RadTextBox ID="txt_user" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                    AutoPostBack="false">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdLabel">
                                Doc Date:
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="dtp_ur"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                    TabIndex="4" Skin="Metro"> 
                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro"></Calendar>
                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                    <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                    <ReadOnlyStyle Resize="None"></ReadOnlyStyle>
                                    <FocusedStyle Resize="None"></FocusedStyle>
                                    <DisabledStyle Resize="None"></DisabledStyle>
                                    <InvalidStyle Resize="None"></InvalidStyle>
                                    <HoveredStyle Resize="None"></HoveredStyle>
                                    <EnabledStyle Resize="None"></EnabledStyle>
                                    </DateInput>
                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                </telerik:RadDatePicker>
                                &nbsp;
                                Ctrl No :
                                <telerik:RadTextBox ID="txt_ctrl" runat="server" Width="95px" Enabled="false" RenderMode="Lightweight"
                                    AutoPostBack="false">
                                </telerik:RadTextBox>
                                &nbsp;
                                Last Update :
                          &nbsp;<telerik:RadTextBox ID="txt_lastupdate" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                    AutoPostBack="false">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdLabel">
                                Cashed Date:
                            </td>
                            <td>
                            <telerik:RadDatePicker ID="dtp_cashed" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                TabIndex="4" Skin="Silk">
                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                </DateInput>
                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                            </telerik:RadDatePicker>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                Remark :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <telerik:RadTextBox ID="txt_remark" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                    AutoPostBack="false" TextMode="MultiLine">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
