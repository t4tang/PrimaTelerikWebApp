<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h01list.aspx.cs" Inherits="TelerikWebApplication.Form.Inventory.UserRequest.inv01h01list" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        
        <div runat="server" style="padding:10px 10px 10px 10px;" id="searchParam">                
            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="Date From " Height="26px"></telerik:RadDatePicker>                
            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" CssClass="dtPicker" DateInput-Label="To Date " Height="26px"></telerik:RadDatePicker>
            <telerik:RadComboBox ID="cb_project_prm" runat="server" RenderMode="Lightweight" CssClass="combo" Label="Project" AutoPostBack="true"
                EnableLoadOnDemand="True" Skin="MetroTouch"  OnItemsRequested="cb_project_ItemsRequested" EnableVirtualScrolling="true" 
                Height="200" Width="315" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"
                OnSelectedIndexChanged="cb_project_SelectedIndexChanged"></telerik:RadComboBox>&nbsp
            &nbsp
            <telerik:RadButton ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
            Style="clear: both; margin: 0px 0; height:28px">
            </telerik:RadButton>    
        </div>
        <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="MetroTouch"
            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true" PageSize="10"
            OnNeedDataSource="RadGrid1_NeedDataSource" >
            <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
            <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="sro_code" Font-Size="12px" 
            EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true">
                <Columns>
                    <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" AllowFiltering="False" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:ImageButton ID="EditLink" runat="server" Text="Edit" ImageUrl="~/Images/modify.png" 
                                Width="15px" Height="15px" ImageAlign="Middle" />
                        </ItemTemplate>
                        <HeaderStyle Width="30px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
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
                           
                <CommandItemTemplate>
                    <a href="#" onclick="return ShowInsertForm();">Add New</a>
                </CommandItemTemplate>
                        
            </MasterTableView>
            <ClientSettings>                         
                <Selecting AllowRowSelect="true"></Selecting>
            </ClientSettings>
        </telerik:RadGrid>                
     
    </div>
    </form>
</body>
</html>
