<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h09.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.PaymentRequest.Submition.acc01h09" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
    
    <script type="text/javascript" src="../../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("reportViewer.aspx?doc_no=" + id, "PreviewDialog");
                return false;
            }

        </script>
    </telerik:RadCodeBlock>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
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
        Modal="true" Width="1250px" Height="670px">
        <ContentTemplate>
             <div runat="server" style="padding:20px 10px 10px 10px;" id="searchParam">
                 <table>
                     <tr>
                         <td style="width:200px">
                             <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  DateInput-Label="Date From "
                                DateInput-ReadOnly="true"></telerik:RadDatePicker> 
                         </td>
                         <td style="width:250px">
                             <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px" DateInput-Label="To Date " 
                                DateInput-ReadOnly="true"></telerik:RadDatePicker>
                         </td>
                         <td style="width:320px">
                              <telerik:RadComboBox ID="cb_project_prm" runat="server" RenderMode="Lightweight" Label="Project" AutoPostBack="false"
                                EnableLoadOnDemand="True" Skin="MetroTouch"  OnItemsRequested="cb_project_prm_ItemsRequested" EnableVirtualScrolling="true" 
                                Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px"
                                OnSelectedIndexChanged="cb_project_SelectedIndexChanged"></telerik:RadComboBox>
                         </td>
                         <td >
                              <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Retrieve" BorderStyle="Solid" BackColor="Transparent"
                                  Width="120px" Height="25px" />
                         </td>
                         <td >
                             <asp:Button ID="btnOk" runat="server" OnClick="btnOk_Click" Text="Select & Close" BorderStyle="Solid" BackColor="Transparent"
                                  Width="120px" Height="25px" />
                         </td>
                     </tr>
                 </table>  
            </div>
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="12"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <ClientSettings EnablePostBackOnRowClick="true" >
                </ClientSettings>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="reg_no" Font-Size="12px"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                     CommandItemSettings-ShowRefreshButton="false" >                    
                    <Columns>
                        <telerik:GridClientSelectColumn UniqueName="SelectColumn" ></telerik:GridClientSelectColumn> 
                        <telerik:GridBoundColumn UniqueName="reg_no" HeaderText="Reg. Number" DataField="reg_no">
                            <HeaderStyle Width="300px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="doc_no" HeaderText="Doc. Number" DataField="doc_no" 
                                ItemStyle-Width="350px" FilterControlWidth="350px">
                            <HeaderStyle Width="350px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="reg_date" HeaderText="Date" DataField="reg_date" ItemStyle-Width="70px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="70px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" 
                            FilterControlWidth="220px" >
                            <HeaderStyle Width="220px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn HeaderText="Total Amount" ItemStyle-Width="180px" ItemStyle-HorizontalAlign="Right" DefaultInsertValue="0">
                            <ItemTemplate>  
                                <%#DataBinder.Eval(Container.DataItem, "amount", "{0:#,###,###0.00}")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn> 
                                               
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" HeaderText="Delete"
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                        </telerik:GridButtonColumn>                            
                    </Columns>
                   
                </MasterTableView>
                <ClientSettings>                         
                    <Selecting AllowRowSelect="true"></Selecting>
                </ClientSettings>
            </telerik:RadGrid>
           
        </ContentTemplate>
    </telerik:RadWindow>

    <div  class="scroller" runat="server">
        <div style=" padding-left:15px; width:100%; border-bottom-color: #FF9933; border-bottom-width: 1px; border-bottom-style: inset;">
            <table id="tbl_control">
                <tr>
                                        
                    <td  style="text-align:right;vertical-align:middle;">
                        <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                            Height="30px" Width="35px" ImageUrl="~/Images/daftar.png" >                            
                        </asp:ImageButton>                                                 
                    </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:8px">
                        <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/tambah.png">
                        </asp:ImageButton>
                    </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:13px">
                        <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" OnClick="btnSave_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/simpan-gray.png">
                        </asp:ImageButton>
                    </td>              
                    <td style="width:89%; text-align:right">
                        <telerik:RadLabel ID="lbl_form_name" Text="Payment Request Entry" runat="server" style="font-weight:lighter; 
                            font-size:10px; font-variant: small-caps; padding-left:10px; 
                        padding-bottom:0px; font-size:x-large; color:Highlight"></telerik:RadLabel>
                    </td>
                </tr>
            </table>            
        </div>

          <div class="table_trx" id="div1">                               
            <table id="Table1" border="0" >    
                <tr style="vertical-align: top">
                    <td style="vertical-align: top">
                        <table id="Table2" width="Auto" border="0" class="module"> 
                            <tr>
                                <td class="tdLabel">
                                    Document Number:
                                </td>
                                <td>
                                   <telerik:RadComboBox RenderMode="Lightweight" ID="cb_doc_number" runat="server" Width="350px" 
                                    DropDownWidth="650px" EmptyMessage="- Select Document Number -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                        MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true" AutoPostBack="true" 
                                       OnItemsRequested="cb_doc_number_ItemsRequested" OnSelectedIndexChanged="cb_doc_number_SelectedIndexChanged" >
                                        <HeaderTemplate>
                                            <table style="width: 700px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 350px;">
                                                        Doc, Number
                                                    </td>
                                                    <td style="width: 350px;">
                                                        Amount
                                                    </td>                                                                
                                                </tr>
                                            </table>                                                       
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 700px; font-size:smaller">
                                                <tr>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.doc_no")%>
                                                    </td>
                                                    <td style="width: 350px;">
                                                        <%# DataBinder.Eval(Container, "DataItem.amount")%>
                                                    </td>                                                                
                                                </tr>
                                            </table>

                                        </ItemTemplate>
                                        <FooterTemplate>
                                        </FooterTemplate>                                                        
                                    </telerik:RadComboBox>                                       
                                </td>
                            </tr>
                            <tr>
                                <td style="width:140px">
                                    Submition Number:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_reg_number" runat="server" Width="250px" ReadOnly="true" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                       
                                </td>
                            </tr>    
                            <tr>
                                <td class="tdLabel">
                                    Submition Note :
                                </td>                
                                <td style="vertical-align:top; text-align:left">                               
                                    <telerik:RadTextBox ID="txt_note" runat="server" TextMode="MultiLine" Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                    </telerik:RadTextBox>                                  
                                </td>
                            </tr> 
                            <tr>
                                <td class="tdLabel">
                                    Submition Date :
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_submit_date"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        TabIndex="4" Skin="MetroTouch"> 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="MetroTouch" 
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
 
                        </table>
                    </td>                                        
                </tr>    
                <tr>
                    <td colspan="3" style="padding-top:40px; padding-bottom:20px;">
                        <table>   
                                        
                            <tr>
                                <td class="tdLabel">
                                    Date :
                                </td>
                                <td>
                                <telerik:RadDatePicker ID="dtp_doc"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                    TabIndex="4" Skin="MetroTouch" ReadOnly="true"> 
                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="MetroTouch" 
                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                    </DateInput>
                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                </telerik:RadDatePicker>
                            </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Due Date :
                                </td>
                                <td>
                                <telerik:RadDatePicker ID="dtp_due_date" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                    TabIndex="4" Skin="MetroTouch" ReadOnly="true">
                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                        FastNavigationNextText="&amp;lt;&amp;lt;" Skin="MetroTouch"></Calendar>
                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                    </DateInput>
                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                </telerik:RadDatePicker>
                            </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Object :
                                </td>                
                                <td style="vertical-align:top; text-align:left">                               
                                    <telerik:RadTextBox ID="txt_object"  ReadOnly="true"
                                        runat="server" TextMode="MultiLine"
                                        Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                    </telerik:RadTextBox>                                  
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Total Amount :
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_amount" Width="150px" NumberFormat-AllowRounding="true"
                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  ReadOnly="true"
                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" >
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Project :
                                </td>
                                <td>                    
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="250px" DropDownWidth="300px" ReadOnly="true"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="MetroTouch"         >
                                    </telerik:RadComboBox>   
                                </td>
                            </tr>
                            <tr >
                                <td class="tdLabel">
                                    Departement:
                                </td>
                                <td style="vertical-align:top; text-align:left">                                   
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cost_center" runat="server" Width="250px" DropDownWidth="300px"
                                      EnableLoadOnDemand="True" Skin="MetroTouch" ShowMoreResultsBox="false" EnableVirtualScrolling="false" ReadOnly="true" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Payment to :
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_pay_to" runat="server" Width="450px" Enabled="true" RenderMode="Lightweight" ReadOnly="true"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Remark:
                                </td>                
                                <td style="vertical-align:top; text-align:left">                               
                                    <telerik:RadTextBox ID="txt_remark" runat="server" TextMode="MultiLine" Width="450px" Rows="0" TabIndex="5" Resize="Both" ReadOnly="true">
                                    </telerik:RadTextBox>                                  
                                </td>
                            </tr>
                            <tr>
                                <td style="width:120px;vertical-align:top">
                                    Payment Method :
                                </td>                
                                <td style="vertical-align:top; text-align:left">                               
                                    <telerik:RadTextBox ID="txt_pay_methode" runat="server" ReadOnly="true" TextMode="MultiLine" Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                    </telerik:RadTextBox>                                  
                                </td>
                            </tr>


                        </table>
                    </td>
                                        
                </tr>    
                <tr>
                    <td colspan="3" style="padding-top:10px; padding-bottom:20px;">
                        <table>
                            <tr>
                                <td style="padding:0px 10px 0px 10px">
                                    User 
                                </td>
                                <td style="width:50px">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_uid" Width="50px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width:80px; padding-left:15px">
                                    Last Update 
                                </td>
                                <td style="width:70px;">
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_lastUpdate" Width="160px" runat="server" Skin="MetroTouch">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="padding:0px 10px 0px 10px">
                                    Owner 
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_owner" Width="50px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>                               
                                <td style="padding:0px 10px 0px 10px">
                                    Edited
                                </td>
                                <td>
                                    <telerik:RadTextBox ReadOnly="true" ID="txt_edited" Width="40px" runat="server" >
                                    </telerik:RadTextBox>
                                </td>                                
                            </tr>
                           
                            
                        </table>
                    </td>
                </tr>   
            </table>
        </div>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server"  ReloadOnShow="false" ShowContentDuringLoad="false"
                  Width="1150px" Height="670px" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
            
         <script type="text/javascript">
        //<![CDATA[
            Sys.Application.add_load(function() {
                $windowContentDemo.contentTemplateID = "<%=RadWindow_ContentTemplate.ClientID%>";
                $windowContentDemo.templateWindowID = "<%=RadWindow_ContentTemplate.ClientID %>";
            });
        //]]>
        </script>  
 
    </div>

</asp:Content>
