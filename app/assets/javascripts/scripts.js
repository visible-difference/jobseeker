$(document).ready(function() {
  $("#user_email").focusout(function() {
    var email = document.forms["new_user"]["user[email]"].value;
    var password = document.forms["new_user"]["user[password]"];
    if (email == "test@test.com") {
      password.value = "test1234";
    }
  });
  setTimeout(function(){
    $('#flash').remove();
  }, 5000);

  $('#add-comp-address-btn').click(function(){
    $('#add-comp-address').toggle();
    $(this).remove();
  }); 

  $('#view-comp-info-btn').click(function() {
    $('#comp-info').toggle();
    $('#iconChange').toggleClass('fa-chevron-up').toggleClass('fa-chevron-down');
    $('#view-comp-info-btn').blur();
  });

  $('.enter-home-1').click(function() {
    $(this).blur();
  }) 

});
