var model_name = 'internship';

// ** On change Institution
$('#institution').live("change", function() {
  liveSearch();
});

// ** On change Staff
$('#staff').live("change", function() {
  liveSearch();
});

// ** On change type
$('#internship_type').live("change", function() {
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
