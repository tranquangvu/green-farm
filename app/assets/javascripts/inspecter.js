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
//= require core/source/AppOffcanvas
//= require core/source/AppCard
//= require core/source/AppNavSearch
//= require core/source/AppVendor
//= require core/demo/demo
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require bootstrap-datepicker/js/bootstrap-datepicker
//= require twitter-bootstrap-wizard/jquery.bootstrap.wizard.min
//= require libs/circle-progress
//= require fancyBox/lib/jquery.mousewheel-3.0.6.pack.js
//= require fancyBox/source/jquery.fancybox.pack
//= require fancyBox/source/helpers/jquery.fancybox-buttons
//= require fancyBox/source/helpers/jquery.fancybox-media
//= require fancyBox/source/helpers/jquery.fancybox-thumbs
//= require inspector/farms/chart
//= require inspector/farms/show
//= require inspector/base/dashboard
//= require inspector/cameras/show

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
    "pageLength": 50,
    "lengthMenu": [[50, 100, 250, 500], [50, 100, 250, 500]],
    "language": {
      "lengthMenu": '_MENU_ entries per page',
      "paginate": {
        "previous": '<i class="fa fa-angle-left"></i>',
        "next": '<i class="fa fa-angle-right"></i>'
      }
    }
  });
});

$(document).ready(function() {
  $("a.fancybox").fancybox();
});

function generalChartOptions(options) {
  return {
    colors: options.colors || '#0aa89e',
    series: {
      shadowSize: 0,
      lines: {
        show: true,
        lineWidth: options.lineWidth != null ? options.lineWidth : 2,
        fill: options.fill === false ? false : true
      },
      points: {
        show: true,
        radius: options.pointRadius === 0 ? 0 : 3,
        lineWidth: options.pointLineWidth === 0 ? 0 : 2
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

function drawChart(targetId, data, options) {
  var chart = $(targetId);
      chart.css({"width": "100%"});
  var plot = $.plot(chart, data, generalChartOptions({
        colors: options.colors,
        textColor: options.textColor,
        gridMargin: options.gridMargin,
        lineWidth: options.lineWidth,
        pointLineWidth: options.pointLineWidth,
        pointRadius: options.pointRadius,
        fill: options.fill
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
