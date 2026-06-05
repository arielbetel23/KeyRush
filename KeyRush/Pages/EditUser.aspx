<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/KeyRush/Pages/MasterPage.master" AutoEventWireup="true" CodeFile="EditUser.aspx.cs" Inherits="KeyRush_Pages_EditUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link href="../Styles/General.css" rel="stylesheet" />
    <script type="text/javascript" src="../Scripts/EditUser.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="page-content" style="max-width:520px;">

    <h1>Edit Profile</h1>
    <p style="color:#94a3b8; margin-top:-0.5rem;">
        <% Response.Write("Editing account: <strong style='color:#6c63ff'>" + Session["username"] + "</strong>"); %>
    </p>

    <div class="card-dark">
        <form runat="server">
            <h3 id="display" style="color:#6c63ff; font-size:1rem; margin-bottom:1.25rem;"></h3>

            <div style="margin-bottom:1rem;">
                <label class="form-label-dark">Old Password</label>
                <asp:TextBox runat="server" ID="oldPassword" ClientIDMode="Static" TextMode="Password" oninput="return checkOldPass();" placeholder="Enter current password" CssClass="input-dark" />
                <div id="oldpasswordError" style="color:#f87171; font-size:0.8rem; margin-top:0.25rem;"></div>
            </div>

            <div style="margin-bottom:1rem;">
                <label class="form-label-dark">New Password</label>
                <asp:TextBox runat="server" ID="newPassword" ClientIDMode="Static" TextMode="Password" placeholder="Enter new password" oninput="return checkNewPass();" CssClass="input-dark" />
                <div id="newpasserror" style="color:#f87171; font-size:0.8rem; margin-top:0.25rem;"></div>
            </div>

            <div style="margin-bottom:1rem;">
                <label class="form-label-dark">Email</label>
                <asp:TextBox runat="server" ID="email" ClientIDMode="Static" placeholder="New email address" oninput="return checkNewEmail();" CssClass="input-dark" />
                <div id="newEmailError" style="color:#f87171; font-size:0.8rem; margin-top:0.25rem;"></div>
            </div>

            <div style="margin-bottom:1.5rem;">
                <label class="form-label-dark">Phone Number</label>
                <asp:TextBox runat="server" ID="phonenumber" ClientIDMode="Static" placeholder="New phone number" oninput="return checkNewPhoneNum();" CssClass="input-dark" />
                <div id="phonenumError" style="color:#f87171; font-size:0.8rem; margin-top:0.25rem;"></div>
            </div>

            <button type="submit" name="submit" id="submit" onclick="return EditUser();" class="btn-accent" style="width:100%;">Save Changes</button>
        </form>

        <div id="message" runat="server" style="margin-top:1rem; color:#22c55e; font-size:0.9rem;"></div>

        <%
            if (Request.Form["submit"] != null)
            {
                string oldPassword = this.oldPassword.Text;
                if (Authentication(Session["username"].ToString(), oldPassword))
                {
                    string[] userToUpdate = { Session["username"].ToString(), newPassword.Text, email.Text, phonenumber.Text };
                    string[] columns = { "username", "password", "email", "phonenumber"};
                    Edit(columns, userToUpdate);
                }
                else
                    Response.Write("<p style='color:#f87171; margin-top:0.75rem;'>Invalid password — update failed.</p>");
            }
        %>
    </div>

</div>
<script type="text/javascript" src="../Scripts/EditUser.js"></script>
</asp:Content>
