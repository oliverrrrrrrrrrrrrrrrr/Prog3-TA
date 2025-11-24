<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Verify_Code.aspx.cs" Inherits="CampusStoreWeb.Verify_Code" %>
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
        
        /* Verify Code Container */
        .verify-code-container {
            max-width: 450px;
            margin: 0 auto 80px;
        }
        
        .verify-code-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 40px 35px;
            text-align: center;
        }
        
        .verify-code-title {
            font-size: 24px;
            font-weight: 600;
            color: #2b2b2b;
            margin-bottom: 15px;
        }
        
        .verify-code-description {
            color: #6c757d;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 10px;
        }
        
        .verify-code-email {
            color: #2b2b2b;
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 30px;
        }
        
        /* Code Input */
        .code-input-container {
            display: flex;
            justify-content: center;
            gap: 12px;
            margin-bottom: 25px;
        }
        
        .code-input {
            width: 55px;
            height: 55px;
            text-align: center;
            font-size: 24px;
            font-weight: 600;
            border: 2px solid #dee2e6;
            border-radius: 8px;
            transition: all 0.3s;
        }
        
        .code-input:focus {
            border-color: #1e5a7d;
            box-shadow: 0 0 0 0.2rem rgba(30, 90, 125, 0.15);
            outline: none;
        }
        
        .code-input.filled {
            border-color: #1e5a7d;
            background-color: #f8f9fa;
        }
        
        .code-input.error {
            border-color: #dc3545;
        }
        
        /* Timer and Resend */
        .timer-section {
            margin-bottom: 25px;
            font-size: 14px;
            color: #6c757d;
        }
        
        .timer-text {
            display: inline-block;
            margin-bottom: 10px;
        }
        
        .timer-countdown {
            font-weight: 600;
            color: #ff6b35;
        }
        
        .resend-link {
            color: #00bcd4;
            text-decoration: none;
            font-weight: 500;
            cursor: pointer;
        }
        
        .resend-link:hover {
            color: #0097a7;
            text-decoration: underline;
        }
        
        .resend-link.disabled {
            color: #adb5bd;
            cursor: not-allowed;
            pointer-events: none;
        }
        
        /* Button */
        .btn-verify-code {
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
            cursor: pointer;
        }
        
        .btn-verify-code:hover {
            background-color: #e55a28;
        }
        
        .btn-verify-code:active {
            background-color: #cc4d1f;
        }
        
        .btn-verify-code:disabled {
            background-color: #adb5bd;
            cursor: not-allowed;
        }
        
        /* Hidden ASP TextBox */
        .hidden-code-input {
            display: none;
        }
        
        /* Alert Messages */
        .alert {
            margin-bottom: 20px;
            text-align: left;
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
                    <a href="Forget_assword.aspx">Forget Password</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">Verify Code</li>
            </ol>
        </nav>
    </div>
    
    <!-- Verify Code Container -->
    <div class="verify-code-container">
        <div class="verify-code-card">
            
            <h2 class="verify-code-title">Verify Code</h2>
            
            <p class="verify-code-description">
                We've sent a verification code to
            </p>
            <p class="verify-code-email">
                <asp:Label ID="lblEmail" runat="server" Text="user@example.com"></asp:Label>
            </p>
            
            <!-- Code Input Boxes -->
            <div class="code-input-container">
                <input type="text" class="code-input" id="code1" maxlength="1" pattern="[0-9]" inputmode="numeric" />
                <input type="text" class="code-input" id="code2" maxlength="1" pattern="[0-9]" inputmode="numeric" />
                <input type="text" class="code-input" id="code3" maxlength="1" pattern="[0-9]" inputmode="numeric" />
                <input type="text" class="code-input" id="code4" maxlength="1" pattern="[0-9]" inputmode="numeric" />
                <input type="text" class="code-input" id="code5" maxlength="1" pattern="[0-9]" inputmode="numeric" />
                <input type="text" class="code-input" id="code6" maxlength="1" pattern="[0-9]" inputmode="numeric" />
            </div>
            
            <!-- Hidden TextBox to store the complete code for server-side validation -->
            <asp:TextBox ID="txtVerificationCode" runat="server" CssClass="hidden-code-input"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvCode" runat="server" 
                                        ControlToValidate="txtVerificationCode"
                                        ErrorMessage="Please enter the verification code" 
                                        CssClass="text-danger small"
                                        Display="Dynamic" />
            
            <!-- Timer and Resend -->
            <div class="timer-section">
                <div class="timer-text">
                    Code expires in: <span class="timer-countdown" id="timerCountdown">05:00</span>
                </div>
                <div>
                    <a href="#" class="resend-link disabled" id="resendLink">Resend Code</a>
                </div>
            </div>
            
            <asp:Button ID="btnVerifyCode" runat="server" CssClass="btn-verify-code" 
                        Text="VERIFY CODE ➔" OnClick="btnVerifyCode_Click" />
            
        </div>
    </div>
    
    <script>
        // Code input handling
        const codeInputs = document.querySelectorAll('.code-input');
        const hiddenInput = document.getElementById('<%= txtVerificationCode.ClientID %>');
        const verifyButton = document.querySelector('.btn-verify-code');
        
        // Focus first input on load
        window.addEventListener('load', function() {
            codeInputs[0].focus();
        });
        
        codeInputs.forEach((input, index) => {
            // Only allow numbers
            input.addEventListener('input', function(e) {
                const value = e.target.value;
                
                // Remove non-numeric characters
                e.target.value = value.replace(/[^0-9]/g, '');
                
                // Add filled class
                if (e.target.value) {
                    e.target.classList.add('filled');
                } else {
                    e.target.classList.remove('filled');
                }
                
                // Auto-focus next input
                if (e.target.value && index < codeInputs.length - 1) {
                    codeInputs[index + 1].focus();
                }
                
                // Update hidden input with complete code
                updateHiddenInput();
            });
            
            // Handle backspace
            input.addEventListener('keydown', function(e) {
                if (e.key === 'Backspace' && !e.target.value && index > 0) {
                    codeInputs[index - 1].focus();
                }
            });
            
            // Handle paste
            input.addEventListener('paste', function(e) {
                e.preventDefault();
                const pasteData = e.clipboardData.getData('text').replace(/[^0-9]/g, '');
                
                if (pasteData.length === 6) {
                    codeInputs.forEach((input, i) => {
                        input.value = pasteData[i] || '';
                        if (input.value) {
                            input.classList.add('filled');
                        }
                    });
                    codeInputs[5].focus();
                    updateHiddenInput();
                }
            });
        });
        
        function updateHiddenInput() {
            let code = '';
            codeInputs.forEach(input => {
                code += input.value;
            });
            hiddenInput.value = code;
            
            // Enable/disable verify button
            if (code.length === 6) {
                verifyButton.disabled = false;
            } else {
                verifyButton.disabled = true;
            }
        }
        
        // Timer countdown
        let timeLeft = 300; // 5 minutes in seconds
        const timerElement = document.getElementById('timerCountdown');
        const resendLink = document.getElementById('resendLink');
        
        function updateTimer() {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            timerElement.textContent = 
                String(minutes).padStart(2, '0') + ':' + String(seconds).padStart(2, '0');
            
            if (timeLeft <= 0) {
                clearInterval(timerInterval);
                timerElement.textContent = 'Expired';
                timerElement.style.color = '#dc3545';
                resendLink.classList.remove('disabled');
                verifyButton.disabled = true;
                
                // Mark inputs as expired
                codeInputs.forEach(input => {
                    input.classList.add('error');
                    input.disabled = true;
                });
            } else {
                timeLeft--;
            }
        }
        
        const timerInterval = setInterval(updateTimer, 1000);
        updateTimer(); // Initial call
        
        // Resend code functionality
        resendLink.addEventListener('click', function(e) {
            e.preventDefault();
            
            if (!this.classList.contains('disabled')) {
                // Call server-side method to resend code
                __doPostBack('<%= btnResendCode.UniqueID %>', '');
            }
        });
        
        // Reset timer function (called after resending)
        function resetTimer() {
            timeLeft = 300;
            timerElement.style.color = '#ff6b35';
            resendLink.classList.add('disabled');
            
            // Re-enable inputs
            codeInputs.forEach(input => {
                input.classList.remove('error');
                input.disabled = false;
                input.value = '';
                input.classList.remove('filled');
            });
            
            codeInputs[0].focus();
            updateHiddenInput();
            
            clearInterval(timerInterval);
            const newInterval = setInterval(updateTimer, 1000);
        }
    </script>
    
    <!-- Hidden button for resend functionality -->
    <asp:Button ID="btnResendCode" runat="server" style="display:none;" OnClick="btnResendCode_Click" />
    
</asp:Content>
