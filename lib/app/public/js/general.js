// JavaScript Document

jQuery(document).ready(function(){
  // CUFON
  Cufon.replace('#navigation li a, h1, h2, h3, h4, h5, h6, .home-text, div.links-home a, #footer-custom p, .fancy-link a, a.download-menu, .post-entries a ', {  hover: true });
  Cufon.replace('.widget-footlink, .menu-food .info, .drinks .info, #footer p, .twocol-one p, .menu-desc p');

  // LOOPED SLIDER 
  jQuery(document).ready(function($){
    jQuery("#loopedSlider").loopedSlider({
      autoStart: 7000, 
      slidespeed: 1000, 
      autoHeight: true
    });
  });

  //FAKE ROTATED BACKGROUNDS
  jQuery(' #more-info .image, #content.location .map').each(function(){
    jQuery(this).append('<div class="fakebg"></div>');
    jQuery(this).append('<div class="fakebg second"></div>');
  });

  //ALT STYLING FOR LIST WIDGETS
  jQuery('.widget_woo_specials li:odd, .widget_woo_staff li:odd').addClass('alt');

  //CLEAR FORM FIELD ON FOCUS
  var name = jQuery('#content.location .text input.txt').val();

  if (name == '') { jQuery('#content.location .text input.txt').val('Name') };

  jQuery('#content.location .text input.txt').focus(function() {
    var val = jQuery(this).val();
    if(val == 'Enter your address'){	jQuery(this).val(''); }
  });

  jQuery('#content.location .text input.txt').blur(function() {
    var val = jQuery(this).val();
    if(val == ''){	jQuery(this).val('Enter your address'); }
  });

  //RESERVATION CONFIRMATION MODAL BUTTONS
  jQuery('.ui-dialog-buttonpane button:contains(Cancel)').addClass('inactive');

  //STAFF WIDGET AVATAR
  jQuery('.widget_woo_staff img.avatar').each(function(){
    jQuery(this).addClass('thumb');
  });

  //BUSINESS HOURS WIDGET
  jQuery('.widget-wootable-businesshours li:last').css('border-bottom','none');
});
