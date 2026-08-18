<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="KeyRush_Pages_ForgotPassword" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Forgot Password — GameZone</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link rel="stylesheet" href="../Styles/Auth.css" />
    <script type="text/javascript" src="../Scripts/Forms.js"></script>
</head>
<body>
    <div class="auth-wrapper" style="max-width:500px;">
        <div class="auth-card">
            <h1 class="auth-title">Reset Password</h1>
            <p class="auth-subtitle">Verify your identity to set a new password</p>

            <form id="form1" runat="server">
                <div class="form-group">
                    <label for="txtUsername">Username</label>
                    <input type="text" name="username" id="txtUsername" placeholder="Enter your username" oninput="return checkUserName();" />
                    <div id="usernameError" class="error-text"></div>
                </div>

                <div class="form-group">
                    <label>Security Question 1</label>
                    <select name="question1" id="question1">
                        <option value="1">What is your favorite pet?</option>
                        <option value="2">What country are you living in?</option>
                        <option value="3">What is your favorite sport?</option>
                    </select>
                    <input type="text" name="answer1" id="answer1" oninput="return firstAnswerCheck();" placeholder="Your answer" style="margin-top:0.5rem;" />
                    <div id="answer1error" class="error-text"></div>
                </div>

                <div class="form-group">
                    <label>Security Question 2</label>
                    <select name="question2" id="question2">
                        <option value="1">What is your favorite NBA team?</option>
                        <option value="2">What city are you living in?</option>
                        <option value="3">What is your favorite soccer team?</option>
                    </select>
                    <input type="text" name="answer2" id="answer2" oninput="return secondAnswerCheck();" placeholder="Your answer" style="margin-top:0.5rem;" />
                    <div id="secondanswererror" class="error-text"></div>
                </div>

                <div class="form-group">
                    <label for="txtPassword">New Password</label>
                    <input type="password" name="password" id="txtPassword" oninput="return checkPassword();" placeholder="Enter new password" />
                    <div id="passwordError" class="error-text"></div>
                </div>

                <button type="submit" name="submit" id="submit" onclick="return forgotPass();" class="btn-primary-auth">Reset Password</button>
                <button type="reset" name="clear" id="clear" class="btn-reset-auth">Clear</button>
            </form>

            <div class="auth-footer">
                Remembered it? <a href="Signin2.aspx">Sign in</a>
            </div>
        </div>
    </div>

    <%
        string username = Request.Form["username"];
        int question1 = Convert.ToInt32(Request.Form["question1"]);
        string answer1 = Request.Form["answer1"];
        int question2 = Convert.ToInt32(Request.Form["question2"]);
        string answer2 = Request.Form["answer2"];
        string password = Request.Form["password"];
        if (Request.Form["submit"] != null)
            Update(username, password, question1, answer1, question2, answer2);
    %>
</body>
</html>
