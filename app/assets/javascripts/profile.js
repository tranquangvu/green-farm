//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery.remotipart

$(document).on('dragover', '#dropzone', function() {
  $(this).addClass('hover');
});

$(document).on('dragleave', '#dropzone', function() {
  $(this).removeClass('hover');
});

$(document).on('change', '#dropzone input', function(e) {
  var file = this.files[0];
  $('#dropzone').removeClass('hover');
  if (this.accept && $.inArray(file.type, this.accept.split(/, ?/)) == -1) {
    return alert('File type not allowed.');
  }
  $('#dropzone').addClass('dropped');
  $('#dropzone img').remove();
  if ((/^image\/(gif|png|jpeg)$/i).test(file.type)) {
    var reader = new FileReader(file);
    reader.readAsDataURL(file);
    reader.onload = function (e) {
      var data = e.target.result,
          $img = $('<img />').attr('src', data).fadeIn();
      $('#dropzone .dropzone-content').html($img);
    };
  }
});
