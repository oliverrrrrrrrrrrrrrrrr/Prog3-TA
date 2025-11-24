<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Forget_Password.aspx.cs" Inherits="CampusStoreWeb.Forget_Password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Breadcrumb personalizado */
        .custom-breadcrumb {
            background-color: transparent;
            padding: 20px 0;
            margin-bottom: 30px;
        }
        
        .custom-breadcrumb .breadcrumb {
            background-color: transparent;
            padding: 0;
            margin: 0;
        }
        
        .custom-breadcrumb .breadcrumb-item {
            color: #6c757d;
            font-size: 14px;
        }
        
        .custom-breadcrumb .breadcrumb-item a {
            color: #6c757d;
            text-decoration: none;
        }
        
        .custom-breadcrumb .breadcrumb-item a:hover {
            color: #1e5a7d;
        }
        
        .custom-breadcrumb .breadcrumb-item.active {
            color: #00bcd4;
        }
        
        .custom-breadcrumb .breadcrumb-item + .breadcrumb-item::before {
            content: "›";
            color: #6c757d;
        }
        
        /* Forgot Password Container */
        .forgot-password-container {
            max-width: 450px;
            margin: 0 auto 80px;
        }
        
        .forgot-password-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 40px 35px;
            text-align: center;
        }
        
        .forgot-password-title {
            font-size: 24px;
            font-weight: 600;
            color: #2b2b2b;
            margin-bottom: 15px;
        }
        
        .forgot-password-description {
            color: #6c757d;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        
        /* Form */
        .form-label {
            font-size: 14px;
            font-weight: 500;
            color: #2b2b2b;
            margin-bottom: 8px;
            text-align: left;
            display: block;
        }
        
        .form-control {
            padding: 12px 15px;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            font-size: 14px;
            width: 100%;
        }
        
        .form-control:focus {
            border-color: #1e5a7d;
            box-shadow: 0 0 0 0.2rem rgba(30, 90, 125, 0.15);
        }
        
        /* Button */
        .btn-send-code {
            width: 100%;
            background-color: #ff6b35;
            color: white;
            border: none;
            padding: 12px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 4px;
            text-transform: uppercase;
            transition: background-color 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 25px;
            cursor: pointer;
        }
        
        .btn-send-code:hover {
            background-color: #e55a28;
        }
        
        .btn-send-code:active {
            background-color: #cc4d1f;
        }
        
        /* Links */
        .account-links {
            margin-top: 25px;
            font-size: 14px;
        }
        
        .account-links p {
            margin-bottom: 8px;
            color: #6c757d;
        }
        
        .account-links a {
            color: #00bcd4;
            text-decoration: none;
            font-weight: 500;
        }
        
        .account-links a:hover {
            color: #0097a7;
            text-decoration: underline;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- Breadcrumb -->
    <div class="custom-breadcrumb">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="Default.aspx"><i class="bi bi-house-door"></i> Home</a>
                </li>
                <li class="breadcrumb-item">
                    <a href="#">User Account</a>
                </li>
                <li class="breadcrumb-item">
                    <a href="SignIn.aspx">Sign In</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">Forget Password</li>
            </ol>
        </nav>
    </div>
    
    <!-- Forgot Password Container -->
    <div class="forgot-password-container">
        <div class="forgot-password-card">
            
            <h2 class="forgot-password-title">Forget Password</h2>
            
            <p class="forgot-password-description">
                Enter the email address or mobile phone number associated with your Clicon account.
            </p>
            
            <div class="mb-3">
                <label for="txtEmailForgot" class="form-label">Email Address</label>
                <asp:TextBox ID="txtEmailForgot" runat="server" CssClass="form-control" 
                             TextMode="Email" placeholder="" />
                <asp:RequiredFieldValidator ID="rfvEmailForgot" runat="server" 
                                            ControlToValidate="txtEmailForgot"
                                            ErrorMessage="Email is required" 
                                            CssClass="text-danger small"
                                            Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revEmailForgot" runat="server"
                                                ControlToValidate="txtEmailForgot"
                                                ErrorMessage="Please enter a valid email address"
                                                ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                                                CssClass="text-danger small"
                                                Display="Dynamic" />
            </div>
            
            <asp:Button ID="btnSendCode" runat="server" CssClass="btn-send-code" 
                        Text="SEND CODE ➔" OnClick="btnSendCode_Click" />
            
            <div class="account-links">
                <p>
                    Already have account? 
                    <asp:HyperLink ID="lnkSignIn" runat="server" NavigateUrl="~/SignIn.aspx">
                        Sign In
                    </asp:HyperLink>
                </p>
                <p>
                    Don't have account? 
                    <asp:HyperLink ID="lnkSignUp" runat="server" NavigateUrl="~/SignIn.aspx">
                        Sign Up
                    </asp:HyperLink>
                </p>
            </div>
            
        </div>
    </div>
    
</asp:Content>