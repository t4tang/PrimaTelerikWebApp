 <%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="acc01h07postJnl.aspx.cs" Inherits="TelerikWebApplication.Form.Security.Posting.Journal.acc01h07postJnl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../../Styles/common.css" rel="stylesheet" />
    <link href="../../../../Styles/mail.css" rel="stylesheet" />
    <link href="../../../../Styles/custom-cs.css" rel="stylesheet" />
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
  
    <div style="padding-left: 15px;">
        <table id="tbl_control">
            <tr> 
                <td style="text-align: right; width:1300px">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight: lighter; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-weight:bold; text-align:right">
                    </telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>
    <div class="scroller" runat="server">   

        <div runat="server" style="width: 100%; border-top-color:gainsboro; border-top-width: 1px; border-top-style: inset; padding-top: 8px;height:100%; overflow-y:auto; overflow-x:hidden">   
        
        <div runat="server" title="Period Process">
            <table>
                <tr>
                    <td>
                        <telerik:RadComboBox runat="server" ID="cbMonth" Label="Month:" Skin="Telerik" Font-Size="11px"  RenderMode="Lightweight" 
                            EnableLoadOnDemand="True"  EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true" Width="160px"
                            OnItemsRequested="cbMonth_ItemsRequested" OnSelectedIndexChanged="cbMonth_SelectedIndexChanged">
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <telerik:RadComboBox runat="server" ID="cbYear" Label="Year:" Skin="Telerik" Font-Size="11px" RenderMode="Lightweight" 
                            EnableLoadOnDemand="True"  EnableVirtualScrolling="true" Filter="Contains" MarkFirstMatch="true"
                            OnItemsRequested="cbYear_ItemsRequested" >
                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
            
        </div>
        <div runat="server" title="Process Type" style="padding:25px 0px 25px 0px">
            <table>
                <tr>
                    <td>
                        <telerik:RadLabel runat="server" Skin="Telerik" Font-Size="11px" Text="Transaction Period:"></telerik:RadLabel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadTextBox runat="server" ID="txtPerStart" Skin="Telerik" Font-Size="11px" Width="90px" ReadOnly="true">
                        </telerik:RadTextBox>
                    </td>
                    <td>
                        <telerik:RadLabel runat="server" Skin="Telerik" Font-Size="11px" Text="To:"></telerik:RadLabel>
                         <telerik:RadTextBox runat="server" ID="txtPerEnd" Skin="Telerik" Font-Size="11px" Width="120px" ReadOnly="true">
                        </telerik:RadTextBox>
                    </td>
                </tr>
            </table>

            <br />
            
            <asp:RadioButtonList ID="rblPost" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Selected="True" Value="1">Posting</asp:ListItem>
                <asp:ListItem Selected="False" Value="0">Unposting</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div runat="server" title="Post">
            <table>
                <tr>
                    <td style="width:60px">
                        <asp:CheckBox ID="chkGR" runat="server" Text="GR" Checked="true" />
                    </td>
                    <td style="width:60px">
                        <asp:CheckBox ID="chkGI" runat="server" Text="GI" Checked="true" />
                    </td>
                    <td style="width:70px">
                        <asp:CheckBox ID="chkPurchase" runat="server" Text="Purchase" Checked="true" />
                    </td>
                    <td style="width:60px">
                        <asp:CheckBox ID="chkSales" runat="server" Text="Sales" Checked="true" />
                    </td>
                </tr>
                <tr>
                    <td style="width:60px">
                        <asp:CheckBox ID="chkCash" runat="server" Text="Cash" Checked="true" />
                    </td>
                    <td style="width:60px">
                        <asp:CheckBox ID="chkBank" runat="server" Text="Bank" Checked="true" />
                    </td>                    
                    <td style="width:60px">
                        <asp:CheckBox ID="chkAP" runat="server" Text="A/P" Checked="true" />
                    </td>
                    <td style="width:60px">
                        <asp:CheckBox ID="chkAR" runat="server" Text="A/R" Checked="true" />
                    </td>
                </tr>
                <tr>
                    <td style="width:60px">
                        <asp:CheckBox ID="chkAsset" runat="server" Text="Asset" Checked="true" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="submitButton">
            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            </telerik:RadAjaxManager>
            <telerik:RadButton RenderMode="Lightweight" ID="btnProcessing" runat="server" Text="Start Posting Process" CssClass="btn-wrapper" ForeColor="White"
               Skin="Material"  OnClick="btnProcessing_Click" Width="160px">
            </telerik:RadButton>
            <telerik:RadProgressManager ID="RadProgressManager1" runat="server" />
            <telerik:RadProgressArea RenderMode="Lightweight" ID="RadProgressArea1" runat="server" Width="500px" />
        </div>
    </div>
    </div>
</asp:Content>
