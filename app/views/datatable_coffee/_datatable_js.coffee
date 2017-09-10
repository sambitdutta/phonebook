$(document).ready ->
  $('#<%= datatable %>').DataTable
    responsive: true
    <% if data.count <= 10 %>
    searching: false
    paging: false
    info: false
    <% end %>
    dom: 'frtBip'
    buttons: [
      'copy'
      'csv'
      'excel'
      'pdf'
      'print'
    ]
  return
