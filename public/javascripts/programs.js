var model_name = 'program';
function initializeSearchForm() {
  // Do nothing
}

$(document).ready(function() {
  liveSearch();
});

$('#item-edit-form')
  .live('ajax:success', function(evt, data, status, xhr) {
    var r = $.parseJSON(xhr.responseText);
    loadPlanTable();
  })
