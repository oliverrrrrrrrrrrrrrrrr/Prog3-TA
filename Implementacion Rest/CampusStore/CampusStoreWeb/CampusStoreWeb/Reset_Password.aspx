<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reset_Password.aspx.cs" Inherits="CampusStoreWeb.Reset_Password" %>
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
        
        /* Reset Password Container */
        .reset-password-container {
            max-width: 450px;
            margin: 0 auto 80px;
        }
        
        .reset-password-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 40px 35px;
            text-align: center;
        }
        
        .reset-password-title {
            font-size: 24px;
            font-weight: 600;
            color: #2b2b2b;
            margin-bottom: 15px;
        }
        
        .reset-password-description {
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
        
        .form-control::placeholder {
            color: #adb5bd;
            font-size: 13px;
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
            font-size: 16px;
        }
        
        .password-toggle:hover {
            color: #1e5a7d;
        }
        
        /* Button */
        .btn-reset-password {
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
        
        .btn-reset-password:hover {
            background-color: #e55a28;
        }
        
        .btn-reset-password:active {
            background-color: #cc4d1f;
        }
        
        /* Validation messages */
        .validation-message {
            text-align: left;
            margin-top: 5px;
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
                <li class="breadcrumb-item">
                    <a href="Forget_Password.aspx">Forget Password</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">Reset Password</li>
            </ol>
        </nav>
    </div>
    
    <!-- Reset Password Container -->
    <div class="reset-password-container">
        <div class="reset-password-card">
            
            <h2 class="reset-password-title">Reset Password</h2>
            
            <p class="reset-password-description">
                Ingresa tu nueva contraseña
            </p>
            
            <!-- Password Field -->
            <div class="mb-3">
                <label for="txtNewPassword" class="form-label">Password</label>
                <div class="password-wrapper">
                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" 
                                 TextMode="Password" placeholder="8+ characters" />
                    <button type="button" class="password-toggle" id="toggleNewPassword">
                        <i class="bi bi-eye" id="eyeIconNew"></i>
                    </button>
                </div>
                <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" 
                                            ControlToValidate="txtNewPassword"
                                            ErrorMessage="Password is required" 
                                            CssClass="text-danger small validation-message"
                                            Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revNewPassword" runat="server"
                                                ControlToValidate="txtNewPassword"
                                                ErrorMessage="Password must be at least 8 characters"
                                                ValidationExpression="^.{8,}$"
                                                CssClass="text-danger small validation-message"
                                                Display="Dynamic" />
            </div>
            
            <!-- Confirm Password Field -->
            <div class="mb-3">
                <label for="txtConfirmPassword" class="form-label">Confirm Password</label>
                <div class="password-wrapper">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" 
                                 TextMode="Password" placeholder="" />
                    <button type="button" class="password-toggle" id="toggleConfirmPassword">
                        <i class="bi bi-eye" id="eyeIconConfirm"></i>
                    </button>
                </div>
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                                            ControlToValidate="txtConfirmPassword"
                                            ErrorMessage="Please confirm your password" 
                                            CssClass="text-danger small validation-message"
                                            Display="Dynamic" />
                <asp:CompareValidator ID="cvConfirmPassword" runat="server"
                                      ControlToValidate="txtConfirmPassword"
                                      ControlToCompare="txtNewPassword"
                                      ErrorMessage="Passwords do not match"
                                      CssClass="text-danger small validation-message"
                                      Display="Dynamic" />
            </div>
            
            <asp:Button ID="btnResetPassword" runat="server" CssClass="btn-reset-password" 
                        Text="RESET PASSWORD ➔" OnClick="btnResetPassword_Click" />
            
        </div>
    </div>
    
    <script>
        // Password Toggle for New Password
        document.getElementById('toggleNewPassword').addEventListener('click', function() {
            const passwordField = document.getElementById('<%= txtNewPassword.ClientID %>');
            const eyeIcon = document.getElementById('eyeIconNew');
            
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
        
        // Password Toggle for Confirm Password
        document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
            const passwordField = document.getElementById('<%= txtConfirmPassword.ClientID %>');
            const eyeIcon = document.getElementById('eyeIconConfirm');
            
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
