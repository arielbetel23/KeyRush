// Shared client-side validation for every form page: Sign In, Sign Up,
// Forgot Password, and Edit Profile. All four link only to this file.
//
// The *value validators (validatePasswordValue, validateEmailValue,
// validatePhoneValue) hold the actual rules once. Each page calls a thin
// wrapper that reads its own field/error ids and, on Edit Profile, only
// validates when the (optional) field was actually filled in.

function styleError(error) {
    error.style.color = "red";
    error.style.fontFamily = "Time New Roman";
    error.style.fontSize = "12px";
    error.innerHTML = "";
}

// ---------- Password ----------

function validatePasswordValue(pass, error) {
    if (pass.length == 0) {
        error.innerHTML = "Password is required.";
        return false;
    }

    if (pass.length < 6 || pass.length > 12) {
        error.textContent = "Password must be between 6 and 12 characters long.";
        return false;
    }

    if (pass.charAt(0) >= '0' && pass.charAt(0) <= '9') {
        error.innerHTML = "Password first letter cannot be a digit!";
        return false;
    }

    if (/[֐-׿]/.test(pass)) {
        error.innerHTML = "password must only contain English letters";
        return false;
    }

    const specialChars = ['!', '<', '>', '?', '.', ';', '[', ']', '(', ')', '*', '&', '^', '%', '$', '#', '@', '`', '~', '/', '-', '+', ':', ',', '"'];
    let specialCharFound = false;
    let digitFound = false;

    for (var i = 0; i < pass.length; i++) {
        if (specialChars.includes(pass[i])) {
            specialCharFound = true;
        }
        if (pass[i] >= '0' && pass[i] <= '9') {
            digitFound = true;
        }
        if (specialCharFound && digitFound) {
            break;
        }
        if (i < pass.length - 2) {
            if (pass[i] === pass[i + 1] && pass[i + 1] === pass[i + 2]) {
                error.innerHTML = "Password must not contain three identical characters in a row.";
                return false;
            }
        }
    }

    if (!specialCharFound) {
        error.innerHTML = "Password must contain at least one special character.";
        return false;
    }
    if (!digitFound) {
        error.innerHTML = "Password must contain at least one digit.";
        return false;
    }

    if (pass.includes(' ')) {
        error.innerHTML = "password must not contains spaces";
        return false;
    }

    if (!/[A-Z]/.test(pass)) {
        error.innerHTML = "Password must contain at least one uppercase letter.";
        return false;
    }

    return true;
}

// Sign In / Sign Up / Forgot Password — password is always required.
function checkPassword() {
    var pass = document.getElementById("txtPassword").value;
    var error = document.getElementById("passwordError");
    styleError(error);
    return validatePasswordValue(pass, error);
}

// Edit Profile — current password, always required.
function checkOldPass() {
    let pass = document.getElementById("oldPassword").value;
    let error = document.getElementById("oldpasswordError");
    styleError(error);
    return validatePasswordValue(pass, error);
}

// Edit Profile — new password is optional; only validated if filled in.
function zeroNewPass() {
    let pass = document.getElementById("newPassword").value;
    let error = document.getElementById("newpasserror");
    styleError(error);
    if (pass.length == 0) {
        return false;
    }
    return true;
}

function checkNewPass() {
    let pass = document.getElementById("newPassword").value;
    let error = document.getElementById("newpasserror");
    styleError(error);
    if (zeroNewPass() == true) {
        return validatePasswordValue(pass, error);
    }
}

function checkConfirmPassword() {
    let pass = document.getElementById("txtPassword").value;
    let conpass = document.getElementById("txtVerifyPassword").value;
    let error = document.getElementById("confirmError");
    styleError(error);
    if (conpass.length == 0) {
        error.innerHTML = "confirm password is rewuird";
        return false;
    }

    if (conpass.length > 0 && conpass != pass) {
        error.innerHTML = "the confirm password is difrrent from the passwor";
        return false;
    }
    return true;
}

// ---------- Email ----------

