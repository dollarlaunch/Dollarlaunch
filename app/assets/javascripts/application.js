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
//= require jquery
//= require ckeditor-jquery
//= require cocoon
//= require activestorage
//= require dataTables/jquery.dataTables
//= require social-share-button
//= require_tree .
// Images
$(function() {
  // Multiple images preview in browser
  var imagesPreview = function(input, placeToInsertImagePreview) {
    if (input.files) {
      var filesAmount = input.files.length;
      for (i = 0; i < filesAmount; i++) {
        var reader = new FileReader();
        reader.onload = function(event) {
          $($.parseHTML('<img>')).attr('src', event.target.result).appendTo(placeToInsertImagePreview);
        }
        reader.readAsDataURL(input.files[i]);
      }
    }
  };
  $('#campaign_image').on('change', function() {
    if ($('#campaign_image').val() != "") {
      $('.new-frm-preview img').hide();
    }
    $('.new-frm-preview').show();
    imagesPreview(this, '.new-frm-preview');
    $('.new-frm-img').hide();
    $('.new-frm-preview').addClass('p-0');
  });
});