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

// Plan
var current_plan_edit = 0;
function loadPlanTable() {
  program_id = $('#program_id').val();
  url = location.pathname + '/' + program_id + '/plan';
  $.get(url, {}, function(html) {
    $("#plan-area").html(html);
    loadCoursesDropdown();
  });
  $("#new-course-dialog").remove();
  $('#content-panel').append('<div title="Nuevo curso" id="new-course-dialog"><iframe width="550" height="340" src="/programas/' + program_id + '/nuevo_curso" scrolling="no"></iframe></div>');
  $("#new-course-dialog").dialog({ autoOpen: false, width: 640, height: 450, modal:true });
  $("#a-new-course").live("click", function() {
    $("#new-course-dialog").dialog('open');
  });
}

function hideCurrentCourse() {
  if (current_plan_edit != 0) {
    $("#div_"+current_plan_edit).slideUp("fast", function() {
      $('#tr_'+current_plan_edit).animate({ backgroundColor: "white" }, 1000, function() {
        $('#tr_'+current_plan_edit).removeClass("selected");
      });
    });
  }
}

$(".course").live("click", function() {
  program_id = $('#program_id').val();
  var course_id = $('#'+this.id).attr('course_id');
  var tr_id = this.id;
  if (current_plan_edit != course_id) {
    if (current_plan_edit != 0) {
      current_plan_edit2 = current_plan_edit;
      $("#div_"+current_plan_edit).slideUp("fast", function() {
        $("#edit-course_"+current_plan_edit2).remove();
        $('#tr_'+current_plan_edit2).animate({ backgroundColor: "white" }, 1000, function() {
          $('#tr_'+current_plan_edit2).removeClass("selected");
        });
      });
    }
    url = location.pathname + '/' + program_id + '/curso/' + course_id;
    $("<tr class=\"edit-course\" id=\"edit-course_" + course_id + "\"><td colspan=\"5\"><div class=\"edit-course-div\" id=\"div_"+course_id+"\"></div></td></tr>").insertAfter($('#'+this.id));
    $.get(url, {}, function(html) {
      $('#'+tr_id).animate({ backgroundColor: "#dddddd" }, 1000);
      $("#div_"+course_id).hide().html(html).slideDown("fast", function() {
        $('#'+tr_id).addClass("selected");
      });
    });
    current_plan_edit = course_id;
  } else {
    $("#div_"+course_id).slideUp("fast", function() {
      $(".edit-course").remove();
      $('#'+tr_id).animate({ backgroundColor: "white" }, 1000, function() {
        $('#'+tr_id).removeClass("selected");
      });
    });
    current_plan_edit = 0;
  }
});


// Terms
var current_term_edit = 0;
function loadTermsTable() {
  program_id = $('#program_id').val();
  url = location.pathname + '/' + program_id + '/periodos';
  $.get(url, {}, function(html) {
    $("#terms-area").html(html);
    loadTermsDropdown();
  });
  $("#new-term-dialog").remove();
  $('#content-panel').append('<div title="Nuevo periodo" id="new-term-dialog"><iframe width="550" height="340" src="/programas/' + program_id + '/nuevo_periodo" scrolling="no"></iframe></div>');
  $("#new-term-dialog").dialog({ autoOpen: false, width: 640, height: 450, modal:true });
  $("#a-new-term").live("click", function() {
    $("#new-term-dialog").dialog('open');
  });
}

function hideCurrentTerm() {
  if (current_term_edit != 0) {
    $("#div_"+current_term_edit).slideUp("fast", function() {
      $('#tr_term_'+current_term_edit).animate({ backgroundColor: "white" }, 1000, function() {
        $('#tr_term_'+current_term_edit).removeClass("selected");
      });
    });
  }
}

$(".term-item").live("click", function() {
  program_id = $('#program_id').val();
  var term_id = $('#'+this.id).attr('term_id');
  var tr_term_id = this.id;
  if (current_term_edit != term_id) {
    if (current_term_edit != 0) {
      current_term_edit2 = current_term_edit;
      $("#div_"+current_term_edit).slideUp("fast", function() {
        $("#edit-course_"+current_term_edit2).remove();
        $('#tr_term_'+current_term_edit2).animate({ backgroundColor: "white" }, 1000, function() {
          $('#tr_term_'+current_term_edit2).removeClass("selected");
        });
      });
    }

    url = location.pathname + '/' + program_id + '/periodo/' + term_id;
    $("<tr class=\"edit-course\" id=\"edit-course_" + term_id + "\"><td colspan=\"5\"><div class=\"edit-course-div\" id=\"div_"+term_id+"\"></div></td></tr>").insertAfter($('#'+this.id));
    $.get(url, {}, function(html) {
      $('#'+tr_term_id).animate({ backgroundColor: "#dddddd" }, 1000);
      $("#div_"+term_id).hide().html(html).slideDown("fast", function() {
        $('#'+tr_term_id).addClass("selected");
      });
    });
    current_term_edit = term_id;
  } else {
    $("#div_"+term_id).slideUp("fast", function() {
      $(".edit-course").remove();
      $('#'+tr_term_id).animate({ backgroundColor: "white" }, 1000, function() {
        $('#'+tr_term_id).removeClass("selected");
      });
    });
    current_term_edit = 0;
  }
});


