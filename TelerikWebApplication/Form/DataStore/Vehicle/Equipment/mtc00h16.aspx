<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc00h16.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Vehicle.Equipment.mtc00h16" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl"/>
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
            </AjaxSettings>
        </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>

    <div class="scroller">
        <div style="overflow-x:auto">
            <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" ShowFooter="true" 
                AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" Width="1600px"
                MasterTableView-AllowFilteringByColumn="true" MasterTableView-CommandItemDisplay="Top" 
                OnNeedDataSource="RadGrid1_NeedDataSource" OnItemCreated="RadGrid1_ItemCreated" >

                <MasterTableView DataKeyNames="unit_code" Font-Names="Calibri" Font-Size="13px">
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                            <HeaderStyle Width="20px" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn HeaderText="Unit Code" DataField="unit_code">
                            <HeaderStyle Width="70px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Project Area" DataField="region_name">
                            <HeaderStyle Width="180px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Class" DataField="class_name">
                            <HeaderStyle Width="50px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Model" DataField="model_no">
                            <HeaderStyle Width="70px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Manufacture" DataField="manu_name">
                            <HeaderStyle Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="SN" DataField="key_no">
                            <HeaderStyle Width="70px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Engine Model" DataField="engine_no">
                            <HeaderStyle Width="70px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Status Condition" DataField="equ_status">
                            <HeaderStyle Width="70px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Purchase Date" DataField="pur_date">
                            <HeaderStyle Width="40px" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn HeaderText="Receive Date" DataField="arr_date">
                            <HeaderStyle Width="40px" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn HeaderText="Status" DataField="con_status">
                            <HeaderStyle Width="40px" />                             
                        </telerik:GridBoundColumn>

                        <telerik:GridButtonColumn UniqueName="Delete" CommandName="Delete" HeaderStyle-Width="35px" 
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                            <HeaderStyle Width="35px" />
                        </telerik:GridButtonColumn>
                    </Columns>

                    <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                            <table id="table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                                        padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
                                <tr class="EditFormHeader">
                                    <td colspan="2">
                                        <b>Master Compartement</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table id="Table3" border="0" class="module">
                                            <tr style="text-align:left">
                                                <td>Unit Code
                                                </td>
                                                <td>
                                                     <telerik:RadTextBox ID="txt_equipment_code" runat="server" RenderMode="Lightweight" Width="120px" Enabled="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.unit_code") %>' AutoPostBack="false" >
                                                     </telerik:RadTextBox>
                                                </td>
                                                <td style="text-align:left">
                                                     <telerik:RadTextBox ID="txt_equipment_Name" runat="server" RenderMode="Lightweight" Width="280px" Enabled="true"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.unit_name") %>' AutoPostBack="false" >
                                                     </telerik:RadTextBox>    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <tr>
                                                        <td>Type
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadComboBox ID="cb_type" runat="server" RenderMode="Lightweight" Width ="250px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.type_name") %>'                                
                                                                EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch"
                                                                Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Kind
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadComboBox ID="cb_kind" runat="server" RenderMode="Lightweight" Width ="250px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.kind_name") %>'             
                                                                EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch"
                                                                Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Manufacture
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadComboBox ID="cb_manufacture" runat="server" RenderMode="Lightweight" Width ="250px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.manu_name") %>'             
                                                                EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch"
                                                                Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Model No
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadComboBox ID="cb_model" runat="server" RenderMode="Lightweight" Width ="250px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.model_no") %>'                                
                                                                EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch"
                                                                Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Status
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadComboBox ID="cb_status" runat="server" RenderMode="Lightweight" Width ="250px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.equ_status") %>'             
                                                                EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch"
                                                                Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <%--<tr>
                                                        <td>
                                                            Category
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="cb_category" runat="server" RenderMode="Lightweight" Width ="250px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.manu_name") %>'             
                                                                EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch"
                                                                Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>--%>
                                                    <tr>
                                                        <td>
                                                            Reading Type
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadComboBox ID="cb_reading_type" runat="server" RenderMode="Lightweight" Width ="250px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.reading_code") %>'             
                                                                EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch"
                                                                Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Std. Operation
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadTextBox ID="txt_std_opr" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.hour_avai") %>' AutoPostBack="false" >
                                                             </telerik:RadTextBox>
                                                        </td>
                                                    </tr>                                                 

                                                </td>
                                                <td>
                                                     <tr>
                                                        <td>Class
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadComboBox ID="cb_class" runat="server" RenderMode="Lightweight" Width ="250px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.class_name") %>'                                
                                                                EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch"
                                                                Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Engine No
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadTextBox ID="txt_engine_no" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.engine_no") %>' AutoPostBack="false" >
                                                             </telerik:RadTextBox>
                                                        </td>
                                                    </tr>  
                                                    <tr>
                                                        <td>
                                                            Engine Model
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadTextBox ID="txt_engine_model" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.engine_size") %>' AutoPostBack="false" >
                                                             </telerik:RadTextBox>
                                                        </td>
                                                    </tr>  <tr>
                                                        <td>
                                                            S/N
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadTextBox ID="txt_sn" runat="server" RenderMode="Lightweight" Width="80px" Enabled="true"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.key_no") %>' AutoPostBack="false" >
                                                             </telerik:RadTextBox>
                                                        </td>
                                                    </tr>  <tr>
                                                        <td>
                                                            Project
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadComboBox ID="cb_project" runat="server" RenderMode="Lightweight" Width ="250px"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>'
                                                                EnableVirtualScrolling="true" ShowMoreResultsBox="true" AutoPostBack="false" Skin ="MetroTouch"
                                                                Height="200" MarkFirstMatch="true" EnableLoadOnDemand="True">                                        
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>  <tr>
                                                        <td>
                                                            Cost Center
                                                        </td>
                                                        <td colspan="3">
                                                           <telerik:RadComboBox RenderMode="Lightweight" ID="cb_cost_center" runat="server" Width="120px" DropDownWidth="100px"                                                               
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.dept_code") %>'
                                                                EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Skin="Metro" >
                                                            </telerik:RadComboBox>   
                                                        </td>
                                                    </tr>  
                                                    <tr>
                                                        <td>
                                                            Supplier
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="120px" DropDownWidth="300px"
                                                              Text='<%# DataBinder.Eval(Container, "DataItem.supplier_name") %>'      
                                                                EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Skin="Metro" >
                                                            </telerik:RadComboBox>   
                                                        </td>
                                                    </tr> 
                                                    <tr>
                                                        <td>
                                                            Asset Code
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_asset_code" runat="server" Width="120px" DropDownWidth="300px"
                                                                    EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Skin="Metro" >
                                                            </telerik:RadComboBox>   
                                                        </td>
                                                    </tr> 
                                                    <tr>
                                                        <td>
                                                            PIC
                                                        </td>
                                                        <td colspan="3">
                                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_pic" runat="server" Width="120px" DropDownWidth="300px"
                                                                    EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Skin="Metro" >
                                                            </telerik:RadComboBox>   
                                                        </td>
                                                    </tr>    
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2"  style="padding-top:10px">
                                        <asp:Button ID="btnupdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' 
                                             runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' />                                                                               
                                         <asp:Button ID="btncancel" Text="Cancel" runat="server" CausesValidation="false" CommandName="Cancel" />
                                    </td>
                                </tr>
                            </table>
                        </FormTemplate>
                    </EditFormSettings>
                </MasterTableView>
                <FilterMenu RenderMode="Lightweight"></FilterMenu>
            </telerik:RadGrid>
        </div>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="UserListDialog" runat="server" Title="Editing Record"
                     Height="490px" Width="850px" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>    
    </div>
</asp:Content>
