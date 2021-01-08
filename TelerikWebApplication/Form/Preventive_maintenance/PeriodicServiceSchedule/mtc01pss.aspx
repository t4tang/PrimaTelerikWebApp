<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="mtc01pss.aspx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.PeriodicServiceSchedule.mtc01pss" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../Styles/common.css" rel="styleshSeet" />
    <link href="../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../Styles/custom-cs.css" rel="stylesheet" />

    <script type="text/javascript" src="../../../Script/Script.js" ></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("reportViewer.aspx?jobno=" + id, "PreviewDialog");
                return false;
            }
            function RowDblClick(sender, eventArgs) {
                Row = eventArgs.get_itemIndexHierarchical();
            }
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function ShowInsertForm() {                
                window.radopen("mtc01h02EditForm.aspx", "EditDialogWindows");
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
           
        </script>
    </telerik:RadCodeBlock>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
            <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
        </ContentTemplate>        
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls> 
            </telerik:AjaxSetting>            
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server" MinDisplayTime="2500" BackgroundPosition="None" Skin="Material">
        <img alt="Loading..." src="../../../Images/loaderpage.gif" style="border: 0px; width:100px; height:75px; position: absolute; top: 170px; left:600px" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" MinDisplayTime="2500" Height="75px" Width="75px" Transparency="50">
        <img alt="Loading..." src="../../../Images/load.gif" style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="ContentTemplateZone"
        Modal="true" Width="350px" Height="200px" VisibleStatusbar="False" AutoSize="False">
        <ContentTemplate>
            <div runat="server" style="padding: 20px 10px 10px 10px;" id="Div2">
                <table>
                    <%--<tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Date From :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                        <td >
                            <telerik:RadLabel runat="server" Text="To Date :" CssClass="lbObject" ForeColor="Black"></telerik:RadLabel><br />
                            <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Lightweight" Width="200px"  Skin="Telerik"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>--%>
                    <tr>
                        <td colspan="2">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                <telerik:RadLabel runat="server" Text="Project :" CssClass="lbObject" ForeColor="#000000"></telerik:RadLabel><br />
                                <telerik:RadComboBox ID="cb_proj_prm" runat="server" RenderMode="Lightweight" AutoPostBack="true"
                                    EnableLoadOnDemand="True"  Skin="Telerik" 
                                    OnItemsRequested="cb_proj_prm_ItemsRequested"
                                    OnSelectedIndexChanged="cb_proj_prm_SelectedIndexChanged"
                                    EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="250px">
                                </telerik:RadComboBox>                                    
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="height:50px">   
                        <td colspan="2" style="padding-right:10px">
                            <telerik:RadButton ID="btnSearch" runat="server" Text="Filter" Width="95%" Height="25px" OnClick="btnSearch_Click"
                             Skin="Material" ForeColor="DeepSkyBlue"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>

    <div style="padding-left: 15px; ">
        <table id="tbl_control">
            <tr>                
                <td style="vertical-align: middle; margin-left: 10px; padding: 5px 0px 0px 13px;">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter"
                        Height="25px" Width="28px" ImageUrl="~/Images/filter.png"></asp:ImageButton>
                </td>                  
                <td style="vertical-align: middle; margin-left: 10px; padding-left: 8px">
                    <%--<asp:ImageButton runat="server" ID="btnNew" AlternateText="New" OnClientClick="ShowInsertForm(); return false;" ToolTip="Add New"
                        Height="30px" Width="32px" ImageUrl="~/Images/tambah.png"></asp:ImageButton>--%>
                </td>    
                <td style="width: 96%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:normal">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>

     <div  class="scroller" runat="server">
         <telerik:RadGrid  RenderMode="Lightweight" ID="RadGrid1"  runat="server" ShowFooter="false" Skin="Windows7" AllowCustomPaging="False"
             ShowStatusBar="true" PageSize="10" Width="1000px" 
             AllowSorting="True" AllowMultiRowSelection="True" AllowPaging="True" ShowGroupPanel="False" GroupHeaderItemStyle-Font-Bold="true"
            AutoGenerateColumns="False" GridLines="none"
             OnNeedDataSource="RadGrid1_NeedDataSource" >
             <PagerStyle Mode="NextPrevAndNumeric" ></PagerStyle>
             <MasterTableView Width="100%" CommandItemDisplay="None" DataKeyNames="NextService" Font-Size="12px"
                GroupHeaderItemStyle-Font-Size="X-Small">
                 <GroupByExpressions>
                    <telerik:GridGroupByExpression>
                        <SelectFields>
                            <telerik:GridGroupByField FieldAlias="Unit" FieldName="unit_code"></telerik:GridGroupByField>
                        </SelectFields>
                        <GroupByFields>
                            <telerik:GridGroupByField FieldName="unit_code" ></telerik:GridGroupByField>
                        </GroupByFields>
                    </telerik:GridGroupByExpression>                                
                </GroupByExpressions>
                 <Columns>
                     <telerik:GridBoundColumn UniqueName="hmAsOff" HeaderText="HM/KM Reading" DataField="hmAsOff">
                         <HeaderStyle Width="100px" HorizontalAlign="Center" ForeColor="#0066cc" Font-Size="13px"></HeaderStyle>
                         <ItemStyle Width="40px" HorizontalAlign="Right" />
                     </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn UniqueName="NextService" HeaderText="Next Service" DataField="NextService">
                         <HeaderStyle Width="120px"  HorizontalAlign="Center" ForeColor="#0066cc" Font-Size="13px" />
                         <ItemStyle Width="80px" HorizontalAlign="Right"/>
                     </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn UniqueName="hour_avai" HeaderText="Est. WH/Day" DataField="hour_avai" >
                         <HeaderStyle Width="70px" HorizontalAlign="Center" ForeColor="#0066cc" Font-Size="13px" />
                         <ItemStyle Width="50px" HorizontalAlign="Right" />
                     </telerik:GridBoundColumn>
                     <telerik:GridDateTimeColumn UniqueName="NextServiceDate" HeaderText="Service Date" DataField="NextServiceDate" ItemStyle-Width="80px" 
                            EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" 
                         DataFormatString="{0:d}" >
                         <HeaderStyle Width="110px"  HorizontalAlign="Center" ForeColor="#0066cc" Font-Size="13px" />
                         <ItemStyle Width="80px" HorizontalAlign="Center"/>
                     </telerik:GridDateTimeColumn>
                     <telerik:GridBoundColumn UniqueName="region_name" HeaderText="Project Area" DataField="region_name" 
                         FilterControlWidth="120px" >
                         <HeaderStyle Width="120px" HorizontalAlign="Center" ForeColor="#0066cc" Font-Size="13px" />
                     </telerik:GridBoundColumn>
                     
                 </Columns>
             </MasterTableView>
             <ClientSettings ReorderColumnsOnClient="True" AllowDragToGroup="True" AllowColumnsReorder="True">
                <Selecting AllowRowSelect="True"></Selecting>
                <Resizing AllowRowResize="True" AllowColumnResize="True" EnableRealTimeResize="True"
                    ResizeGridOnColumnResize="False"></Resizing>                 
                 <ClientEvents OnRowDblClick="RowDblClick" />
            </ClientSettings>
         </telerik:RadGrid>

         <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager2" runat="server" EnableShadow="true">
        </telerik:RadWindowManager>

    </div>
</asp:Content>
