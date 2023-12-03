function validateForm(containerForm) {
    var x, y, i, valid = true;
    y = document.querySelectorAll('.'+ containerForm +' .need-validation'); // Use querySelectorAll to select elements with the attribute
    for (i = 0; i < y.length; i++) {

        if (y[i].tagName === "SELECT") {
            // For dropdowns, check if no option is selected
            if (y[i].value === "" || y[i].value === "0") {
                y[i].classList.add("is-invalid");
                valid = false;

            } else {
                y[i].classList.remove("is-invalid"); 
            }
        } else {
            // For input fields, check if they are empty
            if (y[i].value === "") {
                y[i].classList.add("is-invalid");
                valid = false;
            } else {
                y[i].classList.remove("is-invalid"); // Remove "invalid" class when it's not empty or not zero
            }
        }
    }
    return valid;
}