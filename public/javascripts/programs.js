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
  } else {
      $("#schedule-area").html('');
  }
}

$('#tc_term_id').live("change", function() {
  loadCoursesDropdown();
});

function loadCoursesDropdown() {
  term_id = $('#tc_term_id').val();
  program_id = $('#program_id').val();
  $("#schedule-area").html('');
  if (term_id > 0) {
    url = location.pathname + "/" + program_id + "/periodo/" + term_id + "/courses_dropdown";
    $.get(url, {}, function(html) {
      $("#courses-dropdown").html(html);
    });
  } else {
      $("#courses-dropdown").html('<span>Es necesario seleccionar un periodo</span>');
  }
}

$('#tc_course_id').live("change", function() {
  if ($('#tc_course_id').val() == 0) {
    openAssignCoursesDialog();
  } else {
    loadSchedule();
  }
});
    
function openAssignCoursesDialog() {
  $("#schedule-area").html('');
  program_id = $('#program_id').val();
  term_id = $('#tc_term_id').val();
  $("#select-courses-dialog").remove();
  url = '/programas/' + program_id + '/periodo/' + term_id + '/seleccionar_cursos';
  $('#content-panel').append('<div title="Asignar cursos" id="select-courses-dialog"><iframe width="550" height="440" src="' + url + '" scrolling="no"></iframe></div>');
  $("#select-courses-dialog").dialog({ autoOpen: true, width: 590, height: 550, modal:true });
}
