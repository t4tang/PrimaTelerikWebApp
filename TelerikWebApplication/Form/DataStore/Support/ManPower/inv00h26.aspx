<%@ Page Title="PRIMA SYSTEM" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h26.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Support.ManPower.inv00h26" %>
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
                            <telerik:RadLabel ID="lbl_form_name" Text="Master Manpower" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
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
            ShowFooter ="False" CssClass="RadGrid_ModernBrowsers"
            AutoGenerateColumns="False" MasterTableView-AutoGenerateColumns="False" 
             OnNeedDataSource ="RadGrid1_NeedDataSource" OnItemCreated="RadGrid1_ItemCreated"
             OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand" 
             OnDeleteCommand="RadGrid1_DeleteCommand" Skin ="Silk"
             MasterTableView-CommandItemDisplay="Top" MasterTableView-DataKeyNames="Nik"  
            MasterTableView-AllowFilteringByColumn="True" AllowSorting="True">
            <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
            <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Century Gothic">
                <Columns>              
                    <telerik:GridEditCommandColumn UniqueName ="EditCommandColumn">
                        <HeaderStyle Width ="15px" ></HeaderStyle>
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText ="NIK" DataField ="Nik" >
                        <HeaderStyle Width ="50px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Employee Name" DataField ="Name" >
                        <HeaderStyle Width ="350px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn HeaderText ="Employee No" DataField ="EmpNo" >
                        <HeaderStyle Width ="80px" > </HeaderStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Position" DataField ="Jabatan">
                        <HeaderStyle Width ="220px" > </HeaderStyle>
                    </telerik:GridBoundColumn>     
                    <telerik:GridBoundColumn HeaderText ="Poject" DataField ="region_name">
                        <HeaderStyle Width ="280px" > </HeaderStyle>
                    </telerik:GridBoundColumn> 
                                      
                    <telerik:GridButtonColumn UniqueName ="DeleteColumn" Text ="Delete" CommandName="Delete" HeaderStyle-Width="30px"
                        ConfirmText="Delete This Product?" ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="FontIconButton">
                        <HeaderStyle Width="30px"></HeaderStyle>
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table id="Table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                            padding-top:12px; padding-bottom:5px; background-color: #F0FFFE; margin:5px">
                            <tr >
                                <td>
                                    Code:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_Code" runat="server" Width="80px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.Nik") %>' AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px">
                                    Gender :
                                </td>
                                <td style="padding-left:10px">
                                    <asp:RadioButtonList ID="rb_gender" SelectedValue='<%# DataBinder.Eval(Container, "DataItem.stGender") %>' 
                                        RepeatDirection="Horizontal" runat="server" OnDataBound="MyRadioButtonList_DataBound">
                                        <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                        <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Employee Number:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_EmpNo" runat="server" Width="100px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.EmpNo") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px">
                                    Marital Status :
                                </td>
                                <td style="padding-left:10px">
                                    <telerik:RadComboBox ID="cb_maritalSts" runat="server" RenderMode="Lightweight" Width ="75px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.stMarital") %>' 
                                        OnItemsRequested="cb_maritalSts_ItemsRequested"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="false"
                                         AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">

                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Employee Name:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_EmpName" runat="server" Width="250px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.Name") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                                <td style="padding-left:15px">
                                    Employee Status:
                                </td>
                                <td style="padding-left:10px">
                                    <asp:RadioButtonList ID="rb_EmpSts" SelectedValue='<%# DataBinder.Eval(Container, "DataItem.stEmployee") %>' 
                                        RepeatDirection="Horizontal" runat="server" OnDataBound="MyRadioButtonList_DataBound">
                                        <asp:ListItem Text="Permanen" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Percobaan" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Harian" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Kontrak" Value="4"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Position :
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_position" runat="server" RenderMode="Lightweight" Width ="250px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.jabatan") %>' 
                                        OnItemsRequested="cb_position_ItemsRequested" OnPreRender="cb_position_PreRender"
                                        OnSelectedIndexChanged="cb_position_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                            AutoPostBack="false" Skin ="MetroTouch" EnableLoadOnDemand="true"
                                        Height="200" MarkFirstMatch="true">

                                    </telerik:RadComboBox>
                                </td>
                                <td style="padding-left:15px">
                                    Status:
                                </td>
                                <td style="padding-left:10px">
                                    <asp:RadioButtonList ID="rb_status" SelectedValue='<%# DataBinder.Eval(Container, "DataItem.status") %>' 
                                        RepeatDirection="Horizontal" runat="server" OnDataBound="MyRadioButtonList_DataBound">
                                        <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Resign" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="PHK" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Mutasi" Value="4"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Project Area:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_region" runat="server" RenderMode="Lightweight" Width ="350px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>' 
                                        OnPreRender="cb_project_PreRender" OnItemsRequested="cb_project_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                        EnableLoadOnDemand="true" ShowDropDownOnTextboxClick="true"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                         AutoPostBack="false" Skin ="MetroTouch"
                                        Height="200" MarkFirstMatch="true">

                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Departemen:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_dept" runat="server" RenderMode="Lightweight" Width ="350px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.dept_name") %>' 
                                        OnPreRender="cb_dept_PreRender" OnItemsRequested="cb_dept_ItemsRequested"
                                        OnSelectedIndexChanged="cb_dept_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                         AutoPostBack="false" Skin ="MetroTouch" EnableLoadOnDemand="true"
                                        Height="200" MarkFirstMatch="true">

                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    Point Of Hire :
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cb_poh" runat="server" RenderMode="Lightweight" Width ="350px"
                                        Text='<%# DataBinder.Eval(Container, "DataItem.city_name") %>' 
                                        OnPreRender="cb_poh_PreRender" OnItemsRequested="cb_poh_ItemsRequested" 
                                        OnSelectedIndexChanged="cb_poh_SelectedIndexChanged"
                                        EnableVirtualScrolling="true" ShowMoreResultsBox="true"
                                         AutoPostBack="false" Skin ="MetroTouch" EnableLoadOnDemand="true"
                                        Height="200" MarkFirstMatch="true">

                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Date Of Hire :
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtp_hire" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        SelectedDate='<%# DataBinder.Eval(Container, "DataItem.tgl_terima") %>'
                                        TabIndex="4" Skin="Silk">
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" 
                                            FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Silk"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    KPJ No:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_kpj_no" runat="server" Width="150px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.kpj_no") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    NPWP:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_npwp" runat="server" Width="250px" Enabled="true"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.NPWP") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Remark :
                                </td>
                                <td colspan="3">
                                    <telerik:RadTextBox ID="txt_remark" runat="server" Width="550px" Enabled="true" TextMode="MultiLine"
                                        RenderMode="Lightweight" Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr >
                                <td colspan="3" style="padding-top:15px;padding-bottom:15px">
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
            <FilterMenu RenderMode="Lightweight"></FilterMenu>
        </telerik:RadGrid>
        
    </div>
</asp:Content>
