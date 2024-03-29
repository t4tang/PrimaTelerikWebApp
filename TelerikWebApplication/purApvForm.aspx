﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="purApvForm.aspx.cs" Inherits="TelerikWebApplication.Form.Purchase.purApvForm" %>
<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../Styles/common.css" rel="stylesheet" />
    <link href="../../Styles/custom-cs.css" rel="stylesheet" />
    <script src="../../Script/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../../Script/Script.js"></script>

    <script src="jquery-1.3.2.min.js"></script>  
    <script src="jquery.dimensions.js"></script>  
    <script>  
        var name = "#floatDiv";  
        var menuYloc = null;  
        $(document).ready(function () {  
            menuYloc = parseInt($(name).css("top").substring(0, $(name).css("top").indexOf("px")))  
            $(window).scroll(function () {  
                offset = menuYloc + $(document).scrollTop() + "px";  
                $(name).animate({ top: offset }, { duration: 500, queue: false });  
            });  
        });  
    </script> 

    <style>
		#reportViewer1 {
			position:absolute;
			left: 5px;
			right: 5px;
			top: 5px;
			bottom: 5px;
			overflow: hidden;
			font-family: Verdana, Arial;
            text-align:center;
		}
        #floatDiv {  
            position: absolute;  
            top: 535px;  
            /*left: 50%;  */  
            margin-left: 105px;
            margin-bottom:3px;
            width: 300px;  
            height: 50px;  
            border: 1px solid black;  
            float:right;
            /*background-color:white;*/
            border-style:none;
            border-width:0px;
        }  
	</style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1"></telerik:RadScriptManager>
        <div>
            <telerik:ReportViewer
                ID="reportViewer1" 
			    Width="1000px"
			    Height="600px"                
			    EnableAccessibility="false"
                runat="server">
                <ReportSource IdentifierType="TypeReportSource" Identifier="TelerikWebApplication.Form.Purchase.Purchase_order.pur01h02_slip, TelerikWebApplication, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
                </ReportSource>                
            </telerik:ReportViewer>
        </div>
        <%--<div id="FloatDiv" style="position:absolute; padding: 15px 5px 25px 15px; text-align:right; width:950px; float:right" >--%>
        <div id="floatDiv" >
            <table>
                <tr>
                    <td style="width:135px">
                        <telerik:RadButton ID="btnOk" runat="server" Text="Sign" OnClick="btnOk_Click1" CssClass="btn-wrapper" ForeColor="White" 
                            BackColor="#ff6600" Width="120px" Skin="Material" Enabled="false"></telerik:RadButton>
                    </td>
                    <td>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:CheckBox ID="chk_overhaul" runat="server" Text="Overhaul" OnCheckedChanged="chk_overhaul_CheckedChanged" 
                                    AutoPostBack="true" BackColor="White"  ForeColor="Highlight" Font-Bold="true" ></asp:CheckBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        </td>
                </tr>
            </table>
            
        </div>
        <div style="clear:both; font-size:1px;"></div>
    </form>
</body>
</html>
