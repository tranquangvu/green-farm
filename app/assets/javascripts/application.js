//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require owl.carousel
//= require libs/parallax
//= require moment
//= require bootstrap-datetimepicker
//= require bootstrap-select

$(window).on('load', function() {
  $('#loader').delay(500).fadeOut('slow');
  $('body').css({'overflow':'visible'});
});

$(window).ready(function(){
  $('#owl-sticky').owlCarousel({
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

  $('section.under-testimonials, section.contact').parallax({
    imageSrc: '/assets/parallax_01.jpg',
    speed: 0.5
  });
});

$(document).on('click', 'a[href^="#"]', function(e) {
  var id = $($(this).attr('href'));
  if (id.length === 0) return;
  e.preventDefault();
  $('body, html').animate({scrollTop: id.offset().top}, 800);
});