function validateEmailValue(email, error) {
    if (email.length == 0) {
        error.innerHTML = "The email is required.";
        return false;
    }

    if (!/^[a-zA-Z0-9_\-.@]+$/.test(email)) {
        error.innerHTML = "Email must only contain English letters, numbers, hyphens, and underscores.";
        return false;
    }

    var atSignIndex = email.indexOf('@');
    var dotIndex = email.lastIndexOf('.');

    if (atSignIndex === -1 || dotIndex === -1) {
        error.innerHTML = "Email must contain a '@' and a '.'.";
        return false;
    }

    if (!/^[a-zA-Z]/.test(email)) {
        error.innerHTML = "Email must start with a letter.";
        return false;
    }

    if (atSignIndex + 1 < email.length && !/[a-zA-Z]/.test(email.charAt(atSignIndex + 1))) {
        error.innerHTML = "The first character after the '@' must be a letter.";
        return false;
    }

    if (email.length - dotIndex - 1 < 2 || email.length - dotIndex - 1 > 3) {
        error.innerHTML = "Email must have 2-3 characters after the last dot.";
        return false;
    }

    return true;
}

// Sign Up — email is always required.
function checkEmail() {
    var email = document.getElementById("email").value;
    var emailError = document.getElementById("emailError");
    styleError(emailError);
    return validateEmailValue(email, emailError);
}

// Edit Profile — email is optional; only validated if filled in.
function ZeroEmail() {
    let email = document.getElementById("email").value;
    if (email.length == 0) {
        return false;
    }
    return true;
}

function checkNewEmail() {
    let email = document.getElementById("email").value;
    let emailError = document.getElementById("newEmailError");
    styleError(emailError);
    if (ZeroEmail() == true) {
        return validateEmailValue(email, emailError);
    }
}

// ---------- Phone number ----------

function validatePhoneValue(phone, error) {
    if (phone.length === 0) {
        error.innerHTML = "Phone number is required";
        return false;
    }

    if (!/^[0-9-]+$/.test(phone)) {
        error.innerHTML = "Phone number must include only digits and hyphens";
        return false;
    }

    var parts = phone.split('-');

    if (parts.length !== 2) {
        error.innerHTML = "Phone number format is incorrect. Please use 'XX-XXXXXXX' or 'XXX-XXXXXXX'";
        return false;
    }

    if (!(parts[0].length >= 2 && parts[0].length <= 3 && /^\d+$/.test(parts[0]))) {
        error.innerHTML = "Area code must be 2 or 3 digits";
        return false;
    }

    if (!(parts[1].length === 7 && /^\d+$/.test(parts[1]))) {
        error.innerHTML = "Phone number must be exactly 7 digits after the hyphen";
        return false;
    }

    if (!/^0[01346-9]-\d{7}$/.test(phone) && !/^05[0-9]-\d{7}$/.test(phone) && !/^07[0-9]-\d{7}$/.test(phone)) {
        error.innerHTML = "Prefix must be a two-digit number starting with 0 (not followed by 5 or 7) or " +
            "a three-digit prefix starting with 05 or 07, followed by a dash and seven digits.";
        return false;
    }
    return true;
}

// Sign Up — phone number is always required.
function checkPhoneNumber() {
    var phone = document.getElementById("phonenumber").value;
    var error = document.getElementById("phoneError");
    styleError(error);
    return validatePhoneValue(phone, error);
}

// Edit Profile — phone number is optional; only validated if filled in.
function ZeroPhoneNum() {
    let phone = document.getElementById("phonenumber").value;
    if (phone.length == 0) {
        return false;
    }
    return true;
}

function checkNewPhoneNum() {
    let phone = document.getElementById("phonenumber").value;
    let error = document.getElementById("phonenumError");
    styleError(error);
    if (ZeroPhoneNum() == true) {
        return validatePhoneValue(phone, error);
    }
}

// ---------- Sign Up only ----------

function checkUserName() {
    var username = document.getElementById("txtUsername").value;
    var error = document.getElementById("usernameError");
    styleError(error);
    if (username.length == 0) {
        error.innerHTML = "Username is required!";
        return false;
    }
    else if (username.length < 6) {
        error.innerHTML = "Username must contains at least 6 charceters";
        return false;
    }
    var firstLetter = username.charAt(0);
    if (firstLetter >= '0' && firstLetter <= '9') {
        error.innerHTML = "Username first letter cannot be digit!";
        return false;
    }

    if (/[֐-׿]/.test(username)) {
        error.innerHTML = "Username must only contain English letters";
        return false;
    }

    if (username.includes(' ')) {
        error.innerHTML = "Username must not contain spaces";
        return false;
    }

    return true;
}

