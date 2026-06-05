<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Notalowedadmin.aspx.cs" Inherits="KeyRush_Pages_Notalowed" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Access Denied — GameZone</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <style>
        :root {
            --bg: #0f1117;
            --surface: #1a1d2e;
            --border: #2d3148;
            --accent: #6c63ff;
            --text: #e2e8f0;
            --text-muted: #94a3b8;
        }
        *, *::before, *::after { box-sizing: border-box; }
        body {
            margin: 0;
            min-height: 100vh;
            background: var(--bg);
            color: var(--text);
            font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 2rem;
        }
        .error-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 3.5rem 3rem;
            max-width: 520px;
            width: 100%;
        }
        .error-code {
            font-size: 4rem;
            font-weight: 700;
            color: #f87171;
            line-height: 1;
            margin-bottom: 0.5rem;
        }
        h1 {
            font-size: 1.4rem;
            font-weight: 600;
            color: #ffffff;
            margin: 0 0 0.75rem;
        }
        p {
            color: var(--text-muted);
            font-size: 0.95rem;
            margin-bottom: 2rem;
        }
        .btn-home {
            background: var(--accent);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 0.75rem 2rem;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s, transform 0.1s;
        }
        .btn-home:hover {
            background: #5a52e0;
            transform: translateY(-1px);
        }
    </style>
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
