<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="pur00h03.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Support.Expedition.pur00h03" %>
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
            <telerik:AjaxSetting AjaxControlID="btn_new">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>       
                <td style="vertical-align: middle; margin-left: 10px; padding:0px 0px 0px 0px">
                    <telerik:RadButton ID="btn_new" runat="server" ForeColor="OrangeRed" BackColor="#33ccff" Text="New" Width="80px" Height="30px"
                        Skin="Telerik" OnClick="btn_new_Click" ></telerik:RadButton>
                </td>                    
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                     
                </td>                           
                <td style="width: 98%; text-align: right; padding-right:17px">
                     <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <telerik:RadLabel ID="lbl_form_name" Text="Expedition" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                                padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                            </telerik:RadLabel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div> 
    
    <div class="scroller" style="overflow-y:scroll; height:620px"> 
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="True" 
            ShowFooter ="False" AutoGenerateColumns="False" MasterTableView-AutoGenerateColumns="False"
            OnNeedDataSource ="RadGrid1_NeedDataSource" OnInsertCommand ="RadGrid1_InsertCommand" OnUpdateCommand ="RadGrid1_UpdateCommand"
            OnDeleteCommand ="RadGrid1_DeleteCommand" Skin ="Silk" OnItemCreated ="RadGrid1_ItemCreated"
            MasterTableView-CommandItemDisplay="Top" MasterTableView-DataKeyNames="EXP_CODE" MasterTableView-ClientDataKeyNames="city_code" 
            MasterTableView-AllowFilteringByColumn="True" AllowSorting="True" CssClass="RadGrid_ModernBrowsers">
            <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
            <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName ="EditCommandColumn">
                        <HeaderStyle Width ="15px" ></HeaderStyle>
                        <ItemStyle Width = "15px" />
                    </telerik:GridEditCommandColumn>
                     <telerik:GridBoundColumn HeaderText ="Code" DataField ="EXP_CODE" >
                        <HeaderStyle Width ="100px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Expedition" DataField ="EXP_NAME" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Contact 1" DataField ="CONT1" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Contact 2" DataField ="CONT2" >
                        <HeaderStyle Width ="420px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn UniqueName ="DeleteColumn" Text ="Delete" CommandName="Delete" HeaderStyle-Width="30px"
                        ConfirmText="Delete This Product?" ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="FontIconButton">
                        <HeaderStyle Width="30px"></HeaderStyle>
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table id="Table2" cellspacing="4" cellpadding="5" width="100%" border="0" rules="none" class="formTemplate_Table">
                            <tr>
                                <td>
                                    Code:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_code" runat="server" Width="75px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.EXP_CODE") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Expedition:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_expedition" runat="server" Width="150px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.EXP_NAME") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Address:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_address" runat="server" Width="200px" Height="50px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.ADDR") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    City:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_city" runat="server" RenderMode="Lightweight" Width ="178px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.city_name") %>' 
                                        OnItemsRequested ="cb_city_ItemsRequested" OnSelectedIndexChanged ="cb_city_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true" OnPreRender ="cb_city_PreRender"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                        AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Phone:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_phone" runat="server" Width="150px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.TLP") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Fax:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_fax" runat="server" Width="150px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.FAX") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    E-Mail:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_email" runat="server" Width="150px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.EMAIL") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Website:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_website" runat="server" Width="150px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.WEBSITE") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Name:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_name1" runat="server" Width="150px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.CONT1") %>' AutoPostBack="false"></telerik:RadTextBox>
                                    &nbsp
                                    <telerik:RadTextBox ID="txt_name2" runat="server" Width="150px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.CONT2") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    HP:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_hp1" runat="server" Width="150px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.HP1") %>' AutoPostBack="false"></telerik:RadTextBox>
                                    &nbsp
                                    <telerik:RadTextBox ID="txt_hp2" runat="server" Width="150px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.HP2") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    E-Mail:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_email1" runat="server" Width="150px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.EMAIL1") %>' AutoPostBack="false"></telerik:RadTextBox>
                                    &nbsp
                                    <telerik:RadTextBox ID="txt_email2" runat="server" Width="150px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.EMAIL2") %>' AutoPostBack="false"></telerik:RadTextBox>
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
