<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h18.aspx.cs" Inherits="TelerikWebApplication.Form.Fico.Budget.acc01h18" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />
    <script src="../../../Script/Script.js"></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("reportViewer_inv01h05.aspx?do_code=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("inv01h05EditForm.aspx", "EditDialogWindows");
                return false;
            }

            function ShowEditForm(id, rowIndex) {
                var grid = $find("<%= RadGrid1.ClientID %>");
 
                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);
 
                window.radopen("inv01h05EditForm.aspx?do_code=" + id, "EditDialogWindows");
                return false;
            }

            function openWinFiterTemplate() {
                var filterDialog = $find("<%=FilterDialogWindows.ClientID%>");
                filterDialog.show();
            }

            Sys.Application.add_load(function () {
            $windowContentDemo.contentTemplateID = "<%=FilterDialogWindows.ClientID%>";
            $windowContentDemo.templateWindowID = "<%=FilterDialogWindows.ClientID %>";
            });

            function openWinAddNewTemplate() {
                var filterDialog = $find("<%=AddNewDialogWindows.ClientID%>");
                filterDialog.show();
            }

            Sys.Application.add_load(function () {
            $windowContentDemo.contentTemplateID = "<%=AddNewDialogWindows.ClientID%>";
            $windowContentDemo.templateWindowID = "<%=AddNewDialogWindows.ClientID %>";
            });

            function refreshGrid(arg) {
                if (!arg) {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("Rebind");
                }
                else {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("RebindAndNavigate");
                }

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
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid2" LoadingPanelID="RadAjaxLoadingPanel2"></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position:center; top: 170px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" MinDisplayTime="3000" BackgroundPosition="None" Skin="Silk">
        <img alt="Loading..." src="../../../Images/load.gif" style="border: 0px; width:60px; height:45px; position: center; top: 1200px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="Windows7" MinDisplayTime="500" BackgroundPosition="Center"></telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="450px" Height="350px" VisibleStatusbar="False" AutoSize="True">
        <ContentTemplate>
            <div runat="server" style="padding: 20px 10px 10px 10px;" id="Div2">
                <table>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Type :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="cb_bgt_type" runat="server" RenderMode="Lightweight" AutoPostBack="false"
                                EnableLoadOnDemand="True"  Skin="Silk" 
                                OnItemsRequested="cb_bgt_type_ItemsRequested"
                                OnSelectedIndexChanged="cb_bgt_type_SelectedIndexChanged"
                                EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="300px">
                            </telerik:RadComboBox>  
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Year :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="cb_tahun" runat="server" RenderMode="Lightweight" AutoPostBack="false"
                                EnableLoadOnDemand="True"  Skin="Silk" 
                                OnItemsRequested="cb_tahun_ItemsRequested" 
                                OnSelectedIndexChanged="cb_tahun_SelectedIndexChanged"
                                EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="300px">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight" AutoPostBack="true"
                                    EnableLoadOnDemand="True"  Skin="Silk" 
                                    OnItemsRequested="cb_Project_prm_ItemsRequested"
                                    OnSelectedIndexChanged="cb_Project_prm_SelectedIndexChanged"
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="300px">
                                </telerik:RadComboBox>                                    
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Filter" Width="95%" Height="25px"
                             Skin="Material" ForeColor="DeepSkyBlue"></telerik:RadButton>
                        </td>

                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="AddNewDialogWindows" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="450px" Height="350px" VisibleStatusbar="False" AutoSize="True">
        <ContentTemplate>
            <div runat="server" style="padding: 20px 10px 10px 10px;" id="Div1">
                <table>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Type :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="RadComboBox1" runat="server" RenderMode="Lightweight" AutoPostBack="false"
                                EnableLoadOnDemand="True"  Skin="Silk" 
                                OnItemsRequested="cb_bgt_type_ItemsRequested"
                                OnSelectedIndexChanged="cb_bgt_type_SelectedIndexChanged"
                                EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="300px">
                            </telerik:RadComboBox>  
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Year :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadComboBox ID="RadComboBox2" runat="server" RenderMode="Lightweight" AutoPostBack="false"
                                EnableLoadOnDemand="True"  Skin="Silk" 
                                OnItemsRequested="cb_tahun_ItemsRequested" 
                                OnSelectedIndexChanged="cb_tahun_SelectedIndexChanged"
                                EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="300px">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                <telerik:RadComboBox ID="RadComboBox3" runat="server" RenderMode="Lightweight" AutoPostBack="true"
                                    EnableLoadOnDemand="True"  Skin="Silk" 
                                    OnItemsRequested="cb_Project_prm_ItemsRequested"
                                    OnSelectedIndexChanged="cb_Project_prm_SelectedIndexChanged"
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="300px">
                                </telerik:RadComboBox>                                    
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btn_ok" runat="server" OnClick="btn_ok_Click" Text="OK" Width="95%" Height="25px"
                             Skin="Material" ForeColor="DeepSkyBlue"></telerik:RadButton>
                        </td>

                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:gainsboro; border-bottom-width:thin ">
        <table id="tbl_control">
            <tr>                        
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="29px" Width="30px" ImageUrl="~/Images/search.png" Visible="true"></asp:ImageButton>
                </td>              
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 0px 13px">
                    <asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClientClick="openWinAddNewTemplate(); return false;" ToolTip="Add New"
                        Height="26px" Width="27px" ImageUrl="~/Images/tambah.png" Visible="true" ></asp:ImageButton>
                </td>
                <td style="width: 97%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:yellowgreen; font-weight:bold; margin-right:20px">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>     

    <div  class="scroller" runat="server">
        <div runat="server" style="width:auto;">
            <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" AllowPaging="true" PageSize="15" ShowFooter="false" Skin="Silk" 
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" MasterTableView-GridLines="None" CssClass="RadGrid_ModernBrowsers"
                OnNeedDataSource="RadGrid1_NeedDataSource">
                <PagerStyle Mode="NumericPages" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle>               
                <HeaderStyle BackColor="#73bbbb" ForeColor="White" Font-Names="Centruy Gothic" Font-Size="11px"/>
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" />
                <SelectedItemStyle Font-Italic="False" ForeColor="White" BackColor="#c0c0c0" />
                <SortingSettings EnableSkinSortStyles="false" />
                <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="Kd_Bget" Font-Size="11px"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="false" CommandItemSettings-ShowAddNewRecordButton="false"
                CommandItemSettings-ShowRefreshButton="false" EditMode="EditForms">
                    <Columns> 
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                        <HeaderStyle Width="40px" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="accountname" HeaderText="Description" DataField="accountname" >
                            <HeaderStyle Width="270px" />
                            <ItemStyle Width="270px" />
                        </telerik:GridBoundColumn>                        
                        <telerik:GridBoundColumn UniqueName="January" HeaderText="January" DataField="plan01" 
                            DataType="System.Double" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="February" HeaderText="February" DataField="plan02"  
                            DataType="System.Double" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="March" HeaderText="March" DataField="plan03"  
                            DataType="System.Double" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="April" HeaderText="April" DataField="plan04"  
                            DataType="System.Double" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridBoundColumn UniqueName="May" HeaderText="May" DataField="plan05"  
                            DataType="System.Double" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="June" HeaderText="June" DataField="plan06"  
                            DataType="System.Double" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="July" HeaderText="July" DataField="plan07"  
                            DataType="System.Double" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="August" HeaderText="August" DataField="plan08"  
                            DataType="System.Double" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="September" HeaderText="September" DataField="plan09" 
                            DataType="System.Double" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="October" HeaderText="October" DataField="plan10"  
                            DataType="System.Double" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="November" HeaderText="November" DataField="plan11"  
                            DataType="System.Double" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="December" HeaderText="December" DataField="plan12"  
                            DataType="System.Double" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###,###0.00}">
                            <HeaderStyle Width="120px" />
                            <ItemStyle Width="120px" />
                        </telerik:GridBoundColumn>
                    </Columns>
                    <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                            <div style="padding: 15px 0px 20px 25px;">
                                <table id="Table1" border="0" style="border-collapse: collapse; padding:15px 0px 5px 0px; font-size:11px;">
                                    <tr>
                                        <td colspan="4" style="padding: 0px 0px 10px 0px; text-align:left">
                                            <asp:Button ID="btnSave" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" 
                                                OnClick="btnSave_Click" Height="25px" 
                                                Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" 
                                                CssClass="btn-entryFrm" >
                                            </asp:Button>&nbsp;
                            
                                            <asp:Button ID="btnCancel" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" 
                                                Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                                runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                                        </td>
                                    </tr>     
                                    <tr style="vertical-align: top;">
                                        <td style="vertical-align: top;">
                                            <table id="Table2" width="Auto" border="0" class="module">                                                
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server" Text="Account" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadLabel ID="lbl_account" runat="server" CssClass="lbObject" ForeColor="Black"
                                                            Text='<%#DataBinder.Eval(Container, "DataItem.Kd_Bget") %>'>
                                                        </telerik:RadLabel>
                                                    </td>
                                                </tr>     
                                                <tr>
                                                    <td class="tdLabel">                                                    
                                                        <telerik:RadLabel runat="server" Text="January" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_jan" Width="175px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="false" Skin="Silk"
                                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "plan01", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"   
                                                            NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>    
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">                                                    
                                                        <telerik:RadLabel runat="server" Text="February" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_feb" Width="175px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="false" Skin="Silk"
                                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "plan02", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"    
                                                            NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>    
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">                                                    
                                                        <telerik:RadLabel runat="server" Text="March" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_mar" Width="175px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="false" Skin="Silk"
                                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "plan03", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"    
                                                            NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>    
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">                                                    
                                                        <telerik:RadLabel runat="server" Text="April" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_apr" Width="175px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="false" Skin="Silk"
                                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "plan04", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"    
                                                            NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>    
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">                                                    
                                                        <telerik:RadLabel runat="server" Text="May" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_may" Width="175px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="false" Skin="Silk"
                                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "plan05", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"    
                                                            NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>    
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">                                                    
                                                        <telerik:RadLabel runat="server" Text="Juni" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_jun" Width="175px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="false" Skin="Silk"
                                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "plan06", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"    
                                                            NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>    
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="vertical-align: top; padding-left:15px">
                                            <table id="Table3" border="0" class="module">
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel runat="server"></telerik:RadLabel>
                                                    <td>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">                                                    
                                                        <telerik:RadLabel runat="server" Text="July" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_jul" Width="175px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="false" Skin="Silk"
                                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "plan07", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"    
                                                            NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>    
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">                                                    
                                                        <telerik:RadLabel runat="server" Text="August" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_aug" Width="175px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="false" Skin="Silk"
                                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "plan08", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"    
                                                            NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>    
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">                                                    
                                                        <telerik:RadLabel runat="server" Text="September" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_sep" Width="175px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="false" Skin="Silk"
                                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "plan09", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"    
                                                            NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>    
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">                                                    
                                                        <telerik:RadLabel runat="server" Text="October" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_oct" Width="175px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="false" Skin="Silk"
                                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "plan10", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"    
                                                            NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>    
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">                                                    
                                                        <telerik:RadLabel runat="server" Text="November" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_nov" Width="175px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="false" Skin="Silk"
                                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "plan11", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"    
                                                            NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>    
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">                                                    
                                                        <telerik:RadLabel runat="server" Text="December" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox  RenderMode="Lightweight" runat="server" ID="txt_dec" Width="175px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ShowSpinButtons="false" Skin="Silk"
                                                            DbValue='<%# DataBinder.Eval(Container.DataItem, "plan12", "{0:#,###,###0.00}") %>'
                                                            onkeydown="blurTextBox(this, event)"
                                                            MaxLength="11" Type="Number" EnabledStyle-HorizontalAlign="Right"    
                                                            NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>    
                                                    </td>
                                                </tr>
                                            </table>           
                                        </td>
                    
                                    </tr>  
                                     
                                </table>

                                
                            </div>
                        </FormTemplate>
                    </EditFormSettings>
                </MasterTableView>
                <ClientSettings>
                    <Selecting AllowRowSelect="true"></Selecting>
                    <ClientEvents OnRowDblClick="RowDblClick" />
                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="540"  SaveScrollPosition="true" FrozenColumnsCount="2"/>
                </ClientSettings>
            </telerik:RadGrid>
        </div>        
            
         
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Lightweight" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1150px" Height="670px" Modal="true" AutoSize="True">
                </telerik:RadWindow>
                <telerik:RadWindow RenderMode="Lightweight" ID="EditDialogWindows" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1250px" Height="720px" Modal="true" AutoSize="False" Skin="Silk" Font-Names="Century Gothic">
                </telerik:RadWindow>
                
            </Windows>
        </telerik:RadWindowManager>
        
        <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>
       <telerik:RadNotification RenderMode="Lightweight" ID="notif" Text="Data telah disimpan" runat="server" Position="BottomRight" Skin="Silk"
                AutoCloseDelay="10000" Width="350" Height="110" Title="Confirmation" EnableRoundedCorners="true">
        </telerik:RadNotification>
    </div>

</asp:Content>
