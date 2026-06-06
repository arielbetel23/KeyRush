<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Notalowedadmin.aspx.cs" Inherits="KeyRush_Pages_Notalowed" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Access Denied — GameZone</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link rel="stylesheet" href="../Styles/Notalowedadmin.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="error-card">
            <div class="error-code">403</div>
            <h1>Access Denied</h1>
            <p>You don't have permission to view this page.</p>
            <button type="submit" name="submit" class="btn-home">Go Back Home</button>
        </div>
    </form>
    <%
        if (Request.Form["submit"] != null)
            Response.Redirect("Homepage.aspx");
    %>
</body>
</html>
