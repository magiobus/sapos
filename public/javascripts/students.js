var model_name = 'student';
// ** On change Program
var advprev = 0;

$('#program').live("change", function() {
  liveSearch();
});

$('#campus').live("change", function() {
  liveSearch();
});

$('#supervisor').live("change", function() {
  liveSearch();
});

// ** On change Status
$('.status-cbs').live("click", function() {
  liveSearch();
});

// ** Xls
$('#to_excel').live('click', function() {
  window.location = location.pathname + "/busqueda.xls?" + $("#live-search").serialize();
});


function initializeSearchForm() {
  $("#program option[value=0]").attr("selected", true);
  $("#campus option[value=0]").attr("selected", true);
  $('#status_activos').attr('checked', true);
  $('#status_egresados').attr('checked', false);
  $('#status_bajas').attr('checked', false);
}

$('#advance-select').live("change", function() {
  $('#advance-' + advprev).hide();
  $('#advance-' + $('#advance-select').val()).show();
  advprev = $('#advance-select').val();
});

$(document).ready(function() {
  liveSearch();
});

$('.assign-number')
  .live("ajax:success", function(evt, data, status, xhr) {
    var res = $.parseJSON(xhr.responseText);
    $("#flash-notice").removeClass('error').removeClass('notice').removeClass('info');
    $("#flash-notice").addClass('success').html(res['flash']['notice']);
    $("#flash-notice").slideDown().delay(1500).slideUp();
    $("#thesis-number").html(res['number']);
  })

  .live('ajax:beforeSend', function(ev, xhr, settings) {
    $("#thesis-number").html('Asignando...');
  })

  .live("ajax:error", function(data, status) {
    console.log(data);
    console.log(status);
  })

  .live('ajax:complete', function(evt, xhr, status) {

  });


$('#item-edit-form')
  .live('ajax:success', function(evt, data, status, xhr) {
    var r = $.parseJSON(xhr.responseText);
    if (r['thesis_status'] == 'C') {
      $("#field_student_thesis_number").show();
    }
  });


// Schedule
$('#term_term_id').live("change", function() {
  loadStudentSchedule($('#term_term_id').val());
});

function loadStudentSchedule(term_id) {
  student_id = $('#student_id').val();
  url = location.pathname + '/' + student_id + '/horario/' + term_id;
  $.get(url, {}, function(html) {
    $("#student-schedule-area").html(html);
  });
}

