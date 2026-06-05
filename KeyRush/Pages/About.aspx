<%@ Page Title="About" Language="C#" MasterPageFile="~/KeyRush/Pages/MasterPage.master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="KeyRush_Pages_About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link href="../Styles/General.css" rel="stylesheet" />
    <style>
        /* Header */
        .about-header {
            text-align: center;
            padding: 2.5rem 1.5rem 1rem;
        }
        .about-header h1 {
            font-size: 3rem;
            margin: 0 0 0.75rem;
            letter-spacing: -0.02em;
        }
        .about-header .subtitle {
            color: #94a3b8;
            font-size: 1.15rem;
            margin: 0;
        }

        /* How it works — step cards */
        .steps-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
            margin-top: 1.5rem;
        }
        .step-card {
            background: #1a1d2e;
            border: 1px solid #2d3148;
            border-radius: 12px;
            padding: 2rem;
            text-align: center;
            transition: border-color 0.2s, transform 0.15s;
        }
        .step-card:hover {
            border-color: #6c63ff;
            transform: translateY(-3px);
        }
        .step-number {
            width: 3rem;
            height: 3rem;
            margin: 0 auto 1.1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #6c63ff;
            color: #ffffff;
            border-radius: 50%;
            font-size: 1.3rem;
            font-weight: 700;
            box-shadow: 0 4px 18px rgba(108,99,255,0.4);
        }
        .step-card h3 {
            margin: 0 0 0.6rem;
            font-size: 1.2rem;
        }
        .step-card p {
            color: #94a3b8;
            font-size: 0.95rem;
            margin: 0;
        }

        /* Get-started call to action */
        .cta-section {
            text-align: center;
            padding: 1rem 1.5rem 1rem;
        }
        .cta-section .cta-subtitle {
            color: #94a3b8;
            font-size: 1.1rem;
            max-width: 520px;
            margin: 0 auto 2rem;
        }
        .cta-actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            flex-wrap: wrap;
        }
        /* Match the homepage hero buttons (tag + class so Bootstrap resets don't override) */
        a.cta-btn {
            display: inline-block;
            border-radius: 10px;
            padding: 0.85rem 2.2rem;
            font-size: 1.05rem;
            font-weight: 700;
            text-decoration: none;
            transition: background 0.2s, border-color 0.2s, transform 0.1s, color 0.2s;
        }
        a.cta-btn.primary {
            background: #6c63ff;
            color: #ffffff;
            border: 2px solid #6c63ff;
            box-shadow: 0 6px 30px rgba(108,99,255,0.4);
        }
        a.cta-btn.primary:hover {
            background: #5a52e0;
            border-color: #5a52e0;
            color: #ffffff;
            text-decoration: none;
            transform: translateY(-1px);
        }
        a.cta-btn.secondary {
            background: transparent;
            color: #e2e8f0;
            border: 2px solid #2d3148;
        }
        a.cta-btn.secondary:hover {
            border-color: #6c63ff;
            color: #ffffff;
            text-decoration: none;
            transform: translateY(-1px);
        }

        @media (max-width: 720px) {
            .about-header h1 { font-size: 2.4rem; }
            .steps-grid { grid-template-columns: 1fr; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="page-content">

    <%-- Header --%>
    <section class="about-header">
        <h1>About KeyRush</h1>
        <p class="subtitle">Everything you need to know about the platform.</p>
    </section>

    <hr class="section-divider" />

    <%-- What is KeyRush --%>
    <section>
        <h2>What is KeyRush?</h2>
        <div class="card-dark">
            <p>
                KeyRush is a web-based platform for testing and improving your typing speed and
                click speed. It lets you measure your WPM (words per minute) on the typing test
                and your CPS (clicks per second) on the CPS test, track your personal best scores
                over time, and compete with other users on the global leaderboard.
            </p>
        </div>
    </section>

    <%-- How it works --%>
    <section>
        <h2>How it works</h2>
        <div class="steps-grid">
            <div class="step-card">
                <div class="step-number">1</div>
                <h3>Create an account</h3>
                <p>Sign up for a free account to save your scores and join the leaderboard.</p>
            </div>
            <div class="step-card">
                <div class="step-number">2</div>
                <h3>Take a test</h3>
                <p>Choose the typing test or the CPS test and see how fast you really are.</p>
            </div>
            <div class="step-card">
                <div class="step-number">3</div>
                <h3>Track &amp; compete</h3>
                <p>Track your progress over time and compete with other users on the leaderboard.</p>
            </div>
        </div>
    </section>

    <%-- Get started (guests only) --%>
    <% if (!IsLoggedIn) { %>
        <hr class="section-divider" />

        <section class="cta-section">
            <h2>Ready to get started?</h2>
            <p class="cta-subtitle">Create a free account to save your scores and join the global leaderboard.</p>
            <div class="cta-actions">
                <a href="Signup.aspx" class="cta-btn primary">Sign Up</a>
                <a href="Signin2.aspx" class="cta-btn secondary">Sign In</a>
            </div>
        </section>
    <% } %>

</div>
</asp:Content>