function checkFirstname() {
    var firstname = document.getElementById("txtFirstname").value;
    var error = document.getElementById("firstnamError");
    styleError(error);

    if (firstname.length == 0) {
        error.innerHTML = "First name is required";
        return false;
    }
    if (firstname.length > 0 && firstname.length < 3) {
        error.innerHTML = "First name minimum length is 3 characters";
        return false;
    }

    var englishLetters = /^[A-Za-z]+$/;
    var hebrewLetters = /^[֐-׿]+$/;

    if (!englishLetters.test(firstname) && !hebrewLetters.test(firstname)) {
        error.innerHTML = "First name must contain only English or Hebrew letters, not both";
        return false;
    }
    return true;
}

function checkLastname() {
    var lastname = document.getElementById("txtLastname").value;
    var error = document.getElementById("lastnamError");
    styleError(error);

    if (lastname.length == 0) {
        error.innerHTML = "Last name is required";
        return false;
    }
    if (lastname.length > 0 && lastname.length < 3) {
        error.innerHTML = "Last name minimum length is 3 characters";
        return false;
    }

    var englishLetters = /^[A-Za-z]+$/;
    var hebrewLetters = /^[֐-׿]+$/;

    if (!englishLetters.test(lastname) && !hebrewLetters.test(lastname)) {
        error.innerHTML = "Last name must contain only English or Hebrew letters, not both";
        return false;
    }
    return true;
}

function checkBirth() {
    var date = document.getElementById("birth").value;
    var error = document.getElementById("birthError");
    styleError(error);
    if (date.length == 0) {
        error.innerHTML = "You must enter your birthday!";
        return false;
    }
    let today = new Date().getTime();
    let d = new Date(date).getTime();
    if (d > today) {
        error.innerHTML = "You must enter date prior from today!";
        return false;
    }

    return true;
}

// ---------- Sign Up + Forgot Password (security questions) ----------

function firstAnswerCheck() {
    let answer = document.getElementById("answer1").value;
    let error = document.getElementById("answer1error");
    styleError(error);
    if (answer.length == 0) {
        error.innerHTML = "the first answer is requird!";
        return false;
    }
    if (answer.length > 0 && answer.length > 8) {
        error.innerHTML = "the length of the answer must be between 1-8 letters";
        return false;
    }
    return true;
}

function secondAnswerCheck() {
    let answer = document.getElementById("answer2").value;
    let error = document.getElementById("secondanswererror");
    styleError(error);
    if (answer.length == 0) {
        error.innerHTML = "the second answer is requird!";
        return false;
    }
    if (answer.length > 0 && answer.length > 8) {
        error.innerHTML = "the length of the answer must be between 1-8 letters";
        return false;
    }
    return true;
}

// ---------- Per-page submit orchestrators ----------

function forgotPass() {
    let check = true;
    check = checkUserName() && check;
    check = firstAnswerCheck() && check;
    check = secondAnswerCheck() && check;
    check = checkPassword() && check;
    return check;
}

function signIn() {
    var check = true;
    check = checkUserName() && check;
    check = checkPassword() && check;
    return check;
}

function signUp() {
    var check = true;
    check = checkUserName() && check;
    check = checkPassword() && check;
    check = checkConfirmPassword() && check;
    check = checkFirstname() && check;
    check = checkLastname() && check;
    check = checkBirth() && check;
    check = checkEmail() && check;
    check = checkPhoneNumber() && check;
    check = firstAnswerCheck() && check;
    check = secondAnswerCheck() && check;
    return check;
}

function EditUser() {
    let display = document.getElementById("display");
    styleError(display);
    display.style.fontSize = "21px";

    let isPhoneFilled = ZeroPhoneNum();
    let isEmailFilled = ZeroEmail();
    let isPasswordFilled = zeroNewPass();

    if (!isPhoneFilled && !isEmailFilled && !isPasswordFilled) {
        display.innerHTML = "Must edit at least one field!";
        return false;
    }

    let updateSuccessful = true;
    if (isPasswordFilled) {
        updateSuccessful = checkNewPass() && updateSuccessful;
    }
    if (isEmailFilled) {
        updateSuccessful = checkNewEmail() && updateSuccessful;
    }
    if (isPhoneFilled) {
        updateSuccessful = checkNewPhoneNum() && updateSuccessful;
    }

    return updateSuccessful;
}
