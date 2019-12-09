﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="PrimaWebApp.frm_login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--<title></title>--%>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Prima System</title>

    <!-- Bootstrap -->
    <link href="Styles/bootstrap.min.css" rel="stylesheet" />
    <link href="styles/custom-Cs.css" rel="stylesheet" />
    <%--<asp:ContentPlaceHolder ID="head" runat="server">
    </asp:ContentPlaceHolder>--%>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <!--- Navbar --->
        <div class="navbar-default navbar-fixed-top"  role="navigation">
            <div class="container">
               <%-- <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class ="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="Home.aspx"><span>
                        <img alt="logo" src="Images/prima-s.png" height="40" /></span> PT. PSG</a>
                </div>--%>
                <div class="navbar-collapse collapse">
                    <%--<ul class="nav navbar-nav navbar-right">
                        <li><a href="Home.aspx">Home</a> </li>
                        <li><a href="#">About</a></li>
                        <li><a href="#">Contact</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Product<b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li class="dropdown-header">Men</li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Shirts</a></li>
                                <li><a href="#">Pants</a></li>
                                <li><a href="#">Denim</a></li>
                                <li role="separator" class="divider"></li>
                                <li class="dropdown-header">Women</li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Top</a></li>
                                <li><a href="#">Leging</a></li>
                                <li><a href="#">Denim</a></li>
                            </ul>
                        </li>
                        <li><a href="SignUp.aspx">Register</a></li>
                    </ul>--%>
                </div>
            </div>
        </div>
            <!--- Navbar End --->
       <div class="container">
           <div class="form-horizontal">
               <h2>Login</h2>
               <hr />
               <div class="form-group" >
                   <asp:Label ID="Label1" runat="server" CssClass="col-md-2 control-label" Text="User Id"></asp:Label>
                   <div class="col-md-3">
                       <asp:TextBox ID="txt_uid" CssClass="form-control" runat="server"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidatorUserId" runat="server" CssClass="text-danger" ErrorMessage="The userid is required" ControlToValidate="txt_uid"></asp:RequiredFieldValidator>
                   </div>                   
               </div>
               <div class="form-group" >
                   <asp:Label ID="Label2" runat="server" CssClass="col-md-2 control-label" Text="Password"></asp:Label>
                   <div class="col-md-3">
                       <asp:TextBox ID="txt_pwd" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidatorPass" runat="server" CssClass="text-danger" ErrorMessage="The password is required" ControlToValidate="txt_pwd"></asp:RequiredFieldValidator>
                   </div>                   
               </div>
               <div class="form-group" >      
                   <div class="col-md-2"></div>             
                   <div class="col-md-6">
                       <asp:CheckBox ID="CheckBox1" runat="server" />
                       <asp:Label ID="Label3" runat="server" CssClass="control-label" Text="Remember me ?"></asp:Label>                       
                   </div>                   
               </div>
               <div class="form-group" >      
                   <div class="col-md-2"></div>             
                   <div class="col-md-6">
                       <asp:Button ID="btnSubmit" runat="server" Text="Login" CssClass="btn btn-default" OnClick="btnSubmit_Click" />
                       <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default" />--%>
                   </div>                   
               </div>
               <div class="form-group" >      
                   <div class="col-md-2"></div>             
                   <div class="col-md-6">
                       <asp:Label ID="lbl_error" runat="server" CssClass="text-danger"></asp:Label>
                   </div>                   
               </div>
           </div>
       </div>
    </div>
        
    </form>
    <hr />
    <div class="container">

    </div>
    <footer>
        <div class="container" >
            <%--<p class="pull-right"><a href="#">Back to top</a></p>--%>
            
        </div>
    </footer>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
