
let wordList = [];
let currentIndex = 0;
let correctCount = 0;
let started = false;
let selectedSeconds = 30;
let timeLeft = 0;
let timerInterval;

const WINDOW = 40;

function initTyping() {
    wordList = WORDS;
    currentIndex = 0;
    correctCount = 0;
    document.getElementById('typeInput').addEventListener('keydown', handleKey);
    document.getElementById('timer').innerHTML = "Ready";
    renderWords();
}

function selectDuration(seconds, btn) {
    if (started) return;
    selectedSeconds = seconds;
    let buttons = document.getElementsByClassName('dur-btn');
    for (let i = 0; i < buttons.length; i++) {
        buttons[i].classList.remove('active');
    }
    btn.classList.add('active');
    document.getElementById('timer').innerHTML = "Ready";
}

function setSelectorDisabled(disabled) {
    let buttons = document.getElementsByClassName('dur-btn');
    for (let i = 0; i < buttons.length; i++) {
        buttons[i].disabled = disabled;
    }
}

function renderWords() {
    let html = "";
    let end = Math.min(currentIndex + WINDOW, wordList.length);
    for (let i = currentIndex; i < end; i++) {
        let cls = (i === currentIndex) ? "word current" : "word";
        html += "<span class='" + cls + "'>" + wordList[i] + "</span> ";
    }
    document.getElementById('words').innerHTML = html;
}

function startTest() {
    if (started) return;
    if (wordList.length === 0) return;

    started = true;
    correctCount = 0;
    currentIndex = 0;
    renderWords();

    document.getElementById('results').hidden = true;
    document.getElementById('congrats').hidden = true;

    let input = document.getElementById('typeInput');
    input.value = "";
    input.disabled = false;
    input.focus();

    document.getElementById('startBtn').disabled = true;
    setSelectorDisabled(true);

    timeLeft = selectedSeconds;
    updateTimer();
    timerInterval = setInterval(tick, 1000);
}

function tick() {
    timeLeft--;
    updateTimer();
    if (timeLeft <= 0) {
        endTest();
    }
}

function updateTimer() {
    document.getElementById('timer').innerHTML = timeLeft + "s";
}

function handleKey(e) {
    if (!started) return;
    if (e.key === ' ' || e.keyCode === 32) {
        e.preventDefault();
        let input = document.getElementById('typeInput');
        let typed = input.value.trim();
        if (typed === wordList[currentIndex]) {
            correctCount++;
        }
        currentIndex++;
        input.value = "";
        if (currentIndex >= wordList.length) {
            endTest();
            return;
        }
        renderWords();
    }
}

function endTest() {
    clearInterval(timerInterval);
    started = false;

    document.getElementById('typeInput').disabled = true;
    setSelectorDisabled(false);
    document.getElementById('timer').innerHTML = "Time's up!";

    let minutes = selectedSeconds / 60;
    let wpm = Math.round(correctCount / minutes);

    document.getElementById('wpmValue').innerHTML = wpm;
    document.getElementById('results').hidden = false;
    document.getElementById('congrats').hidden = true;

    submitScore(wpm);
}

function submitScore(wpm) {
    fetch(SUBMIT_URL + "?ajax=submitScore&wpm=" + wpm)
        .then(function (response) { return response.text(); })
        .then(function (text) {
            if (text.trim() === "true") {
                document.getElementById('congrats').hidden = false;
            }
        })
        .catch(function () { });
}

function tryAgain() {
    clearInterval(timerInterval);
    started = false;
    correctCount = 0;
    currentIndex = 0;

    document.getElementById('results').hidden = true;
    document.getElementById('congrats').hidden = true;

    let input = document.getElementById('typeInput');
    input.value = "";
    input.disabled = true;

    document.getElementById('startBtn').disabled = false;
    setSelectorDisabled(false);
    document.getElementById('timer').innerHTML = "Ready";
    renderWords();
}
