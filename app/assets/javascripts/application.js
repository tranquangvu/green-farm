//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require owl.carousel
//= require parallax
//= require moment
//= require bootstrap-datetimepicker
//= require bootstrap-select

$(window).on('load', function() {
  $('#loader').delay(1400).fadeOut('slow');
  $('body').delay(300).css({'overflow':'visible'});
})

$(window).ready(function(){
  $('#owl-sticky').owlCarousel({
    // autoPlay: 3000,
    items: 3,
    itemsDesktop: [1199,3],
    itemsDesktopSmall: [979,3],
    itemsTablet: [768,2],
    itemsMobile: [479,1],
    navigation: true,
    pagination: false,
    responsive: true,
    responsiveRefreshRate: 200,
    responsiveBaseWidth: window,
    navigationText: ["<i class='fa fa-angle-left'></i>","<i class='fa fa-angle-right'></i>"]
  });

  // parallax background
  $('section.under-testimonials, section.contact').parallax({
    imageSrc: '/assets/parallax_01.jpg',
    speed: 0.5
  });

  $('#datetimepicker').datetimepicker({
    // debug: true,
    icons: {
      previous: 'fa fa-chevron-circle-left',
      next: 'fa fa-chevron-circle-right'
    },
    widgetPositioning: {
      horizontal: 'left',
      vertical: 'bottom'
    },
    showClose: true,
    showClear: true,
    showTodayButton: true
  });

  $('.selectpicker').selectpicker({
    style: 'btn-white'
  });

})
