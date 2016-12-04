$(document).ready(function() {
  if ($("#inspecter-cameras-show-container").length > 0) {
    $('#save_to_gallery').on('change', function(){
      var cameraSnapshot = $('#camera-snapshot'),
          snapshotUrl = cameraSnapshot.attr('href');

      if ($(this).prop('checked')) {
        cameraSnapshot.attr('href', snapshotUrl.replace('save_to_gallery=false', 'save_to_gallery=true'));
      }
      else {
        cameraSnapshot.attr('href', snapshotUrl.replace('save_to_gallery=true', 'save_to_gallery=false'));
      }
    });
  }
});
