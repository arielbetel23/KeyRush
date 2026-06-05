<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Signup.aspx.cs" Inherits="KeyRush_Pages_Signup" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register — GameZone</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link rel="stylesheet" href="../Styles/Signup.css" />
</head>
<body>
    <div class="signup-wrapper">
        <div class="auth-card">
            <h1 class="auth-title">Create Account</h1>
            <p class="auth-subtitle">Join GameZone — it's free</p>

            <form id="form1" runat="server" method="post">

                <div class="form-section-label">Account Details</div>

                <div class="form-group">
                    <label for="txtUsername">Username</label>
                    <input type="text" name="txtUsername" id="txtUsername" oninput="return checkUserName();" placeholder="Choose a username" />
                    <div id="usernameError" class="error"></div>
                </div>
                <div class="form-group">
                    <label for="txtPassword">Password</label>
                    <input type="password" name="txtPassword" id="txtPassword" oninput="return checkPassword();" placeholder="Create a password" />
                    <div id="passwordError" class="error"></div>
                </div>
                <div class="form-group">
                    <label for="txtVerifyPassword">Confirm Password</label>
                    <input type="password" name="txtVerifyPassword" id="txtVerifyPassword" oninput="checkConfirmPassword();" placeholder="Repeat your password" />
                    <div id="confirmError" class="error"></div>
                </div>

                <div class="form-section-label">Personal Info</div>

                <div class="form-group">
                    <label for="txtFirstname">First Name</label>
                    <input type="text" name="txtFirstname" id="txtFirstname" oninput="return checkFirstname();" placeholder="First name" />
                    <div id="firstnamError" class="error"></div>
                </div>
                <div class="form-group">
                    <label for="txtLastname">Last Name</label>
                    <input type="text" name="txtLastname" id="txtLastname" oninput="return checkLastname();" placeholder="Last name" />
                    <div id="lastnamError" class="error"></div>
                </div>
                <div class="form-group">
                    <label for="birth">Birthdate</label>
                    <input type="date" name="birthdate" id="birth" oninput="return checkBirth();" />
                    <div id="birthError" class="error"></div>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="text" name="email" id="email" oninput="return checkEmail();" placeholder="your@email.com" />
                    <div id="emailError" class="error"></div>
                </div>
                <div class="form-group">
                    <label for="phonenumber">Phone Number</label>
                    <input type="text" name="phonenumber" id="phonenumber" oninput="return checkPhoneNumber();" placeholder="+1 555 000 0000" />
                    <div id="phoneError" class="error"></div>
                </div>
                <div class="form-group">
                    <label>Gender (optional)</label>
                    <div class="radio-group">
                        <label><input type="radio" name="gender" value="true" /> Male</label>
                        <label><input type="radio" name="gender" value="false" /> Female</label>
                    </div>
                </div>

                <div class="form-section-label">Security Questions</div>

                <div class="form-group">
                    <label>Question 1</label>
                    <select name="question1" id="question1">
                        <option value="1">What is your favorite pet?</option>
                        <option value="2">What country are you living in?</option>
                        <option value="3">What is your favorite sport?</option>
                    </select>
                    <input type="text" name="answer1" id="answer1" oninput="return firstAnswerCheck();" placeholder="Your answer" style="margin-top:0.5rem;" />
                    <div id="answer1error" class="error"></div>
                </div>
                <div class="form-group">
                    <label>Question 2</label>
                    <select name="question2" id="question2">
                        <option value="1">What is your favorite NBA team?</option>
                        <option value="2">What city are you living in?</option>
                        <option value="3">What is your favorite soccer team?</option>
                    </select>
                    <input type="text" name="answer2" id="answer2" oninput="return secondAnswerCheck();" placeholder="Your answer" style="margin-top:0.5rem;" />
                    <div id="secondanswererror" class="error"></div>
                </div>

                <button type="submit" name="submit" id="submit" onclick="return signUp();" class="btn-primary-auth">Create Account</button>
                <button type="reset" name="clear" id="clear" class="btn-reset-auth">Clear</button>
            </form>

            <div class="auth-footer">
                Already have an account? <a href="Signin2.aspx">Sign in</a>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="../Scripts/SignUp.js"></script>
    <%
        if (Request.Form["submit"] != null)
        {
            Signup();
        }
    %>
</body>
</html>
