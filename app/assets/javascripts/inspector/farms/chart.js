$("#inspecter-famrs-chart").ready(function() {
  var currentChartPer =  $('input:radio[name=chart_per]').val();

  $('input:radio[name=chart_per]').change(function() {
    currentChartPer = $(this).val();

    if ($(this).val() === 'day') {
      $('#chart-per-day').removeClass('hide');
      $('#chart-per-month').addClass('hide');
    }

    if ($(this).val() === 'month') {
      $('#chart-per-day').addClass('hide');
      $('#chart-per-month').removeClass('hide');
    }
  });

  $('#chart-filter-form').submit(function(e) {
    e.preventDefault();

    var temperatureCb = $('#props_temperature'),
        humidityCb = $('#props_humidity'),
        lightCb = $('#props_light'),
        soilMoistureCb = $('#props_soil_moisture');

    var temperatureChartArea = $('#temperature-chart-area'),
        humidityChartArea = $('#humidity-chart-area'),
        soilMoistureChartArea = $('#soil_moisture-chart-area'),
        lightChartArea = $('#light-chart-area');

    var date = new Date($('#date').val()),
        month = new Date($('#month').val()),
        farmId = $('#farm_id').val();

    var isPerDay = currentChartPer === 'day';

    // draw temperature chart
    if (temperatureCb.prop('checked')) {
      var url = isPerDay ? '/inspecter/values/temperature_of_date' :
        '/inspecter/values/temperature_of_month';

      $.ajax({
        type: 'GET',
        url: url,
        data: {
          farm_id: farmId,
          year: isPerDay ? date.getFullYear() : month.getFullYear(),
          month: isPerDay ? date.getMonth() + 1 : month.getMonth() + 1,
          day: isPerDay ? date.getDate() : null
        },
        success: function (data) {
          var timeData = data.map(function(dt) {
            var date = new Date(
              dt.year + '-' + dt.month + (dt.day ? '-' + dt.day : '') + ' ' +
              dt.hour + ':' + dt.minute + ':00'
            );
            return [date.getTime(), dt.temperature]
          });
          drawChart("#temperature-chart", [{label: 'Temperature', data: timeData}], {
            colors: ['#0aa89e'],
            textColor: '#313534'
          });
          temperatureChartArea.removeClass('hide');
        },
        error: function (err) {
          console.log(err);
        }
      });
    }
    else {
      temperatureChartArea.addClass('hide');
    }

    // draw humidity chart
    if (humidityCb.prop('checked')) {
      var url = isPerDay ? '/inspecter/values/humidity_of_date' :
        '/inspecter/values/humidity_of_month';

      $.ajax({
        type: 'GET',
        url: url,
        data: {
          farm_id: farmId,
          year: isPerDay ? date.getFullYear() : month.getFullYear(),
          month: isPerDay ? date.getMonth() + 1 : month.getMonth() + 1,
          day: isPerDay ? date.getDate() : null
        },
        success: function (data) {
          var timeData = data.map(function(dt) {
            var date = new Date(
              dt.year + '-' + dt.month + (dt.day ? '-' + dt.day : '') + ' ' +
              dt.hour + ':' + dt.minute + ':00'
            );
            return [date.getTime(), dt.humidity]
          });
          drawChart("#humidity-chart", [{label: 'Humidity', data: timeData}], {
            colors: ['#2196f3'],
            textColor: '#313534',
            gridMargin: -8
          });
          humidityChartArea.removeClass('hide');
        },
        error: function (err) {
          console.log(err);
        }
      });
    }
    else {
      humidityChartArea.addClass('hide');
    }

    // draw light chart
    if (lightCb.prop('checked')) {
      var url = isPerDay ? '/inspecter/values/light_of_date' :
        '/inspecter/values/light_of_month';

      $.ajax({
        type: 'GET',
        url: url,
        data: {
          farm_id: farmId,
          year: isPerDay ? date.getFullYear() : month.getFullYear(),
          month: isPerDay ? date.getMonth() + 1 : month.getMonth() + 1,
          day: isPerDay ? date.getDate() : null
        },
        success: function (data) {
          var timeData = data.map(function(dt) {
            var date = new Date(
              dt.year + '-' + dt.month + (dt.day ? '-' + dt.day : '') + ' ' +
              dt.hour + ':' + dt.minute + ':00'
            );
            return [date.getTime(), dt.light]
          });
          drawChart("#light-chart", [{label: 'Light', data: timeData}], {
            colors: ['#FFC107'],
            textColor: '#313534',
            gridMargin: -15
          });
          lightChartArea.removeClass('hide');
        },
        error: function (err) {
          console.log(err);
        }
      });
    }
    else {
      lightChartArea.addClass('hide');
    }

    if (soilMoistureCb.prop('checked')) {
      var url = isPerDay ? '/inspecter/values/soil_moisture_of_date' :
        '/inspecter/values/soil_moisture_of_month';

      $.ajax({
        type: 'GET',
        url: url,
        data: {
          farm_id: farmId,
          year: isPerDay ? date.getFullYear() : month.getFullYear(),
          month: isPerDay ? date.getMonth() + 1 : month.getMonth() + 1,
          day: isPerDay ? date.getDate() : null
        },
        success: function (data) {
          var timeData = data.map(function(dt) {
            var date = new Date(
              dt.year + '-' + dt.month + (dt.day ? '-' + dt.day : '') + ' ' +
              dt.hour + ':' + dt.minute + ':00'
            );
            return [date.getTime(), dt.soil_moisture]
          });
          drawChart("#soil_moisture-chart", [{label: 'Soil Moisture', data: timeData}], {
            colors: ['#9C27B0'],
            textColor: '#313534',
            gridMargin: -8
          });
          soilMoistureChartArea.removeClass('hide');
        },
        error: function (err) {
          console.log(err);
        }
      });
    }
    else {
      soilMoistureChartArea.addClass('hide');
    }
    return false;
  });
});
