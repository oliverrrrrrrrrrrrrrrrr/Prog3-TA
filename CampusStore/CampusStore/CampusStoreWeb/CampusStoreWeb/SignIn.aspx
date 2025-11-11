<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="CampusStoreWeb.SignIn" %>
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
        
        /* Sign In Container */
        .signin-container {
            max-width: 450px;
            margin: 0 auto 80px;
        }
        
        .signin-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 40px 35px;
        }
        
        /* Tabs */
        .signin-tabs {
            display: flex;
            border-bottom: 2px solid #e9ecef;
            margin-bottom: 30px;
        }
        
        .signin-tab {
            flex: 1;
            text-align: center;
            padding: 15px 0;
            font-size: 16px;
            font-weight: 500;
            color: #6c757d;
            background: none;
            border: none;
            border-bottom: 3px solid transparent;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
            bottom: -2px;
        }
        
        .signin-tab.active {
            color: #1e5a7d;
            border-bottom-color: #ff6b35;
        }
        
        .signin-tab:hover {
            color: #1e5a7d;
        }
        
        /* Form */
        .form-label {
            font-size: 14px;
            font-weight: 500;
            color: #2b2b2b;
            margin-bottom: 8px;
        }
        
        .form-control {
            padding: 12px 15px;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-control:focus {
            border-color: #1e5a7d;
            box-shadow: 0 0 0 0.2rem rgba(30, 90, 125, 0.15);
        }
        
        .password-wrapper {
            position: relative;
        }
        
        .password-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #6c757d;
            cursor: pointer;
            padding: 5px;
        }
        
        .password-toggle:hover {
            color: #1e5a7d;
        }
        
        .forgot-password {
            color: #00bcd4;
            text-decoration: none;
            font-size: 14px;
            float: right;
            margin-bottom: 5px;
        }
        
        .forgot-password:hover {
            color: #0097a7;
            text-decoration: underline;
        }
        
        /* Button */
        .btn-signin {
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
        }
        
        .btn-signin:hover {
            background-color: #e55a28;
        }
        
        .btn-signin:active {
            background-color: #cc4d1f;
        }
        
        /* Tab Content */
        .tab-content-wrapper {
            display: none;
        }
        
        .tab-content-wrapper.active {
            display: block;
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
                <li class="breadcrumb-item active" aria-current="page">Sign In</li>
            </ol>
        </nav>
    </div>
    
    <!-- Sign In Container -->
    <div class="signin-container">
        <div class="signin-card">
            
            <!-- Tabs -->
            <div class="signin-tabs">
                <button class="signin-tab active" id="tabSignIn" type="button">Sign In</button>
                <button class="signin-tab" id="tabSignUp" type="button">Sign Up</button>
            </div>
            
            <!-- Sign In Form -->
            <div class="tab-content-wrapper active" id="contentSignIn">
                <div class="mb-3">
                    <label for="txtEmail" class="form-label">Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" 
                                 TextMode="Email" placeholder="" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                                                ControlToValidate="txtEmail"
                                                ErrorMessage="Email is required" 
                                                CssClass="text-danger small"
                                                Display="Dynamic" />
                </div>
                
                <div class="mb-2">
                    <label for="txtPassword" class="form-label">Password</label>
                    <asp:HyperLink ID="lnkForgotPassword" runat="server" 
                                   NavigateUrl="~/Forget_Password.aspx" 
                                   CssClass="forgot-password">
                        Forget Password
                    </asp:HyperLink>
                    <div style="clear: both;"></div>
                </div>
                
                <div class="mb-3">
                    <div class="password-wrapper">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" 
                                     TextMode="Password" placeholder="" />
                        <button type="button" class="password-toggle" id="togglePassword">
                            <i class="bi bi-eye" id="eyeIcon"></i>
                        </button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                                                ControlToValidate="txtPassword"
                                                ErrorMessage="Password is required" 
                                                CssClass="text-danger small"
                                                Display="Dynamic" />
                </div>

                 <asp:CustomValidator 
                    ID="cvLoginError" 
                    runat="server" 
                    Display="None" 
                    EnableClientScript="false" />
                
                <asp:Button ID="btnSignIn" runat="server" CssClass="btn-signin" 
                            Text="SIGN IN ➔" OnClick="btnSignIn_Click" />
            </div>
            
            <!-- Sign Up Form (Hidden by default) -->
            <div class="tab-content-wrapper" id="contentSignUp">
                <div class="mb-3">
                    <label for="txtSignUpEmail" class="form-label">Email Address</label>
                    <asp:TextBox ID="txtSignUpEmail" runat="server" CssClass="form-control" 
                                 TextMode="Email" placeholder="" ValidationGroup="SignUp" />
                </div>
                
                <div class="mb-3">
                    <label for="txtSignUpPassword" class="form-label">Password</label>
                    <div class="password-wrapper">
                        <asp:TextBox ID="txtSignUpPassword" runat="server" CssClass="form-control" 
                                     TextMode="Password" placeholder="" ValidationGroup="SignUp" />
                        <button type="button" class="password-toggle" id="toggleSignUpPassword">
                            <i class="bi bi-eye" id="eyeIconSignUp"></i>
                        </button>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="txtConfirmPassword" class="form-label">Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" 
                                 TextMode="Password" placeholder="" ValidationGroup="SignUp" />
                </div>
                
                <asp:Button ID="btnSignUp" runat="server" CssClass="btn-signin" 
                            Text="SIGN UP ➔" ValidationGroup="SignUp" OnClick="btnSignUp_Click" />
            </div>
            
        </div>
    </div>
    
    <script>
        // Tab Switching
        document.getElementById('tabSignIn').addEventListener('click', function() {
            document.getElementById('tabSignIn').classList.add('active');
            document.getElementById('tabSignUp').classList.remove('active');
            document.getElementById('contentSignIn').classList.add('active');
            document.getElementById('contentSignUp').classList.remove('active');
        });
        
        document.getElementById('tabSignUp').addEventListener('click', function() {
            document.getElementById('tabSignUp').classList.add('active');
            document.getElementById('tabSignIn').classList.remove('active');
            document.getElementById('contentSignUp').classList.add('active');
            document.getElementById('contentSignIn').classList.remove('active');
        });
        
        // Password Toggle for Sign In
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordField = document.getElementById('<%= txtPassword.ClientID %>');
            const eyeIcon = document.getElementById('eyeIcon');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                eyeIcon.classList.remove('bi-eye');
                eyeIcon.classList.add('bi-eye-slash');
            } else {
                passwordField.type = 'password';
                eyeIcon.classList.remove('bi-eye-slash');
                eyeIcon.classList.add('bi-eye');
            }
        });
        
        // Password Toggle for Sign Up
        document.getElementById('toggleSignUpPassword').addEventListener('click', function() {
            const passwordField = document.getElementById('<%= txtSignUpPassword.ClientID %>');
            const eyeIcon = document.getElementById('eyeIconSignUp');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                eyeIcon.classList.remove('bi-eye');
                eyeIcon.classList.add('bi-eye-slash');
            } else {
                passwordField.type = 'password';
                eyeIcon.classList.remove('bi-eye-slash');
                eyeIcon.classList.add('bi-eye');
            }
        });
    </script>
    
</asp:Content>
