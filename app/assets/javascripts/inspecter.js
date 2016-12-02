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
//= require inspector/farms/chart

$(function(){
  window.setTimeout(function() { $(".notice").alert('close'); }, 8000);

  $('.datepicker').datepicker({
    format: 'yyyy-mm-dd',
    todayBtn: true,
    autoclose: true,
    todayHighlight: true
  });

  $(".monthpicker").datepicker({
    format: "yyyy-mm",
    startView: "months",
    minViewMode: "months",
    todayBtn: true,
    autoclose: true,
    todayHighlight: true
  });

  $('.datatable').DataTable({
    "dom": 'lCfrtip',
    "order": [],
    "pageLength": 100,
    "lengthMenu": [[100, 250, 500], [100, 250, 500]],
    "language": {
      "lengthMenu": '_MENU_ entries per page',
      "paginate": {
        "previous": '<i class="fa fa-angle-left"></i>',
        "next": '<i class="fa fa-angle-right"></i>'
      }
    }
  });
});

function generalChartOptions(options) {
  return {
    colors: options.colors || '#0aa89e',
    series: {
      shadowSize: 0,
      lines: {
        show: true,
        lineWidth: 2,
        fill: true
      },
      points: {
        show: true,
        radius: 3,
        lineWidth: 2
      }
    },
    legend: {
      show: false
    },
    xaxis: {
      mode: 'time',
      timezone: 'browser',
      timeformat: '%H:%M',
      color: 'rgba(0, 0, 0, 0)',
      font: {color: options.textColor || '#000'}
    },
    yaxis: {
      font: {color: options.textColor || '#000'}
    },
    grid: {
      borderWidth: 0,
      color: options.textColor || '#000',
      hoverable: true,
      margin: options.gridMargin
    }
  };
}

function generalChartTooltip (event, pos, item, tooltip) {
  if (item) {
    if (tooltip.previousPoint !== item.dataIndex) {
      tooltip.previousPoint = item.dataIndex;

      var x = item.datapoint[0];
      var xToDate = new Date(x);
      var y = item.datapoint[1];
      var tipLabel = '<strong>' + tooltip.title + '</strong>';
      var tipContent = y + tooltip.unit + " on " + xToDate.getHours() + 'h' + xToDate.getMinutes() + '\'';

      if (tooltip.tip !== undefined) {
        $(tooltip.tip).popover('hide');
      }
      tooltip.tip = $('<div></div>').appendTo('body').css({left: item.pageX, top: item.pageY + $('body').scrollTop() - 5, position: 'absolute'});
      tooltip.tip.popover({html: true, title: tipLabel, content: tipContent, placement: 'top'}).popover('show');
    }
  }
  else {
    if (tooltip.tip !== undefined) {
      $(tooltip.tip).popover('hide');
    }
    tooltip.previousPoint = null;
  }
}

function drawChart(targetId, data, option) {
  var chart = $(targetId);
      chart.css({"width": "100%"});
  var plot = $.plot(chart, data, generalChartOptions({
        colors: option.colors,
        textColor: option.textColor,
        gridMargin: option.gridMargin
      }));
  var tooltip = {
    tip: null,
    previousPoint: null,
    title: chart.data('title'),
    unit: chart.data('unit')
  };
  chart.bind("plothover", function (event, pos, item) {
    return generalChartTooltip(event, pos, item, tooltip);
  });
}

function initCameraStream(target, host, username, password) {
  setTimeout(function() {
    var date = new Date();
    target.src = host + '/cgi-bin/CGIProxy.fcgi?cmd=snapPicture2&usr=' +
      username + '&pwd=' + password + '&t=' + Math.floor(date.getTime()/1000);
  }, 1000);
}
