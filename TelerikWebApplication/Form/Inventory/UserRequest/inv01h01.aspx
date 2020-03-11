<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv01h01.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.UserRequest.inv01h01" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    
    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
        </script>
    </telerik:RadCodeBlock>

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
            <%--<telerik:AjaxSetting AjaxControlID="RadGrid2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>--%>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>
   
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="RadWindow_ContentTemplate" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="1150px" Height="580px">
        <ContentTemplate>
             <div runat="server" style="padding:20px 10px 10px 10px;" id="searchParam">                
                <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="Date From " Height="26px"></telerik:RadDatePicker>                
                <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="To Date " Height="26px"></telerik:RadDatePicker>
                <telerik:RadComboBox ID="cb_project_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="Project" AutoPostBack="false"
                    EnableLoadOnDemand="True" Skin="MetroTouch"  OnItemsRequested="cb_project_ItemsRequested" EnableVirtualScrolling="true" 
                    Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"
                    OnSelectedIndexChanged="cb_project_prm_SelectedIndexChanged"></telerik:RadComboBox>&nbsp
                &nbsp
                
                <asp:Button ID="btnFind" runat="server" Text="Search" OnClick="btnSearch_Click" />
                 &nbsp
                <asp:Button ID="btnOk" runat="server" OnClick="btnOk_Click" Text="Select & Close"/>
                
            </div>
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="10"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnDeleteCommand="RadGrid1_DeleteCommand">
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                <ClientSettings EnablePostBackOnRowClick="true" >
                </ClientSettings>
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="doc_code" Font-Size="12px"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" CommandItemSettings-ShowAddNewRecordButton="false"
                     CommandItemSettings-ShowRefreshButton="false" >                    
                    <Columns>
                         
                        <telerik:GridBoundColumn UniqueName="doc_code" HeaderText="UR Number" DataField="doc_code">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="doc_date" HeaderText="Date" DataField="doc_date" ItemStyle-Width="80px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" 
                            FilterControlWidth="120px" >
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="wo_desc" HeaderText="Status" DataField="wo_desc" 
                            FilterControlWidth="90px" >
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="doc_remark" HeaderText="Remark" DataField="doc_remark" ItemStyle-Wrap="true"
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
        
        <div style=" padding-left:15px; width:100%; border-bottom-color: #FF9933; border-bottom-width: 1px; border-bottom-style: inset;">
            <table id="tbl_control">
                <tr>
                                        
                    <td  style="text-align:right;vertical-align:middle;">
                        <asp:ImageButton runat="server" ID="btnList" OnClientClick="openWinContentTemplate(); return false;"
                            Height="30px" Width="35px" ImageUrl="~/Images/list.png" >                            
                        </asp:ImageButton>                                                 
                    </td>
                    <td style="vertical-align:middle; margin-left:10px">
                        <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClick="btnNew_Click"
                            Height="37px" Width="49px" ImageUrl="~/Images/add.png">
                        </asp:ImageButton>
                    </td>
                    <%--<td style="vertical-align:middle; margin-left:20px">
                        <asp:ImageButton runat="server" ID="btnEdit" AlternateText="Edit" OnClick="btnEdit_Click"
                            Height="25px" Width="30px" ImageUrl="~/Images/edit.png">
                        </asp:ImageButton>
                    </td>--%>
                    <td style="vertical-align:middle; margin-left:10px;padding-left:0px">
                        <asp:ImageButton runat="server" ID="btnSave" AlternateText="Save" OnClick="btnSave_Click"
                            Height="37px" Width="38px" ImageUrl="~/Images/save.png">
                        </asp:ImageButton>
                    </td>
                    <%--<td style="vertical-align:middle; margin-left:20px">
                        <asp:ImageButton runat="server" ID="btn_cancel" AlternateText="Cancel"
                            Height="28px" Width="34px" ImageUrl="~/Images/Undo.png">
                        </asp:ImageButton>
                    </td>--%>
                    <td style="width:89%; text-align:right">
                        <telerik:RadLabel ID="lbl_form_name" Text="User Request" runat="server" style="font-weight:lighter; 
                            font-variant: small-caps; padding-left:10px; 
                        padding-bottom:13px; font-size:x-large; color:Highlight"></telerik:RadLabel>
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
                                    UR Number:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_ur_number" runat="server" Width="150px" Enabled="false" RenderMode="Lightweight"
                                        AutoPostBack="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>             
                            <tr>
                                <td class="tdLabel">
                                    UR Date:
                                </td>
                                <td>
                                <telerik:RadDatePicker ID="dtp_ur"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                    TabIndex="4" Skin="Silk"> 
                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Metro" 
                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                    </DateInput>
                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                </telerik:RadDatePicker>
                            </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Excute Date:
                                </td>
                                <td>
                                <telerik:RadDatePicker ID="dtp_exe" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                    TabIndex="4" Skin="Silk">
                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                        FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Metro"></Calendar>
                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                    </DateInput>
                                    <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                </telerik:RadDatePicker>
                            </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    UR Status:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ur_status" runat="server" Width="150"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Metro"
                                        OnItemsRequested="cb_ur_status_ItemsRequested" OnPreRender="cb_ur_status_PreRender"
                                        OnSelectedIndexChanged="cb_ur_status_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Priority:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="150"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Metro"
                                     OnPreRender="cb_priority_PreRender" OnItemsRequested="cb_priority_ItemsRequested"
                                        OnSelectedIndexChanged="cb_priority_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Tipe:
                                </td>
                                <td>
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_ur_type" runat="server" Width="150"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="false" Skin="Metro" EnableVirtualScrolling="true"
                                        OnPreRender="cb_ur_type_PreRender" OnItemsRequested="cb_ur_type_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_ur_type_SelectedIndexChanged" >
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
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="300" DropDownWidth="300px"
                                        AutoPostBack="true" ShowMoreResultsBox="true" EmptyMessage="- Select a Project -" EnableLoadOnDemand="True" Skin="MetroTouch"  
                                         OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                         OnPreRender="cb_project_PreRender" >
                                    </telerik:RadComboBox>               
                                </td>
                            </tr>
                            <tr >
                                <td class="tdLabel">
                                    Cost Ctr:
                                </td>
                                <td style="vertical-align:top; text-align:left">                                   
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cost_center" runat="server" Width="250px" DropDownWidth="300px"
                                      EnableLoadOnDemand="True" Skin="MetroTouch" ShowMoreResultsBox="false" EnableVirtualScrolling="false" 
                                       EmptyMessage="- Select a cost Center -" OnItemsRequested="cb_cost_center_ItemsRequested" OnSelectedIndexChanged="cb_cost_center_SelectedIndexChanged"
                                         OnPreRender="cb_cost_center_PreRender" >
                                    </telerik:RadComboBox>                
                                </td>
                            </tr>
                            <tr>
                                <td class="tdLabel">
                                    Request By:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_request" runat="server" Width="250px" 
                                            DropDownWidth="650px" EmptyMessage="- Select -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                             MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true" 
                                                 OnItemsRequested="cb_request_ItemsRequested" OnSelectedIndexChanged="cb_request_SelectedIndexChanged"
                                                OnPreRender="cb_request_PreRender" >
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
                                                    <%--A total of
                                                    <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                    items--%>
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
                                <td class="tdLabel">
                                    Approved By:
                                </td>
                                <td style="vertical-align:top; text-align:left">
                                  <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_approved" runat="server" Width="250px" 
                                            DropDownWidth="650px" EmptyMessage="- Select -" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                             MarkFirstMatch="true" Skin="MetroTouch" EnableVirtualScrolling="true" 
                                               OnItemsRequested="cb_approved_ItemsRequested" OnSelectedIndexChanged="cb_approved_SelectedIndexChanged"
                                                OnPreRender="cb_approved_PreRender" >  
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
                                                    <%--A total of
                                                    <asp:Literal runat="server" ID="RadComboItemsCount" />
                                                    items--%>
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
                                <td class="tdLabel">
                                    Remark:
                                </td>                
                                <td style="vertical-align:top; text-align:left">                               
                                    <telerik:RadTextBox ID="txt_remark" 
                                        runat="server" TextMode="MultiLine"
                                        Width="450px" Rows="0" TabIndex="5" Resize="Both">
                                    </telerik:RadTextBox>                                  
                                </td>
                            </tr>
                        </table>           
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
                                <td style="padding-right:5px">
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
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                      <ContentTemplate>
                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" AutoGenerateColumns="false" PageSize="5"
                                AllowPaging="true" AllowSorting="true" runat="server"  OnNeedDataSource="RadGrid2_NeedDataSource" 
                                AllowAutomaticUpdates="true" AllowAutomaticInserts="True" ShowStatusBar="true" OnInsertCommand="RadGrid2_save_handler"
                                 OnUpdateCommand="RadGrid2_save_handler" OnDeleteCommand="RadGrid2_DeleteCommand" ClientSettings-Selecting-AllowRowSelect="true">   
                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="part_code" Font-Size="12px" EditMode="InPlace"
                                    ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" >                                             
                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" />                                        
                                    <Columns>   
                                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                                            HeaderText="Edit" HeaderStyle-Width="60px" UpdateText="Update">
                                        </telerik:GridEditCommandColumn>                        
                                        <telerik:GridTemplateColumn UniqueName="prod_code" HeaderText="Product Code" HeaderStyle-Width="120px"
                                            SortExpression="prod_code" ItemStyle-Width="320px">
                                            <FooterTemplate>Template footer</FooterTemplate>
                                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <%#DataBinder.Eval(Container.DataItem, "part_code")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cb_prod_code" EnableLoadOnDemand="True" DataTextField="spec"
                                                    OnItemsRequested="cb_prod_code_ItemsRequested" DataValueField="prod_code" AutoPostBack="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.part_code") %>'
                                                    HighlightTemplatedItems="true" Height="190px" Width="120px" DropDownWidth="450px"
                                                    OnSelectedIndexChanged="cb_prod_code_SelectedIndexChanged" OnPreRender="cb_prod_code_PreRender">
                                                    <HeaderTemplate>
                                                        <ul>
                                                            <li class="col1">Prod. Code</li>
                                                            <li class="col2">Prod. Name</li>
                                                        </ul>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <ul>
                                                            <li class="col1" >
                                                                <%# DataBinder.Eval(Container, "Value")%>
                                                            </li>
                                                            <li class="col2">
                                                                <%# DataBinder.Eval(Container, "Attributes['spec']")%></li>
                                                        </ul>
                                                    </ItemTemplate>
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                            
                                        <telerik:GridTemplateColumn HeaderText="Part Name" ItemStyle-Width="280px">
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "spec")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_prod_name" Width="280px" ReadOnly="true"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.spec") %>'>
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn> 
                                        <telerik:GridTemplateColumn HeaderText="Qty" ItemStyle-Width="120px">
                                            <ItemTemplate>  
                                                <%#DataBinder.Eval(Container.DataItem, "part_qty")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadNumericTextBox RenderMode="Lightweight" runat="server" ID="txt_qty" Width="110px"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.part_qty") %>'>
                                                </telerik:RadNumericTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn> 
                                        <telerik:GridTemplateColumn HeaderText="UoM" ItemStyle-Width="100px">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "part_unit")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="100px" runat="server" ID="cb_uom_d"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.part_unit") %>'
                                        EnableLoadOnDemand="True" Skin="MetroTouch" DataTextField="part_unit" DataValueField="part_unit" >
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Cost Center" ItemStyle-Width="220px">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "dept_code")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox RenderMode="Lightweight" DropDownWidth="220px" runat="server" ID="cb_dept_d"
                                        EnableLoadOnDemand="True" Skin="MetroTouch" DataTextField="name" DataValueField="CostCenter"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>'
                                        OnItemsRequested="cb_cost_center_ItemsRequested" OnPreRender="cb_dept_d_PreRender"
                                         OnSelectedIndexChanged="cb_cost_center_SelectedIndexChanged" >
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>    
                            <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="400px">
                                <ItemTemplate>  
                                    <%#DataBinder.Eval(Container.DataItem, "remark")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txt_remark_d" Width="400px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
                                    </telerik:RadTextBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn> 
                            <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" 
                                ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px">
                            </telerik:GridButtonColumn>
                                        <%--<telerik:GridButtonColumn UniqueName="Delete" CommandName="Delete" HeaderStyle-Width="35px" 
                        ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>--%>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings>
                        <ClientEvents OnRowDblClick="rowDblClick"/>
                    </ClientSettings>
                 </telerik:RadGrid>
                      </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="RadGrid2">
                        </asp:AsyncPostBackTrigger>
                    </Triggers>
                </asp:UpdatePanel>
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
