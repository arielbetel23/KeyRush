<%@ Page Title="Typing Test" Language="C#" MasterPageFile="~/KeyRush/Pages/MasterPage.master" AutoEventWireup="true" CodeFile="Typing.aspx.cs" Inherits="KeyRush_Pages_Typing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link href="../Styles/General.css" rel="stylesheet" />
    <script type="text/javascript" src="../Scripts/Typing.js?v=1"></script>
    <link href="../Styles/Typing.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="page-content" style="text-align:center;">

    <h1 style="font-size:2.6rem; margin-bottom:0.5rem;">Typing Test</h1>
    <p style="color:#94a3b8; font-size:1.1rem;">How fast can you type? Choose a duration, then start typing the words.</p>

    <div style="margin-top:2.5rem;">
        <p style="color:#94a3b8; font-size:0.95rem; margin-bottom:0.75rem;">Select duration</p>
        <div id="time-selector">
            <button type="button" class="dur-btn"        onclick="selectDuration(10, this);">10 s</button>
            <button type="button" class="dur-btn active" onclick="selectDuration(30, this);">30 s</button>
            <button type="button" class="dur-btn"        onclick="selectDuration(60, this);">1 min</button>
        </div>

        <div id="timer">Ready</div>

        <div id="words" class="words-display"></div>

        <input type="text" id="typeInput" placeholder="Press Start, then type here…" autocomplete="off" disabled />

        <br />
        <button type="button" id="startBtn" onclick="startTest();">Start</button>

        <div id="results" hidden>
            <p style="color:#94a3b8; margin-bottom:0.3rem;">Your speed</p>
            <div class="wpm-score"><span id="wpmValue">0</span> WPM</div>
            <div id="congrats" hidden>Congrats! You broke your record!</div>
            <button type="button" id="again" onclick="tryAgain();">Try again</button>
        </div>
    </div>

    <hr class="section-divider" />

    <h2 style="text-align:center;">Leaderboard — Top 3 (WPM)</h2>
    <div class="table-scroll-wrapper">
        <div id="leaderboard" runat="server"></div>
    </div>
    <div id="myRank" runat="server"></div>

</div>

<script type="text/javascript">
    var WORDS = <%= GetWordsJs() %>;
    var SUBMIT_URL = "Typing.aspx";
    initTyping();
</script>
</asp:Content>
