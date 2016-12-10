$(document).ready(function() {
  if ($("#inspecter-farms-show-container").length > 0) {
    var updateTimes = 0;
    var deviceId = $('#current-value').data('id');
    var deviceIp = $('#current-value').data('ip');
    var socket = io('http://0.0.0.0:5001');

    socket.on('connect', function() {
      console.log('Client connected');

      socket.emit('client_response_connect', {
        client: true,
        device_id: deviceId,
        device_ip: deviceIp
      });
    });

    socket.on('client_update_view', function(data) {
      updateTimes++;
      animation = updateTimes == 1;

      debugger

      if (data.temperature !== null && data.temperature !== undefined) {
        drawTemperatureCircle(1.0, animation, data.temperature + "℃");
      }

      if (data.humidity !== null && data.humidity !== undefined) {
        drawHumidityCircle(data.humidity/100.0, animation, data.humidity + "%");
      }

      if (data.light !== null && data.light !== undefined) {
        drawLightCircle(1.0, animation, data.light + "lux");
      }

      if (data.soilMoisture !== null && data.soilMoisture !== undefined) {
        drawSoilMoistureCircle(data.soilMoisture/100.0, animation, data.soilMoisture + "%");
      }

      if (data.led !== null && data.led !== undefined) {
        $("#switch_led").attr("checked", data.led);
      }

      if (data.servo !== null && data.servo !== undefined) {
        $("#switch_servo").attr("checked", data.servo);
      }
    });

    socket.on('disconnect', function(){
      console.log('Client disconnected');
    });

    // toogle switch led handler
    $('#switch_led').change(function(e) {
      var status = $(this).prop('checked');

      socket.emit('client_change_led', {
        status: status,
        device_id: deviceId,
        device_ip: deviceIp
      });
    });

    // toogle switch servo handler
    $('#switch_servo').change(function(event) {
      var status = $(this).prop('checked');

      socket.emit('client_change_servo', {
        status: status,
        device_id: deviceId,
        device_ip: deviceIp
      });
    });

    // update value after 10 minutes
    setInterval(function() {
      socket.emit('client_request_current_value', {
        device_id: deviceId,
        device_ip: deviceIp
      });
    }, 600000);
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
