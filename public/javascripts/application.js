delay = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();

function calcFrameHeight(id) {
  var h = document.getElementById(id).contentWindow.document.body.scrollHeight;
  document.getElementById(id).height = h;
}

function changeResourceImage(id, small, medium) {
  if (small != $('#img-small-' + id).attr('src')) {
    $('#img-small-' + id).attr('src', small);
    $('#img-medium-' + id).attr('src', medium);
  }
}

function liveSearch() {
    $("#search-box").addClass("loading"); 
    var form = $("#live-search"); 
    var url = location.pathname + "/busqueda"; 
    var formData = form.serialize(); 
    $.get(url, formData, function(html) { 
        $("#search-box").removeClass("loading"); 
        $("#items-list").html(html); 
        $("#items-list li:first a").click();
    });
}

function showFormErrors(xhr, status, error) {
    var res,
        errorText,
        errorMsg;

    try {
        res = $.parseJSON(xhr.responseText);
    } catch(err) {
        res['errors'] = { generic_error: "Error:" + err.description };
    }

    $("#flash-notice").removeClass('success').removeClass('notice').removeClass('info');
    $("#flash-notice").addClass('error').html(res['flash']['error']);
    $("#flash-notice").slideDown();

    for ( e in res['errors'] ) {
        errorMsg = $('<div>' + res['errors'][e] + '</div>').addClass('error-message');
        $('#field_student_' + e.replace('.', '_')).addClass('with-errors').append(errorMsg);
    }
}


$(document).ready(function() {

$("#flash-notice").live('click', function() {
    $(this).slideUp();
    $(this).removeClass('error').removeClass('success').removeClass('notice').removeClass('info');
});

$("#search-box")
  .live("keyup", function() {
    delay(function(){
      liveSearch();
    }, 300 );
  })
  .live("click", function() {
    if (this.value == '') {
      liveSearch();
    } 
  });


// ** Get Item **
$('.get-item')
  .live('ajax:success', function(data, status, xhr) {  
    $('.panel-list li').removeClass("selected");
    $('.panel-add').removeClass("selected");
    $(this).closest('li').addClass("selected"); 
    $('#content-panel').html(status);
    $(function() {  
      $('#resource-tabs').tabs(); 
    });

    /** Disable/enable submit button **/
    $('#content-panel form').find (':submit').attr('disabled', 'disabled').addClass('disabled');

    var form = $('#content-panel form');
    $(':input', form.get(0)).live ('change', function (e) {
        form.find (':submit').removeAttr('disabled').removeClass('disabled');
    })
  })

  .live('ajax:beforeSend', function(ev, xhr, settings) {
     $(this).closest('li').addClass("loading");
  })

  .live("ajax:error", function(data, status) {
    console.log(data);
    console.log(status);
   })

  .live('ajax:complete', function(evt, xhr, status) {
     $(this).closest('li').removeClass("loading"); 
  });

$('#add-new-item')
  .live('ajax:beforeSend', function(ev, xhr, settings) {
     $('.panel-add').addClass("selected");
     $('.panel-list li').removeClass("selected");
   })

  .live("ajax:error", function(data, status) {
    console.log(data);
    console.log(status);
   })

  .live('ajax:success', function(data, status, xhr) {  
    $('#content-panel').html(status);
    $(function() {  $('#resource-tabs').tabs(); });

    /** Disable/enable submit button **/
    $('#content-panel form').find (':submit').attr('disabled', 'disabled').addClass('disabled');

    var form = $('#content-panel form');
    $(':input', form.get(0)).live ('change', function (e) {
        form.find (':submit').removeAttr('disabled').removeClass('disabled');
    })
  }
)

$('#item-new-form')
    .live("ajax:beforeSend", function(evt, xhr, settings) {
        var $submitButton = $(this).find('input[type="submit"]');
        $submitButton.data( 'origText', $(this).text() );
        $submitButton.text( "Creando..." );
        $('.error-message').remove();
        $('.with-errors').removeClass('with-errors');
    })
    
    .live("ajax:success", function(evt, data, status, xhr) {
        // Load new
        var $form = $(this);
        var res = $.parseJSON(xhr.responseText);
        $("#flash-notice").removeClass('error').removeClass('notice').removeClass('info');
        $("#flash-notice").addClass('success').html(res['flash']['notice']);
        $("#flash-notice").slideDown().delay(1500).slideUp();
        $("#search-box").val(res['uniq']);
        initializeSearchForm();
        liveSearch();       
    })

    .live('ajax:complete', function(evt, xhr, status) {
        var $submitButton = $(this).find('input[type="submit"]');
        $submitButton.text( $(this).data('origText') );
        $submitButton.attr('disabled', 'disabled').addClass('disabled');
    })

    .live("ajax:error", function(evt, xhr, status, error) {
        showFormErrors(xhr, status, error);
    }
);
  

$('#item-edit-form')
    .live("ajax:beforeSend", function(evt, xhr, settings) {
        var $submitButton = $(this).find('input[type="submit"]');
        $submitButton.data( 'origText', $(this).text() );
        $submitButton.text( "Actualizando..." );
        $('.error-message').remove();
        $('.with-errors').removeClass('with-errors');
    })
    
    .live("ajax:success", function(evt, data, status, xhr) {
        var $form = $(this);
        var res = $.parseJSON(xhr.responseText);
        $("#flash-notice").removeClass('error').removeClass('notice').removeClass('info');
        $("#flash-notice").addClass('success').html(res['flash']['notice']);
        $("#flash-notice").slideDown().delay(1500).slideUp();
    })

    .live('ajax:complete', function(evt, xhr, status) {
        var $submitButton = $(this).find('input[type="submit"]');
        $submitButton.text( $(this).data('origText') );
        $submitButton.attr('disabled', 'disabled').addClass('disabled');
    })

    .live("ajax:error", function(evt, xhr, status, error) {
        showFormErrors(xhr, status, error);
    }
);







});  // READY
