# Place all the behaviors and hooks related to all controllers here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  mk_clickable();
  notifyDefaults();
  datepickerDefaults();
  $('[data-toggle="tooltip"]').tooltip()
  return
@mk_clickable = () ->
  $(".clickable").click ->
    window.location = $(this).data('location');
    return
  return
@notifyDefaults = () ->
  $.notifyDefaults
    allow_dismiss: true
    delay: 5000
    mouse_over: 'pause'
    type: 'success'
    animate:
      enter: 'animated slideInDown'
      exit: 'animated slideOutUp'
    template:
      '<div data-notify="container" class="col-xs-11 col-sm-3 alert-pastel alert-{0}" role="alert">' +
      '<div class="text-left"><span data-notify="icon"></span> <span data-notify="title"><strong>{1}</strong></span></div>' +
      '<div class="text-right small"><button type="button" aria-hidden="true" class="close fa fa-times" data-notify="dismiss"></button></div>' +
      '<div data-notify="message"><span data-notify="message">{2}</span></div>' +
      '</div>'
@datepickerDefaults = () ->
  $.fn.datepicker.defaults.format = "mm/dd/yyyy";
  $.fn.datepicker.defaults.endDate = '0d';
  $.fn.datepicker.defaults.autoclose = true;
  $.fn.datepicker.defaults.clearBtn = true;
  $.fn.datepicker.defaults.todayBtn = true;
  $.fn.datepicker.defaults.todayHighlight = true;


#for multi select boxes
# config =
#   '.deploy-select': { width: '100%' }
#   '.another-select': { width: '100%' }
# for selector of config
#   $(selector).chosen config[selector]
# or just use the same class on each
# $('.deploy-select').chosen { width: '100%' }
