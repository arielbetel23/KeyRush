<%@ Page Title="Home" Language="C#" MasterPageFile="~/KeyRush/Pages/MasterPage.master" AutoEventWireup="true" CodeFile="Homepage.aspx.cs" Inherits="Pages_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link href="../Styles/General.css" rel="stylesheet" />
    <style>
        /* Hero */
        .hero {
            text-align: center;
            padding: 3.5rem 1.5rem 3rem;
        }
        .hero h1 {
            font-size: 3.6rem;
            margin: 0 0 1rem;
            letter-spacing: -0.02em;
        }
        .hero .subtitle {
            color: #94a3b8;
            font-size: 1.2rem;
            max-width: 620px;
            margin: 0 auto 2.2rem;
        }
        .hero-actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            flex-wrap: wrap;
        }
        /* Big call-to-action buttons (tag + class so Bootstrap resets don't override) */
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

        /* Feature cards */
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-top: 1.5rem;
        }
        .feature-card {
            background: #1a1d2e;
            border: 1px solid #2d3148;
            border-radius: 12px;
            padding: 2rem;
            transition: border-color 0.2s, transform 0.15s;
        }
        .feature-card:hover {
            border-color: #6c63ff;
            transform: translateY(-3px);
        }
        .feature-card h3 {
            margin: 0 0 0.6rem;
            font-size: 1.35rem;
        }
        .feature-card p {
            color: #94a3b8;
            font-size: 0.98rem;
            margin-bottom: 1.5rem;
        }
        a.feature-link {
            display: inline-block;
            background: #6c63ff;
            color: #ffffff;
            border-radius: 8px;
            padding: 0.55rem 1.6rem;
            font-size: 0.95rem;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.2s;
        }
        a.feature-link:hover { background: #5a52e0; color: #ffffff; text-decoration: none; }

        /* Personal stats */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-top: 1.5rem;
        }
        .stat-box {
            background: #1a1d2e;
            border: 1px solid #2d3148;
            border-radius: 12px;
            padding: 2rem;
            text-align: center;
        }
        .stat-box .stat-label {
            color: #94a3b8;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            margin-bottom: 0.6rem;
        }
        .stat-box .stat-value {
            font-size: 3rem;
            font-weight: 700;
            color: #ffffff;
            line-height: 1;
        }
        .signin-prompt {
            background: #1a1d2e;
            border: 1px solid #2d3148;
            border-radius: 12px;
            padding: 2.5rem 2rem;
            text-align: center;
            margin-top: 1.5rem;
        }
        .signin-prompt p {
            color: #94a3b8;
            font-size: 1.1rem;
            margin-bottom: 1.3rem;
        }

        @media (max-width: 640px) {
            .hero h1 { font-size: 2.6rem; }
            .feature-grid, .stats-grid { grid-template-columns: 1fr; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="page-content">

    <%-- Hero --%>
    <section class="hero">
        <h1>KeyRush</h1>
        <p class="subtitle">Test your typing speed and CPS. Track your personal best. Compete on the global leaderboard.</p>
        <div class="hero-actions">
            <a href="Typing.aspx" class="cta-btn primary">Start Typing Test</a>
            <a href="CPS.aspx" class="cta-btn secondary">Start CPS Test</a>
        </div>
    </section>

    <hr class="section-divider" />

    <%-- What is KeyRush --%>
    <section>
        <h2>What is KeyRush?</h2>
        <div class="card-dark">
            <p>
                KeyRush lets you measure your typing speed in WPM (words per minute) and your
                click speed in CPS (clicks per second). Improve over time by tracking your
                personal best, and compete with other users on the global leaderboard.
            </p>
        </div>
    </section>

    <%-- Feature cards --%>
    <section>
        <h2>Pick a test</h2>
        <div class="feature-grid">
            <div class="feature-card">
                <h3>Typing Test</h3>
                <p>Type as many words as you can before the timer runs out and see your speed in WPM.</p>
                <a href="Typing.aspx" class="feature-link">Try it</a>
            </div>
            <div class="feature-card">
                <h3>CPS Test</h3>
                <p>Click as fast as you can within the time limit and measure your clicks per second.</p>
                <a href="CPS.aspx" class="feature-link">Try it</a>
            </div>
        </div>
    </section>

    <hr class="section-divider" />

    <%-- Personal stats (logged in) or sign-in prompt (guest) --%>
    <section>
        <h2>Your personal best</h2>
        <% if (IsLoggedIn) { %>
            <div class="stats-grid">
                <div class="stat-box">
                    <div class="stat-label">Best WPM</div>
                    <div class="stat-value"><%= BestWPM %></div>
                </div>
                <div class="stat-box">
                    <div class="stat-label">Best CPS</div>
                    <div class="stat-value"><%= BestCPS %></div>
                </div>
            </div>
        <% } else { %>
            <div class="signin-prompt">
                <p>Sign in to track your personal best</p>
                <a href="Signin2.aspx" class="cta-btn primary">Sign In</a>
            </div>
        <% } %>
    </section>

</div>
</asp:Content>
