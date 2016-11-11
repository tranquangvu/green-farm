//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require socket.io

// Camera
function initCameraStream(target, host, username, password) {
  setTimeout(function() {
    var date = new Date();
    target.src = host + '/cgi-bin/CGIProxy.fcgi?cmd=snapPicture2&usr=' + username + '&pwd=' + password + '&t=' + Math.floor(date.getTime()/1000);  
  }, 1000);
}
