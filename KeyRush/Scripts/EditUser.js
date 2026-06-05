

function checkOldPass() {
    let pass = document.getElementById("oldPassword").value;
    let error = document.getElementById("oldpasswordError");
    styleError(error);

    if (pass.length == 0) {
        error.innerHTML = "Password is required.";
        return false;
    }

    if (pass.length < 6 || pass.length > 12) {
        error.textContent = "Password must be between 6 and 12 characters long.";
        error.style.color = "red";
        return false;
    }

    if (pass.charAt(0) >= '0' && pass.charAt(0) <= '9') {
        error.innerHTML = "Password first letter cannot be a digit!";
        return false;
    }

    if (/[\u0590-\u05FF]/.test(pass)) {
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

function zeroNewPass() {
    let oldpass = document.getElementById("newPassword").value;
    let error = document.getElementById("newpasserror");
    styleError(error);
    if (oldpass.length == 0) {
        return false;
    }
    return true;
}

function checkNewPass() {
    let pass = document.getElementById("newPassword").value;
    let error = document.getElementById("newpasserror");
    styleError(error);
    if (zeroNewPass() == true) {
        if (pass.length < 6 || pass.length > 12) {
            error.textContent = "Password must be between 6 and 12 characters long.";
            error.style.color = "red";
            return false;
        }

        if (pass.charAt(0) >= '0' && pass.charAt(0) <= '9') {
            error.innerHTML = "Password first letter cannot be a digit!";
            return false;
        }

        if (/[\u0590-\u05FF]/.test(pass)) {
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
    
}

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
        if (!/^[a-zA-Z0-9_\-.@]+$/.test(email)) {
            emailError.innerHTML = "Email must only contain English letters, numbers, hyphens, and underscores.";
            return false;
        }

        var atSignIndex = email.indexOf('@');
        var dotIndex = email.lastIndexOf('.');

        if (atSignIndex === -1 || dotIndex === -1) {
            emailError.innerHTML = "Email must contain a '@' and a '.'.";
            return false;
        }

        if (!/^[a-zA-Z]/.test(email)) {
            emailError.innerHTML = "Email must start with a letter.";
            return false;
        }

        if (atSignIndex + 1 < email.length && !/[a-zA-Z]/.test(email.charAt(atSignIndex + 1))) {
            emailError.innerHTML = "The first character after the '@' must be a letter.";
            return false;
        }

        if (email.length - dotIndex - 1 < 2 || email.length - dotIndex - 1 > 3) {
            emailError.innerHTML = "Email must have 2-3 characters after the last dot.";
            return false;
        }


        return true;
    }
    
}

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
}


function styleError(error) {
    error.style.color = "red";
    error.style.fontFamily = "Time New Roman";
    error.style.fontSize = "12px";
    error.innerHTML = "";
}

function EditUser() {
    let display = document.getElementById("display");
    styleError(display);
    display.style.fontSize = "21px";
    console.log("starting the check");

    let isPhoneFilled = ZeroPhoneNum();
    let isEmailFilled = ZeroEmail();
    let isPasswordFilled = zeroNewPass();

    if (!isPhoneFilled && !isEmailFilled && !isPasswordFilled) {
        display.innerHTML = "Must edit at least one field!";
        console.log("No fields to update");
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








