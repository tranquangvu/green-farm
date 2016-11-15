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
//= require datatables.net/js/jquery.dataTables.min
//= require libs/DataTables/extensions/ColVis/js/dataTables.colVis.min
//= require libs/DataTables/extensions/TableTools/js/dataTables.tableTools.min
//= require bootstrap-datepicker/js/bootstrap-datepicker
//= require twitter-bootstrap-wizard/jquery.bootstrap.wizard.min
//= require core/demo/dashboard

$(function(){
  window.setTimeout(function() { $(".notice").alert('close'); }, 8000);
});

function initCameraStream(target, host, username, password) {
  setTimeout(function() {
    var date = new Date();
    target.src = host + '/cgi-bin/CGIProxy.fcgi?cmd=snapPicture2&usr=' + username + '&pwd=' + password + '&t=' + Math.floor(date.getTime()/1000);
  }, 1000);
}
