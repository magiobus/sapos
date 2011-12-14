var model_name = 'staff';

// ** On change Program
$('#institution').live("change", function() {
  liveSearch();
});

// ** On change Status
$('.status-cbs').live("click", function() {
  liveSearch();
});


function initializeSearchForm() {
  $("#institution option[value=0]").attr("selected", true);
  $('#status_activos').attr('checked', true);
  $('#status_inactivos').attr('checked', false);
}

$(document).ready(function() {
  liveSearch();
});

$('#item-edit-form')
  .live("ajax:beforeSend", function(evt, xhr, settings) {
    hideCurrentSeminar();
  })
  .live('ajax:success', function(evt, data, status, xhr) {
    var r = $.parseJSON(xhr.responseText);
    loadSeminarsTable();
  });


// Seminars
var current_seminar_edit = 0;
function loadSeminarsTable() {
  staff_id = $('#staff_id').val();
  url = location.pathname + '/' + staff_id + '/seminarios';
  $.get(url, {}, function(html) {
    $("#seminars-area").html(html);
  });
  $("#new-seminar-dialog").remove();
  $('#content-panel').append('<div title="Nuevo seminario" id="new-seminar-dialog"><iframe width="550" height="440" src="/docentes/' + staff_id + '/nuevo_seminario" scrolling="no"></iframe></div>');
  $("#new-seminar-dialog").dialog({ autoOpen: false, width: 640, height: 550, modal:true });
  $("#a-new-seminar").live("click", function() {
    $("#new-seminar-dialog").dialog('open');
  });
}

function hideCurrentSeminar() {
  if (current_seminar_edit != 0) {
    $("#div_"+current_seminar_edit).slideUp("fast", function() {
      $('#tr_seminar_'+current_seminar_edit).animate({ backgroundColor: "white" }, 1000, function() {
        $('#tr_seminar_'+current_seminar_edit).removeClass("selected");
      });
    });
  }
}

$(".seminar-item").live("click", function() {
  staff_id = $('#staff_id').val();
  var seminar_id = $('#'+this.id).attr('seminar_id');
  var tr_seminar_id = this.id;
  if (current_seminar_edit != seminar_id) {
    if (current_seminar_edit != 0) {
      current_seminar_edit2 = current_seminar_edit;
      $("#div_"+current_seminar_edit).slideUp("fast", function() {
        $("#edit-seminar_"+current_seminar_edit2).remove();
        $('#tr_seminar_'+current_seminar_edit2).animate({ backgroundColor: "white" }, 1000, function() {
          $('#tr_seminar_'+current_seminar_edit2).removeClass("selected");
        });
      });
    }

    url = location.pathname + '/' + staff_id + '/seminario/' + seminar_id;
    $("<tr class=\"edit-seminar\" id=\"edit-seminar_" + seminar_id + "\"><td colspan=\"5\"><div class=\"edit-seminar-div\" id=\"div_"+seminar_id+"\"></div></td></tr>").insertAfter($('#'+this.id));
    $.get(url, {}, function(html) {
      $('#'+tr_seminar_id).animate({ backgroundColor: "#dddddd" }, 1000);
      $("#div_"+seminar_id).hide().html(html).slideDown("fast", function() {
        $('#'+tr_seminar_id).addClass("selected");
      });
    });
    current_seminar_edit = seminar_id;
  } else {
    $("#div_"+seminar_id).slideUp("fast", function() {
      $(".edit-seminar").remove();
      $('#'+tr_seminar_id).animate({ backgroundColor: "white" }, 1000, function() {
        $('#'+tr_seminar_id).removeClass("selected");
      });
    });
    current_seminar_edit = 0;
  }
});


