<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="pro00h09.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.MineControlProduction.TimeCategory.pro00h09" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
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
         OnNeedDataSource ="RadGrid1_NeedDataSource" OnInsertCommand ="RadGrid1_InsertCommand" OnUpdateCommand ="RadGrid1_UpdateCommand"
        OnDeleteCommand ="RadGrid1_DeleteCommand" Skin ="MetroTouch" OnItemCreated ="RadGrid1_ItemCreated"
         MasterTableView-CommandItemDisplay="Top" MasterTableView-DataKeyNames="time_code" MasterTableView-ClientDataKeyNames="time_code" 
        MasterTableView-AllowFilteringByColumn="True" AllowSorting="True">
        <MasterTableView>
            <Columns>
          
                <telerik:GridEditCommandColumn UniqueName ="EditCommandColumn">
                    <HeaderStyle Width ="15px" ></HeaderStyle>
                    <ItemStyle Width = "15px" />
                </telerik:GridEditCommandColumn>
                 <telerik:GridBoundColumn HeaderText ="Code" DataField ="time_code" >
                    <HeaderStyle Width ="100px" > </HeaderStyle>
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn HeaderText ="Time Category" DataField ="time_name" >
                    <HeaderStyle Width ="420px" > </HeaderStyle>
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn HeaderText ="Type" DataField ="cat_code" >
                    <HeaderStyle Width ="420px" > </HeaderStyle>
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn HeaderText ="Remark" DataField ="remark" >
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
                    <telerik:RadTextBox ID="txt_time_code" runat="server" Width="150px" Enabled="true"
                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.time_code") %>' AutoPostBack="false"></telerik:RadTextBox>

                </td>
            </tr>
            <tr>
                <td>
                    Category:
                </td>
                <td>
                    <telerik:RadTextBox ID="txt_time_name" runat="server" Width="350px" Enabled="true"
                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.time_name") %>'  AutoPostBack="false"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Type:
                </td>
            <td>
                    <telerik:RadComboBox ID="cb_type" runat="server" RenderMode="Lightweight" Width ="200px"
                    Text='<%# DataBinder.Eval(Container, "DataItem.pay_code") %>' 
                        OnItemsRequested ="cb_type_ItemsRequested" OnSelectedIndexChanged ="cb_type_SelectedIndexChanged"
                    EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_type_PreRender"
                    EnableVirtualScrolling="false" ShowMoreResultsBox="true"
                    AutoPostBack="false" Skin ="MetroTouch"
                    Height="200" MarkFirstMatch="true">
                </telerik:RadComboBox>
                                   
            </td>
            </tr>
            <tr>
                <td>
                    Remark:
                </td>
                <td>
                    <telerik:RadTextBox ID="txt_remark" runat="server" Width="420px" Enabled="true"
                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>' AutoPostBack="false"></telerik:RadTextBox>

                </td>
            </tr>
            <tr>
              
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
