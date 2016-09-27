//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require owl.carousel

$(window).load(function() {
  $('#loader').delay(3000).fadeOut('slow');
  $('#loader-container').delay(2000).fadeOut('slow');
  $('body').delay(3000).css({'overflow':'visible'});
})

$('#owl-sticky').owlCarousel({
  loop:true,
  margin:30,
  nav:true,
  dots:false,
  responsive:{
    0:{
      items:1
    },
    600:{
      items:2
    },
    1000:{
      items:3
    }
  }
})
