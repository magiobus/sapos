var model_name = 'scholarship_category';

function initializeSearchForm() {
  // Do nothing
}


$(document).ready(function() {
  liveSearch();
});

$('#item-edit-form')
  .live("ajax:beforeSend", function(evt, xhr, settings) {
    hideCurrentType();
  })
  .live('ajax:success', function(evt, data, status, xhr) {
    var r = $.parseJSON(xhr.responseText);
    loadTypesTable();
  });


//types
var current_type_edit = 0;
function loadTypesTable() {
  scholarship_category_id = $('#scholarship_category_id').val();
  url = location.pathname + '/' + scholarship_category_id + '/tipos';
  $.get(url, {}, function(html) {
    $("#types-area").html(html);
  //loadTypesDropdown();
  });
  $("#new-type-dialog").remove();
  $('#content-panel').append('<div title="Nuevo Tipo" id="new-type-dialog"><iframe width="550" height="340" src="/becas/' + scholarship_category_id + '/nuevo_tipo" scrolling="no"></iframe></div>');
  $("#new-type-dialog").dialog({ autoOpen: false, width: 640, height: 450, modal:true });
  $("#a-new-type").live("click", function() {
  $("#new-type-dialog").dialog('open');
  });
}

function hideCurrentType() {
  if (current_type_edit != 0) {
    $("#div_"+current_type_edit).slideUp("fast", function() {
      $('#tr_type_'+current_type_edit).animate({ backgroundColor: "white" }, 1000, function() {
        $('#tr_type_'+current_type_edit).removeClass("selected");
      });
    });
  }
}

$(".type-item").live("click", function() {
  program_id = $('#program_id').val();
  var type_id = $('#'+this.id).attr('scholarship_type_id');
  var tr_type_id = this.id;
  if (current_type_edit != type_id) {
    if (current_type_edit != 0) {
      current_type_edit2 = current_type_edit;
      $("#div_"+current_type_edit).slideUp("fast", function() {
        $("#edit-type_"+current_type_edit2).remove();
        $('#tr_type_'+current_type_edit2).animate({ backgroundColor: "white" }, 1000, function() {
          $('#tr_type_'+current_type_edit2).removeClass("selected");
        });
      });
    }

    url = location.pathname + '/' + scholarship_category_id + '/tipo/' + type_id;
    $("<tr class=\"edit-type\" id=\"edit-type_" + type_id + "\"><td colspan=\"5\"><div class=\"edit-type-div\" id=\"div_"+type_id+"\"></div></td></tr>").insertAfter($('#'+this.id));
    $.get(url, {}, function(html) {
      $('#'+tr_type_id).animate({ backgroundColor: "#dddddd" }, 1000);
      $("#div_"+type_id).hide().html(html).slideDown("fast", function() {
        $('#'+tr_type_id).addClass("selected");
      });
    });
    current_type_edit = type_id;
  } else {
    $("#div_"+type_id).slideUp("fast", function() {
      $(".edit-type").remove();
      $('#'+tr_type_id).animate({ backgroundColor: "white" }, 1000, function() {
        $('#'+tr_type_id).removeClass("selected");
      });
    });
    current_type_edit = 0;
  }
});
