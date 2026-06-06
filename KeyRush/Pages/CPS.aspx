<%@ Page Title="CPS Test" Language="C#" MasterPageFile="~/KeyRush/Pages/MasterPage.master" AutoEventWireup="true" CodeFile="CPS.aspx.cs" Inherits="KeyRush_Pages_CPS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link href="../Styles/General.css" rel="stylesheet" />
    <script type="text/javascript" src="../Scripts/CPS.js?v=4"></script>
    <link href="../Styles/CPS.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="page-content" style="text-align:center;">

    <h1 style="font-size:2.6rem; margin-bottom:0.5rem;">CPS Test</h1>
    <p style="color:#94a3b8; font-size:1.1rem;">How fast can you click? Choose a duration, then press the button.</p>

    <div style="margin-top:3rem;">
        <p style="color:#94a3b8; font-size:0.95rem; margin-bottom:0.75rem;">Select duration</p>
        <div id="time-selector">
            <button type="button" class="dur-btn"        onclick="selectDuration(1000, this);">1 s</button>
            <button type="button" class="dur-btn active" onclick="selectDuration(5000, this);">5 s</button>
            <button type="button" class="dur-btn"        onclick="selectDuration(10000, this);">10 s</button>
            <button type="button" class="dur-btn"        onclick="selectDuration(60000, this);">1 min</button>
        </div>

        <div id="score">Press to begin</div>

        <button type="button" id="cps"
            onclick="cps();"
            onmousedown="if(!this.disabled)this.style.transform='scale(0.91)'"
            onmouseup="this.style.transform='scale(1)'"
            onmouseleave="this.style.transform='scale(1)'">
            Click Me!
        </button>
        <br />
        <button type="button" id="restart" onclick="restart();">Start again</button>

        <div id="results" hidden>
            <p style="color:#94a3b8; margin-bottom:0.3rem;">Your speed</p>
            <div class="cps-score"><span id="cpsValue">0</span> CPS</div>
            <div id="congrats" hidden>Congrats! You broke your record!</div>
            <button type="button" id="again" onclick="restart();">Try again</button>
        </div>
    </div>

    <hr class="section-divider" />

    <h2 style="text-align:center;">Leaderboard — Top 3 (CPS)</h2>
    <div class="table-scroll-wrapper">
        <div id="leaderboard" runat="server"></div>
    </div>
    <div id="myRank" runat="server"></div>

</div>

<script type="text/javascript">
    var SUBMIT_URL = "CPS.aspx";
</script>
</asp:Content>
