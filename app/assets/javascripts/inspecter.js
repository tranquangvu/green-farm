//= require socket.io
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require parsley
//= require spin.js/spin.min
//= require autosize/dist/autosize.min
//= require moment/min/moment.min
//= require Flot/jquery.flot
//= require Flot/jquery.flot.time
//= require Flot/jquery.flot.resize
//= require libs/Flot/jquery.flot.orderBars
//= require Flot/jquery.flot.pie
//= require libs/Flot/curvedLines
//= require jquery-knob/dist/jquery.knob.min
//= require libs/jquery.sparkline.min
//= require nanoscroller/bin/javascripts/jquery.nanoscroller
//= require d3/d3.min
//= require rickshaw/rickshaw.min
//= require core/source/App
//= require core/source/AppNavigation
//= require core/source/AppCard
//= require core/source/AppNavSearch
//= require core/source/AppVendor
//= require core/demo/demo
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require bootstrap-datepicker/js/bootstrap-datepicker
//= require twitter-bootstrap-wizard/jquery.bootstrap.wizard.min
//= require libs/circle-progress

$(function(){
  window.setTimeout(function() { $(".notice").alert('close'); }, 8000);

  $('.datepicker').datepicker({
    format: 'yyyy-mm-dd',
    todayBtn: true,
    autoclose: true,
    todayHighlight: true
  });

  $(".monthpicker").datepicker( {
    format: "yyyy-mm",
    startView: "months",
    minViewMode: "months",
    todayBtn: true,
    autoclose: true,
    todayHighlight: true
  });
});

function initCameraStream(target, host, username, password) {
  setTimeout(function() {
    var date = new Date();
    target.src = host + '/cgi-bin/CGIProxy.fcgi?cmd=snapPicture2&usr=' + username + '&pwd=' + password + '&t=' + Math.floor(date.getTime()/1000);
  }, 1000);
}
