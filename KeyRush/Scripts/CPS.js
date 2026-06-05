// CPS test logic. Loaded by CPS.aspx via <script src="../Scripts/CPS.js">.
// Original click-counting + timer behaviour, plus a duration selector.

let counter = 0;
let started = false;
let timeout;
let selectedDuration = 5000; // default: 5 seconds

// Called by the duration buttons. Records the chosen duration and moves the
// "active" highlight to the clicked button. Ignored while a test is running.
function selectDuration(ms, btn) {
    if (started) return;
    selectedDuration = ms;
    let buttons = document.getElementsByClassName('dur-btn');
    for (let i = 0; i < buttons.length; i++) {
        buttons[i].classList.remove('active');
    }
    btn.classList.add('active');
}

function setSelectorDisabled(disabled) {
    let buttons = document.getElementsByClassName('dur-btn');
    for (let i = 0; i < buttons.length; i++) {
        buttons[i].disabled = disabled;
    }
}

function cps() {
    if (!started) {
        started = true;
        counter = 0;
        document.getElementById('cps').innerHTML = "Keep clicking!";
        document.getElementById('score').innerHTML = "Your score is: 0";
        document.getElementById('results').hidden = true;
        document.getElementById('congrats').hidden = true;
        setSelectorDisabled(true);
        timeout = setTimeout(endCPS, selectedDuration);
    }
    counter++;
    document.getElementById('score').innerHTML = "Your score is: " + counter;
}

function endCPS() {
    document.getElementById('cps').disabled = true;
    document.getElementById('cps').innerHTML = "Click Me!";
    document.getElementById('score').innerHTML = "Final score: " + counter + " (Time's up!)";
    setSelectorDisabled(false);
    started = false;

    let seconds = selectedDuration / 1000;
    let cpsScore = Math.round((counter / seconds) * 100) / 100;

    document.getElementById('cpsValue').innerHTML = cpsScore;
    document.getElementById('results').hidden = false;
    document.getElementById('congrats').hidden = true;

    submitScore(cpsScore);
}

// Send the score to the server. The server replies "true" when it is a new
// personal best, which reveals the congratulations message.
function submitScore(cps) {
    fetch(SUBMIT_URL + "?ajax=submitScore&cps=" + cps)
        .then(function (response) { return response.text(); })
        .then(function (text) {
            if (text.trim() === "true") {
                document.getElementById('congrats').hidden = false;
            }
        })
        .catch(function () { /* ignore network errors */ });
}

function restart() {
    clearTimeout(timeout);
    document.getElementById('cps').disabled = false;
    document.getElementById('cps').innerHTML = "Click Me!";
    document.getElementById('score').innerHTML = "Press to begin";
    counter = 0;
    started = false;
    setSelectorDisabled(false);
    document.getElementById('results').hidden = true;
    document.getElementById('congrats').hidden = true;
}
