<%@ Page Title="Home" Language="C#" MasterPageFile="~/KeyRush/Pages/MasterPage.master" AutoEventWireup="true" CodeFile="Homepage.aspx.cs" Inherits="Pages_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link href="../Styles/General.css" rel="stylesheet" />
    <link href="../Styles/Homepage.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="page-content">

    <section class="hero">
        <h1>KeyRush</h1>
        <p class="subtitle">Test your typing speed and CPS. Track your personal best. Compete on the global leaderboard.</p>
        <div class="hero-actions">
            <a href="Typing.aspx" class="cta-btn primary">Start Typing Test</a>
            <a href="CPS.aspx" class="cta-btn secondary">Start CPS Test</a>
        </div>
    </section>

    <hr class="section-divider" />

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
