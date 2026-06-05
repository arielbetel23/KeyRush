<%@ Page Title="Typing Test" Language="C#" MasterPageFile="~/KeyRush/Pages/MasterPage.master" AutoEventWireup="true" CodeFile="Typing.aspx.cs" Inherits="KeyRush_Pages_Typing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link href="../Styles/General.css" rel="stylesheet" />
    <script type="text/javascript" src="../Scripts/Typing.js?v=1"></script>
    <style>
        .page-content { max-width: 760px; }

        #time-selector {
            display: flex;
            justify-content: center;
            gap: 0.7rem;
            margin-bottom: 2.5rem;
        }
        /* Tag + class selectors so Bootstrap's button resets don't override these */
        button.dur-btn {
            background: #1a1d2e;
            border: 2px solid #2d3148;
            color: #94a3b8;
            border-radius: 10px;
            padding: 0.6rem 1.4rem;
            font-size: 1rem;
            font-weight: 600;
            font-family: inherit;
            cursor: pointer;
            transition: border-color 0.15s, background 0.15s, color 0.15s, box-shadow 0.15s;
            outline: none;
        }
        button.dur-btn:hover:not(:disabled) {
            border-color: #6c63ff;
            color: #e2e8f0;
        }
        button.dur-btn.active {
            background: #6c63ff;
            border-color: #6c63ff;
            color: #ffffff;
            box-shadow: 0 0 0 4px rgba(108,99,255,0.30);
        }
        button.dur-btn:disabled {
            opacity: 0.38;
            cursor: not-allowed;
        }

        #timer {
            font-size: 2.3rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 1.5rem;
            min-height: 3rem;
        }

        .words-display {
            background: #1a1d2e;
            border: 1px solid #2d3148;
            border-radius: 12px;
            padding: 1.6rem;
            font-size: 1.35rem;
            line-height: 2.4rem;
            color: #94a3b8;
            text-align: left;
            margin-bottom: 1.5rem;
            min-height: 7.2rem;
        }
        .words-display .word { padding: 0 0.18rem; border-radius: 4px; }
        .words-display .word.done { color: #475569; }
        .words-display .word.current {
            background: #6c63ff;
            color: #ffffff;
        }

        input#typeInput {
            width: 100%;
            background: #252840;
            border: 1px solid #2d3148;
            color: #e2e8f0;
            border-radius: 10px;
            padding: 0.8rem 1.1rem;
            font-size: 1.15rem;
            font-family: inherit;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        input#typeInput:focus {
            border-color: #6c63ff;
            box-shadow: 0 0 0 3px rgba(108,99,255,0.2);
        }
        input#typeInput:disabled { opacity: 0.5; cursor: not-allowed; }

        button#startBtn {
            background: #6c63ff;
            color: #fff;
            border: none;
            border-radius: 10px;
            padding: 0.75rem 2.6rem;
            font-size: 1.05rem;
            font-weight: 700;
            font-family: inherit;
            cursor: pointer;
            margin-top: 1.6rem;
            box-shadow: 0 6px 30px rgba(108,99,255,0.4);
            transition: background 0.2s;
            outline: none;
        }
        button#startBtn:hover:not(:disabled) { background: #5a52e0; }
        button#startBtn:disabled { opacity: 0.45; cursor: not-allowed; box-shadow: none; }

        #results {
            background: #1a1d2e;
            border: 1px solid #2d3148;
            border-radius: 12px;
            padding: 2rem;
            margin-top: 1.5rem;
        }
        #results .wpm-score {
            font-size: 3rem;
            font-weight: 700;
            color: #ffffff;
        }
        #congrats {
            color: #4ade80;
            font-weight: 600;
            font-size: 1.15rem;
            margin-top: 0.5rem;
        }
        button#again {
            background: transparent;
            border: 1px solid #2d3148;
            color: #94a3b8;
            border-radius: 8px;
            padding: 0.65rem 2.2rem;
            font-size: 1rem;
            font-family: inherit;
            cursor: pointer;
            margin-top: 1.5rem;
            transition: background 0.2s, color 0.2s;
            outline: none;
        }
        button#again:hover { background: #252840; color: #e2e8f0; }

        /* Leaderboard: highlight the logged-in user's row */
        .usersTable tr.me-row td {
            background: #1e1b4b;
            color: #c4b5fd;
            font-weight: 700;
        }
        .usersTable tr.me-row:hover td { background: #1e1b4b; }
        #myRank {
            text-align: center;
            color: #94a3b8;
            margin-top: 1rem;
            font-size: 1rem;
        }
    </style>
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
    // Word pool (shuffled server-side) and submit target for the client-side test.
    var WORDS = <%= GetWordsJs() %>;
    var SUBMIT_URL = "Typing.aspx";
    initTyping();
</script>
</asp:Content>
