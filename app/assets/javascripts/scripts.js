$(document).ready(function() {
    $("#user_email").focusout(function() {
      var email = document.forms["new_user"]["user[email]"].value;
      var password = document.forms["new_user"]["user[password]"];
      if (email == "test@test.com") {
        password.value = "test1234";
      }
    });
});