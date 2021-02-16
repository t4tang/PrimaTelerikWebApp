<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inv01h06EditForm.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.InfoRecord.inv01h06EditForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type ="text/javascript" >  
        function GetRadWindow()     
        {     
           var oWindow = null;     
           if (window.radWindow)
           oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog     
           else if (window.frameElement.radWindow)
           oWindow = window.frameElement.radWindow;//IE (and Moz as well)     
           return oWindow;               
        }     
        function Close()     
        {     
          GetRadWindow().Close();          
        }

        function CloseAndRebind(args) {
            GetRadWindow().BrowserWindow.refreshGrid(args);
            GetRadWindow().close();
        }

    </script>
   <style type="text/css">
       .lbObject
         {
             color:teal;
             font-size:12px;
             font-weight:normal;
             font-family: Segoe UI, Tahoma, Geneva, 'Verdana', sans-serif;         
         }

       .lblEditInfo
       {
         font-size:11px;
         color:black;
         font-style:italic;
         /*background-color:greenyellow;*/
         font-family: Segoe UI, Tahoma, Geneva, 'Verdana', sans-serif;
       }
   </style>
    
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="cb_project">
            <UpdatedControls>
                
                <telerik:AjaxUpdatedControl ControlID="txt_diskh"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="txt_remark"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
        <%--<telerik:AjaxSetting AjaxControlID="cb_ref">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="gridLoadingPanel2"></telerik:AjaxUpdatedControl>
            </UpdatedControls>                
        </telerik:AjaxSetting>--%>
    </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel2" runat="server" MinDisplayTime="1000" BackgroundPosition="None" >
    <img alt="Loading..." src="../../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: absolute; top: 100px; left:600px" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
    <div>
            <div style="padding: 15px 15px 10px 15px;" class="lbObject">
                <table id="Table2" width="Auto" border="0" class="module">
                <tr>
                    <td style="vertical-align:top; width:auto">
                        <table>
                            <tr>
                                <td colspan="2" style="padding:0px 0px 5px 5px">
                                    <%--<telerik:RadButton ID="btn_save" runat="server" Text="Save" BackColor="#ff6600" ForeColor="White" Width="80px" Height="28px"
                                    OnClick="btnSave_Click" Skin="Material"></telerik:RadButton>--%>
                                    <asp:ImageButton runat="server" ID="btnSave" AlternateText="New" OnClick="btnSave_Click" ToolTip="Save" Visible="true"
                                    Height="30px" Width="32px" ImageUrl="~/Images/simpan.png"></asp:ImageButton>
                                </td>
                            </tr>
                            <tr style="vertical-align: top; width:auto">                               
                                <td  style="vertical-align: top">
                                    <telerik:RadLabel runat="server" Text="Info Record:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td>                                  
                                    <telerik:RadTextBox ID="txt_info_record" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                       Skin="Telerik"  EmptyMessage="Let it blank">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>                            
                                    <telerik:RadLabel runat="server" Text="Project Area:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td >
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_project" runat="server" Width="250px" DropDownWidth="250px"
                                                AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" CausesValidation="false"
                                                OnItemsRequested="cb_project_ItemsRequested" OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                                OnPreRender="cb_project_PreRender">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_project" ForeColor="Red" 
                                                Font-Size="X-Small" Text="Required!"></asp:RequiredFieldValidator>                             
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                           </tr>                            
                            <tr>
                               <td>
                                   <telerik:RadLabel runat="server" Text="Supplier:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                              </td>
                                <td style="width:310px">  
                                     <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                        <ContentTemplate>
                                         <telerik:RadComboBox RenderMode="Lightweight" ID="cb_supplier" runat="server" Width="250px" DropDownWidth="250px"
                                            AutoPostBack="true" CausesValidation="false" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik"  
                                            OnItemsRequested="cb_supplier_ItemsRequested" OnSelectedIndexChanged="cb_supplier_SelectedIndexChanged" OnPreRender="cb_supplier_PreRender">
                                        </telerik:RadComboBox>                                   
                                        <asp:RequiredFieldValidator runat="server" ID="supplierValidator" ControlToValidate="cb_supplier" ForeColor="Red" 
                                       Font-Size="X-Small"  Text="Required!" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                           </tr>
                        </table>
                    </td>
                    <td style="vertical-align:top; width:auto">
                        <table>
                            
                                                       
                                                     
                                                      
                            <tr>
                                <td>
                                    <telerik:RadLabel runat="server" Text="Remark:" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                </td>
                                <td style="width:350px">
                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadTextBox ID="txt_remark"
                                                runat="server" TextMode="MultiLine"
                                                Width="300px" Rows="0" TabIndex="5" Resize="Both">
                                            </telerik:RadTextBox>
                                        </ContentTemplate>
                                        
                                    </asp:UpdatePanel>
                                </td>
                            </tr>                           
                        </table>
                    </td>
                    <td style="vertical-align:top; width:auto">
                        <table>
                                          
                            
                            
                             
                            
                            <tr>
                                <td colspan="2" style="padding-top:15px"> 
                                    <telerik:RadLabel runat="server" ID="lbl_userId" Width="100px" Text="User: " CssClass="lblEditInfo" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadLabel runat="server" ID="lbl_lastUpdate" Width="220px" Text="Last Update: " CssClass="lblEditInfo"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"> 
                                    <telerik:RadLabel runat="server" ID="lbl_Owner" Width="100px" Text="Owner: " CssClass="lblEditInfo"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadLabel runat="server" ID="lbl_edited" Width="100px" Text="Edited: " CssClass="lblEditInfo"/>
                                </td>
                            </tr>        
                        </table>
                    </td>
                </tr>                  
               </table>
            </div>            
            
            <div style="padding: 5px 15px 15px 15px; height:360px">
            <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="98.5%" 
            SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Telerik" CausesValidation="false">
                <Tabs>
                    <telerik:RadTab Text="Detail" Height="10px" >
                    </telerik:RadTab>
                    <telerik:RadTab Text="Journal" Height="10px"> 
                    </telerik:RadTab>            
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage runat="server" SelectedIndex="0" ID="RadMultiPage1" >
                <telerik:RadPageView runat="server" ID="PageView1" Height="350px">
                 <asp:UpdatePanel ID="panel2" runat="server" UpdateMode="Always">
                      <ContentTemplate>
                            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid2" GridLines="None" PageSize="10" runat="server" Skin="Telerik"
                                HeaderStyle-Font-Size="Small" HeaderStyle-Font-Bold="true" ItemStyle-Font-Size="small" Font-Size="Small"
                                Font-Names="Segoe UI" CellSpacing="0" 
                                OnNeedDataSource="RadGrid2_NeedDataSource"
                                OnPreRender="RadGrid2_PreRender" 
                                OnDeleteCommand="RadGrid2_DeleteCommand">
                                <PagerStyle Mode="NumericPages" PageButtonCount="4"></PagerStyle>
                                <MasterTableView CommandItemDisplay="Top" DataKeyNames="Prod_code" Font-Size="11px" EditMode="Batch"
                                  AllowAutomaticUpdates="true" AllowAutomaticInserts="true" AllowAutomaticDeletes="true" HeaderStyle-Font-Bold="false"
                                ShowHeadersWhenNoRecords="true" AutoGenerateColumns="False" CommandItemSettings-AddNewRecordText="New Item" 
                                CommandItemSettings-ShowRefreshButton="False" ItemStyle-ForeColor="#006600">
                                    <CommandItemSettings ShowRefreshButton="False" ShowSaveChangesButton="False" ShowAddNewRecordButton="False" ShowCancelChangesButton="false" />
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Type" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Center" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblProdType" Width="40px" Text='<%# DataBinder.Eval(Container.DataItem, "prod_type") %>'></asp:Label>                                           
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Material Code" HeaderStyle-Width="150px" ItemStyle-Width="150px"
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblProdCode" Width="150px" Text='<%# DataBinder.Eval(Container.DataItem, "Prod_code") %>'></asp:Label>
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>
                                                                                
                                        <telerik:GridTemplateColumn HeaderText="Location" HeaderStyle-Width="100px" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Left"
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <%--<telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtLocation" Width="100px"  ReadOnly="true" 
                                                    EnabledStyle-HorizontalAlign="Left" Text='<%# DataBinder.Eval(Container.DataItem, "KoLok") %>'>
                                                </telerik:RadTextBox>--%>
                                                <telerik:RadComboBox runat="server" RenderMode="Lightweight" ID="cbKolok" Width="100px" Skin="Telerik"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "KoLok") %>'
                                                    EnableLoadOnDemand="True" EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false"  
                                                    DataTextField="kolok" DataValueField="kolok" OnItemsRequested="cbKolok_ItemsRequested">
                                                </telerik:RadComboBox>
                                            </ItemTemplate>                                            
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Order Qty" HeaderStyle-Width="80px" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Right" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" DefaultInsertValue="0" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtPartQty" Width="80px"  ReadOnly="false" 
                                                    EnabledStyle-HorizontalAlign="Right"
                                                    NumberFormat-AllowRounding="true"
                                                    NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                                    Text='<%# DataBinder.Eval(Container.DataItem, "qty_Sisa", "{0:#,###,###0.00}") %>'
                                                    onkeydown="blurTextBox(this, event)"
                                                    AutoPostBack="true" MaxLength="11" Type="Number"
                                                    NumberFormat-DecimalDigits="2">
                                                </telerik:RadTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                       <%-- <telerik:GridTemplateColumn HeaderText="PO Qty" HeaderStyle-Width="70px" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblQtyPo" Text='<%# DataBinder.Eval(Container.DataItem, "qtypo", "{0:#,###,###0.00}") %>'></asp:Label>
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>--%>

                                        <telerik:GridTemplateColumn HeaderText="UoM" HeaderStyle-Width="50px" ItemStyle-Width="50px" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblUom" Width="50px" Text='<%# DataBinder.Eval(Container.DataItem, "SatQty") %>' ></asp:Label>
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Cost Center" HeaderStyle-Width="100px" ItemStyle-Width="100px" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblCostCtr" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "dept_code") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                            
                                        <telerik:GridTemplateColumn HeaderText="Remark" ItemStyle-Width="300px" HeaderStyle-Width="300px" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="txtRemark_d" Width="300px"
                                                    Text='<%# DataBinder.Eval(Container, "DataItem.Remark") %>'>
                                                </telerik:RadTextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Ctrl. No" HeaderStyle-Width="130px" ItemStyle-Width="130px" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblRS" Text='<%# DataBinder.Eval(Container.DataItem, "nocontr") %>' Width="130px"></asp:Label>
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Warranty" HeaderStyle-Width="50px" ItemStyle-Width="50px" ItemStyle-HorizontalAlign="Center"
                                             HeaderStyle-ForeColor="#009900" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkWarranty" Width="50px" Checked='<%# DataBinder.Eval(Container.DataItem, "twarranty") %>' />
                                            </ItemTemplate>                                        
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Del" CommandName="Delete" ConfirmText="Are You Sure ?" 
                                            HeaderStyle-BackColor="#3399cc" HeaderStyle-ForeColor="#009900" ConfirmTitle="Delete" ConfirmDialogType="RadWindow"
                                            ButtonType="FontIconButton" ItemStyle-Width="40px" HeaderStyle-Width="40px" ItemStyle-ForeColor="Red">
                                        </telerik:GridButtonColumn>

                                    </Columns>
                                </MasterTableView>  
                                <ClientSettings>
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="310px" />
                                    <Selecting AllowRowSelect="true"></Selecting>                    
                                </ClientSettings>
                            </telerik:RadGrid>
                            <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Text="Data tersimpan" Position="BottomRight"
                                    AutoCloseDelay="10000" Width="350" Height="110" Title="Notification" EnableRoundedCorners="true">
                            </telerik:RadNotification>
                     </ContentTemplate>
                    
                    </asp:UpdatePanel>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
            </div>

         
            
    </div>
        <telerik:RadNotification RenderMode="Lightweight" ID="notif" runat="server" Text="Data telah disimpan" Position="Center" Skin="Windows7"
                    AutoCloseDelay="7000" Width="350" Height="110" Title="Congrotulation" EnableRoundedCorners="true">
        </telerik:RadNotification>
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
        
    </form>
</body>
</html>
