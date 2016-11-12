//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require parsley
//= require nprogress

//**
//* vendor
//**
//= require spin.js/spin.min
//= require autosize/dist/autosize.min
//= require moment/min/moment.min
//= require Flot/jquery.flot
//= require Flot/jquery.flot.time
//= require Flot/jquery.flot.resize
//= require jquery.flot.orderBars
//= require Flot/jquery.flot.pie
//= require curvedLines
//= require jquery-knob/dist/jquery.knob.min
//= require jquery.sparkline.min
//= require nanoscroller/bin/javascripts/jquery.nanoscroller
//= require d3/d3.min
//= require rickshaw/rickshaw.min
//= require core/App
//= require core/AppNavigation
//= require core/AppCard
//= require core/AppNavSearch
//= require core/AppVendor
//= require twitter-bootstrap-wizard/jquery.bootstrap.wizard.min
//= require dashboard
//**
//* end vendor
//**

// Camera
function initCameraStream(target, host, username, password) {
  setTimeout(function() {
    var date = new Date();
    target.src = host + '/cgi-bin/CGIProxy.fcgi?cmd=snapPicture2&usr=' + username + '&pwd=' + password + '&t=' + Math.floor(date.getTime()/1000);  
  }, 1000);
}

// =================================
// COMMON JS
// =================================

// init progress bar
NProgress.configure({
  showSpinner: false,
  ease: 'ease',
  speed: 500
});

window.onbeforeunload = function(e) {
  NProgress.start();  
};

$(function(){
  // set timeout for alert close
  window.setTimeout(function() { $(".noty").alert('close'); }, 8000);

  // done progress bar when page loaded
  NProgress.set(0.2);
  NProgress.done();
});
