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
