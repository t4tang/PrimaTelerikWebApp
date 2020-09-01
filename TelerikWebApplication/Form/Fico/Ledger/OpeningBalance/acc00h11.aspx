<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc00h11.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Ledger.OpeningBalance.acc00h11" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <script src="../../../../Script/Script.js"></script>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("acc00d22.aspx?asset_id=" + id, "PreviewDialog");
                return false;
            }

        </script>
    </telerik:RadCodeBlock>
    <style type="text/css">      
       div.RadGrid .rgPager .rgAdvPart     
       {     
        display:none;        
       }      
    </style> 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
     <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
        <AjaxSettings>            
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
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
             
            <div runat="server" style="margin-right:10px" id="Div2">
                
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div class="scroller" runat="server">        

        <div style=" padding-left:15px; width:100%; border-bottom-color: #FF9933; border-bottom-width: 1px; border-bottom-style: inset;">
            <table id="tbl_control">
                <tr>
                     <td style="width:180px">
                        <telerik:RadComboBox ID="cb_month" runat="server" RenderMode="Lightweight" Label="Project" AutoPostBack="false"
                        EnableLoadOnDemand="True" Skin="MetroTouch"  EnableVirtualScrolling="true"  ShowMoreResultsBox="true"
                        Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px" Text ="January"
                        BorderStyle="NotSet"></telerik:RadComboBox>
                    </td>
                    <td style="width:180px">
                        <telerik:RadComboBox ID="cb_year" runat="server" RenderMode="Lightweight" Label="Year" AutoPostBack="false"
                        EnableLoadOnDemand="True" Skin="MetroTouch" EnableVirtualScrolling="true" 
                            OnItemsRequested="cb_year_ItemsRequested"
                        Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px"
                        BorderStyle="NotSet"></telerik:RadComboBox>
                    </td>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:8px">
                        <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/tambah.png">
                        </asp:ImageButton>
                    </td>
                     <td style="vertical-align:middle; margin-left:10px;padding-left:8px">
                        <asp:ImageButton runat="server" ID="btnCancel" AlternateText="Cancel" OnClick="btnCancel_Click"
                            Height="30px" Width="32px" ImageUrl="~/Images/undo-gray.png">
                        </asp:ImageButton>
                    </td>
                      
                    <td style="width:100%; text-align:right">
                        <telerik:RadLabel ID="lbl_form_name" Text="Opening Balance" runat="server" style="font-weight:lighter; 
                            font-size:10px; font-variant: small-caps; padding-right:5px; 
                        padding-bottom:0px; font-size:x-large; color:Highlight"></telerik:RadLabel>
                    </td>
                </tr>
            </table>            
        </div> 

        <div class="table_trx" id="div1" style="padding-bottom:5px">                               
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" OnNeedDataSource="RadGrid1_NeedDataSource"
                PageSize="14" OnUpdateCommand="RadGrid1_UpdateCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="account_no" Font-Size="12px" EditMode="InPlace"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                  ShowHeadersWhenNoRecords="true"  PagerStyle-ShowPagerText="true" CommandItemSettings-ShowRefreshButton="false" >                                     
                    <Columns>
                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                            HeaderText="Edit" HeaderStyle-Width="30px" UpdateText="Update">
                        </telerik:GridEditCommandColumn>                           
                        <%--<telerik:GridBoundColumn UniqueName="Account" HeaderText="Account" DataField="account_no" ReadOnly="true" 
                               ItemStyle-Width="65px" FilterControlWidth="65px">
                            <HeaderStyle Width="65px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridTemplateColumn HeaderText="Account" ItemStyle-Width="65px" ItemStyle-HorizontalAlign="Left" FilterControlWidth="65px">
                            <ItemTemplate>
                                <telerik:RadLabel ID="lbl_account" runat="server" RenderMode="Lightweight" Width="65px" 
                                    Text='<%#DataBinder.Eval(Container.DataItem, "account_no")%>'></telerik:RadLabel>                                  
                            </ItemTemplate>                         
                        </telerik:GridTemplateColumn>   
                        <telerik:GridBoundColumn UniqueName="AccountName" HeaderText="Account Name" DataField="accountname" ReadOnly="true"
                                ItemStyle-Width="230px" FilterControlWidth="230px">
                            <HeaderStyle Width="230px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>                        
                        <%--<telerik:GridBoundColumn UniqueName="Balance" HeaderText="Balance" DataField="balance" ReadOnly="true"
                            FilterControlWidth="30px" ItemStyle-HorizontalAlign="Left">
                            <HeaderStyle Width="30px"></HeaderStyle>
                        </telerik:GridBoundColumn> --%>
                        <telerik:GridTemplateColumn HeaderText="Balance" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Left" FilterControlWidth="30px">
                            <ItemTemplate>
                                <telerik:RadLabel ID="lbl_balance" runat="server" RenderMode="Lightweight" Width="30px" 
                                    Text='<%#DataBinder.Eval(Container.DataItem, "balance")%>'></telerik:RadLabel>                                  
                            </ItemTemplate>                         
                        </telerik:GridTemplateColumn> 
                        <telerik:GridBoundColumn UniqueName="Curr" HeaderText="Curr" DataField="cur_code" ReadOnly="true"
                            FilterControlWidth="40px" ItemStyle-HorizontalAlign="Left" >
                            <HeaderStyle Width="40px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn HeaderText="Kurs" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>  
                                <%#DataBinder.Eval(Container.DataItem, "kurs", "{0:#,###0.######00}")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_kurs" Width="100px" NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" OnTextChanged="txt_kurs_TextChanged"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "kurs", "{0:#,###0.######00}") %>'
                                    onkeydown="blurTextBox(this, event)" EnabledStyle-HorizontalAlign="Right"
                                    AutoPostBack="true" MaxLength="11" Type="Money">
                                </telerik:RadTextBox>
                            </EditItemTemplate>                            
                        </telerik:GridTemplateColumn>   
                        <telerik:GridTemplateColumn HeaderText="Debet" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>  
                                <%#DataBinder.Eval(Container.DataItem, "sl_debet_idr", "{0:#,###,###0.00}")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_debet" Width="140px" NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" OnTextChanged="txt_debet_TextChanged"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "sl_debet_idr", "{0:#,###,###0.00}") %>'
                                    onkeydown="blurTextBox(this, event)" EnabledStyle-HorizontalAlign="Right"
                                    AutoPostBack="true" MaxLength="11" Type="Money">
                                </telerik:RadTextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Credit" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>  
                                <%#DataBinder.Eval(Container.DataItem, "sl_credit_idr", "{0:#,###,###0.00}")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox  RenderMode="Lightweight" runat="server" ID="txt_credit" Width="140px" NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" OnTextChanged="txt_credit_TextChanged"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "sl_credit_idr", "{0:#,###,###0.00}") %>'
                                    onkeydown="blurTextBox(this, event)" EnabledStyle-HorizontalAlign="Right"
                                    AutoPostBack="true" MaxLength="11" Type="Money">
                                </telerik:RadTextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Debet Valas" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>  
                                <%#DataBinder.Eval(Container.DataItem, "sl_debet_usd", "{0:#,###,###0.00}")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadLabel  RenderMode="Lightweight" runat="server" ID="lbl_debet_valas" Width="90px" NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ReadOnly="true"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "sl_debet_usd", "{0:#,###,###0.00}") %>'
                                    onkeydown="blurTextBox(this, event)" EnabledStyle-HorizontalAlign="Right"
                                    AutoPostBack="false" MaxLength="11" Type="Money">
                                </telerik:RadLabel>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Credit Valas" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>  
                                <%#DataBinder.Eval(Container.DataItem, "sl_credit_usd", "{0:#,###,###0.00}")%>
                            </ItemTemplate> 
                            <EditItemTemplate>
                                <telerik:RadLabel  RenderMode="Lightweight" runat="server" ID="lbl_credit_valas" Width="90px" NumberFormat-AllowRounding="true"
                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ReadOnly="true"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "sl_credit_usd", "{0:#,###,###0.00}") %>'
                                    onkeydown="blurTextBox(this, event)" EnabledStyle-HorizontalAlign="Right"
                                    AutoPostBack="false" MaxLength="11" Type="Money">
                                </telerik:RadLabel>
                            </EditItemTemplate>                          
                        </telerik:GridTemplateColumn>  
                        
                    </Columns>
                   
                </MasterTableView>
                <ClientSettings>                         
                    <Selecting AllowRowSelect="true"></Selecting>
                </ClientSettings>
            </telerik:RadGrid>
        </div>

        
    </div>
</asp:Content>

