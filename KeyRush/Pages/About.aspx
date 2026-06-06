<%@ Page Title="About" Language="C#" MasterPageFile="~/KeyRush/Pages/MasterPage.master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="KeyRush_Pages_About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link href="../Styles/General.css" rel="stylesheet" />
    <link href="../Styles/About.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="page-content">

    <section class="about-header">
        <h1>About KeyRush</h1>
        <p class="subtitle">Everything you need to know about the platform.</p>
    </section>

    <hr class="section-divider" />

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
