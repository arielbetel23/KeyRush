<%@ Page Title="CPS Test" Language="C#" MasterPageFile="~/KeyRush/Pages/MasterPage.master" AutoEventWireup="true" CodeFile="CPS.aspx.cs" Inherits="KeyRush_Pages_CPS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" />
    <link href="../Styles/General.css" rel="stylesheet" />
    <script type="text/javascript" src="../Scripts/CPS.js?v=4"></script>
    <style>
        .page-content { max-width: 680px; }

        #time-selector {
            display: flex;
            justify-content: center;
            gap: 0.7rem;
            margin-bottom: 3rem;
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

        #score {
            font-size: 2.3rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 2.5rem;
            min-height: 3rem;
        }

        button#cps {
            width: 270px;
            height: 270px;
            background: #6c63ff;
            color: #fff;
            border: none;
            border-radius: 50%;
            font-size: 1.35rem;
            font-weight: 700;
            font-family: inherit;
            cursor: pointer;
            box-shadow: 0 6px 44px rgba(108,99,255,0.5);
            transition: transform 0.08s, background 0.2s;
            user-select: none;
            -webkit-user-select: none;
            outline: none;
        }
        button#cps:hover:not(:disabled) { background: #5a52e0; }
        button#cps:disabled { opacity: 0.45; cursor: not-allowed; box-shadow: none; }

        button#restart {
            background: transparent;
            border: 1px solid #2d3148;
            color: #94a3b8;
            border-radius: 8px;
            padding: 0.65rem 2.2rem;
            font-size: 1rem;
            font-family: inherit;
            cursor: pointer;
            margin-top: 2.2rem;
            transition: background 0.2s, color 0.2s;
            outline: none;
        }
        button#restart:hover { background: #252840; color: #e2e8f0; }

        #results {
            background: #1a1d2e;
            border: 1px solid #2d3148;
            border-radius: 12px;
            padding: 2rem;
            margin-top: 1.5rem;
        }
        #results .cps-score {
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
    // Submit target for the client-side test.
    var SUBMIT_URL = "CPS.aspx";
</script>
</asp:Content>
