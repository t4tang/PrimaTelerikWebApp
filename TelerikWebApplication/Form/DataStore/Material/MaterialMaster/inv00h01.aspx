<%@ Page Title="PRIMA SYSTEM" Language="C#"  MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h01.aspx.cs" Inherits="TelerikWebApplication.Form.Master_data.Material.Material_master.material_master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function RowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
 
            function onPopUpShowing(sender, args) {
                args.get_popUp().className += " popUpEditForm";
            }
        </script>
    </telerik:RadCodeBlock>

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

    <telerik:RadFormDecorator RenderMode="Native" ID="RadFormDecorator1" runat="server" DecorationZoneID="demo" DecoratedControls="All" 
        EnableRoundedCorners="false" Visible="false" />

    <div style="overflow:auto">        
        <!-- Page Content -->
             <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" Skin="MetroTouch"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnUpdateCommand="RadGrid1_UpdateCommand"
                OnInsertCommand="RadGrid1_InsertCommand" OnDeleteCommand="RadGrid1_DeleteCommand" BorderStyle="Solid" Font-Names="Calibri"
                 AllowFilteringByColumn="true" >
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                    <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="prod_code" Font-Size="12px"
                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true">                        
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="prod_code" HeaderText="Material Code" DataField="prod_code">
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridBoundColumn>                        
                        <telerik:GridBoundColumn UniqueName="spec" HeaderText="Specification" DataField="spec">
                            <HeaderStyle Width="250px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="unit" HeaderText="UOM" DataField="unit">
                            <HeaderStyle Width="250px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="brand_name" HeaderText="Manufacture" DataField="brand_name">
                            <HeaderStyle Width="250px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="group_name" HeaderText="Group" DataField="group_name">
                            <HeaderStyle Width="250px"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" 
                            ConfirmText="Are you sure you want to delete this row or record?">
                             <HeaderStyle Width="20px"></HeaderStyle>
                        </telerik:GridButtonColumn>
                    </Columns>
                   
                    <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                            <table id="Table2" cellspacing="2" cellpadding="1" width="100%" border="0" rules="none" 
                                style="border-collapse: collapse; padding-left:35px; padding-top:7px; padding-bottom:5px; background-color: #F0FFFE;">
                                   
                                <tr class="EditFormHeader">
                                    <td >
                                        <b style="font-weight: bold; font-variant: small-caps; text-decoration: underline; color: #990000;">General Info</b>
                                    </td>
                                    <td style="border-collapse: collapse; padding-left:35px;">
                                        <b style="font-weight: bold; font-variant: small-caps; text-decoration: underline; color: #990000;">Purchase</b>
                                    </td>
                                </tr>
                                    
                                <tr>        
                                    <td>
                                        <table id="Table3" border="0" class="module">                
                                            <tr>
                                                <td>Material Code:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_material_code" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>'>
                                                    </asp:TextBox>
                                                </td>
                                            </tr>             
                                            <tr>
                                                <td>Specification:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_specification" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.spec") %>'>
                                                    </asp:TextBox>
                                                </td>
                                            </tr> 
                                            <tr>
                                                <td>Unit of Measure:
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_uom" runat="server" Width="300" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.unit") %>'
                                                        EmptyMessage="Select the UoM" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                        EnableVirtualScrolling="true" OnItemsRequested="cb_uom_ItemsRequested" DataValueField="unit" 
                                                        OnSelectedIndexChanged="cb_uom_SelectedIndexChanged">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr> 
                                                <tr>
                                                <td>Brand:
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_brand" Width="300" runat="server"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.brand_name") %>'
                                                        EmptyMessage="Select the brand" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                        EnableVirtualScrolling="true" OnItemsRequested="cb_brand_ItemsRequested" OnSelectedIndexChanged="cb_brand_SelectedIndexChanged" >
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Category:
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_category" runat="server" Width="300"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.kind_name") %>'
                                                        EmptyMessage="Select the category" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                        EnableVirtualScrolling="true" OnItemsRequested="cb_category_ItemsRequested" OnSelectedIndexChanged="cb_category_SelectedIndexChanged" >
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td>Group:
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_group" runat="server" Width="300"
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.group_name") %>'
                                                        EmptyMessage="Select the group" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                        EnableVirtualScrolling="true" OnItemsRequested="cb_group_ItemsRequested" OnSelectedIndexChanged="cb_group_SelectedIndexChanged" >
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>  
               
                                            <tr>
                                                <td>
                                                    Status Maintenance:
                                                </td>
                                                <td>
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="cb_st_main" runat="server" 
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.stMain") %>' 
                                                        AutoPostBack="false" Width="300px" AllowCustomText="false"
                                                        EmptyMessage="Select the status maintenance" EnableLoadOnDemand="True" ShowMoreResultsBox="True"
                                                        EnableVirtualScrolling="true" OnItemsRequested="cb_st_main_ItemsRequested" >

                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="border-collapse: collapse; padding-left:35px; vertical-align:top">
                                        <table >                                           
                                            
                                            <tr>
                                                <td>Min Stock:</td>
                                                <td>
                                                    <asp:TextBox ID="txt_min_stock" runat="server"  Text='<%# DataBinder.Eval(Container, "DataItem.QtyMin") %>'>
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Min Purchase:</td>
                                                <td>
                                                    <asp:TextBox ID="txt_min_purchase" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.QtyMinPur") %>'>
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="title" style="font-weight: bold;" colspan="2">
                                                    <br />
                                                    <b style="font-weight: bold; font-variant: small-caps; text-decoration: underline; color: #990000;">Sales:</b>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Selling Price:

                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_selling_price" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.price_sale") %>'>
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Sales forecast:</td>
                                                <td>
                                                    <asp:TextBox ID="txt_sales_forecast" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SalesFore") %>'>
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="border-collapse: collapse; padding-left:35px;; vertical-align:top">
                                        <table>
                                             <tr>
                                                <td>
                                                    <asp:CheckBox ID="chk_use_SN" runat="server" Text="Use Serial Number" Skin="Telerik" AutoPostback="false"
                                                        Checked='<%# DataBinder.Eval (Container, "DataItem.tSN").ToString()!="0"?true:false %>'/>
                                                   
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:CheckBox ID="chk_active" runat="server" Text="Active" Skin="Telerik" AutoPostback="false"
                                                        Checked='<%# DataBinder.Eval (Container, "DataItem.tActive").ToString()!="0"?true:false %>'/>                                                   
                                                   
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:CheckBox ID="chk_warranty" runat="server" Text="Warranty" Skin="Telerik" AutoPostback="false"
                                                        Checked='<%# DataBinder.Eval (Container, "DataItem.tWarranty").ToString()!="0"?true:false %>'/>
                                                   
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:CheckBox ID="chk_monitoring_stock" runat="server" Text="Monitor" Skin="Telerik" AutoPostback="false"
                                                        Checked='<%# DataBinder.Eval (Container, "DataItem.tMonitor").ToString()!="0"?true:false %>'/>
                                                   
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:CheckBox ID="chk_consignment" runat="server" Text="Consignment" Skin="Telerik" AutoPostback="false"
                                                        Checked='<%# DataBinder.Eval (Container, "DataItem.tConsig").ToString()!="0"?true:false %>'/>
                                                   
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                    
                                <tr>
                                    <td colspan="2"></td>
                                </tr>

                                <tr>
                                    <td class="auto-style1"></td>
                                    <td></td>
                                </tr>

                                <tr>
                                    <td align="right" colspan="2">
                                        <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                            runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'></asp:Button>&nbsp;
                                        <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                                            CommandName="Cancel"></asp:Button>
                                    </td>
                                </tr>

                            </table>
                        </FormTemplate>
                    </EditFormSettings>
                        </MasterTableView>
                        <ClientSettings>
                            <ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />
                        </ClientSettings>
                </telerik:RadGrid>
       
    </div>
</asp:Content>
