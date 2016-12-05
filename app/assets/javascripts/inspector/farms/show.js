$(document).ready(function() {
  if ($("#inspecter-farms-show-container").length > 0) {
    var updateTimes = 0;

    var socket = io('http://0.0.0.0:5001');

    socket.on('connect', function() {
      console.log('Client connected');

      socket.emit('client_response_connect', {
        client: true,
        device_id: "#{@farm.device.id}",
        device_ip: "#{@farm.device.ip}"
      });
    });

    socket.on('client_update_view', function(data){
      updateTimes++;
      animation = updateTimes == 1;

      if (data) {
        drawTemperatureCircle(1.0, animation, data.temperature + "℃");
        drawHumidityCircle(data.humidity/100.0, animation, data.humidity + "%");
        drawLightCircle(1.0, animation, data.light + "lux");
        drawSoilMoistureCircle(data.soil_moisture/100.0, animation, data.soil_moisture + "%");
      }
    });

    socket.on('disconnect', function(){
      console.log('Client disconnected');
    });
  }
});

function drawTemperatureCircle(value = null, animation = true, label = null) {
  option = {
    lineCap: 'round',
    emptyFill: '#fafafa',
    fill: {color: '#ff9800'},
    startAngle: 1.5 * Math.PI
  }
  if (value !== null && animation !== null) {
    option.value = value;
    option.animation = animation;
  }
  if (label !== null && label !== '') {
    $('#temperature-circle .chart-value').text(label);
  }
  $('#temperature-circle').circleProgress(option);
}

function drawHumidityCircle(value = null, animation = true, label = null) {
  option = {
    lineCap: 'round',
    emptyFill: '#fafafa',
    fill: {color: '#2196f3'},
    startAngle: 1.5 * Math.PI,
  }
  if (value !== null && animation !== null) {
    option.value = value;
    option.animation = animation;
  }
  if (label !== null && label !== '') {
    $('#humidity-circle .chart-value').text(label);
  }
  $('#humidity-circle').circleProgress(option);
}

function drawLightCircle(value = null, animation = true, label = null) {
  option = {
    lineCap: 'round',
    emptyFill: '#fafafa',
    fill: {color: '#f44336'},
    startAngle: 1.5 * Math.PI,
  }
  if (value !== null && animation !== null) {
    option.value = value;
    option.animation = animation;
  }
  if (label !== null && label !== '') {
    $('#light-circle .chart-value').text(label);
  }
  $('#light-circle').circleProgress(option);
}

function drawSoilMoistureCircle(value = null, animation = true, label = null) {
  option = {
    lineCap: 'round',
    emptyFill: '#fafafa',
    fill: {color: '#4caf50'},
    startAngle: 1.5 * Math.PI,
  }
  if (value !== null && animation !== null) {
    option.value = value;
    option.animation = animation;
  }
  if (label !== null && label !== '') {
    $('#soil_moisture-circle .chart-value').text(label);
  }
  $('#soil_moisture-circle').circleProgress(option);
}
