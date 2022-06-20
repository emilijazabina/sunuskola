function validateEmail() {
    const submitBtn = document.querySelector('.submit');
    var mail = document.forms["myForm"]["email"].value;
    if (mail == "") {
      document.getElementById("chk_option_error").innerHTML = "Email address is required";
      submitBtn.disabled = true;
      return false;
    }
  
    // const regx = /^([a-zA-Z0-9\/_]+)@([a-zA-Z0-9])+.([a-z]+)(.[a-z]+)?$/;
    const regx = /^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$/;
    if (!regx.test(mail)) {
      document.getElementById("chk_option_error").innerHTML = "Please provide a valid e-mail address";
      submitBtn.disabled = true;
      return false;
    }
  
    if (mail.endsWith(".co")) {
      document.getElementById("chk_option_error").innerHTML = "We are not accepting subscriptions from Colombia emails";
      submitBtn.disabled = true;
      return false;
    }
  
    var form_data = new FormData(document.querySelector("form"));
    if (!form_data.has("termsofservice")) {
      document.getElementById("chk_option_error").innerHTML = "You must accept the terms and conditions";
      submitBtn.disabled = true;
      return false;
    }
  
    document.querySelector("form").style.display = "none";
    document.getElementById("chk_option_success").style.display = "block";
  }
  
  function setInputs() {
    const inputs = document.getElementsByTagName("input");
    for (let input of inputs) {
      input.addEventListener("input", enableSubmitBtn);
    }
  }
  
  function enableSubmitBtn() {
    const submitBtn = document.querySelector(".submit");
    submitBtn.disabled = false;
    document.getElementById("chk_option_error").innerHTML = "";
  }