// Schedule
var current_schedule_edit = 0;
function loadSchedule() {
  term_id = $('#tc_term_id').val();
  course_id = $('#tc_course_id').val();
  program_id = $('#program_id').val();
  if ((term_id > 0) && (course_id > 0)) {
    url = location.pathname + "/" + program_id + "/periodo/" + term_id + "/curso/" + course_id + "/horario";
    $.get(url, {}, function(html) {
      $("#schedule-area").html(html);
    });
    $("#new-schedule-dialog").remove();
    url_dialog = location.pathname + "/" + program_id + "/periodo/" + term_id + "/curso/" + course_id + "/nueva_sesion";
    $('#content-panel').append('<div title="Agregar sesión" id="new-schedule-dialog"><iframe width="550" height="340" src="' + url_dialog + '" scrolling="no"></iframe></div>');
    $("#new-schedule-dialog").dialog({ autoOpen: false, width: 640, height: 450, modal:true });
    $("#a-new-schedule").live("click", function() {
      $("#new-schedule-dialog").dialog('open');
    });
  } else {
      $("#schedule-area").html('');
  }
}

function hideCurrentSchedule() {
  if (current_schedule_edit != 0) {
    $("#div_"+current_schedule_edit).slideUp("fast", function() {
      $('#tr_schedule_'+current_schedule_edit).animate({ backgroundColor: "white" }, 1000, function() {
        $('#tr_schedule_'+current_schedule_edit).removeClass("selected");
      });
    });
  }
}

$(".schedule-item").live("click", function() {
  program_id = $('#program_id').val();
  term_id = $('#tc_term_id').val();
  course_id = $('#tc_course_id').val();
  var schedule_id = $('#'+this.id).attr('schedule_id');
  var tr_schedule_id = this.id;
  if (current_schedule_edit != schedule_id) {
    if (current_schedule_edit != 0) {
      current_schedule_edit2 = current_schedule_edit;
      $("#div_"+current_schedule_edit).slideUp("fast", function() {
        $("#edit-course_"+current_schedule_edit2).remove();
        $('#tr_schedule_'+current_schedule_edit2).animate({ backgroundColor: "white" }, 1000, function() {
          $('#tr_schedule_'+current_schedule_edit2).removeClass("selected");
        });
      });
    }

    url = location.pathname + '/' + program_id + '/periodo/' + term_id + '/curso/' + course_id + '/sesion/' + schedule_id;
    $("<tr class=\"edit-course\" id=\"edit-course_" + schedule_id + "\"><td colspan=\"6\"><div class=\"edit-course-div\" id=\"div_"+schedule_id+"\"></div></td></tr>").insertAfter($('#'+this.id));
    $.get(url, {}, function(html) {
      $('#'+tr_schedule_id).animate({ backgroundColor: "#dddddd" }, 1000);
      $("#div_"+schedule_id).hide().html(html).slideDown("fast", function() {
        $('#'+tr_schedule_id).addClass("selected");
      });
    });
    current_schedule_edit = schedule_id;
  } else {
    $("#div_"+schedule_id).slideUp("fast", function() {
      $(".edit-course").remove();
      $('#'+tr_schedule_id).animate({ backgroundColor: "white" }, 1000, function() {
        $('#'+tr_schedule_id).removeClass("selected");
      });
    });
    current_schedule_edit = 0;
  }
});


// Program
$('#tc_term_id').live("change", function() {
  loadCoursesDropdown();
});

function loadTermsDropdown() {
  program_id = $('#program_id').val();
  url = location.pathname + "/" + program_id + "/terms_dropdown";
  $.get(url, {}, function(html) {
    $("#terms-dropdown").html(html);
    $("#courses-dropdown").html('<span>Es necesario seleccionar un periodo</span>');
    $("#schedule-area").html('');
  });
}


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
