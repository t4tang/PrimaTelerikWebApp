<%@ Page Title="PRIMA SYSTEM" Language="C#"  MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h01.aspx.cs" Inherits="TelerikWebApplication.Form.Master_data.Material.Material_master.material_master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
            <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
        </ContentTemplate>        
    </asp:UpdatePanel> 
   
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

    <div class="scroller" runat="server" style="overflow-y:scroll; height:640px;" >        
        <!-- Page Content -->
             <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" AllowPaging="True" ShowFooter="false" Skin="Silk" PageSize="14"
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" ClientSettings-Selecting-AllowRowSelect="true"
                OnNeedDataSource="RadGrid1_NeedDataSource" OnUpdateCommand="RadGrid1_UpdateCommand" OnItemCreated="RadGrid1_ItemCreated"
                OnInsertCommand="RadGrid1_InsertCommand" OnDeleteCommand="RadGrid1_DeleteCommand" CssClass="RadGridFormTemplate" 
                 AllowFilteringByColumn="true" OnItemCommand="RadGrid1_ItemCommand" >
                <PagerStyle Mode="NextPrevNumericAndAdvanced"></PagerStyle>
                    <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="prod_code" Font-Names="Calibri" Font-Size="12px"
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
                            <table id="Table2" cellspacing="4" cellpadding="5" width="100%" border="0" rules="none" class="formTemplate_Table">
                                   
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
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.unit") %>' OnPreRender="cb_uom_PreRender"
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
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.brand_name") %>' OnPreRender="cb_brand_PreRender"
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
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.kind_name") %>' OnPreRender="cb_category_PreRender"
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
                                                        Text='<%# DataBinder.Eval(Container, "DataItem.group_name") %>' OnPreRender="cb_group_PreRender"
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
                                                        AutoPostBack="false" Width="300px" AllowCustomText="false" OnPreRender="cb_st_main_PreRender"
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
                                                    <%--<asp:TextBox ID="txt_min_stock" runat="server"  Text='<%# DataBinder.Eval(Container, "DataItem.QtyMin") %>'>
                                                    </asp:TextBox>--%>
                                                    <telerik:RadNumericTextBox ID="txt_min_stock" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.QtyMin") %>'>
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Min Purchase:</td>
                                                <td>
                                                    <telerik:RadNumericTextBox ID="txt_min_purchase" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.QtyMinPur") %>'>
                                                    </telerik:RadNumericTextBox>
                                                    <%--<asp:TextBox ID="txt_min_purchase" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.QtyMinPur") %>'>
                                                    </asp:TextBox>--%>
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
                                                    <telerik:RadNumericTextBox ID="txt_selling_price" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.price_sale") %>'>
                                                    </telerik:RadNumericTextBox>
                                                    <%--<asp:TextBox ID="txt_selling_price" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.price_sale") %>'>
                                                    </asp:TextBox>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Sales forecast:</td>
                                                <td>
                                                    <telerik:RadNumericTextBox ID="txt_sales_forecast" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SalesFore") %>'>
                                                    </telerik:RadNumericTextBox>
                                                   <%-- <asp:TextBox ID="txt_sales_forecast" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SalesFore") %>'>
                                                    </asp:TextBox>--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="border-collapse: collapse; padding-left:35px; vertical-align:top">
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

                                <tr >
                                    <td colspan="2" style="padding:10px 0px 10px 0px">
                                        <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                            runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'></asp:Button>&nbsp;
                                        <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                                            CommandName="Cancel"></asp:Button>
                                    </td>
                                </tr>

                            </table>
                            
                            <div style="padding: 5px 15px 10px 15px;">
                                 <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip2" 
                                    SelectedIndex="1" MultiPageID="RadMultiPage2" Skin="Silk" CausesValidation="False">
                                    <Tabs>
                                        <telerik:RadTab Text="Storage" Height="20px" Visible="true" Selected="True" > 
                                        </telerik:RadTab>
                                        <telerik:RadTab Text="Assembly Formulation" Height="20px"  Visible="true" >
                                        </telerik:RadTab>
                                        <telerik:RadTab Text="Interchange" Height="20px"  Visible="true"> 
                                        </telerik:RadTab>
                                    </Tabs>
                                </telerik:RadTabStrip>
                               
                                <telerik:RadMultiPage runat="server" ID="RadMultiPage2"  SelectedIndex="0" >
                                    <telerik:RadPageView runat="server" ID="RadPageView1" Height="280px" >
                                        <div style="padding: 5px 10px 10px 10px;">
                                            <telerik:RadGrid runat="server" ID="RadGridPageView1" RenderMode="Lightweight" AllowPaging="true"
                                                ShowFooter="false" AllowSorting="false" PageSize="5" AutoGenerateColumns="false" Skin="Silk"
                                                OnNeedDataSource="RadGridPageView1_NeedDataSource" >
                                                    <MasterTableView CommandItemDisplay="None" AllowFilteringByColumn= "false" DataKeyNames="prod_code, wh_code" Width="60%" 
                                                    Font-Names="Calibri" Font-Size="12px" CommandItemSettings-ShowAddNewRecordButton="false"  HeaderStyle-Font-Size="12px"
                                                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" HeaderStyle-Height="10px" HeaderStyle-ForeColor="Highlight" >
                                                        <Columns>
                                                            <%--<telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                                                                <HeaderStyle Width="40px" B/>
                                                            </telerik:GridEditCommandColumn>--%>
                                                            <telerik:GridBoundColumn HeaderText ="Storage" DataField="wh_name" FilterControlWidth="60px">
                                                                <HeaderStyle Width="100px" HorizontalAlign="Center" />
                                                                <ItemStyle Width="100px" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText ="Location" DataField="KoLok">
                                                                <HeaderStyle Width="80px" HorizontalAlign="Center" />
                                                                <ItemStyle Width="80px" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText ="On Hand" DataField="QACT">
                                                                <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                                                <ItemStyle Width="50px" HorizontalAlign="Right" />
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                            </telerik:RadGrid>
                                        </div>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView runat="server" ID="RadPageView2" Height="280px" >
                                        <div style="padding: 10px 10px 10px 10px;">
                                            <telerik:RadGrid runat="server" ID="RadGridPageView2" RenderMode="Lightweight" AllowPaging="true"
                                                ShowFooter="false" AllowSorting="false" PageSize="5" AutoGenerateColumns="false" Skin="Silk">
                                                <MasterTableView CommandItemDisplay="None" AllowFilteringByColumn= "false" DataKeyNames="prod_code, wh_code" Width="60%" 
                                                    Font-Names="Calibri" Font-Size="12px" CommandItemSettings-ShowAddNewRecordButton="false"  HeaderStyle-Font-Size="12px"
                                                    EditFormSettings-PopUpSettings-KeepInScreenBounds="true" HeaderStyle-Height="10px" HeaderStyle-ForeColor="Highlight">
                                                    <Columns>
                                                        <telerik:GridBoundColumn HeaderText ="Material Code" FilterControlWidth="60px">
                                                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                                                            <ItemStyle Width="100px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText ="Specification">
                                                            <HeaderStyle Width="80px" HorizontalAlign="Center" />
                                                            <ItemStyle Width="80px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText ="UoM">
                                                            <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                                            <ItemStyle Width="50px" HorizontalAlign="Right" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText ="Qty">
                                                            <HeaderStyle Width="80px" HorizontalAlign="Center" />
                                                            <ItemStyle Width="80px" />
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
                                                </MasterTableView>
                                            </telerik:RadGrid>
                                        </div>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView runat="server" ID="RadPageView3" Height="280px" >
                                        <div style="padding: 10px 10px 10px 10px;">
                                            <telerik:RadGrid runat="server" ID="RadGridPageView3">

                                            </telerik:RadGrid>
                                        </div>
                                    </telerik:RadPageView>
                                </telerik:RadMultiPage>
                            </div>
                        </FormTemplate>
                    </EditFormSettings>
                        </MasterTableView>
                        <ClientSettings>
                            <ClientEvents OnRowDblClick="RowDblClick" OnPopUpShowing="onPopUpShowing" />
                        </ClientSettings>
                </telerik:RadGrid>

    </div>
</asp:Content>
