// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require cocoon
//= require_tree .

$(function(){
  function slideFade(elem) {

    var fade = { opacity: 0, transition: 'opacity 5s' };
    elem.delay(2000).css(fade).slideUp(3000);
  }

  slideFade($('.alert'));


  $( "#team-1" ).click(function() {
    $( "#team-members" ).toggle('hide')
  });

  $( "#search-events-button" ).click(function() {
  $( "#search-form-and-result" ).toggle('hide')
  });

  $("#largest-text").on("click", function() {largestText();
  });

  $("#original-text").on("click", function() {originalText();
  });

  $("#smallest-text").on("click", function() {smallestText();
  });

  $( ".important-docs" ).click(function() {
    $( ".im-docs" ).toggle('hide')
  });

  $( ".team-docs" ).click(function() {
    $( ".docs" ).toggle('hide')
  });

})

function largestText() {
  if (document.body.style.fontSize == "") {
    document.body.style.fontSize = "1.0em";
  }
  document.body.style.fontSize = "1.2em";
}

function smallestText() {
  if (document.body.style.fontSize == "") {
    document.body.style.fontSize = "1.0em";
  }
  document.body.style.fontSize = "0.9em";
}

function originalText() {
  if (document.body.style.fontSize == "") {
    document.body.style.fontSize = "1.0em";
  }
  document.body.style.fontSize = "1.0em";
}
