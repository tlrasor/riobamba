SimpleTable = function(tableId, getCall) {
  this.page = 0; 
  this.pageSize = 10;
  this.id = tableId;
  this.tableData = [];
  this.getCallback = getCall;
  this.clear = function() {
    this.page = 0;
    this.tableData = [];
    $(tableId).find("tr:gt(0)").remove();
  };
  this.write = function() {
    $(tableId).find("tr:gt(0)").remove();
    var trHTML = '';
    var lower = this.page * this.pageSize;
    var upperPage = this.pageSize + (this.page * this.pageSize);
    var upper = (this.tableData.length < upperPage)? this.tableData.length : upperPage;
    var tab = this.tableData.slice(lower, upper)
    $.each(tab, function (i, item) {
      trHTML += '<tr>'; 
      trHTML += '<td>' + item.id + '</td>';
      trHTML += '<td><a href="'+item.url+'">'+item.url+'</td>';
      trHTML += '<td><a href="/r/'+ item.code+'">'+item.code+'</td>';
      trHTML += '<td>' + item.created_at + '</td>';
      trHTML += '</tr>';
    });
    $(this.id).append(trHTML);
    $('#tablePageNumber').val(this.page);
  };
  this.refresh = function() {
    this.clear();
    var cb = this.getCallback(this.tableData);
    var that = this;
    cb.done(function(r){
      that.write();
    });
  };
  this.pageDown = function() {
    if(this.page <= 0) return;
    this.page = this.page - 1;
    this.write();
  };
  this.pageUp = function() {
    var nextLower = (this.page + 1) * this.pageSize;
    if(nextLower > this.tableData.length) {
      return;
    }
    this.page = this.page + 1;
    this.write();
  };
}

var tableGetter = function(td){
  var q = $.ajax({
    url: '/api/r',
    type: 'GET',
    data: {
    },
    success: function(response) {
      $.each(response, function(i, item) {
        var redirect = {
          id: item.redirect.id,
          url: item.redirect.url,
          code: item.code,
          created_at: item.redirect.created_at
        };
        td.push(redirect);
      });
    }
  });
  return q;
}

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
  var rUrl = $('#newRedirectUrl').val();
  var u = (ValidURL(rUrl)) ? rUrl : "http://" + rUrl;
  if(!ValidURL(u)){
    alert("Invalid URL");
    return;
  }
  return $.ajax({
    url: '/api/r',
    type: 'POST',
    data: {
      url: u
    },
    success: function() {
      clearNewRedirectForm();
    }
  });
}

var sTable = new SimpleTable('#simpleTable', tableGetter);

$(document).ready(function() {
  sTable.refresh();
});

$('#tablePageDown').click(function() {
  sTable.pageDown();
});

$('#tablePageUp').click(function() {
  sTable.pageUp();
});

$('#tableRefresh').click(function() {
  sTable.refresh();
});

$('#saveNewRedirect').click(function() {
  var post = postNewRedirect();
  post.done(function(p){
    sTable.refresh();    
  });
});

$('#clearNewRedirect').click(function() {
  clearNewRedirectForm();
});