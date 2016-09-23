
function ValidURL(str) {
  var pattern = new RegExp('^(https?:\\/\\/)'+ // protocol
    '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|'+ // domain name
    '((\\d{1,3}\\.){3}\\d{1,3}))'+ // OR ip (v4) address
    '(\\:\\d+)?(\/[-a-z\\d%_.~+]*)*'+ // port and path
    '(\\?[;&a-z\\d%_.~+=-]*)?'+ // query string
    '(\\#[-a-z\\d_]*)?$','i'); // fragment locater
  if(!pattern.test(str)) {
    return false;
  } else {
    return true;
  }
}

var clearNewRedirectForm = function() {
  $('#newRedirectUrl').val('');
  $('#newRedirectCode').val('');
};

var postNewRedirect = function() {
  var rUrl = $('#add-link-input').val();
  var u = (ValidURL(rUrl)) ? rUrl : "http://" + rUrl;
  if(!ValidURL(u)){
    alert("Invalid URL");
    return;
  }
  return $.ajax({
    url: '/api/',
    type: 'POST',
    data: {
      url: u
    },
    success: function() {
      alert("Link added!");
    },
    error: function() {
      alert("something fucked up!");
    }
  });
}

$(document).ready(function() {
});

$( "#add-link-btn" ).click(function( ) {
  var post = postNewRedirect();
  post.done(function(p){
    alert("Done with the post")  ;
  });
});



$('#clear-link-btn').click(function() {
  clearNewRedirectForm();
});