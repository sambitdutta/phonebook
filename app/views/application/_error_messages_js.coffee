notifyDefaults();
$(document).ready ->
    $.notify({
      # options
      message: '<%= pluralize(errors.count, "error") %> prevented the form from being saved'
      title: '<%= 'form error'.to_s.upcase %>:'
      icon: 'fa fa-fire'
    },{
      # settings
      type: 'danger'
      delay: 8000
    })
    <% errors.full_messages.each do |msg| %>
      <% if msg.is_a?(String) %>
    $.notify({
      # options
      message: '<%= msg %>'
      title: '<%= 'input error'.to_s.upcase %>:'
      icon: 'fa fa-info-circle'
    },{
      # settings
      type: 'warning'
      delay: 0
    })
      <% end %>
    <% end %>
