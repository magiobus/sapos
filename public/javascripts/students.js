// ** On change Program
var advprev = 0;

$('#program').live("change", function() {
  liveSearch();
});

// ** On change Status
$('.status-cbs').live("click", function() {
  liveSearch();
});


function initializeSearchForm() {
  $("#program option[value=0]").attr("selected", true);
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
