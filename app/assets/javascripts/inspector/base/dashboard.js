$(document).ready(function() {
  if ($("#inspecter-dashboard-container").length > 0) {
    var currentDate = new Date(),
        farmId = $("#inspecter-dashboard-container").data('farm');

    // draw temperature chart
    $.ajax({
      type: 'GET',
      url: '/inspecter/values/temperature_of_date',
      data: {
        farm_id: farmId,
        year: currentDate.getFullYear(),
        month: currentDate.getMonth() + 1,
        day: currentDate.getDate()
      },
      success: function (data) {
        var timeData = data.map(function(dt) {
          var date = new Date(
            dt.year + '-' + dt.month + (dt.day ? '-' + dt.day : '') + ' ' +
            dt.hour + ':' + dt.minute + ':00'
          );
          return [date.getTime(), dt.temperature]
        });
        drawChart("#flot-temperature", [{label: 'Temperature', data: timeData}], {
          colors: ['#ff9800'],
          textColor: '#313534',
          lineWidth: 1,
          pointLineWidth: 1,
          pointRadius: 0,
          fill: false,
          yMin: 0,
          yMax: 50
        });
      },
      error: function (err) {
        console.log(err);
      }
    });

    // draw humidity chart
    $.ajax({
      type: 'GET',
      url: '/inspecter/values/humidity_of_date',
      data: {
        farm_id: farmId,
        year: currentDate.getFullYear(),
        month: currentDate.getMonth() + 1,
        day: currentDate.getDate()
      },
      success: function (data) {
        var timeData = data.map(function(dt) {
          var date = new Date(
            dt.year + '-' + dt.month + (dt.day ? '-' + dt.day : '') + ' ' +
            dt.hour + ':' + dt.minute + ':00'
          );
          return [date.getTime(), dt.humidity]
        });
        drawChart("#flot-humidity", [{label: 'Humidity', data: timeData}], {
          colors: ['#2196f3'],
          textColor: '#313534',
          gridMargin: -8,
          lineWidth: 1,
          pointLineWidth: 1,
          pointRadius: 0,
          fill: false,
          yMin: 0,
          yMax: 100
        });
      },
      error: function (err) {
        console.log(err);
      }
    });

    // draw light chart
    $.ajax({
      type: 'GET',
      url: '/inspecter/values/light_of_date',
      data: {
        farm_id: farmId,
        year: currentDate.getFullYear(),
        month: currentDate.getMonth() + 1,
        day: currentDate.getDate()
      },
      success: function (data) {
        var timeData = data.map(function(dt) {
          var date = new Date(
            dt.year + '-' + dt.month + (dt.day ? '-' + dt.day : '') + ' ' +
            dt.hour + ':' + dt.minute + ':00'
          );
          return [date.getTime(), dt.light]
        });
        drawChart("#flot-light", [{label: 'Humidity', data: timeData}], {
          colors: ['#f44336'],
          textColor: '#313534',
          gridMargin: -15,
          lineWidth: 1,
          pointLineWidth: 1,
          pointRadius: 0,
          fill: false,
          yMin: 0,
          yMax: 1000
        });
      },
      error: function (err) {
        console.log(err);
      }
    });

    // draw soil moisture
    $.ajax({
      type: 'GET',
      url: '/inspecter/values/soil_moisture_of_date',
      data: {
        farm_id: farmId,
        year: currentDate.getFullYear(),
        month: currentDate.getMonth() + 1,
        day: currentDate.getDate()
      },
      success: function (data) {
        var timeData = data.map(function(dt) {
          var date = new Date(
            dt.year + '-' + dt.month + (dt.day ? '-' + dt.day : '') + ' ' +
            dt.hour + ':' + dt.minute + ':00'
          );
          return [date.getTime(), dt.soil_moisture]
        });
        drawChart("#flot-soil-moisture", [{label: 'Soil Moisture', data: timeData}], {
          colors: ['#4caf50'],
          textColor: '#313534',
          gridMargin: -8,
          lineWidth: 1,
          pointLineWidth: 1,
          pointRadius: 0,
          fill: false,
          yMin: 0,
          yMax: 100
        });
      },
      error: function (err) {
        console.log(err);
      }
    });
  }
});
