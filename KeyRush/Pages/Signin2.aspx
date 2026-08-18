<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Signin2.aspx.cs" Inherits="KeyRush_Pages_Signin2" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign In — GameZone</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link rel="stylesheet" href="../Styles/Auth.css" />
    <script type="text/javascript" src="../Scripts/Forms.js"></script>
</head>
<body>
    <div class="auth-wrapper">
        <div class="auth-card">
            <div class="auth-logo">
                <img src="../Images/Logo.png" alt="Logo" />
            </div>
            <h1 class="auth-title">Welcome back</h1>
            <p class="auth-subtitle">Sign in to your GameZone account</p>

            <asp:Literal ID="litMessage" runat="server" Visible="false"></asp:Literal>

            <form id="form1" runat="server">
                <div class="form-group">
                    <label for="txtUsername">Username</label>
                    <input type="text" name="txtUsername" id="txtUsername" oninput="return checkUserName();" placeholder="Enter your username" />
                    <div id="usernameError" class="error-text"></div>
                </div>

                <div class="form-group">
                    <label for="txtPassword">Password</label>
                    <input type="password" name="txtPassword" id="txtPassword" oninput="return checkPassword();" placeholder="Enter your password" />
                    <div id="passwordError" class="error-text"></div>
                </div>

                <div class="form-row">
                    <span></span>
                    <a href="ForgotPassword.aspx">Forgot password?</a>
                </div>

                <button type="submit" name="submit" id="submit" onclick="return signIn();" class="btn-primary-auth">Sign In</button>
                <button type="reset" name="clear" id="clear" class="btn-reset-auth">Clear</button>
            </form>

            <div class="auth-footer">
                Don't have an account? <a href="Signup.aspx">Register</a>
            </div>
        </div>
    </div>

    <%
        if (Request.Form["submit"] != null)
        {
            SignIn();
        }
    %>
</body>
</html>
