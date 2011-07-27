var model_name = 'program';
function initializeSearchForm() {
  // Do nothing
}

$(document).ready(function() {
  liveSearch();
});

$('#item-edit-form')
  .live("ajax:beforeSend", function(evt, xhr, settings) {
    hideCurrentCourse();
    hideCurrentTerm();
  })
  .live('ajax:success', function(evt, data, status, xhr) {
    var r = $.parseJSON(xhr.responseText);
    loadPlanTable();
    loadTermsTable();
  });

function loadSchedule() {
  term_id = $('#tc_term_id').val();
  course_id = $('#tc_course_id').val();
  program_id = $('#program_id').val();
  if ((term_id > 0) && (course_id > 0)) {
    url = location.pathname + "/" + program_id + "/periodo/" + term_id + "/curso/" + course_id + "/horario";
    $.get(url, {}, function(html) {
      $("#schedule-area").html(html);
    });
  }
}

$('#tc_term_id').live("change", function() {
  loadSchedule();
});

$('#tc_course_id').live("change", function() {
  loadSchedule();
});
