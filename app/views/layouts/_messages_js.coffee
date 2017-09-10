notifyDefaults();
$(document).ready ->
  <% flash.each do |name, msg| %>
  <% if msg.is_a?(String) %>
  $.notify({
    # options
    message: '<%= msg %>'
    title: '<%= name.to_s.upcase %>:'
    icon: 'fa <%= name.to_s == 'notice' ? 'fa-check-circle' : 'fa-fire' %>'
  },{
    # settings
    type: '<%= name.to_s == 'notice' ? 'success' : 'danger' %>'
  });
  <% end %>
  <% end %>
