<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h09.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Controlling.Project.inv00h09" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />

    <%-- <script type="text/javascript">
        function ShowEditForm(id, rowIndex) {
            var grid = $find("<%=RadGrid1.ClientID %>");

            var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
            grid.get_masterTableView().selectItem(rowControl, true);

            window.radopen("edit_form.aspx?region_code=" + id, "UserListDialog");
            return false;
        }
    </script>--%>
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
     <div style="overflow:auto">
    <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="True" 
        ShowFooter ="true" 
        AutoGenerateColumns="False" MasterTableView-AutoGenerateColumns="False"
         OnNeedDataSource ="RadGrid1_NeedDataSource"   OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand ="RadGrid1_UpdateCommand"
        OnDeleteCommand="RadGrid1_DeleteCommand" Skin ="MetroTouch" OnItemCreated ="RadGrid1_ItemCreated"
         MasterTableView-CommandItemDisplay="Top" MasterTableView-DataKeyNames="region_code" MasterTableView-ClientDataKeyNames="region_code" 
        MasterTableView-AllowFilteringByColumn="True" AllowSorting="True">
        <MasterTableView>
            <Columns>
           <%-- <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" AllowFiltering="False" 
                ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                <asp:LinkButton ID="EditLink" runat="server" Text="Edit"></asp:LinkButton>
                    </ItemTemplate> </telerik:GridTemplateColumn>--%>
                <telerik:GridEditCommandColumn UniqueName ="EditCommandColumn">
                    <HeaderStyle Width ="20px" ></HeaderStyle>
                </telerik:GridEditCommandColumn>
                 <telerik:GridBoundColumn HeaderText ="Code" DataField ="region_code" >
                    <HeaderStyle Width ="200px" > </HeaderStyle>
                </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn HeaderText ="Project Area" DataField ="region_name" >
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
                    <telerik:RadTextBox ID="txt_region_code" runat="server" Width="150px" Enabled="true"
                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.region_code") %>' AutoPostBack="false"></telerik:RadTextBox>

                </td>
            </tr>
            <tr>
                <td>
                    Project Area:
                </td>
                <td>
                    <telerik:RadTextBox ID="txt_region_name" runat="server" Width="350px" Enabled="true"
                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>'  AutoPostBack="false"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
              <%--  <td>
                    Satuan:
                </td>
                <td>
                    <telerik:RadComboBox ID="cb_stuan" runat="server" RenderMode="Lightweight" Width ="150"
                        Text='<%# DataBinder.Eval(Container, "DataItem.unit_name") %>' 
                         OnItemsRequested ="cb_stuan_ItemsRequested" OnSelectedIndexChanged ="cb_stuan_SelectedIndexChanged"
                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender="cb_stuan_PreRender"
                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                        CssClass="combo" AutoPostBack="true" Skin="Office2010Silver"
                        Height="200" MarkFirstMatch="true">

                    </telerik:RadComboBox>
                </td>
            </tr>--%>
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
