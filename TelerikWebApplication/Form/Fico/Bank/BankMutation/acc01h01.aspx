<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h01.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Bank.BankMutation.acc01h01" %>
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
                    EnableLoadOnDemand="True" Skin="MetroTouch"  OnItemsRequested="cb_project_ItemsRequested" EnableVirtualScrolling="true" 
                    Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"
                    OnSelectedIndexChanged="cb_project_prm_SelectedIndexChanged"></telerik:RadComboBox>&nbsp
                &nbsp
                <%--<telerik:RadButton ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                Style="clear: both; margin: 0px 0; height:35px">
                </telerik:RadButton>--%>
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                 &nbsp
                <asp:Button ID="btnOk" runat="server" OnClick="btnOk_Click" Text="Select & Close"/>
                
            </div>
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="10"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <ClientSettings EnablePostBackOnRowClick="true" >
                </ClientSettings>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="NoBuk" Font-Size="12px"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                     CommandItemSettings-ShowRefreshButton="false" >                    
                    <Columns>
                         <%--<telerik:GridTemplateColumn UniqueName="TemplateEditColumn" AllowFiltering="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>                              
                               <asp:RadioButton ID="rb_get" runat="server" Width="15px"  />                                
                            </ItemTemplate>
                            <HeaderStyle Width="30px"></HeaderStyle>
                        </telerik:GridTemplateColumn>--%>
                        <telerik:GridBoundColumn UniqueName="NoBuk" HeaderText="Reg. No" DataField="NoBuk">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="Tgl" HeaderText="Date" DataField="Tgl" ItemStyle-Width="80px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="NoCtrl" HeaderText="Ctrl. No" DataField="NoCtrl" 
                            FilterControlWidth="120px" >
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="NoRef" HeaderText="No. Ref" DataField="NoRef" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="KoTransName" HeaderText="Transaction" DataField="KoTransName" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="KoBank" HeaderText="Bank Code" DataField="KoBank" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="cur_code" HeaderText="Curr." DataField="cur_code" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="kurs" HeaderText="Kurs" DataField="kurs" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="Total" HeaderText="Amount" DataField="Total" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
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
                    <td  style="text-align:right;">
                        <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                            Height="30px" Width="35px" ImageUrl="~/Images/list.png">
                        </asp:ImageButton>                        
                    </td>
                    <td style="vertical-align:top; margin-left:20px">
                        <%--<telerik:RadButton ID="btnStandard" runat="server" Text="Save" Height="30px" Width="75px" 
                        SingleClick="true" SingleClickText="Saving..." Style="clear: both; float: left; margin: 5px 0;">
                        </telerik:RadButton>--%>
                        <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" OnClick="btnSave_Click"
                            Height="37px" Width="38px" ImageUrl="~/Images/save.png">
                        </asp:ImageButton>
                    </td>
                </tr>
            </table>            
        </div>

        <div class="table_trx">                               
            <table id="Table1" border="0" >    
                <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module">                
                            <tr>
                                <td class="tdLabel">
                                    Reg No:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_NoBuk" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>             
                            <tr>
                                <td class="tdLabel">
                                    Date:
                                </td>
                                <td>
                                <telerik:RadDatePicker ID="dtp_bm"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
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
                            </td>
                            </tr>
                           <tr>
                                <td class="tdLabel">
                                    No Ctrl:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_NoCtrl" runat="server" Width="200px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>             
                            <tr>
                                <td class="tdLabel">
                                    No Ref:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_NoRef" runat="server" Width="200px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>             
                            <tr>
                                <td class="tdLabel">
                                    Transaction:
                                </td>
                                <td>
                                     <telerik:RadComboBox RenderMode="Lightweight" ID="cb_KoTrans" runat="server" Width="200"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Metro"
                                        OnItemsRequested="cb_KoTrans_ItemsRequested" OnPreRender="cb_KoTrans_PreRender"
                                        OnSelectedIndexChanged="cb_KoTrans_SelectedIndexChanged"
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
                                    Project:
                                </td>
                                <td style="vertical-align:top; text-align:left">                      
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" Skin="Metro" 
                                         OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                         OnPreRender="cb_project_PreRender" >
                                    </telerik:RadComboBox>               
                                </td>
                            </tr>
                            <tr >
                                <td class="tdLabel">
                                    Bank:
                                </td>
                                <td style="vertical-align:top; text-align:left">                                   
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_bank" runat="server" Width="120px" DropDownWidth="300px"
                                            EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Skin="Metro" >
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
                                
                                    Kurs:
                               &nbsp
                                    <telerik:RadTextBox ID="txt_kurs" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>          
                            <tr>
                                <td class="tdLabel">
                                    From / To:
                                </td>                
                                <td style="vertical-align:top; text-align:left">                               
                                    <telerik:RadTextBox ID="txt_Kontak" 
                                        runat="server" TextMode="MultiLine"
                                        Width="450px" Rows="0" Columns="100" TabIndex="5" Resize="Both">
                                    </telerik:RadTextBox>                                  
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Remark:
                                </td>                
                                <td style="vertical-align:top; text-align:left">                               
                                    <telerik:RadTextBox ID="txt_Ket" 
                                        runat="server" TextMode="MultiLine"
                                        Width="450px" Rows="0" Columns="100" TabIndex="5" Resize="Both">
                                    </telerik:RadTextBox>                                  
                                </td>
                            </tr>
                        </table>           
                    </td>
                    
                </tr>
                <tr>
                                <td class="tdLabel">
                                    Prepared By:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_prepared" runat="server" Width="250px" 
                                            DropDownWidth="450px" AutoPostBack="false" EmptyMessage="- Select -" EnableLoadOnDemand="false"                                                       
                                               Skin="Metro"  OnItemsRequested="cb_prepared_ItemsRequested" OnSelectedIndexChanged="cb_prepared_SelectedIndexChanged"
                                                OnPreRender="cb_prepared_PreRender">
                                                <HeaderTemplate>
                                                    <table style="width: 400px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 80px;">
                                                                NIK
                                                            </td>
                                                            <td style="width: 300px;">
                                                                Position
                                                            </td>                                                                
                                                        </tr>
                                                    </table>                                                       
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 350px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                            </td>
                                                            <td style="width: 200px;">
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
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>

                                
                                <td class="tdLabel">
                                    Checked By:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_checked" runat="server" Width="250px" 
                                            DropDownWidth="450px" AutoPostBack="false" EmptyMessage="- Select -" EnableLoadOnDemand="false"                                                       
                                               Skin="Metro" >
                                                <HeaderTemplate>
                                                    <table style="width: 400px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 80px;">
                                                                NIK
                                                            </td>
                                                            <td style="width: 300px;">
                                                                Position
                                                            </td>                                                                
                                                        </tr>
                                                    </table>                                                       
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 350px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                            </td>
                                                            <td style="width: 200px;">
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
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>

                          
                                <td class="tdLabel">
                                    Approved By:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px" 
                                            DropDownWidth="650px" EmptyMessage="- Select -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                             MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true" 
                                               >  
                                                <HeaderTemplate>
                                                    <table style="width: 400px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 80px;">
                                                                NIK
                                                            </td>
                                                            <td style="width: 300px;">
                                                                Position
                                                            </td>                                                                
                                                        </tr>
                                                    </table>                                                       
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 350px; font-size:smaller">
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.name")%>
                                                            </td>
                                                            <td style="width: 200px;">
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
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cb_project" EventName="SelectedIndexChanged">
                                                </asp:AsyncPostBackTrigger>
                                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>

                            </tr>    
                <tr>
                    <td colspan="3" style="padding-top:20px; padding-bottom:20px;">
                        <table>
                            <tr>
                                <td style="width:50px" class="tdLabel">
                                    User 
                                </td>
                                <td style="width:50px">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="50px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width:80px; padding-left:15px" class="tdLabel">
                                    Last Update 
                                </td>
                                <td style="width:70px;">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_lastUpdate" Width="140px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td >
                                    Owner 
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="50px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px" class="tdLabel">
                                    Printed 
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_printed" Width="40px" runat="server" >
                                    </telerik:RadTextBox>
                                    &nbsp
                                    Edited
                                    &nbsp
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>                                
                            </tr>
                            
                        </table>
                    </td>
                </tr>   
            </table>

            <div style=" width:100%; border-top-color: #336600; border-top-width: 1px; border-top-style: inset; padding-top: 20px;">
                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" AllowSorting="True"
                AllowAutomaticInserts="true" AllowAutomaticUpdates="true" AllowAutomaticDeletes="true"
                PageSize="7" AllowPaging="True" runat="server"  OnNeedDataSource="RadGrid2_NeedDataSource"  >   
                    <MasterTableView CommandItemDisplay="Top" DataKeyNames="accountno" Font-Size="12px"
                        ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-ShowAddNewRecordButton="False" 
                        CommandItemSettings-ShowCancelChangesButton="False">
                        <BatchEditingSettings EditType="Cell" HighlightDeletedRows="true" />                                              
                        <CommandItemSettings ShowRefreshButton="false" />                                        
                        <Columns>
                           
                            <telerik:GridTemplateColumn DataField="KoRek" HeaderText="Account No" UniqueName="KoRek" 
                                ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <%# Eval("accountno") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadDropDownList RenderMode="Lightweight" runat="server" ID="CategoryIDDropDown" DataValueField="KoRek"
                                        DataTextField="KoRek" DataSourceID="SqlDataSource1">
                                    </telerik:RadDropDownList>
                                </EditItemTemplate>
                                <HeaderStyle Width="70px" />
                                <ItemStyle HorizontalAlign="Left" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridNumericColumn DataField="accountname" HeaderText="Account Name" ItemStyle-HorizontalAlign="Left" ReadOnly="true"
                                SortExpression="accountname" UniqueName="accountname">
                                <HeaderStyle Width="180px" />
                                <ItemStyle HorizontalAlign="Left" Width="180px" />
                            </telerik:GridNumericColumn>
                             <telerik:GridNumericColumn DataField="remark" HeaderText="Remark" ItemStyle-HorizontalAlign="Left"
                                SortExpression="remark" UniqueName="remark" >
                                <HeaderStyle Width="140px" />
                                <ItemStyle HorizontalAlign="Left" Width="140px" />
                            </telerik:GridNumericColumn> 
                            <telerik:GridNumericColumn DataField="Mutasi" HeaderText="D/C" ItemStyle-HorizontalAlign="Left"
                                SortExpression="Mutasi" UniqueName="Mutasi">
                                <HeaderStyle Width="40px" />
                                <ItemStyle HorizontalAlign="Left" Width="40px" />
                            </telerik:GridNumericColumn> 
                             <telerik:GridNumericColumn DataField="Valas" HeaderText="Kurs" ItemStyle-HorizontalAlign="Right"
                                SortExpression="Valas" UniqueName="Valas" DataFormatString="{0:#,###0.000000000;(#,###0.000000000);0}">
                                <HeaderStyle Width="40px" />
                                <ItemStyle HorizontalAlign="Right" Width="40px" />
                            </telerik:GridNumericColumn>                     
                            <telerik:GridNumericColumn DataField="Jumlah" HeaderText="Ammount" ItemStyle-HorizontalAlign="Right"
                                SortExpression="Jumlah" UniqueName="Jumlah" DataFormatString="{0:#,###0.00;(#,###0.00);0}">
                                <HeaderStyle Width="40px" />
                                <ItemStyle HorizontalAlign="Right" Width="40px" />
                            </telerik:GridNumericColumn> 
                            
                            <telerik:GridNumericColumn DataField="region_code" HeaderText="Project Area" ItemStyle-HorizontalAlign="Left"
                                ReadOnly="true" SortExpression="region_code" UniqueName="region_code" ItemStyle-Width="50">
                                <HeaderStyle Width="60px" />
                                <ItemStyle HorizontalAlign="Left" Width="30px" />
                            </telerik:GridNumericColumn>
                           <telerik:GridNumericColumn DataField="dept_code" HeaderText="Cost Center" ItemStyle-HorizontalAlign="Left"
                                ReadOnly="true" SortExpression="dept_code" UniqueName="dept_code" ItemStyle-Width="50">
                                <HeaderStyle Width="60px" />
                                <ItemStyle HorizontalAlign="Left" Width="30px" />
                            </telerik:GridNumericColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete this product?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" HeaderText="Delete" ItemStyle-Width="25px" HeaderStyle-Width="25px"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                            </telerik:GridButtonColumn>
                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                    <ClientSettings AllowKeyboardNavigation="true"></ClientSettings>
                    <ItemStyle HorizontalAlign="Right" />
                    <FilterMenu RenderMode="Lightweight">
                    </FilterMenu>
                    <HeaderContextMenu RenderMode="Lightweight">
                    </HeaderContextMenu>
                </telerik:RadGrid>
            </div>
        </div>     
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT [prod_code], [spec] FROM [ms_product] WHERE stEdit != 4">
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
