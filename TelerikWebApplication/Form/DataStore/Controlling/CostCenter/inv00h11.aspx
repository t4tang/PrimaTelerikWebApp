<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h11.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Controlling.CostCenter.inv00h11" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>

</asp:Content>
 

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ConfiguratorPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>
     <div class="scroller">
    <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="True" 
        ShowFooter ="true" 
        AutoGenerateColumns="False" MasterTableView-AutoGenerateColumns="False" 
         OnNeedDataSource ="RadGrid1_NeedDataSource"   OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand ="RadGrid1_UpdateCommand"
        OnDeleteCommand="RadGrid1_DeleteCommand" Skin ="MetroTouch" OnItemCreated ="RadGrid1_ItemCreated"
         MasterTableView-CommandItemDisplay="Top" MasterTableView-DataKeyNames="CostCenter" MasterTableView-ClientDataKeyNames="CostCenter" 
        MasterTableView-AllowFilteringByColumn="True" AllowSorting="True">
        <MasterTableView>
            <Columns>
           <%-- <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" AllowFiltering="False" 
                ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                <asp:LinkButton ID="EditLink" runat="server" Text="Edit"></asp:LinkButton>
                    </ItemTemplate> </telerik:GridTemplateColumn>--%>
                <telerik:GridEditCommandColumn UniqueName ="EditCommandColumn">
                    <HeaderStyle Width ="15px" ></HeaderStyle>
                </telerik:GridEditCommandColumn>
                 <telerik:GridBoundColumn HeaderText ="Code" DataField ="CostCenter" >
                    <HeaderStyle Width ="100px" > </HeaderStyle>
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn HeaderText ="Cost Center" DataField ="CostCenterName" >
                    <HeaderStyle Width ="420px" > </HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn HeaderText ="Company" DataField ="company_name" Visible ="false" >
                    <HeaderStyle Width ="420px" > </HeaderStyle>
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn HeaderText ="Profit Center" DataField ="ProfitCtrName" Visible ="false" >
                    <HeaderStyle Width ="420px" > </HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn HeaderText ="Project Area" DataField ="region_name" >
                    <HeaderStyle Width ="420px" > </HeaderStyle>
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn HeaderText ="Person In Charge" DataField ="PersonIC" Visible ="false" >
                    <HeaderStyle Width ="420px" > </HeaderStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn HeaderText ="Divisi" DataField ="DivName" Visible ="false">
                    <HeaderStyle Width ="420px" > </HeaderStyle>
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn HeaderText ="Heirarchy" DataField ="Heirarchy" Visible ="false">
                    <HeaderStyle Width ="420px" > </HeaderStyle>
                </telerik:GridBoundColumn>
               
                <telerik:GridButtonColumn UniqueName ="DeleteColumn" Text ="Delete" CommandName="Delete" HeaderStyle-Width="30px"
                    ConfirmText="Delete This Product?" ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="FontIconButton">
                    <HeaderStyle Width="30px"></HeaderStyle>
                </telerik:GridButtonColumn>
            </Columns>
            <EditFormSettings EditFormType="Template">
                <FormTemplate>
                      <table id="Table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                                    padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
            <tr>
                <td>
                    Code:
                </td>
                <td>
                    <telerik:RadTextBox ID="txt_CostCenter" runat="server" Width="150px" Enabled="true"
                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.CostCenter") %>' AutoPostBack="false"></telerik:RadTextBox>

                </td>
            </tr>
            <tr>
                <td>
                    Cost Center:
                </td>
                <td>
                    <telerik:RadTextBox ID="txt_CostCenterName" runat="server" Width="350px" Enabled="true"
                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.CostCenterName") %>'  AutoPostBack="false"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td>
                    Company:
                </td>
                <td>
                    <telerik:RadComboBox ID="cb_company" runat="server" RenderMode="Lightweight" Width ="350px"
                        Text='<%# DataBinder.Eval(Container, "DataItem.company_name") %>' 
                         OnItemsRequested ="cb_company_ItemsRequested" OnSelectedIndexChanged ="cb_company_SelectedIndexChanged"
                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender="cb_company_PreRender"
                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                        AutoPostBack="false" Skin ="MetroTouch"
                        Height="200" MarkFirstMatch="true">

                    </telerik:RadComboBox>
                </td>
            </tr>
             <tr>
                <td>
                    Profit Center:
                </td>
                <td>
                    <telerik:RadComboBox ID="cb_profitCtr" runat="server" RenderMode="Lightweight" Width ="350px"
                        Text='<%# DataBinder.Eval(Container, "DataItem.ProfitCtrName") %>' 
                         OnItemsRequested ="cb_profitCtr_ItemsRequested" OnSelectedIndexChanged ="cb_profitCtr_SelectedIndexChanged"
                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_profitCtr_PreRender"
                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                         AutoPostBack="false" Skin ="MetroTouch"
                        Height="200" MarkFirstMatch="true">

                    </telerik:RadComboBox>
                </td>
                 </tr>
             <tr>
                <td>
                    Project Area:
                </td>
                <td>
                    <telerik:RadComboBox ID="cb_region" runat="server" RenderMode="Lightweight" Width ="350px"
                        Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' 
                         OnItemsRequested ="cb_region_ItemsRequested" OnSelectedIndexChanged ="cb_region_SelectedIndexChanged"
                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_region_PreRender"
                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                         AutoPostBack="false" Skin ="MetroTouch"
                        Height="200" MarkFirstMatch="true">

                    </telerik:RadComboBox>
                </td>
            </tr>
             <tr>
                <td>
                    Person In Charge:
                </td>
                <td>
                    <telerik:RadTextBox ID="txt_PersonIC" runat="server" Width="350px" Enabled="true"
                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.PersonIC") %>'  AutoPostBack="false"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td>
                    Category:
                </td>
                <td>
                    <telerik:RadComboBox ID="cb_category" runat="server" RenderMode="Lightweight" Width ="350px"
                        Text='<%# DataBinder.Eval(Container, "DataItem.DivName") %>' 
                         OnItemsRequested ="cb_category_ItemsRequested" OnSelectedIndexChanged ="cb_category_SelectedIndexChanged"
                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_category_PreRender"
                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                         AutoPostBack="false" Skin ="MetroTouch"
                        Height="200" MarkFirstMatch="true">

                    </telerik:RadComboBox>
                </td>
            </tr>
             <tr>
                <td>
                    Hirarchy:
                </td>
                <td>
                    <telerik:RadTextBox ID="txt_Heirarchy" runat="server" Width="350px" Enabled="true"
                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.Heirarchy") %>'  AutoPostBack="false"></telerik:RadTextBox>
                </td>
            </tr>
           
            <tr >
                <td align="right" colspan="2">
                    <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                    runat ="server" CommandName ='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' >
                        </asp:Button>&nbsp;
                    <asp:Button ID ="btnCancel" Text="Cancel" runat="server" CausesValidation ="false" CommandName="Cancel"> </asp:Button>
                </td>
            </tr>
        </table> 
                </FormTemplate>
            </EditFormSettings>     
        </MasterTableView>
    </telerik:RadGrid>
         </div>
</asp:Content>
