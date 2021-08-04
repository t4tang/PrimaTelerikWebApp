<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inv00h05.aspx.cs" Inherits="TelerikWebApplication.Form.DataStore.Material.Warehouse.inv00h05" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function ShowGlAccountForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("gl_account.aspx?wh_code=" + id, "dialogWindows");
                return false;
            }

            function ShowMaterialForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("material.aspx?wh_code=" + id, "dialogWindows");
                return false;
            }
        </script>
    </telerik:RadCodeBlock>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="GridLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_new">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel runat="server" ID="GridLoadingPanel1">
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
                            <telerik:RadLabel ID="lbl_form_name" Text="Storage Location" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                                padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                            </telerik:RadLabel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div> 

    <div class="scroller" style="overflow-y:scroll; height:620px">
        <%--PAGE CONTENT--%>
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Lightweight" AllowPaging="true" ShowFooter="false" AllowSorting="true" PageSize="20"
            AutoGenerateColumns="false" AllowFilteringByColumn="true" Skin="Silk" CssClass="RadGrid_ModernBrowsers" 
            OnDeleteCommand="RadGrid1_DeleteCommand" 
            OnNeedDataSource="RadGrid1_NeedDataSource"
            OnUpdateCommand="RadGrid1_UpdateCommand"
            OnInsertCommand="RadGrid1_InsertCommand" 
            OnItemCreated="RadGrid1_ItemCreated">
            <HeaderStyle Font-Size="11px" ForeColor="White" BackColor="#808080" />
            <MasterTableView CommandItemDisplay="None" AllowFilteringByColumn="true" DataKeyNames="wh_code" Width="100%" Font-Names="Century Gothic" Font-Size="11px" 
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="40px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText ="Code" DataField="wh_code" FilterControlWidth="60px">
                        <HeaderStyle Width="60px" />
                        <ItemStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Storage Location" DataField="wh_name">
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Type" DataField="type_out">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Material" DataField="ref_prod_code">
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Capacity" DataField="FluitCap">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplateBtnAccountColumn" HeaderStyle-Width="70px" ItemStyle-Width="70px" AllowFiltering="False">
                        <ItemTemplate>
                            <asp:HyperLink runat="server" ID="link_gl_account" Height="20px" Width="80px" Text="GL Account"  />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn UniqueName="TemplateBtnMaterialColumn" HeaderStyle-Width="70px" ItemStyle-Width="70px" AllowFiltering="False">
                        <ItemTemplate> 
                            <asp:HyperLink runat="server" ID="link_material" Height="20px" Width="50px" Text="Material"  />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" 
                        ConfirmText="Are you sure you want to delete this row or record?">
                            <HeaderStyle Width="20px"></HeaderStyle>
                    </telerik:GridButtonColumn>
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table id="Table2" cellspacing="4" cellpadding="5" width="100%" border="0" style="border-collapse: collapse; padding-left:35px; 
                            padding-top:4px; padding-bottom:5px; background-color: #F0FFFE;">
                            <tr>
                                <td>                                    
                                    <tr>
                                       <td colspan="2" style="padding:10px 0px 10px 0px">
                                          <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                                      runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' />
                                                &nbsp; <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="false" CommandName="Cancel" />
                                       </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Code :
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txt_code" runat="server" Width="80px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.wh_code") %>'>
                                            </telerik:RadTextBox>
                                        </td>
                                        &nbsp;
                                        <td>
                                            Consignment :
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chk_consig" runat="server" Text="Active" Skin="Telerik" AutoPostback="false"
                                                          Checked='<%# DataBinder.Eval (Container, "DataItem.type_out").ToString()!="0"?true:false %>'/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Storage :
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txt_storage" runat="server" Width="230px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.wh_name") %>' AutoPostBack="false">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Project :
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cb_project" runat="server" Width="215px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.region_name") %>' AutoPostBack="false"
                                                                 ShowDropDownOnTextboxClick="true" OnPreRender="cb_project_PreRender" EnableLoadOnDemand="true" EnableVirtualScrolling="true"
                                                                 ShowMoreResultsBox="true" MarkFirstMatch="true" OnItemsRequested="cb_project_ItemsRequested"
                                                                 OnSelectedIndexChanged="cb_project_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr >
                                        <td>
                                            Type:
                                        </td>
                                        <td >
                                            <telerik:RadComboBox ID="cb_type" runat="server" RenderMode="Lightweight" Width="100px"
                                                                 Text='<%#DataBinder.Eval(Container, "DataItem.type_out") %>'
                                                                 ShowDropDownOnTextboxClick="true" OnPreRender="cb_type_PreRender"
                                                                 EnableLoadOnDemand="True" EnableVirtualScrolling="false"
                                                                 ShowMoreResultsBox="false" MarkFirstMatch="True"
                                                                 OnItemsRequested="cb_type_ItemsRequested" OnSelectedIndexChanged="cb_type_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </td>
                                <td>
                                    <tr >
                                        <td>
                                            Material Reference:
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cb_material_ref" runat="server" RenderMode="Lightweight" Width="170px"
                                                                 Text='<%#DataBinder.Eval(Container, "DataItem.ref_prod_code") %>'
                                                                 ShowDropDownOnTextboxClick="true" EnableLoadOnDemand="True" EnableVirtualScrolling="false"
                                                                 ShowMoreResultsBox="false" MarkFirstMatch="True" DropDownWidth="350px"
                                                                 OnItemsRequested="cb_material_ref_ItemsRequested" OnSelectedIndexChanged="cb_material_ref_SelectedIndexChanged">
                                                <%--<HeaderTemplate>
                                                    <table style="width: 275px" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td style="width: 175px;">
                                                                Product Name
                                                            </td>
                                                            <td style="width: 60px;">
                                                                Quantity
                                                            </td>
                                                            <td style="width: 40px;">
                                                                Price
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 600px">
                                                        <tr>
                                                            <td style="width: 140px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.prod_code")%>
                                                            </td>
                                                            <td style="width: 460px;">
                                                                <%# DataBinder.Eval(Container, "DataItem.spec")%>
                                                            </td>                                                                
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>--%>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Cap. Tanki :
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txt_cap_tanki" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.FluitCap") %>' AutoPostBack="false">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Address :
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txt_address" runat="server" Width="150px" Enabled="true" RenderMode="Lightweight" Text='<%#DataBinder.Eval(Container, "DataItem.address") %>' AutoPostBack="false">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>   
                                </td>
                            </tr>
                        </table>

                    </FormTemplate>
                </EditFormSettings>
            </MasterTableView>
            <%--<ClientSettings>
                <Scrolling UseStaticHeaders="true" AllowScroll="true" ScrollHeight="480px" />
            </ClientSettings>--%>
        </telerik:RadGrid>
                           <%-- </telerik:RadPageView>
                        </telerik:RadMultiPage>
            </EditFormSettings>
            </MasterTableView>
            </telerik:RadGrid>--%>

            <telerik:RadWindowManager ID="RadWindowManager1" RenderMode="Lightweight" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1400px" Height="720px" Modal="true" AutoSize="False">
                </telerik:RadWindow>  

                <telerik:RadWindow RenderMode="Lightweight" ID="dialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1050px" Height="600px" Modal="true" AutoSize="False">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
</asp:Content>
