<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h15.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Budget.acc01h15" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    <script src="../../../Script/Script.js"></script>
    
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
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
        <AjaxSettings>            
            <telerik:AjaxSetting AjaxControlID="cb_year">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadPivotGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

     <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None">
        <img alt="Loading..." src="../../../Images/loading.gif" style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="1250px" Height="730px">
        <ContentTemplate>
         
            <div>
                <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" runat="server" AllowAutomaticDeletes="True"
                    AllowAutomaticInserts="True" PageSize="14"  AllowAutomaticUpdates="True" AllowPaging="True" Skin="Silk" CssClass="RadGrid_ModernBrowsers" 
                    HeaderStyle-Font-Size="Small" ItemStyle-Font-Size="Small" Font-Names="Segoe UI"
                    AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                    <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                    <MasterTableView CommandItemDisplay="Top" DataKeyNames="id" AllowFilteringByColumn="true"
                        DataSourceID="SqlDataSource1" HorizontalAlign="NotSet" EditMode="Batch" AutoGenerateColumns="False" CommandItemSettings-ShowAddNewRecordButton="False">
                        <BatchEditingSettings EditType="Cell" HighlightDeletedRows="true"/>
                        <SortExpressions>
                            <telerik:GridSortExpression FieldName="account" SortOrder="Descending" />
                        </SortExpressions>
                        <Columns>
                            <%--<telerik:GridBoundColumn DataField="id" HeaderStyle-Width="35px" ItemStyle-Width="35px" HeaderText="id" SortExpression="id"
                                UniqueName="id">                                
                            </telerik:GridBoundColumn>--%>
                            <telerik:GridBoundColumn DataField="account" HeaderStyle-Width="110px" HeaderText="ACCOUNT" SortExpression="Account"
                                UniqueName="account" ReadOnly="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">                                
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="accountname" HeaderStyle-Width="410px" HeaderText="ACCOUNT NAME" SortExpression="accountname"
                                UniqueName="accountname" ReadOnly="true" FilterControlWidth="500px">                                
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="project" HeaderStyle-Width="70px" HeaderText="PROJECT" SortExpression="project"
                                UniqueName="project" ReadOnly="true" FilterControlWidth="50px">                                
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Bulan" HeaderStyle-Width="110px" HeaderText="MONTH" SortExpression="Bulan"
                                UniqueName="Bulan" ReadOnly="true" FilterControlWidth="90px">                                
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="month" HeaderStyle-Width="110px" HeaderText="month" SortExpression="month"
                                UniqueName="month" Visible="false" >                                
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="year" HeaderStyle-Width="75px" HeaderText="YEAR" SortExpression="year"
                                UniqueName="year" ReadOnly="true" FilterControlWidth="50px">                                
                            </telerik:GridBoundColumn>
                           <%-- <telerik:GridBoundColumn DataField="budget_amount" HeaderStyle-Width="110px" HeaderText="Budget" SortExpression="Budget"
                                UniqueName="budget_amount" DataFormatString="{0:#,###,###0.00}" ItemStyle-HorizontalAlign="Right" >                                
                            </telerik:GridBoundColumn>--%>
                            <telerik:GridTemplateColumn HeaderText="BUDGET" HeaderStyle-Width="150px" SortExpression="budget_amount" UniqueName="TemplateColumn" 
                                DataField="budget_amount" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>                                   
                                    <asp:Label runat="server" ID="lblBudget" Text='<%# Eval("budget_amount", "{0:#,###,###0.00}") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox RenderMode="Lightweight" Width="155px" runat="server" ID="txt_amount"
                                        NumberFormat-AllowRounding="true"  NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ReadOnly="false" 
                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2"
                                        EnabledStyle-HorizontalAlign="Right">
                                        </telerik:RadNumericTextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            
                        </Columns>
                    </MasterTableView>
                    <ClientSettings AllowKeyboardNavigation="true"></ClientSettings>
                </telerik:RadGrid>
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConString %>"
                SelectCommand="SELECT acc01h15.id, acc01h15.account, gl_account.accountname, acc01h15.project, v_month.Bulan, acc01h15.month, acc01h15.year, acc01h15.budget_amount FROM acc01h15 INNER JOIN gl_account ON acc01h15.account = gl_account.accountno INNER JOIN v_month ON acc01h15.month = v_month.Value WHERE year = @year"
                UpdateCommand="UPDATE [acc01h15] SET [budget_amount] = @budget_amount WHERE [id] = @id">
               <SelectParameters>
                    <asp:ControlParameter ControlID="cb_year" PropertyName="Text" Name="year" />
               </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="budget_amount" Type="Decimal"></asp:Parameter>
                    <asp:Parameter Name="id" Type="Int64"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>            

        </ContentTemplate>
    </telerik:RadWindow>
    <div class="scroller">
        <div id="PrimaryBtnWrapper" class="btn-wrapper" runat="server" style="width:100%;min-height: 40px; padding-left:15px; border-bottom-color: #FF9933; 
            border-bottom-width: 1px; border-bottom-style: inset;">
            <table id="tbl_control">
                <tr>                       
                   <%-- <td  style="text-align:right;vertical-align:middle;">
                        <asp:ImageButton runat="server" ID="btnModify" OnClientClick="openWinContentTemplate(); return false;"
                            Height="30px" Width="75px" ImageUrl="~/Images/update.png" >                            
                        </asp:ImageButton>                                                 
                    </td>--%>
                    <td>
                        <asp:Button ID="btn_Ok" runat="server" Text="UPDATE" BorderStyle="Solid" BackColor="#00A9E1"
                            OnClientClick="openWinContentTemplate(); return false;"  Width="120px" Height="25px" BorderColor="White" BorderWidth="1px" 
                            Font-Bold="False" ForeColor="White" font-variant="small-caps" />
                        <%--<telerik:RadButton RenderMode="Lightweight" ID="btnPrimary" runat="server" OnClientClicking="openWinContentTemplate(); return false;"
                            Height="29px" Text="UPDATE">
                        </telerik:RadButton> --%>
                    </td>             
                    <td style="width:40%;text-align:right;margin-left:10px;padding-left:13px">
                        <telerik:RadComboBox ID="cb_year" runat="server" RenderMode="Lightweight" Label="Year" AutoPostBack="true"
                        EnableLoadOnDemand="True" Skin="MetroTouch" EnableVirtualScrolling="true" 
                            OnItemsRequested="cb_year_ItemsRequested" OnSelectedIndexChanged="cb_year_SelectedIndexChanged" OnPreRender="cb_year_PreRender"
                        Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="160px"
                         BorderStyle="NotSet"></telerik:RadComboBox>
                    </td>                    
                   <td style="width:50%; text-align:right; ">
                        <telerik:RadLabel ID="lbl_form_name" Text="Budget" runat="server" style="font-weight:lighter; 
                            font-size:10px; font-variant: small-caps; padding-left:10px; 
                        padding-bottom:0px; font-size:x-large; color:Highlight"></telerik:RadLabel>
                    </td>
                </tr>
            </table>            
        </div>
        <div style=" width:100%; ">
            <telerik:RadPivotGrid RenderMode="Lightweight" runat="server" ID="RadPivotGrid1" AllowPaging="true"  PageSize="10" Height="640px"
                OnNeedDataSource="RadPivotGrid1_NeedDataSource"  Skin="Silk" CssClass="RadGrid_ModernBrowsers" 
                AllowSorting="true" AllowFiltering="false" ShowFilterHeaderZone="false" Font-Size="Small" Font-Names="Segoe UI" 
                TotalsSettings-ColumnGrandTotalsPosition="None">
                <PagerStyle Mode="NextPrevNumericAndAdvanced" AlwaysVisible="true"></PagerStyle>
                <DataCellStyle Width="100px" />
                <Fields>
                    <telerik:PivotGridRowField DataField="remark" CellStyle-Width="180px" Caption="Category" >
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridRowField DataField="name" CellStyle-Width="150px" Caption="Group">
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridRowField DataField="accountname" CellStyle-Width="250px" Caption="Account">
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridColumnField DataField="project" Caption="Project">
                    </telerik:PivotGridColumnField>
                    <telerik:PivotGridColumnField DataField="year" Caption="Year">
                    </telerik:PivotGridColumnField>
                    <telerik:PivotGridColumnField DataField="month" Caption="Month">
                    </telerik:PivotGridColumnField>                    
                    <telerik:PivotGridAggregateField DataField="budget_amount" Aggregate="Sum" Caption="Budget"
                        DataFormatString="{0:#,###,###0.00}" CellStyle-Width="150px" CellStyle-ForeColor="#006699">
                    </telerik:PivotGridAggregateField>
                </Fields>
                <ClientSettings>
                    <Scrolling AllowVerticalScroll="true"></Scrolling>
                    
                </ClientSettings>
            </telerik:RadPivotGrid>           

        </div>
         <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            //<![CDATA[
                Sys.Application.add_load(function() {
                    $windowContentDemo.contentTemplateID = "<%=RadWindow_ContentTemplate.ClientID%>";
                    $windowContentDemo.templateWindowID = "<%=RadWindow_ContentTemplate.ClientID %>";
                });
            //]]>
            </script>
        </telerik:RadCodeBlock>
    </div>
        
</asp:Content>
