<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h02.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Cash.CashMutation.acc01h02" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
    <script src="../../../../Script/Script.js"></script>
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
            <telerik:AjaxSetting AjaxControlID="btnSearch">
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
                <telerik:RadComboBox ID="cb_cashmutation_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="Cash" AutoPostBack="false"
                    EnableLoadOnDemand="True" Skin="MetroTouch" Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" 
                    ChangeTextOnKeyBoardNavigation="false" EnableVirtualScrolling="true" 
                    OnItemsRequested="cb_cashmutation_prm_ItemsRequested" OnSelectedIndexChanged="cb_cashmutation_prm_SelectedIndexChanged" 
                    >
                </telerik:RadComboBox>&nbsp
                &nbsp
                <asp:Button ID="btnSearch" runat="server" Text="Search"  OnClick="btnSearch_Click"/>
                 &nbsp
                <asp:Button ID="btnOk" runat="server" Text="Select & Close" OnClick="btnOk_Click" /> 
            </div>
            
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="10" 
                 OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <ClientSettings EnablePostBackOnRowClick="true"></ClientSettings>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="NoBuk" Font-Size="12px" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" 
                    AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false" CommandItemSettings-ShowRefreshButton="false">
                    <Columns>
                        <telerik:GridBoundColumn UniqueName="NoBuk" HeaderText="Reg. No" DataField="NoBuk">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="Tgl" HeaderText="Date" DataField="Tgl" ItemStyle-Width="80px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="NoCtrl" HeaderText="Ctrl. No." DataField="NoCtrl" 
                            FilterControlWidth="120px" >
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="NoRef" HeaderText="No. Ref" DataField="NoRef" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="KoTrans" HeaderText="Transaction" DataField="KoTrans" 
                            FilterControlWidth="120px" >
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="KoKas" HeaderText="Cash Code" DataField="KoKas" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="cur_code" HeaderText="Currency" DataField="cur_code" 
                            FilterControlWidth="120px" >
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="kurs" HeaderText="Kurs" DataField="kurs" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="Total" HeaderText="Amount" DataField="Total" 
                            FilterControlWidth="120px" >
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="Kontak" HeaderText="Contact" DataField="Kontak" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="Ket" HeaderText="Remark" DataField="Ket" ItemStyle-Wrap="true"
                                ItemStyle-Width="450px" FilterControlWidth="480px">
                            <HeaderStyle Width="500px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete">
                        </telerik:GridButtonColumn> 
                    </Columns>
                </MasterTableView>
                <ClientSettings>                         
                    <Selecting AllowRowSelect="true"></Selecting>
                </ClientSettings>
            </telerik:RadGrid>
        </ContentTemplate>
    </telerik:RadWindow>
        
    <div class="scroller">
        <div style=" padding-left:15px; width:100%; border-bottom-color: #FF6600; border-bottom-width: 1px; border-bottom-style: inset;">
            <table>
                <tr>
                    <td style="text-align:right;">
                        <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                            Height="30px" Width="35px" ImageUrl="~/Images/list.png">
                        </asp:ImageButton>
                    </td>
                    <td style="vertical-align:top; margin-left:20px;padding-left:7px">
                        <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" OnClick="btnSave_Click"
                            Height="37px" Width="38px" ImageUrl="~/Images/save.png">
                        </asp:ImageButton>
                    </td>
                    <%--<td style="vertical-align:top; margin-left:20px">
                        <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" OnClick="btnSave_Click"
                            Height="37px" Width="38px" ImageUrl="~/Images/save.png">
                        </asp:ImageButton>
                    </td>--%>
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
                                    Reg No:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_reg_no" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Date:
                                </td>
                                <td>
                                <telerik:RadDatePicker ID="dtp_exe" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                    TabIndex="4" Skin="Silk">
                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                    </DateInput>
                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                </telerik:RadDatePicker>
                            </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    No. Ctrl:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_NoCtrl" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    No. Ref:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_NoRef" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Transaction:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_trans" runat="server" Width="150"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Metro"
                                        OnItemsRequested="cb_trans_ItemsRequested" OnPreRender="cb_trans_PreRender"
                                        OnSelectedIndexChanged="cb_trans_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align: top; padding-left:15px">
                        <table id="Table3" border="0" class="module">
                            <tr>
                                <td class="tdLabel">
                                    Project Area:
                                </td>
                                <td style="vertical-align:top; text-align:left">                      
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cash_project" runat="server" Width="300" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" Skin="Metro" 
                                        OnSelectedIndexChanged="cb_cash_project_SelectedIndexChanged" 
                                        OnPreRender="cb_cash_project_PreRender" OnItemsRequested="cb_cash_project_ItemsRequested" >
                                    </telerik:RadComboBox>               
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Cash:
                                </td>
                                <td style="vertical-align:top; text-align:left">                      
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cash" runat="server" Width="300" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" Skin="Metro">
                                    </telerik:RadComboBox>               
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Currency:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_cur_code" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                    &nbsp
                                    <telerik:RadNumericTextBox ID="nu_kurs" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false" Label="Kurs">
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    From/To:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_fromto" runat="server" Width="250px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Remark:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <telerik:RadTextBox ID="txt_remark" 
                                        runat="server" TextMode="MultiLine"
                                        Width="450px" Rows="0" Columns="100" TabIndex="5" Resize="Both">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>                   
                        </table>
                    </td>
                </tr>
                <tr>
                   <td colspan="4">
                       <table>
                           <tr>
                                <td >
                                    Prepared By:
                                </td>
                                <td style="vertical-align:top; text-align:left">                      
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_prepare" runat="server" Width="150px" DropDownWidth="250px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" Skin="Metro" 
                                        >
                                    </telerik:RadComboBox>    
                                </td>
                               <td style="padding-left=15px">
                                   Checked By:
                               </td>
                               <td>
                                   <telerik:RadComboBox RenderMode="Lightweight" ID="cb_checked" runat="server" Width="150px" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" Skin="Metro" 
                                        >
                                    </telerik:RadComboBox>
                               </td>
                               <td style="padding-left=15px">
                                   Aproval By:
                               </td>     
                               <td>
                                   <telerik:RadComboBox RenderMode="Lightweight" ID="cb_aproval" runat="server" Width="150px" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" Skin="Metro" 
                                        >
                                    </telerik:RadComboBox>
                               </td>
                           </tr>
                       </table>
                   </td>
                </tr>
            </table>
            <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 20px;">
                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"
                    AllowPaging="true" AllowSorting="true" runat="server"  OnNeedDataSource="RadGrid2_NeedDataSource" 
                    AllowAutomaticUpdates="true" AllowAutomaticInserts="True" ShowStatusBar="true" AllowMultiRowEdit="true" 
                    >
                    <MasterTableView CommandItemDisplay="Top" DataKeyNames="" Font-Size="12px" EditMode="PopUp"
                        ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False">
                        <CommandItemSettings ShowRefreshButton="false" ShowSaveChangesButton="false" />
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Account No." ItemStyle-Width="120px">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "KoRek")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_account" Width="110px">
                                    </telerik:RadNumericTextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="120px">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "Ket")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_remark" Width="110px">
                                    </telerik:RadNumericTextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="D/C" ItemStyle-Width="120px">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "MutasiName")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_dc" Width="110px">
                                    </telerik:RadNumericTextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Kurs" ItemStyle-Width="120px">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "kurs")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_kurs" Width="110px">
                                    </telerik:RadNumericTextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Amount" ItemStyle-Width="120px">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "Jumlah")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_amount" Width="110px">
                                    </telerik:RadNumericTextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Project Area" ItemStyle-Width="120px">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "region_code")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_project" Width="110px">
                                    </telerik:RadNumericTextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Cost Center" ItemStyle-Width="120px">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "dept_code")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_co_cen" Width="110px">
                                    </telerik:RadNumericTextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>      
                </telerik:RadGrid>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="WHERE stEdit != 4">
    </asp:SqlDataSource>  
     <script type="text/javascript">
    //<![CDATA[
        Sys.Application.add_load(function() {
            $windowContentDemo.contentTemplateID = "<%=RadWindow_ContentTemplate.ClientID%>";
            $windowContentDemo.templateWindowID = "<%=RadWindow_ContentTemplate.ClientID %>";
        });
    //]]>
    </script>  
</asp:Content>
